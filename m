Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDEVRQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:17:16 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36916 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDEVRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:17:15 -0400
X-Google-Smtp-Source: AIpwx4/tNf/pp6GWuwXrCYQOfLRsTbzvO2sbjbAUlsk4hRvEHIT/QQ+cngdGF0p1zIR1HEszQXLlhTop9yfa9Pdf0z0=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 23:17:13 +0200
X-Google-Sender-Auth: 2Iu89-YaCa4NiKwNu8CTmrfe7CQ
Message-ID: <CAK8P3a0zV6V=RjPes-uyv3k_M0gZWgHtn7vpyDPpokmjw0aM0Q@mail.gmail.com>
Subject: [GIT PULL 0/3] ARM: SoC changes for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This time we have just under 1000 non-merge changesets,
merged from 93 branches.

We added one new 32-bit ARM platform (Nuvoton NPCM),
but was a bit careless when I first merged those patches, so I
applied some last minute fixups today that didn't go through
linux-next first. I considered reverting the new platform
instead, but in the end decided to keep it and apply the
fixes given that we are not regressing on the other platforms
here.

The rest is quite normal, maybe a bit bigger than the last
few cycles that felt quiet to me. We have a few new SoC
variants for existing platforms: Allwinner H6, NVIDIA
Tegra194 (Xavier) and the ST STM32MPU family as a
variation of the STM32 MCU series. The actual pull
requests give more details about the changes.

Of the overall patch size, about three quarters are now
from device tree patches.

=== Top contributors by number of patches ===

     39 Tony Lindgren
     37 Fabio Estevam
     30 Simon Horman
     30 Gregory CLEMENT
     28 Jacopo Mondi
     26 Sudeep Holla
     24 Patrice Chotard
     23 Sean Wang
     22 Geert Uytterhoeven
     21 Sergei Shtylyov
     21 Chen-Yu Tsai
     19 Michal Simek
     18 Stefan Agner
     15 Marcel Ziswiler
     14 Maciej Purski
     14 Bartosz Golaszewski
     14 Arnd Bergmann
     13 Dave Gerlach
     12 Linus Walleij
     12 Joel Stanley
     12 Heiner Kallweit

=== Dirstat ===

   0.1% Documentation/arm/Microchip/
   0.3% Documentation/arm/stm32/
   0.5% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/
  57.2% arch/arm/boot/dts/
   0.3% arch/arm/configs/
   0.4% arch/arm/mach-davinci/
   0.4% arch/arm/mach-imx/
   0.1% arch/arm/mach-npcm/
   2.3% arch/arm/mach-omap2/
   0.1% arch/arm/mach-pxa/
   0.1% arch/arm/mach-shmobile/
   1.1% arch/arm/mach-sunxi/
   0.9% arch/arm/
   0.8% arch/arm64/boot/dts/allwinner/
   3.3% arch/arm64/boot/dts/amlogic/
   0.1% arch/arm64/boot/dts/exynos/
   0.4% arch/arm64/boot/dts/freescale/
   0.2% arch/arm64/boot/dts/hisilicon/
   2.3% arch/arm64/boot/dts/marvell/
   1.3% arch/arm64/boot/dts/mediatek/
   0.7% arch/arm64/boot/dts/nvidia/
   0.1% arch/arm64/boot/dts/qcom/
   2.8% arch/arm64/boot/dts/renesas/
   1.0% arch/arm64/boot/dts/rockchip/
   0.6% arch/arm64/boot/dts/socionext/
   0.3% arch/arm64/boot/dts/sprd/
   2.7% arch/arm64/boot/dts/xilinx/
   3.0% drivers/bus/
   0.2% drivers/clk/
   0.3% drivers/clocksource/
   0.3% drivers/cpufreq/
   3.5% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/tegra/
   0.5% drivers/firmware/
   0.2% drivers/hwmon/
   2.7% drivers/mtd/nand/
   2.4% drivers/perf/
   0.3% drivers/reset/
   0.1% drivers/soc/mediatek/
   0.3% drivers/soc/renesas/
   0.1% drivers/soc/rockchip/
   0.1% drivers/soc/tegra/
   0.4% drivers/soc/ti/
   0.3% drivers/
   0.1% include/clocksource/
   0.5% include/dt-bindings/clock/
   0.1% include/dt-bindings/power/
   0.3% include/dt-bindings/reset/
   0.3% include/linux/platform_data/
   0.5% include/linux/
 1147 files changed, 51976 insertions(+), 26653 deletions(-)
