Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeB1C1T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:27:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46597 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751453AbeB1C1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:27:17 -0500
X-ME-Sender: <xms:hBOWWvGKsIENk6nk0KiArETYOi_SFuopeHWNiqMJQha4r_z6-cIORA>
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/3] Allwinner sunxi message box support
Date: Tue, 27 Feb 2018 20:27:11 -0600
Message-Id: <20180228022714.30068-1-samuel@sholland.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the "hardware message box" in recent
Allwinner sunxi SoCs, used for communication with the ARISC management
processor (the platform's equivalent of the ARM SCP). The end goal is to
use the arm_scpi driver as a client, communicating with firmware running
on the ARISC CPU.

This driver has been tested with the base arm_scpi driver (which sends
the SCPI_CMD_SCPI_CAPABILITIES command at probe time) and an in-progress
firmware application running on the ARISC CPU. Because no firmware for
the other end of the mailbox is complete at the moment, I have not
included changes to the SoC device trees.

The second patch in the series fixes an issue in the mailbox framework
discovered while writing this driver. It is a re-send of a patch I
originally sent by itself in January.

Samuel Holland (3):
  dt-bindings: Add a binding for the sunxi message box
  mailbox: Avoid NULL dereference in mbox_chan_received_data
  mailbox: sunxi-msgbox: Add a new mailbox driver

 .../devicetree/bindings/mailbox/sunxi-msgbox.txt   |  40 +++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox.c                          |   6 +-
 drivers/mailbox/sunxi-msgbox.c                     | 323 +++++++++++++++++++++
 5 files changed, 376 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

-- 
2.13.6
