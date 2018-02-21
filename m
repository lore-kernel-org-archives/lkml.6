Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeBUJUw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:20:52 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54438 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbeBUJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:20:50 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 00/10] drm/sun4i: Allwinner MIPI-DSI support
Date: Wed, 21 Feb 2018 10:20:24 +0100
Message-Id: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
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

Changes from v1:
  - Rebased on 4.16-rc1
  - Constified a few function arguments and structures
  - Reworked the DT binding example a bit
  - Reworked the panel driver to check for DSI return codes, and use DCS
    helpers when possible

Maxime Ripard (10):
  regmap: mmio: Add function to attach a clock
  drm/sun4i: tcon: Add TRI finish interrupt for vblank
  drm/sun4i: Protect the TCON pixel clocks
  dt-bindings: display: Add Allwinner MIPI-DSI bindings
  drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
  dt-bindings: vendor: Add Huarui Lighting
  dt-bindings: panel: Add Huarui LHR050H41 panel documentation
  drm/panel: Add Huarui LHR050H41 panel driver
  arm: dts: sun8i: a33: Add the DSI-related nodes
  [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt |   19 +-
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt        |   84 +++++-
 Documentation/devicetree/bindings/vendor-prefixes.txt                |    1 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                                     |   35 ++-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                         |   39 +++-
 drivers/base/regmap/regmap-mmio.c                                    |   24 ++-
 drivers/gpu/drm/panel/Kconfig                                        |    9 +-
 drivers/gpu/drm/panel/Makefile                                       |    1 +-
 drivers/gpu/drm/panel/panel-huarui-lhr050h41.c                       |  506 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/Kconfig                                        |   10 +-
 drivers/gpu/drm/sun4i/Makefile                                       |    4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                   |  115 ++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                                   |   46 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                              |  297 +++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                               | 1111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                               |   67 ++++-
 include/linux/regmap.h                                               |    3 +-
 17 files changed, 2366 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
 create mode 100644 drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h

base-commit: 91ab883eb21325ad80f3473633f794c78ac87f51
-- 
git-series 0.9.1
