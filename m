Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34AFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FFC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FFC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJBRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:01:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:01:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AIflc1917711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:18:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AIfLg1917708;
        Tue, 2 Oct 2018 03:18:41 -0700
Date:   Tue, 2 Oct 2018 03:18:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Message-ID: <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
Cc:     m.mizuma@jp.fujitsu.com, bhe@redhat.com, bp@alien8.de,
        torvalds@linux-foundation.org, msys.mizuma@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org
Reply-To: m.mizuma@jp.fujitsu.com, bhe@redhat.com, bp@alien8.de,
          torvalds@linux-foundation.org, msys.mizuma@gmail.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20181001140843.26137-3-msys.mizuma@gmail.com>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding size
 for KASLR is not enough
Git-Commit-ID: 3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
Gitweb:     https://git.kernel.org/tip/3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
AuthorDate: Mon, 1 Oct 2018 10:08:42 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 11:47:21 +0200

ACPI/NUMA: Add warning message if the padding size for KASLR is not enough

Add warning message if the padding size for KASLR,
rand_mem_physical_padding, is not enough. The message also
says the suitable padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181001140843.26137-3-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/setup.h |  2 ++
 drivers/acpi/numa.c          | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..65a5bf8f6aba 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -80,6 +80,8 @@ static inline unsigned long kaslr_offset(void)
 	return (unsigned long)&_text - __START_KERNEL;
 }
 
+extern int rand_mem_physical_padding;
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 85167603b9c9..3d69834c692f 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,6 +32,7 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <asm/setup.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -435,6 +436,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
+	u64 max_possible_phys, max_actual_phys, threshold;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -463,6 +465,18 @@ int __init acpi_numa_init(void)
 
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
+
+		/* check the padding size for KASLR is enough. */
+		if (parsed_numa_memblks && kaslr_enabled()) {
+			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
+			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
+			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
+
+			if (max_possible_phys > threshold) {
+				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
+				  (max_possible_phys - max_actual_phys) >> 40);
+			}
+		}
 	}
 
 	/* SLIT: System Locality Information Table */
