Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68233C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2196F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2196F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935951AbeFRIXt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935922AbeFRIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7557AC8D;
        Mon, 18 Jun 2018 08:23:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhadram Varka <vbhadram@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 184/279] net: phy: broadcom: add support for BCM89610 PHY
Date:   Mon, 18 Jun 2018 10:12:49 +0200
Message-Id: <20180618080616.561941277@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bhadram Varka <vbhadram@nvidia.com>

[ Upstream commit 23b8392201e0681b76630c4cea68e1a2e1821ec6 ]

It adds support for BCM89610 (Single-Port 10/100/1000BASE-T)
transceiver which is used in P3310 Tegra186 platform.

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/broadcom.c |   10 ++++++++++
 include/linux/brcmphy.h    |    1 +
 2 files changed, 11 insertions(+)

--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -720,6 +720,15 @@ static struct phy_driver broadcom_driver
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm53xx_phy_get_stats,
 	.probe		= bcm53xx_phy_probe,
+}, {
+	.phy_id         = PHY_ID_BCM89610,
+	.phy_id_mask    = 0xfffffff0,
+	.name           = "Broadcom BCM89610",
+	.features       = PHY_GBIT_FEATURES,
+	.flags          = PHY_HAS_INTERRUPT,
+	.config_init    = bcm54xx_config_init,
+	.ack_interrupt  = bcm_phy_ack_intr,
+	.config_intr    = bcm_phy_config_intr,
 } };
 
 module_phy_driver(broadcom_drivers);
@@ -741,6 +750,7 @@ static struct mdio_device_id __maybe_unu
 	{ PHY_ID_BCMAC131, 0xfffffff0 },
 	{ PHY_ID_BCM5241, 0xfffffff0 },
 	{ PHY_ID_BCM5395, 0xfffffff0 },
+	{ PHY_ID_BCM89610, 0xfffffff0 },
 	{ }
 };
 
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -25,6 +25,7 @@
 #define PHY_ID_BCM54612E		0x03625e60
 #define PHY_ID_BCM54616S		0x03625d10
 #define PHY_ID_BCM57780			0x03625d90
+#define PHY_ID_BCM89610			0x03625cd0
 
 #define PHY_ID_BCM7250			0xae025280
 #define PHY_ID_BCM7260			0xae025190


