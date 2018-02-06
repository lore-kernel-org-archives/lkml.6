Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBFO0l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:26:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34400 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeBFO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:26:33 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/3] Improved perf support for imx53/ppd
Date: Tue,  6 Feb 2018 15:26:26 +0100
Message-Id: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This improves perf on imx53 by adding support for enabling the Secure
Debug Enable Register (SDER) SUNIDEN bit. This unlocks new
functionality:

ppd before patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
                 0      instructions              #    0.00  insn per cycle

ppd  after patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
            177864      instructions              #    0.05  insn per cycle

Changes since PATCHv1:
 * Update DTS patch to reference imx53.dtsi's pmu node
 * Remove a superfluous newline in first patch

-- Sebastian

Peter Senna Tschudin (2):
  ARM: imx53: add SoC specific PMU setup
  ARM: dts: imx53: PPD: Enable secure-reg-access

Sebastian Reichel (1):
  drivers/perf: arm_pmu: Add platform hardware setup hooks.

 arch/arm/boot/dts/imx53-ppd.dts |  4 +++
 arch/arm/boot/dts/imx53.dtsi    |  2 +-
 arch/arm/mach-imx/mach-imx53.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c          | 12 ++++++++
 include/linux/perf/arm_pmu.h    |  5 +++
 5 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.15.1
