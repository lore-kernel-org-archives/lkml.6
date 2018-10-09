Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2807FECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8037214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp/+yv2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8037214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJIXqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36928 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so2687073wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5zfkwUnKP03G6y8nzrZjffU+ry/YHFw2yqYvicoudlI=;
        b=pp/+yv2a8FPaU1qaLwp9qSoaSqt7f/vfxn7wHxaUJie0uqReHNopXxUFsu0cxg/8mY
         xgBZljhDbFJBpkazMCe9ApnUv8nr6AopkC/i5e9JQ38LDCVZotwqZYjGn7I2eB7PKO0U
         3dg0NiWA8cfRWLWA2fKIZr+4FmDnZaRwkouvOgDhejNoGhT/tYL8m8leRYs+vzV1owYf
         KDe/laMm3VPY4EVgU3dY65hN49mqxXO3NlHobUM1OB7Ys4nUOovg220uzPT0R1O9pbTv
         dXQuU/5nh6N2zFeDnoRwh/LCWRgMwqOrUfy+vsb4rzMhp+23pxs8OLrwEy8mxuM28xO3
         51OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5zfkwUnKP03G6y8nzrZjffU+ry/YHFw2yqYvicoudlI=;
        b=s+MGqjsgpdVLCbauYtROfNWVCitdJHS7yPm16vqqn/UIvZQC3sfWGwvBRs1KJlkz1l
         jGmTcZOkSydGG7hTcTDI9uHZkghWxfES8MkkcsDABCEgqqUSMlgYDTLzThXzSieBLq1f
         XcqG8/kOj+cJ0H5TUdJExYcWsWaXAgM/YLnXuAXzLvTGGKCFxzS8/VzjLpuP3Vvh/DP8
         UMULxb1OnkqbrjX3OO5CQHoBs8fyfS46+s5CwFEultgxPiAqxTGCazoPrZv9padSuFxr
         0aa5p46++1gk97F4UXglbBoc0ionRHrrUEQ+OuSOIcC9AKIFX2qNyK4dUAiLFAV7zvMi
         pm1w==
X-Gm-Message-State: ABuFfoiTo7bKisWDj85hQxqwnJqxQ6VCCJr5/fpRBLARIDeiW30VyIIe
        npT1LHAAjsCSfo4XqPPwUl8=
X-Google-Smtp-Source: ACcGV61OomIkhieElrneSvJU1K71ab3uba6ZYVpY0lmINpi0OzaLs6xOD/kyExT5fVAM5S0zufhwrQ==
X-Received: by 2002:a1c:868e:: with SMTP id i136-v6mr2565020wmd.50.1539102532896;
        Tue, 09 Oct 2018 09:28:52 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:52 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 08/18] RDMA/mlx4: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:07 +0300
Message-Id: <20181009162817.4635-9-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/mlx4/main.c | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index fa5d20eccc21..2c189f90261c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2214,6 +2214,11 @@ static void mlx4_ib_fill_diag_counters(struct mlx4_ib_dev *ibdev,
 	}
 }
 
+static struct ib_device_ops mlx4_ib_hw_stats_ops = {
+	.get_hw_stats		= mlx4_ib_get_hw_stats,
+	.alloc_hw_stats		= mlx4_ib_alloc_hw_stats,
+};
+
 static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 {
 	struct mlx4_ib_diag_counters *diag = ibdev->diag_counters;
@@ -2242,6 +2247,7 @@ static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 
 	ibdev->ib_dev.get_hw_stats	= mlx4_ib_get_hw_stats;
 	ibdev->ib_dev.alloc_hw_stats	= mlx4_ib_alloc_hw_stats;
+	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_hw_stats_ops);
 
 	return 0;
 
@@ -2493,6 +2499,88 @@ static void get_fw_ver_str(struct ib_device *device, char *str)
 		 (int) dev->dev->caps.fw_ver & 0xffff);
 }
 
