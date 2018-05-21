Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeEUOp7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:45:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38815 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEUOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:45:52 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: dts: Draak: Enable video inputs and VIN4
Date: Mon, 21 May 2018 16:45:39 +0200
Message-Id: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  this series enables HDMI, CVBS and VIN4 for R8A77995 Draak board.

Compared to v3, the analog video decoder ADV7180 is now described in bindings
with the compatible string "adi,adv7180cp" and its port nodes definition
has been res-structured according to the chip bindings as reported by
Laurent on v3.

Bindings have been copi^W^Winspired from Gen2 Gose board, the only Gen2 board
using the "adv7180cp" compatible string.

Example of how to switch to HDMI input is still available here:
git://jmondi.org/linux d3/media-master/salvator-x-dts_csi2/d3-hdmi

And the series still depends on
[PATCH v3 0/9] rcar-vin: Add support for parallel input on Gen3

Thanks
   j

Jacopo Mondi (3):
  dt-bindings: media: rcar-vin: Add R8A77995 support
  arm64: dts: renesas: draak: Describe CVBS input
  arm64: dts: renesas: draak: Describe HDMI input

v3 -> v4:
- Use 'adi,adv7180cp' in [3/3] as detailed in the commit message
- Add Laurent's R-b tag to [2/3]

v2 -> v3:
- Add comment to CVBS and HDMI inputs
- Add missing Signed-off-by to [2/3]
- Add Niklas' tag

 .../devicetree/bindings/media/rcar_vin.txt         |   1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 117 +++++++++++++++++++++
 2 files changed, 118 insertions(+)

--
2.7.4
