Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44511ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D72075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJYJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:54:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34448 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbeJYJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:54:00 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46678276"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Oct 2018 09:23:31 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D80604B7117F;
        Thu, 25 Oct 2018 09:23:30 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 25 Oct 2018 09:23:37 +0800
Date:   Thu, 25 Oct 2018 09:22:35 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <mingo@redhat.com>, <hpa@zytor.com>, <keescook@chromium.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <ard.biesheuvel@linaro.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181025012235.GA1905@localhost.localdomain>
References: <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181023024801.GA25978@localhost.localdomain>
 <20181024192135.7qhhfbbrgb4ojgqe@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181024192135.7qhhfbbrgb4ojgqe@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D80604B7117F.AA278
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:21:36PM -0400, Masayoshi Mizuma wrote:
>On Tue, Oct 23, 2018 at 10:48:02AM +0800, Chao Fan wrote:
>> On Mon, Oct 22, 2018 at 11:42:05AM -0400, Masayoshi Mizuma wrote:
>> >Hi Boris,
>> 
>> Hi Mizuma-san,
>> 
>> I have several questions:
>
>Thank you for your comments! I think your suggestions are
>right.
>However, the prototype patch works EFI environment only.

Yes, I agree. But I think this method is much better than
adding code to arch/x86/mm/kaslr.c.

>The memory hot-plug affinity in SRAT and KASLR are also available
>on legacy BIOS environment, so I need to get the patch useful
>for legacy BIOS as well, but I have no idea to add such things...
>If you have ideas, could you let me know?

I have no idea. I will work on it, try to help figure out the BIOS issue.

Thanks,
Chao Fan

>
>Probably I should have another idea, for example,
>add the SRAT parsing code, looks like you are adding to
>arch/x86/boot/compressed/acpitb.c, to arch/x86/mm/kaslr.c.
>
>Thanks,
>Masa
>
>> 
>> >+static void store_possible_addr(unsigned long long possible)
>> >+{
>> >+	struct setup_data *data;
>> >+
>> >+	data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
>> I suggest you add check:
>> 
>> 	if (!data) {
>> 		debug_putstr("No setup_data found.\n");
>> 		return;
>> 	}
>> 
>> >+	while (data) {
>> >+		if (data->type == SETUP_KASLR) {
>> >+			*(unsigned long long *)data->data = possible;
>> >+			return;
>> >+		}
>> >+		data = (struct setup_data *)(unsigned long)data->next;
>> >+	}
>> >+}
>> >+
>> > /*
>> >  * According to ACPI table, filter the immvoable memory regions
>> >  * and store them in immovable_mem[].
>> >@@ -319,6 +333,7 @@ void get_immovable_mem(void)
>> > 	struct acpi_subtable_header *table;
>> > 	struct acpi_srat_mem_affinity *ma;
>> > 	unsigned long table_end;
>> >+	unsigned long long possible_addr, max_possible_addr = 0;
>> > 	int i = 0;
>> >
>> > 	if (!cmdline_find_option_bool("movable_node") ||
>> >@@ -338,7 +353,12 @@ void get_immovable_mem(void)
>> > 		       sizeof(struct acpi_subtable_header) < table_end) {
>> > 		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>> > 			ma = (struct acpi_srat_mem_affinity *)table;
>> >-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>> >+
>> >+			if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
>> >+				possible_addr = ma->base_address + ma->length;
>> >+				if (possible_addr > max_possible_addr)
>> >+					max_possible_addr = possible_addr;
>> >+			} else {
>> > 				immovable_mem[i].start = ma->base_address;
>> > 				immovable_mem[i].size = ma->length;
>> > 				i++;
>> >@@ -351,4 +371,5 @@ void get_immovable_mem(void)
>> > 			((unsigned long)table + table->length);
>> > 	}
>> > 	num_immovable_mem = i;
>> >+	store_possible_addr(max_possible_addr);
>> > }
>> >diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
>> >index 1458b17..9b95fba 100644
>> >--- a/arch/x86/boot/compressed/eboot.c
>> >+++ b/arch/x86/boot/compressed/eboot.c
>> >@@ -192,6 +192,40 @@ static void setup_efi_pci(struct boot_params *params)
>> > 	efi_call_early(free_pool, pci_handle);
>> > }
>> >
>> >+#ifdef CONFIG_RANDOMIZE_MEMORY
>> >+static void setup_kaslr(struct boot_params *params)
>> >+{
>> >+	struct setup_data *kaslr_data = NULL;
>> >+	struct setup_data *data;
>> >+	unsigned long size;
>> >+	efi_status_t status;
>> >+
>> >+	size = sizeof(struct setup_data) + sizeof(unsigned long long);
>> >+
>> >+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
>> >+			size, (void **)&kaslr_data);
>> >+	if (status != EFI_SUCCESS) {
>> >+		efi_printk(sys_table, "Failed to allocate memory for 'kaslr_data'\n");
>> >+		return;
>> >+	}
>> >+
>> >+	kaslr_data->type = SETUP_KASLR;
>> >+	kaslr_data->next = 0;
>> >+	kaslr_data->len = size;
>> >+
>> >+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
>> >+	if (data)
>> >+		data->next = (unsigned long)kaslr_data;
>> Why just put the kaslr_data in data->next. You can't make sure
>> data->next was NULL.
>> >+	else {
>> If data is NULL, go to this else{}, so these two lines below work?
>> >+		while (data->next)
>> >+			data = (struct setup_data *)(unsigned long)data->next;
>> >+		data->next = (unsigned long)kaslr_data;
>> >+	}
>> If my understanding is not wrong, it should be:
>> 
>> 	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
>> 	if (!data)
>> 		params->hdr.setup_data = (unsigned long)kaslr_data;
>> 	else {
>> 		while (data->next)
>> 			data = (struct setup_data *)(unsigned long)data->next;
>> 		data->next = (unsigned long)kaslr_data;
>> 	}
>> 
>> If I misunderstand something, please tell me.
>> 
>> Thanks,
>> Chao Fan
>> 
>> 
>
>


