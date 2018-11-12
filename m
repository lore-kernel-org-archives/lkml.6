Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA222243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXJOw6CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA222243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeKMDiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:38:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43483 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeKMDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:38:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so14745563qkr.10;
        Mon, 12 Nov 2018 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8F3CijJUA2+Qc/Xz0eBd1Bn4aYzhA5i2RbZ6IfAcSw=;
        b=PXJOw6CBFBR8qVxowUk8dvqH4M8g8iUyxpGToqggfuZGoKUl2FG6qLtzr8VxqA8MOI
         uBbtlvAje/A+59nk1tQ+NarA590c7SPG00fyiC5hpQIDyyQWgQBFFrrnKlEtl3blLFZP
         2pIYrwmPhzjciwgmyv0Ax7+cCgVguW0ke8S06cw2cxnbkmyLrhezgikjeE44QPwauo/S
         FNKnHTZSG1i+HzFYY5cOISzyzoBND1HznUO2J5X3eCE+3INFzKNlzOArbQ+ojsSLJvOO
         /1eewWn8h1Y6pUmC2144fwdix3KT/gplKZ14Y0nIO3T4a0pp8Fkv+eoGwplqHPjlpRP4
         K10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8F3CijJUA2+Qc/Xz0eBd1Bn4aYzhA5i2RbZ6IfAcSw=;
        b=NyqQJdneN4Q0jSvqxd2fn/01NHPV5qBQcs/plHQ3nciR+GiRSLKV0+pBKkFmzC6Ck9
         5bvXYyXVkc5KUZUOA0eIVVlCcvl1cXnQmjf/U7XAZ0iL61kXfHxsNWhgwqcIIUZFWDGZ
         b0NkefLvWba3i7Md81Yt4prX7W5ymP/biHU/Drp0Snn4XpftTKqJOgA53D3ppRwPb31u
         N3vuSwFeBuGdU3ukf8flMz6lXerFM9z1jL9c+rr/7HzOnhlRXVF064DO1AmSmp6YpYgd
         Vy4LCwmKKCMHrgYoVlAcvamLNaLQ8c9ClEYSqIpr+1BK59rDbFemNm787v+vxc8ofmoD
         Cscw==
X-Gm-Message-State: AGRZ1gJ3Mw4PD0nXfaW+kdHJ/5KkRophBCi79DAp4bojmtuqhb0yr5Fq
        y4vjxWZd09ZRVW9m99Y8oA==
X-Google-Smtp-Source: AJdET5d1UrQ/Xf6QqMjT79bsFxg0bG7OZpuSPB3jJ3QFiXB83mJ1KPm6bvyKZICXm+pr7FRC1vFkZg==
X-Received: by 2002:ac8:4055:: with SMTP id j21mr1798025qtl.389.1542044630376;
        Mon, 12 Nov 2018 09:43:50 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q36-v6sm10976228qte.94.2018.11.12.09.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 09:43:50 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:43:44 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181112174343.mvjri2okwboew2nw@gabell>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Nov 12, 2018 at 05:46:43PM +0800, Chao Fan wrote:
> Imitate setup_acpi_rsdp() for the early_param of 'acpi_rsdp'.
> KEXEC writes the RSDP pointer to cmdline for EFI booting.
> So if 'acpi_rsdp' found in cmdline, use it directely.
> 

> Since function kstrtoull() is needed, include it in
> arch/x86/boot/string.h. To solve the definition conflict
> problem, set BOOT_STRING tag to expose only kstrtoull() and
> functions used by it. Other functions in lib/kstrtox.c will
> be covered.

How about the following get_acpi_rsdp()...? It doesn't use kstrtoull().

static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
{
#ifdef CONFIG_KEXEC
        unsigned long addr;
        char val[32];

        if (cmdline_find_option("acpi_rsdp", val, sizeof(val)) > 0) {
                char *e;

                if (!strncmp(val, "0x", 2)) {
                        addr = simple_strtoull(val + 2, &e, 16);
                        if ((addr == 0) || ((val + 2) == e))
                                return;
                        *rsdp_addr = (acpi_physical_address)addr;
                }
        }
#endif
}

Thanks,
Masa

> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 26 ++++++++++++++++++++++++++
>  arch/x86/boot/string.h            |  4 ++++
>  lib/kstrtox.c                     |  4 ++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> index 50fa65cf824d..5cfb4efa5a19 100644
> --- a/arch/x86/boot/compressed/acpitb.c
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -8,6 +8,12 @@
>  #include <linux/numa.h>
>  #include <linux/acpi.h>
>  
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
> +#define BOOT_STRING
> +#include "../string.h"
> +
>  /* Search EFI table for RSDP table. */
>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  {
> @@ -200,3 +206,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  		*rsdp_addr = (acpi_physical_address)address;
>  	}
>  }
> +
> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
> +{
> +#ifdef CONFIG_KEXEC
> +	unsigned long long res;
> +	int len = 0;
> +	char *val;
> +
> +	val = malloc(19);
> +	len = cmdline_find_option("acpi_rsdp", val, 19);
> +
> +	if (len == -1)
> +		return;
> +
> +	if (len > 0) {
> +		val[len] = 0;
> +		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}
> +#endif
> +}
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index 3d78e27077f4..0ff3edb888e4 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -30,3 +30,7 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
>  					  unsigned int base);
>  
>  #endif /* BOOT_STRING_H */
> +
> +#ifdef BOOT_STRING
> +#include "../../../lib/kstrtox.c"
> +#endif
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..3804db9eed56 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -126,6 +126,8 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  }
>  EXPORT_SYMBOL(kstrtoull);
>  
> +#ifndef BOOT_STRING
> +
>  /**
>   * kstrtoll - convert a string to a long long
>   * @s: The start of the string. The string must be null-terminated, and may also
> @@ -408,3 +410,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
> +
> +#endif
> -- 
> 2.19.1
> 
> 
> 
