Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96528C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0262084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B89EBzmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0262084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbeKPV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:28:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbeKPV25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:28:57 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542367021; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrdV4LNfU1WtkI1OmvJyM/WppDdD2qrjgbY67T7a2Fs=;
        b=B89EBzmpWOEFjfCvMEBRtZbpyPWb0MM5L0T6wuV2xtQAELQ0Ww6A0yxPxss+HXfKKSr0kH
        y+h58CvJ8qbqnDTIgx0tTu502bDDw8/MqYzO4PoA+D2RcQlQuuJrI91IR9uF8S9ENLdDCw
        s4FT7O6abaIUivhOxd8zlTgk+ai95dM=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bX9536rg7kPG; Fri, 16 Nov 2018 12:17:01 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0FE004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:fe00:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 850BC1EC03C8;
        Fri, 16 Nov 2018 12:17:00 +0100 (CET)
Date:   Fri, 16 Nov 2018 12:16:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 4/5] x86/boot: Dig out SRAT table from RSDP and find
 immovable memory
Message-ID: <20181116111654.GC20313@zn.tnic>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-5-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112094645.4879-5-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:46:44PM +0800, Chao Fan wrote:
> To avoid KASLR extracting kernel on movable memory, slove the
						      ^^^^^

Please introduce a spellchecker into your patch creation workflow.

> conflict between KASLR and movable_node feature, dig the SRAT tables

s/dig/determine/ or "compute SRAT table's address" or so.

Also, replace "dig" with a more suitable verb in all your patches.

> from RSDP pointer. Walk the SRAT tables and store the immovable
> memory regions in immovable_mem[].

		"... in an array called immovable_mem[]."

> There are three methods to get RSDP pointer: KEXEC condition,
> EFI confition, BIOS condition.

"condition" is not the right word here.

> If KEXEC add 'acpi_rsdp' to cmdline, use it.
> Otherwise, parse EFI table for RSDP.
> Then, search memory for RSDP.
> 
> Imitate from ACPI code, based on acpi_os_get_root_pointer().
> Process: RSDP->RSDT/XSDT->ACPI root table->SRAT.

What?!

This looks like a comment you've added as a note for yourself but not
part of the final commit message. If you wanna explain the process, then
write it out in plain english as if you're explaining it to someone who
doesn't know what you're doing.

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

Right, as previously pointed out, this needs that CONFIG_ symbol and
then you can save yourself most (if not all) of the ifdeffery in the
rest of the patchset.

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

Reorganize that code here to get rid of acpi_use_rsdt.

> +
> +	/* Get ACPI root table from RSDT or XSDT.*/
> +	header = (struct acpi_table_header *)root_table;
> +	len = header->length;

No checking of that header pointer before dereffing it?

If it is NUL, that gives you a very nasty bug to try to debug in the
early code.

> +	count = (u32)((len - sizeof(struct acpi_table_header)) / size);

Uuh, no checking for count wrapping around here due to wrong len? That
would give you a *lot* of looping below if it wraps.

IOW, you need to verify all those values before doing arithmetic with
them - it is early code and it is BIOS - there's no trusting it.

Also, it is not "count" but "num_entries" or so.

> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
> +
> +	for (i = 0; i < count; i++) {

That variable i is not needed, right?

	while (num_entries--)

?

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

Now can acpi_table be NUL here?

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
					  ^^^^^^^^^
Typo.

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

"..., aborting."

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

Above says "regions" but define below is "TABLES". Hmmm?

> +#define ACPI_MAX_TABLES                128
> +void get_immovable_mem(void);
> +#endif
> +#endif
> -- 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
