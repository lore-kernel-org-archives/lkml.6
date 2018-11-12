Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509622507
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHzPymgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B509622507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeKMHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:47:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41089 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeKMHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:47:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so16075980qkj.8;
        Mon, 12 Nov 2018 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sw/pr0udrOlUnFKQmEpKblJ8VIzowgGSTR5MnbBsQnc=;
        b=GHzPymgCSj+wei2kFZJsieWxJO9y4CDKZyMfIXNRxOZW5JZhtFEla0ZTZQe4V4tBRh
         ywh7Pztteq11Ekp3xW4Pntpm9WGequroCqOtbMjB6D+SkjBgiQcRffOgpQquEcTacfGn
         ajq5LJFGA+xlCpCCHzcUCn81oEnHYb2kzq5XZCYGgqGHZBLd4eNm1+CL5FpvU/mSDa5K
         s10BEjwLkt1K0hDB2HD1KuiLks7JkmfWx6DyqYAQ2u5XNw7Bl9v4mJlA1So8KQWvN3Nw
         vNDUBNWWwCvaUtSyZiZre46gvGGHvbAST0MZrv3F1lMIsWzW4r/qhdwRE9iNr3nPXOJ/
         bgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sw/pr0udrOlUnFKQmEpKblJ8VIzowgGSTR5MnbBsQnc=;
        b=D2XvcbVSpE3T+xF/zGnH8uFtXTD3ui1XUB0r7VXx3e+JVj4y3VIkE5NKhoFOlRJFy7
         9BqcM1CEhLe13U7Oi6Tc4H6grFn/vcRQOK1vfP8BA0e4uxHSreLH2jJrBbErgdxSKRDW
         yOT0aP5KHnIMt1y+edzwAUfyaI5SNxhNj4j4XdhkqPH0L0pb6IbJ0cbJ6Yo67cuQ1i+2
         QoAV3a0c7L/2tn/nELmQIN3Fv0Vz1R5N041v9wRgVb8AAlZAmtfN2dACr/wkjbX+2UUi
         csLrY5hoLTVS4h/mURZTFptaPuiMMf9aAmK8Wy+f4+LsdBjmGvGEv8hAbQEcJLk3WvjG
         5GLw==
X-Gm-Message-State: AGRZ1gJfbqyVJFEuWG29uWXy2m1rqFqVzYS011TM95svJoTuiEvO3xZi
        hj3hlAXbg7/BrZNu60uHkA==
X-Google-Smtp-Source: AJdET5dWXTWncID0OIO4JO5WFcED9uZHZin/56lgQ6nzYcNMjZMEGmnupNxKYxp/SCMw9kZwXF8l8g==
X-Received: by 2002:ac8:46c6:: with SMTP id h6mr2600992qto.315.1542059521983;
        Mon, 12 Nov 2018 13:52:01 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s34sm1958058qth.72.2018.11.12.13.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 13:52:01 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:51:59 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 4/5] x86/boot: Dig out SRAT table from RSDP and find
 immovable memory
Message-ID: <20181112215158.55jcpbe4fa6jskb5@gabell>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-5-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112094645.4879-5-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:46:44PM +0800, Chao Fan wrote:
> To avoid KASLR extracting kernel on movable memory, slove the
> conflict between KASLR and movable_node feature, dig the SRAT tables
> from RSDP pointer. Walk the SRAT tables and store the immovable
> memory regions in immovable_mem[].
> 
> There are three methods to get RSDP pointer: KEXEC condition,
> EFI confition, BIOS condition.
> If KEXEC add 'acpi_rsdp' to cmdline, use it.
> Otherwise, parse EFI table for RSDP.
> Then, search memory for RSDP.
> 
> Imitate from ACPI code, based on acpi_os_get_root_pointer().
> Process: RSDP->RSDT/XSDT->ACPI root table->SRAT.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/Makefile |   4 +
>  arch/x86/boot/compressed/acpitb.c | 139 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c  |   4 -
>  arch/x86/boot/compressed/misc.h   |  15 ++++
>  4 files changed, 158 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 466f66c8a7f8..b51f7629b8ef 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -84,6 +84,10 @@ ifdef CONFIG_X86_64
>  	vmlinux-objs-y += $(obj)/pgtable_64.o
>  endif
>  
> +#if (defined CONFIG_MEMORY_HOTREMOVE) && (defined CONFIG_RANDOMIZE_BASE)
> +vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/acpitb.o
> +#endif

'#' in Makefile means comment out...

ifdef CONFIG_MEMORY_HOTREMOVE
        vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/acpitb.o
endif

> +
>  $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
>  
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> index 5cfb4efa5a19..161f21a7fb3b 100644
> --- a/arch/x86/boot/compressed/acpitb.c
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -14,6 +14,11 @@
>  #define BOOT_STRING
>  #include "../string.h"
>  

> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the immovable memory regions */
> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif

This #ifdef isn't needed.

Could you please check the other #ifdef statement as well?

Thanks,
Masa

