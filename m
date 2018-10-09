Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCBECDE47
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11DB214FE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm3ZsKXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11DB214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJIXql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55731 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJIXqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so2520711wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEQypoJExVT08PG3jvYi3cMy48tMRH7WxT4wHh3YxX4=;
        b=qm3ZsKXrbH7qlOSbQa7p9kUGeuCTcD3p0jLN78j5dh8dCg7w15ynZR4scSe/Kd1nXZ
         jG1dqu6tstf/h+z23SwBgVfj1RyaZ/4ZHgSTDJoFDb1J9jgmGoL4O3dtN9pW1oGyv2nC
         KLdICxP0hhK92h/Lcf9OArzA9EunhHlI1Jyp8YfxquQdaODWnh480/EnoW/NlHE/2O7Y
         33vcG0aWL8JdJn/j5sTc2wU3O3tOBk6RxcVVghQfi2XbETBc2EUZRzc/iKnNGHV8V2Gz
         1vd97f32V0qzZgtcOHhHU+BovNjof7AawhKGeKZNjkcPEt+ulItyzwELWvOy7oRMa5zR
         PE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEQypoJExVT08PG3jvYi3cMy48tMRH7WxT4wHh3YxX4=;
        b=NJudRzjvWvxURlQjLHlYUacOcJgAnRJFBgzF6jlkd1RR36zMRHoW1NndpmyqiCq/IE
         w+zub1f7O4zB7e7F8e7Xr/ZKB9I6sGw1UYHS8ysYcyasC6ttnxD7PRckAGj9Uic5ldT1
         3s6Mw2ILVxvrVR9ZaCU47zJrHPn6sM3j8iKLeJZWrnbtnxXV4zdjgVthb5OMZYHXRWGu
         +Ur+MBUdUnU067hFlSPO7YKhZBkw4rEJ/bdTj62uc9fcR6Z4exRgXP2JlUmDN1AIIlWu
         aBZRqRhtEwGNT4B4XpYhSB0YseF9RudKu47HGrE6xYISUasdyabfGJGrtr+8R7PcHQ7/
         p7AA==
X-Gm-Message-State: ABuFfohf1Ab7vl09OnQN8CWvI1Y2qkwDEFjxhMznDi8S3k2YczdK3C/1
        N0gBydWAQX9S7lMrnctF490=
X-Google-Smtp-Source: ACcGV60Nt8o0jeSV5LtH2uLFi1X3BEqBOD9PlWLxGizl2YHW1E35tPSmgbRvSWHNw28dDuKlUbVS7w==
X-Received: by 2002:a7b:c150:: with SMTP id z16-v6mr2629923wmi.25.1539102534231;
        Tue, 09 Oct 2018 09:28:54 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:53 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 09/18] RDMA/mlx5: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:08 +0300
Message-Id: <20181009162817.4635-10-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/mlx5/main.c | 126 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b3294a7e3ff9..1d2b8f4b2904 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5760,6 +5760,92 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 	kfree(dev->flow_db);
 }
 
