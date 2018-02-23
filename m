Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeBWVBJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:01:09 -0500
Received: from muru.com ([72.249.23.125]:57992 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeBWVBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:01:07 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/12] Use dts data for ti-sysc to configure sysconfig
Date: Fri, 23 Feb 2018 13:00:48 -0800
Message-Id: <20180223210100.86732-1-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series of changes makes ti-sysc driver to use device tree data for
configuring the interconnect target module registers. We already have
smartreflex dts data configured according to the binding for ti-sysc,
so that will be the first user.

I've added code to check the dts data against the existing platform
data to make sure we're not causing regressions. And I've verified
that PM still works.

Regards,

Tony


Tony Lindgren (12):
  bus: ti-sysc: Add fck clock alias for children with notifier_block
  bus: ti-sysc: Add suspend and resume handling
  bus: ti-sysc: Handle stdout-path for debug console
  bus: ti-sysc: Improve handling for no-reset-on-init and
    no-idle-on-init
  bus: ti-sysc: Remove unnecessary debugging statements
  bus: ti-sysc: Add support for platform data callbacks
  bus: ti-sysc: Handle some devices in omap_device compatible way
  ARM: OMAP2+: Add functions to allocate module data from device tree
  ARM: OMAP2+: Add checks for device tree based sysconfig data
  ARM: OMAP2+: Try to parse earlycon from parent too
  PM / AVS: SmartReflex: Prepare to use device tree based probing
  ARM: OMAP2+: Enable ti-sysc to use device tree data for smartreflex

 arch/arm/mach-omap2/board-n8x0.c      |   4 +-
 arch/arm/mach-omap2/omap_device.c     |   5 +
 arch/arm/mach-omap2/omap_hwmod.c      | 418 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.h      |   7 +
 arch/arm/mach-omap2/pdata-quirks.c    |  41 ++-
 arch/arm/mach-omap2/sr_device.c       |  25 +-
 drivers/bus/ti-sysc.c                 | 527 +++++++++++++++++++++++++++++++---
 drivers/power/avs/smartreflex.c       |  41 ++-
 include/linux/platform_data/ti-sysc.h |  50 ++++
 9 files changed, 1063 insertions(+), 55 deletions(-)

-- 
2.16.2
