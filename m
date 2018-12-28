Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C715C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D5421741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUi18dw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeL1DAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:00:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38790 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeL1DAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:00:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so9875075pfi.5;
        Thu, 27 Dec 2018 19:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utqMO7rFICkXWGRPQf4AEPGgKb/tTK2f5Z60c7Pe4V4=;
        b=BUi18dw8kuhZpD/rEHe5XiZUCnoHtgu1EtYJVs3GNgJE5bQiCQb8cMwdSfpb4IBEJu
         8521eV4nMG+0pxmvH906NSRJKw6ftZ82yWJ7DAzQ33eXT0cCdzg7pLzDQyDcYMqDfo5z
         4/yvLq1pWWF/xwxTOFmO4Eb2N5an9iNZKMMPXu4f6UnHxWLD3CF/5WMl2uVmgzNppkgN
         NxMyZuu94WLtOG6o1MTLlgd6PTSUupX07BF9LhcJPhRMOX8n8fYOmpC4+uO+U+MseL3Q
         bFcnxs/NiF3raRLjTFBhBZpy9We6/+v5t9/RImLkTdicADc0hrKWPEkDqDC3K3xnV4VI
         6leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utqMO7rFICkXWGRPQf4AEPGgKb/tTK2f5Z60c7Pe4V4=;
        b=hr8yxGzXXONFMNKkZ8D90duStAl9VYoGRhEq68Y4jPyNxjejPUJRuY8QFp5INNb/jd
         DwZCEpdJ1iFArjZ/inJB0VXwJAurAKT/BvfYenLGhZcKDBCRStg8PFPey9Nxx6AFmiI5
         Q+4skwphK/io1Y2LJN6uzsYgCwplQbefIHYe5y67DzQK5eha33jnM3NoQ2spHN49Qjyu
         QTBkxxFbDZsrQFOlYsaSvOWfPTJCihJkKvAdRN+iV1wPSVnox/89Rp4x/5j5ohOeJudx
         E/VRKryhvjyQHzhCUYxfnIrgkfFEJ77lf0ZwrrBbvA89QPWJ/sCxc7EffCQoMXiWCMMO
         oVnQ==
X-Gm-Message-State: AJcUukfwTrAMpOeZ5Kev3cJq8XESZtDfQ7bQSNYQq+9+/oEj5bAzbtTK
        W/eO2irzaRXWCRpoXsfMwq7txp5umzbd
X-Google-Smtp-Source: ALg8bN6Z4CgnipeBNmTZ9DngS5sCwR81xBZvukBWpEADltwaXqlztHIGPEHhB/RV3HBCQgQohAGy2g==
X-Received: by 2002:a63:e445:: with SMTP id i5mr24757805pgk.307.1545966029228;
        Thu, 27 Dec 2018 19:00:29 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 202sm80185958pfy.87.2018.12.27.19.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 19:00:28 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/2] mm/memblock: extend the limit inferior of bottom-up after parsing hotplug attr
Date:   Fri, 28 Dec 2018 11:00:01 +0800
Message-Id: <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bottom-up allocation style is introduced to cope with movable_node,
where the limit inferior of allocation starts from kernel's end, due to
lack of knowledge of memory hotplug info at this early time. But if later,
hotplug info has been got, the limit inferior can be extend to 0.
'kexec -c' prefers to reuse this style to alloc mem at lower address,
since if the reserved region is beyond 4G, then it requires extra mem
(default is 16M) for swiotlb.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Daniel Vacek <neelx@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/numa.c      |  4 ++++
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 2746994..3eea4e4 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -462,6 +462,10 @@ int __init acpi_numa_init(void)
 
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
+
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+		mark_mem_hotplug_parsed();
+#endif
 	}
 
 	/* SLIT: System Locality Information Table */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aee299a..d89ed9e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -125,6 +125,7 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+void mark_mem_hotplug_parsed(void);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 81ae63c..a3f5e46 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -231,6 +231,12 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
 	return 0;
 }
 
+static bool mem_hotmovable_parsed __initdata_memblock;
+void __init_memblock mark_mem_hotplug_parsed(void)
+{
+	mem_hotmovable_parsed = true;
+}
+
 /**
  * memblock_find_in_range_node - find free area in given range and node
  * @size: size of free area to find
@@ -259,7 +265,7 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 					phys_addr_t end, int nid,
 					enum memblock_flags flags)
 {
-	phys_addr_t kernel_end, ret;
+	phys_addr_t kernel_end, ret = 0;
 
 	/* pump up @end */
 	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
@@ -270,34 +276,40 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 	end = max(start, end);
 	kernel_end = __pa_symbol(_end);
 
-	/*
-	 * try bottom-up allocation only when bottom-up mode
-	 * is set and @end is above the kernel image.
-	 */
-	if (memblock_bottom_up() && end > kernel_end) {
-		phys_addr_t bottom_up_start;
+	if (memblock_bottom_up()) {
+		phys_addr_t bottom_up_start = start;
 
-		/* make sure we will allocate above the kernel */
-		bottom_up_start = max(start, kernel_end);
-
-		/* ok, try bottom-up allocation first */
-		ret = __memblock_find_range_bottom_up(bottom_up_start, end,
-						      size, align, nid, flags);
-		if (ret)
+		if (mem_hotmovable_parsed) {
+			ret = __memblock_find_range_bottom_up(
+				bottom_up_start, end, size, align, nid,
+				flags);
 			return ret;
 
 		/*
-		 * we always limit bottom-up allocation above the kernel,
-		 * but top-down allocation doesn't have the limit, so
-		 * retrying top-down allocation may succeed when bottom-up
-		 * allocation failed.
-		 *
-		 * bottom-up allocation is expected to be fail very rarely,
-		 * so we use WARN_ONCE() here to see the stack trace if
-		 * fail happens.
+		 * if mem hotplug info is not parsed yet, try bottom-up
+		 * allocation with @end above the kernel image.
 		 */
-		WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
+		} else if (!mem_hotmovable_parsed && end > kernel_end) {
+			/* make sure we will allocate above the kernel */
+			bottom_up_start = max(start, kernel_end);
+			ret = __memblock_find_range_bottom_up(
+				bottom_up_start, end, size, align, nid,
+				flags);
+			if (ret)
+				return ret;
+			/*
+			 * we always limit bottom-up allocation above the
+			 * kernel, but top-down allocation doesn't have
+			 * the limit, so retrying top-down allocation may
+			 * succeed when bottom-up allocation failed.
+			 *
+			 * bottom-up allocation is expected to be fail
+			 * very rarely, so we use WARN_ONCE() here to see
+			 * the stack trace if fail happens.
+			 */
+			WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
 			  "memblock: bottom-up allocation failed, memory hotremove may be affected\n");
+		}
 	}
 
 	return __memblock_find_range_top_down(start, end, size, align, nid,
-- 
2.7.4

