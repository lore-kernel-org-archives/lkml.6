Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B12ECDE47
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50323214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uri1F/T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50323214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJIXqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39476 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJIXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so2659029wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cgo6W5LLK8DAL+ka1bJJ+ignQc3ApF0Mp3rq1Md7AUU=;
        b=uri1F/T2x9nLvLHBQNObAr9jeBQ6Sy67cqHOj79MR4p6E8ojARyAucGjEntUXGtlI1
         XrEo+10ej+usIkfqSPgvKqAjd7IUmTxFWMZO7p0DtPL/c6/QxtGA1cHxSU/DajM7BNkb
         H2sdnve7+n01k3S0S8xaOb49GBuGKNB1O6BbFnvNu5AFHH5nk3q7vxmXeGBa9DPl/CBc
         3UnYIN4ZSdTREy0RIJ1GjmenjuL40u2XQ2qKbEgBhCf0StC8JMmFPHskWK9Q/Y6LXEYN
         5x3lLAJGz2UpmBAuweOavL9Z5dmCzdpme46Y73eSiTB07W9pAxdbWqsjZ17uE42q2R4F
         Uxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cgo6W5LLK8DAL+ka1bJJ+ignQc3ApF0Mp3rq1Md7AUU=;
        b=U3kqUwJO8iqp/CxOc292dO9o17Wls++EzoMuM2UWw1R7uDkl6WhSUj3iYgH9VuefQz
         z+knM26IAUwHGF7d2qzALovqJRwFr1ccRhna72Z6yjuRmClnLcZTa1sDM3RAdqMGCwCg
         cS4rxU8fSRoJ+F5sLn6otXE9JdQ/2DwMNexf/jrkK0Im/pDta43THAluaEHDm4ohcJti
         LOPyz8K7tL7hyW1AfS4xchrffXt4BFqZnkPcxZzdrYyI9mu/uV1n2zD6PzU8AXry8fZq
         40lMc41P6G6fLtxrw10znHKwJMkwgGnVIf8DRU/JuWCDHTrg264ALbDvpWJX2BZPB7lC
         ygvQ==
X-Gm-Message-State: ABuFfoid3otmxK19e06ci7HppO84IOwE9IMHvNG4o/3xA/8vmGuxm2RQ
        hRWpzzDHtHUqUvXEWi559UY=
X-Google-Smtp-Source: ACcGV62qtoB/I0+3x7C/au7ynhhzLYuzvUWIDabqRbL/j1n1W/+kVo2ld9j/e/6aaQ2x9O2fDOOtXQ==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr2512872wmd.128.1539102531549;
        Tue, 09 Oct 2018 09:28:51 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:51 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 07/18] RDMA/i40iw: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:06 +0300
Message-Id: <20181009162817.4635-8-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index cb2aef874ca8..7841e609d81a 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2737,6 +2737,40 @@ static const struct cpumask *i40iw_get_vector_affinity(struct ib_device *ibdev,
 	return irq_get_affinity_mask(msix_vec->irq);
 }
 
+static struct ib_device_ops i40iw_dev_ops = {
+	.query_port		= i40iw_query_port,
+	.query_pkey		= i40iw_query_pkey,
+	.query_gid		= i40iw_query_gid,
+	.alloc_ucontext		= i40iw_alloc_ucontext,
+	.dealloc_ucontext	= i40iw_dealloc_ucontext,
+	.mmap			= i40iw_mmap,
+	.alloc_pd		= i40iw_alloc_pd,
+	.dealloc_pd		= i40iw_dealloc_pd,
+	.create_qp		= i40iw_create_qp,
+	.modify_qp		= i40iw_modify_qp,
+	.query_qp		= i40iw_query_qp,
+	.destroy_qp		= i40iw_destroy_qp,
+	.create_cq		= i40iw_create_cq,
+	.destroy_cq		= i40iw_destroy_cq,
+	.get_dma_mr		= i40iw_get_dma_mr,
+	.reg_user_mr		= i40iw_reg_user_mr,
+	.dereg_mr		= i40iw_dereg_mr,
+	.alloc_hw_stats		= i40iw_alloc_hw_stats,
+	.get_hw_stats		= i40iw_get_hw_stats,
+	.query_device		= i40iw_query_device,
+	.drain_sq		= i40iw_drain_sq,
+	.drain_rq		= i40iw_drain_rq,
+	.alloc_mr		= i40iw_alloc_mr,
+	.map_mr_sg		= i40iw_map_mr_sg,
+	.get_port_immutable	= i40iw_port_immutable,
+	.get_dev_fw_str		= i40iw_get_dev_fw_str,
+	.poll_cq		= i40iw_poll_cq,
+	.req_notify_cq		= i40iw_req_notify_cq,
+	.post_send		= i40iw_post_send,
+	.post_recv		= i40iw_post_recv,
+	.get_vector_affinity	= i40iw_get_vector_affinity,
+};
+
 /**
  * i40iw_init_rdma_device - initialization of iwarp device
  * @iwdev: iwarp device
@@ -2830,6 +2864,7 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 	iwibdev->ibdev.post_send = i40iw_post_send;
 	iwibdev->ibdev.post_recv = i40iw_post_recv;
 	iwibdev->ibdev.get_vector_affinity = i40iw_get_vector_affinity;
+	ib_set_device_ops(&iwibdev->ibdev, &i40iw_dev_ops);
 
 	return iwibdev;
 }
-- 
2.14.4

