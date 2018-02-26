Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeBZR5i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:57:38 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39743 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeBZR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:57:37 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] R-Car M3-N: Enable EtherAVB device node
Date: Mon, 26 Feb 2018 18:57:08 +0100
Message-Id: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,
  as discussed with you Sergei and Geert, in order to enable EtherAVB for
R8A77965 we first wanted to make the phy-mode "rgmii-txid" a board specific
property for all other SoCs.

This series adds  the phy-mode property to salvator-common.dtsi and reset the
one for R8A77965/R8A7796/R8A77995 to "rgmii".

Then, in order to enable EtherAVB for R-Car M3-N, iommu nodes had to be added
as they are referenced by the "avb" device node (CC the iommu list for the
series for that reason).

Series based on what you already applied to your development tree (M3-N initial
support - EtherAVB + DTS fixes). A branch for testing is available at

git://jmondi.org/linux m3-n/renesas-drivers-2018-02-13-v4.16-rc1/v2-simon

Thanks
   j

Jacopo Mondi (8):
  arm64: dts: renesas: salvator-common: Override EtherAVB phy-mode
  arm64: dts: renesas: r8a7796: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a7795: Set EtherAVB phy mode to "rgmii"
  arm64: dts: renesas: r8a77995: Set EtherAVB phy mode to "rgmii"
  dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
  iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code
  arm64: dts: renesas: r8a77965: Add IPMMU mm and ds0 blocks
  arm64: dts: renesas: r8a77965: Add EtherAVB device node

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 61 ++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  1 +
 drivers/iommu/ipmmu-vmsa.c                         |  5 ++
 7 files changed, 68 insertions(+), 6 deletions(-)

--
2.7.4
