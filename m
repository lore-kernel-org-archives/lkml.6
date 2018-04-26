Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDZVNr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:13:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53769 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeDZVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:13:44 -0400
X-Google-Smtp-Source: AB8JxZog4C6dGdcqGuVX/U7blXs2Fq+x5oAfhMOD8/CqpJtQiIMASRSSnpZozwrNRjNmv03j+RW9fQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>,
        linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
Date: Thu, 26 Apr 2018 23:13:35 +0200
Message-Id: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
However, several can drivers use 'int' as the return type
of their start_xmit() method.
This series contains the fix for all three of them.

Luc Van Oostenryck (3):
  can: janz-ican3: fix ican3_xmit()'s return type
  can: sun4i: fix sun4ican_start_xmit()'s return type
  can: xilinx: fix xcan_start_xmit()'s return type

 drivers/net/can/janz-ican3.c | 2 +-
 drivers/net/can/sun4i_can.c  | 2 +-
 drivers/net/can/xilinx_can.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.0
