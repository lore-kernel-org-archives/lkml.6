Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeEKC2C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:28:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32845 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752040AbeEKC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:28:01 -0400
X-ME-Sender: <xms:sP_0WiCm3zs2EFz6Sx9YubqjSpzKz8U91aq8kt1Ty0_cPU-9zx6MsQ>
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] Allwinner A64 timer workaround
Date: Thu, 10 May 2018 21:27:49 -0500
Message-Id: <20180511022751.9096-1-samuel@sholland.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Several people (including me) have experienced extremely large system
clock jumps on their A64-based devices, apparently due to the
architectural timer going backward, which is interpreted by Linux as
the timer wrapping around after 2^56 cycles.

Investigation led to discovery of some obvious problems with this SoC's
architectural timer, and this patch series introduces what I believe is
the simplest workaround. More details are in the commit message for
patch 1. Patch 2 simply enables the workaround in the device tree.

Thanks,
Samuel

Samuel Holland (2):
  arm64: arch_timer: Workaround for Allwinner A64 timer instability
  arm64: dts: allwinner: a64: Enable A64 timer workaround

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
 drivers/clocksource/Kconfig                   | 11 ++++++++
 drivers/clocksource/arm_arch_timer.c          | 39 +++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

--
2.16.1
