Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A779ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFF420693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbCjlvCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFF420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeGQUwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:52:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33365 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbeGQUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:52:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so953516plb.0;
        Tue, 17 Jul 2018 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n+tcrvSsv/jVLy4bZUNeVQU1Cz003tWDNHPuu4thCZg=;
        b=YbCjlvCxb+zdI4e26SgvHLhEkRyVz8NNjjFVHoSVs/AVlA2ozAb3R7ymBTy7zKoVDq
         W+iVyixizJtv1sMYuMY5mDJU6l2PP/+1azGl+RhSfXhQKi4wRGRhmkl770lmqBDNvQqE
         5vqEtrshM3FBrduhmtg30Pu3yw9dIX9LJ5X4zOy5ISRAIBzqMv5D8mFCXeiU8a2ckp0k
         2kRNSebOpae91BhP1GrC31ZkvuKNUny7DEj0PklpYICibXK81OW/0dV/M+i7iONfUCpb
         1KZ/BbBV2JVV42/yHVMx/DCf0xoBwnBJxcMAvx0opxIrA4ckZqiLNzUpzjf/qS109zjG
         h0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n+tcrvSsv/jVLy4bZUNeVQU1Cz003tWDNHPuu4thCZg=;
        b=Vv/KSCMlb640m9uFH17i5V8ZwjFOeWkOX61qJ95o2BpaABaDh/wVQ22Uo3JnvTJqWF
         eaYgGmYnzJY6nRt6hs2T8r3kHArixBjv/WaYb8s3ZDPLhE8tKuFXB7RNkO+qTv3o4v7L
         w2Df5Wr2Heg7AT6NhU/MreRCN5GWLn99FQiQIwGO+PzDlLtBLZ3L5tsHhKdjEy6kQSm8
         EE2aQyozy4zsBne6Y2JRkwtIkcdavuYowo9/fByF0YvXBy85cQrXxSlPlDaFoSMlnFRb
         y6HOfRxxdq60u8oG6TzqknxK+5bsQ/19YJMHp70Yo9excEdUD9osJU7Lz3uCw27hDyzg
         M3Ng==
X-Gm-Message-State: AOUpUlGjvYRog/jgBdOrsRSy7uv7a9EsOBct1H3nEit71F9hFLWA/S+B
        CUrtqcnBdWD1/Ppx3hXvIo3/wUwx
X-Google-Smtp-Source: AAOMgpfiYvcjQg9F5oSXxlMVj2jCyrUsmUYFbDmp+rlQByp0W8Bk3zKtXe+fQI4qfox4VhsA91fTSg==
X-Received: by 2002:a17:902:3281:: with SMTP id z1-v6mr3043763plb.226.1531858710268;
        Tue, 17 Jul 2018 13:18:30 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id k190-v6sm3098933pge.28.2018.07.17.13.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:18:29 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:remove static initialise null
Date:   Tue, 17 Jul 2018 23:04:01 +0530
Message-Id: <20180717173401.18024-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove checkpatch error due to initialization of static variables to
NULL

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 426e54a9d574..59fb66c0e064 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -100,8 +100,8 @@ static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
 static struct bio_set *pkt_bio_set;
 
-static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
-static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
+static struct class	*class_pktcdvd;    /* /sys/class/pktcdvd */
+static struct dentry	*pkt_debugfs_root; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
-- 
2.17.1

