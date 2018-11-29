Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A288C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzjLMIpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A288C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeK3D0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:26:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44549 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeK3D0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:26:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so2554597qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpMC4sdaHUXKu11lx7Yyzjk7QiRPbuUmO+Ua7FGL9/M=;
        b=rzjLMIpUkO0z/xe1JAixVWzfVSYG+XjbVuqOjI/mHf6h+1xSv0fdsk10jVUjcshHLr
         zFahISB6Zq2JCaSRekUNtAaKvFdAVcV6uBCXMIQq4z4Cb9Od1HDELY821aE543+oxrEC
         U8opd588hiY+vTEcxz8ERxx6mxh7oBDLz4kztWO9yETDgzE0GiFLt2hunCG+dyj+iCXE
         4oj+tIqsa3eduAy6mQmXZ13zwQrxhZycCDT9B6oxc1jxQU7e4OyGK+PwdJeCjwsETDyo
         lbxGenAarBahz0UoOIQxxCps58Ra9CDF47ts3+/8U7P1IU6wjCHsHB0Rp5kCv7JCOnYb
         CMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpMC4sdaHUXKu11lx7Yyzjk7QiRPbuUmO+Ua7FGL9/M=;
        b=DBn10X/MsztvbH0+eu4VT652zvHdzoWAnsryQAGVDEVmeEzHjR3ABtLnB0yIEPbRYR
         PLj/FR5c90POlDlnbsn5j/JTD3qwXyWpa76vK18hT4ew/HnaTy7J6ChRWIDa3Bnt8Wlq
         TjTzpdOPaYKPG9sIvy5aDKOJcNRXXHzUBSO7CsRYOX5L9KR2VG21eq82fRkYf+l12N7T
         w4rvPoHYTgzT+uch+XtgrsHx1tB2V3wnyajJZ+u9sgNpnUZ5BRgJVcysSGGqR/LSlOpO
         ZomjORgfXkF9c87NqO61HYcO3ORXVYr2sW/5pF2xU77IvFgkftbiofLJZMxQbXXClw1u
         TkuQ==
X-Gm-Message-State: AA+aEWavh39gqqDnxyfjUOIn6gbI48sYYcJHkMpiDcWR37yaZXCX+6Uo
        1HmZQoklacec3zD0ip/w6mLC57E=
X-Google-Smtp-Source: AFSGD/XJZZLeeuaZASwiAd3lKbwBHLjHmx45iFPFXaLE5ZUoKhl4amvG8cWC4rHbKQe5ILo2tZ1L5Q==
X-Received: by 2002:ac8:5344:: with SMTP id d4mr2021508qto.372.1543508419772;
        Thu, 29 Nov 2018 08:20:19 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 83sm1718039qkz.73.2018.11.29.08.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:20:19 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:20:13 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181129162012.hcknuu256trdwnfc@gabell>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:16:27PM +0800, Chao Fan wrote:
> To fix the conflict between KASLR and memory-hotremove, memory
> information in SRAT table is necessary.
> 
> ACPI SRAT (System/Static Resource Affinity Table) can show the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT table must be introduced by RSDP pointer (Root
> System Description Pointer). So RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP pointer
> are different. When booting from KEXEC, 'acpi_rsdp' may have been
> added to cmdline, so parse the cmdline and find the RSDP pointer.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 33 +++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.c   |  5 +++++
>  arch/x86/boot/compressed/misc.h   |  4 ++++
>  lib/kstrtox.c                     |  5 +++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> new file mode 100644
> index 000000000000..614c45655cff
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BOOT_CTYPE_H
> +#include "misc.h"
> +#include "error.h"
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include <linux/numa.h>
> +#include <linux/acpi.h>
> +
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
> +/* Store the immovable memory regions. */
> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif
> +
> +static acpi_physical_address get_acpi_rsdp(void)
> +{
> +#ifdef CONFIG_KEXEC
> +	unsigned long long res;
> +	int len = 0;

> +	char *val;
> +
> +	val = malloc(19);
> +	len = cmdline_find_option("acpi_rsdp", val, 19);
> +	if (len > 0) {
> +		val[len] = 0;

		val[len] = '\0';

> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}

I think free() is needed. Or why don't you use stack?

	char val[19];

	len = cmdline_find_option("acpi_rsdp", val, sizeof(val));
	if (len > 0) {
		val[len] = '\0';
		return (acpi_physical_address)kstrtoull(val, 16, &res);
	}

Thanks,
Masa

> +	return 0;
> +#endif
> +}
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 8dd1d5ccae58..e51713fe3add 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -12,6 +12,7 @@
>   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>   */
>  
> +#define BOOT_CTYPE_H
>  #include "misc.h"
>  #include "error.h"
>  #include "pgtable.h"
> @@ -426,3 +427,7 @@ void fortify_panic(const char *name)
>  {
>  	error("detected buffer overflow");
>  }
> +
> +#ifdef BOOT_STRING
> +#include "../../../../lib/kstrtox.c"
> +#endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..809c31effa4b 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -116,3 +116,7 @@ static inline void console_init(void)
>  void set_sev_encryption_mask(void);
>  
>  #endif
> +
> +/* acpitb.c */
> +#define BOOT_STRING
> +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..a0ac1b2257b8 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  }
>  EXPORT_SYMBOL(kstrtoull);
>  
> +/* Make compressed period code be able to use kstrtoull(). */
> +#ifndef BOOT_STRING
> +
>  /**
>   * kstrtoll - convert a string to a long long
>   * @s: The start of the string. The string must be null-terminated, and may also
> @@ -408,3 +411,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
> +
> +#endif /* BOOT_STRING */
> -- 
> 2.19.1
> 
> 
> 
