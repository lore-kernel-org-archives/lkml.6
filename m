Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47459ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA75220645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA75220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeISPIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:08:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43238 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbeISPHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0274B208D9; Wed, 19 Sep 2018 11:30:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id C7909208E7;
        Wed, 19 Sep 2018 11:30:02 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 08/12] net: mvpp2: make mvpp2_read_relaxed static
Date:   Wed, 19 Sep 2018 11:27:07 +0200
Message-Id: <20180919092711.22296-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Marvell PPv2 driver the mvpp2_read_relaxed function is only used
in a single file. Make it static and remove its prototype from the
header.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 2 --
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 5247f2d1f573..87ac86a87bd5 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1097,8 +1097,6 @@ struct mvpp2_bm_pool {
 void mvpp2_write(struct mvpp2 *priv, u32 offset, u32 data);
 u32 mvpp2_read(struct mvpp2 *priv, u32 offset);
 
-u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset);
-
 void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name);
 
 void mvpp2_dbgfs_cleanup(struct mvpp2 *priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f5edde2994e0..011bf9c5d105 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -83,7 +83,7 @@ u32 mvpp2_read(struct mvpp2 *priv, u32 offset)
 	return readl(priv->swth_base[0] + offset);
 }
 
-u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
+static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
 {
 	return readl_relaxed(priv->swth_base[0] + offset);
 }
-- 
2.17.1

