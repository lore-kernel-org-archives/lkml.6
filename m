Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979D620855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="pWsD0VdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfBUA0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:26:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBUA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:26:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so1287748pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uhRUCA0MmYEEwglDwigd2zJXyv/Fpq3uG3+FonERY40=;
        b=pWsD0VdGkbty8zY6p44MbOC7jp5aCpH/G86GSF9oBw+E+xo0Ffq6oOaXsqurUMBz0O
         pMWuRLOs0czPRnN5PMKSLCdrn91OLrA/BztLScm7ZZMK/t9g2L6TN2D+5tROALrfSnRb
         CRANjVgqLBRb/KJo1jXq8Ggib4Ztzc9tVvU6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uhRUCA0MmYEEwglDwigd2zJXyv/Fpq3uG3+FonERY40=;
        b=NK4Ctu7rAlZWcTC6hf3VkwZcM4rJ6VQrVgumgF/fD+b9mymfxz5OiTZ93SxPIydAWD
         oe3K7m9MVK0kEZH40kxK87GQfmtqZn/CA9l403EwTeqpdIG3UOPRQTzCDO7SPIrNi9MA
         DvjhMAhnItdERtRKSvQe23JLyyqGCjTJ9YbgAwfL5WuvEtIS696vrP5QKUv9aKaFVTrw
         5KlcMl0rpqzINQXXhscilFqxtANRiwmYhuw9HlgjdomRue+XYSgxnXf6H9bh+nnpnmjH
         4FYS1WMYlTB/xFw3Ab3W48IhlsIiPk8Cq3YsIYKN4IaE+okmP2IGerYc5kQ0XpfAthzw
         nU6g==
X-Gm-Message-State: AHQUAuYZbhBrRmvhMKZGCvoKyJ4CaYpbXIVOrT7N4UOU1sQzI1274yBs
        u6nfbUdFTk8pR7JfBoyLD1Muew==
X-Google-Smtp-Source: AHgI3IaS04/eb+mR9xR5310/LeqPinEgijpKKKM1Q7k6rR1Xe8bzPpuO6Hxro02jIjnYI0wJz9C0uw==
X-Received: by 2002:a63:7341:: with SMTP id d1mr17881039pgn.405.1550708812209;
        Wed, 20 Feb 2019 16:26:52 -0800 (PST)
Received: from localhost ([2001:44b8:802:1120:3c28:35e8:eceb:6523])
        by smtp.gmail.com with ESMTPSA id h63sm13590990pfd.148.2019.02.20.16.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 16:26:50 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Mathieu Malaterre <malat@debian.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/prom_init: add __init markers to all functions
In-Reply-To: <1550641996-21937-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550641996-21937-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Thu, 21 Feb 2019 11:26:47 +1100
Message-ID: <87d0nm9ebc.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

> It is fragile to rely on the compiler's optimization to avoid the
> section mismatch. Some functions may not be necessarily inlined
> when the compiler's inlining heuristic changes.
>
> Add __init markers consistently.
>

Are you doing this with some sort of static analysis, or manually?

Regards,
Daniel

> As for prom_getprop() and prom_getproplen(), they are marked as
> 'inline', so inlining is guaranteed because PowerPC never enables
> CONFIG_OPTIMIZE_INLINING. However, it would be better to leave the
> inlining decision to the compiler. I replaced 'inline' with __init.
> I added __maybe_unused to prom_getproplen() because it is currently
> relying on the side-effect of 'inline'; GCC does not report
> -Wunused-function warnings for functions with 'inline' marker.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Add __maybe_unsed to prom_getproplen()
>   - Add __init to enter_prom() as well
>
>  arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index f33ff41..1bad0ac 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -138,9 +138,9 @@ extern void __start(unsigned long r3, unsigned long r4, unsigned long r5,
>  		    unsigned long r9);
>  
>  #ifdef CONFIG_PPC64
> -extern int enter_prom(struct prom_args *args, unsigned long entry);
> +extern int __init enter_prom(struct prom_args *args, unsigned long entry);
>  #else
> -static inline int enter_prom(struct prom_args *args, unsigned long entry)
> +static int __init enter_prom(struct prom_args *args, unsigned long entry)
>  {
>  	return ((int (*)(struct prom_args *))entry)(args);
>  }
> @@ -501,19 +501,20 @@ static int __init prom_next_node(phandle *nodep)
>  	}
>  }
>  
> -static inline int prom_getprop(phandle node, const char *pname,
> +static int __init prom_getprop(phandle node, const char *pname,
>  			       void *value, size_t valuelen)
>  {
>  	return call_prom("getprop", 4, 1, node, ADDR(pname),
>  			 (u32)(unsigned long) value, (u32) valuelen);
>  }
>  
> -static inline int prom_getproplen(phandle node, const char *pname)
> +static int __init __maybe_unused prom_getproplen(phandle node,
> +						 const char *pname)
>  {
>  	return call_prom("getproplen", 2, 1, node, ADDR(pname));
>  }
>  
> -static void add_string(char **str, const char *q)
> +static void __init add_string(char **str, const char *q)
>  {
>  	char *p = *str;
>  
> @@ -523,7 +524,7 @@ static void add_string(char **str, const char *q)
>  	*str = p;
>  }
>  
> -static char *tohex(unsigned int x)
> +static char __init *tohex(unsigned int x)
>  {
>  	static const char digits[] __initconst = "0123456789abcdef";
>  	static char result[9] __prombss;
> @@ -570,7 +571,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
>  #define islower(c)	('a' <= (c) && (c) <= 'z')
>  #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
>  
> -static unsigned long prom_strtoul(const char *cp, const char **endp)
> +static unsigned long __init prom_strtoul(const char *cp, const char **endp)
>  {
>  	unsigned long result = 0, base = 10, value;
>  
> @@ -595,7 +596,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
>  	return result;
>  }
>  
> -static unsigned long prom_memparse(const char *ptr, const char **retptr)
> +static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
>  {
>  	unsigned long ret = prom_strtoul(ptr, retptr);
>  	int shift = 0;
> @@ -2924,7 +2925,7 @@ static void __init fixup_device_tree_pasemi(void)
>  	prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
>  }
>  #else	/* !CONFIG_PPC_PASEMI_NEMO */
> -static inline void fixup_device_tree_pasemi(void) { }
> +static void __init fixup_device_tree_pasemi(void) { }
>  #endif
>  
>  static void __init fixup_device_tree(void)
> @@ -2986,15 +2987,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
>  
>  #ifdef CONFIG_PPC64
>  #ifdef CONFIG_RELOCATABLE
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>  {
>  }
>  
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>  {
>  }
>  #else
> -static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
> +static void __init __reloc_toc(unsigned long offset, unsigned long nr_entries)
>  {
>  	unsigned long i;
>  	unsigned long *toc_entry;
> @@ -3008,7 +3009,7 @@ static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
>  	}
>  }
>  
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>  {
>  	unsigned long offset = reloc_offset();
>  	unsigned long nr_entries =
> @@ -3019,7 +3020,7 @@ static void reloc_toc(void)
>  	mb();
>  }
>  
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>  {
>  	unsigned long offset = reloc_offset();
>  	unsigned long nr_entries =
> -- 
> 2.7.4
