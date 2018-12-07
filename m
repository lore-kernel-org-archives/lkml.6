Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F26BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFABA20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="neJeNX0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFABA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLGShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:37:13 -0500
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:52002
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbeLGShM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzOa5zLVvAJomKNv/Jivb5U+TqabZ2OrsHWykZOZUBc=;
 b=neJeNX0AD3bomQLuUkIwn2zaTyMyESx+xdR+Mx79nGjipijPyrEDiyFDJxpNf9H3OY1PUcS12Mt0E9MGcMg0QuDGEDjbe70WbpuYO2/RnJ3tjveYFEoqeEw2gP63qRwZunzb+F7tx05fh0dwg3AvO4CxKAUCqPMhcCoqekJBjS0=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1SPR8PMB115.eurprd04.prod.outlook.com (10.163.248.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 18:35:13 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 18:35:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        moderated for non-subscribers 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] ARM: dts: Introduce wilddt function instead of listing imx
 boards
Thread-Topic: [RFC] ARM: dts: Introduce wilddt function instead of listing imx
 boards
Thread-Index: AQHUjluXl7drc3J3qk+tQkJdvWmGcw==
Date:   Fri, 7 Dec 2018 18:35:13 +0000
Message-ID: <044dced6439a8ac35cf03336dcef64297e204fc4.1544206368.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:203:69::17) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR8PMB115;6:KCuTogjZvUw7/a4aoP1XfrjwFFNFJ6phrPoILe3GNTg99KIs8Qbvj8aTu0Rw4fk7cvrhFLp26T2hbR1PuJq+cchhUsdLwpI2+kffp33ak0fLTohRLxYw70CpwjmFpWmSbJp3uAWgrUP52D2R8mTO99utfwNNArfS1MHwYRN+4Ax6Egd1BkKqQOap16Nf5Deu6EKkFt6ekj6p1NFbPyIkT0YCoL7jhgDEHW0ySKMOJUZ0A3aX9HakIr0QS1QdobdzArsI8JVOsN38uOUY+NAfvz/72dVo6gc+OuMXRPQKzZxB8U2fTuEjFopoWZ5i+dQRcpZH7hF+icYySuF25ajXUQ4w3CnrCWXLKxptmKODfQfdNJw0XqXQGIDopz0Py+72521c9xfoBKfygq5Xb95gaIVqsHRgeb97eXCX7N+9Iq6XJhCYQhUUyUJR5qY3kJJ5f6HK1V0mC5+pKhF7hbL4Gg==;5:B6h84p+plT7sk9cuZS/u5T8jLgbom8z32hwRh6oYhjFz3qSIpnRUwJVSSEVTJ/HHQhp0mcee2ZoY1TsHThWfbLU9/qeSO+qQmRdWQi3TlyPJNtr1y5XKdeDbBZ7hCogs0E7HkYdfEDD9H70uX5TlHZ/LZ+8co5lnBjSJKg2wJI8=;7:Xpj7ResdC1oysusoGbQyy15szKoh+jKcldvpfImAca3QZFeZqTQudCKD3Igom9dWOJu56J2wjGqDN7AWweL1bPVu9P5pOGCUCKJAxUjTxOFdsUFNLT/XMFn/pZSks5LKnefRA1UIaozhwgTBZL9ndQ==
x-ms-office365-filtering-correlation-id: 384f087b-78f0-409f-ba4b-08d65c72b97a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1SPR8PMB115;
x-ms-traffictypediagnostic: VI1SPR8PMB115:
x-microsoft-antispam-prvs: <VI1SPR8PMB115F0368046C6B37F6C85D2EEAA0@VI1SPR8PMB115.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1SPR8PMB115;BCL:0;PCL:0;RULEID:;SRVR:VI1SPR8PMB115;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(386003)(86362001)(575784001)(5660300001)(97736004)(99286004)(3846002)(6506007)(52116002)(256004)(102836004)(106356001)(26005)(6116002)(186003)(71200400001)(25786009)(68736007)(44832011)(105586002)(118296001)(71190400001)(2906002)(486006)(478600001)(4326008)(36756003)(66066001)(7736002)(305945005)(54906003)(6436002)(2616005)(476003)(6486002)(50226002)(7416002)(81166006)(8936002)(14454004)(6512007)(53936002)(110136005)(8676002)(81156014)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR8PMB115;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /yhho7of3wH3zFSYXx/60saDxGjgzssW1d0lwbLoENZQPWHXe000b87kc6nGJGfIbuXvUW5DU4Zqsb7j0UVWqYIKPCuuWJSKTMHxWvkNlcCY0BF0nks9NLvtbO9IMazzaEqQ2xlYOCMAM8V+I0Mvt8cp7e/hinwUsg1D4ruRkSDNzdjg5O1c6+e8qXw87iGUT5brfk7ga0dXj1pefAhnQf0BKM4Vr+kWSdbCwzp2OZje9ESCfYExwZSz8E4BE87AnViD9H34UD9KKwnwCJ1xf9QgjDSHtrW6Poq2DCaXHRAwzM+8YAs1Wq88xZRQgYGDJvn2PxrMJmcdFp0ZdCJJsKCvp1OxJBbnLMRONSqIGYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384f087b-78f0-409f-ba4b-08d65c72b97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 18:35:13.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR8PMB115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dts makefiles go through a lot of pointless churn when boards are
added. Many SOCs (such as imx) have very simple naming conventions for
all boards using a certain SOC and board listings can be easily
collapsed using wildcards.