+static struct ib_device_ops mlx5_ib_dev_ops = {
+	.query_device		= mlx5_ib_query_device,
+	.get_link_layer		= mlx5_ib_port_link_layer,
+	.query_gid		= mlx5_ib_query_gid,
+	.add_gid		= mlx5_ib_add_gid,
+	.del_gid		= mlx5_ib_del_gid,
+	.query_pkey		= mlx5_ib_query_pkey,
+	.modify_device		= mlx5_ib_modify_device,
+	.modify_port		= mlx5_ib_modify_port,
+	.alloc_ucontext		= mlx5_ib_alloc_ucontext,
+	.dealloc_ucontext	= mlx5_ib_dealloc_ucontext,
+	.mmap			= mlx5_ib_mmap,
+	.alloc_pd		= mlx5_ib_alloc_pd,
+	.dealloc_pd		= mlx5_ib_dealloc_pd,
+	.create_ah		= mlx5_ib_create_ah,
+	.query_ah		= mlx5_ib_query_ah,
+	.destroy_ah		= mlx5_ib_destroy_ah,
+	.create_srq		= mlx5_ib_create_srq,
+	.modify_srq		= mlx5_ib_modify_srq,
+	.query_srq		= mlx5_ib_query_srq,
+	.destroy_srq		= mlx5_ib_destroy_srq,
+	.post_srq_recv		= mlx5_ib_post_srq_recv,
+	.create_qp		= mlx5_ib_create_qp,
+	.modify_qp		= mlx5_ib_modify_qp,
+	.query_qp		= mlx5_ib_query_qp,
+	.destroy_qp		= mlx5_ib_destroy_qp,
+	.drain_sq		= mlx5_ib_drain_sq,
+	.drain_rq		= mlx5_ib_drain_rq,
+	.post_send		= mlx5_ib_post_send,
+	.post_recv		= mlx5_ib_post_recv,
+	.create_cq		= mlx5_ib_create_cq,
+	.modify_cq		= mlx5_ib_modify_cq,
+	.resize_cq		= mlx5_ib_resize_cq,
+	.destroy_cq		= mlx5_ib_destroy_cq,
+	.poll_cq		= mlx5_ib_poll_cq,
+	.req_notify_cq		= mlx5_ib_arm_cq,
+	.get_dma_mr		= mlx5_ib_get_dma_mr,
+	.reg_user_mr		= mlx5_ib_reg_user_mr,
+	.rereg_user_mr		= mlx5_ib_rereg_user_mr,
+	.dereg_mr		= mlx5_ib_dereg_mr,
+	.attach_mcast		= mlx5_ib_mcg_attach,
+	.detach_mcast		= mlx5_ib_mcg_detach,
+	.process_mad		= mlx5_ib_process_mad,
+	.alloc_mr		= mlx5_ib_alloc_mr,
+	.map_mr_sg		= mlx5_ib_map_mr_sg,
+	.check_mr_status	= mlx5_ib_check_mr_status,
+	.get_dev_fw_str		= get_dev_fw_str,
+	.get_vector_affinity	= mlx5_ib_get_vector_affinity,
+	.disassociate_ucontext	= mlx5_ib_disassociate_ucontext,
+	.create_flow		= mlx5_ib_create_flow,
+	.destroy_flow		= mlx5_ib_destroy_flow,
+	.create_flow_action_esp	= mlx5_ib_create_flow_action_esp,
+	.destroy_flow_action	= mlx5_ib_destroy_flow_action,
+	.modify_flow_action_esp	= mlx5_ib_modify_flow_action_esp,
+	.create_counters	= mlx5_ib_create_counters,
+	.destroy_counters	= mlx5_ib_destroy_counters,
+	.read_counters		= mlx5_ib_read_counters,
+};
+
+static struct ib_device_ops mlx5_ib_dev_ipoib_enhanced_ops = {
+	.alloc_rdma_netdev	= mlx5_ib_alloc_rdma_netdev,
+};
+
+static struct ib_device_ops mlx5_ib_dev_sriov_ops = {
+	.get_vf_config		= mlx5_ib_get_vf_config,
+	.set_vf_link_state	= mlx5_ib_set_vf_link_state,
+	.get_vf_stats		= mlx5_ib_get_vf_stats,
+	.set_vf_guid		= mlx5_ib_set_vf_guid,
+};
+
+static struct ib_device_ops mlx5_ib_dev_mw_ops = {
+	.alloc_mw		= mlx5_ib_alloc_mw,
+	.dealloc_mw		= mlx5_ib_dealloc_mw,
+};
+
+static struct ib_device_ops mlx5_ib_dev_xrc_ops = {
+	.alloc_xrcd		= mlx5_ib_alloc_xrcd,
+	.dealloc_xrcd		= mlx5_ib_dealloc_xrcd,
+};
+
+static struct ib_device_ops mlx5_ib_dev_dm_ops = {
+	.alloc_dm		= mlx5_ib_alloc_dm,
+	.dealloc_dm		= mlx5_ib_dealloc_dm,
+	.reg_dm_mr		= mlx5_ib_reg_dm_mr,
+};
+
 int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -5847,14 +5933,18 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	dev->ib_dev.check_mr_status	= mlx5_ib_check_mr_status;
 	dev->ib_dev.get_dev_fw_str      = get_dev_fw_str;
 	dev->ib_dev.get_vector_affinity	= mlx5_ib_get_vector_affinity;
-	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads))
+	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads)) {
 		dev->ib_dev.alloc_rdma_netdev	= mlx5_ib_alloc_rdma_netdev;
+		ib_set_device_ops(&dev->ib_dev,
+				  &mlx5_ib_dev_ipoib_enhanced_ops);
+	}
 
 	if (mlx5_core_is_pf(mdev)) {
 		dev->ib_dev.get_vf_config	= mlx5_ib_get_vf_config;
 		dev->ib_dev.set_vf_link_state	= mlx5_ib_set_vf_link_state;
 		dev->ib_dev.get_vf_stats	= mlx5_ib_get_vf_stats;
 		dev->ib_dev.set_vf_guid		= mlx5_ib_set_vf_guid;
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_sriov_ops);
 	}
 
 	dev->ib_dev.disassociate_ucontext = mlx5_ib_disassociate_ucontext;
