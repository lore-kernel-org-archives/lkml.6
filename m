Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BAECDE48
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8262E214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEBdUQ94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8262E214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJIXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37941 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJIXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so2663508wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYHOisxPW8Qr1x8eT4M4ISdrOrW8nh2A6gEtGiGPXhU=;
        b=YEBdUQ944sCQ+EqWhIqSooKGH5oMhT+QPme5R3e1vDj6K3HlvrDTO85hRJ0HjfrEN2
         ausGmdS+Nvdpr5jIVm5wtAtZoY8v2McGEqpaxd5sTxhlXP0jweeKSgjtCH7NAkOYC6yV
         5sYFn8hFy+8DE39jY6ed4aV/ddLCKaLiODhHDQwez3U2sDA2Ns456vACL0htzDSfz5cn
         i10ycsO+Vl7rNV5K85jtUz/+Sl7wu5MZ52zNcctaV5icaLNoHamf82ROM3vA7Xb7W/Q2
         TXXDTWUMeiehs4q1eSsNX9la5bycegVVF+LgWVGxtoNebI7GptkbMhwG3CJ8SEvXcxXM
         xHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYHOisxPW8Qr1x8eT4M4ISdrOrW8nh2A6gEtGiGPXhU=;
        b=RMJuuXSbUUR6uwoXzPzDf/vnstGkMV2cqO/2xD+00ng0LGKU2PVIP7MLPjt1cK8zVa
         ng6rORPMswEKtcdLLou0f40ftqRa0ZK7HS2T5h2vLIXk4t6Ov8kMf2XvuZZNDV257HO4
         LvOdG++4HRFjcMJxeo/Xz/dS+WkdPA62TcMpMDNxZOLUv6qhtby5MVjnr3231m+qI2pO
         NgcqmU9MpsgT6F92tFiisAkhfpI856oXtuVv8QuHAJy/PGmepYzrYk8Ms5wy99w/j4LJ
         cNU7qmBAmSc5DUWrdPgxs+mHFa4e3zKp/q0nv8gDOkAHcDNneZImFlpGNhatRD6YpBul
         uOVw==
X-Gm-Message-State: ABuFfohY8deuzqiQuqXtAiZCi6uNAZrqlvRDcA5TsDKzbyF4FrIRGzfz
        ETIXR2TQAvj2jUtD5Kpo1Tc=
X-Google-Smtp-Source: ACcGV61rcpiGhluXtRs93q7V5b5RQDyRrDv4BuTqB+iMnDe4FdqhN5D3fc4J5jx31IuMLEkwQxvmBw==
X-Received: by 2002:a1c:ee9d:: with SMTP id j29-v6mr2692205wmi.52.1539102526347;
        Tue, 09 Oct 2018 09:28:46 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:45 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 03/18] RDMA/cxgb3: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:02 +0300
Message-Id: <20181009162817.4635-4-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 39530cc15f95..4fe13dd1ef7d 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1313,6 +1313,39 @@ static void get_dev_fw_ver_str(struct ib_device *ibdev, char *str)
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%s", info.fw_version);
 }
 
+static struct ib_device_ops iwch_dev_ops = {
+	.query_device		= iwch_query_device,
+	.query_port		= iwch_query_port,
+	.query_pkey		= iwch_query_pkey,
+	.query_gid		= iwch_query_gid,
+	.alloc_ucontext		= iwch_alloc_ucontext,
+	.dealloc_ucontext	= iwch_dealloc_ucontext,
+	.mmap			= iwch_mmap,
+	.alloc_pd		= iwch_allocate_pd,
+	.dealloc_pd		= iwch_deallocate_pd,
+	.create_qp		= iwch_create_qp,
+	.modify_qp		= iwch_ib_modify_qp,
+	.destroy_qp		= iwch_destroy_qp,
+	.create_cq		= iwch_create_cq,
+	.destroy_cq		= iwch_destroy_cq,
+	.resize_cq		= iwch_resize_cq,
+	.poll_cq		= iwch_poll_cq,
+	.get_dma_mr		= iwch_get_dma_mr,
+	.reg_user_mr		= iwch_reg_user_mr,
+	.dereg_mr		= iwch_dereg_mr,
+	.alloc_mw		= iwch_alloc_mw,
+	.dealloc_mw		= iwch_dealloc_mw,
+	.alloc_mr		= iwch_alloc_mr,
+	.map_mr_sg		= iwch_map_mr_sg,
+	.req_notify_cq		= iwch_arm_cq,
+	.post_send		= iwch_post_send,
+	.post_recv		= iwch_post_receive,
+	.alloc_hw_stats		= iwch_alloc_stats,
+	.get_hw_stats		= iwch_get_mib,
+	.get_port_immutable	= iwch_port_immutable,
+	.get_dev_fw_str		= get_dev_fw_ver_str,
+};
+
 int iwch_register_device(struct iwch_dev *dev)
 {
 	int ret;
@@ -1401,6 +1434,7 @@ int iwch_register_device(struct iwch_dev *dev)
 	       sizeof(dev->ibdev.iwcm->ifname));
 
 	dev->ibdev.driver_id = RDMA_DRIVER_CXGB3;
+	ib_set_device_ops(&dev->ibdev, &iwch_dev_ops);
 	ret = ib_register_device(&dev->ibdev, "cxgb3_%d", NULL);
 	if (ret)
 		goto bail1;
-- 
2.14.4

