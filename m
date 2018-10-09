Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F7EECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7AF214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Qg7Une"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7AF214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJIXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45665 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so2501558wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5NZZeIjuVvP2+M9CQhp6KEz2lK0JIAzjiH54akdMr54=;
        b=A4Qg7UneUqU5V1MYqoo5iFf0yxVoLbI+aPUzYvIJw2ohIAgWccxHTleoYI3vlt/Qvo
         3qelULd4lGo0QmZzqIxLktWOS78tdbNHVJTvxsR+OSdB0XATEqgANfn/pm9mubpne0Gq
         L98GdgSZ3alB3zavV1vt0RlYaUDOlDfd50alZC/DI3iS3Ppqo9PLrw8lPTx5WlhuPpV4
         S8lwpKntRX0njK3i70aJSX7ZY6J3KfKgxXSsnU8ZBnIaILBj1ZN5eGu502WmALi++QYx
         u5SDPUm9VMmz9g3dm1jUnbYP79Ud+Ts02SOZ6X+bC8VqZLQEy3jJX6ARHp7SMRp4apCI
         Qwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5NZZeIjuVvP2+M9CQhp6KEz2lK0JIAzjiH54akdMr54=;
        b=HfaCr5r4SeICZTfapEIbDAKlnUNPKkT4aGLoi/zIXym2Snfz1WCayFimuRbUJFrGrh
         tIsyTuB+gfklRoy2AKhZ+DeQkyhLEN2yvUxgsYxrh+cg1rk2UZLmOGdvwHq0sY4xL+9S
         k4l7yxtqrxAIaw9425i+znG1VwpJ/irnyCqEMmAgwHhBgAWF95NfngOe+jvnIOrc9FtN
         cwFLhEIyJZ0Z3TS+EJ0RBDLXgQltNQWJM4Mht4vVXzFTnKO6k+cZpX9hn6Q4I88mrIvw
         rmAHOOghisNZ+taR0pFs316B9CSKD3Zqo3ciqs91H8LFPMWaTwq62KMaH+fJKFI85v97
         XQLQ==
X-Gm-Message-State: ABuFfoivIQmgPv5Wi4TNaPNwIEszWrOpBiL+DgvGZZPiGT0+ai686cnp
        IFtqac48OaVJVOvwjcpF86Q=
X-Google-Smtp-Source: ACcGV61yO46mkI5IG/0/plZ8OJ9S3PDLuagwPmu4YIZUW16UKTEVuZF6ugCoKsLlQfvTXjQfy0hXRg==
X-Received: by 2002:a5d:5649:: with SMTP id j9-v6mr1684603wrw.41.1539102525111;
        Tue, 09 Oct 2018 09:28:45 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:44 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 02/18] RDMA/bnxt_re: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:01 +0300
Message-Id: <20181009162817.4635-3-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73632e5b819f..14cd92bd300f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -572,6 +572,50 @@ static void bnxt_re_unregister_ib(struct bnxt_re_dev *rdev)
 	ib_unregister_device(&rdev->ibdev);
 }
 
+static struct ib_device_ops bnxt_re_dev_ops = {
+	.query_device		= bnxt_re_query_device,
+	.modify_device		= bnxt_re_modify_device,
+	.query_port		= bnxt_re_query_port,
+	.get_port_immutable	= bnxt_re_get_port_immutable,
+	.get_dev_fw_str		= bnxt_re_query_fw_str,
+	.query_pkey		= bnxt_re_query_pkey,
+	.get_netdev		= bnxt_re_get_netdev,
+	.add_gid		= bnxt_re_add_gid,
+	.del_gid		= bnxt_re_del_gid,
+	.get_link_layer		= bnxt_re_get_link_layer,
+	.alloc_pd		= bnxt_re_alloc_pd,
+	.dealloc_pd		= bnxt_re_dealloc_pd,
+	.create_ah		= bnxt_re_create_ah,
+	.modify_ah		= bnxt_re_modify_ah,
+	.query_ah		= bnxt_re_query_ah,
+	.destroy_ah		= bnxt_re_destroy_ah,
+	.create_srq		= bnxt_re_create_srq,
+	.modify_srq		= bnxt_re_modify_srq,
+	.query_srq		= bnxt_re_query_srq,
+	.destroy_srq		= bnxt_re_destroy_srq,
+	.post_srq_recv		= bnxt_re_post_srq_recv,
+	.create_qp		= bnxt_re_create_qp,
+	.modify_qp		= bnxt_re_modify_qp,
+	.query_qp		= bnxt_re_query_qp,
+	.destroy_qp		= bnxt_re_destroy_qp,
+	.post_send		= bnxt_re_post_send,
+	.post_recv		= bnxt_re_post_recv,
+	.create_cq		= bnxt_re_create_cq,
+	.destroy_cq		= bnxt_re_destroy_cq,
+	.poll_cq		= bnxt_re_poll_cq,
+	.req_notify_cq		= bnxt_re_req_notify_cq,
+	.get_dma_mr		= bnxt_re_get_dma_mr,
+	.dereg_mr		= bnxt_re_dereg_mr,
+	.alloc_mr		= bnxt_re_alloc_mr,
+	.map_mr_sg		= bnxt_re_map_mr_sg,
+	.reg_user_mr		= bnxt_re_reg_user_mr,
+	.alloc_ucontext		= bnxt_re_alloc_ucontext,
+	.dealloc_ucontext	= bnxt_re_dealloc_ucontext,
+	.mmap			= bnxt_re_mmap,
+	.get_hw_stats		= bnxt_re_ib_get_hw_stats,
+	.alloc_hw_stats		= bnxt_re_ib_alloc_hw_stats,
+};
+
 static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 {
 	struct ib_device *ibdev = &rdev->ibdev;
@@ -671,6 +715,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	ibdev->alloc_hw_stats           = bnxt_re_ib_alloc_hw_stats;
 
 	ibdev->driver_id = RDMA_DRIVER_BNXT_RE;
+	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	return ib_register_device(ibdev, "bnxt_re%d", NULL);
 }
 
-- 
2.14.4

