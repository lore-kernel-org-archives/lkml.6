Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B52175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBGGqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:46:01 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34152 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBGGpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:45:47 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id CF0ED5FD40; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RFT PATCH 8/9] ARM: dtsi: axp81x: add USB power supply node
Date:   Thu,  7 Feb 2019 14:45:34 +0800
Message-Id: <20190207064535.9226-9-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207064535.9226-1-wens@csie.org>
References: <20190207064535.9226-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

The AXP813/818 has a VBUS power input. Add a device node for it, now
that we support it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
[wens@csie.org: Add commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp81x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index bd83962d3627..1dfeeceabf4c 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -171,4 +171,8 @@
 			status = "disabled";
 		};
 	};
+
+	usb_power_supply: usb-power-supply {
+		compatible = "x-powers,axp813-usb-power-supply";
+	};
 };
-- 
2.20.1

