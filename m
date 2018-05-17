Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeEQUHv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:07:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46024 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:07:50 -0400
X-Google-Smtp-Source: AB8JxZp7MutrKiRoZ3Q02yrTksNN81Nj0NsH9jLPA17hygwE3wvj0IY9OAOruEM5/BvsWRq24OWzyw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: fugang.duan@nxp.com, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 0/3] net: Allow more drivers with COMPILE_TEST
Date: Thu, 17 May 2018 13:07:42 -0700
Message-Id: <20180517200745.19142-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

This patch series includes more drivers to be build tested with COMPILE_TEST
enabled. This helps cover some of the issues I just ran into with missing
a driver *sigh*.

Chanves in v3:

- drop the TI Keystone NETCP driver from the COMPILE_TEST additions

Changes in v2:

- allow FEC to build outside of CONFIG_ARM/ARM64 by defining a layout of
  registers, this is not meant to run, so this is not a real issue if we
  are not matching the correct register layout


Florian Fainelli (3):
  net: ethernet: ti: Allow most drivers with COMPILE_TEST
  net: ethernet: freescale: Allow FEC with COMPILE_TEST
  net: phy: Allow MDIO_MOXART and MDIO_SUN4I with COMPILE_TEST

 drivers/net/ethernet/freescale/Kconfig    |  2 +-
 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c |  2 +-
 drivers/net/ethernet/ti/Kconfig           | 12 ++++++------
 drivers/net/phy/Kconfig                   |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.14.1
