Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704CAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91219214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZt8x//N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91219214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJIXqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36002 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeJIXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so2668041wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zJ7OvqIOhFG8Bz6ToLDYZc8ULkE9qZBoiGR2ew5iWI=;
        b=pZt8x//NrkFuhjVehpioRUjXgCZTjbsbsSNpUyEOHlC4+zj19DgRDsOEK0qf22KvPt
         QjaYLde7EXvZOuKxL/uAWxbOlAzBMvHaXNmHlEE/S1aQqHOpX3PxR9pqBl2VI9CDtfLs
         pyUoO2dTGLCdqMrn7+amq6nHnenveVk+Ha8qjnWpq0u4EHuQY+AWcz+MaC8thj1XXOL+
         eW7Bp222wMRQ18rotNEXdI2wFPyaR6dplL/ThmJ6qXzqh/8/e6QfVisu3BsSweWlpMa2
         a8+8/Ef+SZQocksYemWB6yfefrEU6HwJoWSQIpYKPHwOPrn/sy03vzXWiBFrF/pxTh9d
         J3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zJ7OvqIOhFG8Bz6ToLDYZc8ULkE9qZBoiGR2ew5iWI=;
        b=SEKKkWHqbyxTF2HKH7kx07p+MzuTDhMuusmlmU6roqgUbZtkr/OuBFFL65e8or2VCx
         Y2Zg0s3afT4jRdwbQC3EyK88JyD2iUtqJycNf76bZMeYB4ARMLdCyCeNERTnhfVONDb9
         AatveXQjimWbYKFgYtVDPzpF6M5KRzC6EsRwVpVHi/w4DQ3wvDljo34vRvasRF6ixEFn
         pQRcIsETS0ioJ32du6ra24viF9W+WEV4nZZMZW6W/u4zCWWnpD1lg+gUGDZ293QPjyIo
         +r1o1x37L7QXzS0qPr4NIizodZ6T6Gt+NGffOaLpfuj1LnuVKbNhsG2SEqGwT1pj7DTc
         3eAw==
X-Gm-Message-State: ABuFfohbx+JN99PbfQIErG0fSi/I5Y/UkiJieP9/gvd5LxFRHNJkLuek
        o+1u/KUiksnaEuUgajGZT2o=
X-Google-Smtp-Source: ACcGV635AwpCFnQP4ETlrPMnP+wClD2blsFuabDlJ15FUZV4f5rLLCmYXbVjbYbY2AEZpAl7m02TrA==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr2463610wme.125.1539102539200;
        Tue, 09 Oct 2018 09:28:59 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:58 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 13/18] RDMA/qedr: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:12 +0300
Message-Id: <20181009162817.4635-14-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/qedr/main.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index cd7b8b39a129..ae7b28e4a475 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -133,12 +133,18 @@ static int qedr_iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	return 0;
 }
 
+static struct ib_device_ops qedr_iw_dev_ops = {
+	.query_gid		= qedr_iw_query_gid,
+	.get_port_immutable	= qedr_iw_port_immutable,
+};
+
 static int qedr_iw_register_device(struct qedr_dev *dev)
 {
 	dev->ibdev.node_type = RDMA_NODE_RNIC;
 	dev->ibdev.query_gid = qedr_iw_query_gid;
 
 	dev->ibdev.get_port_immutable = qedr_iw_port_immutable;
+	ib_set_device_ops(&dev->ibdev, &qedr_iw_dev_ops);
 
 	dev->ibdev.iwcm = kzalloc(sizeof(*dev->ibdev.iwcm), GFP_KERNEL);
 	if (!dev->ibdev.iwcm)
@@ -159,13 +165,57 @@ static int qedr_iw_register_device(struct qedr_dev *dev)
 	return 0;
 }
 
+static struct ib_device_ops qedr_roce_dev_ops = {
+	.get_port_immutable	= qedr_roce_port_immutable,
+};
+
 static void qedr_roce_register_device(struct qedr_dev *dev)
 {
 	dev->ibdev.node_type = RDMA_NODE_IB_CA;
 
 	dev->ibdev.get_port_immutable = qedr_roce_port_immutable;
+	ib_set_device_ops(&dev->ibdev, &qedr_roce_dev_ops);
 }
 
+static struct ib_device_ops qedr_dev_ops = {
+	.query_device		= qedr_query_device,
+	.query_port		= qedr_query_port,
+	.modify_port		= qedr_modify_port,
+	.alloc_ucontext		= qedr_alloc_ucontext,
+	.dealloc_ucontext	= qedr_dealloc_ucontext,
+	.mmap			= qedr_mmap,
+	.alloc_pd		= qedr_alloc_pd,
+	.dealloc_pd		= qedr_dealloc_pd,
+	.create_cq		= qedr_create_cq,
+	.destroy_cq		= qedr_destroy_cq,
+	.resize_cq		= qedr_resize_cq,
+	.req_notify_cq		= qedr_arm_cq,
+	.create_qp		= qedr_create_qp,
+	.modify_qp		= qedr_modify_qp,
+	.query_qp		= qedr_query_qp,
+	.destroy_qp		= qedr_destroy_qp,
+	.create_srq		= qedr_create_srq,
+	.destroy_srq		= qedr_destroy_srq,
+	.modify_srq		= qedr_modify_srq,
+	.query_srq		= qedr_query_srq,
+	.post_srq_recv		= qedr_post_srq_recv,
+	.query_pkey		= qedr_query_pkey,
+	.create_ah		= qedr_create_ah,
+	.destroy_ah		= qedr_destroy_ah,
+	.get_dma_mr		= qedr_get_dma_mr,
+	.dereg_mr		= qedr_dereg_mr,
+	.reg_user_mr		= qedr_reg_user_mr,
+	.alloc_mr		= qedr_alloc_mr,
+	.map_mr_sg		= qedr_map_mr_sg,
+	.poll_cq		= qedr_poll_cq,
+	.post_send		= qedr_post_send,
+	.post_recv		= qedr_post_recv,
+	.process_mad		= qedr_process_mad,
+	.get_netdev		= qedr_get_netdev,
+	.get_link_layer		= qedr_link_layer,
+	.get_dev_fw_str		= qedr_get_dev_fw_str,
+};
+
 static int qedr_register_device(struct qedr_dev *dev)
 {
 	int rc;
@@ -261,6 +311,8 @@ static int qedr_register_device(struct qedr_dev *dev)
 	dev->ibdev.get_link_layer = qedr_link_layer;
 	dev->ibdev.get_dev_fw_str = qedr_get_dev_fw_str;
 
+	ib_set_device_ops(&dev->ibdev, &qedr_dev_ops);
+
 	dev->ibdev.driver_id = RDMA_DRIVER_QEDR;
 	return ib_register_device(&dev->ibdev, "qedr%d", NULL);
 }
-- 
2.14.4

