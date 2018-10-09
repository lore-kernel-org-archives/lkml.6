Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BADECDE48
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151E3214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh+NT+ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151E3214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeJIXqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeJIXqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so2509270wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pW4H/oLkMUquIMiCs18y3wN7hCaDV3HqSP/jxxq3Qe8=;
        b=oh+NT+ffx9sCqRLxpzBnJHKQ0adQJlOPjHDvP7MG83Rhf7543pGXk6+cqQMOVq+W8W
         I+N8jbBPOTwssR2VGrUI2aX8x7oH9xbZO0yhONCs8RZYWqeqvzH9q/1zq6D+lJqPFKO9
         rkJb4BAlxxYwIWfc/41mHn8nHWQE6lemfqcWEByV6aCN5yNRCOwqVb2QSKHEK2pBcCS+
         QRWOuItI5vtTCtigpykg88NQDUsI7p75u90DZP6QfBUKob/jYrJ34DSvSTYJWJW8N6cT
         0mw4m+/z91Ikj4wlEW0SJTDfkbvWa9u6QXYoyy49/KLCiyQSLYO82DYxpoxp1hkrVGL4
         8dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pW4H/oLkMUquIMiCs18y3wN7hCaDV3HqSP/jxxq3Qe8=;
        b=QJzlBg0AoRnDIUZy5/vkA18LXcVWT6jSmX2esxWCZoB2BGHjq9kU5JZuo5hWRN2npw
         JvQ31/NiHg4JoRhhJFw1oTu2ACXIN6/gSgJ0QapelIZwuC0rQmKJKx2bIlVs5RybdMmh
         XGHagh9sdPs27hLm1xkSsyLcCeJlXXuq+b2bNxG63pes0gAlsNNDt7Z0vZOTdFJ4/a79
         7nPtGwQF8pAWL59E7hydSZO42iHs3zCvnsEBnFSbh+VUjST04vyBkbhdPObP+LtOzxLQ
         NNg7ANNP5+jEPiFikUqMSPMVL/mvsi5qEgQ5sjM7xlzHTGMq/+daVDuyyBzqij/eFPmu
         tcHg==
X-Gm-Message-State: ABuFfogGWJz3oRJGa4hPkaAQw6aptngeExUpb9zWPBrUti/WNEhXT2Ge
        FOCVD0uYWOIulZdfdUOJiiA=
X-Google-Smtp-Source: ACcGV6310TdbnO9GkVwqzDWxWUI9GVWs8FTxF1EvgUNyuyAz0WcXpKt5UGT2dPgSe67cVO++uejSnw==
X-Received: by 2002:adf:92a6:: with SMTP id 35-v6mr17953310wrn.137.1539102541755;
        Tue, 09 Oct 2018 09:29:01 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:01 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 15/18] RDMA/usnic: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:14 +0300
Message-Id: <20181009162817.4635-16-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index e3f98fe2f1e6..e327f5ec818e 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -330,6 +330,37 @@ static void usnic_get_dev_fw_str(struct ib_device *device, char *str)
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%s", info.fw_version);
 }
 
+static struct ib_device_ops usnic_dev_ops = {
+	.query_device		= usnic_ib_query_device,
+	.query_port		= usnic_ib_query_port,
+	.query_pkey		= usnic_ib_query_pkey,
+	.query_gid		= usnic_ib_query_gid,
+	.get_netdev		= usnic_get_netdev,
+	.get_link_layer		= usnic_ib_port_link_layer,
+	.alloc_pd		= usnic_ib_alloc_pd,
+	.dealloc_pd		= usnic_ib_dealloc_pd,
+	.create_qp		= usnic_ib_create_qp,
+	.modify_qp		= usnic_ib_modify_qp,
+	.query_qp		= usnic_ib_query_qp,
+	.destroy_qp		= usnic_ib_destroy_qp,
+	.create_cq		= usnic_ib_create_cq,
+	.destroy_cq		= usnic_ib_destroy_cq,
+	.reg_user_mr		= usnic_ib_reg_mr,
+	.dereg_mr		= usnic_ib_dereg_mr,
+	.alloc_ucontext		= usnic_ib_alloc_ucontext,
+	.dealloc_ucontext	= usnic_ib_dealloc_ucontext,
+	.mmap			= usnic_ib_mmap,
+	.create_ah		= usnic_ib_create_ah,
+	.destroy_ah		= usnic_ib_destroy_ah,
+	.post_send		= usnic_ib_post_send,
+	.post_recv		= usnic_ib_post_recv,
+	.poll_cq		= usnic_ib_poll_cq,
+	.req_notify_cq		= usnic_ib_req_notify_cq,
+	.get_dma_mr		= usnic_ib_get_dma_mr,
+	.get_port_immutable	= usnic_port_immutable,
+	.get_dev_fw_str		= usnic_get_dev_fw_str,
+};
+
 /* Start of PF discovery section */
 static void *usnic_ib_device_add(struct pci_dev *dev)
 {
@@ -415,6 +446,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	us_ibdev->ib_dev.get_port_immutable = usnic_port_immutable;
 	us_ibdev->ib_dev.get_dev_fw_str     = usnic_get_dev_fw_str;
 
+	ib_set_device_ops(&us_ibdev->ib_dev, &usnic_dev_ops);
 
 	us_ibdev->ib_dev.driver_id = RDMA_DRIVER_USNIC;
 	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d", NULL))
-- 
2.14.4

