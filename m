Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDJKxk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:53:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34373 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeDJKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:53:39 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Tue, 10 Apr 2018 12:53:08 +0200
Message-Id: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  new version with last bits hopefully fixed.

The vcc supply is now mandatory, as suggested by Mark Brown, and the driver
requires it to be described in device tree.

The "OE" GPIO is now described by 'oe' again, as I wrongly interpreted Rob's
suggestions on v6.

A few minor grammar fixes in bindings and in driver as suggested by Laurent.

As per v7, Eagle disaply enablement based on this series, is sent separately.

Thanks
   j

v7 -> b8:
- Make 'vcc' supply mandatory
- Use 'oe' property name to describe "OE" pin
- Minor fixes as suggested by Laurent on bindings and driver

v6 -> v7:
- Use semi-standard names for powerdown and output enable GPIOs as suggested
  by Rob and Vladimir
- Use 'regulator_get()' not the optional version, and list only 'vcc' as
  requested supply
- Addressed Laurent's review comments and removed Eagle display enablement patch
  to be sent separately

v5 -> v6:
- Drop check for CONFIG_OF as it is a Kconfig dependency
- Add Niklas Reviewed-by tags
- List [3/3] depenencies below commit message to ease integration

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

Jacopo Mondi (2):
  dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
  drm: bridge: Add thc63lvd1024 LVDS decoder driver

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  60 ++++++
 drivers/gpu/drm/bridge/Kconfig                     |   6 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 206 +++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
