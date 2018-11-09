Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4239120892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtY6fS79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4239120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKIQ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39106 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeKIQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so447913pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ow8luW8HYDT6HHVRhv0uM4c/Zk3Ha3snWz7rsKYzHxE=;
        b=BtY6fS79qUSUdw6odCyXzhzKyXYHFlr6NvBRMERuhh1hDraSjt9j2yKUwAcdCPoBwL
         InSqNelUnjXxU+6LCXKn7SpGfYcMOG8yE0yARiFGYBiswQdpIsZku38c9uJ/vm3IgUqg
         El054i/6UGk31S6MC8S7A5Dbe5tiS/gpatKTvbg/xY5q54NvWEh/JQFtj8njQioFGNoq
         L4nccfR2A0zdLaA1zV3E6Zgxku7jh1iE6AsS3fS39drBeYdcH8I/iOrrGIKmSzDU2Dze
         OO57mO51BTtIBzSC7NigXa0I1iivpaNXjMINi4rgfDjDA4ATYjyguXdO9xAgkb55jrIU
         lQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ow8luW8HYDT6HHVRhv0uM4c/Zk3Ha3snWz7rsKYzHxE=;
        b=IvZy11EVtnrWNPYk6Rwowv7dOFBhT3gUZAoqdS8kkxSK6Vbza74Va0B21NW5XiiIlA
         Y247KzzOC029UzGK+wijUe+up00EIqozt8WXm64KGlrv93bqsEktd4l4be7a+ZK2G/+E
         jQEx3EiZHEZfx1Yve77SwHryn/+FzmnBuJI0+fXssShn4NSXH6sPWgNsTCHJh55yJHNa
         nfVsTdLvdqKd/vK5itYxw1PZG+CFP0eoe6UL6xH9FEPQkfb6JrNaRRR9JjtbmDCODIZx
         f2FZfC9IXzgISKEcq5406gYFoMkdE68ab4YyJUIE1xL3BBCUbg/erPIGtyVCVc7oe2tc
         jV7A==
X-Gm-Message-State: AGRZ1gKTO3oePAkKKTHXEkxBeaUZi0KtGnzdeyUOPJ6yIid4FgErvqn6
        DP1ztI53DPjYwkWNG85sAg==
X-Google-Smtp-Source: AJdET5cxtRfw2ZsPktJ3kZ8sESWDSkNL6zBg8GtYQZpKC+5MmuXfzJ+4cSys4HwvLnrVSpRIDXh2/w==
X-Received: by 2002:a62:34c5:: with SMTP id b188-v6mr8125043pfa.65.1541746062460;
        Thu, 08 Nov 2018 22:47:42 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:41 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 06/11] mm: hwpoison: remove MF_COUNT_INCREASED
Date:   Fri,  9 Nov 2018 15:47:10 +0900
Message-Id: <1541746035-13408-7-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there's no user of MF_COUNT_INCREASED, so we can safely remove
all calling points.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 include/linux/mm.h  |  7 +++----
 mm/memory-failure.c | 16 +++-------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
index 22623ba..f85b450 100644
--- v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h
+++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
@@ -2725,10 +2725,9 @@ void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long nr_pages);
 
 enum mf_flags {
-	MF_COUNT_INCREASED = 1 << 0,
-	MF_ACTION_REQUIRED = 1 << 1,
-	MF_MUST_KILL = 1 << 2,
-	MF_SOFT_OFFLINE = 1 << 3,
+	MF_ACTION_REQUIRED = 1 << 0,
+	MF_MUST_KILL = 1 << 1,
+	MF_SOFT_OFFLINE = 1 << 2,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index 11e283e..ed347f8 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -1094,7 +1094,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1290,7 +1290,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
 			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
 			return 0;
@@ -1331,10 +1331,7 @@ int memory_failure(unsigned long pfn, int flags)
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
 	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
-		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
+		action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
 		return 0;
 	}
 
@@ -1622,9 +1619,6 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 {
 	int ret;
 
-	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
 	/*
 	 * When the target page is a free hugepage, just remove it
 	 * from free hugepage list.
@@ -1906,15 +1900,11 @@ int soft_offline_page(struct page *page, int flags)
 	if (is_zone_device_page(page)) {
 		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
 				pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
 		return -EIO;
 	}
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_hwpoison_page(page);
 		return -EBUSY;
 	}
 
-- 
2.7.0