+static struct ib_device_ops mlx4_ib_dev_ops = {
+	.get_netdev		= mlx4_ib_get_netdev,
+	.add_gid		= mlx4_ib_add_gid,
+	.del_gid		= mlx4_ib_del_gid,
+	.query_device		= mlx4_ib_query_device,
+	.query_port		= mlx4_ib_query_port,
+	.get_link_layer		= mlx4_ib_port_link_layer,
+	.query_gid		= mlx4_ib_query_gid,
+	.query_pkey		= mlx4_ib_query_pkey,
+	.modify_device		= mlx4_ib_modify_device,
+	.modify_port		= mlx4_ib_modify_port,
+	.alloc_ucontext		= mlx4_ib_alloc_ucontext,
+	.dealloc_ucontext	= mlx4_ib_dealloc_ucontext,
+	.mmap			= mlx4_ib_mmap,
+	.alloc_pd		= mlx4_ib_alloc_pd,
+	.dealloc_pd		= mlx4_ib_dealloc_pd,
+	.create_ah		= mlx4_ib_create_ah,
+	.query_ah		= mlx4_ib_query_ah,
+	.destroy_ah		= mlx4_ib_destroy_ah,
+	.create_srq		= mlx4_ib_create_srq,
+	.modify_srq		= mlx4_ib_modify_srq,
+	.query_srq		= mlx4_ib_query_srq,
+	.destroy_srq		= mlx4_ib_destroy_srq,
+	.post_srq_recv		= mlx4_ib_post_srq_recv,
+	.create_qp		= mlx4_ib_create_qp,
+	.modify_qp		= mlx4_ib_modify_qp,
+	.query_qp		= mlx4_ib_query_qp,
+	.destroy_qp		= mlx4_ib_destroy_qp,
+	.drain_sq		= mlx4_ib_drain_sq,
+	.drain_rq		= mlx4_ib_drain_rq,
+	.post_send		= mlx4_ib_post_send,
+	.post_recv		= mlx4_ib_post_recv,
+	.create_cq		= mlx4_ib_create_cq,
+	.modify_cq		= mlx4_ib_modify_cq,
+	.resize_cq		= mlx4_ib_resize_cq,
+	.destroy_cq		= mlx4_ib_destroy_cq,
+	.poll_cq		= mlx4_ib_poll_cq,
+	.req_notify_cq		= mlx4_ib_arm_cq,
+	.get_dma_mr		= mlx4_ib_get_dma_mr,
+	.reg_user_mr		= mlx4_ib_reg_user_mr,
+	.rereg_user_mr		= mlx4_ib_rereg_user_mr,
+	.dereg_mr		= mlx4_ib_dereg_mr,
+	.alloc_mr		= mlx4_ib_alloc_mr,
+	.map_mr_sg		= mlx4_ib_map_mr_sg,
+	.attach_mcast		= mlx4_ib_mcg_attach,
+	.detach_mcast		= mlx4_ib_mcg_detach,
+	.process_mad		= mlx4_ib_process_mad,
+	.get_port_immutable	= mlx4_port_immutable,
+	.get_dev_fw_str		= get_fw_ver_str,
+	.disassociate_ucontext	= mlx4_ib_disassociate_ucontext,
+};
+
+static struct ib_device_ops mlx4_ib_dev_wq_ops = {
+	.create_wq		= mlx4_ib_create_wq,
+	.modify_wq		= mlx4_ib_modify_wq,
+	.destroy_wq		= mlx4_ib_destroy_wq,
+	.create_rwq_ind_table	= mlx4_ib_create_rwq_ind_table,
+	.destroy_rwq_ind_table	= mlx4_ib_destroy_rwq_ind_table,
+};
+
+static struct ib_device_ops mlx4_ib_dev_fmr_ops = {
+	.alloc_fmr		= mlx4_ib_fmr_alloc,
+	.map_phys_fmr		= mlx4_ib_map_phys_fmr,
+	.unmap_fmr		= mlx4_ib_unmap_fmr,
+	.dealloc_fmr		= mlx4_ib_fmr_dealloc,
+};
+
+static struct ib_device_ops mlx4_ib_dev_mw_ops = {
+	.alloc_mw		= mlx4_ib_alloc_mw,
+	.dealloc_mw		= mlx4_ib_dealloc_mw,
+};
+
+static struct ib_device_ops mlx4_ib_dev_xrc_ops = {
+	.alloc_xrcd		= mlx4_ib_alloc_xrcd,
+	.dealloc_xrcd		= mlx4_ib_dealloc_xrcd,
+};
+
+static struct ib_device_ops mlx4_ib_dev_fs_ops = {
+	.create_flow		= mlx4_ib_create_flow,
+	.destroy_flow		= mlx4_ib_destroy_flow,
+};
+
 static void *mlx4_ib_add(struct mlx4_dev *dev)
 {
 	struct mlx4_ib_dev *ibdev;
@@ -2630,6 +2718,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.get_dev_fw_str    = get_fw_ver_str;
 	ibdev->ib_dev.disassociate_ucontext = mlx4_ib_disassociate_ucontext;
 
+	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=
 		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
 
@@ -2645,6 +2734,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 			mlx4_ib_create_rwq_ind_table;
 		ibdev->ib_dev.destroy_rwq_ind_table =
 			mlx4_ib_destroy_rwq_ind_table;
+		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
 		ibdev->ib_dev.uverbs_ex_cmd_mask |=
 			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ)	  |
 			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ)	  |
@@ -2658,12 +2748,14 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		ibdev->ib_dev.map_phys_fmr	= mlx4_ib_map_phys_fmr;
 		ibdev->ib_dev.unmap_fmr		= mlx4_ib_unmap_fmr;
 		ibdev->ib_dev.dealloc_fmr	= mlx4_ib_fmr_dealloc;
+		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fmr_ops);
 	}
 
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
 	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
 		ibdev->ib_dev.alloc_mw = mlx4_ib_alloc_mw;
 		ibdev->ib_dev.dealloc_mw = mlx4_ib_dealloc_mw;
+		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_mw_ops);
 
 		ibdev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_ALLOC_MW) |
@@ -2673,6 +2765,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC) {
 		ibdev->ib_dev.alloc_xrcd = mlx4_ib_alloc_xrcd;
 		ibdev->ib_dev.dealloc_xrcd = mlx4_ib_dealloc_xrcd;
+		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_xrc_ops);
 		ibdev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
 			(1ull << IB_USER_VERBS_CMD_CLOSE_XRCD);
@@ -2682,6 +2775,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		ibdev->steering_support = MLX4_STEERING_MODE_DEVICE_MANAGED;
 		ibdev->ib_dev.create_flow	= mlx4_ib_create_flow;
 		ibdev->ib_dev.destroy_flow	= mlx4_ib_destroy_flow;
+		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 
 		ibdev->ib_dev.uverbs_ex_cmd_mask	|=
 			(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-- 
2.14.4

