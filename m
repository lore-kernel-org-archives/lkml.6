Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37868C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31452133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY+hfB0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbeLQRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:16:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45483 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeLQRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:16:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so7752740qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/lB1yINtkBrV2oTAzQ8ZOCMd3eQiPRpf88y7Zf3G74=;
        b=YY+hfB0mRR45Vp0IjD8AXRbg1/hBdqxqw5hqwBb/qU3HIq2DbNRNYCHNS+VpYXwCil
         oSvngzVjj7n3WOtRvqLcSlcnyqlreDGBVtyFbr3CPsmCP6+yRcIdACZXrcsX0+yxU3zo
         0sTzi1qZv6nYupo3XBrfVg2LfzQ3ad7r5As8VmNoAxKfYH0qqwsI6s5GIjpW+LGq4Rbu
         zbR6hvNZJCbnMMRHSnqIWWl1dJH43xMk1Qveo4zqxigbiBR1I+a4brFH4wFzkUVA+dvG
         8jasOlGdn3jeWUdiOEejeiUk6kGw4py29YjNm5aysLHkb8xI1KMU+FBuCaJ7nf2NW3x6
         lp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/lB1yINtkBrV2oTAzQ8ZOCMd3eQiPRpf88y7Zf3G74=;
        b=DVlpvLy5p4ooaFNlw8Vo9zrjSRUfeoBMGYy6wlMAKJCbsswHHHbAvuNRziXzsAcqWj
         iSfPfXGZCh3FAIaC+UtEhiuuGalSRxgCusUbyDSh8LEv3ophQPU0A1PwYPlIZP4YvjmK
         Pqt491MZtxVjR0xTVUvBPdCQrZQeuAFuPe7KYqguDqXUZ6b/OuSFTYSDbjaPkCMR8zVN
         3EcwFiprVg9qjDF42y3dyoCqktiaz/EYsa4sN+PKU6tBcjVysRveushREqWfUGP9xi35
         EbTanq2NDDpOPho5Hd2HFRNs8qjelSPh6WoEQRQxCfPtb37NsBCszxJbrfs1C/plT+8G
         5SfQ==
X-Gm-Message-State: AA+aEWa9Enm8Lu2JQhNwIP50PhwS837McahYt+/YLfj34lDOOT5jamSw
        yiXdgnf14X1k5rOVu8K0Mg==
X-Google-Smtp-Source: AFSGD/WuFQdToL8UrpDNszJIhXbytFUp7F5nBKG/euvpiW6ntbXb1XytAQpmkBcpkAV6u6bFMJuHYw==
X-Received: by 2002:a37:be02:: with SMTP id o2mr13194712qkf.133.1545066969713;
        Mon, 17 Dec 2018 09:16:09 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f14sm8388960qka.18.2018.12.17.09.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:16:09 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:16:05 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181217171604.pr6o4dy3guqmoo3i@gabell>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:10:50AM +0800, Chao Fan wrote:
> Memory information in SRAT is necessary to fix the conflict between
> KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
> 
> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
> are different. When booting from EFI, EFI table points to RSDP.
> So parse the EFI table and find the RSDP.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index cad15686f82c..c96008712ec9 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return 0;
>  #endif
>  }
> +
> +/* Search EFI table for RSDP. */
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	acpi_physical_address rsdp_addr = 0;
> +	efi_system_table_t *systab;
> +	struct efi_info *e;
> +	bool efi_64;
> +	char *sig;
> +	int size;
> +	int i;
> +
> +	e = &boot_params->efi_info;
> +	sig = (char *)&e->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4))
> +		efi_64 = true;
> +	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
> +		efi_64 = false;
> +	else {
> +		debug_putstr("Wrong EFI loader signature.\n");
> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. Based on efi_init(). */
> +#ifdef CONFIG_X86_64
> +	systab = (efi_system_table_t *)(e->efi_systab | ((__u64)e->efi_systab_hi<<32));
> +#else
> +	if (e->efi_systab_hi || e->efi_memmap_hi) {
> +		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> +		return 0;
> +	}
> +	systab = (efi_system_table_t *)e->efi_systab;
> +#endif
> +
> +	if (!systab)
> +		return 0;
> +
> +	/*
> +	 * Get EFI tables from systab. Based on efi_config_init() and
> +	 * efi_config_parse_tables().
> +	 */
> +	size = efi_64 ? sizeof(efi_config_table_64_t) :
> +			sizeof(efi_config_table_32_t);
> +
> +	for (i = 0; i < systab->nr_tables; i++) {
> +		void *config_tables;

> +		unsigned long table;

		u64 table;

Otherwise, the following build warning happen in ARCH=i386.
===
arch/x86/boot/compressed/acpi.c:96:44: warning: right shift count >= width of type [-Wshift-count-overflow]
    if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
===

Thanks,
Masa
