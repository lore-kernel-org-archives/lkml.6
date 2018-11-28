Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFB2206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFB2206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeK2E4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:49 -0500
Received: from shell.v3.sk ([90.176.6.54]:39506 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbeK2E4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 86066999FD;
        Wed, 28 Nov 2018 18:54:19 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X6g6Az3bFM78; Wed, 28 Nov 2018 18:53:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5C66799BE7;
        Wed, 28 Nov 2018 18:53:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i_e2eqEx6tsK; Wed, 28 Nov 2018 18:53:34 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 05F7499986;
        Wed, 28 Nov 2018 18:53:31 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 10/20] DT: marvell,mmp2: Add SSP controllers
Date:   Wed, 28 Nov 2018 18:53:14 +0100
Message-Id: <20181128175324.163202-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite Marvel keeps their base addresses secret there's a good chance
they're actually correct.

SSP1 and SSP3 bases were taken from OLPC 1.75: OpenFirmware and kernel
respectively. SSP2 and SSP4 addresses are from James Cameron who actually
has a copy of the data sheet.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Added SSP2 and SSP4 (thanks James Cameron <quozl@laptop.org>)

Changes since v1:
- Dropped the aliases

 arch/arm/boot/dts/mmp2.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 0c5a51b98c3f..ee03e0846740 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -346,6 +346,38 @@
 				resets =3D <&soc_clocks MMP2_CLK_RTC>;
 				status =3D "disabled";
 			};
+
+			ssp1: ssp@d4035000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4035000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
+				interrupts =3D <0>;
+				status =3D "disabled";
+			};
+
+			ssp2: ssp@d4036000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4036000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP1>;
+				interrupts =3D <1>;
+				status =3D "disabled";
+			};
+
+			ssp3: ssp@d4037000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4037000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP2>;
+				interrupts =3D <20>;
+				status =3D "disabled";
+			};
+
+			ssp4: ssp@d4039000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4039000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP3>;
+				interrupts =3D <21>;
+				status =3D "disabled";
+			};
 		};
=20
 		soc_clocks: clocks{
--=20
2.19.1

