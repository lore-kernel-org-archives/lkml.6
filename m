Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864FECDE47
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C7214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms4mvntF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5C7214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJIXqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46658 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJIXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so2418030wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSYkuyo8gio+vQmhDl6DcBl7uYon+VFW6rLfvz0xVvI=;
        b=ms4mvntFBJLK1tf2KtDs/ELfDlk5t20k0ASu1hCQo0Mn9MZgDn34e3PYZLEYk9lmRy
         QtFNAqHycF8jIxxjI7WFtBwTT/5+tf6sXGet+spZezU3CvcJb7P42oTrnphmm6iKDOjK
         PDqNFOkr/Bae5fcJLCmSo5nHRMzHxuLCtb2NSgeiHetqfxrHUIXLIWt/W7rneVlTFI7M
         WH3al73NCxfhSRe9uKo/rmgJCzafv4hxC7oNLd9IXbIaIlynFvpTw6s3y5sYvC+wAuAE
         i9RQDeFUQ0bKY+2RqGvAeBrwlaJIcMRQu99VW+22VUYp5OWDDjYvf+nl26qKCb7lWP48
         H8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sSYkuyo8gio+vQmhDl6DcBl7uYon+VFW6rLfvz0xVvI=;
        b=FT67Z8tPVz5UYMWvb1JteFiaIWDpXLt/6N+ZHrbXWZE4ffWzunM5w9PvpywELYPfii
         4KolOE1zWnPL1R8dGJjFu6ILgFGZVd9qzU4PPALUmPepCSS7KE9u7wDejsp2jtcEpr8L
         2yBbOv3k7KthTKJLzE1VFWuk49II75Y0O3vkRTQ6BHGeOx4NvPHI8S5fAWimfvkNE+2h
         G1IKrjJfBSJJvKn2rmnMjnqBe6cbg8RUcxwIDzC3pwI90u0QZ7x+/j4GRhAgP80BXDb1
         /Pp4O6k5WvECUFVeRNWRdkqZyQ+uGc6BWhyrVo3QiiMgnJgKgAeAGa1Dd+CmwAo04Iau
         Ybaw==
X-Gm-Message-State: ABuFfog5Rmpes/F+/AV1BOpCdSviRrcFNZPSl9XAfErjtEy0puNyr3np
        a63MUeWqTAX3HYOWN2Kmmt4=
X-Google-Smtp-Source: ACcGV638g+lebu+LQiRGJ0w+yfkOhrNJirayJTmOnDBElW64+hDWvLf3Y6XMo6sZvNThOnlm5fRRLw==
X-Received: by 2002:a5d:6383:: with SMTP id p3-v6mr20973939wru.291.1539102544297;
        Tue, 09 Oct 2018 09:29:04 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:03 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 17/18] RDMA/rxe: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:16 +0300
Message-Id: <20181009162817.4635-18-kamalheib1@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_verbs.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e4da5b671e4a..4f28f71b7746 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1152,6 +1152,52 @@ static struct device_attribute *rxe_dev_attributes[] = {
 	&dev_attr_parent,
 };
 
+static struct ib_device_ops rxe_dev_ops = {
+	.query_device		= rxe_query_device,
+	.modify_device		= rxe_modify_device,
+	.query_port		= rxe_query_port,
+	.modify_port		= rxe_modify_port,
+	.get_link_layer		= rxe_get_link_layer,
+	.get_netdev		= rxe_get_netdev,
+	.query_pkey		= rxe_query_pkey,
+	.alloc_ucontext		= rxe_alloc_ucontext,
+	.dealloc_ucontext	= rxe_dealloc_ucontext,
+	.mmap			= rxe_mmap,
+	.get_port_immutable	= rxe_port_immutable,
+	.alloc_pd		= rxe_alloc_pd,
+	.dealloc_pd		= rxe_dealloc_pd,
+	.create_ah		= rxe_create_ah,
+	.modify_ah		= rxe_modify_ah,
+	.query_ah		= rxe_query_ah,
+	.destroy_ah		= rxe_destroy_ah,
+	.create_srq		= rxe_create_srq,
+	.modify_srq		= rxe_modify_srq,
+	.query_srq		= rxe_query_srq,
+	.destroy_srq		= rxe_destroy_srq,
+	.post_srq_recv		= rxe_post_srq_recv,
+	.create_qp		= rxe_create_qp,
+	.modify_qp		= rxe_modify_qp,
+	.query_qp		= rxe_query_qp,
+	.destroy_qp		= rxe_destroy_qp,
+	.post_send		= rxe_post_send,
+	.post_recv		= rxe_post_recv,
+	.create_cq		= rxe_create_cq,
+	.destroy_cq		= rxe_destroy_cq,
+	.resize_cq		= rxe_resize_cq,
+	.poll_cq		= rxe_poll_cq,
+	.peek_cq		= rxe_peek_cq,
+	.req_notify_cq		= rxe_req_notify_cq,
+	.get_dma_mr		= rxe_get_dma_mr,
+	.reg_user_mr		= rxe_reg_user_mr,
+	.dereg_mr		= rxe_dereg_mr,
+	.alloc_mr		= rxe_alloc_mr,
+	.map_mr_sg		= rxe_map_mr_sg,
+	.attach_mcast		= rxe_attach_mcast,
+	.detach_mcast		= rxe_detach_mcast,
+	.get_hw_stats		= rxe_ib_get_hw_stats,
+	.alloc_hw_stats		= rxe_ib_alloc_hw_stats,
+};
+
 int rxe_register_device(struct rxe_dev *rxe)
 {
 	int err;
@@ -1251,6 +1297,8 @@ int rxe_register_device(struct rxe_dev *rxe)
 	dev->get_hw_stats = rxe_ib_get_hw_stats;
 	dev->alloc_hw_stats = rxe_ib_alloc_hw_stats;
 
+	ib_set_device_ops(dev, &rxe_dev_ops);
+
 	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm)) {
 		pr_err("failed to allocate crc algorithm err:%ld\n",
-- 
2.14.4

