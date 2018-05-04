Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeEDPXi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:23:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36102 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbeEDPXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:23:36 -0400
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] drm/panel: Add Ilitek ILI9881c controller driver
Date: Fri,  4 May 2018 17:23:29 +0200
Message-Id: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                        |  39 ++++++-
 drivers/gpu/drm/panel/Kconfig                                       |   9 +-
 drivers/gpu/drm/panel/Makefile                                      |   1 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                       | 488 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 557 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

base-commit: a08fc7c8056e75b08285a2ad955228002dcd86bc
-- 
git-series 0.9.1
