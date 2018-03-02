Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163648AbeCBAJL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:09:11 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46701 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163111AbeCBAJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:09:10 -0500
X-Google-Smtp-Source: AG47ELsRwMsbjvTZQS4ohbKsUsJobt0QHQ3O7VgfZNBf0rG1XxyOuOHCHdvA1nL/JMZAaJktyWMqrQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v3 0/5] net: phy: Reduce duplication
Date: Thu,  1 Mar 2018 16:08:54 -0800
Message-Id: <20180302000859.17309-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series reduces the duplication among 10G PHY drivers that just
essentially stub most functions, but do that while replicating what the existing
generic functions do.

Changes in v3:

- removed unused "reg" variable in teranetics.c
- fixed subject for patch 5 since we actually use gen10g_no_soft_reset()

Changes in v2:

- rename gen10g_soft_reset() to gen10g_no_soft_reset() to better illustrate
  what it does (or does not)
- removed stray comment in marvell10g.c

Florian Fainelli (5):
  net: phy: aquantia: Utilize genphy_c45_aneg_done()
  net: phy: Export gen10g_* functions
  net: phy: teranetics: Utilize generic functions
  net: phy: cortina: Utilize generic functions
  net: phy: marvell10g: Utilize gen10g_no_soft_reset()

 drivers/net/phy/aquantia.c   | 20 ++++++--------------
 drivers/net/phy/cortina.c    | 18 +++---------------
 drivers/net/phy/marvell10g.c | 11 +----------
 drivers/net/phy/phy-c45.c    | 20 +++++++++++++-------
 drivers/net/phy/teranetics.c | 32 +++++---------------------------
 include/linux/phy.h          |  8 ++++++++
 6 files changed, 36 insertions(+), 73 deletions(-)

-- 
2.14.1
