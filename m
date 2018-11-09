Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B845B20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3fUO3sG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B845B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeKIQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45083 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeKIQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id p17-v6so478040pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m0e0f9nzNxyxhpTcBsr3tCvUPNiuZ+bV+28ICuX+JQY=;
        b=f3fUO3sGOcfSkELF9VhwEATDLBjrZFtcbQKPtLzgiXaaYkML+7ejQCSpk2OalDEGzH
         lGsQBO43VDXY1NSNNnMO1qYjoh8fvUjH4AxaVhvqn7WvR3CnMtDmZEfFEnRmGcPpgDqC
         l2E0WUeLgN5ZFbJ8VY0FtBUpgdrOvxiFuiVOlSb+O3z73r9ia4od8Oi1C33rlMuxct/x
         izmo4xhtAIVtMDAESf57lGJHicM4lMWhwPvIPf6G7cWacr82ehZCx1aoBkBPvz7fyVBW
         MM1DWevtTcBipdEwBQxYder+tGsTmNtEVTb5ibLZOs4J6Gldrw5EujN9T9ZkOE2iEjmu
         A4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=m0e0f9nzNxyxhpTcBsr3tCvUPNiuZ+bV+28ICuX+JQY=;
        b=gwLWSJCRdJzYVpiWShBwIO3KMiDRVaQXMAPtFgbmG4aypaQYol4hXgafhh9C7B9l14
         FvW5cLpr+8GrPGSIGc6mAU9HcZFdPLOA3RDJs7Zc+99M7u9V7iAZF7yW1nZTAnfh1XmC
         JJQXWC2J6LQvktmnFpEWBm75La7ToIybOjutWxQTJ2fLPostVKmZOWoFRctgOGly98WW
         2j0jsLwd2BwkinwoXSa9tvpPT8HHzduq+OHFiEUnR/I8gCDGQWsS3rjRsPChv808o3Bw
         3BYGzAH92HnobTgef27JeEDHEv0U5p0Tiq7kNLegQuCjIyu+v0Ytm1gXp6Dw0UmE4/kF
         1xTg==
X-Gm-Message-State: AGRZ1gIVBHgTMaqBnUDkd/uTs3nH5zKTyuEl4jNvt7QRiYoCOMPAv6Yr
        psPppsIoBHgWgTQDYJ70v5SZR+tewA==
X-Google-Smtp-Source: AJdET5eQnu/2Z9HBZ98qfYLw+/ijhzOTROzAPjFfw2esGCkLFwrTpsn+UNpgSRk7SDYzPGhWflz7YA==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr6399252pgb.66.1541746057988;
        Thu, 08 Nov 2018 22:47:37 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:37 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 04/11] mm: madvise: call soft_offline_page() without MF_COUNT_INCREASED
Date:   Fri,  9 Nov 2018 15:47:08 +0900
Message-Id: <1541746035-13408-5-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently madvise_inject_error() pins the target page when calling
memory error handler, but it's not good because the refcount is just
an artifact of error injector and mock nothing about hw error itself.
IOW, pinning the error page is part of error handler's task, so
let's stop doing it.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/madvise.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/madvise.c v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
index 6cb1ca9..9fa0225 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/madvise.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
@@ -637,6 +637,16 @@ static int madvise_inject_error(int behavior,
 		ret = get_user_pages_fast(start, 1, 0, &page);
 		if (ret != 1)
 			return ret;
+		/*
+		 * The get_user_pages_fast() is just to get the pfn of the
+		 * given address, and the refcount has nothing to do with
+		 * what we try to test, so it should be released immediately.
+		 * This is racy but it's intended because the real hardware
+		 * errors could happen at any moment and memory error handlers
+		 * must properly handle the race.
+		 */
+		put_page(page);
+
 		pfn = page_to_pfn(page);
 
 		/*
@@ -646,16 +656,11 @@ static int madvise_inject_error(int behavior,
 		 */
 		order = compound_order(compound_head(page));
 
-		if (PageHWPoison(page)) {
-			put_page(page);
-			continue;
-		}
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 					pfn, start);
 
-			ret = soft_offline_page(page, MF_COUNT_INCREASED);
+			ret = soft_offline_page(page, 0);
 			if (ret)
 				return ret;
 			continue;
@@ -663,14 +668,6 @@ static int madvise_inject_error(int behavior,
 
 		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
-
-		/*
-		 * Drop the page reference taken by get_user_pages_fast(). In
-		 * the absence of MF_COUNT_INCREASED the memory_failure()
-		 * routine is responsible for pinning the page to prevent it
-		 * from being released back to the page allocator.
-		 */
-		put_page(page);
 		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
-- 
2.7.0

