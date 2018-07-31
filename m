Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F19D208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeGaHi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:38:56 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:55196 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGaHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:38:56 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.158])
        by regular1.263xmail.com (Postfix) with ESMTP id 6CCCF28D;
        Tue, 31 Jul 2018 14:00:19 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C4A71360;
        Tue, 31 Jul 2018 14:00:00 +0800 (CST)
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 14.20.128.48
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <5b1568d42f5dc7882e2aa23d77621ab2>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 0
Received: from unknown (unknown [14.20.128.48])
        by smtp.263.net (Postfix) whith SMTP id 28719NPUHQ7;
        Tue, 31 Jul 2018 14:00:10 +0800 (CST)
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] arm64: dts: rockchip: add GRF GPIO controller to rk3328
Date:   Tue, 31 Jul 2018 13:59:20 +0800
Message-Id: <1533016762-5268-3-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Adding a GRF GPIO controller labled "grf_gpio" to rk3328, currently
providing access to the GPIO_MUTE pin, which is manupulated by the
GRF_SOC_CON10 register.

The GPIO_MUTE pin is referred to as <&grf_gpio 0>.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v4:
- Use binding of "rockchip,rk3328-grf-gpio"

Changes in v3:
- Use dedicated "rockchip,rk3328-gpio-mute" driver

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 3f5a294..bf5656d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -275,6 +275,12 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		grf_gpio: grf-gpio {
+			compatible = "rockchip,rk3328-grf-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
 	};
 
 	uart0: serial@ff110000 {
-- 
2.7.4


