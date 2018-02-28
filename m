Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeB1NLw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:11:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60471 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbeB1NLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:11:50 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@bootlin.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 0/3] add CPUs OPPs to sun8i a83t
Date: Wed, 28 Feb 2018 14:11:19 +0100
Message-Id: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Allwinner A83T is an octacore A7 divided in two clusters of 4 A7,
each cluster having its own regulator and clock.

Let's add the OPPs for each cluster so that we can use cpufreq on this SoC.

The operating points were found in Allwinner BSP and fex files and have
been tested on a TBS A711 with cpuburn and cpufreq-ljt-stress-test.

Note that there are a few OPPs that are missing:

1608000000Hz with 920000mV
1800000000Hz with 1000000mV
2016000000Hz with 1080000mV

These OPPs are pretty unstable but it might be due to the SoC quickly
overheating (till the board completely shuts down).
It seems[1] impossible to reach those frequencies with none or passive
cooling, so better leave them out by default.

It's still possible to add those OPPs on a per-board basis though.

[1] http://linux-sunxi.org/User:Tkaiser#First_steps_with_Banana_Pi_M3

Thanks,
Quentin

Quentin Schulz (3):
  ARM: dts: sun8i: a83t: add cpu0 and cpu100 labels
  ARM: dts: sun8i: a711: set regulator for each cluster of CPUs
  ARM: dts: sun8i: a83t: add stable OPP tables and CPUfreq

 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts |   9 ++-
 arch/arm/boot/dts/sun8i-a83t.dtsi         | 122 ++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 2 deletions(-)

base-commit: 827ad482fda17d0de5df5116fda827cd3671e62e
-- 
git-series 0.9.1
