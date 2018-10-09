Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CAFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE8214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpY590HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACE8214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJIXqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJIXqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so2507937wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o22LruJlQbcpQm5R5egUfci5o/4tvJ2Avfn5OS0Boc0=;
        b=YpY590HNQLLgXIx+Au9skd6gWqmWG1AofOjQqCk0k3bOJ+qEwUFuXmjgidz2X1upDX
         VTMPgQyXboUyGa7n0YFPCUeAB+TEO0V0NTzNhcycaJN6cUAwiWFdDnjOi27zhfRJHr1d
         h0RbGQUfGVZ/rwJbW1n6M0h9+OTkMwh4Yf5T20KVSmlTofdlgVXCD9RyvqFYLbkhMv6k
         OUlUUIio/ehbZSjqbKxVta6UVWgGMdTUnovO3IPQbt5NohuFvz8CtNUFXXdwpK7smTMx
         jHv03+QoVSB3UGlt4slYCQXma9SfnO6fw7fUsDQIedFa88GopRfwzw3Ch2AgK/7uiXhu
         V7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o22LruJlQbcpQm5R5egUfci5o/4tvJ2Avfn5OS0Boc0=;
        b=l5DQsMzBuSvFW2dBD1dGxZQOi9Fo5FoSaHIjucN9SjeCpUPrCGu3kXfsB6uHXa0cNH
         jXPIfcD7D44LqWN8rK+TwGIwIGhpcimkJFPKjmj4agCb0276KhmKl9l2RuQ6AxDSIemJ
         2HOhysiDOH7LWFQ+JJXzpLKyipfIgz6iW2GKQyKO34+/C4TrZnV9hL30uy7xyyYEcxRj
         hBkG7h8mPO2cfWr27i/J4SBXQbonnuoRuIWQIU+TpwMzQBx8E58lvyt4itCdncO76ehL
         YoMv8KQf5AnvNavdSOs0iTmiaSb95XNRRN22f5LLPJ/UZRWXfy/WV1rjEZIXQ25t19RH
         7ZrA==
X-Gm-Message-State: ABuFfojkyhDrKeONxKDC8Gx4P3kV2yva7SEIL+VOdiOTK+PIF0/6nbhL
        zcIQ9LRWvIGj+y7yuEUJWPHykSjN
X-Google-Smtp-Source: ACcGV609neNUAYJu4/QRjsuBcD319qiuoDqBwHlWbOUWdZUAp3gYsyh116GUZcuESB4KzeCpqQRaCg==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr18998717wrf.153.1539102528865;
        Tue, 09 Oct 2018 09:28:48 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:48 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 05/18] RDMA/hfi1: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:04 +0300
Message-Id: <20181009162817.4635-6-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/hfi1/verbs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index bc7f00ba1988..c63f331dbf7a 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1610,6 +1610,15 @@ static int get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	return count;
 }
 
+static struct ib_device_ops hfi1_dev_ops = {
+	.modify_device		= modify_device,
+	.alloc_hw_stats		= alloc_hw_stats,
+	.get_hw_stats		= get_hw_stats,
+	.alloc_rdma_netdev	= hfi1_vnic_alloc_rn,
+	.process_mad		= hfi1_process_mad,
+	.get_dev_fw_str		= hfi1_get_dev_fw_str,
+};
+
 /**
  * hfi1_register_ib_device - register our device with the infiniband core
  * @dd: the device data structure
@@ -1662,6 +1671,8 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 	ibdev->process_mad = hfi1_process_mad;
 	ibdev->get_dev_fw_str = hfi1_get_dev_fw_str;
 
+	ib_set_device_ops(ibdev, &hfi1_dev_ops);
+
 	strlcpy(ibdev->node_desc, init_utsname()->nodename,
 		sizeof(ibdev->node_desc));
 
-- 
2.14.4

