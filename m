Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72126ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F38F208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBxbTGu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F38F208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIOQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 12:56:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53357 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 12:56:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so4584563wme.3;
        Sat, 15 Sep 2018 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6PHgxloUaPnNE9aKYzPMS9kzren52vC0YmGoQXbTQo=;
        b=XBxbTGu3Z1oKWajPRqMW/Gj6ZOIqS/u9eaebZ/TvoLMlZbzLhGvIfLNGKaxBVuUNq4
         BYRvwKWDm+nb5r8pAfrM1SzXOh+ZVJ+3R1qHN4dHaresdGV35sfJzNriJXdFXvNtASsU
         9VmQOPnBTRSRgc4WHZ+MyjU1o80Gi34iNDkuT8SageDI25zApjdpaC05vg2FAIjKMAEy
         PBLVYukRjnFdK7IzchR5cZJ/X6Omo9s0YIvWkZbE5KWKTWkfCb4kAtJ1lTuqK5FhEojS
         xJYNSZNqbcSIF4rLcbm1VYD8rBvTxv+DIZBUFLmdaIxyk5LMxzYaKrka+6qVwY/p3xwi
         1V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6PHgxloUaPnNE9aKYzPMS9kzren52vC0YmGoQXbTQo=;
        b=N+uZVbf+WpIsSRoSkWauXU6/ZhsSeC7Rwob0U8gFSAPieVpD3MvvMUeYrL2dFtcHMb
         a6YW8aQA4ao0dp6yl8kMS0iwTbs2wvytLb6L6ruq75kqh/Xr9lpLV2OXvE+26PgsAhkv
         YAW2YywW/dZshb2r5pxtOdousZvOkIHXnKBX7r3xc0CLEvX/fCwVnsHKZkigk03T+Bwr
         GiITe11zIq2pFYojGpjZzTSPUQNPUH7cxkHnJVtfbOBjxvTHv+P09auLSwnRFmL598aO
         YU6e4vNqZDvejDqkCKwO2Zibtjnhc7CkWrZVkx6T3gqcXOirKsaG1W90uOSFRdEC482Q
         n7hw==
X-Gm-Message-State: APzg51D4tACNM98+l5RTLGZVeIuZfRFIMgiozW6RvEhoKECPwdmQJqFt
        +W1PVIoiRxhQTitGUduBt9w=
X-Google-Smtp-Source: ANB0VdZoLLFP4V27zS57bZ7Q9bRzvpVQGJYcrMz7ZEUtOzUEmt22WBMwIlfLEAQy8hUw1MCshs/5cg==
X-Received: by 2002:a1c:ee97:: with SMTP id j23-v6mr5542834wmi.66.1537011457374;
        Sat, 15 Sep 2018 04:37:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m68-v6sm3152024wmb.10.2018.09.15.04.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 04:37:36 -0700 (PDT)
Date:   Sat, 15 Sep 2018 13:37:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Joseph =?iso-8859-1?Q?Myers=A0?= <joseph@codesourcery.com>,
        David Howells <dhowells@redhat.com>, libc-alpha@sourceware.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
Message-ID: <20180915113733.GA35411@gmail.com>
References: <20180914113929.953895-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914113929.953895-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> diff --git a/arch/x86/include/uapi/asm/elf.h b/arch/x86/include/uapi/asm/elf.h
> new file mode 100644
> index 000000000000..a640e1224939
> --- /dev/null
> +++ b/arch/x86/include/uapi/asm/elf.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_X86_ELF_H
> +#define _UAPI_ASM_X86_ELF_H
> +
> +#ifdef __i386__
> +
> +/*
> + * These are used to set parameters in the core dumps.
> + */
> +#define ELF_CLASS	ELFCLASS32
> +#define ELF_DATA	ELFDATA2LSB
> +#define ELF_ARCH	EM_386
> +#define ELF_NGREG	17
> +
> +#else
> +
> +/*
> + * These are used to set parameters in the core dumps.
> + */
> +#define ELF_CLASS	ELFCLASS64
> +#define ELF_DATA	ELFDATA2LSB
> +#define ELF_ARCH	EM_X86_64
> +#define ELF_NGREG	27
> +
> +#endif /* __i386__ */
> +
> +typedef unsigned long elf_greg_t;
> +typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> +
> +#endif

On a second thought, maybe deduplicate the comments? Something like:

/*
 * These are used to set parameters in core dumps:
 */
#ifdef __i386__
# define ELF_CLASS	ELFCLASS32
# define ELF_DATA	ELFDATA2LSB
# define ELF_ARCH	EM_386
# define ELF_NGREG	17
#else
# define ELF_CLASS	ELFCLASS64
# define ELF_DATA	ELFDATA2LSB
# define ELF_ARCH	EM_X86_64
# define ELF_NGREG	27
#endif

Note:

 - I fixed a typo in the comment.
 - Aligned the blocks vertically for better visibility.
 - The closing #endif comment became unnecessary as well, due to the much more obvious 
   structure when written this way.

The type changes/cleanups look good otherwise: it's quite probable that it was never directly 
included in any user-space library in any sane fashion before, so it's not really an UAPI that 
was relied on, as long as it doesn't break the build anywhere.

Thanks,

	Ingo
