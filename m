Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E66C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5A20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfBUJvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:51:37 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57949 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBUJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:51:36 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EB7F7C0006;
        Thu, 21 Feb 2019 09:51:30 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 0/7] net: phy: marvell10g: Add 2.5GBaseT
Date:   Thu, 21 Feb 2019 10:51:21 +0100
Message-Id: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing bits necessary to fully support 2.5GBaseT
in the Marvell Alaska PHYs.

The main points for that support are :

 - Making use of the .get_features call, recently introduced by Heiner
   and Andrew, that allows having a fully populated list of supported
   modes, including 2500BaseT.  

 - Configuring the MII to 2500BaseX when establishing a link at 2.5G

 - Adding a small quirk to take into account the fact that some PHYs in
   the family won't report the correct supported abilities

The rest of the series consists of small cosmetic improvements such as
using the correct helper to set a linkmode bit and adding macros for the
PHY ids.

We also add support for the 88E2110 PHY, which doesn't require the
quirk, and support for 2500BaseT in the PPv2 driver, in order to have a
fully working setup on the MacchiatoBin board.

Maxime Chevallier (7):
  net: phy: marvell10g: Use get_features to get the PHY abilities
  net: phy: marvell10g: Use linkmode_set_bit helper instead of __set_bit
  net: phy: marvell10g: Use 2500BASEX when using 2.5GBASET
  net: phy: marvell10g: Use a #define for 88X3310 family id
  net: phy: marvell10g: Force reading of 2.5/5G
  net: mvpp2: Add 2.5GBaseT support
  net: phy: marvell10g: add support for the 88x2110 PHY

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  1 +
 drivers/net/phy/marvell10g.c                  | 92 ++++++++++++++++---
 include/linux/marvell_phy.h                   |  2 +
 3 files changed, 81 insertions(+), 14 deletions(-)

-- 
2.19.2

