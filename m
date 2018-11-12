Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA44C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55BD20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55BD20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeKLNMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:22 -0500
Received: from shell.v3.sk ([90.176.6.54]:59618 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeKLNMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 73CDDC6A37;
        Mon, 12 Nov 2018 04:21:10 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id M4Fxc6X250I8; Mon, 12 Nov 2018 04:20:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9F31CC6A26;
        Mon, 12 Nov 2018 04:20:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ojGcXMMpTKiF; Mon, 12 Nov 2018 04:20:38 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 06267C6A28;
        Mon, 12 Nov 2018 04:20:36 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 05/18] DT: marvell,mmp2: add MMC controllers
Date:   Mon, 12 Nov 2018 04:20:14 +0100
Message-Id: <20181112032027.653931-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
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
Changes since v1:
- The controllers seem to be on AXI bus, not APB. Move them.
- Remove aliases.

 arch/arm/boot/dts/mmp2.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4743a1288280..063382b3eaca 100644
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
+			mmc4: mmc@d4288000 {
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

