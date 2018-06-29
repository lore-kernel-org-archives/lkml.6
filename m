Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4839927FCA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4839927FCA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935434AbeF2OlW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:41:22 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:53460 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934656AbeF2OlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:41:20 -0400
Received: from player779.ha.ovh.net (unknown [10.109.105.58])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 26974D2B10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:41:19 +0200 (CEST)
Received: from localhost.localdomain (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id DB4217C00C4;
        Fri, 29 Jun 2018 16:40:58 +0200 (CEST)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] ARM: dts: imx6ull: add operating points
Date:   Fri, 29 Jun 2018 16:52:21 +0200
Message-Id: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4976196116056593660
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrvddugdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULL has different operating ranges than i.MX6UL so add the
operating points for the i.MX6ULL and removed them form board device
trees. A 25mV offset is added to the minimum allowed values like for the
i.MX6UL.
The valid frequencies are now selected by the cpufreq driver according
to ratings stored in fuses since commit 0aa9abd4c212 ("cpufreq: imx6q:
check speed grades for i.MX6ULL")

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
 arch/arm/boot/dts/imx6ull.dtsi              | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index 3dffbcd50bf6..183193e8580d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -20,20 +20,6 @@
 
 &cpu0 {
 	clock-frequency = <792000000>;
-	operating-points = <
-		/* kHz	uV */
-		792000  1225000
-		528000	1175000
-		396000	1025000
-		198000	950000
-	>;
-	fsl,soc-operating-points = <
-		/* KHz	uV */
-		792000  1175000
-		528000	1175000
-		396000	1175000
-		198000	1175000
-	>;
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index ebc25c98e5e1..ade64bd46fab 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -48,6 +48,25 @@
 /* Delete CAAM node in AIPS-2 (i.MX6UL specific) */
 /delete-node/ &crypto;
 
+&cpu0 {
+	operating-points = <
+		/* kHz	uV */
+		900000	1275000
+		792000	1225000
+		528000	1175000
+		396000	1025000
+		198000	950000
+	>;
+	fsl,soc-operating-points = <
+		/* KHz	uV */
+		900000	1175000
+		792000	1175000
+		528000	1175000
+		396000	1175000
+		198000	1175000
+	>;
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
2.16.4

