Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EC520645
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfBXL7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 06:59:46 -0500
Received: from shell.v3.sk ([90.176.6.54]:50029 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfBXL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 06:59:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 45DA510218B;
        Sun, 24 Feb 2019 12:59:43 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NOIe8hNz0moN; Sun, 24 Feb 2019 12:59:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5362210218F;
        Sun, 24 Feb 2019 12:59:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V1rcX-3MR7zq; Sun, 24 Feb 2019 12:59:39 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 92A2510218B;
        Sun, 24 Feb 2019 12:59:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] DT: marvell,mmp2: specify reg-shift for the UARTs
Date:   Sun, 24 Feb 2019 12:59:29 +0100
Message-Id: <20190224115929.13548-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the 8250_of driver happy. There are two more drivers in the
tree that bind to mrvl,mmp-uart compatibles: pxa and 8250_pxa and
neither of them requires the reg-shift property, assuming it's always 2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 8d6d62bef738..80effcb78695 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -193,6 +193,7 @@
 				interrupts =3D <27>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART0>;
 				resets =3D <&soc_clocks MMP2_CLK_UART0>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -202,6 +203,7 @@
 				interrupts =3D <28>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART1>;
 				resets =3D <&soc_clocks MMP2_CLK_UART1>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -211,6 +213,7 @@
 				interrupts =3D <24>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART2>;
 				resets =3D <&soc_clocks MMP2_CLK_UART2>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -220,6 +223,7 @@
 				interrupts =3D <46>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART3>;
 				resets =3D <&soc_clocks MMP2_CLK_UART3>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
--=20
2.20.1

