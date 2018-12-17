Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D174C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C372133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545067517;
	bh=AI5AXkTeiFKa3BBmUxvtw4VNgubrdNomju84JTX3lUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kavu9gaUQ6zHI7VEoTi5RK2G1V9pfJ0DN7h7BtuJnvFOc/+R6104oMUOi3lU/yn2h
	 mHuK7a2Mo+SEvFUeSP8LrzlsKXND1mMasHuc6lHPZPLz6Y6jgcBWv0GVhnvy03GR6F
	 KMA7kYqaHScjP3KFEBn/f+Vs7BHRcfmL8wl9ToHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeLQRZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:25:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35007 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeLQRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:25:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so45056wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzxeQAeBcfwjWd6uRZ79gUXOJyj8m1rfDRi0Z4NzHnc=;
        b=Y3K4lJPo2d/PpKtyDTN9GytUB2KdzsCYAmGqxsApTUifb8Q2ymHapx+EX+oKauIvta
         /E0KzVnZRel836q2mmO9C9NYKa2tlYodDIJma32CDGf64zP6hswr8apsjmbkSz/QgrQF
         zThZvPnRJec4yedJNsidXHS29SJvy8UKV4ABK/NiP8LhQFtPj8ep3iSPchxc8y7F/qvv
         uon+WaGLHs677hR2tD6jFUjTygwGpb9qytC1YzvV/sD8Q3LoMdr+aZJhoYStq21x+HHp
         FSt59xSP1phRR/4u9EqVWcHBntVGchHtpvD71djlZOPsKYVP/NlOM51yvRe/+TPqLpoI
         uRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzxeQAeBcfwjWd6uRZ79gUXOJyj8m1rfDRi0Z4NzHnc=;
        b=YjDaiAMIUp+uabx7+XqPswdgGU5asfDX93TeyGWGQE1Vu8HdJtVMyqLPh0wuHhG4t9
         jCfdDBZ4jorXFUGz3kZ4OxGyXrhUKX6kdt/CEfxOY0BPtQuciIbbF+8ex2e/EdFsqF6g
         wncm0Y5TOJR+jnE8ans2yrm/PG2FEnn6so9dSwIE52c3Jl8K+5x8rbJf6JDAnLFATpaB
         4/uo1tU/taND1V/IKc+fusUfKaWmNaDF8NBA/h6BYtuIAFSa0lXVoA9I+8TTalmlT6jS
         rXtXDm0aEovUvX+ZACvbjwBPVmoqYT5scDlNUVNYVu5kkkrXP091aghs/tR7WyFcP/TV
         vdzA==
X-Gm-Message-State: AA+aEWZHyarG9cH35C9FWaLzQI1x7H5otcyuvlknLoqaRv/D77wphw1I
        BiFRkQPZgKTVEykITni6HnY=
X-Google-Smtp-Source: AFSGD/Wg6slAut0g7TXncoLxbtmCUUKBRX1quFRFO2FFPkKkRytE5eUqemz4/pX87rmW2uIItWTUfA==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr696wmg.51.1545067513716;
        Mon, 17 Dec 2018 09:25:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a12sm1101627wro.18.2018.12.17.09.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:25:13 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:25:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181217172510.GA90818@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove.
> 
> ACPI SRAT (System/Static Resource Affinity Table) shows the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT is introduced by Root System Description
> Pointer(RSDP), so RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
> are different. When booting from KEXEC, 'acpi_rsdp' may have been
> added to cmdline, so parse cmdline to find RSDP.

What is the nature of the basic conflict? Should the kernel only allow 
hot-removing memory ranges that are explicitly marked as such in the 
SRAT? I presume that's already so, correct? Or should the kernel avoiding 
KASLR-randomizing into hot-removable memory areas?

Some minor nits:

> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpi.c
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> new file mode 100644
> index 000000000000..44f19546c169
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
> +/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digits */
> +#define MAX_ADDRESS_LENGTH 18

I'd suggest adding the +1 for the string termination \0 as well, and use 
that below.

Also, 'max address length' is way too generic (and hence pretty 
meaningless) - how about MAX_HEX_ADDRESS_STRING_LEN or so?

> +
> +static acpi_physical_address get_acpi_rsdp(void)
> +{
> +#ifdef CONFIG_KEXEC
> +	char val[MAX_ADDRESS_LENGTH+1];
> +	unsigned long long res;
> +	int len;
> +
> +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
> +	if (len > 0) {
> +		char *e;
> +
> +		val[len] = '\0';
> +		return (acpi_physical_address)simple_strtoull(val, &e, 16);

'return' is not a function - no need for the parenthesis.

Thanks,

	Ingo
