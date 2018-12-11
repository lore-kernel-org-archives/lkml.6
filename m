Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB52120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="kYZO8us5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB52120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeLKM5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:57:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44908 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLKM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:57:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so10665433lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=B5OxVxVCV5CgTbspOHE6zw8Koc7T4ZCxbFbcoeMSHX0=;
        b=kYZO8us5Gx4VJmd5uQFfW6enIIeXVvyDTOxvIevbfhqal1l6vawCccOwwmgCWtp0De
         oOQUmmTk41oxs8YlYAnbv7FQL4m4ZbE456flWc70ElgqdYzY/SnFf80IcnM4wk3kgIQ1
         YWDvBFRtzsqVLytytpsR7VSTQhHZbnI8ytbDmHd1RShTElZg3p3n4XAZsSey5fXXHApX
         3s5RIGSeZ/XqZGYmOW3hlWYe23AX6F9xC3VeyfZuIeNFYcls8BhCq7O64iJ+5+gmhlqr
         4RlIP/7Ct+ETgifO4dKFNCnMzGmBEdFtGQo4MiNajsiHzYxZMrZ4bZTNZNW1B9H1ejRi
         9mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B5OxVxVCV5CgTbspOHE6zw8Koc7T4ZCxbFbcoeMSHX0=;
        b=UKKOOdg+8aa4IctBhOYqAAfHOKCq5O2dbDEk3hiIPNs9EtMsN1+JwFu8iSKBun9iRv
         ief+3GqDKQ5lm4yMZ9iBV36xArWTuD3qitQqJq2rE2SBVi4C3u+ikB2rRaW4z1k97WSR
         XwqSTj/eU0NAsNawGy3NHkXslZSybnZTi/GGftfOxCt/8jVAAqUwj+f0xaWuAynQaa9O
         dd4E6u2dK7FaTLAMeshfA7OmG6dU+aGa5Wezahvns+LOPz7PMHqp9IJTHKElBl9n9AUc
         tGys3A3XGHlR0QDjJyenemyKYkn7+nkHK+QMJMhoO0h1dN/WCwLXQAKZsfZfseIA9tYR
         7pPQ==
X-Gm-Message-State: AA+aEWYJNi5+/uI58/WYUItAh9X0fkLbM7qpe4+SYAl9jrpRKRc5gMVL
        kbpmkENtpQuXYNGvNrE7k2Sw6JthrVQ=
X-Google-Smtp-Source: AFSGD/ULZv8g+nHqpBmCn8i5r2krP5fpZoCRpGJt/70nLzwN2pEa3a4BGXkDF92INUt2sltVKOETsw==
X-Received: by 2002:a19:c014:: with SMTP id q20mr8698803lff.16.1544533020958;
        Tue, 11 Dec 2018 04:57:00 -0800 (PST)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id g4-v6sm2736636lji.17.2018.12.11.04.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 04:57:00 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux@armlinux.org.uk,
        maxime.chevallier@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, antoine.tenart@bootlin.com,
        stefanc@marvell.com, nadavh@marvell.com, jaz@semihalf.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Date:   Tue, 11 Dec 2018 13:56:49 +0100
Message-Id: <1544533009-12425-1-git-send-email-mw@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in the mvneta driver reworked allocation
and handling of the ingress buffers to use entire pages.
Apart from that in SW BM scenario the HW must be informed
via PRXDQS about the biggest possible incoming buffer
that can be propagated by RX descriptors.

The BufferSize field was filled according to the MTU-dependent
pkt_size value. Later change to PAGE_SIZE broke RX operation
when usin 64K pages, as the field is simply too small.

This patch conditionally limits the value passed to the BufferSize
of the PRXDQS register, depending on the PAGE_SIZE used.
On the occasion remove now unused frag_size field of the mvneta_port
structure.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation
method for SWBM")

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e5397c8..61b2349 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -408,7 +408,6 @@ struct mvneta_port {
 	struct mvneta_pcpu_stats __percpu	*stats;
 
 	int pkt_size;
-	unsigned int frag_size;
 	void __iomem *base;
 	struct mvneta_rx_queue *rxqs;
 	struct mvneta_tx_queue *txqs;
@@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
 	if (!pp->bm_priv) {
 		/* Set Offset */
 		mvneta_rxq_offset_set(pp, rxq, 0);
-		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
+		mvneta_rxq_buf_size_set(pp, rxq, PAGE_SIZE < SZ_64K ?
+					PAGE_SIZE :
+					MVNETA_RX_BUF_SIZE(pp->pkt_size));
 		mvneta_rxq_bm_disable(pp, rxq);
 		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
@@ -3760,7 +3761,6 @@ static int mvneta_open(struct net_device *dev)
 	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
-	pp->frag_size = PAGE_SIZE;
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret)
-- 
2.7.4

