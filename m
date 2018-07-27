Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4354C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FF2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp3xYFJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501FF2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeG0Ju0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:50:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43161 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0Ju0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:50:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1492454pfi.10;
        Fri, 27 Jul 2018 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mPSTWh3lwRepsLbgt2o0sl8oKrikhsxeI/ve+7lxBcM=;
        b=Tp3xYFJxr4Vxf8OFKNp8P5qouAFZfTEkOccniXiTH3pRakPvbHa12sUDkCpORGj7Kz
         clnqMPQRrnXbEPnmZsa2ZWNpbj/i2lbTNqN3tOisJhBx0TJZVeVFNPb1kmjfs9ubKvEh
         BxIHed4UJKfwC1A/d1XD9kriEFeubiIy+DEsg5GvAyXx8skLJcy4juAILX69bRJpQLxt
         /6qh05vaz1XqR0OUHLTMOOA1cY/MRRZIjgHQjrrfj0CbKrjl0HpCttpL9/wjzoQPXs3F
         M2XrVV8tvUE37yho+qN7fMvzU3Rr9478HRiWhExm3U9+IZFzjNu8pFdsXjwejzYNagrK
         SXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mPSTWh3lwRepsLbgt2o0sl8oKrikhsxeI/ve+7lxBcM=;
        b=ZQWcgfr12PjfY1RwgSk9yGuE4wVm6VR44UvF+Rk1Hn0T+fFV8DqOJvQPKlurJC8j73
         FK/H+cvPBuMTeGrovRpq03TRE8O1tvB2IrYgsRKnaehq4VYQxn3eaFC1LKOpR7TV6yBj
         4/KYl3K8SnMcdZYmqL30PmXeIBqxxKPB5lQlay8gxivjABmI6HjBLcWRo8f/uQF7/Qtx
         569oB6nLnRxp79FuT4OQGoZYbHzlhAxAbfFgw8XMXo/9ML6VZqsbSAshHL/bmrHAFQhf
         s7Brr0FvKX9/A39DKE+ySZTqJfKUVlgjODd3ACuA09W5SYeuT5/vJbs4ze4nf97Tzqmd
         D3lQ==
X-Gm-Message-State: AOUpUlGkO1I44CCfKxMe3139unJyYrISuqkpoUak1O7UekcnuwQ3xg4o
        n10PZ9ENWDqlI2KDpCS2iFU=
X-Google-Smtp-Source: AAOMgpc4GmwtXgNyhuw4YAlf83ezBDXkxkuVifLkGI2ZqQKas0pdnKiG7A5gZwIv+kcAanhnbE197w==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr5022733pgv.273.1532680178417;
        Fri, 27 Jul 2018 01:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id q81-v6sm9734363pfd.15.2018.07.27.01.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:29:37 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, yanjun.zhu@oracle.com, keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: nvidia: forcedeth: Replace GFP_ATOMIC with GFP_KERNEL in nv_probe()
Date:   Fri, 27 Jul 2018 16:29:31 +0800
Message-Id: <20180727082931.7340-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv_probe() is never called in atomic context.
It calls dma_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/nvidia/forcedeth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 66c665d0b926..a6f1a5a3daea 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5775,7 +5775,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 						      (np->rx_ring_size +
 						      np->tx_ring_size),
 						      &np->ring_addr,
-						      GFP_ATOMIC);
+						      GFP_KERNEL);
 		if (!np->rx_ring.orig)
 			goto out_unmap;
 		np->tx_ring.orig = &np->rx_ring.orig[np->rx_ring_size];
@@ -5784,7 +5784,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 						    sizeof(struct ring_desc_ex) *
 						    (np->rx_ring_size +
 						    np->tx_ring_size),
-						    &np->ring_addr, GFP_ATOMIC);
+						    &np->ring_addr, GFP_KERNEL);
 		if (!np->rx_ring.ex)
 			goto out_unmap;
 		np->tx_ring.ex = &np->rx_ring.ex[np->rx_ring_size];
-- 
2.17.0