Add a "wilddt" function and use it for imx6/7

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/Makefile | 203 ++++---------------------------------
 1 file changed, 19 insertions(+), 184 deletions(-)

If useful in v2 the wilddt function can be split into a separate patch
for "scripts/Makefile.lib"

A few other arches also have DT wildcards but not on a per-soc basis, in
theory they could $(call wilddt,*)

I'm not sure if $dtstree is used correctly here?

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..42e6ba453adf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
+
+dtstree	:=3D $(srctree)/$(src)
+
+# return list of .dtb for all .dts matching $1 in current directory
+# Example usage: dtb-$CONFIG_SOC_ABC123 +=3D $(call wilddt,abc123-*)
+define wilddt
+	$(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/$(1).dts))
+endef
+
 dtb-$(CONFIG_ARCH_ALPINE) +=3D \
 	alpine-db.dtb
 dtb-$(CONFIG_MACH_ARTPEC6) +=3D \
 	artpec6-devboard.dtb
 dtb-$(CONFIG_MACH_ASM9260) +=3D \
@@ -384,199 +393,25 @@ dtb-$(CONFIG_SOC_IMX53) +=3D \
 	imx53-tx53-x03x.dtb \
 	imx53-tx53-x13x.dtb \
 	imx53-usbarmory.dtb \
 	imx53-voipac-bsb.dtb
 dtb-$(CONFIG_SOC_IMX6Q) +=3D \
