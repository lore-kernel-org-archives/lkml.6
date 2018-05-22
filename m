Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeEVKSw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:18:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51485 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbeEVKSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:18:34 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 0/3] net: sfp: small improvements
Date: Tue, 22 May 2018 12:17:58 +0200
Message-Id: <20180522101801.18947-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, David,

A small series of patches improving the SFP support by adding a warning
when no Tx disable pin is available, and making the i2c-bus property
mandatory.

Thanks!
Antoine

Since v1:
  - Removed the patch fixing the sfp driver when no i2c bus was described.
  - Made two new patches to make the i2c-bus property mandatory for sfp modules.

Since the phylink series:
  - s/-EOPNOTSUPP/-ENODEV/ in patch 1/2.
  - I added the acked-by tag in patch 2/2.

Antoine Tenart (3):
  net: phy: sfp: warn the user when no tx_disable pin is available
  net: phy: sfp: make the i2c-bus dt property mandatory
  Documentation/bindings: net: the sfp i2c-bus property is now mandatory

 .../devicetree/bindings/net/sff,sfp.txt       |  4 +-
 drivers/net/phy/sfp.c                         | 37 ++++++++++++-------
 2 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.17.0
