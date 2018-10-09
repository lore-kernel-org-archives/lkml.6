Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF06EECDE49
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EA4214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqi92kXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA4214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJIXqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36171 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJIXqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so2523240wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7vpRjs4HnVzSUO+t3h2x028FfZuTWcDxrvni65rb60=;
        b=lqi92kXjjdcGtyYFjrUckCESohoASKIlDvF7AhVwBNZd2diTC1Ilq7HZSF73H6L7yr
         gecj6dYhhAtstSomAFdGQ7GRVp/Dk43IJgWUZgG+/XvmjIrA3fGc/YguUO6j4mHvv8DZ
         EAtQSo3/F/lPjeU54w+NSYbKeWq1HdCtLypnKHO2cr/eX2V3yIJhL4hd05GEXFXvdqn4
         7pIyaldLiQp9i4WeLFAVyHGpFdJKf2vhpFgJAG3xoq4PBQhL4utSenVmZQV12i3oTZcG
         dsD+/Z998rPl/PhxxlWnpdQ1AgoEvQ4SVZtrZiGyuPm/K+oHDr6aiEBEdOAmM/53EPMJ
         eVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7vpRjs4HnVzSUO+t3h2x028FfZuTWcDxrvni65rb60=;
        b=JjEPLPXapeT+c1h8MIw3fFgxKwBIJku7zS/NlGqFcgELf+V04CQfhBMBtTIjOvIafL
         XEwqlP36d2FiTwFaFvYdNKifsq30JtIXkY458AD9+KSNGJfOd6Tt1IxfiTvOvnP2b4Vm
         Zxz9/G4Wc4mN6hXWqFjfGY144Z2QbPBaDmgpmOa/Q6DXD6AWZhIVdbOMzfzA1TVhaSUR
         UEDMTfoZMnxu0fjgJiPF4sVyA37xqqZ9U0EgSa90AY+fjcfTd16DR2bVh6gY8eL3L0Je
         Pq07Sm3mRpCC9eW9WTZnAkaX/ETyGbTDTwWFsaZCubcRUyvIQN5uolycXzLZlWjCbyrY
         vkrw==
X-Gm-Message-State: ABuFfoht//Cv7S4b2yP/JbOKY1qiAqmPUrue+gzJJ2cI57xrp6ci+2Sk
        oK3jy4v9aKYy4I6kGmmDaEVDoO/c
X-Google-Smtp-Source: ACcGV62JQjjcKjymIYGqC1+kEpMp502ui9umVUz3dsl/4ccUPQyBjMkDvAfgX6fSJchRumgjdNu5TQ==
X-Received: by 2002:adf:8248:: with SMTP id 66-v6mr19753983wrb.140.1539102537985;
        Tue, 09 Oct 2018 09:28:57 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:57 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 12/18] RDMA/ocrdma: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:11 +0300
Message-Id: <20181009162817.4635-13-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/ocrdma/ocrdma_main.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 4d3c27613351..1ad1c4110bf8 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -114,6 +114,50 @@ static void get_dev_fw_str(struct ib_device *device, char *str)
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%s", &dev->attr.fw_ver[0]);
 }
 
+static struct ib_device_ops ocrdma_dev_ops = {
+	.query_device		= ocrdma_query_device,
+	.query_port		= ocrdma_query_port,
+	.modify_port		= ocrdma_modify_port,
+	.get_netdev		= ocrdma_get_netdev,
+	.get_link_layer		= ocrdma_link_layer,
+	.alloc_pd		= ocrdma_alloc_pd,
+	.dealloc_pd		= ocrdma_dealloc_pd,
+	.create_cq		= ocrdma_create_cq,
+	.destroy_cq		= ocrdma_destroy_cq,
+	.resize_cq		= ocrdma_resize_cq,
+	.create_qp		= ocrdma_create_qp,
+	.modify_qp		= ocrdma_modify_qp,
+	.query_qp		= ocrdma_query_qp,
+	.destroy_qp		= ocrdma_destroy_qp,
+	.query_pkey		= ocrdma_query_pkey,
+	.create_ah		= ocrdma_create_ah,
+	.destroy_ah		= ocrdma_destroy_ah,
+	.query_ah		= ocrdma_query_ah,
+	.poll_cq		= ocrdma_poll_cq,
+	.post_send		= ocrdma_post_send,
+	.post_recv		= ocrdma_post_recv,
+	.req_notify_cq		= ocrdma_arm_cq,
+	.get_dma_mr		= ocrdma_get_dma_mr,
+	.dereg_mr		= ocrdma_dereg_mr,
+	.reg_user_mr		= ocrdma_reg_user_mr,
+	.alloc_mr		= ocrdma_alloc_mr,
+	.map_mr_sg		= ocrdma_map_mr_sg,
+	.alloc_ucontext		= ocrdma_alloc_ucontext,
+	.dealloc_ucontext	= ocrdma_dealloc_ucontext,
+	.mmap			= ocrdma_mmap,
+	.process_mad		= ocrdma_process_mad,
+	.get_port_immutable	= ocrdma_port_immutable,
+	.get_dev_fw_str		= get_dev_fw_str,
+};
+
+static struct ib_device_ops ocrdma_dev_srq_ops = {
+	.create_srq		= ocrdma_create_srq,
+	.modify_srq		= ocrdma_modify_srq,
+	.query_srq		= ocrdma_query_srq,
+	.destroy_srq		= ocrdma_destroy_srq,
+	.post_srq_recv		= ocrdma_post_srq_recv,
+};
+
 static int ocrdma_register_device(struct ocrdma_dev *dev)
 {
 	ocrdma_get_guid(dev, (u8 *)&dev->ibdev.node_guid);
@@ -198,6 +242,8 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	dev->ibdev.get_port_immutable = ocrdma_port_immutable;
 	dev->ibdev.get_dev_fw_str     = get_dev_fw_str;
 
+	ib_set_device_ops(&dev->ibdev, &ocrdma_dev_ops);
+
 	if (ocrdma_get_asic_type(dev) == OCRDMA_ASIC_GEN_SKH_R) {
 		dev->ibdev.uverbs_cmd_mask |=
 		     OCRDMA_UVERBS(CREATE_SRQ) |
@@ -211,6 +257,7 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 		dev->ibdev.query_srq = ocrdma_query_srq;
 		dev->ibdev.destroy_srq = ocrdma_destroy_srq;
 		dev->ibdev.post_srq_recv = ocrdma_post_srq_recv;
+		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
 	}
 	dev->ibdev.driver_id = RDMA_DRIVER_OCRDMA;
 	return ib_register_device(&dev->ibdev, "ocrdma%d", NULL);
-- 
2.14.4