-	imx6dl-apf6dev.dtb \
-	imx6dl-aristainetos_4.dtb \
-	imx6dl-aristainetos_7.dtb \
-	imx6dl-aristainetos2_4.dtb \
-	imx6dl-aristainetos2_7.dtb \
-	imx6dl-colibri-eval-v3.dtb \
-	imx6dl-cubox-i.dtb \
-	imx6dl-cubox-i-emmc-som-v15.dtb \
-	imx6dl-cubox-i-som-v15.dtb \
-	imx6dl-dfi-fs700-m60.dtb \
-	imx6dl-gw51xx.dtb \
-	imx6dl-gw52xx.dtb \
-	imx6dl-gw53xx.dtb \
-	imx6dl-gw54xx.dtb \
-	imx6dl-gw551x.dtb \
-	imx6dl-gw552x.dtb \
-	imx6dl-gw553x.dtb \
-	imx6dl-gw560x.dtb \
-	imx6dl-gw5903.dtb \
-	imx6dl-gw5904.dtb \
-	imx6dl-hummingboard.dtb \
-	imx6dl-hummingboard-emmc-som-v15.dtb \
-	imx6dl-hummingboard-som-v15.dtb \
-	imx6dl-hummingboard2.dtb \
-	imx6dl-hummingboard2-emmc-som-v15.dtb \
-	imx6dl-hummingboard2-som-v15.dtb \
-	imx6dl-icore.dtb \
-	imx6dl-icore-mipi.dtb \
-	imx6dl-icore-rqs.dtb \
-	imx6dl-mamoj.dtb \
-	imx6dl-nit6xlite.dtb \
-	imx6dl-nitrogen6x.dtb \
-	imx6dl-phytec-mira-rdk-nand.dtb \
-	imx6dl-phytec-pbab01.dtb \
-	imx6dl-rex-basic.dtb \
-	imx6dl-riotboard.dtb \
-	imx6dl-sabreauto.dtb \
-	imx6dl-sabrelite.dtb \
-	imx6dl-sabresd.dtb \
-	imx6dl-savageboard.dtb \
-	imx6dl-ts4900.dtb \
-	imx6dl-ts7970.dtb \
-	imx6dl-tx6dl-comtft.dtb \
-	imx6dl-tx6s-8034.dtb \
-	imx6dl-tx6s-8034-mb7.dtb \
-	imx6dl-tx6s-8035.dtb \
-	imx6dl-tx6s-8035-mb7.dtb \
-	imx6dl-tx6u-801x.dtb \
-	imx6dl-tx6u-80xx-mb7.dtb \
-	imx6dl-tx6u-8033.dtb \
-	imx6dl-tx6u-8033-mb7.dtb \
-	imx6dl-tx6u-811x.dtb \
-	imx6dl-tx6u-81xx-mb7.dtb \
-	imx6dl-udoo.dtb \
-	imx6dl-wandboard.dtb \
-	imx6dl-wandboard-revb1.dtb \
-	imx6dl-wandboard-revd1.dtb \
-	imx6q-apalis-eval.dtb \
-	imx6q-apalis-ixora.dtb \
-	imx6q-apalis-ixora-v1.1.dtb \
-	imx6q-apf6dev.dtb \
-	imx6q-arm2.dtb \
-	imx6q-b450v3.dtb \
-	imx6q-b650v3.dtb \
-	imx6q-b850v3.dtb \
-	imx6q-cm-fx6.dtb \
-	imx6q-cubox-i.dtb \
-	imx6q-cubox-i-emmc-som-v15.dtb \
-	imx6q-cubox-i-som-v15.dtb \
-	imx6q-dfi-fs700-m60.dtb \
-	imx6q-dhcom-pdk2.dtb \
-	imx6q-display5-tianma-tm070-1280x768.dtb \
-	imx6q-dmo-edmqmx6.dtb \
-	imx6q-dms-ba16.dtb \
-	imx6q-evi.dtb \
-	imx6q-gk802.dtb \
-	imx6q-gw51xx.dtb \
-	imx6q-gw52xx.dtb \
-	imx6q-gw53xx.dtb \
-	imx6q-gw5400-a.dtb \
-	imx6q-gw54xx.dtb \
-	imx6q-gw551x.dtb \
-	imx6q-gw552x.dtb \
-	imx6q-gw553x.dtb \
-	imx6q-gw560x.dtb \
-	imx6q-gw5903.dtb \
-	imx6q-gw5904.dtb \
-	imx6q-h100.dtb \
-	imx6q-hummingboard.dtb \
-	imx6q-hummingboard-emmc-som-v15.dtb \
-	imx6q-hummingboard-som-v15.dtb \
-	imx6q-hummingboard2.dtb \
-	imx6q-hummingboard2-emmc-som-v15.dtb \
-	imx6q-hummingboard2-som-v15.dtb \
-	imx6q-icore.dtb \
-	imx6q-icore-mipi.dtb \
-	imx6q-icore-ofcap10.dtb \
-	imx6q-icore-ofcap12.dtb \
-	imx6q-icore-rqs.dtb \
-	imx6q-kp-tpc.dtb \
-	imx6q-marsboard.dtb \
-	imx6q-mccmon6.dtb \
-	imx6q-nitrogen6x.dtb \
-	imx6q-nitrogen6_max.dtb \
-	imx6q-nitrogen6_som2.dtb \
-	imx6q-novena.dtb \
-	imx6q-phytec-mira-rdk-emmc.dtb \
-	imx6q-phytec-mira-rdk-nand.dtb \
-	imx6q-phytec-pbab01.dtb \
-	imx6q-pistachio.dtb \
-	imx6q-rex-pro.dtb \
-	imx6q-sabreauto.dtb \
-	imx6q-sabrelite.dtb \
-	imx6q-sabresd.dtb \
-	imx6q-savageboard.dtb \
-	imx6q-sbc6x.dtb \
-	imx6q-tbs2910.dtb \
-	imx6q-ts4900.dtb \
-	imx6q-ts7970.dtb \
-	imx6q-tx6q-1010.dtb \
-	imx6q-tx6q-1010-comtft.dtb \
-	imx6q-tx6q-1020.dtb \
-	imx6q-tx6q-1020-comtft.dtb \
-	imx6q-tx6q-1036.dtb \
-	imx6q-tx6q-1036-mb7.dtb \
-	imx6q-tx6q-10x0-mb7.dtb \
-	imx6q-tx6q-1110.dtb \
-	imx6q-tx6q-11x0-mb7.dtb \
-	imx6q-udoo.dtb \
-	imx6q-utilite-pro.dtb \
-	imx6q-var-dt6customboard.dtb \
-	imx6q-wandboard.dtb \
-	imx6q-wandboard-revb1.dtb \
-	imx6q-wandboard-revd1.dtb \
-	imx6q-zii-rdu2.dtb \
-	imx6qp-nitrogen6_max.dtb \
-	imx6qp-nitrogen6_som2.dtb \
-	imx6qp-phytec-mira-rdk-nand.dtb \
-	imx6qp-sabreauto.dtb \
-	imx6qp-sabresd.dtb \
-	imx6qp-tx6qp-8037.dtb \
-	imx6qp-tx6qp-8037-mb7.dtb \
-	imx6qp-tx6qp-8137.dtb \
-	imx6qp-tx6qp-8137-mb7.dtb \
-	imx6qp-wandboard-revd1.dtb \
-	imx6qp-zii-rdu2.dtb
+	$(call wilddt,imx6dl-*) \
+	$(call wilddt,imx6q-*) \
+	$(call wilddt,imx6qp-*)
 dtb-$(CONFIG_SOC_IMX6SL) +=3D \
