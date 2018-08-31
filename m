Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFDE20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFDE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeHaUtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:49:00 -0400
Received: from mout.perfora.net ([74.208.4.197]:43905 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbeHaUri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:38 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LjbZe-1fKVp13raK-00bahB; Fri, 31 Aug 2018 18:39:12 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 24/34] ARM: tegra: apalis_t30: get rid of fake clocks simple bus
Date:   Fri, 31 Aug 2018 18:38:06 +0200
Message-Id: <20180831163817.23970-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Rleoj/ZXRtvWiN1U5F8eCkd/z5OyK3ck8jm/9DlmXezuSDoUvMr
 nXt6LizP3l3K9JIu11LTcjNJ1v6e7TnNszf0D2InNglX5VY7L5IkmpNMZ2NApo+0DwQjhZ5
 XduLCZIOSM89a6C6c2t4b7VPyUY6otj6reN0WxjK2aQZJQ5PBx5ivWeZiqWhTV/6tkA0QiT
 ADIcXlhj0LQ6ZYdLR/zLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H3+vzDHrppM=:B+omvoG4iXOxJonbMRjXxK
 ghMhlgIfs8whLc1WZw87O8V3+IKjoo7b+pmoCJtSnv1lg64nd3GLOB4qkxEop8rzbajH73/1H
 TGIOE+YAhni4wBgMWjey5PODrf83Z64Za3cpWzfd4beVkGswvJtRxO6pkF9MblLK0dwqLcFmW
 +haCOmLkXHOgwjIFSact7lWNjGmC95i8tIkwGuLqumUaFVwQBY/Ux7BOuj+ywNaQQZiJO+2Q7
 HBiGAmZRLwIEFivXueSyIV3WkLmFlocS6c5sQG5+qfgkZdv5XEIE1a005gHJskQdn3IXgmTHe
 /XRV+n7MJvvHhdvygbTn77Q9SbLzhQre20rF3xCPducgY66sFmHwC3lEaTC2lun3+CwpqCcq/
 YM7Ncnhu/yxDgiXKHL7bxhOki8MUMNLGrx48HBrSUWz7NrbRBLNDbaUN3ddnHcIC9bEzyhvnY
 VqhM0nl/4rJYYI6lGucDLMg1gdECkjjR9iScIk2ZLpY6PDIwo7o3But1yridM9WyTntPqSlqZ
 +1UJFmrik2G5tusOP4SPczzI6p1SpX8kIpVYHpTzBgbx+O+btwVWVXNi6jAEZ6XkdgY4x/G5K
 hjLPsnQHj+Ks25HnqEmB49OPuYaj50Nn7N3fMdQozfyefb7xsu4yEEioPEzz7tZ7Hivq/Zo/K
 7/H7PIKHudT5vLJo2uLhldZQ0UpMH04FKGtX2d5tPanAnELN35zyfow+qF1Y+dnCalic=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of the fake clocks simple bus and use node names as per the
actual schematics.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Get rid of fake clocks simple bus as suggested by Rob.

 arch/arm/boot/dts/tegra30-apalis.dtsi | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 6d6f17422478..d80101df2228 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1097,25 +1097,16 @@
 		mmc-ddr-1_8v;
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clk@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
+	clk32k_in: xtal1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
 
-		clk16m: clk@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			#clock-cells = <0>;
-			clock-frequency = <16000000>;
-			clock-output-names = "clk16m";
-		};
+	clk16m: osc4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
 	};
 
 	reg_1v8_avdd_hdmi_pll: regulator-1v8-avdd-hdmi-pll {
-- 
2.14.4