> +
>  /* Search EFI table for RSDP table. */
>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  {
> @@ -226,3 +231,137 @@ static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>  	}
>  #endif
>  }
> +
> +/*
> + * Used to dig RSDP table from EFI table or BIOS.
> + * If RSDP table found in EFI table, use it. Or search BIOS.
> + * Based on acpi_os_get_root_pointer().
> + */
> +static acpi_physical_address get_rsdp_addr(void)
> +{
> +	acpi_physical_address pa = 0;
> +
> +	get_acpi_rsdp(&pa);
> +
> +	if (!pa)
> +		efi_get_rsdp_addr(&pa);
> +
> +	if (!pa)
> +		bios_get_rsdp_addr(&pa);
> +
> +	return pa;
> +}
> +
> +static struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +	acpi_physical_address acpi_table;
> +	acpi_physical_address root_table;
> +	struct acpi_table_header *header;
> +	struct acpi_table_rsdp *rsdp;
> +	bool acpi_use_rsdt = false;
> +	char *signature;
> +	char arg[10];
> +	u8 *entry;
> +	u32 count;
> +	u32 size;
> +	int i, j;
> +	int ret;
> +	u32 len;
> +
> +	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
> +	if (!rsdp)
> +		return NULL;
> +
> +	ret = cmdline_find_option("acpi", arg, sizeof(arg));
> +	if (ret == 4 && !strncmp(arg, "rsdt", 4))
> +		acpi_use_rsdt = true;
> +
> +	/* Get RSDT or XSDT from RSDP. */
> +	if (!acpi_use_rsdt &&
> +	    rsdp->xsdt_physical_address && rsdp->revision > 1) {
> +		root_table = rsdp->xsdt_physical_address;
> +		size = ACPI_XSDT_ENTRY_SIZE;
> +	} else {
> +		root_table = rsdp->rsdt_physical_address;
> +		size = ACPI_RSDT_ENTRY_SIZE;
> +	}
> +
> +	/* Get ACPI root table from RSDT or XSDT.*/
> +	header = (struct acpi_table_header *)root_table;
> +	len = header->length;
> +	count = (u32)((len - sizeof(struct acpi_table_header)) / size);
> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
> +
> +	for (i = 0; i < count; i++) {
> +		u64 address64;
> +
> +		if (size == ACPI_RSDT_ENTRY_SIZE)
> +			acpi_table = ((acpi_physical_address)
> +				      (*ACPI_CAST_PTR(u32, entry)));
> +		else {
> +			*(u64 *)(void *)&address64 = *(u64 *)(void *)entry;
> +			acpi_table = (acpi_physical_address) address64;
> +		}
> +
> +		if (acpi_table) {
> +			header = (struct acpi_table_header *)acpi_table;
> +			signature = header->signature;
> +
> +			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
> +				return header;
> +		}
> +		entry += size;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * According to ACPI table, filter the immvoable memory regions
> + * and store them in immovable_mem[].
> + */
> +void get_immovable_mem(void)
> +{
> +	struct acpi_table_header *table_header;
> +	struct acpi_subtable_header *table;
> +	struct acpi_srat_mem_affinity *ma;
> +	unsigned long table_end;
> +	char arg[10];
> +	int i = 0;
> +	int ret;
> +
> +	ret = cmdline_find_option("acpi", arg, sizeof(arg));
> +	if (ret == 3 && !strncmp(arg, "off", 3))
> +		return;
> +
> +	if (!cmdline_find_option_bool("movable_node"))
> +		return;
> +
> +	table_header = get_acpi_srat_table();
> +	if (!table_header)
> +		return;
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +
> +	table = (struct acpi_subtable_header *)
> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
> +
> +	while (((unsigned long)table) +
> +		       sizeof(struct acpi_subtable_header) < table_end) {
> +		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> +			ma = (struct acpi_srat_mem_affinity *)table;
> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> +				immovable_mem[i].start = ma->base_address;
> +				immovable_mem[i].size = ma->length;
> +				i++;
> +			}
> +
> +			if (i >= MAX_NUMNODES*2) {
> +				debug_putstr("Too many immovable memory regions, aborted.\n");
> +				break;
> +			}
> +		}
> +		table = (struct acpi_subtable_header *)
> +			((unsigned long)table + table->length);
> +	}
> +	num_immovable_mem = i;
> +}
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709d9947..b251572e77af 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -87,10 +87,6 @@ static unsigned long get_boot_seed(void)
>  #define KASLR_COMPRESSED_BOOT
>  #include "../../lib/kaslr.c"
>  
> -struct mem_vector {
> -	unsigned long long start;
> -	unsigned long long size;
> -};
>  
>  /* Only supporting at most 4 unusable memmap regions with kaslr */
>  #define MAX_MEMMAP_REGIONS	4
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..4a3645fda0ed 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
>  			    unsigned long *output,
>  			    unsigned long output_size,
>  			    unsigned long *virt_addr);
> +struct mem_vector {
> +	unsigned long long start;
> +	unsigned long long size;
> +};
> +
>  /* cpuflags.c */
>  bool has_cpuflag(int flag);
>  #else
> @@ -116,3 +121,13 @@ static inline void console_init(void)
>  void set_sev_encryption_mask(void);
>  
>  #endif
> +
> +/* acpitb.c */
> +#ifdef CONFIG_RANDOMIZE_BASE
> +int num_immovable_mem;
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the amount of immovable memory regions */
> +#define ACPI_MAX_TABLES                128
> +void get_immovable_mem(void);
> +#endif
> +#endif
> -- 
> 2.19.1
> 
> 
> 
