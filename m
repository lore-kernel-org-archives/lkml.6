Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeC1WoX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:44:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37393 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeC1WoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:44:21 -0400
X-Google-Smtp-Source: AIpwx487xc235e+LPk/esuhcEFVgzjbmvMBUKQiNvLhYRKyjERRu8HFpgfZnbdKm38GYRrMDpL46zA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list),
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH net-next v2 0/2] phylink: API changes
Date: Wed, 28 Mar 2018 15:44:14 -0700
Message-Id: <20180328224416.6981-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series contains two API changes to PHYLINK which will later be used
by DSA to migrate to PHYLINK. Because these are API changes that impact other
outstanding work (e.g: MVPP2) I would rather get them included sooner to minimize
conflicts.

Thank you!

Changes in v2:

- added missing documentation to mac_link_{up,down} that the interface
  must be configured in mac_config()

- added Russell's, Andrew's and my tags

Florian Fainelli (1):
  net: phy: phylink: Provide PHY interface to mac_link_{up,down}

Russell King (1):
  sfp/phylink: move module EEPROM ethtool access into netdev core
    ethtool

 drivers/net/ethernet/marvell/mvneta.c | 22 +++-------------------
 drivers/net/phy/phylink.c             | 32 +++-----------------------------
 drivers/net/phy/sfp-bus.c             |  6 ++----
 include/linux/netdevice.h             |  3 +++
 include/linux/phylink.h               | 17 +++++++++++------
 net/core/ethtool.c                    |  7 +++++++
 6 files changed, 29 insertions(+), 58 deletions(-)

-- 
2.14.1
