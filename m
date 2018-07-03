Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFE3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79507208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="dk5TjK/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79507208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeGCPP6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:15:58 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37075 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeGCPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so1868714qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAOvev/teZ5lXIBJGd21BS6gvQRoa6lUzarUFbC3suM=;
        b=dk5TjK/OCGk+DthILXggq/KPLMq8M8T/9LBB/hysxl6G3j6OKpcECLEVlLxR3U2Kat
         ZU1qCtwmTt6YhI7AyaFWVNCHRN1bw5OOIIsbp/ZjnE6uKoqx5KcDkwPrZ+cwb2dri/AD
         V6/TC32apQf4kM5kYIN0UkZN587YyDI8ocMnfo8qATyXRuQenYaDOO+9r7dGsNVce5xA
         L4gNvxrQDD0VkZ4YY/DZ4fROV2UAyhyUUMZYebtVCiGUr9dC54unfAtCLIfrDJQxNwtQ
         bImG2d5cBqqYMtLWc83oCnlbvxR8oJBIPY1Np6MZf5IXCg8sl/Ympq4JOprN7qTUvHRs
         vcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAOvev/teZ5lXIBJGd21BS6gvQRoa6lUzarUFbC3suM=;
        b=MvSejQcLyQid/FTU3RpXSnBSZW9MnqmL7OTepZliaf9ICbKpCnnTh7jKcbvH9HxejN
         sXamnT+SpEz9dtUduZbM1taB6C6/aVErie1q00kKyvdqndbwirlZaYRI8tpvOz8lq3vP
         WvOp579WDeOyqHUuXpcY2VIKhPMfersFYTSe/rPJYgs646lT+Omh98AGSYjPDvooqoMO
         SRR5lq1jrYgxz0AlV3LI1ESwx7F3ySIcuRhn8Se9jqQ+pglyAeSLS22F3JcDwufihqFR
         hhpybYx/Kh9/tYweDCrxaZ0P3kicifeDMcMmuyR+ynVYpRgEqv5MLSF72to/s9HWX/ri
         qVWw==
X-Gm-Message-State: APt69E3g5zvESUpsHzXRom4pmRISePL3S9pJum72m/mTqjE0ODTSObi5
        djfXd/yKYr6fYjXyvfeMHG9COQrS/Rs=
X-Google-Smtp-Source: AAOMgpfRAqcA96t4xBBsi1UaguX8n5rDrgmOAc5tvyzSiEUk6doHf/hJo0Zo25nEoRgJNxJwlzc2bg==
X-Received: by 2002:a0c:b39b:: with SMTP id t27-v6mr27046561qve.144.1530630929494;
        Tue, 03 Jul 2018 08:15:29 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u27-v6sm916782qkl.66.2018.07.03.08.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/14] skip readahead if the cgroup is congested
Date:   Tue,  3 Jul 2018 11:15:03 -0400
Message-Id: <20180703151503.2549-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

We noticed in testing we'd get pretty bad latency stalls under heavy
pressure because read ahead would try to do its thing while the cgroup
was under severe pressure.  If we're under this much pressure we want to
do as little IO as possible so we can still make progress on real work
if we're a throttled cgroup, so just skip readahead if our group is
under pressure.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/readahead.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index e273f0de3376..9f62b7151100 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -19,6 +19,7 @@
 #include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
+#include <linux/blk-cgroup.h>
 
 #include "internal.h"
 
@@ -505,6 +506,9 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
 		force_page_cache_readahead(mapping, filp, offset, req_size);
@@ -555,6 +559,9 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (inode_read_congested(mapping->host))
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* do read-ahead */
 	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
 }
-- 
2.14.3

