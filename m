Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7145D2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpyp8THJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7145D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIFHKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:10:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:10:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so4387764pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ntlToCEYPBVqpbkLSK/ENg542xYGEa6KM3EFSfuXv8=;
        b=Dpyp8THJbeqSZl/2aZHauThs0mNeE2egl0PvC3CE7jbTFQRT1yejyUZbns0YktLraU
         xCnzH1AXwzMwmfuanQiK3P4h7BPgF6eSIHAswTbSV9hhZJ+i3L8qogkpv/m8nqeE1rjU
         BxhR//aDy5Vcd9XMwRvVmJ+qVd9lrxJ7kkuOxXkABdkGNwInmxl81S/h0GLr+cvhr0Vp
         1iNWkJcQe6f3n2qkW1fr+KpRwNjr+FRYvNOWmwmm7L4DHbUowsp1jRpWI8csxmLdwC1N
         P5G1bo9n9sWyc2ekNh+CV44pdmSkU/kYmhOdseJyCK8o3Mske21TU/r3fP0L4MdxHIIM
         dbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ntlToCEYPBVqpbkLSK/ENg542xYGEa6KM3EFSfuXv8=;
        b=inE7S5zgtFXxXQL8VdTTo2zRn7MwS663sES7X01lHdjGMsfGy76EDwenEq+rhxm/f4
         azi49vERaRuuCWax6Qk6GNzvXvY5F/UC5mktbmkjnJfwdfvIRDABSCMfcXZwrn8QSnZe
         E5cgPDbQsLD+ZAx0AX33x8erwjjGV7NJ8NJXTpSni0zYw8OSqdpoFZQxovdiec15y2Np
         SSnrACaUxh0Hj/VxrWsYYdlwRyYT5FTlj6XgeIrmP/lYtE4UFqIDUOWz7R7occcW3rVd
         MgtTZGS+TepdbOjUAskF85ct0XN5Cn0u/6X/LbkkeE2B8TRHxqF1LGfPq9JPEYSyVA4M
         Ordw==
X-Gm-Message-State: APzg51D2c6NOLmA8olORINU6ulityCmYunyUPao6O7ZSwD98XS6elkXM
        3NriritrUkVURpQCFQtHDej+ruU=
X-Google-Smtp-Source: ANB0VdZoLvhplfTnGaikNO3UrU//HVA1zJS4od/a9Izj2t3pSTzcQ8DFjU/N9GtmS1Hq6k/s8Bvb3A==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr609029pgg.163.1536201418278;
        Wed, 05 Sep 2018 19:36:58 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r17-v6sm8780990pff.50.2018.09.05.19.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:36:57 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Subject: [PATCH 2/3] x86/boot/KASLR: change the prototype of process_mem_region() to meet the align requirement
Date:   Thu,  6 Sep 2018 10:36:21 +0800
Message-Id: <1536201382-13133-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the prototype of process_mem_region(), in order to reuse this func
to find a region with special alignment requirement (used in patch 3/3 to
find a region align on 1GiB boundary. And a trivial change on the data type
of mem_vector.size to ease the comparison of underflow.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 5185267..584f17c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -89,7 +89,7 @@ static unsigned long get_boot_seed(void)
 
 struct mem_vector {
 	unsigned long long start;
-	unsigned long long size;
+	long long size;
 };
 
 /* Only supporting at most 4 unusable memmap regions with kaslr */
@@ -577,9 +577,12 @@ typedef void (*handles_mem_region)(struct mem_vector *entry,
 			       unsigned long minimum,
 			       unsigned long image_size);
 
-static void process_mem_region(struct mem_vector *entry,
-			       unsigned long minimum,
-			       unsigned long image_size)
+typedef void (*store_info)(struct mem_vector *region,
+	unsigned long image_size);
+
+static void __process_mem_region(struct mem_vector *entry,
+	unsigned long minimum, unsigned long volume, unsigned long align,
+	store_info store)
 {
 	struct mem_vector region, overlap;
 	struct slot_area slot_area;
@@ -598,9 +601,11 @@ static void process_mem_region(struct mem_vector *entry,
 	end = min(entry->size + entry->start, mem_limit);
 	if (entry->start >= end)
 		return;
-	cur_entry.start = entry->start;
-	cur_entry.size = end - entry->start;
 
+	cur_entry.start =  ALIGN(entry->start,  align);
+	cur_entry.size = end - cur_entry.start;
+	if (cur_entry.size < 0)
+		return;
 	region.start = cur_entry.start;
 	region.size = cur_entry.size;
 
@@ -613,7 +618,7 @@ static void process_mem_region(struct mem_vector *entry,
 			region.start = minimum;
 
 		/* Potentially raise address to meet alignment needs. */
-		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
+		region.start = ALIGN(region.start, align);
 
 		/* Did we raise the address above the passed in memory entry? */
 		if (region.start > cur_entry.start + cur_entry.size)
@@ -628,22 +633,22 @@ static void process_mem_region(struct mem_vector *entry,
 			region.size = KERNEL_IMAGE_SIZE - region.start;
 
 		/* Return if region can't contain decompressed kernel */
-		if (region.size < image_size)
+		if (region.size < volume)
 			return;
 
 		/* If nothing overlaps, store the region and return. */
 		if (!mem_avoid_overlap(&region, &overlap)) {
-			process_gb_huge_pages(&region, image_size);
+			(*store)(&region, volume);
 			return;
 		}
 
-		/* Store beginning of region if holds at least image_size. */
-		if (overlap.start > region.start + image_size) {
+		/* Store beginning of region if holds at least volume. */
+		if (overlap.start > region.start + volume) {
 			struct mem_vector beginning;
 
 			beginning.start = region.start;
 			beginning.size = overlap.start - region.start;
-			process_gb_huge_pages(&beginning, image_size);
+			(*store)(&beginning, volume);
 		}
 
 		/* Return if overlap extends to or past end of region. */
@@ -656,6 +661,13 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static void process_mem_region(struct mem_vector *entry,
+	unsigned long minimum, unsigned long image_size)
+{
+	__process_mem_region(entry, minimum, image_size, CONFIG_PHYSICAL_ALIGN,
+		store_slot_info);
+}
+
 #ifdef CONFIG_EFI
 /*
  * Returns true if mirror region found (and must have been processed
-- 
2.7.4

