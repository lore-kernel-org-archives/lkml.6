Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeCFN5B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:57:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34938 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFN5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:57:00 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/7] drm/sun4i: Allwinner MIPI-DSI support
Date: Tue,  6 Mar 2018 14:55:57 +0100
Message-Id: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an preliminary version of the MIPI-DSI support for the Allwinner
SoCs.

This controller can be found on a number of recent SoCs, such as the
A31, A33 or the A64.

Given the sparse documentation, there's a number of obscure areas, but
the current implementation has been tested with a 4-lanes DSI panel on
an A33.

The support is a bit rough around the edges at the time, and some artifacts
are still shown on the screen for some reasons. Wider testing with
different display will hopefully nail those down.

Let me know what you think,
Maxime

Changes from v2:
  - Added a ports node under the DSI node
  - Changed the huarui panel driver to an ili9881c driver
  - Changed the panel vendor to bananapi
  - Made the init table static in the panel driver
  - Dropped the huarui vendor patch for the DT doc.

Changes from v1:
  - Rebased on 4.16-rc1
  - Constified a few function arguments and structures
  - Reworked the DT binding example a bit
  - Reworked the panel driver to check for DSI return codes, and use DCS
    helpers when possible

Maxime Ripard (7):
  drm/sun4i: tcon: Add TRI finish interrupt for vblank
  dt-bindings: display: Add Allwinner MIPI-DSI bindings
  drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
  dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
  drm/panel: Add Ilitek ILI9881c panel driver
  arm: dts: sun8i: a33: Add the DSI-related nodes
  [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt |   20 +-
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt       |   93 ++++++-
 arch/arm/boot/dts/sun8i-a33.dtsi                                    |   44 +++-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                        |   39 +++-
 drivers/gpu/drm/panel/Kconfig                                       |    9 +-
 drivers/gpu/drm/panel/Makefile                                      |    1 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                       |  506 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/Kconfig                                       |   10 +-
 drivers/gpu/drm/sun4i/Makefile                                      |    4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                  |  111 ++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                                  |   46 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                             |  297 +++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                              | 1111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                              |   67 ++++-
 14 files changed, 2355 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h

base-commit: 37746b935fb2b75cd3aa014e08f959e0321bde59
-- 
git-series 0.9.1
