Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A20C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11070222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfBMBys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:54:48 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36273 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729322AbfBMBys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:54:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="54206572"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Feb 2019 09:54:44 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 427B94B4030E;
        Wed, 13 Feb 2019 09:54:41 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Feb 2019 09:54:49 +0800
Date:   Wed, 13 Feb 2019 09:54:29 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <caoj.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190213015429.GA12592@localhost.localdomain>
References: <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
 <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
 <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
 <20190211112009.GE19618@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190211112009.GE19618@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 427B94B4030E.A8A63
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:20:09PM +0100, Borislav Petkov wrote:
>On Mon, Feb 11, 2019 at 10:46:18AM +0000, Ard Biesheuvel wrote:
>> As I pointed out in my previous reply, systab will be the wrong type
>> on 32-bit firmware, it needs to be efi_system_table_32_t
>
>This seems to work. Chao, please run it too.

Yes, your PATCH really works well. I tried both efi32 OVMF and efi64
OVMF, all boot.

Thanks,
Chao Fan

>
>Thx.
>
>---
>diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>index c5a949335d8b..0d97aa8bd01f 100644
>--- a/arch/x86/boot/compressed/acpi.c
>+++ b/arch/x86/boot/compressed/acpi.c
>@@ -50,7 +50,8 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> 	acpi_physical_address rsdp_addr = 0;
> 
> #ifdef CONFIG_EFI
>-	efi_system_table_t *systab;
>+	unsigned long systab, systab_tables, config_tables;
>+	unsigned int nr_tables;
> 	struct efi_info *ei;
> 	bool efi_64;
> 	int size, i;
>@@ -70,13 +71,13 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> 
> 	/* Get systab from boot params. */
> #ifdef CONFIG_X86_64
>-	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
>+	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
> #else
> 	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
> 		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> 		return 0;
> 	}
>-	systab = (efi_system_table_t *)ei->efi_systab;
>+	systab = ei->efi_systab;
> #endif
> 	if (!systab)
> 		error("EFI system table not found.");
>@@ -87,16 +88,30 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> 	size = efi_64 ? sizeof(efi_config_table_64_t) :
> 			sizeof(efi_config_table_32_t);
> 
>-	for (i = 0; i < systab->nr_tables; i++) {
>+	if (efi_64) {
>+		efi_system_table_64_t *st_tbl = (efi_system_table_64_t *)systab;
>+
>+		config_tables	= st_tbl->tables;
>+		nr_tables	= st_tbl->nr_tables;
>+	} else {
>+		efi_system_table_32_t *st_tbl = (efi_system_table_32_t *)systab;
>+
>+		config_tables	= st_tbl->tables;
>+		nr_tables	= st_tbl->nr_tables;
>+	}
>+
>+	if (!config_tables)
>+		error("EFI config tables not found.");
>+
>+	for (i = 0; i < nr_tables; i++) {
> 		acpi_physical_address table;
>-		void *config_tables;
> 		efi_guid_t guid;
> 
>-		config_tables = (void *)(systab->tables + size * i);
>+		config_tables += size * i;
>+
> 		if (efi_64) {
>-			efi_config_table_64_t *tmp_table;
>+			efi_config_table_64_t *tmp_table = (efi_config_table_64_t *)config_tables;
> 
>-			tmp_table = config_tables;
> 			guid = tmp_table->guid;
> 			table = tmp_table->table;
> 
>@@ -105,9 +120,8 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> 				return 0;
> 			}
> 		} else {
>-			efi_config_table_32_t *tmp_table;
>+			efi_config_table_32_t *tmp_table = (efi_config_table_32_t *)config_tables;
> 
>-			tmp_table = config_tables;
> 			guid = tmp_table->guid;
> 			table = tmp_table->table;
> 		}
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


