Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8783C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E7120879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b22eIwsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E7120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbeLMTZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:25:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42427 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:25:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so1814955qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uhQ4xtSsjXVEk8SJhow8yMIjHBwH0uGK8vR7TLRN4CU=;
        b=b22eIwsvOSqNU24zUsdkGgx+ts4qX6kR12HTYYi2aL9RJulfS7VMPvlbS9MLzZTYK1
         K7n+7QEm7ACysxIgrtSdKLAth9DEfjT3mo8sZwvn6AtsbV0Dp3DNX+ql5mhdBfUtZoSD
         QgOfCb+J4EExTH2tXNxnQb7apxlaXeabK7vDG1K4QUSaYCdwesaBRjvi7uLH8V7rJ1cY
         HXP0kz1V+NS4+XlUQj6+OE3ttQarR3bbLZO5qKo70iuAkMXTcQKXIfsj45R39yq3+6YV
         corkbUxvoYju068wShyDCpi+FagHl1t1eCVPzjT8cLT87MkIxbsVAqSjcvUejt3P20TT
         WIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uhQ4xtSsjXVEk8SJhow8yMIjHBwH0uGK8vR7TLRN4CU=;
        b=WGvB1XHba9IL2C7XyBAarDCtwv0kFr6hoNA1MdXp6mm6ZOEQ7QXZPwn2aR/H6ldoyl
         DZypRloUvSk77//OFvbgoZ773Q2C8me/zzhk1rnLe2mRnomeCEdzNGcjiDiuifZOLVZq
         tk9v09Ewi96y6SpVJ6kpaHPg46ddbIx0q7xSor4eUwk+rRqip4JmFIsbe7hrnmg1YsGW
         NHRy0MWOWAYayr7fhw3G+677PYEbb2/GIS1vnfnai7v9osVf9lJKwrn3Odp6obFTooCC
         rqUFnIcrFpNUdRHHBqMYx3wB+90fz6e32Mcj90ZqrvGkZhg6vn5bvL8mJ01AJZOGia79
         EYng==
X-Gm-Message-State: AA+aEWazP7XGe4eIYDDx1RHlyf0gUHcEp2gvfVsyT3niwDBTZ+1XuAWC
        VI0LBo5Yb9L+FbvRIJtlIg==
X-Google-Smtp-Source: AFSGD/UMjkDpf61UpSJjTmuAk3G2Dg1UoldDPibUtwhB9xw8m4HnPAATdTfQTSK4cxTLfFwC8beVkQ==
X-Received: by 2002:ae9:f80f:: with SMTP id x15mr13167qkh.341.1544729136859;
        Thu, 13 Dec 2018 11:25:36 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c48sm1720168qtd.9.2018.12.13.11.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 11:25:36 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:25:30 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181213192529.yjklliaxy4tk4kck@gabell>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Great work! Let me say some trivial comments.

On Wed, Dec 12, 2018 at 11:10:49AM +0800, Chao Fan wrote:
> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove.
> 
> ACPI SRAT (System/Static Resource Affinity Table) shows the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT is introduced by Root System Description
> Pointer(RSDP). So RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
> are different. When booting from KEXEC, 'acpi_rsdp' may have been
> added to cmdline, so parse cmdline to find RSDP.
> 
> Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
> 'CONFIG_EARLY_PARSE_RSDP' to make ifdeffery clear.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/Kconfig                | 10 ++++++++++
>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h |  6 ++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpi.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba7e3464ee92..455da382fa9e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2149,6 +2149,16 @@ config X86_NEED_RELOCS
>  	def_bool y
>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>  
> +config EARLY_PARSE_RSDP
> +	bool "Parse RSDP pointer on compressed period for KASLR"
> +	def_bool y
> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
> +	help
> +	  This option parses RSDP in compressed period. Works
> +	  for KASLR to get memory information from SRAT table and choose
> +	  immovable memory to extract kernel.
> +	  Say Y if you want to use both KASLR and memory-hotremove.
> +
>  config PHYSICAL_ALIGN
>  	hex "Alignment value to which kernel should be aligned"
>  	default "0x200000"
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> new file mode 100644
> index 000000000000..cad15686f82c
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BOOT_CTYPE_H
> +#include "misc.h"
> +#include "error.h"
> +
> +#include <linux/efi.h>
> +#include <linux/numa.h>
> +#include <linux/acpi.h>
> +#include <asm/efi.h>
> +
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
> +#include "../string.h"
> +
> +static acpi_physical_address get_acpi_rsdp(void)
> +{
> +#ifdef CONFIG_KEXEC
> +	unsigned long long res;
> +	int len = 0;
> +	char val[MAX_ADDRESS_LENGTH+1];
> +

> +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);

sizeof() is better here.

	len = cmdline_find_option("acpi_rsdp", val, sizeof(var));

> +	if (len > 0) {
> +		val[len] = 0;

'\0' should be fine here not 0.

		val[len] = '\0';

> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}
> +	return 0;
> +#endif
> +}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..72fcfbfec3c6 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -116,3 +116,9 @@ static inline void console_init(void)
>  void set_sev_encryption_mask(void);
>  
>  #endif
> +
> +/* acpi.c */
> +#ifdef CONFIG_EARLY_PARSE_RSDP
> +/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digit. */
> +#define MAX_ADDRESS_LENGTH 18
> +#endif
> -- 
> 2.19.2
> 
> 
