Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B46C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4304E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4304E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeIENqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:46:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39607 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIENqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:46:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ECA7920618; Wed,  5 Sep 2018 11:16:53 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id BCADA206F6;
        Wed,  5 Sep 2018 11:16:43 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 01/10] phy: Add MIPI D-PHY mode
Date:   Wed,  5 Sep 2018 11:16:32 +0200
Message-Id: <00e3d5da1ca3c03ba60350c1cf78ab44693ff493.1536138624.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPI D-PHY is a MIPI standard meant mostly for display and cameras in
embedded systems. Add a mode for it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aebdd348..9cba7fe16c23 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -40,6 +40,7 @@ enum phy_mode {
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
+	PHY_MODE_MIPI_DPHY,
 };
 
 /**
-- 
git-series 0.9.1