-	imx6sl-evk.dtb \
-	imx6sl-warp.dtb
+	$(call wilddt,imx6sl-*)
 dtb-$(CONFIG_SOC_IMX6SLL) +=3D \
-	imx6sll-evk.dtb
+	$(call wilddt,imx6sll-*)
 dtb-$(CONFIG_SOC_IMX6SX) +=3D \
-	imx6sx-nitrogen6sx.dtb \
-	imx6sx-sabreauto.dtb \
-	imx6sx-sdb-reva.dtb \
-	imx6sx-sdb-sai.dtb \
-	imx6sx-sdb.dtb \
-	imx6sx-softing-vining-2000.dtb \
-	imx6sx-udoo-neo-basic.dtb \
-	imx6sx-udoo-neo-extended.dtb \
-	imx6sx-udoo-neo-full.dtb
+	$(call wilddt,imx6sx-*)
 dtb-$(CONFIG_SOC_IMX6UL) +=3D \
-	imx6ul-14x14-evk.dtb \
-	imx6ul-ccimx6ulsbcexpress.dtb \
-	imx6ul-ccimx6ulsbcpro.dtb \
-	imx6ul-geam.dtb \
-	imx6ul-isiot-emmc.dtb \
-	imx6ul-isiot-nand.dtb \
-	imx6ul-liteboard.dtb \
-	imx6ul-opos6uldev.dtb \
-	imx6ul-pico-hobbit.dtb \
-	imx6ul-tx6ul-0010.dtb \
-	imx6ul-tx6ul-0011.dtb \
-	imx6ul-tx6ul-mainboard.dtb \
-	imx6ull-14x14-evk.dtb \
-	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb \
-	imx6ulz-14x14-evk.dtb
+	$(call wilddt,imx6ul-*) \
+	$(call wilddt,imx6ull-*) \
+	$(call wilddt,imx6ulz-*)
 dtb-$(CONFIG_SOC_IMX7D) +=3D \
-	imx7d-cl-som-imx7.dtb \
-	imx7d-colibri-emmc-eval-v3.dtb \
-	imx7d-colibri-eval-v3.dtb \
-	imx7d-nitrogen7.dtb \
-	imx7d-pico-pi.dtb \
-	imx7d-sbc-imx7.dtb \
-	imx7d-sdb.dtb \
-	imx7d-sdb-sht11.dtb \
-	imx7s-colibri-eval-v3.dtb \
-	imx7s-warp.dtb
+	$(call wilddt,imx7[ds]-*)
 dtb-$(CONFIG_SOC_LS1021A) +=3D \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
 dtb-$(CONFIG_SOC_VF610) +=3D \
--=20
2.17.1

