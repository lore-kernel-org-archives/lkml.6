Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872D2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxIVKFSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfAKFN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:13:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38863 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfAKFN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:13:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so6226377plb.5;
        Thu, 10 Jan 2019 21:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+u0Zr0RniU+aM1CbZXWVIvdBXHEhjiwQS1respGVgg=;
        b=QxIVKFSc+xLsuLW52+XUiU/TXXaB/qGlW4A3Cfa8HuJjgkRI/wq/+IAYzlXWpogLhL
         Vi+Dd9HsaFROyIJIagXcYbmzrfaIhR4PGbbxmRMZuH1yn1GgIFu/ZL7NZD+s46NfL45X
         8C5AwFAPWdyoRQwJ+d8vsbAdzSku4NcDZqy+GyaEBdD+Of+l9fkrvT/Zmfbrtdy8w2LH
         8PfhPnh/14bVlCBvekx6P9ZKTm6CqjiJ73oHlSYxKJy79q14FJP5w14Z3LD5SAuTolcL
         7CzpEwS5A7hagjBChFbVjBPChSF2jmpenqDqd0Mx8UOyMdYFKVmG82yvL38fgM6TGyWF
         iFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+u0Zr0RniU+aM1CbZXWVIvdBXHEhjiwQS1respGVgg=;
        b=eFCN4qWMjnrBiN1R+Z/2+8rDmjXO+DPZYtSDBYW8PlIABryqJsJFMyifAHSg6M4Jd9
         1MyIrxNEnbrmm0SXLPXUfHo0CouiYqk8E7Ip34FgTJ9kA/2yZ3yGs0Ibe27si+IEWDRe
         dc4nLAIFh7Zg9QbtAHRP4naTJewUgUP9chq+CDjawKgrwTapN7sTyoCrK6TSOVuVyLu6
         SK4yJsH5C8Y+q5jYZ6iiyLQN9wdv28IWrNfRklw/oCgQcrYc1IHYg8cFAltM7YjvdmFM
         EwC9aHFl2AWWHdFh/f7AZkTasFeDUcF59ZZlCSa65SBOkYmnCjEzbdkCuaeQ8mBkNE/P
         eSkA==
X-Gm-Message-State: AJcUukeLEj++eS5GXwvUKYvQdJ9u96cwckb3sWI0pkOv/nhik9JQPQu/
        J8L2VARJB+3q7E6pI/hj8+1dZ1PSQeib
X-Google-Smtp-Source: ALg8bN7eC57a6OGKT0WjXEulrsCn268Kwp8SuL/Sc5JAlDGxLx10K/Z81zjSvV5waQB2JL3h2km0FQ==
X-Received: by 2002:a17:902:7614:: with SMTP id k20mr13420401pll.285.1547183604873;
        Thu, 10 Jan 2019 21:13:24 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:13:24 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHv2 1/7] x86/mm: concentrate the code to memblock allocator enabled
Date:   Fri, 11 Jan 2019 13:12:51 +0800
Message-Id: <1547183577-20309-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch identifies the point where memblock alloc start. It has no
functional.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/kernel/setup.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..ac432ae 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -962,29 +962,6 @@ void __init setup_arch(char **cmdline_p)
 
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/*
-	 * Memory used by the kernel cannot be hot-removed because Linux
-	 * cannot migrate the kernel pages. When memory hotplug is
-	 * enabled, we should prevent memblock from allocating memory
-	 * for the kernel.
-	 *
-	 * ACPI SRAT records all hotpluggable memory ranges. But before
-	 * SRAT is parsed, we don't know about it.
-	 *
-	 * The kernel image is loaded into memory at very early time. We
-	 * cannot prevent this anyway. So on NUMA system, we set any
-	 * node the kernel resides in as un-hotpluggable.
-	 *
-	 * Since on modern servers, one node could have double-digit
-	 * gigabytes memory, we can assume the memory around the kernel
-	 * image is also un-hotpluggable. So before SRAT is parsed, just
-	 * allocate memory near the kernel image to try the best to keep
-	 * the kernel away from hotpluggable memory.
-	 */
-	if (movable_node_is_enabled())
-		memblock_set_bottom_up(true);
-#endif
 
 	x86_report_nx();
 
@@ -1096,9 +1073,6 @@ void __init setup_arch(char **cmdline_p)
 
 	cleanup_highmap();
 
-	memblock_set_current_limit(ISA_END_ADDRESS);
-	e820__memblock_setup();
-
 	reserve_bios_regions();
 
 	if (efi_enabled(EFI_MEMMAP)) {
@@ -1113,6 +1087,8 @@ void __init setup_arch(char **cmdline_p)
 		efi_reserve_boot_services();
 	}
 
+	memblock_set_current_limit(0, ISA_END_ADDRESS, false);
+	e820__memblock_setup();
 	/* preallocate 4k for mptable mpc */
 	e820__memblock_alloc_reserved_mpc_new();
 
@@ -1130,7 +1106,31 @@ void __init setup_arch(char **cmdline_p)
 	trim_platform_memory_ranges();
 	trim_low_memory_range();
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/*
+	 * Memory used by the kernel cannot be hot-removed because Linux
+	 * cannot migrate the kernel pages. When memory hotplug is
+	 * enabled, we should prevent memblock from allocating memory
+	 * for the kernel.
+	 *
+	 * ACPI SRAT records all hotpluggable memory ranges. But before
+	 * SRAT is parsed, we don't know about it.
+	 *
+	 * The kernel image is loaded into memory at very early time. We
+	 * cannot prevent this anyway. So on NUMA system, we set any
+	 * node the kernel resides in as un-hotpluggable.
+	 *
+	 * Since on modern servers, one node could have double-digit
+	 * gigabytes memory, we can assume the memory around the kernel
+	 * image is also un-hotpluggable. So before SRAT is parsed, just
+	 * allocate memory near the kernel image to try the best to keep
+	 * the kernel away from hotpluggable memory.
+	 */
+	if (movable_node_is_enabled())
+		memblock_set_bottom_up(true);
+#endif
 	init_mem_mapping();
+	memblock_set_current_limit(get_max_mapped());
 
 	idt_setup_early_pf();
 
@@ -1145,8 +1145,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	mmu_cr4_features = __read_cr4() & ~X86_CR4_PCIDE;
 
-	memblock_set_current_limit(get_max_mapped());
-
 	/*
 	 * NOTE: On x86-32, only from this point on, fixmaps are ready for use.
 	 */
-- 
2.7.4

