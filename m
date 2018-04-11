Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeDKMnm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:43:42 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51169 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeDKMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:43:41 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] V3M-Eagle HDMI output enablement
Date: Wed, 11 Apr 2018 14:43:05 +0200
Message-Id: <1523450590-31347-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I have rebased the Eagle display enablement on top of (part of) Sergei's
series:
 [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support

Simon: you can skip "[1/5]  arm64: dts: renesas: r8a77970: add FCPVD support"
as you already collected that

Sergei: I re-sent your series because there was an additional comment from
Laurent on [3/5]. I felt it was wrong to send a follow up patch on a series
still not collected by Simon, so I've resent it. Hope this time is ok with you.
Also, please note that [5/5] of your original series shall be re-sent using
the newly introduced (still in-review) LVDS decoder. Please see [5/5] of this
series as an example.

Niklas: [5/5] of this series is a fixup of your patches and mine. I added
your signed-off-by, hope it is ok.

The series depends on THC63LVD1024 driver, currently submitted for inclusion
"[PATCH v8 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge"
currently available at:
git://jmondi.org/linux lvds-bridge/linus-master/v8

Thanks
   j

v2 -> v3:
- Use Sergei's series for patches [1-4] with a minor comment from Laurent
- Remove the lvds-decoder node label and add Laurent's Reviewed-by in [5/5]

v1 -> v2:
- Add Laurent's reviewed by tags
- Fixup patch 5, 6 and 7 of v1
- Remove DU digital output pin muxing
- Update thc63lvd1024 to use the new bindings with mandatory power supply
- Minor fixes (changes are described individually in each patch)

Jacopo Mondi (1):
  arm64: dts: renesas: eagle: Enable HDMI output

Sergei Shtylyov (4):
  arm64: dts: renesas: r8a77970: add FCPVD support
  arm64: dts: renesas: r8a77970: add VSPD support
  arm64: dts: renesas: r8a77970: add DU support
  arm64: dts: renesas: r8a77970: add LVDS support

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 93 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 75 +++++++++++++++++++++
 2 files changed, 168 insertions(+)

--
2.7.4
