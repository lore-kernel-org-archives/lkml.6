Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754498AbeCHPAb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:00:31 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47228 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754302AbeCHPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:00:28 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] ARM: sunxi: Clean and improvements for multi-cluster SMP
Date: Thu,  8 Mar 2018 23:00:08 +0800
Message-Id: <20180308150012.19045-1-wens@csie.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a bit of cleanup and improvement for the new
multi-cluster SMP code for Allwinner A80 and A83T (soon) SoCs.

The first patch is just a typo fix.

The second and third patch add the use of the "enable-method" cpu
property to enable SMP, instead of matching against the machine
compatible. However, due to how init calls are sequenced, we still
need to use a platform early_init call.

The last patch splits out parts of the SoC-specific init code, i.e.
the device node matching parts. This should help with Mylene's work
on adding support for the A83T.

Please have a look.

Regards
ChenYu

Chen-Yu Tsai (4):
  ARM: sunxi: mc-smp: Fix "lookback" typo
  ARM: sunxi: mc-smp: Use DT enable-method for sun9i A80 SMP
  ARM: dts: sun9i: Add enable-method for SMP support for the A80 SoC
  ARM: sunxi: mc-smp: Split out SoC-specific device node lookup sequence

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm/boot/dts/sun9i-a80.dtsi               |   8 ++
 arch/arm/mach-sunxi/mc_smp.c                   | 147 ++++++++++++++++++-------
 3 files changed, 115 insertions(+), 41 deletions(-)

-- 
2.16.2
