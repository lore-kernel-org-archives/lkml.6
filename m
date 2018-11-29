Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E71C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B920832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ats4BdQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207B920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeK2Nlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:41:39 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:62915
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbeK2Nli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V+NyPxjv59hXatRN9FiKRyEC1kB2CrzVSXmYVvAWbI=;
 b=Ats4BdQF6gZLXh7FIXSXHhZ5HzKO4reiAlbkBFypBcekxC9T2ldFK8QKneOdNgoh8p3ML6Hx/Kl3NdBSeb3boXYYMX/CpMNTHOuSvCqU5JZTbGIdV229qH+knIIfyt+8BJx/528tAgsW2icvw6ZwengJjA+TeX6IzM9K5StZW2E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 02:37:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 02:37:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUh4yD0j4a4gnKUE+WHik1QQ7rHA==
Date:   Thu, 29 Nov 2018 02:37:47 +0000
Message-ID: <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:sV5rp+2oQ7B66b68LU+k8rZXoZzioTf/uKgwVdvGVb1c1XJQod5gIF0vSDwBOiBcdKRhRKTFfhQWb4xI5v3JgWPTYEch9U4r3sc5iZRGzN84EyJNNrU2YHZYKsnThA1d+/vRdb3yOi883IxFmJelJUAIUpsXHRGA6fYwQVqYZYfBSpHJ1DtaZS/ctP8ogVBfg5xxmbYyqgUGhYnPJ9x+zY2QZBdSpD3GAYHMtO0Vo8I5vElABF6VrF1EApQguX55eEj/jOn3KYiLXf7fcfbjHIYElFoZL+msEDMcatjK+ij86hMF3lUPKJ8sd62lASqEPJV7+f8VtZQzAH4+GF0fqasRLcEZNaAlKsyw2MeYQvqoN8rR7M5GY5rTJ1zuOHwi7fXR9zqzJ5lxxspOUaC3eZqJJEcVZNNP/yqOVRD+TLZmVRFWisUeB6SLvgPsXUMEFFZCHarp4ksEgV7YaHDwpg==;5:GwKOKIlFL8vJZ9uxrP42s0ltPOi8b9bHHuxHyvhqx84AY0ejEv3hWWDLxYbd4azM7jw2zBWPvOVpkOMJ7hLKLBlT66PV1r2VHa0vxNUOp6vYyIERad+GUzo+X4nUVQlBvWDS3sOH5ipfm2iYlA5+TxKao0dhpCrSqqdwidAycKU=;7:dDFQsfwTTTf7ciNgKG9TtCahdcuf3EQKoU7E+3I4PNHozNKexAwyr+R1hXeQ4fEy9TC4m/hivLQT891j/UUfFGeRcrsJHxJzOTlH5e0+2+n0vhOv87VcpVCvsIkq+viyK2wFYeKTYUdBjNvW9K/fNg==
x-ms-office365-filtering-correlation-id: 91b193a0-84ff-4d50-521d-08d655a3a636
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39466BAC979CFBADEFC338E0F5D20@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(54534003)(199004)(189003)(25786009)(50226002)(99286004)(3846002)(6116002)(478600001)(8936002)(76176011)(14454004)(2201001)(52116002)(316002)(102836004)(106356001)(86362001)(110136005)(186003)(2906002)(26005)(81166006)(81156014)(8676002)(386003)(6506007)(68736007)(6512007)(7736002)(6486002)(6436002)(4326008)(66066001)(71190400001)(53936002)(39060400002)(36756003)(2501003)(71200400001)(305945005)(256004)(97736004)(105586002)(486006)(11346002)(446003)(2616005)(476003)(7416002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n13gfGD4ATH/E1FQHnU6YqhJWepU3mgQ+2apN5ulkEPfZ4EHxOw9cI6GrG+nrxNQ2nngolQkXZ6GmveGFRfNk9NMAqLx7ndVUrHhtxTF/Cc6XwSfPRUkHVfPpuKyfhoG4knpMIu5Cbj4bOWpH0uFZuEtLh7wZUigexDpwBbxn61Ux19uimMF8kiyvji6/2KmygmdldNS7Cya0/KQT3++Dlf4WZfdD/w/RuFm6oZU5U+L+PMIQfLRBS7rFWaReqszqvrHNeMOToUZO2oUYbyuj6AJSXLt8oChnbYVxa4w6bin/0Iy46fRc80rfucCiC6Hp2ZkqDbQu2xA1jsblRC8oV7IKS5L5lacTwBrvX2CkQY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b193a0-84ff-4d50-521d-08d655a3a636
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 02:37:47.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog:
V3->V4:
  *move the tsens node to inside of SCU node as it is belonging to SCU.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 ++++++++++++++++++++++++++=
+
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 9b08688..48f622c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
=20
 #include "imx8-ca35.dtsi"
=20
@@ -87,6 +88,12 @@
 		rtc: rtc {
 			compatible =3D "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible =3D "fsl,imx8qxp-sc-thermal";
+			tsens-num =3D <1>;
+			#thermal-sensor-cells =3D <1>;
+		};
 	};
=20
 	adma_subsys: bus@59000000 {
@@ -410,4 +417,24 @@
 		#size-cells =3D <1>;
 		ranges =3D <0x5f000000 0x0 0x5f000000 0x1000000>;
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <2000>;
+			thermal-sensors =3D <&tsens 355>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature =3D <107000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+				cpu_crit0: trip1 {
+					temperature =3D <127000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
 };
--=20
2.7.4

