Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF41C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607B4214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4SnnhGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607B4214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJIXqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34414 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeJIXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so2109754wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zl8jCVdEdGBhcfRdNUEKYnO8aYChOnJurzzPax6VvlA=;
        b=q4SnnhGWu/ziHwIoDT+oStkR00ua0u55g20ILkoOQPe0twM7o/j18l1f0JT0zPgnR8
         N1DTqwvIWYD8e3rzXRuYN8zNy5ldy6IYendEGuHIn1ldlYrdiJfkieAFNyML0UWMncph
         mFtYP1XHvGgTlLHZfw0kQuRZJiDdOjdSIQiJPcOlwT15m6o6ImvqTGrN/mCpddhvWiuz
         RebR0oqUN2D+0TrAVUEuNu8eO/KaPOzNf0JHUylO0JCz6zdNJMqn/M7Rt//+wXSkKP2X
         ATJIGrILqe9HafnHrBY6ZVOU25XQj3S2r9OoWBzoQ92HZmgQ9bKmAEUSm7jnDdSds0YL
         dfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zl8jCVdEdGBhcfRdNUEKYnO8aYChOnJurzzPax6VvlA=;
        b=YLOGH4J6DX+CSvGf901iW2A+Qt4wnMCvg35PbnMJrv94gC+8QjEfs/Stn6lfEjXR7x
         4UL/RCGm2SmMoOiw18lpQeuFwgvVCGvUs+8nzjdesAsLURqBdVAlTEzfOA+2iHhJbwjY
         C/n9oO2PczTzK8VKRUHhhVbxICeZ6xDyOg6JpXZL4+RYPN3bJq4je/gWp+J2UEGR5fOy
         ee+C8JtvJ/7uzVLDLt/ZlnfaMJhZEcHZaFMG5yiMnduf3T/v0o+0uZfGD8N9D3l4ocZR
         iEi2N/BM7PaG504LSjkKT9WkZCx+5i6MCCTkuR9iMZu0EtmUZ/ueMjVivYSJo7aDKaGb
         oFGw==
X-Gm-Message-State: ABuFfohofYp0Xbt3ddi3A+gRQ2HFj1E7ICXwxrNZRgLs9FKPYOwu/t99
        jhC0FSoob8BymRTVRm6JTrE=
X-Google-Smtp-Source: ACcGV60tOuuJ1g0ij9FmRKMlW37JLPm4atAovMMZFXYH8y2aVh1GtbL0Kz5ljSfPkKrHm9eH5BRKzA==
X-Received: by 2002:adf:83c3:: with SMTP id 61-v6mr19823298wre.5.1539102535583;
        Tue, 09 Oct 2018 09:28:55 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:55 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 10/18] RDMA/mthca: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:09 +0300
Message-Id: <20181009162817.4635-11-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/mthca/mthca_provider.c | 97 ++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 7bd7e2ad17e4..540d55dd75bc 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1189,6 +1189,81 @@ static void get_dev_fw_str(struct ib_device *device, char *str)
 		 (int) dev->fw_ver & 0xffff);
 }
 
