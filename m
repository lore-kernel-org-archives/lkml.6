Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F49C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB5C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDIzIUoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB5C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJPXE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:04:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39016 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeJPXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:04:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id e22-v6so26106003qto.6;
        Tue, 16 Oct 2018 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jrztjpm9KbobkEX+xje3pnUDQJA0qNbUYpWCzAkkf4I=;
        b=LDIzIUoyOu6jP89QPrUfEJArwRyVbkVbob8VonNh1SvdiKvX+BvDgbAIGWoG70nsC7
         JLgOHFSwiSlkIo2tfJWiIYDirueo31vYhYbxGo/G2KYlQpjqEAipy+XVxIkNOsiSM0gR
         rJArPj+Z+jl5S6Lw6d/uxkeK6zf2hlqIE3UxppfsItXqG04xhpgUKLT/Th4OjuIw7mWM
         9Pb9r4NwRiu3XX6GXulhEsKYEeOtShRNo7izG89mqq3uRkxmCiRuRfp2TrjiCmyooaNd
         h4DAa2TslTezWmuswmxyma3aTwHf4aibLTMyIjzG0LgUjsm26jdBTAdJCSoi80Wd46r+
         vnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jrztjpm9KbobkEX+xje3pnUDQJA0qNbUYpWCzAkkf4I=;
        b=Z0F5yELPjxJtKd3Sm15V/FMxtH8SszqxFAZtBEJxA2++qAEPs3ExuHc3mF/qaPsTih
         nco9egnplzvyoTWvdisEa2bzlW0mGQygPr0M61K/nAX2do4ddAGSQvPQ2Fwhk5XbCODE
         vzU7+KCAy+5s1hmJ27/SZzDVjXlZHNAo7SBAoPIvphqlqMbkYuknDR4EJvuIMFDLpCxd
         O7iIWT+QVJLkkcGsUDrc5KJCfgh+ri8PM+buzoFxX/TXkyEEaqbfImH6hVExNI3FnlLt
         nw8k4emi76Swyy70yShWLqeNLb3B9A8CmhZ91TbtVcRIOwtJWBBdDyZE1vnhzB84r3yw
         OCwA==
X-Gm-Message-State: ABuFfogfnMCWEz50l58cQELibAEK04ZuWdwJO9SlNs66a6LEBJtxYXa5
        vboE02+UioeLBHG9JN4P1Q==
X-Google-Smtp-Source: ACcGV63jcoFtW/VppzEfMXq8woeNY2nmtDof+7IvugUVmiPChHVq7pkgJtQ0iqqSORFM4211h4PRwg==
X-Received: by 2002:a0c:f68b:: with SMTP id p11mr15509403qvn.45.1539702842883;
        Tue, 16 Oct 2018 08:14:02 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x191-v6sm7723939qkb.93.2018.10.16.08.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:14:02 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:54 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181016151353.punyk7exekut2543@gabell>
References: <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
 <20181010194443.sgdvplwdnltshwwi@gabell>
 <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
 <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015005035.z3xym6nx43hogdge@gabell>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Baoquan and all,

I have created a RFC patch for adjust KASLR padding size.
This patch is based on Can's v8 patch [1/3], and the Can's patch
will be changed in the future, so this patch is just RFC.

Welcome to any comments and suggestions. Thanks!

---
 arch/x86/boot/compressed/acpitb.c     |  8 ++++++-
 arch/x86/include/uapi/asm/bootparam.h |  3 ++-
 arch/x86/mm/kaslr.c                   | 31 ++++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
index 6b869e3f9780..1504b46f2a04 100644
--- a/arch/x86/boot/compressed/acpitb.c
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -367,6 +367,7 @@ void get_immovable_mem(void)
 	struct acpi_subtable_header *table;
 	struct acpi_srat_mem_affinity *ma;
 	unsigned long table_end;
+	unsigned long long possible_addr, max_possible_addr = 0;
 	int i = 0;
 
 	if (!strstr(args, "movable_node") || strstr(args, "acpi=off"))
@@ -384,7 +385,11 @@ void get_immovable_mem(void)
 	while (((unsigned long)table) + table->length < table_end) {
 		if (table->type == 1) {
 			ma = (struct acpi_srat_mem_affinity *)table;
-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
+			if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
+				possible_addr = ma->base_address + ma->length;
+				if (possible_addr > max_possible_addr)
+					max_possible_addr = possible_addr;
+			} else {
 				immovable_mem[i].start = ma->base_address;
 				immovable_mem[i].size = ma->length;
 				i++;
@@ -397,6 +402,7 @@ void get_immovable_mem(void)
 			((unsigned long)table + table->length);
 	}
 	num_immovable_mem = i;
+	boot_params->possible_mem_addr = max_possible_addr;
 }
 #else
 void get_immovable_mem(void)
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index a06cbf019744..c987c725e93a 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -191,7 +191,8 @@ struct boot_params {
 	__u8  _pad7[0x290-0x1f1-sizeof(struct setup_header)];
 	__u32 edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
 	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
-	__u8  _pad8[48];				/* 0xcd0 */
+	__u8  _pad8[40];				/* 0xcd0 */
+	__u64 possible_mem_addr;			/* 0xcf8 */
 	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
 	__u8  _pad9[276];				/* 0xeec */
 } __attribute__((packed));
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b0eda9..8c5aca792b51 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -69,6 +69,35 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+static unsigned int __init kaslr_padding(void)
+{
+	unsigned long long max_possible_phys, max_actual_phys, threshold;
+	unsigned int rand_mem_physical_padding =
+				CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+
+	if (!boot_params.possible_mem_addr)
+		goto out;
+
+	max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << TB_SHIFT);
+	max_possible_phys = roundup(boot_params.possible_mem_addr,
+					1ULL << TB_SHIFT);
+	threshold = max_actual_phys +
+		((unsigned long long)rand_mem_physical_padding << TB_SHIFT);
+
+	if (max_possible_phys > threshold)
+		rand_mem_physical_padding =
+			(max_possible_phys - max_actual_phys) >> TB_SHIFT;
+out:
+	return rand_mem_physical_padding;
+}
+#else
+static unsigned int __init kaslr_padding(void)
+{
+	return CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+}
+#endif
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -102,7 +131,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		kaslr_padding();
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.18.0

- Masa
