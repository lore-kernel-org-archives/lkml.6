Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6A52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeK2E4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:34 -0500
Received: from shell.v3.sk ([90.176.6.54]:39418 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK2E4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0094399A93;
        Wed, 28 Nov 2018 18:54:04 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PfmE0zDODrht; Wed, 28 Nov 2018 18:53:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 16D8C99AB6;
        Wed, 28 Nov 2018 18:53:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qVk-QmR5mnfo; Wed, 28 Nov 2018 18:53:30 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9D16B99A2C;
        Wed, 28 Nov 2018 18:53:29 +0100 (CET)
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
Subject: [PATCH v4 05/20] DT: marvell,mmp2: add MMC controllers
Date:   Wed, 28 Nov 2018 18:53:09 +0100
Message-Id: <20181128175324.163202-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's apparently four of them on a MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v3:
- Fixed the mmc4 node name

Changes since v1:
- The controllers seem to be on AXI bus, not APB. Move them.
- Remove aliases.

 arch/arm/boot/dts/mmp2.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4743a1288280..1120fe6abbdc 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -117,6 +117,42 @@
 				reg-names =3D "mux status", "mux mask";
 				mrvl,intc-nr-irqs =3D <2>;
 			};
+
+			mmc1: mmc@d4280000 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4280000 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH0>;
+				clock-names =3D "io";
+				interrupts =3D <39>;
+				status =3D "disabled";
+			};
+
+			mmc2: mmc@d4280800 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4280800 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH1>;
+				clock-names =3D "io";
+				interrupts =3D <52>;
+				status =3D "disabled";
+			};
+
+			mmc3: mmc@d4281000 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4281000 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH2>;
+				clock-names =3D "io";
+				interrupts =3D <53>;
+				status =3D "disabled";
+			};
+
+			mmc4: mmc@d4281800 {
+				compatible =3D "mrvl,pxav3-mmc";
+				reg =3D <0xd4281800 0x120>;
+				clocks =3D <&soc_clocks MMP2_CLK_SDH3>;
+				clock-names =3D "io";
+				interrupts =3D <54>;
+				status =3D "disabled";
+			};
 		};
=20
 		apb@d4000000 {	/* APB */
--=20
2.19.1