+static struct ib_device_ops mthca_dev_ops = {
+	.query_device		= mthca_query_device,
+	.query_port		= mthca_query_port,
+	.modify_device		= mthca_modify_device,
+	.modify_port		= mthca_modify_port,
+	.query_pkey		= mthca_query_pkey,
+	.query_gid		= mthca_query_gid,
+	.alloc_ucontext		= mthca_alloc_ucontext,
+	.dealloc_ucontext	= mthca_dealloc_ucontext,
+	.mmap			= mthca_mmap_uar,
+	.alloc_pd		= mthca_alloc_pd,
+	.dealloc_pd		= mthca_dealloc_pd,
+	.create_ah		= mthca_ah_create,
+	.query_ah		= mthca_ah_query,
+	.destroy_ah		= mthca_ah_destroy,
+	.create_qp		= mthca_create_qp,
+	.modify_qp		= mthca_modify_qp,
+	.query_qp		= mthca_query_qp,
+	.destroy_qp		= mthca_destroy_qp,
+	.create_cq		= mthca_create_cq,
+	.resize_cq		= mthca_resize_cq,
+	.destroy_cq		= mthca_destroy_cq,
+	.poll_cq		= mthca_poll_cq,
+	.get_dma_mr		= mthca_get_dma_mr,
+	.reg_user_mr		= mthca_reg_user_mr,
+	.dereg_mr		= mthca_dereg_mr,
+	.get_port_immutable	= mthca_port_immutable,
+	.get_dev_fw_str		= get_dev_fw_str,
+	.attach_mcast		= mthca_multicast_attach,
+	.detach_mcast		= mthca_multicast_detach,
+	.process_mad		= mthca_process_mad,
+};
+
+static struct ib_device_ops mthca_dev_arbel_srq_ops = {
+	.create_srq		= mthca_create_srq,
+	.modify_srq		= mthca_modify_srq,
+	.query_srq		= mthca_query_srq,
+	.destroy_srq		= mthca_destroy_srq,
+	.post_srq_recv		= mthca_arbel_post_srq_recv,
+};
+
+static struct ib_device_ops mthca_dev_tavor_srq_ops = {
+	.create_srq		= mthca_create_srq,
+	.modify_srq		= mthca_modify_srq,
+	.query_srq		= mthca_query_srq,
+	.destroy_srq		= mthca_destroy_srq,
+	.post_srq_recv		= mthca_tavor_post_srq_recv,
+};
+
+static struct ib_device_ops mthca_dev_arbel_fmr_ops = {
+	.alloc_fmr		= mthca_alloc_fmr,
+	.unmap_fmr		= mthca_unmap_fmr,
+	.dealloc_fmr		= mthca_dealloc_fmr,
+	.map_phys_fmr		= mthca_arbel_map_phys_fmr,
+};
+
+static struct ib_device_ops mthca_dev_tavor_fmr_ops = {
+	.alloc_fmr		= mthca_alloc_fmr,
+	.unmap_fmr		= mthca_unmap_fmr,
+	.dealloc_fmr		= mthca_dealloc_fmr,
+	.map_phys_fmr		= mthca_tavor_map_phys_fmr,
+};
+
+static struct ib_device_ops mthca_dev_arbel_ops = {
+	.req_notify_cq		= mthca_arbel_arm_cq,
+	.post_send		= mthca_arbel_post_send,
+	.post_recv		= mthca_arbel_post_receive,
+};
+
+static struct ib_device_ops mthca_dev_tavor_ops = {
+	.req_notify_cq		= mthca_tavor_arm_cq,
+	.post_send		= mthca_tavor_post_send,
+	.post_recv		= mthca_tavor_post_receive,
+};
+
 int mthca_register_device(struct mthca_dev *dev)
 {
 	int ret;
@@ -1249,10 +1324,15 @@ int mthca_register_device(struct mthca_dev *dev)
 			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
 
-		if (mthca_is_memfree(dev))
+		if (mthca_is_memfree(dev)) {
 			dev->ib_dev.post_srq_recv = mthca_arbel_post_srq_recv;
-		else
+			ib_set_device_ops(&dev->ib_dev,
+					  &mthca_dev_arbel_srq_ops);
+		} else {
 			dev->ib_dev.post_srq_recv = mthca_tavor_post_srq_recv;
+			ib_set_device_ops(&dev->ib_dev,
+					  &mthca_dev_tavor_srq_ops);
+		}
 	}
 
 	dev->ib_dev.create_qp            = mthca_create_qp;
@@ -1273,24 +1353,33 @@ int mthca_register_device(struct mthca_dev *dev)
 		dev->ib_dev.alloc_fmr            = mthca_alloc_fmr;
 		dev->ib_dev.unmap_fmr            = mthca_unmap_fmr;
 		dev->ib_dev.dealloc_fmr          = mthca_dealloc_fmr;
-		if (mthca_is_memfree(dev))
+		if (mthca_is_memfree(dev)) {
 			dev->ib_dev.map_phys_fmr = mthca_arbel_map_phys_fmr;
-		else
+			ib_set_device_ops(&dev->ib_dev,
+					  &mthca_dev_arbel_fmr_ops);
+		} else {
 			dev->ib_dev.map_phys_fmr = mthca_tavor_map_phys_fmr;
+			ib_set_device_ops(&dev->ib_dev,
+					  &mthca_dev_tavor_fmr_ops);
+		}
 	}
 
 	dev->ib_dev.attach_mcast         = mthca_multicast_attach;
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
 
+	ib_set_device_ops(&dev->ib_dev, &mthca_dev_ops);
+
 	if (mthca_is_memfree(dev)) {
 		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
 		dev->ib_dev.post_send     = mthca_arbel_post_send;
 		dev->ib_dev.post_recv     = mthca_arbel_post_receive;
+		ib_set_device_ops(&dev->ib_dev, &mthca_dev_arbel_ops);
 	} else {
 		dev->ib_dev.req_notify_cq = mthca_tavor_arm_cq;
 		dev->ib_dev.post_send     = mthca_tavor_post_send;
 		dev->ib_dev.post_recv     = mthca_tavor_post_receive;
+		ib_set_device_ops(&dev->ib_dev, &mthca_dev_tavor_ops);
 	}
 
 	mutex_init(&dev->cap_mask_mutex);
-- 
2.14.4

