Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9B9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34C217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYCegLec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfBEPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:05:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40803 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:05:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so1823416qta.7;
        Tue, 05 Feb 2019 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QyDQZHnbhzlkECxuJ6YyFClvddOgyYJVbtTCsXxc2SI=;
        b=kYCegLecoTD2uGwiOd1IO27GcQxDcZ4f6cYBHLWBXdxd3RO2teyCzjX/58YqUdc/IB
         NiLQkPYyeoFNxauq1ENximbo87RKsLrmscWulg+YWGPqL8QbekwNRgYO90zyLOr7rED5
         KPqSZbB0M2UQ+ip2m8MNFfiues+JymuAVO2UUmFlLKuhGpnibduQtw8pVZv48veKskRd
         mrl/7FYiei4/bGpBWm7E8WmI/5DC9guZHUvH7g/m6e4DVkpFgoCGlGN4vrpQOtrQRr7g
         TAN+W063VImagwAaaNQJJIFr9QBJCooBMsVqrwQDeAq4yqdVn1fApQuSCzNtf9o2bvY9
         u2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QyDQZHnbhzlkECxuJ6YyFClvddOgyYJVbtTCsXxc2SI=;
        b=Yx/j3xXHCbkj0G5za/H4urFvuSg/Fa1LgfETzpUQ+ZQushT73neoVDsRlrhxthUeTz
         rS0Z1YFpPwvrpixlf4uNbUaRGTOqEQuyjJ5pBQ5rJ+XB8Am6zOarn+cUJodEltUECPTy
         sXziwjmDBzgFG8aqCmaeW15XAMx3bX5o1BRSikkvVJwAR9IBe9mPoR8NkZN67oL93HJn
         4fnUPhz48dfCE1k4R25bvinehk/GeWXDDOm70UfTRuomTKeUPzfPZn5gUggN7rJUX5jr
         bExdXOajhGvBxNBpr/M+plqD7Pdz1dRQMKpfgoTpne5jAP6JOieis6ZGj8Z/4istyTrg
         C9xw==
X-Gm-Message-State: AHQUAubDx9ougkx8aA7mar08CCR8GPHKsEFL7Tp8I+is3a/m6zH25M0r
        rly/lC4Yonx27HCMG+c06Q==
X-Google-Smtp-Source: AHgI3IbnH4Gev4fPm2Cu+dr68lEeErNcpFQe9p7y5G8wsT+/Irb+13TsuCbHVm6oIAvMY/dbiAeQdg==
X-Received: by 2002:ac8:1695:: with SMTP id r21mr1900886qtj.226.1549379126058;
        Tue, 05 Feb 2019 07:05:26 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t123sm14732544qkc.6.2019.02.05.07.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:05:25 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:05:16 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, keescook@chromium.org, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20190205150514.fvztftk75swgfayd@gabell>
References: <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
 <20181106222133.lb7674yzszivzihd@gabell>
 <20181108105129.GA7543@zn.tnic>
 <20181110105422.GA20023@zn.tnic>
 <20181111134556.qxv2v4g7dl5irzo7@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111134556.qxv2v4g7dl5irzo7@gabell>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and all,

On Sun, Nov 11, 2018 at 08:45:57AM -0500, Masayoshi Mizuma wrote:
> On Sat, Nov 10, 2018 at 11:54:22AM +0100, Borislav Petkov wrote:
> > On Thu, Nov 08, 2018 at 11:51:29AM +0100, Borislav Petkov wrote:
> > > A global definition which doesn't need allocation?
> > > 
> > > Maybe hpa would have another, better idea...
> > 
> > ...and he has: just put that address in a new field in struct
> > boot_params by converting one of the padding arrays there.
> > 
> > Don't forget to document it in Documentation/x86/zero-page.txt
> > 
> > This way you don't need any of the allocation fun or to use setup_data
> > at all.
> 
> Thanks!
> I have the prototype patch to use boot_params [1].
> I will try to brush up it.
> 
> [1] https://lore.kernel.org/lkml/20181016151353.punyk7exekut2543@gabell

Chao's patches are included in the tip tree, so I modified the patch.

Could you review the following patch?

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Date: Tue, 5 Feb 2019 10:00:59 -0500
Subject: [PATCH] x86/mm: Introduce adjustment the padding size for KASLR

If the physical memory layout has huge space for hotplug, the padding
used for the physical memory mapping section is not enough.
So, such system may crash while memory hot-adding on KASLR enabled system.

For example, SRAT has the following layout, the maximum possible memory
size is 32TB, and the memory is installed as 2TB actually, then the padding
size should set 30TB (== possible memory size - actual memory size).

  SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

This patch introduces adjustment the padding size if the default
padding size isn't enough.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/x86/zero-page.txt       |  1 +
 arch/x86/boot/compressed/acpi.c       | 19 +++++++++++++++----
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 26 +++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
index 68aed077f..343fe1a90 100644
--- a/Documentation/x86/zero-page.txt
+++ b/Documentation/x86/zero-page.txt
@@ -15,6 +15,7 @@ Offset	Proto	Name		Meaning
 058/008	ALL	tboot_addr      Physical address of tboot shared page
 060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
 				(struct ist_info)
+078/010	ALL	possible_mem_addr The possible maximum physical memory address.
 080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
 090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
 0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c5a949335..7dd61b943 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -288,6 +288,7 @@ int count_immovable_mem_regions(void)
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
 	char arg[MAX_ACPI_ARG_LENGTH];
+	unsigned long long possible_addr, max_possible_addr = 0;
 	int num = 0;
 
 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
@@ -308,10 +309,19 @@ int count_immovable_mem_regions(void)
 			struct acpi_srat_mem_affinity *ma;
 
 			ma = (struct acpi_srat_mem_affinity *)sub_table;
-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-				immovable_mem[num].start = ma->base_address;
-				immovable_mem[num].size = ma->length;
-				num++;
+			if (ma->length) {
+				if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
+					possible_addr =
+						ma->base_address + ma->length;
+					if (possible_addr > max_possible_addr)
+						max_possible_addr =
+							possible_addr;
+				} else {
+					immovable_mem[num].start =
+						ma->base_address;
+					immovable_mem[num].size = ma->length;
+					num++;
+				}
 			}
 
 			if (num >= MAX_NUMNODES*2) {
@@ -320,6 +330,7 @@ int count_immovable_mem_regions(void)
 			}
 		}
 		table += sub_table->length;
+		boot_params->possible_mem_addr = max_possible_addr;
 	}
 	return num;
 }
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137..5b64b606e 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -156,7 +156,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64  possible_mem_addr;			/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed..71fc28570 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,6 +70,30 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static unsigned int __init kaslr_padding(void)
+{
+	unsigned int rand_mem_physical_padding =
+				CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unsigned long long max_possible_phys, max_actual_phys, threshold;
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
+#endif
+	return rand_mem_physical_padding;
+}
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -103,7 +127,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+			kaslr_padding();
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.20.1

Thanks,
Masa
