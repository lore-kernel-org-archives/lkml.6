Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEPSxO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:53:14 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35375 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeEPSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:53:11 -0400
X-Google-Smtp-Source: AB8JxZp8vGaTRTXB70WwO8EYIn73Stk6wMQUmD1d+k5R41z3sP9TUhfn6MQ0b1Yb8nM4rqibveI5yA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: fugang.duan@nxp.com, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 0/3]  net: Allow more drivers with COMPILE_TEST
Date: Wed, 16 May 2018 11:52:55 -0700
Message-Id: <20180516185258.20508-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

This patch series includes more drivers to be build tested with COMPILE_TEST
enabled. This helps cover some of the issues I just ran into with missing
a driver *sigh*.

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
 drivers/net/ethernet/ti/Kconfig           | 14 +++++++-------
 drivers/net/phy/Kconfig                   |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.14.1
