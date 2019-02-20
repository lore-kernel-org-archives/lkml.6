Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA992147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UJyOOrK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfBTGyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:54:03 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:56736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfBTGyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7vvJpUc8AzJ2+iBl+Ug3+Ov8umi01/juNghnVDL2U0=;
 b=UJyOOrK4FfnO5tIj1oiJjcpgf2YCrzXA6AH1W7gn6kWRHLf1vgjy8dgX7yBEtBnhcrI3T20yjvjf5Y56Wx9cJFksCg1INpmWahphGtM+xsi1AvaunA09yhoOqj4iRT3xkPOL2po2lvMJnTyTVPxuO2XRYwrvXheAuoOscj4SN0o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:53:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 06:53:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V7 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUyOkNAaRgvbqSq0aZKEZTC700Lg==
Date:   Wed, 20 Feb 2019 06:53:58 +0000
Message-ID: <1550645332-2907-4-git-send-email-Anson.Huang@nxp.com>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e27d52e2-2d34-4a52-5121-08d697002fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3883;23:raHSPdV4Pv12RvAHwYMnJnzKrnt2hc9PA8q6N?=
 =?iso-8859-1?Q?dDlMnRuQpefO+KJgvbPdEbTAnLkwevuOaJL08oTS5CKyfqH4zx0+BRlY27?=
 =?iso-8859-1?Q?kjxR4o0+dbX3dFx+5T9wdyNKJ7rbwz2/Zf5ujF65nUofoB5IPhJXLb3ppd?=
 =?iso-8859-1?Q?FCLB+WV94KLIOm80P92S36OsVenCx7Ib7Po7LLVamtvgcKWFcp+CswAw5m?=
 =?iso-8859-1?Q?NQA6QorwSWkx9ASInPHu8vGOHxEqfNoy7JZnv1SpvZOQgNbgEV7YDNaOMx?=
 =?iso-8859-1?Q?XYxtQuHLI870piyDRopliB10QHuL/EcWKv5V19QldMCTdnE5AnS/ee4MUJ?=
 =?iso-8859-1?Q?IhHM1pFPYN79Tq7h00/yUKAUwYQKGUBwm7u/92H9x6+hriEJdw8+8xDunA?=
 =?iso-8859-1?Q?o62pFj4i+/TiLh0AUVYlagqpaXTmhaNyG1fvQCVLeN4daRAIeNmjqG0pWQ?=
 =?iso-8859-1?Q?Q2JQ0845juk/1a/a+AoDQUpUYvu4CarGCzuYAJj+baOclWN9loTfdUwWve?=
 =?iso-8859-1?Q?tQuaiyj4F441d+I/1Im7YPOBJTLLZHwifMELw3qnI/aDafj671r7Y2lxf+?=
 =?iso-8859-1?Q?YtrBsJE6LDwAfpz9s5KtGjy8tS2iUrnzuHPYYm/NS0jcLuM+ivIpFtKnT/?=
 =?iso-8859-1?Q?fE5SsDXY4O5280Lvl9J+oEjUBmeFqoUYC1xrzbPekM7MCAHvLb46ian0gO?=
 =?iso-8859-1?Q?TVryxryN+TQB1xu495lvFY0Tzl6y0gGobiwq9l3vE65D5QzVMtmFbCQaks?=
 =?iso-8859-1?Q?wJDy2IY0RJbQq22Ou7vM5GFoOADM2BGIjExEt5FkQ8bF2iNJlKttyITQzH?=
 =?iso-8859-1?Q?fr7z44BNgyZnIzXgbHvPaKokhSu4ZBX5N6n0KUDueGKGnNvx/U3Pgbc7br?=
 =?iso-8859-1?Q?sbCo2QAC/HM9xldMS1CChPHWnxscWHzVS/Fcu7R9UbH3zEZJFFT5XJCh2Q?=
 =?iso-8859-1?Q?ZDFN43zsUlwRqk6CJv1UGrdp5UtWF/8vRBKjvJZr9nkVBYtZGdhknOR0cZ?=
 =?iso-8859-1?Q?8JT8XVr7Ku/Mgh7ejsObb7gHnZYB3THjX4LBOdhpwlhd9EcV6erKf5bOwW?=
 =?iso-8859-1?Q?ULxjXtTRp4uZjOdGCXdC5mGyvW6xdKmGVl90wF5XRckJdS1jjX2JnuFQZf?=
 =?iso-8859-1?Q?O830xQ/mOjYwkrPEnhDPRFdcAPQ8bQWPcEA5WceiLKrnnEdKWR+JJmRmDH?=
 =?iso-8859-1?Q?5MBJ1dZweeNp7wGNweNH2rj/rQfazVpLo6hr+MeUHDro1XwC+mvVE3RbOW?=
 =?iso-8859-1?Q?EoSrNpyUxRxyUBjzu6y3bM8se5RZq3g/ETgCA/nnTM1pAHu9HH1vw/izqz?=
 =?iso-8859-1?Q?DHK7qb8t1vw2wPVEktgGwvGAK?=
x-microsoft-antispam-prvs: <DB3PR0402MB38832259DE1375621247322FF57D0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(81156014)(2906002)(81166006)(386003)(105586002)(50226002)(2201001)(2501003)(8936002)(5660300002)(102836004)(106356001)(8676002)(6506007)(476003)(2616005)(99286004)(86362001)(4326008)(52116002)(25786009)(3846002)(11346002)(6116002)(446003)(71190400001)(71200400001)(110136005)(486006)(76176011)(316002)(68736007)(6512007)(6436002)(256004)(14444005)(53936002)(7736002)(478600001)(66066001)(97736004)(186003)(14454004)(6486002)(26005)(305945005)(7416002)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: voU1rMjrX0Pq62dMzV0zcMBD2HzZ4smKpB1/fOD7hP9X8wr4TeDeMlvAwpeApVZxdbeg1ekRqUEspfFOSh8YJ/loosk6DilAD9rZv9k+Ai5Sx9qfHRZ/AFgXtnS9e5vrZgrmxf33Ejtnct88QqV8+HAWjRig3lY90JhCIVgPG3L3OgOKIi/cZB1u6Rp1V2n3QSiI5uCCEHE4pdoEU68iufFEtv/E7AGSG/4mJKJ5atsZP+CLD2oln+Me+d3yLwfm+lXfu/LMMAkILuhsA6rVdb+uKKpjxT9Z4eiGEdDpPhBqt6R9q88AowHuBOv2zL6YhE+LCr7OKBC6GBg6u0Hkvep1k2W6mUvg42OaCsULqhje+1O6gjCw54pBk6Q+U0ZGVQIC2nCCBhtC4UbzA5/Ln9mtUNZuVBZIflsSS79X08E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27d52e2-2d34-4a52-5121-08d697002fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:53:49.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V6:
	- add fallback compatible string "fsl,imx-sc-thermal" according to i.MX SC=
 thermal driver
	  update.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++++++=
++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..24b03d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
=20
 / {
 	interrupt-parent =3D <&gic>;
@@ -116,6 +117,12 @@
 		rtc: rtc {
 			compatible =3D "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible =3D "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			tsens-num =3D <1>;
+			#thermal-sensor-cells =3D <1>;
+		};
 	};
=20
 	timer {
@@ -443,4 +450,25 @@
 			power-domains =3D <&pd IMX_SC_R_GPIO_7>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <2000>;
+			thermal-sensors =3D <&tsens 0>;
+			imx,sensor-resource-id =3D <355>;
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

