Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A74AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FBB2168C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FBB2168C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeHOMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:51:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbeHOMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:51:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5F7BA27D9BA
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
Subject: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new rockchip,force-bvalid property.
Date:   Wed, 15 Aug 2018 11:59:34 +0200
Message-Id: <20180815095934.11205-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180815095934.11205-1-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is used when the otg-id pin is not connected. When this
property is set it forces to set the B-Device Session Valid bit when the
port works as device and clears that bit when the port works as host.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index 2d4808d3920b..55761f466c41 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -48,6 +48,11 @@ Optional properties:
 		See ./phy-bindings.txt for details.
  - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
 			  Otherwise, use the bvalid register.
+ - rockchip,force-bvalid : boolean, set this to force the B-Device Session
+			  Valid bit when the usb port is in device mode. This
+			  is used when the otg-id pin is not connected.
+			  Only supported in case of compatible being:
+			  * "rockchip,rk3399-usb2phy"
 
 Example:
 
-- 
2.18.0

