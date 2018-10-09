Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C0ECDE47
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306B214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV8tRlHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJIXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36918 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJIXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so2686782wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwhcXmKUX4U8ipwdVYogTbCzTk6jrQFDLMcECgp8Vyw=;
        b=rV8tRlHHBkEv6PuNPcgxQQ2KmogrNyEICMBbK6hgFXQqhYMGOkfXqr4fsN4t6RJKT0
         BE+5sOegJpqbE6Qpa+wBxbrFi1ujNrnI2As0+4qmHXrDviovpjN0ArrlPpKuYbHaK4Ta
         Ekv00Wd6iMfnfPqlJjOr+rN9UPf5ZLvdqbXVhsVH/qi7GPdb4kRVjgwxYb+S0d5zxMIT
         yu83e8K0t7zpa11vip8qE8Nk7XTJ3R5RjXMHk+TH0DyDibzZ1cy9XiXfWw254bMznmPB
         durbHwVl8T08OsXsVxq3nwsOuUiJg7/STK3Igdw6W1oiy2WmH7UfCeIa2xJcV8EJ5Gd4
         YvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwhcXmKUX4U8ipwdVYogTbCzTk6jrQFDLMcECgp8Vyw=;
        b=tqeKSI1N6Dm2jx+C69PGKWmNQjLlLDv1tXRDbB6F2b67NBhaOFDtPrOQQ3Ox+AA2sh
         9Ok+/U1QQCMRoF/UnGwYZaPqpumbdtJfnWGzOV8B83gmFTLAY4/uglYpJLe+b0u0u5kw
         3Q6VGG7fjhe53J7fu/2Vmr91868d33ySXI8aKqUG9cbSu8fpBnW2Lg6JFeKTx172blo7
         cYuYutTNPUdk6LFwwbOYcSECCQuNIXeSTy+ur0dt/hhvUoEe4l9ragu4OkEit4tGtN9/
         kcIcKctKvgctTtnidqp5xVpAxQ+Fe+25MoCyL+ImYRYHNOHuOus3xosEzM6SAoHXY7Pd
         6yIw==
X-Gm-Message-State: ABuFfohbKm4mLE3HF4W8699kNTV1ZtJEgD1YFbNCvSaJ93xfP9oGlxnI
        Qu5XZ8hpYNBw33f8vcDf1fE=
X-Google-Smtp-Source: ACcGV63/UVY3MtSQCOg30OaUW+EwEp9Cmc0WQqofqU/OWKgKwCx7bCdsV9+yqPMb5zqKxPXiy+ettg==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195-v6mr2616927wmu.137.1539102527604;
        Tue, 09 Oct 2018 09:28:47 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:47 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 04/18] RDMA/cxgb4: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:03 +0300
Message-Id: <20181009162817.4635-5-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/cxgb4/provider.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 416f8d1af610..66bf1aae4021 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -527,6 +527,44 @@ static int fill_res_entry(struct sk_buff *msg, struct rdma_restrack_entry *res)
 		c4iw_restrack_funcs[res->type](msg, res) : 0;
 }
 
+static struct ib_device_ops c4iw_dev_ops = {
+	.query_device		= c4iw_query_device,
+	.query_port		= c4iw_query_port,
+	.query_pkey		= c4iw_query_pkey,
+	.query_gid		= c4iw_query_gid,
+	.alloc_ucontext		= c4iw_alloc_ucontext,
+	.dealloc_ucontext	= c4iw_dealloc_ucontext,
+	.mmap			= c4iw_mmap,
+	.alloc_pd		= c4iw_allocate_pd,
+	.dealloc_pd		= c4iw_deallocate_pd,
+	.create_qp		= c4iw_create_qp,
+	.modify_qp		= c4iw_ib_modify_qp,
+	.query_qp		= c4iw_ib_query_qp,
+	.destroy_qp		= c4iw_destroy_qp,
+	.create_srq		= c4iw_create_srq,
+	.modify_srq		= c4iw_modify_srq,
+	.destroy_srq		= c4iw_destroy_srq,
+	.create_cq		= c4iw_create_cq,
+	.destroy_cq		= c4iw_destroy_cq,
+	.poll_cq		= c4iw_poll_cq,
+	.get_dma_mr		= c4iw_get_dma_mr,
+	.reg_user_mr		= c4iw_reg_user_mr,
+	.dereg_mr		= c4iw_dereg_mr,
+	.alloc_mw		= c4iw_alloc_mw,
+	.dealloc_mw		= c4iw_dealloc_mw,
+	.alloc_mr		= c4iw_alloc_mr,
+	.map_mr_sg		= c4iw_map_mr_sg,
+	.req_notify_cq		= c4iw_arm_cq,
+	.post_send		= c4iw_post_send,
+	.post_recv		= c4iw_post_receive,
+	.post_srq_recv		= c4iw_post_srq_recv,
+	.alloc_hw_stats		= c4iw_alloc_stats,
+	.get_hw_stats		= c4iw_get_mib,
+	.get_port_immutable	= c4iw_port_immutable,
+	.get_dev_fw_str		= get_dev_fw_str,
+	.get_netdev		= get_netdev,
+};
+
 void c4iw_register_device(struct work_struct *work)
 {
 	int ret;
@@ -626,6 +664,7 @@ void c4iw_register_device(struct work_struct *work)
 	       sizeof(dev->ibdev.iwcm->ifname));
 
 	dev->ibdev.driver_id = RDMA_DRIVER_CXGB4;
+	ib_set_device_ops(&dev->ibdev, &c4iw_dev_ops);
 	ret = ib_register_device(&dev->ibdev, "cxgb4_%d", NULL);
 	if (ret)
 		goto err_kfree_iwcm;
-- 
2.14.4

