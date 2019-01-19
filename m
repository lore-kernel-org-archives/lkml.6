Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DCC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7812E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfASUTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:19:14 -0500
Received: from mailoutvs37.siol.net ([185.57.226.228]:33310 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbfASUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:19:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E3A4D522DDD;
        Sat, 19 Jan 2019 21:19:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B_B-2b9th1bW; Sat, 19 Jan 2019 21:19:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1B289522DD6;
        Sat, 19 Jan 2019 21:19:09 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id AE2CE522DDD;
        Sat, 19 Jan 2019 21:19:06 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Igors Makejevs <git_bb@bwzone.com>
Subject: [PATCH v2 1/2] arm64: dts: allwinner: a64: Add IR node
Date:   Sat, 19 Jan 2019 21:18:59 +0100
Message-Id: <20190119201900.26592-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119201900.26592-1-jernej.skrabec@siol.net>
References: <20190119201900.26592-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igors Makejevs <git_bb@bwzone.com>

IR peripheral is completely compatible with A13 one.

Signed-off-by: Igors Makejevs <git_bb@bwzone.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
index 839b2ae88583..6db55cdc3b4e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1004,6 +1004,18 @@
 			status =3D "disabled";
 		};
=20
+		r_ir: ir@1f02000 {
+			compatible =3D "allwinner,sun5i-a13-ir";
+			reg =3D <0x01f02000 0x400>;
+			clocks =3D <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names =3D "apb", "ir";
+			resets =3D <&r_ccu RST_APB0_IR>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&r_ir_pin>;
+			status =3D "disabled";
+		};
+
 		r_i2c: i2c@1f02400 {
 			compatible =3D "allwinner,sun50i-a64-i2c",
 				     "allwinner,sun6i-a31-i2c";
@@ -1043,6 +1055,11 @@
 				function =3D "s_i2c";
 			};
=20
+			r_ir_pin: ir {
+				pins =3D "PL11";
+				function =3D "s_cir_rx";
+			};
+
 			r_pwm_pin: pwm {
 				pins =3D "PL10";
 				function =3D "s_pwm";
--=20
2.20.1

