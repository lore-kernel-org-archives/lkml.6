Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeERJqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:46:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33579 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeERJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:45:57 -0400
X-Google-Smtp-Source: AB8JxZpqX1iJzKquBy5OdYUYH0se5DFhZwtOx6LTE71UNwA3Ipbg0E25uQvv9SfvU39wn9EpUo8Jrw==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 00/26] arm64: allwinner: Add A64 DE2 HDMI support
Date: Fri, 18 May 2018 15:15:10 +0530
Message-Id: <20180518094536.17201-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.

A64 behaviour similar to Allwinner A83T where
Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
Mixer1 => TCON1 => HDMI
as per Display System Block DiagramAllwinner_A64_User_Manual_V1.1.pdf

This is second patch-set followed with previous RFC[1] and first series[2]
and merely concentrated on HDMI pipeline through TCON1 and rest will add eventually.

This series fixed previous version comments
- about documenting fallback compatibles
- adding new compatible for mixer1
- support for multiple DW HDMI PHY clock parents (thanks, to Jernej)

Note:
Pine64 boards are unable to get edid by default like other A64 boards,
but forcing 'video=HDMI-A-1:1920x1080@60D' kernel command line can
create edid with display on penel.

Log:
[    1.613196] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
[    1.620764] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    1.628612] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
[    1.637677] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_ph
y)
[    1.647699] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
[    1.656090] [drm] forcing HDMI-A-1 connector on
[    1.660664] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
[    1.668063] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.674684] [drm] No driver support for vblank timestamp query.
[    2.497502] Console: switching to colour frame buffer device 240x67
[    2.551795] sun4i-drm display-engine: fb0:  frame buffer device
[    2.558166] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0

[2] https://lkml.org/lkml/2018/4/30/288
[1] https://lkml.org/lkml/2018/4/24/547

Icenowy Zheng (1):
  drm: sun4i: add support for HVCC regulator for DWC HDMI glue

Jagan Teki (22):
  dt-bindings: clock: Add compatible for A64 DE2 CCU
  arm64: dts: allwinner: a64: Add DE2 CCU
  clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
  clk: sunxi-ng: a64: Add minimal rate for video PLLs
  drm/sun4i: Add support for A64 mixer1
  dt-bindings: display: Add compatible for A64 DE2 tcon1 blocks
  drm/sun4i: Add support for A64 display engine
  arm64: dts: allwinner: a64: Add DE2 tcon1 pipeline
  drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
  arm64: defconfig: Enable CONFIG_DRM_SUN4I
  dt-bindings: display: Add compatible for A64 HDMI
  dt-bindings: display: Add compatible for A64 HDMI PHY
  dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
  arm64: dts: allwinner: a64: Add HDMI support
  drm/sun4i: Enable DesignWare HDMI for SUN8I and SUN50I
  arm64: dts: allwinner: a64: Add HDMI pipeline
  arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output
  arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
  arm64: dts: allwinner: a64: orangepi-win: Enable HDMI output
  arm64: dts: allwinner: a64: a64-olinuxino: Enable HDMI output
  arm64: dts: allwinner: a64: pine64: Enable HDMI output
  arm64: dts: allwinner: a64: sopine: Enable HDMI output

Jernej Skrabec (3):
  drm/sun4i: DE2 mixer: Add index quirk
  drm/sun4i: Add support for multiple DW HDMI PHY clock parents
  drm/sun4i: Add support for A64 HDMI PHY

 .../devicetree/bindings/clock/sun8i-de2.txt        |   1 +
 .../bindings/display/sunxi/sun4i-drm.txt           |   5 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  26 +++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  26 +++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  26 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 124 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   2 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |  46 ++++----
 drivers/gpu/drm/sun4i/Kconfig                      |   3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  14 +++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |  11 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |  44 ++++++--
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c         |  89 +++++++++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  17 ++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   2 +
 include/dt-bindings/clock/sun50i-a64-ccu.h         |   2 +
 21 files changed, 458 insertions(+), 60 deletions(-)

-- 
2.14.3
