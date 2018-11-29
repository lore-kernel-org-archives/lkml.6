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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF6C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C812146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyfEszt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C812146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeK3Eui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:50:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41092 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbeK3Eui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:50:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so1554652qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zmfFJPL7+/cOk8ascdK+XjmKUzeq6IuRrKTy6cB/0/E=;
        b=RyfEszt+C9qJzm7kF+7uei9pZZOI+X5BVTv10cvRMOWVWZjARb3a7jnWa0nmyaS1uI
         xB7cKRrDPuGeKJYDd9ICV7CIF/P+CqtIUPpujIsYp/+SfbOsGIaStGYu0p5tsHJYjSTb
         B4VURbp7lKShcnJOw5MtT9qi8JIso/3x3LiGS+yYxivS8ZZIlDVuwWcFgVD9/n+kIHeq
         huKgXnzCBG8ZT30d8jHZYHtKgbziX8dEtKDD/BcOBwqPWPxoqztBNEAp6v/8UCAFl0+z
         2VEc397fSnBiVYFMmGKdvAijtArdoRAhOs1txCLiyQ/UxCj4DXSRoa+GVBsoVnC+Vily
         yH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zmfFJPL7+/cOk8ascdK+XjmKUzeq6IuRrKTy6cB/0/E=;
        b=sP4YmXBQjVdNfzGPEPp0qdQwplIJbEW1TI7OGe23H5Bn/pTwWRorLDxNHcXQwOYrtR
         4fuQKGhD4J7PmfZhBoGojXlzqFX2Pl0obxHcW0aG70S3ydE5rZnvNU2QGAaABCoNR5cr
         b2b6Vc0iAUHAtv5GcrAkv8zXqsGaaiY+NDSDyC+c5B6cEbmCc0Q5Ot0+8bYNg9O+x/OX
         vRjkJmNkPfxcVKuNnj4bwPtxExGtNtUq9/qunNRYcPvAgFHLgIpldVGjz/g5FVIZaL4P
         eLK6m6GWtnVi+eFW6Tt8KFbz7JIEieBfa2/xZ+7EzLZkpsQaKMmFY4DFv6dME9UjDjYV
         hbgw==
X-Gm-Message-State: AA+aEWZrHRKS1DbzSKndp/Nu/1JG9GiDMn91pXjfmJLwaJCrkI4ZYAcq
        5MdIoUXresYX+PQhazx1QA==
X-Google-Smtp-Source: AFSGD/UEzALfBqbFO3/xr5W5UGQaJ3OGRJJ5GZAvgVoxMLC8XSP+fq4Sa0GynjWq1M6u2NOM1H6EUg==
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr2162032qkg.184.1543513467698;
        Thu, 29 Nov 2018 09:44:27 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w52sm1649386qtc.51.2018.11.29.09.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:44:27 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:44:24 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181129174424.rurhcqlsqwpddj5n@gabell>
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

Remove this #endif...

Thanks,
Masa

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
> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}
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
