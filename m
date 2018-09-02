Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C546220841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C546220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeIBOZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:44 -0400
Received: from mout.perfora.net ([74.208.4.196]:45833 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeIBOZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:43 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LcyTW-1fVq1d3IIK-00i2Rv; Sun, 02 Sep 2018 12:10:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 35/37] ARM: tegra: colibri_t20: get rid of fake clocks simple bus
Date:   Sun,  2 Sep 2018 12:09:04 +0200
Message-Id: <20180902100906.25792-36-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:CpgrN+eJqB0fLTeGd8B/27cXjoMhyMmOcTAvRrOTsck3SmOLbgN
 F7oN3YOXnkUV5lCscdHzYQtVUIoY/LZRj8/PDuK3QL5HeXBZ+KUDNg+DkRQZ++dL9EEK40R
 1tacJ/Wmoo8aKGkBpgaTUe9mAo16nwjD6dGUOHAL42YLk5OGCBAmQyR+Fapmv9lkfxUeTPe
 YmqrP8Jxx2rYCtcYo1LOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/nxVG6y94vY=:NWuLL0qOaVe1rLjEMo1aiX
 iIuKcTVD8klRubyu6+lh7v0Hu2S0OoC+NnqS4CAYi8oUD+rJ88l7HdFuvGSFtHP2E79jR/i4k
 MEfNh0ibda2CSh00d2SewgoqgNEg0xt3Lqkb7flCCFnCD0TVM1hrMNoe+7FkfpgiS/NIHRKDo
 V9NlHT5dIjQ8GIb+dVTnds48EcWpSu07Rk2R7Fa/V4CIqDBX9gqvcdHGtXUBKTx5s4rpyLcke
 a/Ug96Ms+4LNDx5w7Lq40F61867wlcXgI+VvHMJe8KAbiFvNmf/EtzOjga6MfdDE2/LbGXLsI
 1BJW+k3TLtY2WS0vqeFFqJJR19jOfCroqh2huXkfLm8GNFjHQSE8GR5Z4r8Ouiv7y2nInoFZh
 7S3y+aXK/gkcBr6wRcb7QCDPq/kzWGgeFGHxN9nrp8v8MsBGxE3Y3JUrf+r8fgOvyEDh03Jat
 eSUiXqDaJLcZyFEnUPpKvYWWUIC5Gx9EYBDPsXfr7RgiSCLHzwSGUki+N7/XvYPqSQtv3Rj4V
 koy44b4khgNcpeGBxJEgjQ05D1LvSJoeZsbXrjj0Szc1YKVdYEsUJury+PpvQFlzLrfJpCvV+
 dnO6YsDx9lEnyrRlVOQevicefz0oNAH2faaJbo1h8SbfGIjFmxYQo20bQci+nFx+iSVovHz7O
 hpHF2cZP+jvDNm/PGiBhYB0tySiyFOnQxwru76uL8HpUeS3P89DAcubkMeF8XFGkxNhA=
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

 arch/arm/boot/dts/tegra20-colibri.dtsi | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 473f32f20d8d..243615f6c349 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -701,17 +701,10 @@
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
+	clk32k_in: xtal3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
 	};
 
 	reg_lan_v_bus: regulator-lan-v-bus {
-- 
2.14.4

