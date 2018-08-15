Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716072168C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716072168C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeHOMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:51:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeHOMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:51:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8420D27D9AC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     amstan@chromium.org, groeck@google.com,
        kieran.bingham@ideasonboard.com, kernel@collabora.com,
        bleung@chromium.org, heiko@sntech.de, devicetree@vger.kernel.org,
        Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add documentation for extcon and utmi-avalid properties.
Date:   Wed, 15 Aug 2018 11:59:32 +0200
Message-Id: <20180815095934.11205-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180815095934.11205-1-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
rk3399") introduces two new properties. The extcon property is used to
detect the cable-state, and the rockchip,utmi-avalid is used to indicate
which register should be used to detect the vbus state.

Document these properties in the documentation binding.

Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index 074a7b3b0425..2d4808d3920b 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -23,6 +23,7 @@ Optional properties:
 		 register files". When set driver will request its
 		 phandle as one companion-grf for some special SoCs
 		 (e.g RV1108).
+ - extcon : phandle to the extcon device for the otg phy.
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify host or otg port,
@@ -45,6 +46,8 @@ Required properties (port (child) node):
 Optional properties:
  - phy-supply : phandle to a regulator that provides power to VBUS.
 		See ./phy-bindings.txt for details.
+ - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
+			  Otherwise, use the bvalid register.
 
 Example:
 
-- 
2.18.0

