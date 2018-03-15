Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCOQMg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:12:36 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40845 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCOQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:12:34 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Thu, 15 Mar 2018 17:11:53 +0100
Message-Id: <1521130316-1221-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   v5 with a few small changes compared to v4 and with Andrzej tag added to
all patches in the series.

I fixed punctuation in the bindings and added a statement to clarify
the chip does not expose any control bus but it is instead configured by input
signals.

Minor changes in the driver, with the regulator name printed out in error path
of enable/disable routines instead of its index.

Branch for testing available at
git://jmondi.org v3m/v4.16-rc3/lvds-bridge-v5

Thanks
   j

v4 -> v5:
- Fix punctuation in bindings documentation
- Add small statement to bindings document to clarify the chip has no
  control bus
- Print regulator name in enable/disable routines error path
- Add Andrzej Reviewed-by tag

v3 -> v4:
- Rename permutations of "pdwn" to just "pdwn" everywhere in the series
- Improve power enable/disable routines as suggested by Andrzej and Sergei
- Change "pdwn" gpio initialization to use the logical output level
- Change Kconfig description

v2 -> v3:
- Drop support for "lvds-decoder" and make the driver THC63LVD1024 specific
-- Rework bindings to describe multiple input/output ports
-- Rename driver and remove "lvds-decoder" references
-- Rework Eagle DTS to use new bindings

v1 -> v2:
- Drop support for THC63LVD1024


Jacopo Mondi (3):
  dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
  drm: bridge: Add thc63lvd1024 LVDS decoder driver
  arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  66 ++++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  33 ++-
 drivers/gpu/drm/bridge/Kconfig                     |   6 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 257 +++++++++++++++++++++
 5 files changed, 360 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
