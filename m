Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78D520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeG3Jpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:45:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56044 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeG3Jpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:45:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DAEF327E232
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, robin.murphy@arm.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        devicetree@vger.kernel.org, Mark Yao <markyao0591@gmail.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Li <ayaka@soulik.info>,
        Douglas Anderson <dianders@chromium.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 8/8] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date:   Mon, 30 Jul 2018 10:11:24 +0200
Message-Id: <20180730081124.30698-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730081124.30698-1-enric.balletbo@collabora.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY Interface)
nodes on gru/kevin boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 21 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 1da8f7c1501e..7a7dcca11497 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -295,6 +295,12 @@
 	status = "okay";
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -374,6 +380,10 @@
 		<200000000>;
 };
 
+&display_subsystem {
+	devfreq = <&dmc>;
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -495,6 +505,17 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	center-supply = <&ppvar_centerlogic>;
+	upthreshold = <25>;
+	downdifferential = <15>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e9d9aa7aa2ac..20b64ca638cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -128,7 +128,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
-- 
2.18.0

