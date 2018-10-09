Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4977C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2FF214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGb0hUA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2FF214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJIXqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so2509892wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oc9+fOZpqXIzxaz8vCgKAGzanoNLXdD4T85GrX2mX8c=;
        b=FGb0hUA03PmaDSrucEiykbDBq9wsxEzQzsHC61roQuyf8kU5F1/YHm7iZyWvQa8dSr
         dQn4FNKL/CLP8M/9X/K94NYR3cvOIV3JzXwsAdUw0LQTpqE1Oedm/xbThejZ0HmIkrSw
         dPy6GSeHVy9ALFw/t6D52X2ITuKx2DweFeVN1mZUWUr5TU+YpDnaJQspsWyl0UT7w8CI
         nAeOI6Gqth4ncq5CydnKyNfkiQ/hyMoqRT2WLCcSzgpzqF5cAhyPFDoHeI5NwHiwN4Ar
         zketsAgLQbzKsxK9sqCNdSIYTAoD1WyR0S0M6Nwv3w2h9p/hqKjt03gc/+efV98p5sFn
         sZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oc9+fOZpqXIzxaz8vCgKAGzanoNLXdD4T85GrX2mX8c=;
        b=tsk+ahQ2e0I+9dP+btsFB0SgVxc38m1QZdxrDymrERFaPw5wxOfQk/Bw6mn7VQAoV0
         H/rcbQzF07YkXPCmn6JcTWad+LHsOTn7xyWVwsXenMnNDxjcmhTpYzi0KtG9MNxS3dP6
         7AjYG9xnp/2n7clOJXfy36aMsJKZyqE4aEQl88Fw2DCadE+JhQ6nfn9udzNh/CNnZNbv
         YMaaVZ08/aqF+50b/Cj3S8r6yZ+yg+SHpuYrqkgn7lq/RTxl6oB9t7vrJmwvFWe1WkC0
         ssAcNCR7kgqGgR0PeX364yJ9NRS4KxWaaEVg1YVeLzMWDDH+EErAOzGalmzFy6Opn2ff
         H2Gw==
X-Gm-Message-State: ABuFfohDUhSlEFQY1iM3M/QDoSWBiYih+w19FlnwqQQxbS9HFaXcD4Jw
        q2neTVr296eq3hqwV9Cvx0Q=
X-Google-Smtp-Source: ACcGV63T0IGN5BJnAxDqMWJmkuVc1uU6vBOxOxbrh0V+THgPYvigXn/jnchGBKeevShUa31RbnNHng==
X-Received: by 2002:a1c:de88:: with SMTP id v130-v6mr2537015wmg.59.1539102530134;
        Tue, 09 Oct 2018 09:28:50 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:49 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 06/18] RDMA/hns: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:05 +0300
Message-Id: <20181009162817.4635-7-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 11 ++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 11 ++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 42 +++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index de9b8e391563..283ca30334fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -799,6 +799,7 @@ struct hns_roce_hw {
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
+	struct ib_device_ops *hns_roce_dev_ops;
 };
 
 struct hns_roce_dev {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index ca05810c92dc..c9bc316366e0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4793,6 +4793,16 @@ static void hns_roce_v1_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	kfree(eq_table->eq);
 }
 
+static struct ib_device_ops hns_roce_v1_dev_ops = {
+	.query_qp	= hns_roce_v1_query_qp,
+	.destroy_qp	= hns_roce_v1_destroy_qp,
+	.post_send	= hns_roce_v1_post_send,
+	.post_recv	= hns_roce_v1_post_recv,
+	.modify_cq	= hns_roce_v1_modify_cq,
+	.req_notify_cq	= hns_roce_v1_req_notify_cq,
+	.poll_cq	= hns_roce_v1_poll_cq,
+};
+
 static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.reset = hns_roce_v1_reset,
 	.hw_profile = hns_roce_v1_profile,
@@ -4818,6 +4828,7 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.destroy_cq = hns_roce_v1_destroy_cq,
 	.init_eq = hns_roce_v1_init_eq_table,
 	.cleanup_eq = hns_roce_v1_cleanup_eq_table,
