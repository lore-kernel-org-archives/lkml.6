Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeBGNqK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:46:10 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39491 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeBGNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:06 -0500
X-Google-Smtp-Source: AH8x226FHh8uw2p/O2w1UR6wgDeDuUHxs3Wnvtxe8/8g6TapsJp+ySXhjT/sRmSN6YWBTV6sKiar8g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/7] ARM: davinci: add genpd support
Date: Wed,  7 Feb 2018 14:45:46 +0100
Message-Id: <20180207134553.13510-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar et al,

please take a look at the following patches. They add a simple genpd
driver and use it in DT mode on da850 boards.

I was trying to use genpd in legacy mode too, but couldn't find neither
any interfaces nor users that would do that. For now I added a check in
arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
we're using genpd.

This series applies on top of and has been tested with David Lechner's
for-bartosz branch. It fixes the clock look-up issues we faced with
lcdc and emac.

Bartosz Golaszewski (7):
  dt-bindings: soc: new driver for DaVinci genpd
  soc: davinci: new genpd driver
  ARM: davinci: don't setup pm_clk if we're using genpd
  ARM: dts: da850: add power controller nodes
  ARM: dts: da850: add power-domains properties to device nodes
  ARM: davinci: select generic power domains for DaVinci in DT mode
  ARM: davinci_all_defconfig: select the DaVinci genpd driver in DT mode

 .../bindings/soc/ti,davinci-pm-domains.txt         |  13 +++
 arch/arm/boot/dts/da850.dtsi                       |  46 ++++++++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/Kconfig                      |   1 +
 arch/arm/mach-davinci/pm_domain.c                  |   9 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/davinci/Kconfig                        |  16 +++
 drivers/soc/davinci/Makefile                       |   1 +
 drivers/soc/davinci/davinci_pm_domains.c           | 125 +++++++++++++++++++++
 10 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
 create mode 100644 drivers/soc/davinci/Kconfig
 create mode 100644 drivers/soc/davinci/Makefile
 create mode 100644 drivers/soc/davinci/davinci_pm_domains.c

-- 
2.16.1
