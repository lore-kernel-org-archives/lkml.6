Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC26C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AF720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeGYIJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:09:39 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.179]:8238 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeGYIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:37 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6xBd5g
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 08:59:11 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 17/32] ARM: dts: omap3-gta04: add camera interface parallel port
Date:   Wed, 25 Jul 2018 08:58:49 +0200
Message-Id: <322301c4b84b8c64b634e3023c0c4767c233560c.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GTA04 has an optional OV9655 camera (for which we do
not yet have a driver upstream), but the ISP hardware
connection description in the device tree is independent
of that.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4947e635c1af..05e24485f765 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -699,3 +699,23 @@
 &mcbsp4 {
 	status = "okay";
 };
+
+/* image signal processor within OMAP3 SoC */
+&isp {
+	ports {
+		port@0 {
+			reg = <0>;
+			parallel_ep: endpoint {
+				ti,isp-clock-divisor = <1>;
+				ti,strobe-mode;
+				bus-width = <8>;/* Used data lines */
+				data-shift = <2>; /* Lines 9:2 are used */
+				hsync-active = <0>; /* Active low */
+				vsync-active = <1>; /* Active high */
+				data-active = <1>;/* Active high */
+				pclk-sample = <1>;/* Falling */
+			};
+		};
+		/* port@1 and port@2 are not used by GTA04 */
+	};
+};
-- 
2.12.2