+	.hns_roce_dev_ops = hns_roce_v1_dev_ops,
 };
 
 static const struct of_device_id hns_roce_of_match[] = {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e3d9f1de8899..82fb636c99ad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5247,6 +5247,16 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	destroy_workqueue(hr_dev->irq_workq);
 }
 
+static struct ib_device_ops hns_roce_v2_dev_ops = {
+	.query_qp	= hns_roce_v2_query_qp,
+	.destroy_qp	= hns_roce_v2_destroy_qp,
+	.post_send	= hns_roce_v2_post_send,
+	.post_recv	= hns_roce_v2_post_recv,
+	.modify_cq	= hns_roce_v2_modify_cq,
+	.req_notify_cq	= hns_roce_v2_req_notify_cq,
+	.poll_cq	= hns_roce_v2_poll_cq,
+};
+
 static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.cmq_init = hns_roce_v2_cmq_init,
 	.cmq_exit = hns_roce_v2_cmq_exit,
@@ -5273,6 +5283,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.poll_cq = hns_roce_v2_poll_cq,
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
+	.hns_roce_dev_ops = hns_roce_v2_dev_ops,
 };
 
 static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 7e693b11c823..725678f138df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -440,6 +440,44 @@ static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 	ib_unregister_device(&hr_dev->ib_dev);
 }
 
+static struct ib_device_ops hns_roce_dev_ops = {
+	.modify_device		= hns_roce_modify_device,
+	.query_device		= hns_roce_query_device,
+	.query_port		= hns_roce_query_port,
+	.modify_port		= hns_roce_modify_port,
+	.get_link_layer		= hns_roce_get_link_layer,
+	.get_netdev		= hns_roce_get_netdev,
+	.add_gid		= hns_roce_add_gid,
+	.del_gid		= hns_roce_del_gid,
+	.query_pkey		= hns_roce_query_pkey,
+	.alloc_ucontext		= hns_roce_alloc_ucontext,
+	.dealloc_ucontext	= hns_roce_dealloc_ucontext,
+	.mmap			= hns_roce_mmap,
+	.alloc_pd		= hns_roce_alloc_pd,
+	.dealloc_pd		= hns_roce_dealloc_pd,
+	.create_ah		= hns_roce_create_ah,
+	.query_ah		= hns_roce_query_ah,
+	.destroy_ah		= hns_roce_destroy_ah,
+	.create_qp		= hns_roce_create_qp,
+	.modify_qp		= hns_roce_modify_qp,
+	.create_cq		= hns_roce_ib_create_cq,
+	.destroy_cq		= hns_roce_ib_destroy_cq,
+	.get_dma_mr		= hns_roce_get_dma_mr,
+	.reg_user_mr		= hns_roce_reg_user_mr,
+	.dereg_mr		= hns_roce_dereg_mr,
+	.get_port_immutable	= hns_roce_port_immutable,
+	.disassociate_ucontext	= hns_roce_disassociate_ucontext,
+};
+
+static struct ib_device_ops hns_roce_dev_mr_ops = {
+	.rereg_user_mr		= hns_roce_rereg_user_mr,
+};
+
+static struct ib_device_ops hns_roce_dev_mw_ops = {
+	.alloc_mw		= hns_roce_alloc_mw,
+	.dealloc_mw		= hns_roce_dealloc_mw,
+};
+
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -524,6 +562,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->rereg_user_mr	= hns_roce_rereg_user_mr;
 		ib_dev->uverbs_cmd_mask |= (1ULL << IB_USER_VERBS_CMD_REREG_MR);
+		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
 	}
 
 	/* MW */
@@ -533,6 +572,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		ib_dev->uverbs_cmd_mask |=
 					(1ULL << IB_USER_VERBS_CMD_ALLOC_MW) |
 					(1ULL << IB_USER_VERBS_CMD_DEALLOC_MW);
+		ib_set_device_ops(ib_dev, &hns_roce_dev_mw_ops);
 	}
 
 	/* OTHERS */
@@ -540,6 +580,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_dev->disassociate_ucontext	= hns_roce_disassociate_ucontext;
 
 	ib_dev->driver_id = RDMA_DRIVER_HNS;
+	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
+	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	ret = ib_register_device(ib_dev, "hns_%d", NULL);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
-- 
2.14.4

