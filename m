Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA720847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OwQYQcBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJYPdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:33:41 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:53120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbeJYPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1nD6+p3bPv4rTswzFGg/kLz3Cisik4qPqGu929Lzw=;
 b=OwQYQcBnjsDj4Q2uQxXBtX92IP5szOZGJms1dgYDSKw5pplqohx5tua1+yEMcLIFL8HsnXK7JDXlkcP29KoIAq0BwuCEPn7H7Bftg0iQ4p7aOxtptxTGImCLcftfIEaupa9PSPDjQSnfLgfvrZTsAgHsYSokAOLG1nvfOkh9z48=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4478.eurprd04.prod.outlook.com (20.177.53.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 07:02:09 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:02:09 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v6 6/6] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH v6 6/6] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUbDClV6ivgJnGRke4NIVSxJ8Yyw==
Date:   Thu, 25 Oct 2018 07:02:09 +0000
Message-ID: <1540407376-24115-7-git-send-email-vabhav.sharma@nxp.com>
References: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4478;6:PKU3jn6sm6BzIEwbtHYuvxGwnJ9wwcrmh2LyUlhhJjFjVkm2PsB7qUqsWVhUb3ruK7jYGkABCy8V4mvTrdN5qTaGf5xyG/CKuD6IYBmDRHpv5JqVDLe8USssxPwMvhU71KC/FLB+Wf7PmejBoJ4yreQ66UoEnkH7rZT2aCf7lgD/WGd+uMCmstWf4mmqGN4EzMjLK5/boWbc21F7SpmNMU1XlwvFujfELkCM9RIzsMGenZXolamdAkskT18972UmryxrOZVgLaZV3LpOPrBVc8RJWDDMbsAnclvNeKOZlep04Qc8UjbKbSi3wWab+VAzMcnpQ2kACuDkGUJtQX19Wyg/UgqD3W/zGflII+Ie2LPqqoSd46/vij5OkQFBalj6gmyFoiDokO0fr1MHYIp6TW2Ea+pYg5VmZUY6UxS2asppBfNjNcQ1Cpl9Hu28d+XOrBO4rFyI3IAwhJ9tEgjing==;5:tzPHYAJx8p2jn8yze9hq6JWbRvJhR9oOaryLGwOTd5U1P7/jPWmZaYX0OydRO6RKLI5LL3mFqT3hYXNMfO0/7G2xM4SLI4pBnFvlcLzALSbHtvbRvnJtFTBrN7IbLBI+Dzzqmwfkk8cWGqAOYHlHAowHJoA/oWKAUcRsN5o0hYg=;7:BNWoeaqQ8zMEn2AIkhBL4EjJ3mUHHfzL77TpUOwerV6Ux7SQdK13pS8s2J7rPBSCZ3OH6XdmqmYhPaft8V6+Z5nDKy93ih21LNXur4QwQA44oTjou9ke2Qly5X36v16h0+/l4ChlDoC/IPBBSlc/aTwzpWY6pTmPOTjCp4KesMxRjERBLy4jHMkKoqe4BJJ10FuqqTsptPgN+t86Lhh5M5JZ92kJn6uEgkSRNDZ+5UPuMls2f7FFJhPbGD7ZepUg
x-ms-office365-filtering-correlation-id: 546a0776-1a50-4b52-903e-08d63a47c7ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4478;
x-ms-traffictypediagnostic: VI1PR04MB4478:
x-microsoft-antispam-prvs: <VI1PR04MB447800EA91CDCFCEB6BAB12CF3F70@VI1PR04MB4478.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4478;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4478;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(486006)(71190400001)(71200400001)(44832011)(97736004)(2906002)(6116002)(3846002)(102836004)(76176011)(5250100002)(256004)(6506007)(86362001)(55236004)(52116002)(316002)(2501003)(186003)(2900100001)(4326008)(110136005)(26005)(2201001)(54906003)(36756003)(446003)(2616005)(6486002)(6512007)(6436002)(11346002)(105586002)(99286004)(386003)(66066001)(476003)(68736007)(53936002)(14454004)(478600001)(25786009)(5660300001)(8676002)(81166006)(81156014)(305945005)(8936002)(7416002)(7736002)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4478;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UJuGjzyFW49OjHQDRidnS0rfUyDUNylUclSOaVR+ccJFVCwGyhOafHptaXUBYV89fagt/NBEbnHs+Z4Z4XJwS5xpSXw99p28GVPkphRJ0122/mkEFi9Ya+nXqE5UQJ0zl2T5Z0kWGfauQLyQKLt9tEt3+kLbjnYZdN0OP5oK2qJtpTmhu1o3SMgZFwdMvYlnVV6f6UInnl2ZEU78xICR+guIoSJPRDZ/LYCLuAWNuzh8RDM0Kh2S75TWXpqHI+uyN0J//ZLt6fvszTD1dRiy5245SplWOzH1khMSDIA5M7GdARM6iqQB3SBJ7v2nErtcW/Y27UFRIhsya9bDGRpDRfC9CGkaTFodjr1k3A80SQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546a0776-1a50-4b52-903e-08d63a47c7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:02:09.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++=
++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 86e18ad..445b72b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
new file mode 100644
index 0000000..6481e5f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160ARDB
+//
+// Copyright 2018 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model =3D "NXP Layerscape LX2160ARDB";
+	compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
+
+	aliases {
+		crypto =3D &crypto;
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "MC34717-3.3VSB";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&crypto {
+	status =3D "okay";
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status =3D "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width =3D <8>;
+	status =3D "okay";
+};
+
+&i2c0 {
+	status =3D "okay";
+
+	i2c-mux@77 {
+		compatible =3D "nxp,pca9547";
+		reg =3D <0x77>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		i2c@2 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x2>;
+
+			power-monitor@40 {
+				compatible =3D "ti,ina220";
+				reg =3D <0x40>;
+				shunt-resistor =3D <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x3>;
+
+			temperature-sensor@4c {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4c>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+
+			temperature-sensor@4d {
+				compatible =3D "nxp,sa56004";
+				reg =3D <0x4d>;
+				vcc-supply =3D <&sb_3v3>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status =3D "okay";
+
+	rtc@51 {
+		compatible =3D "nxp,pcf2129";
+		reg =3D <0x51>;
+		// IRQ10_B
+		interrupts =3D <0 150 0x4>;
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
+
+&usb0 {
+	status =3D "okay";
+};
+
+&usb1 {
+	status =3D "okay";
+};
--=20
2.7.4

