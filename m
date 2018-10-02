Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BB3C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603702083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdFlEFy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603702083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeJBVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38344 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so2159345qtf.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LCUMo2ZJDotHi4uZkUbq2fSulQUn+KtjDHJVxfuaADc=;
        b=FdFlEFy73J3odd6Ml0HOJqMATdOam+eYxQdqv1N/reSCKQvxQr2MDkJwqKvUN7eufe
         Wsmbz8lJIuAE0NIyLrsLWbVGhtxpuBu60TIFloUSnjwNDiWEk4+Iub6JOGQMeuntpRzd
         1Z9uqNRYIP3htCqRzoIP1c5hHg/77M7n2+7Q7/A4Ub9Lcw6bCc1fTHvELtrFX/vo1dHt
         E95yBchChfPH0y8PnLej0XLls6YDgRhhbgHiyZfOWaNjOuTpxAGhQMpxR79na1Ku0NBB
         XU9D3cGpYIhUWP6GzyyIEKITrHRGvR2dvzBJNjTcf7YEC5s7T6UrMaOxFxLBimbbm3Md
         bMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LCUMo2ZJDotHi4uZkUbq2fSulQUn+KtjDHJVxfuaADc=;
        b=tT0NSDZ1xnRzn2Dsld7R9cL46EVK/YlYpRexERqH+k7lCuErZMKGZffe0nauZgs5zR
         UWcnxjJ6W0XYQXork1S2TwzwTtqQv0mOU6jI4qq7L4B9BmKQ8w4KP+QeeZRVRg88+u6e
         AONlMnc30B2qe4zxbGN/vYof2Nbr2Yl/aCUjatLGvLIpuwUL3D++F6Y0dljnPavIic31
         IbvWSjbjYishZyZRvBLGKuRxmZQ8JWBv5HzY9fddM6hLv75m40iCH9xfI6Hs6Q1xWUo1
         TNTUb0bVCKkFY4segVL8zZJe/W6fMueHGM1EynWLLL3G8dGwqz3+23TI8r9Go+6lgIKh
         iPSw==
X-Gm-Message-State: ABuFfogZOVc0jv70ctKtvl/L0knqssQHP9iMhvC6k4e8fa/sNKyySssY
        6C7eamon7cfrhNqw6rA2NQ==
X-Google-Smtp-Source: ACcGV60RAitDTP1cP7/L+DkixKLYwudAYhrUIRcChfTK8Pu2a1gFdSI9QgzUFTzoz0I5xXe9jowgyw==
X-Received: by 2002:a0c:b3d6:: with SMTP id b22-v6mr12519823qvf.203.1538491115612;
        Tue, 02 Oct 2018 07:38:35 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y20-v6sm5257538qkb.46.2018.10.02.07.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:38:35 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 2/3] mm: return zero_resv_unavail optimization
Date:   Tue,  2 Oct 2018 10:38:20 -0400
Message-Id: <20181002143821.5112-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002143821.5112-1-msys.mizuma@gmail.com>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pavel.tatashin@microsoft.com>

When checking for valid pfns in zero_resv_unavail(), it is not necessary to
verify that pfns within pageblock_nr_pages ranges are valid, only the first
one needs to be checked. This is because memory for pages are allocated in
contiguous chunks that contain pageblock_nr_pages struct pages.

Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/page_alloc.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b9d89e..bd5b7e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6440,6 +6440,29 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
 }
 
 #if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
+
+/*
+ * Zero all valid struct pages in range [spfn, epfn), return number of struct
+ * pages zeroed
+ */
+static u64 zero_pfn_range(unsigned long spfn, unsigned long epfn)
+{
+	unsigned long pfn;
+	u64 pgcnt = 0;
+
+	for (pfn = spfn; pfn < epfn; pfn++) {
+		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
+			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
+				+ pageblock_nr_pages - 1;
+			continue;
+		}
+		mm_zero_struct_page(pfn_to_page(pfn));
+		pgcnt++;
+	}
+
+	return pgcnt;
+}
+
 /*
  * Only struct pages that are backed by physical memory are zeroed and
  * initialized by going through __init_single_page(). But, there are some
@@ -6455,7 +6478,6 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
 void __init zero_resv_unavail(void)
 {
 	phys_addr_t start, end;
-	unsigned long pfn;
 	u64 i, pgcnt;
 	phys_addr_t next = 0;
 
@@ -6465,34 +6487,18 @@ void __init zero_resv_unavail(void)
 	pgcnt = 0;
 	for_each_mem_range(i, &memblock.memory, NULL,
 			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
-		if (next < start) {
-			for (pfn = PFN_DOWN(next); pfn < PFN_UP(start); pfn++) {
-				if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
-					continue;
-				mm_zero_struct_page(pfn_to_page(pfn));
-				pgcnt++;
-			}
-		}
+		if (next < start)
+			pgcnt += zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
 		next = end;
 	}
-	for (pfn = PFN_DOWN(next); pfn < max_pfn; pfn++) {
-		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
-			continue;
-		mm_zero_struct_page(pfn_to_page(pfn));
-		pgcnt++;
-	}
-
+	pgcnt += zero_pfn_range(PFN_DOWN(next), max_pfn);
 
 	/*
 	 * Struct pages that do not have backing memory. This could be because
 	 * firmware is using some of this memory, or for some other reasons.
-	 * Once memblock is changed so such behaviour is not allowed: i.e.
-	 * list of "reserved" memory must be a subset of list of "memory", then
-	 * this code can be removed.
 	 */
 	if (pgcnt)
 		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
-
 }
 #endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
 
-- 
2.18.0

