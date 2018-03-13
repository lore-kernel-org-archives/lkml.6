Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeCMOaz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:30:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51609 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeCMOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:30:53 -0400
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
Subject: [PATCH v3 0/3] drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Tue, 13 Mar 2018 15:30:22 +0100
Message-Id: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   opposed to v2, this version drops the "transparent LVDS decoder" and provides
support for the Thine THC63LVD1024 chip only.

I removed all references to "lvds-decoder" and made driver and bindings
specific for the above mentioned chip.

Andrzej: Bindings now describe 2 available inputs (Port@0 mandatory, Port@1
optional) and 2 possible outputs (Port@2 mandatory, Port@3 optional). The driver
still takes only Port@0 and Port@2 into account. This leaves out discussions
on how support bridges with multiple input streams within the DRM framework from
this series.

Simon: Please drop the previous bindings proposal you marked as "deferred" as
that one is superseded by this new one.

I still plan to use this series to propose an API to propagate formats through
bridges, which is not possible at the moment, if I got things right.

Thanks
   j

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

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  63 ++++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 ++-
 drivers/gpu/drm/bridge/Kconfig                     |  10 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 239 +++++++++++++++++++++
 5 files changed, 342 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
