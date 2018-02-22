Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBVTGh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:06:37 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44280 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:06:36 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] R-Car M3-N DTS fixes
Date: Thu, 22 Feb 2018 20:06:04 +0100
Message-Id: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon, Arnd,

    The recently introduced Renesas R-Car M3-N SoC device tree source file is
included from salvator-x[s]-$SOC.dts, and it thus needs place holders for
devices not yet enabled but whose nodes are referenced by those common files.

When first submitted r8a77965.dtsi I ignored DTC compiler warnings as I
(wrongly) assumed it was fine to have place-holders with missing properties or
labels.

As DTC warnings have to be silenced in order to have M3-N device tree sources
accepted, this series address all warnings and make DTC happy even with
place holders.

Simon: up to you if you like to squash this on top of my previous series when
picking that one up. To ease your job I have based this series on all patches
I sent in v2 but the still debated ether-avb one. I thus left the avb node
unpopulated and added just the required properties to silence DTC warnings
to it in this series.

Development branch based on: (renesas-drivers-2018-02-13-v4.16-rc1 +
M3-N v2 patches - ether-avb) where to apply this series on is available at:
git://jmondi.org/linux m3-n/renesas-drivers-2018-02-13-v4.16-rc1/v2-simon

Thanks
  j

Jacopo Mondi (6):
  arm64: dts: renesas: r8a77965: Add "reg" properties
  arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
  arm64: dts: renesas: r8a77965: Remove stale reg property
  arm64: dts: renesas: r8a77965: Add #phy-cells property
  arm64: dts: renesas: r8a77965: Add #pwm-cells property
  arm64: dts: renesas: r8a77965: Add #interrupt-cells property

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 77 ++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

--
2.7.4
