Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CBFC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285BD2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="TJ+uTx5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285BD2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeJHGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41309 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeJHGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so6700906qtl.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEEqfvkw1I9tFvFaX8GvqLlehC3qvmeeopO1s4P8jGE=;
        b=TJ+uTx5rdz4nAZNebJilZJ3eME3EA0fgKkZPq19X8YIScVJGVuad3wUKUrnaulLa94
         ZXVKp7IoqA71x0ScCdkmxolMLnYyUo7ccSPca9a3vR3ln3/xGmsgpvhMtKY9EvkNL//R
         sww/1FaJEaOqORCyzrfecUIE/aq4EeOOtbaWLiVv0Za4K/EaWh71Qr/UMvBPQmPDe9Tw
         wYyK+dEC2cGPePHw1InVR9AiZrSe2ae7LEHk73nIjkjvKzfkh1yLBMYXR92oLCTSk3CD
         lkYqJwcBy9zZr3qgh+MtdjQ/36F83bzKyINbKVTx4EIbx1F2es0VrQMUenqjvM5aUKCo
         BB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEEqfvkw1I9tFvFaX8GvqLlehC3qvmeeopO1s4P8jGE=;
        b=lpjI2mrZWPer6KzPXqBh0oOELnr6cuEAEMglOvRkBCniHX2ZPZR1KBubhpVXJaajnB
         fUXIYLgpUYa/Wvg+mc41XMig4NPfsGRz/0IIXrSDqn5B9LCORuNmQTXGV8AseeBONBvq
         xoecREpoL0TwGrTj6Q0grvaPOeWPpAJb9cZAWc2nUNHJVtakSxTgnJriit5IuxMuCKaS
         nPKvjeQ8EWwujl/vHvDI6B2TZShD4QCnYphSIyuQfyNKFOQRZurnue9gGsbXyALzNbiz
         pMPNjTZ6XwSa3lxc20LznErpg2qA727mEZqPld6AAk1EohKFd6NUZeWpik2b+2W1Z6eG
         9/MA==
X-Gm-Message-State: ABuFfojY0qIPfkE55m1ce4oIriUX/JoFKWgQmiQboTefGnMIZ3gQahs7
        NzetpEX4A+BEtO9A7RHhwh49mA==
X-Google-Smtp-Source: ACcGV616Uoc3udfqnKnDHX2GuW7fVQAgzgGm54XYAk8txWAB6a+MV8M30aqV7ao2luAN7kRNwugdYg==
X-Received: by 2002:a0c:d267:: with SMTP id o36mr3349885qvh.235.1538954899350;
        Sun, 07 Oct 2018 16:28:19 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:18 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 18/19] orangefs: use client-core buffer size to determine writepages count
Date:   Sun,  7 Oct 2018 23:27:35 +0000
Message-Id: <20181007232736.3780-19-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous fixed count of 128 was arbitrary.

I see about a 10% performance increase on large block size I/O since
the count is now 1024 (given the default four megabyte client-core
buffer).

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 9a41b7d2ce54..20950f3f758a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -15,8 +15,6 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
-#define ORANGEFS_WRITEPAGES_COUNT 128
-
 static int orangefs_writepage_locked(struct page *page,
     struct writeback_control *wbc)
 {
@@ -237,9 +235,10 @@ struct orangefs_writepages {
 	size_t len;
 	kuid_t uid;
 	kgid_t gid;
-	struct page *pages[ORANGEFS_WRITEPAGES_COUNT];
+	int maxpages;
 	int npages;
-	struct bio_vec bv[ORANGEFS_WRITEPAGES_COUNT];
+	struct page **pages;
+	struct bio_vec *bv;
 };
 
 static int orangefs_writepages_work(struct orangefs_writepages *ow,
@@ -324,7 +323,7 @@ static int orangefs_writepages_callback(struct page *page,
 		}
 		if (!uid_eq(ow->uid, wr->uid) || !gid_eq(ow->gid, wr->gid)) {
 			orangefs_writepages_work(ow, wbc);
-			memset(ow, 0, sizeof *ow);
+			ow->npages = 0;
 			ret = -1;
 			goto done;
 		}
@@ -340,9 +339,9 @@ static int orangefs_writepages_callback(struct page *page,
 			mapping_set_error(page->mapping, ret);
 			unlock_page(page);
 		} else {
-			if (ow->npages == ORANGEFS_WRITEPAGES_COUNT) {
+			if (ow->npages == ow->maxpages) {
 				orangefs_writepages_work(ow, wbc);
-				memset(ow, 0, sizeof *ow);
+				ow->npages = 0;
 			}
 		}
 	}
@@ -358,6 +357,18 @@ static int orangefs_writepages(struct address_space *mapping,
 	ow = kzalloc(sizeof(struct orangefs_writepages), GFP_KERNEL);
 	if (!ow)
 		return -ENOMEM;
+	ow->maxpages = orangefs_bufmap_size_query()/PAGE_SIZE;
+	ow->pages = kcalloc(ow->maxpages, sizeof(struct page *), GFP_KERNEL);
+	if (!ow->pages) {
+		kfree(ow);
+		return -ENOMEM;
+	}
+	ow->bv = kcalloc(ow->maxpages, sizeof(struct bio_vec), GFP_KERNEL);
+	if (!ow->bv) {
+		kfree(ow->pages);
+		kfree(ow);
+		return -ENOMEM;
+	}
 	mutex_lock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
 	blk_start_plug(&plug);
 	ret = write_cache_pages(mapping, wbc, orangefs_writepages_callback, ow);
@@ -365,6 +376,8 @@ static int orangefs_writepages(struct address_space *mapping,
 		ret = orangefs_writepages_work(ow, wbc);
 	blk_finish_plug(&plug);
 	mutex_unlock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
+	kfree(ow->pages);
+	kfree(ow->bv);
 	kfree(ow);
 	return ret;
 }
-- 
2.19.0

