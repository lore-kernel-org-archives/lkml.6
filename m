Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968096AbeEYThC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:37:02 -0400
Received: from vern.gendns.com ([206.190.152.46]:48873 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967698AbeEYTg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:36:59 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/tinydrm: new dirver for ILI9341 displays
Date: Fri, 25 May 2018 14:36:19 -0500
Message-Id: <20180525193623.15533-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new tinydrm driver for the Ilitek ILI9341 controller and
a 2.4" display panel that uses this controller.

A few things to note here:
* The datasheet for this display[1] doesn't have a vendor mentioned on it
  anywhere, so I have used "adafruit" as the vendor prefix. If someone has a
  better suggestion, please speak up.
* The MAINTAINERS patch for ili9225 is included so we don't end up with a merge
  conflict later on.

v2 changes:
* change vendor prefix from "noname" to "adafruit"
* new patch for "adafruit" vendor prefix
* minor style changes
* drop regulator from driver (instead of adding to DT bindings)

[1]: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf


David Lechner (4):
  MAINTAINERS: fix path to ilitek,ili9225 device tree bindings
  dt-bindings: Add vendor prefix for Adafruit
  dt-bindings: new binding for Ilitek ILI9341 display panels
  drm/tinydrm: new driver for ILI9341 display panels

 .../bindings/display/ilitek,ili9341.txt       |  27 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   8 +-
 drivers/gpu/drm/tinydrm/Kconfig               |  10 +
 drivers/gpu/drm/tinydrm/Makefile              |   1 +
 drivers/gpu/drm/tinydrm/ili9341.c             | 233 ++++++++++++++++++
 6 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
 create mode 100644 drivers/gpu/drm/tinydrm/ili9341.c

-- 
2.17.0
