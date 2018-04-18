Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeDROkw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:40:52 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57137 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeDROkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:40:51 -0400
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
Subject: [PATCH v9 0/2] drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Wed, 18 Apr 2018 16:40:27 +0200
Message-Id: <1524062429-325-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I have another series which is based on this one + Eagle board display
support, I'm re-sending this one to fix the small issue I pointed out in my
reply to v8.

Simon: no changes to Eagle DTS series, so the last one sent is still the good
one.

DRM: I have collected several reviewed-by tags both on driver and bindings.
Can I send out incremental patches on this series and consider this one to
be ready to be collected?

Thanks
   j

v8 -> v9:
- Put 'remote' OF node after usage not just in error path during device
  tree parsing routine
- Add Rob's Reviewed-by tag to the device tree bindings documentation

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
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 205 +++++++++++++++++++++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
