Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE07208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHi3BS+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE07208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeJPENG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:13:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34919 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPENG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:13:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id d21-v6so10697738qtq.2;
        Mon, 15 Oct 2018 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oCi3FVp5ocBY6c4z7IFq967pE+pliNEr3UNCzwjPnio=;
        b=SHi3BS+NiA6YPq0VLkVZWJqvd92wjSCPHkQYdCOSQEPDVyPNs3aZ2YR66ROPN3Tj6H
         3tp4aZe1blgkSKLUp4iidNz7V2y1pavjYjKLMSldSOhZs2rpIhR5PyRpVLwOCmRu2swX
         4U3bIP0THvLorSX8pkJLQU5vTbvdEwoVBbUWBT7gtHYJNmZL0jRbBzGGOoA04tDShkrb
         +LULEOJr1SfiuBJmL3+xov/vIhA4XqtoGECLz+wnM06AhhTqcY8uEN4eYbLEisFa/Txi
         uLKwqSy6hRthkOUGm1XfrtWq5ND+FO6JXLXGyiplrKexa4SdjtxdquqNS4vXJjIgyjc2
         DimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oCi3FVp5ocBY6c4z7IFq967pE+pliNEr3UNCzwjPnio=;
        b=PZt4C2TFha/SVln/Yku9rIISDRkEH6pei71AeZ2Z+FWBDfF8qAe+RnUJ2PWJ0tLskm
         E6aqENOfV23mM+A6V/9W0Qr2JDRVzU3JU2IpsI6HJTQDbK6ryLZ/gYuymllv4vnet/04
         jOcxXjeK9uuPmaG0WCvPukFOAxZxUFuHlg6yhswm/GleYjBFvhYnuVxMDcxLo5snZS0/
         89bMQWPinNjV8kAlV0BHnsYBQi5Io5G1S2rpaycJkWe732SmmGHHPG4dn+tl7R3wt5VP
         BhrkLazhR7AOe6LK2sKHMrV2SE6UCSCp9zGsyKFjCe0e0M/NHnZ3h9sCbPRQWJbdrRFr
         84AA==
X-Gm-Message-State: ABuFfojywIQvNljEps2Bd/74CMRiCkji/lKuTPKNXBSzKDePPttQ6cI1
        izxv7TraKGdq9NndjwtqTA==
X-Google-Smtp-Source: ACcGV62KSApkwIV39hYTvU2ftAKajeNWRgSIZdqSegEd2wO4U+6dAIcuWyDFEZ0fhrxcBSTmFDA9Ig==
X-Received: by 2002:a0c:9377:: with SMTP id e52mr18709367qve.73.1539635176394;
        Mon, 15 Oct 2018 13:26:16 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a72-v6sm6046369qkc.19.2018.10.15.13.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 13:26:16 -0700 (PDT)
Date:   Mon, 15 Oct 2018 16:26:09 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20181015202609.gs6jownxbevs4vzr@gabell>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010084119.17539-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010084119.17539-2-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Let me add some suggestions.

On Wed, Oct 10, 2018 at 04:41:17PM +0800, Chao Fan wrote:
> There is a bug that kaslr may randomly chooses some positions
> which are located in movable memory regions. This will break memory
> hotplug feature and make the movable memory chosen by KASLR can't be
> removed. So dig SRAT table from ACPI tables to get memory information.
> 
> Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
> tables. Since some operations are not needed here, functions are
> simplified. Functions will be used to dig only SRAT tables to get
> information of memory, so that KASLR can the memory in immovable node.
> 
> And also, these functions won't influence the initialization of
> ACPI after start_kernel().
> 
> Since use physical address directely, so acpi_os_map_memory()
> and acpi_os_unmap_memory() are not needed.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/Makefile |   2 +
>  arch/x86/boot/compressed/acpitb.c | 405 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h   |   8 +
>  3 files changed, 415 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
> 
...cut...
> +static struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +	char *args = (char *)get_cmd_line_ptr();
> +	acpi_physical_address acpi_table;
> +	acpi_physical_address root_table;
> +	struct acpi_table_header *header;
> +	struct acpi_table_rsdp *rsdp;
> +	char *signature;
> +	u8 *entry;
> +	u32 count;
> +	u32 size;
> +	int i, j;
> +	u32 len;
> +
> +	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
> +	if (!rsdp)
> +		return NULL;
> +
> +	/* Get rsdt or xsdt from rsdp. */
> +	if (!strstr(args, "acpi=rsdt") &&
> +	    rsdp->xsdt_physical_address && rsdp->revision > 1) {
> +		root_table = rsdp->xsdt_physical_address;
> +		size = ACPI_XSDT_ENTRY_SIZE;
> +	} else {
> +		root_table = rsdp->rsdt_physical_address;
> +		size = ACPI_RSDT_ENTRY_SIZE;
> +	}
> +
> +	/* Get ACPI root table from rsdt or xsdt.*/
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
> +			if (!strncmp(signature, "SRAT", 4))

			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))

> +				return header;
> +		}
> +		entry += size;
> +	}
> +	return NULL;
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/*
> + * According to ACPI table, filter the immvoable memory regions
> + * and store them in immovable_mem[].
> + */
> +void get_immovable_mem(void)
> +{
> +	char *args = (char *)get_cmd_line_ptr();
> +	struct acpi_table_header *table_header;
> +	struct acpi_subtable_header *table;
> +	struct acpi_srat_mem_affinity *ma;
> +	unsigned long table_end;
> +	int i = 0;
> +
> +	if (!strstr(args, "movable_node") || strstr(args, "acpi=off"))
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

> +	while (((unsigned long)table) + table->length < table_end) {

	while (((unsigned long)table) +
			sizeof(struct acpi_subtable_header) < table_end) {

> +		if (table->type == 1) {

		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {

> +			ma = (struct acpi_srat_mem_affinity *)table;
> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> +				immovable_mem[i].start = ma->base_address;
> +				immovable_mem[i].size = ma->length;
> +				i++;
> +			}
> +
> +			if (i >= MAX_NUMNODES*2)
> +				break;
> +		}
> +		table = (struct acpi_subtable_header *)
> +			((unsigned long)table + table->length);
> +	}
> +	num_immovable_mem = i;
> +}

Thanks,
Masa
