Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeBLMjw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:39:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933358AbeBLMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:39:51 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv4 0/2] Improved perf support for imx53/ppd
Date: Mon, 12 Feb 2018 13:39:43 +0100
Message-Id: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
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

Changes since PATCHV3:
 * Use readl_relaxed instead of __raw_readl (and the same for writel)
 * Drop final return in void function
 * Add Reviewed-by from Fabio to 2nd patch
Changes since PATCHv2:
 * Always enable GPC_DBG_EN when kernel configuration allows using perf
   to allow cleanup of the arm-pmu driver.
Changes since PATCHv1:
 * Update DTS patch to reference imx53.dtsi's pmu node
 * Remove a superfluous newline in first patch

-- Sebastian

Sebastian Reichel (2):
  ARM: imx53: add secure-reg-access support for PMU
  ARM: dts: imx53: PPD: Enable secure-reg-access

 arch/arm/boot/dts/imx53-ppd.dts |  4 ++++
 arch/arm/boot/dts/imx53.dtsi    |  2 +-
 arch/arm/mach-imx/mach-imx53.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.15.1
