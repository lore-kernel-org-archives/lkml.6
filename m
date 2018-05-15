Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEOBo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:44:27 -0400
Received: from vern.gendns.com ([206.190.152.46]:58164 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbeEOBoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:44:24 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/tinydrm: new dirver for ILI9341 displays
Date: Mon, 14 May 2018 20:43:46 -0500
Message-Id: <20180515014349.26226-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
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
  anywhere, so I have used "noname" as the vendor prefix. If someone has a
  better suggestion, please speak up.
* The driver is basically a copy of mi0283qt.c with a new init sequence,
  a different physical panel size, fixed (as in corrected) rotation handling,
  and dropped PM (since I don't have a way to test it). Do we want to try to
  share code with these two drivers (it's not much)?
* The MAINTAINERS patch for ili9225 is included so we don't end up with a merge
  conflict later on.

[1]: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf

David Lechner (3):
  MAINTAINERS: fix path to ilitek,ili9225 device tree bindings
  dt-bindings: new binding for Ilitek ILI9341 display panels
  drm/tinydrm: new driver for ILI9341 display panels

 .../bindings/display/ilitek,ili9341.txt       |  27 ++
 MAINTAINERS                                   |   8 +-
 drivers/gpu/drm/tinydrm/Kconfig               |  10 +
 drivers/gpu/drm/tinydrm/Makefile              |   1 +
 drivers/gpu/drm/tinydrm/ili9341.c             | 239 ++++++++++++++++++
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
 create mode 100644 drivers/gpu/drm/tinydrm/ili9341.c

-- 
2.17.0
