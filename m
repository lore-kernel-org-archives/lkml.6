Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E89C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8420855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXMFNcn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeIKEkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:40:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33471 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:40:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id b30-v6so8162845pla.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mK1ugpb/LCNhaDTIyoSauvWmhfcRUffOy8mLsBZJR5A=;
        b=gXMFNcn6Uhsq1Poo1ZFAUqIaW2IbJ/INlomS9949qdQEdHq+HaXa37/FmPUrchHLP9
         XsgeeVjxvdF+z/23Or2XnohMb5J1aPlYTfgh8SbJMW+hh7WpRrefoNZ6Pz3bfQTrXJ4D
         iuc88bA0mRkvfIR7kSBdx2DcQX6dWSd5Yu3I2X6W38GHLys7ka4WnIeQqmFU0vkV6z7H
         z/QU+FnT7DQZz7Pwpk66ztExDL6eQLrl5xZd0STWmRrUsrppfUPJIJlYb1j68PBtxzHH
         qeCB2tvhUlhqZ6RP71JTIU0PpoGYdesLPYQ5tYGmQKqc6cdiJr8dQX3oj4TsNlJ2JGEA
         9lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mK1ugpb/LCNhaDTIyoSauvWmhfcRUffOy8mLsBZJR5A=;
        b=iUFr0FwYxIGzp5VQBDOBTAd5FxcSB3MpnUfA/21cSK1IWP6AVWP+TNHU8csAnlL6/H
         oVM112emwanGuXjNjGgwGNR1n2ba7kJ+EMurDqVf0BL5Q4g56YDZnvE2lTPI59cPhyiW
         DGYf4VrzoGG1tDod+tJSytGBr16Im5HXCCxTqvmzVdUn1cBnr7vepln7wP5obCJWEqmV
         ZNzg4NTalEEJ4w3T660U4Sr6HD24zDCoYeeciD2PP3AAy55cX1/G/BOmX0zZJtpYxAr7
         r5CuurGfLCHuATXdC3a+3QSxSvViqFlOq/izEbp8cS/dIXEDt+kTvceumpg5mdG2T6Kr
         v0bA==
X-Gm-Message-State: APzg51Abxn9o8uOW7ALbeuLikHqGFrLtspDO4Dnjep2I9pTsjCXenjFz
        7FddS6fL+oH9fASSUTb4x10=
X-Google-Smtp-Source: ANB0VdaVXpJqV+58IBdRBFehwoJtL+fd7tHuuYHv5Y+GQ65svTqcpB8Q60RFqHEI56PxpPTtNWOn8w==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr24207713pld.145.1536623022977;
        Mon, 10 Sep 2018 16:43:42 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id d12-v6sm24980289pfk.69.2018.09.10.16.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:43:42 -0700 (PDT)
Subject: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Mon, 10 Sep 2018 16:43:41 -0700
Message-ID: <20180910234341.4068.26882.stgit@localhost.localdomain>
In-Reply-To: <20180910232615.4068.29155.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

On systems with a large amount of memory it can take a significant amount
of time to initialize all of the page structs with the PAGE_POISON_PATTERN
value. I have seen it take over 2 minutes to initialize a system with
over 12GB of RAM.

In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
the boot time returned to something much more reasonable as the
arch_add_memory call completed in milliseconds versus seconds. However in
doing that I had to disable all of the other VM debugging on the system.

In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
a system that has a large amount of memory I have added a new kernel
parameter named "page_init_poison" that can be set to "off" in order to
disable it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
 include/linux/page-flags.h                      |    8 ++++++++
 mm/debug.c                                      |   16 ++++++++++++++++
 mm/memblock.c                                   |    5 ++---
 mm/sparse.c                                     |    4 +---
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf54b974..7b21e0b9c394 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3047,6 +3047,14 @@
 			off: turn off poisoning (default)
 			on: turn on poisoning
 
+	page_init_poison=	[KNL] Boot-time parameter changing the
+			state of poisoning of page structures during early
+			boot. Used to verify page metadata is not accessed
+			prior to initialization. Available with
+			CONFIG_DEBUG_VM=y.
+			off: turn off poisoning
+			on: turn on poisoning (default)
+
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
 			timeout = 0: wait forever
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 74bee8cecf4c..d00216cf00f8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -162,6 +162,14 @@ static inline int PagePoisoned(const struct page *page)
 	return page->flags == PAGE_POISON_PATTERN;
 }
 
+#ifdef CONFIG_DEBUG_VM
+void page_init_poison(struct page *page, size_t size);
+#else
+static inline void page_init_poison(struct page *page, size_t size)
+{
+}
+#endif
+
 /*
  * Page flags policies wrt compound pages
  *
diff --git a/mm/debug.c b/mm/debug.c
index 38c926520c97..c5420422c0b5 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -175,4 +175,20 @@ void dump_mm(const struct mm_struct *mm)
 	);
 }
 
+static bool page_init_poisoning __read_mostly = true;
+
+static int __init page_init_poison_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+	return strtobool(buf, &page_init_poisoning);
+}
+early_param("page_init_poison", page_init_poison_param);
+
+void page_init_poison(struct page *page, size_t size)
+{
+	if (page_init_poisoning)
+		memset(page, PAGE_POISON_PATTERN, size);
+}
+EXPORT_SYMBOL_GPL(page_init_poison);
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/memblock.c b/mm/memblock.c
index 237944479d25..a85315083b5a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1444,10 +1444,9 @@ void * __init memblock_virt_alloc_try_nid_raw(
 
 	ptr = memblock_virt_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-#ifdef CONFIG_DEBUG_VM
 	if (ptr && size > 0)
-		memset(ptr, PAGE_POISON_PATTERN, size);
-#endif
+		page_init_poison(ptr, size);
+
 	return ptr;
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..67ad061f7fb8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -696,13 +696,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-#ifdef CONFIG_DEBUG_VM
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
-#endif
+	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
 
 	section_mark_present(ms);
 	sparse_init_one_section(ms, section_nr, memmap, usemap);

