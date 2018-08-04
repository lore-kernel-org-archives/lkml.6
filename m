Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC66C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3712178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqTHrmw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3712178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHDCiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:38:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42831 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeHDCiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:38:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so3567826pgp.9;
        Fri, 03 Aug 2018 17:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UGB6+KJKyvpiod2K1Al/7IkOHjlblgpNO9ZmO9jcR+g=;
        b=AqTHrmw6Fp8O5cbeOhymeHhZe01FXaGqIOfGx15Rth0A1t4p4RNWJUNpLO5oqkkyUP
         iX5qUJj+xq0iNNo+FQUsT1hZFhNBVT08Duq/Bl9G63qtdYxruQmTaJ8n5eBR7xz0P9CU
         Qg4HXCYcOxVn48buHrOeNtxrXpODwVF4+/jNaojes2W9vO17R0jrWRxO8RJ6xS3pfWt8
         QgDSUiswKtW5bL6COy9VYMtigQ3iL/o3CvwF71fOzwgRIzPsVOpbWnCbr45GtaUPXGZQ
         7qrUiPPDPM62YKXFakBxyNkJLNB5ts41fC2xea4r+NLVYCCva4MAuSONeXRM0MuTTza7
         2sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UGB6+KJKyvpiod2K1Al/7IkOHjlblgpNO9ZmO9jcR+g=;
        b=Uhu/iRrVMLVGSeYlq7ppu4pLSsaz8cEJgh3Sj7A2bGjNmzrzuuYs8eeuR5BWypqoyA
         0AM3T2OvoKocsyBGNSQsnSsViNyVBnWwAr0YA1ib187q0nkmHhDAL8WbdqnzvbETNGT5
         v9jG9eLgutP+54U4j956dymJQw4LeXxbHgerYPO90hhKQuLs8rEkNZs5Mq0IRBDDkLjS
         qCLwHi2qUTvDvBP2YovSnigred72e4QsGKcu9TDgF3Htz75SK/sPQwhNtoPG4xxUkHCb
         eh4dLEZezDCv6DGj35ubBI7q67YET6Isqr+PeaMZaVOIo7CiUvGKnQXPBUVoAwSUdCbm
         xTRw==
X-Gm-Message-State: AOUpUlHU59TQWHKgaa5pAjYitPtz75HWrASRUw8KmkQkyBWa2SmtHUuF
        lbYUDKE5rIcWmZEmwd3Crc0=
X-Google-Smtp-Source: AAOMgpcydZX1dRt1agoqaxt2EHnPW5Sr2xqAk+ZIIR7XX5P1e5TNyHV1ie7rANUK/pMp+53v+SfdyA==
X-Received: by 2002:a62:a119:: with SMTP id b25-v6mr6702039pff.163.1533343218746;
        Fri, 03 Aug 2018 17:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id f67-v6sm12968344pfe.75.2018.08.03.17.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:40:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     benve@cisco.com, _govind@gmx.com, pkaustub@cisco.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: cisco: enic: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Sat,  4 Aug 2018 08:40:09 +0800
Message-Id: <20180804004009.18928-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vnic_dev_register(), vnic_rq_alloc_bufs() and vnic_wq_alloc_bufs() 
are never called in atomic context.
They call kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/cisco/enic/vnic_dev.c | 2 +-
 drivers/net/ethernet/cisco/enic/vnic_rq.c  | 2 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index 76cdd4c9d11f..5c08c4519695 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -1071,7 +1071,7 @@ struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
 	unsigned int num_bars)
 {
 	if (!vdev) {
-		vdev = kzalloc(sizeof(struct vnic_dev), GFP_ATOMIC);
+		vdev = kzalloc(sizeof(struct vnic_dev), GFP_KERNEL);
 		if (!vdev)
 			return NULL;
 	}
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.c b/drivers/net/ethernet/cisco/enic/vnic_rq.c
index f8aa326d1d58..a3e7b003ada1 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.c
@@ -35,7 +35,7 @@ static int vnic_rq_alloc_bufs(struct vnic_rq *rq)
 	unsigned int blks = VNIC_RQ_BUF_BLKS_NEEDED(count);
 
 	for (i = 0; i < blks; i++) {
-		rq->bufs[i] = kzalloc(VNIC_RQ_BUF_BLK_SZ(count), GFP_ATOMIC);
+		rq->bufs[i] = kzalloc(VNIC_RQ_BUF_BLK_SZ(count), GFP_KERNEL);
 		if (!rq->bufs[i])
 			return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/cisco/enic/vnic_wq.c b/drivers/net/ethernet/cisco/enic/vnic_wq.c
index 090cc65658a3..eb75891974df 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_wq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_wq.c
@@ -35,7 +35,7 @@ static int vnic_wq_alloc_bufs(struct vnic_wq *wq)
 	unsigned int blks = VNIC_WQ_BUF_BLKS_NEEDED(count);
 
 	for (i = 0; i < blks; i++) {
-		wq->bufs[i] = kzalloc(VNIC_WQ_BUF_BLK_SZ(count), GFP_ATOMIC);
+		wq->bufs[i] = kzalloc(VNIC_WQ_BUF_BLK_SZ(count), GFP_KERNEL);
 		if (!wq->bufs[i])
 			return -ENOMEM;
 	}
-- 
2.17.0

