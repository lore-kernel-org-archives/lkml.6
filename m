Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6822ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C06214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFSQBFV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C06214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJIXq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeJIXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so2521456wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZx3t7q+UnozZRruXST7lP2ZXEpIQkkgwHA6Q+6HcUY=;
        b=LFSQBFV4ws9OeUpCStW9Wbq9DT2JTXUX2aIcxQW9lZ346CXnYYSsFNbWAkiPHmBFCn
         GkfZLQZr82BWAK7aiZybd4bWEe6T3emUEVvyEARPtnEd1d0uJ4XQK+gP+FtxSfqHVyq9
         vdtPIl8339LwyvgtpkZQkcBfl1DsTSwBtvpLKWAjDgdLc4w4hFH5uEFhaoj54uglvDv4
         7B01qb+WtofS2JhkhbWaLhiNpgKNzpj4tRu4NrvpxCXlJNVaPHIaqfA7NpdSQRv6XCGu
         bvScBEiMfCfJTmwMJAnmknv4y0QCqo9uFTZr5Ega4uZJcJaSZP7KMLyZYLkF3Gt3OTp+
         bUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bZx3t7q+UnozZRruXST7lP2ZXEpIQkkgwHA6Q+6HcUY=;
        b=hP+g9Fmsl4xeYYGiCL53PQVBgV88uydutakcT5xydcBrdtqJQKdFbHqazLon9vfzzX
         zxqt9Xb6OX2zcYUu63iaM/Bw6PRnhEKosI5aI1P6P+TDn2RnMDhEcLbe4vMI9tE2yFvU
         0HezysZsEAd5vB+hmQZOIuqITbyAE50SRt5sYh5/StKj0vYGNi34qYGVUpM0V0O/gsJY
         JH7z5SplbCk1sZvtYKyZ40H4TXU7DfWBtpX7TMG9+uqhSMv3mICpUhh6mkuCqZp3Gzem
         +3SzkXFLH4u2u8Uw4ZSzLFUgNCaZuzXqowyXoEwfkBm5Ps7cm4tKOz9tUg5il/mIRuq3
         U6Tw==
X-Gm-Message-State: ABuFfohyg7QFnj4N6mhNPcr4NIsO4ZN1I36uAOLhIkfZdr/zvJszXDvD
        zuvRPh7hUYE86ct66YgyBLYKn1QI
X-Google-Smtp-Source: ACcGV63q/LCuBS2TzVijrIBstU2jwdIfa5oMrl6L1Pc6WluqA+LZ5zGvmGAn7xe82oMLRbmP7iIBQw==
X-Received: by 2002:adf:9304:: with SMTP id 4-v6mr19745912wro.129.1539102542977;
        Tue, 09 Oct 2018 09:29:02 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:02 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 16/18] RDMA/vmw_pvrdma: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:15 +0300
Message-Id: <20181009162817.4635-17-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009162817.4635-1-kamalheib1@gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize ib_device_ops with the supported operations.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index c1e31985b11c..25d494ce2d7d 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -157,6 +157,49 @@ static struct net_device *pvrdma_get_netdev(struct ib_device *ibdev,
 	return netdev;
 }
 
+static struct ib_device_ops pvrdma_dev_ops = {
+	.query_device		= pvrdma_query_device,
+	.query_port		= pvrdma_query_port,
+	.query_gid		= pvrdma_query_gid,
+	.query_pkey		= pvrdma_query_pkey,
+	.modify_port		= pvrdma_modify_port,
+	.alloc_ucontext		= pvrdma_alloc_ucontext,
+	.dealloc_ucontext	= pvrdma_dealloc_ucontext,
+	.mmap			= pvrdma_mmap,
+	.alloc_pd		= pvrdma_alloc_pd,
+	.dealloc_pd		= pvrdma_dealloc_pd,
+	.create_ah		= pvrdma_create_ah,
+	.destroy_ah		= pvrdma_destroy_ah,
+	.create_qp		= pvrdma_create_qp,
+	.modify_qp		= pvrdma_modify_qp,
+	.query_qp		= pvrdma_query_qp,
+	.destroy_qp		= pvrdma_destroy_qp,
+	.post_send		= pvrdma_post_send,
+	.post_recv		= pvrdma_post_recv,
+	.create_cq		= pvrdma_create_cq,
+	.destroy_cq		= pvrdma_destroy_cq,
+	.poll_cq		= pvrdma_poll_cq,
+	.req_notify_cq		= pvrdma_req_notify_cq,
+	.get_dma_mr		= pvrdma_get_dma_mr,
+	.reg_user_mr		= pvrdma_reg_user_mr,
+	.dereg_mr		= pvrdma_dereg_mr,
+	.alloc_mr		= pvrdma_alloc_mr,
+	.map_mr_sg		= pvrdma_map_mr_sg,
+	.add_gid		= pvrdma_add_gid,
+	.del_gid		= pvrdma_del_gid,
+	.get_netdev		= pvrdma_get_netdev,
+	.get_port_immutable	= pvrdma_port_immutable,
+	.get_link_layer		= pvrdma_port_link_layer,
+	.get_dev_fw_str		= pvrdma_get_fw_ver_str,
+};
+
+static struct ib_device_ops pvrdma_dev_srq_ops = {
+	.create_srq		= pvrdma_create_srq,
+	.modify_srq		= pvrdma_modify_srq,
+	.query_srq		= pvrdma_query_srq,
+	.destroy_srq		= pvrdma_destroy_srq,
+};
+
 static int pvrdma_register_device(struct pvrdma_dev *dev)
 {
 	int ret = -1;
@@ -228,6 +271,8 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	dev->ib_dev.get_link_layer = pvrdma_port_link_layer;
 	dev->ib_dev.get_dev_fw_str = pvrdma_get_fw_ver_str;
 
+	ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_ops);
+
 	mutex_init(&dev->port_mutex);
 	spin_lock_init(&dev->desc_lock);
 
@@ -256,6 +301,7 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 		dev->ib_dev.modify_srq = pvrdma_modify_srq;
 		dev->ib_dev.query_srq = pvrdma_query_srq;
 		dev->ib_dev.destroy_srq = pvrdma_destroy_srq;
+		ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_srq_ops);
 
 		dev->srq_tbl = kcalloc(dev->dsr->caps.max_srq,
 				       sizeof(struct pvrdma_srq *),
-- 
2.14.4

