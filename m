Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F33C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5B208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsDhtFGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E5B208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbeIYVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:44:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34443 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbeIYVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:44:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id 80-v6so2603142qkj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XGK6fptIFX5w28HkvYDbujSCehR2SgbbRAuYHW9cCO4=;
        b=AsDhtFGybEYiZ7vlChRYgfPLS8p4zxURidmslHjc1MTf+dAYgVGYv0RMWduAY6K2Sf
         +TQFfkeddhKAUVNgkV02vu1oHFgCXLxx83Z9FOIYUYhhK3lixQ2YxwEzrEgWIjBTLXLh
         eD6ECF5iEFio1QB+CUiVzEu12sDxphi+h3m/IXxFDKYd4KlRq+LQ17Sa9ooP2fIQ9V3M
         WhDCXc3NFd2wijpqp52sLhoaWauQ41XqWsj8Cf+YhJy0cTkfDMZtvbtc/Ir2+nK75NLh
         qNXWL41+nTMtmvNE0G7R5CopT5hmhsU0B2cvmuGlzd32kbDmP98s313EH7zytJCBEDES
         0chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XGK6fptIFX5w28HkvYDbujSCehR2SgbbRAuYHW9cCO4=;
        b=fzDni/q4zqLIT8G1jC7WJa65/QbqAyWEIKXYZV7BunMSAzvOdaUffKy1egoJ8kYjgq
         s/R8dZM0tmthsOPnuM6qRmY5BmsW47N+mApsgQ38yXdzFl0GnIa4Ny9VPtKV4vjPIDRn
         y+dT6SuUzm6xYXwpwU4je7Ukpd4RxWX8JECPuJEziXBvKHEwqP/08FzvW+jU3P9KgC0h
         19Fm7K2gZ7QW4EAU4sBRJbGOHud/lOA/gPIMn5bhryhXsRogd0wXzaFcPtd/LQQrIlYy
         BpwraP6FunUq0CFMe3BhghyzBKXeqnTIeb6QXuF21mLni5LkgIRtWRlzwDFXKUHCgqfe
         3U8w==
X-Gm-Message-State: ABuFfogRVmyNWJVZkqwj9tuNdSf9q+FVqtgPNhvh66wSa0RI06fzURjx
        SDz1Vgs2qin+DsSaqMQEmA==
X-Google-Smtp-Source: ACcGV62FU9dOFkB9rBQomIyHek5dpMz2ir1A4bcVo/+X23elJCJHE/m0gUQNxP46/v3HBzZXYpPaAA==
X-Received: by 2002:a37:1a59:: with SMTP id a86-v6mr1137670qka.191.1537889759160;
        Tue, 25 Sep 2018 08:35:59 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p18-v6sm2056304qtp.3.2018.09.25.08.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:35:58 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 3/3] mm: return zero_resv_unavail optimization
Date:   Tue, 25 Sep 2018 11:35:32 -0400
Message-Id: <20180925153532.6206-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925153532.6206-1-msys.mizuma@gmail.com>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
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
Reviewed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
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

