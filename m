Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCOLln (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:41:43 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59316 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeCOLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:40 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] ARM: sun9i: a80: Add display support
Date: Thu, 15 Mar 2018 19:41:28 +0800
Message-Id: <20180315114136.24747-1-wens@csie.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series adds basic support for the display pipelines found on the
Allwinner A80 SoC. Currently only parallel RGB output via TCON0 is
supported. TCON1 drives the HDMI encoder, which I've not been able to
get working yet.

Patch 1 adds device tree bindings for the TCONs on the A80. In
particular, TCON0 requires the eDP reset control in addition to its own.

Patch 2 adds a device tree binding for the Detail Enhancement Unit found
only on the A80.

Patch 3 adds driver support for the TCONs.

Patch 4 adds compatible strings to the device tree bindings for all the 
remaining peripherals covered by this series.

Patch 5 adds support for the compatible strings from the previous patch
to the sun4i-drm driver.

Patch 6 adds the display pipeline device nodes to the A80 .dtsi file.

Patch 7 adds a pinmux setting for RGB888 output for TCON0.

Patch 8 enables VGA output on the Cubieboard4 via an external DAC and
an I2C bus from the SoC for DDC.


I've had these patches for quite some time now, rebasing them as more
features were added to sun4i-drm. Please have a look.


Regards
ChenYu


Chen-Yu Tsai (8):
  drm/sun4i: Add compatible strings for A80 TCONs
  drm/sun4i: Add DT binding for Detail Enhancement Unit in Allwinner A80
    SoC
  drm/sun4i: Add support for A80 TCONs
  drm/sun4i: Add compatible strings for the A80 display pipeline
  drm/sun4i: Add driver support for A80 display pipeline
  ARM: dts: sun9i: Add device nodes for documented display pipelines for
    A80
  ARM: dts: sun9i: Add pinmux settings for LCD0 RGB888 output.
  ARM: dts: sun9i: cubieboard4: Enable VGA display output

 .../bindings/display/sunxi/sun4i-drm.txt           |  39 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  68 ++++
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 392 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   7 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  12 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  27 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |   1 +
 8 files changed, 541 insertions(+), 6 deletions(-)

-- 
2.16.2
