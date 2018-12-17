Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A56C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545067839;
	bh=jDdWS/zpA9QS2ny+5AMwiq3xIv9iVjjGt3hN3L+uYOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZSCcP1d79cRMCHbZTvmw+5HngBAubyFekuQwrPHrZeES5Z27W9GrD+BWm2uHGGowk
	 +Kl6PMiX48AfHJzRDZ5K5keXJzOqy6iqJAHmRvx1+TDZssyiWN/B9KK+sdlp5deI3l
	 QFnYKa9uB/g12uUfJUcGLMEL6Rsz9SYJgV+qdaMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbeLQRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:30:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40088 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:30:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so13147953wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pn2NUv7AFl9S+xqnD43IhIce7wOhxIipvzh826JbBU=;
        b=bxVCIclo5mkmry0orufSnKtEJYmlwuQHljC/ORcNc7sZERC/MQ5asx3/k7a6NvNrbi
         U494xQcyqfmHY3/n1/UIs5fM3lLzSGpVanSmtZ3j2C8U5oLc4bIKq1v/u1JjANQF4dp9
         Gla6RFpRycsnRD4PzsKfCJjlRZy6m0zKOxKGtzpEIv+aLuttC1fwNBeC2V4bWcmAUSXF
         FO2DVNwN0nQwuP/WrafVuDPCynO0it7OoQu7u9Yzd0aIbQ5/EVpJvCW58oRBpkTxl6k8
         UgZMeZC2dEOA1pOI9TQ55mOezFnekj7LTn+oUGz1MHNjuCQRxnYlVOt9xEFFpbHFF9Pn
         CR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pn2NUv7AFl9S+xqnD43IhIce7wOhxIipvzh826JbBU=;
        b=UceivRYY+14XABaWgu3b5jZlmzy9uz6iTJR3Mif1LIaKU2HPu0thQLEJTtQXVlhn+j
         uHfc6kCNqsFeImc3VnQC3cUqJ60NMe/5Wv77Vg9G66oAbBJ6YB60pFjJ0pfENwSVU1hF
         4fPyzCeWQ1+MnWB1NZZIaPZzdk0JF/jfbHWaxrGGxFQOPdfD2rUHJt8wlvq5zg9Sn4fl
         qFOgKAzBaRXyIg4oBPlQpW0IHSD0/KhM6DV/3SqrvqikkJmVriyRBlqD+FhNMg9GpUTr
         du2Ly0L9LnUfvpUBpENmEEcJcHXJfjEuu+K1En5wThKGL9+yOqAW8UacUjPiAdPwQW5t
         MFUQ==
X-Gm-Message-State: AA+aEWaEBfnqh04xcfmE7OTYgxWIlkf3IAFvBvOGey3r4ACP2tNxZl3b
        CXgCNXoQeJA5EMk6LBODbOk=
X-Google-Smtp-Source: AFSGD/WIkIK3KNThjdVJTQWfXA4Ht6Ak3HPWoNfoHPpRj74URr3D/pAdmjGLqd0sBBvb+IZ2laezYw==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr12129445wrm.223.1545067835924;
        Mon, 17 Dec 2018 09:30:35 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h17sm660907wrt.59.2018.12.17.09.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:30:35 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:30:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 2/5] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181217173032.GB90818@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

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
> index 44f19546c169..4151881d8713 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
>  #endif
>  	return 0;
>  }
> +
> +/* Search EFI table for RSDP. */
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +	acpi_physical_address rsdp_addr = 0;
> +#ifdef CONFIG_EFI
> +	efi_system_table_t *systab;
> +	struct efi_info *e;

'e' is pretty meaningless, the canonical name for efi_info local 
variables is typically 'ei' (although this is not consistent across the 
code).

> +	bool efi_64;

Is this a flag that shows whether the EFI loader is 64-bit?

> +	char *sig;
> +	int size;
> +	int i;
> +
> +	e = &boot_params->efi_info;
> +	sig = (char *)&e->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		efi_64 = true;
> +	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
> +		efi_64 = false;
> +	} else {
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

Is it normal that EFI provides no 'systab'?

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
> +		efi_guid_t guid;
> +
> +		config_tables = (void *)(systab->tables + size * i);
> +		if (efi_64) {
> +			efi_config_table_64_t *tmp_table;
> +
> +			tmp_table = (efi_config_table_64_t *)config_tables;

Since 'config_tables' is a void * there's no need to cast the type.

> +			guid = tmp_table->guid;
> +			table = tmp_table->table;
> +
> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> +				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> +				return 0;
> +			}
> +		} else {
> +			efi_config_table_32_t *tmp_table;
> +
> +			tmp_table = (efi_config_table_32_t *)config_tables;

Ditto.

> +			guid = tmp_table->guid;
> +			table = tmp_table->table;
> +		}

So it looks like 

> +
> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> +			rsdp_addr = (acpi_physical_address)table;
> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> +			return (acpi_physical_address)table;

'return' is not a function.

Thanks,

	Ingo
