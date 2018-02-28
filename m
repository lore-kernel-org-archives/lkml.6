Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933548AbeB1ThE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:37:04 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45929 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeB1ThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:37:02 -0500
X-Google-Smtp-Source: AG47ELuKjMTm+BDtW76BBpmUQaSesAwMh5Gw9dDUM/Vlqs+I09w7KxlIooZBhr8ShwYxm55yf7Sn4A==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/5] net: phy: Reduce duplication
Date: Wed, 28 Feb 2018 11:36:07 -0800
Message-Id: <20180228193612.29409-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series reduces the duplication among 10G PHY drivers that just
essentially stub most functions, but do that while replicating what the existing
generic functions do.

Florian Fainelli (5):
  net: phy: aquantia: Utilize genphy_c45_aneg_done()
  net: phy: Export gen10g_* functions
  net: phy: teranetics: Utilize generic functions
  net: phy: cortina: Utilize generic functions
  net: phy: marvell10g: Utilize gen10g_soft_reset()

 drivers/net/phy/aquantia.c   | 20 ++++++--------------
 drivers/net/phy/cortina.c    | 18 +++---------------
 drivers/net/phy/marvell10g.c |  7 +------
 drivers/net/phy/phy-c45.c    | 18 ++++++++++++------
 drivers/net/phy/teranetics.c | 30 +++++-------------------------
 include/linux/phy.h          |  8 ++++++++
 6 files changed, 35 insertions(+), 66 deletions(-)

-- 
2.14.1
