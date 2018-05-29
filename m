Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeE2JtX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:49:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932386AbeE2JtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:49:20 -0400
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 0/3] drm/panel: Add Ilitek ILI9881c controller driver
Date: Tue, 29 May 2018 11:49:13 +0200
Message-Id: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the next version of the patches to add the support for the Ilitek
ILI9881c panel controller.

This used to be a part of the larger DSI support series for the Allwinner
SoCs whose patches have been since merged and are obviously not part of
this series anymore.

Let me know what you think,
Maxime

Changes from v5:
  - Switched to a regulator for the power line
  - Changed the mode name to reflect that this should be only for the
    bananapi
  - Fixed a compilation warning
  - Added a comment to explain the interface with the display

Changes from v4:
  - Updated the copyright notice
  - Made the init structure const

Changes from v3:
  - Rebased on top of current drm-misc-next
  - Switched to SPDX license header
  - Made the ECC array const
  - Split the big DSI patch into two, one to add the DSI driver and one to
    add the TCON bits.
  - Removed the dithering code
  - Changed the DT labels to remove the indices
  - Used sleeps instead of delays in the panel driver
  - Used the backlight_enable / _disable functions
  - Added Chen-Yu's Reviewed-by

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

Maxime Ripard (3):
  dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
  drm/panel: Add Ilitek ILI9881c panel driver
  [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt |  20 +++-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                        |  48 +++++++-
 drivers/gpu/drm/panel/Kconfig                                       |   9 +-
 drivers/gpu/drm/panel/Makefile                                      |   1 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                       | 503 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

base-commit: fbbe3b8c2c9c5f84caf668703c26154cb4fbb9d1
-- 
git-series 0.9.1
