Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDJK4P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:56:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39517 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbeDJK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:56:12 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] V3M-Eagle HDMI output enablement
Date: Tue, 10 Apr 2018 12:54:02 +0200
Message-Id: <1523357646-3946-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this series enables HDMI display on V3M Eagle board.

The v2 of this series is based on Linus' master, as it already contains the
pull request for arm64 DT is merged already, and it includes enablement of
R8A77970 basic components such as PFC, GPIOs and I2c.

Compared to to v1 I have not included
[PATCH 1/7] arm64: dts: renesas: r8a77970: add FCPVD support
as Simon has already included this in his tree for v4.18.

Indivual patches contains the changelog, the biggest overall change is that
HDMI output enablement, previously split in 3 patches is now performed in a
single patch for arch/arm64/boot/dts/renesas/r8a77970-eagle.dts as suggested
by Laurent.

The series depends on THC63LVD1024 driver, currently submitted for inclusion
[PATCH v8 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
currently available at:
git://jmondi.org/linux lvds-bridge/linus-master/v8

Thanks
  j

v1 -> v2:
- Add Laurent's reviewed by tags
- Fixup patch 5, 6 and 7 of v1
- Remove DU digital output pin muxing
- Update thc63lvd1024 to use the new bindings with mandatory power supply
- Minor fixes (changes are described individually in each patch)

Jacopo Mondi (1):
  arm64: dts: renesas: eagle: Enable HDMI output

Niklas Söderlund (1):
  arm64: dts: renesas: r8a77970: add LVDS support

Sergei Shtylyov (2):
  arm64: dts: renesas: r8a77970: add VSPD support
  arm64: dts: renesas: r8a77970: add DU support

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 82 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 65 ++++++++++++++++++++
 2 files changed, 147 insertions(+)

--
2.7.4
