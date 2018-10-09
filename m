Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF16C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC9214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEIsp3ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC9214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJIXri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:47:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJIXqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so2521138wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThxpkFr5W2WJ2iDMVrdBG6oQOM/x+o0DS/Pp9OUXHYU=;
        b=UEIsp3neZHnltZB0ZScxRDjOWDjCyBALFL00rdmPUkuUnfexR6Wyz2jgR4iLQnbF3R
         D1m6sXXlMmvtwCOkyKL/b57LEKJz6EK+M20Tkm5E277qNLZzQ4bh1Bi79XzjnWkA8yng
         clb2clS1KHE6vOG97u28PwOW0Q7XmEaFrTfGFkIJYxRbQP18zDuaBpmzN5eta0ITFIpB
         VWlSspoGBKQnnCK0j47bYIEkX/LUycnp26ULnDtnN7Yp0GaCQB35nDv7BxsVUWYwIZft
         Ag9yQ9D3YUYSoA/ZbuYd67mwu5NOmUxdQQWYhUolxEVWCn5NSN72Qqu+hx5x6GE3Zu5/
         zf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThxpkFr5W2WJ2iDMVrdBG6oQOM/x+o0DS/Pp9OUXHYU=;
        b=YVbw+BA9THS1fguLKxUN1gvsxKxaSAZYXi/a6cGqERRp9/rYrqsUZtYO+i2qUVWozC
         jGjMBQReF74594iGjFBEWC/Goo6vi0QbwkblvfXwgDwtnyzWRMvX76Ey01s/ji2p+yKK
         +O62hTqNHrbVBRLWN6SG8qdxd4AEaZGQkGS8fkLInR6CHbKy0YRNT8GoLFBHGCm0x/ZN
         BYXsoDEXbI4ATApFiHARL1KANFbTRnnnqdTDqekg4YYEtde1gDunIm8gIRa0CJ9Sd7pV
         HWk3AVVJMeduW0HF1lI2pGcpZn9pPWm92IkAmd+260h1ewxDAFlZ5lYkGVnbkwDlWziQ
         rgig==
X-Gm-Message-State: ABuFfoi7aW3r/g/b8G54JxZyeFatyGI7XvkpmNeL1gOOrL9pAC85j3AY
        l1jN2Po+EULX87vtGxlC8f0=
X-Google-Smtp-Source: ACcGV63xE7wAMTx82pshrwHjKJvTRoUbVmi2jjFhkgxY+ZwX2bpiXdnO2wdA63QLSrSahlRNWrGT3w==
X-Received: by 2002:a5d:4791:: with SMTP id w17-v6mr22117585wrq.319.1539102536796;
        Tue, 09 Oct 2018 09:28:56 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 11/18] RDMA/nes: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:10 +0300
Message-Id: <20181009162817.4635-12-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/nes/nes_verbs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 94054bc611bd..a305bb8115e9 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3627,6 +3627,39 @@ static void get_dev_fw_str(struct ib_device *dev, char *str)
 		 (nesvnic->nesdev->nesadapter->firmware_version & 0x000000ff));
 }
 
+static struct ib_device_ops nes_dev_ops = {
+	.query_device		= nes_query_device,
+	.query_port		= nes_query_port,
+	.query_pkey		= nes_query_pkey,
+	.query_gid		= nes_query_gid,
+	.alloc_ucontext		= nes_alloc_ucontext,
+	.dealloc_ucontext	= nes_dealloc_ucontext,
+	.mmap			= nes_mmap,
+	.alloc_pd		= nes_alloc_pd,
+	.dealloc_pd		= nes_dealloc_pd,
+	.create_qp		= nes_create_qp,
+	.modify_qp		= nes_modify_qp,
+	.query_qp		= nes_query_qp,
+	.destroy_qp		= nes_destroy_qp,
+	.create_cq		= nes_create_cq,
+	.destroy_cq		= nes_destroy_cq,
+	.poll_cq		= nes_poll_cq,
+	.get_dma_mr		= nes_get_dma_mr,
+	.reg_user_mr		= nes_reg_user_mr,
+	.dereg_mr		= nes_dereg_mr,
+	.alloc_mw		= nes_alloc_mw,
+	.dealloc_mw		= nes_dealloc_mw,
+	.alloc_mr		= nes_alloc_mr,
+	.map_mr_sg		= nes_map_mr_sg,
+	.req_notify_cq		= nes_req_notify_cq,
+	.post_send		= nes_post_send,
+	.post_recv		= nes_post_recv,
+	.drain_sq		= nes_drain_sq,
+	.drain_rq		= nes_drain_rq,
+	.get_port_immutable	= nes_port_immutable,
+	.get_dev_fw_str		= get_dev_fw_str,
+};
+
 /**
  * nes_init_ofa_device
  */
@@ -3719,6 +3752,7 @@ struct nes_ib_device *nes_init_ofa_device(struct net_device *netdev)
 	nesibdev->ibdev.iwcm->destroy_listen = nes_destroy_listen;
 	nesibdev->ibdev.get_port_immutable   = nes_port_immutable;
 	nesibdev->ibdev.get_dev_fw_str   = get_dev_fw_str;
+	ib_set_device_ops(&nesibdev->ibdev, &nes_dev_ops);
 	memcpy(nesibdev->ibdev.iwcm->ifname, netdev->name,
 	       sizeof(nesibdev->ibdev.iwcm->ifname));
 
-- 
2.14.4