@@ -5864,6 +5954,7 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (MLX5_CAP_GEN(mdev, imaicl)) {
 		dev->ib_dev.alloc_mw		= mlx5_ib_alloc_mw;
 		dev->ib_dev.dealloc_mw		= mlx5_ib_dealloc_mw;
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_mw_ops);
 		dev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_ALLOC_MW)	|
 			(1ull << IB_USER_VERBS_CMD_DEALLOC_MW);
@@ -5872,6 +5963,7 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (MLX5_CAP_GEN(mdev, xrc)) {
 		dev->ib_dev.alloc_xrcd = mlx5_ib_alloc_xrcd;
 		dev->ib_dev.dealloc_xrcd = mlx5_ib_dealloc_xrcd;
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_xrc_ops);
 		dev->ib_dev.uverbs_cmd_mask |=
 			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
 			(1ull << IB_USER_VERBS_CMD_CLOSE_XRCD);
@@ -5881,6 +5973,7 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		dev->ib_dev.alloc_dm = mlx5_ib_alloc_dm;
 		dev->ib_dev.dealloc_dm = mlx5_ib_dealloc_dm;
 		dev->ib_dev.reg_dm_mr = mlx5_ib_reg_dm_mr;
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_dm_ops);
 	}
 
 	dev->ib_dev.create_flow	= mlx5_ib_create_flow;
@@ -5895,6 +5988,7 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	dev->ib_dev.create_counters = mlx5_ib_create_counters;
 	dev->ib_dev.destroy_counters = mlx5_ib_destroy_counters;
 	dev->ib_dev.read_counters = mlx5_ib_read_counters;
+	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_ops);
 
 	err = init_node_data(dev);
 	if (err)
@@ -5908,22 +6002,45 @@ int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	return 0;
 }
 
+static struct ib_device_ops mlx5_ib_dev_port_ops = {
+	.get_port_immutable	= mlx5_port_immutable,
+	.query_port		= mlx5_ib_query_port,
+};
+
 static int mlx5_ib_stage_non_default_cb(struct mlx5_ib_dev *dev)
 {
 	dev->ib_dev.get_port_immutable  = mlx5_port_immutable;
 	dev->ib_dev.query_port		= mlx5_ib_query_port;
 
+	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_port_ops);
+
 	return 0;
 }
 
+static struct ib_device_ops mlx5_ib_dev_port_rep_ops = {
+	.get_port_immutable	= mlx5_port_rep_immutable,
+	.query_port		= mlx5_ib_rep_query_port,
+};
+
 int mlx5_ib_stage_rep_non_default_cb(struct mlx5_ib_dev *dev)
 {
 	dev->ib_dev.get_port_immutable  = mlx5_port_rep_immutable;
 	dev->ib_dev.query_port		= mlx5_ib_rep_query_port;
 
+	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_port_rep_ops);
+
 	return 0;
 }
 
+static struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
+	.get_netdev		= mlx5_ib_get_netdev,
+	.create_wq		= mlx5_ib_create_wq,
+	.modify_wq		= mlx5_ib_modify_wq,
+	.destroy_wq		= mlx5_ib_destroy_wq,
+	.create_rwq_ind_table	= mlx5_ib_create_rwq_ind_table,
+	.destroy_rwq_ind_table	= mlx5_ib_destroy_rwq_ind_table,
+};
+
 static int mlx5_ib_stage_common_roce_init(struct mlx5_ib_dev *dev)
 {
 	u8 port_num;
@@ -5942,6 +6059,7 @@ static int mlx5_ib_stage_common_roce_init(struct mlx5_ib_dev *dev)
 	dev->ib_dev.create_rwq_ind_table = mlx5_ib_create_rwq_ind_table;
 	dev->ib_dev.destroy_rwq_ind_table = mlx5_ib_destroy_rwq_ind_table;
 
+	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
 	dev->ib_dev.uverbs_ex_cmd_mask |=
 			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
 			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
@@ -6041,11 +6159,17 @@ static int mlx5_ib_stage_odp_init(struct mlx5_ib_dev *dev)
 	return mlx5_ib_odp_init_one(dev);
 }
 
+static struct ib_device_ops mlx5_ib_dev_hw_stats_ops = {
+	.get_hw_stats		= mlx5_ib_get_hw_stats,
+	.alloc_hw_stats		= mlx5_ib_alloc_hw_stats,
+};
+
 int mlx5_ib_stage_counters_init(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, max_qp_cnt)) {
 		dev->ib_dev.get_hw_stats	= mlx5_ib_get_hw_stats;
 		dev->ib_dev.alloc_hw_stats	= mlx5_ib_alloc_hw_stats;
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_hw_stats_ops);
 
 		return mlx5_ib_alloc_counters(dev);
 	}
-- 
2.14.4

