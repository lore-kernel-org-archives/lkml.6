Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799282089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1WxQ8FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799282089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJBQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:30:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53683 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeJBQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:30:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so1554327wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UfDL0z6hMzJMvlEvQwOltLo2stQYezeQ4aL87ZPJdng=;
        b=Y1WxQ8FAX91osi/eVKJ8m3RNW+w8Fhbxtp8U5Drk3mrQQNC6nOBcnVyTBVzxhiK/Uw
         h0hhG8I8rdxLFTXDEKoNCGylCRCND5zTkZjcWEbizbzczC7qmWhONYjp5mnS0CrPm98d
         DvK8zdw6jtCL8/kW6sel9WXjCo6Jx+RKlASPC+IzYz6SOrgsSmCp8mYyytrV8frVp6ZA
         tBQ1K3HIvf8SzSRX0YOKoyYigN65G5tERZ20ixzdLcNxnfMpeV/155I8QypjPUVN3KdJ
         hG543rFY5CceWYfR19B/Bb56R3UhgteiPp9JtZrV9ftfGyVB1SmEJucg5Yb3SqkT4X8N
         zPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UfDL0z6hMzJMvlEvQwOltLo2stQYezeQ4aL87ZPJdng=;
        b=tiK5kqw10Z+hRy79ATRf4ojIyaGHeoo6mmC0ZsQFiYIys+/gxtXNL+OZDBsJqEENQ0
         ipcuSVnsDBXwNMxbZ2N6BVXm/G5W1ijJYzscKWBGXwi5r0Z7woSPQlKYtd7TsEIZSQAs
         49sswljfPSiYALGU8wbDyXPwpdbPArMfj7sz9+YRhEoCL4/is4VaH68J4iVraLAFmkAA
         edOC2puXxHb//roR1UftfoAtYJQEodu2froQ7cNzXzycvF9MnvRQsMtA4Ffk4dcA0jK3
         itYLSYBnvCvfRw9D7hLUbnBlB9KeDGTnpk+3Fdfh8x8VV5Q5f+yKmU2WzbtXAC2VL2/p
         1C7Q==
X-Gm-Message-State: ABuFfohrXQojzWhHP1v0Go0LoAdgfAoTo3TbslB35B0PgSomNe0rgPrA
        7h1zm8TK6/3aRhPCgZbZmUA=
X-Google-Smtp-Source: ACcGV61J+P4TKlBd7C1b+gYgDPmf7NuVIFeFoefE5JlVqhYCjYRFfMsMNPa632E7+dPyeKcx4AAmpQ==
X-Received: by 2002:a1c:8a94:: with SMTP id m142-v6mr1282177wmd.80.1538473710837;
        Tue, 02 Oct 2018 02:48:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 199-v6sm13235860wme.39.2018.10.02.02.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:48:30 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:48:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 21/22] x86: jump_label: introduce
 ASM_STATIC_KEY_INIT_{TRUE,FALSE}
Message-ID: <20181002094828.GB98058@gmail.com>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-22-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919220444.23190-22-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> These will be useful when defining the contents of (a struct containing)
> a static key in inline assembly.
> 
> Cc: x86@kernel.org
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  arch/x86/include/asm/jump_label.h | 18 ++++++++++++++++++
>  include/linux/jump_label.h        |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 8c0de4282659..2736f7ff6806 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -110,4 +110,22 @@ struct jump_entry {
>  
>  #endif	/* __ASSEMBLY__ */
>  
> +#ifdef CONFIG_X86_64
> +#define ASM_STATIC_KEY_INIT_TRUE					\
> +	 "\t.long 1                              \t# .enabled\n"	\
> +	 "\t.long 0                              \t# <padding>\n"	\
> +	 "\t.quad "__stringify(__JUMP_TYPE_TRUE)"\t# .type\n"
> +#define ASM_STATIC_KEY_INIT_FALSE					\
> +	 "\t.long 0                               \t# .enabled\n"	\
> +	 "\t.long 0                               \t# <padding>\n"	\
> +	 "\t.quad "__stringify(__JUMP_TYPE_FALSE)"\t# .type\n"
> +#else
> +#define ASM_STATIC_KEY_INIT_TRUE					\
> +	 "\t.long 1                              \t# .enabled\n"	\
> +	 "\t.long "__stringify(__JUMP_TYPE_TRUE)"\t# .type\n"
> +#define ASM_STATIC_KEY_INIT_FALSE					\
> +	 "\t.long 0                               \t# .enabled\n"	\
> +	 "\t.long "__stringify(__JUMP_TYPE_FALSE)"\t# .type\n"
> +#endif
> +
>  #endif
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 1a0b6f17a5d6..6e98193ae708 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -132,6 +132,8 @@ struct module;
>  
>  #ifdef HAVE_JUMP_LABEL
>  
> +#define __JUMP_TYPE_FALSE	0
> +#define __JUMP_TYPE_TRUE	1
>  #define JUMP_TYPE_FALSE		0UL
>  #define JUMP_TYPE_TRUE		1UL
>  #define JUMP_TYPE_LINKED	2UL

Looks sane!

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
