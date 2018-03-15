Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeCOLG4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:06:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58607 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCOLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:06:55 -0400
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
Subject: [PATCH v4 0/3] drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Thu, 15 Mar 2018 11:56:28 +0100
Message-Id: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this new version fixes comments received from Andrzej and Sergei on the
preceding v3.

Mostly, I cleaned up the mess with the powerdown GPIO names, and I'm now using
pdwn everywhere. The regulator enabling routine has been improved as suggested
by Sergei and Andrzej and I've changed Kconfig symbol documentation for
consistency with other ones. Also, fix gpio initialization to comply with the
APIs that work on logical level even at gpio request time.

Branch for testing available at
git://jmondi.org v3m/v4.16-rc3/lvds-bridge-v4

Thanks
   j

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

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  63 +++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  33 ++-
 drivers/gpu/drm/bridge/Kconfig                     |   6 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 255 +++++++++++++++++++++
 5 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
