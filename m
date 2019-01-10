Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4AEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C55206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESlhdUQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfAJG1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:27:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33136 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfAJG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:27:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4875062pfb.0;
        Wed, 09 Jan 2019 22:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Uqep5P12TmNJRbDpNJ38z4+WnFaCIQ/6dfEgnqnIVCU=;
        b=ESlhdUQpSVrVl6UjPIHJprxQTwAxcUKZf+HRCE+TrPSxd3kch7zC2hhzmu/lDZxfQX
         ELnBHZkHxtPmBR+mMNXPCzAmu/nZzazCFua4tUNfxY7tVIxhMariWppDrnIgLEaiKmKV
         MY7O/l8RSbNYO5RswniB1EF0KKmkvjT7g1OWaUdc2g0Xy1ZM2r3qhhDh430LBhsLFax3
         Egv2p0ealXSWQI74wreKnAQiFUG0LAx7usnFlVnCCC01ENEktaRj3mTgTe1nkcf9Tf1a
         tjBul/sgTFCUAwfgpqIQZfda2WnkE1xerQh2mKM9i6/zZ50M+tqf92BjLGhAcRYcTrfG
         4VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Uqep5P12TmNJRbDpNJ38z4+WnFaCIQ/6dfEgnqnIVCU=;
        b=L6YqooNQGhMBydFuYY57hzRopgPGlv1Go0XzXkRSvw7cTlcPw8Kd9zQ7Tllsq6S5Tu
         GNB9RnYkHxcf/ar/DUUKHqpSfhinst0VdrVy5Yd659nQlw3/gw6Ap6dmBtujk+9Kfg+L
         Cl6qMZ1M3uJI3op6aOJBSG7FlDdFshpi4hjfaj4VdWKheBmsmzWGj6JgQkCHPpkddeaU
         wi7KEnzcMzrUWBxhcxbHqhIrmebA1GI2kr49cx5sD7gtxzSzyEfzSLRIYY3IxIBorn6B
         ctuOl4H72QgjrW5JoUIVuBz+ijbTr1ZNHS+jXFCu0tNQzZ0WD2KAeFfFdG32BnLIikgO
         p6jQ==
X-Gm-Message-State: AJcUukc8Yy2OD1fb9gYgAHcpQ6qmgIIFT8w6x7p2X2QZ4dgpfnNyNvF3
        aWU3eZUoJgxlWmD6eEEuN04=
X-Google-Smtp-Source: ALg8bN7j2Q/fjvAboQakyJ6XacZL6OAh9N+31Z5vS9qdNJVSsMG9zZStrivtv2kMB90g+KP/4EJXTA==
X-Received: by 2002:a63:bc02:: with SMTP id q2mr8304277pge.116.1547101654087;
        Wed, 09 Jan 2019 22:27:34 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id h134sm149229455pfe.27.2019.01.09.22.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 22:27:33 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:27:31 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/cma: Rollback source IP address if failing to
 acquire device
Message-ID: <20190110062727.GA25844@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the
device state changes back to RDMA_CM_ADDR_BOUND but the resolved source
IP address is still left. After that, if rdma_destroy_id() is called
after rdma_listen(), the device is freed without removed from
listen_any_list in cma_cancel_operation(). Revert to the previous IP
address if acquiring device fails.

Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/infiniband/core/cma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 63a7cc00bae0..8cd113b0ddfb 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2963,13 +2963,22 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 {
 	struct rdma_id_private *id_priv = context;
 	struct rdma_cm_event event = {};
+	struct sockaddr *addr;
+	struct sockaddr_storage old_addr;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
 			   RDMA_CM_ADDR_RESOLVED))
 		goto out;
 
-	memcpy(cma_src_addr(id_priv), src_addr, rdma_addr_size(src_addr));
+	/*
+	 * Store the previous src address, so that if we fail to acquire
+	 * matching rdma device, old address can be restored back, which helps
+	 * to cancel the cma listen operation correctly.
+	 */
+	addr = cma_src_addr(id_priv);
+	memcpy(&old_addr, addr, rdma_addr_size(addr));
+	memcpy(addr, src_addr, rdma_addr_size(src_addr));
 	if (!status && !id_priv->cma_dev) {
 		status = cma_acquire_dev_by_src_ip(id_priv);
 		if (status)
@@ -2980,6 +2989,8 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	}
 
 	if (status) {
+		memcpy(addr, &old_addr,
+		       rdma_addr_size((struct sockaddr *)&old_addr));
 		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
 				   RDMA_CM_ADDR_BOUND))
 			goto out;
-- 
2.17.1

