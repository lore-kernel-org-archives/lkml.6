Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D417C20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D417C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeIAMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:49 -0400
Received: from mout.perfora.net ([74.208.4.194]:44703 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbeIAMYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:49 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M88bH-1fjBBX0Gy9-00vir3; Sat, 01 Sep 2018 10:13:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 17/34] ARM: tegra: colibri_t30: get rid of fake clocks simple bus
Date:   Sat,  1 Sep 2018 10:12:31 +0200
Message-Id: <20180901081248.22639-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:60RLrANkj24+zDCfqiTEJ7J+tc4mvckg+t6GVtqS8yV+1U3ErJh
 9ZbeZ6MxnLd06078FKUtv9mZnq+EF7BWnZkL9A9fnx1MSYrTbH/RONTld7X6my1Z/10Zf/F
 +Ho4s/ACV3JXfxoshYApqeaOShIPa9W/LlVtiW8q2J1e38glvQTa62OLMn+zhb8WrRJUucE
 YsVB9X6HiUej5vl1kqGug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FjKkROT+d3g=:k/kOGlGQQ7sej1vnBhvlbK
 r0zYOZU3iBR9Jv1njjYkH7IFa9qkt5GUuQ1eIKgSt+cOpCuTtgO49uNpoYNmkHfbmD+fuyYmP
 lQXF7ESE+ItHjoW1PU8ADxwb4r3U6g60tGzPbcu2D6Iy0I4IZ5TC2J466SQSPEFd2IFUD/1UJ
 l0CHFEolalxueDl4xgP+RWcXFx3GchQKm29znj3MhAykjH5byOaGT3ZmOucWfbXmxqhVoGByc
 xMFHZxzA39vAsTHGYVHhnMNKoIIVbv6VcwDlvkgudCZd0/nFHjWGtDCJl+YgZ81Bzn05uJKYx
 wk5VoWW/Bn1QEyVPSc8k/2vuUGtmj4oAetqTjFTm/nCXfDQSKeyGWE0k11b+Db85xKllUU9G4
 iFiZOSQZb7i9JB1w5E0WD6R8SoccdzDDqgmiQih1wJyNKMDycaE5bG7QRSku9wf5t2VXJCjZi
 ny9XfJkG0FaIgBGi2DuniQnSeK+YUgM/DyXThMXmI/E1U/ksS8ro08d/AlJngsOKQkeahAJ5a
 w/5Dp3a0j2NsBrZcOByY4g8vB/aIjR8DnJj2YI4AGjd4fKhbp83zV4Zbqw/fWEtZDa/EiGN3g
 zA964IcPjco8ZjpnxRC9DN+m6yltKzbHhNvZAB3XkrRaWTr3YYC/sBqQoQ336eU1TGAx8TYaI
 SY0GZ8wg/Vou35UYn6V58bcZa4BWAQdtqZTB4kUylYJvfTT8bukNHiCHUMBStNAA/xWE=
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

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 12 ++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 15 ++++-----------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 2aaf87ba0c42..bcdaeedcbea2 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -133,14 +133,10 @@
 		pwms = <&pwm 0 5000000>; /* PWM<A> */
 	};
 
-	clocks {
-		clk16m: clk@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			#clock-cells = <0>;
-			clock-frequency = <16000000>;
-			clock-output-names = "clk16m";
-		};
+	clk16m: osc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 95b6444a6f05..4fcdc93ae687 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -954,17 +954,10 @@
 		vbus-supply = <&reg_lan_v_bus>;
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
 	};
 
 	reg_1v8_avdd_hdmi_pll: regulator-1v8-avdd-hdmi-pll {
-- 
2.14.4

