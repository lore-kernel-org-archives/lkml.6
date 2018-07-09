Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A26C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB92208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB92208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeGIU6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:58:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeGIU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:58:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 06D9E263B57
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Nickey Yang <nickey.yang@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Mark Yao <markyao0591@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-rockchip@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: remove deprecated Type-C PHY properties on rk3399
Date:   Mon,  9 Jul 2018 22:57:54 +0200
Message-Id: <20180709205754.29132-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0fbc47d9e426 ("phy: rockchip-typec: deprecate some DT properties
for various register fields.") deprecates some Rockchip Type-C
properties. As these are now not needed, remove from the device tree
file.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b648f43..180dd9d2cc23 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1446,10 +1446,6 @@
 			 <&cru SRST_P_UPHY0_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 		rockchip,grf = <&grf>;
-		rockchip,typec-conn-dir = <0xe580 0 16>;
-		rockchip,usb3tousb2-en = <0xe580 3 19>;
-		rockchip,external-psm = <0xe588 14 30>;
-		rockchip,pipe-status = <0xe5c0 0 0>;
 		status = "disabled";
 
 		tcphy0_dp: dp-port {
@@ -1475,10 +1471,6 @@
 			 <&cru SRST_P_UPHY1_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 		rockchip,grf = <&grf>;
-		rockchip,typec-conn-dir = <0xe58c 0 16>;
-		rockchip,usb3tousb2-en = <0xe58c 3 19>;
-		rockchip,external-psm = <0xe594 14 30>;
-		rockchip,pipe-status = <0xe5c0 16 16>;
 		status = "disabled";
 
 		tcphy1_dp: dp-port {
-- 
2.18.0

