Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D62C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbtsjxzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D5A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKIQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKIQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so455915pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7S6I8bftQslxdirzJ9Dh7FpKhaSjYR8AwdNzVMTAb8=;
        b=Vbtsjxzc4u+FeISNSR2pYhK61DdEYtKpq4/sBiclUcKp28SAlJ/ebQ3kz6WgJ+sKSK
         rCwEvFupUmRMKzsfTzv5QEwSqqt/tiqAzHcdRNYObvLle7KPs+ufmMdRz9KcLjTQzLIN
         4BLFd49ItwISbR2Ov1n4VRukiCJZMv9CkhA6XEjDiDf6/KV7W4g30HpYD0xRa60G/Lbk
         Anzp3zCauT2LF2xV9SC0J4il0jh7HkSmo+a57gzmKuLNK/HwMjFLZ9vI9JbApHq+M3Ji
         +uWTgs/ssSFTjYL7TJtSfRPmB0ddAoRLVcZiH70dgCovCA+EjgpAwNvFgRBEP5X3bz/n
         DlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=N7S6I8bftQslxdirzJ9Dh7FpKhaSjYR8AwdNzVMTAb8=;
        b=D0YjBL5H/BFj+x5iwAmUhVrqnr4pl7K0mrIohC1o5PeFFiBMGPnKxaeD/aYp0VottK
         VLVYRFoP4gj94rjFNns1TUd4+nnqQ2E8pqx1F7ej1u4QaqaQc31AJZoAuac1cwv6m/wo
         lGXxJqRkvV2bKKsi5AQkXkGyqgG0l74TWiZPc+EhmuakHR/f+MbRbuNnlP1NuhYDaUlz
         snLozR6kdvu+nahAJ+oYAQYs8/Vqtp1c5PgwN2abxtTCFZ/Z5UMeGH5Crd8oINelnbMx
         P+BV67nGv9kTMSYAdaBrP4cb6OwWvA91hkgcGeppUW7IYO4RGtbJOFn+0Ms6rI6cr1bi
         J/zQ==
X-Gm-Message-State: AGRZ1gJqhqTG/GXEY3qBFPX72Cuu+T2UlbwzONeLSOGKHqrtXYzJuAQB
        7JLyxiiSwJlJFgcVBCIAqg==
X-Google-Smtp-Source: AJdET5fHJHDcr0dhGRXWOs+m/7KLTmuB661ydLhlRsy1qSm1ieXKAutd9hhcrekp6ruTbsy3J8cuUQ==
X-Received: by 2002:a63:e54d:: with SMTP id z13-v6mr6385719pgj.169.1541746069212;
        Thu, 08 Nov 2018 22:47:49 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:48 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 09/11] mm: hwpoison: apply buddy page handling code to hard-offline
Date:   Fri,  9 Nov 2018 15:47:13 +0900
Message-Id: <1541746035-13408-10-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hard-offline of free buddy pages can be handled in the same manner as
soft-offline. So this patch applies the new semantics to hard-offline to
more complete isolation of offlined page. As a result, the successful
case is worth MF_RECOVERED instead of MF_DELAYED, so this patch also
changes it.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index ecafd4a..af541141 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -772,6 +772,16 @@ static int me_swapcache_clean(struct page *p, unsigned long pfn)
 		return MF_FAILED;
 }
 
+static int me_huge_free_page(struct page *p)
+{
+	int rc = dissolve_free_huge_page(p);
+
+	if (!rc && set_hwpoison_free_buddy_page(p))
+		return MF_RECOVERED;
+	else
+		return MF_FAILED;
+}
+
 /*
  * Huge pages. Needs work.
  * Issues:
@@ -799,8 +809,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 		 */
 		if (PageAnon(hpage))
 			put_page(hpage);
-		dissolve_free_huge_page(p);
-		res = MF_RECOVERED;
+		res = me_huge_free_page(p);
 		lock_page(hpage);
 	}
 
@@ -1108,8 +1117,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 			}
 		}
 		unlock_page(head);
-		dissolve_free_huge_page(p);
-		action_result(pfn, MF_MSG_FREE_HUGE, MF_DELAYED);
+
+		res = me_huge_free_page(p);
+		if (res == MF_FAILED)
+			num_poisoned_pages_dec();
+		action_result(pfn, MF_MSG_FREE_HUGE, res);
 		return 0;
 	}
 
@@ -1270,6 +1282,13 @@ int memory_failure(unsigned long pfn, int flags)
 	p = pfn_to_page(pfn);
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
+
+	if (set_hwpoison_free_buddy_page(p)) {
+		action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
+		num_poisoned_pages_inc();
+		return 0;
+	}
+
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
@@ -1281,8 +1300,7 @@ int memory_failure(unsigned long pfn, int flags)
 
 	/*
 	 * We need/can do nothing about count=0 pages.
-	 * 1) it's a free page, and therefore in safe hand:
-	 *    prep_new_page() will be the gate keeper.
+	 * 1) it's a free page, and removed from buddy allocator.
 	 * 2) it's part of a non-compound high order page.
 	 *    Implies some kernel user: cannot stop them from
 	 *    R/W the page; let's pray that the page has been
@@ -1291,8 +1309,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	if (!get_hwpoison_page(p)) {
-		if (is_free_buddy_page(p)) {
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
+		if (set_hwpoison_free_buddy_page(p)) {
+			action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
 			return 0;
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
@@ -1330,8 +1348,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
-	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
+	if (!PageLRU(p) && set_hwpoison_free_buddy_page(p)) {
+		action_result(pfn, MF_MSG_BUDDY_2ND, MF_RECOVERED);
 		return 0;
 	}
 
-- 
2.7.0

