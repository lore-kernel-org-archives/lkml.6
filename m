Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE0A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE0A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeINNr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34112 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeINNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E6DC820877; Fri, 14 Sep 2018 10:34:01 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id B40CF20731;
        Fri, 14 Sep 2018 10:34:01 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 0/5] Various improvements to Microsemi PHY driver
Date:   Fri, 14 Sep 2018 10:33:42 +0200
Message-Id: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi PHYs have several counters so let's make them available as PHY
statistics.

The VSC 8530/31/40/41 also need to update their EEE init sequence in order to
avoid packet losses and improve performance.

This patch series also makes some minor cosmetic changes to the driver.

Quentin Schulz (3):
  net: phy: mscc: remove unneeded parenthesis
  net: phy: mscc: shorten `x != 0` condition to `x`
  net: phy: mscc: remove unneeded temporary variable

Raju Lakkaraju (2):
  net: phy: mscc: add ethtool statistics counters
  net: phy: mscc: Add EEE init sequence

 drivers/net/phy/mscc.c | 229 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 202 insertions(+), 27 deletions(-)

base-commit: 00989856964175eafbe1435a70862c2ac66cffc0
-- 
git-series 0.9.1
