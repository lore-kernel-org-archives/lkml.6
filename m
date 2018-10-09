Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB22086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjdD95Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DB22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJIVXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJIVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:22:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so903029pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jNMZduWvpDA30ITMoX26ELjye5ItNmE367b4X3cPoAI=;
        b=VjdD95Wg5yg2kR9uYf9fWdxZVHn0/FpQXvwNgsebmm5Y0/KHDE8zcHK3USJ2jES/L4
         SA4/xM1egl/FdrWOenHA+IUpYfUevoVrYHG0sX5lv5FYscMajp+2dAkNltkNU0XDLjw/
         I/YIMB/uprrFFp+e9ZNLv9Oj/UyPIyH1jTvXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jNMZduWvpDA30ITMoX26ELjye5ItNmE367b4X3cPoAI=;
        b=errkqnFklQZKo1Qg4wGtepcglgqVrYDyJWL86dIJsw7OYXg21yWk+fxqb4o9boQ305
         ltbgSrltLWINhYlaKLoMurvkoGy8/P+Xgdyw+wVpMlEOjhYTj98frAZUjpofh0CU9wwz
         wNLuzXw2hGaIH9GVRnEENZi3+JRShXUkBhpmWw7f44nIoMzdiCqR1oaaaujSv+AxiunE
         W1pFnfFQMbEnfwTiMBwIQcpr70Xt9WA357qWJvrzxBPjeOYwyqM6yfgztmOOVTmU6q34
         2eFUczpBvvf1VI3wprzBW9GiiSfV3t1iZnRzGUrwmQDieHir5oBuZWeABhea6xj/g9AM
         3wBw==
X-Gm-Message-State: ABuFfogUBbMouq/zwz5gi8+lx3NCnmuX6vWU8foirNX6AA/VEbN6gVNx
        y6k/mwsWF/Ojq4jUYIrWxvBM
X-Google-Smtp-Source: ACcGV62HmEnEsHawxfCbbKxyrpd66UinCZEIhrZxjVbV6SbcOPcBHPCTfj7esG4g1fWHnfDwdf9kVg==
X-Received: by 2002:a65:5a89:: with SMTP id c9-v6mr25099230pgt.216.1539093952165;
        Tue, 09 Oct 2018 07:05:52 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:05:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/6] arm64: dts: rockchip: ficus: Add on-board LED support
Date:   Tue,  9 Oct 2018 19:35:17 +0530
Message-Id: <20181009140522.6492-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on-board LED support for Ficus board based on the following
standard used by other 96Boards:

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index cce266da28cd..10a4d3882dd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -23,6 +23,52 @@
 		clock-output-names = "clkin_gmac";
 		#clock-cells = <0>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_led1>, <&user_led2>, <&user_led3>,
+			    <&user_led4>, <&wlan_led>, <&bt_led>;
+
+		user_led1 {
+			label = "rk3399-ficus:green:user1";
+			gpios = <&gpio4 RK_PD1 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "rk3399-ficus:green:user2";
+			gpios = <&gpio4 RK_PD2 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "rk3399-ficus:green:user3";
+			gpios = <&gpio4 RK_PD6 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "rk3399-ficus:green:user4";
+			gpios = <&gpio1 RK_PA0 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "rk3399-ficus:yellow:wlan";
+			gpios = <&gpio1 RK_PA1 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "rk3399-ficus:blue:bt";
+			gpios = <&gpio1 RK_PA4 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &gmac {
@@ -53,6 +99,38 @@
 		};
 	};
 
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie {
 		pcie_drv: pcie-drv {
 			rockchip,pins =
-- 
2.17.1

