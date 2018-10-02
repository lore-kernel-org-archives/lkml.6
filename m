Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33719C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB5F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJiUpWmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB5F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJBQdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:33:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45828 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJBQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:33:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so1407754wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UkSwy37u+Hp3DijtnBm7zhwBjY+rVWrEQvnZ6HCXpLg=;
        b=vJiUpWmvFrdOD6k+sumVfwAjj276nJV9dwEubuEeoftd7SITnCO7RK9G+rCViwugXK
         dzvTABja2NUni4TVoSvLPgS5tOkLjkyP1LsqGRKGoXR+xBaIwGOHv1sgFo7NNaYp+/JI
         W80mNbroTSoYfY2DZxT13k7fhDAOhTzTTWi4L4vq5eAr8yLE/+4NcLE9O/VE1I/8JeEr
         2/UdtCIF1gGby5fX8j/uoRAxMdFCxhvnFkQIRGv/iNPEuPGfblvkJ0xHg3+sdMq1jlnW
         T+B5domHJTrLHZf69Q1dsH88JRYTS3i00/sF5dsu4QDLlErg7O2iRG6spF6SYzBESOnQ
         2qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkSwy37u+Hp3DijtnBm7zhwBjY+rVWrEQvnZ6HCXpLg=;
        b=URKGPMQwnWEDUotZOABq0wPAxa+7Lj2I0OjF9+g2Q4h/v7IdEx0U+LpMz7iLu2QLor
         2x1aMhwnIRKZS2WusSKb56t/co91/vuVdjvpZyWdSvhBp7okfHBfn+GSH2DSKQhSB3Cw
         NZcjZHmGSCJNaO4UGhF2a533YWv/nh1oSD02mRQISCpd91beRt8A8TIueYQsanBTPO+i
         /hBcsM25lGKBLpEjid6dVQjMRZHUKTuhw+muMhvReolVSyoLRbiw8Ebwt9E6hfs3oMty
         j8TQtzP/lA6q0F3Hkel+1RwGj+qObqjCB2GDoe2OyPimK2vuJogiGuUlQgGq+ebSpnD9
         cLBA==
X-Gm-Message-State: ABuFfojhPl7V3Vhns4l5PYIBwP81tMoRnwIeJRguRSNv8j8p4+5PgZ05
        vHfzZnnsxtlA47rkZA7wBjlRVclb
X-Google-Smtp-Source: ACcGV60zSPCsjdz7YAleNso9nEYLwLpfVtCY+yEMLZZ/omwAHjUNsqBVYgu/Qk95jcy9B8goij+XtQ==
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr10103856wra.95.1538473858551;
        Tue, 02 Oct 2018 02:50:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a205-v6sm6681206wmh.19.2018.10.02.02.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:50:58 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:50:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 22/22] x86_64: use relative pointers with dynamic debug
Message-ID: <20181002095055.GC98058@gmail.com>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-23-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919220444.23190-23-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Similar to how x86_64 uses bug_entry-relative pointers to reduce
> sizeof(struct bug_entry), the same thing can now be done for struct
> _ddebug, saving 16 bytes for each of those (i.e., each pr_debug, dev_dbg
> etc. in a CONFIG_DYNAMIC_DEBUG kernel).
> 
> Note the use of .ifndef/.endif in asm to avoid
> 
> fs/aio.c:1382: Error: symbol `__UNIQUE_ID_ddebug112' is already defined
> 
> This is due to uses of pr_debug et al in functions that get inlined. In
> such a case, __COUNTER__ is obviously only expanded once, but the asm()
> is repeated once for every inlined instance. Letting all instances share
> the same descriptor object is the right thing to do; that is also what
> happens when it is the compiler that defines a static object inside an
> inline(d) function.
> 
> Cc: x86@kernel.org
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  arch/x86/Kconfig                     |  1 +
>  arch/x86/include/asm/dynamic_debug.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 arch/x86/include/asm/dynamic_debug.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..a44168930e52 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -90,6 +90,7 @@ config X86
>  	select CLOCKSOURCE_WATCHDOG
>  	select DCACHE_WORD_ACCESS
>  	select DMA_DIRECT_OPS
> +	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if X86_64
>  	select EDAC_ATOMIC_SCRUB
>  	select EDAC_SUPPORT
>  	select GENERIC_CLOCKEVENTS
> diff --git a/arch/x86/include/asm/dynamic_debug.h b/arch/x86/include/asm/dynamic_debug.h
> new file mode 100644
> index 000000000000..350ef6e2feff
> --- /dev/null
> +++ b/arch/x86/include/asm/dynamic_debug.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_DYNAMIC_DEBUG_H
> +#define _ASM_X86_DYNAMIC_DEBUG_H
> +
> +#ifdef HAVE_JUMP_LABEL
> +# ifdef DEBUG
> +#  define _DPRINTK_ASM_KEY_INIT ASM_STATIC_KEY_INIT_TRUE
> +# else
> +#  define _DPRINTK_ASM_KEY_INIT ASM_STATIC_KEY_INIT_FALSE
> +# endif
> +#else
> +# define _DPRINTK_ASM_KEY_INIT ""
> +#endif
> +
> +#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)			\
> +	extern struct _ddebug name;					\
> +	asm volatile(".ifndef " __stringify(name) "\n"			\
> +		     ".pushsection __verbose,\"aw\"\n"			\
> +		     "1:\n"						\
> +		     __stringify(name) ":\n"				\
> +		     "\t.long %c0 - 1b \t# _ddebug::modname_disp\n"	\
> +		     "\t.long %c1 - 1b \t# _ddebug::function_disp\n"	\
> +		     "\t.long %c2 - 1b \t# _ddebug::filename_disp\n"	\
> +		     "\t.long %c3 - 1b \t# _ddebug::format_disp\n"	\
> +		     "\t.long %c4      \t# _ddebug::flags_lineno\n"	\
> +		     "\t.long 0        \t# <padding>\n"			\
> +		     _DPRINTK_ASM_KEY_INIT				\
> +		     ".popsection\n"					\
> +		     ".endif\n"						\
> +		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
> +		       "i" (__FILE__), "i" (fmt),			\
> +		       "i" (_DPRINTK_FLAGS_LINENO_INIT))
> +
> +#endif /* _ASM_X86_DYNAMIC_DEBUG_H */
> +

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
