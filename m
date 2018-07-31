Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118EDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8C7208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="X5/YH1IC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8C7208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeGaIun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:43 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.223]:20580 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbeGaIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021109;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2A44xLHVW7D7w0BFQXU0ON95e8eJK5OGp85OqtMr39w=;
        b=X5/YH1ICakFwpdu7IpujHiOx/GZl0PeQu92RKFkzWE+pxtodgUnvziYqc9HskPnJGc
        K7NRjEN4eL/J+Y0IWj2zUkjuH3ZfEEsW0Mt6YimUydEfIBmz93df/ox5u/E0Je2IfOUL
        uFLQOXMLxAszsil54CfSgjhKhTTHAqeUFgHDo/2ET/8Tie93lQaL9J2x/YNKE8zCfRVu
        XOtwNwkuHPwjZbr51QPdAUogTViOYLq/X+8puu6v2LApOa4i9zdMJl4AUsCWvK0+4Q67
        U9dH8Fy360+YMF7bt89vyllDZQvGc4BX5s9364DTB8gv8wukROkZDy5bABjrB9se5kOR
        bPSw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BhwOi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:43 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 17/32] ARM: dts: omap3-gta04: add camera interface parallel port
Date:   Tue, 31 Jul 2018 09:11:20 +0200
Message-Id: <e477d1ce82879e947dbf5ca3579fc94ec667a748.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
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
index 28e041ec4e98..3d3876782a00 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -700,3 +700,23 @@
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

