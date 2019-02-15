Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC282192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395358AbfBOPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:36:27 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40045 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbfBOPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:17 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7166CE0007;
        Fri, 15 Feb 2019 15:35:13 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 00/13] net: mvpp2: various fixes
Date:   Fri, 15 Feb 2019 16:32:28 +0100
Message-Id: <20190215153241.6857-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series contains various fixes on bugs reported to us, or bugs I
stumbled upon while testing the various interface configurations I have
access to.

While this series contain fixes, it's sent to net-next as it is based
on top of Russell's rework and fixes he sent during the last 2 weeks
(such as his PPv2 phylink rework) that were applied to net-next. It'll
also allow the users to have more time to test those changes.

Thanks!
Antoine

Antoine Tenart (13):
  net: mvpp2: do not call phylink_mac_change if there is no event
  net: mvpp2: a port can be disabled even if we use the link IRQ
  net: mvpp2: do not disable the port if the mode hasn't changed
  net: mvpp2: reconfiguring the port interface is PPv2.2 specific
  net: mvpp2: do not set the XLG MAC in reset when disabling a port
  net: mvpp2: fix a typo in the header
  net: mvpp2: fix validate for PPv2.1
  net: mvpp2: fix the computation of the RXQs
  net: mvpp2: update the port documentation regarding the GoP
  net: mvpp2: reset the XPCS while reconfiguring the serdes lanes
  net: mvpp2: reset the XLG MAC in port_reset
  net: mvpp2: fix alignment of MVPP2_GMAC_CONFIG_MII_SPEED definition
  net: mvpp2: some AN fields require the link to be down when updated

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  9 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 98 ++++++++++++-------
 2 files changed, 66 insertions(+), 41 deletions(-)

-- 
2.20.1

