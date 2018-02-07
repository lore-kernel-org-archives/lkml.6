Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeBGOdN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:33:13 -0500
Received: from foss.arm.com ([217.140.101.70]:51628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754026AbeBGOdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:33:11 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] irqchip: GICv2m Multi-MSI support
Date: Wed,  7 Feb 2018 14:32:53 +0000
Message-Id: <20180207143255.17003-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been recently reported that GICv2m doesn't handle the Multi-MSI
variant (it only deals with a single MSI, or the full blown
MSI-X). For better or worse, Multi-MSI is still a thing, and it'd be
better if we dealt with it.

This tiny series aims at teaching this old trick to GICv2m, together
with an extra patch that enables all the v2m regions on Juno. if
nobody objects to this, I plan to take at least the initial patch
through the irqchip tree, and potentially the DT as well if people
want me to.

Marc Zyngier (1):
  irqchip/gic-v2m: Add PCI Multi-MSI support

Robin Murphy (1):
  arm64: dts: juno: Describe the full GICv2m region

 arch/arm64/boot/dts/arm/juno-base.dtsi | 19 ++++++++++++++
 drivers/irqchip/irq-gic-v2m.c          | 46 ++++++++++++++++------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.14.2
