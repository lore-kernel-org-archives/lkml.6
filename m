Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA09EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880172075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfBVPEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:04:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35880 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfBVPEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:04:22 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D70651A01A7;
        Fri, 22 Feb 2019 16:04:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CAE161A01A6;
        Fri, 22 Feb 2019 16:04:20 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6608C2062B;
        Fri, 22 Feb 2019 16:04:20 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] enetc: Add mdio support and device tree nodes
Date:   Fri, 22 Feb 2019 17:04:15 +0200
Message-Id: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the missing part to enable PCI probing of the ENETC ethernet
ports on the LS1028A SoC and external traffic on the LS1028A RDB board.
It's one of the first items on the TODO list for the recently merged
ENETC ethernet driver.

v3: Add DT bindings doc for ENETC connections

Claudiu Manoil (4):
  arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints
  arm64: dts: fsl: ls1028a-rdb: Add ENETC external eth ports for the
    LS1028A RDB board
  enetc: Add ENETC PF level external MDIO support
  dt-bindings: net: freescale: enetc: Add connection bindings for ENETC
    ethernet nodes

 .../devicetree/bindings/net/fsl-enetc.txt          | 109 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts  |  17 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  33 ++++
 drivers/net/ethernet/freescale/enetc/Makefile      |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c  | 199 +++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  12 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   6 +
 7 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c

-- 
2.7.4

