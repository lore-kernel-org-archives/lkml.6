Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC69BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57A220863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfBZNm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:42:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43694 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBZNm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:42:26 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71A35200309;
        Tue, 26 Feb 2019 14:42:24 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64CD42001F0;
        Tue, 26 Feb 2019 14:42:24 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E209D205EB;
        Tue, 26 Feb 2019 14:42:23 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/4] enetc: Add mdio support and device tree nodes
Date:   Tue, 26 Feb 2019 15:42:19 +0200
Message-Id: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
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
v4: none

Claudiu Manoil (4):
  arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints
  arm64: dts: fsl: ls1028a-rdb: Add ENETC external eth ports for the
    LS1028A RDB board
  enetc: Add ENETC PF level external MDIO support
  dt-bindings: net: freescale: enetc: Add connection bindings for ENETC
    ethernet nodes

 .../devicetree/bindings/net/fsl-enetc.txt          |  69 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts  |  17 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  35 ++++
 drivers/net/ethernet/freescale/enetc/Makefile      |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c  | 199 +++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  12 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   6 +
 7 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c

-- 
2.7.4

