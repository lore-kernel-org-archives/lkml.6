Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A34BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE52081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bCXXCnj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DE52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeK1Q7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:59:48 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:14284
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbeK1Q7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oqxe7s4vGNNPngRHR5XMEZndCvHR7d+uhQLiDY9qPk=;
 b=bCXXCnj0v+hApaXQ8sqgphhrvURhLUsxPAlJtfn1Ia8jwKU8+DZv93a9sUiqAeH/dUXUN1scX/th3mHrDG3gViDMup1AK0C1VoC7kuiI7/12/yFpct65xgosUJWjcKQmtowlb9lC5RVFno5uwIBek5I5whE29XGYaezRZ82wsmY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 05:58:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:58:37 +0000
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V2 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUht9nQ3rqL9kbMEarCmiJf6cpTQ==
Date:   Wed, 28 Nov 2018 05:58:37 +0000
Message-ID: <1543384349-2851-5-git-send-email-Anson.Huang@nxp.com>
References: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3691;6:iLR4BfFMHitUxfHh2L0UNoZ8EbNVBGE2oiQ+tJdfn2bLvLQcdeidNQKhDQiBsK6vPy9HJkCW7kHaRgPlw0y8rnkgXI1wD8YOW3Lp00q+GYyjTU+C2MBXxUgUOybQmEheAFUD+pzA783Ploethxslbvo+u17JYt1SCcNAj0+0bP6VjegVT9R4LvV5/EoSqp3Nzog7vXG65GkPY99SeKXhZbkt7mAthV/Hc/ncvztSNkOk7a+uuKoQgNF9e8l5fSRy8da83s9ZW+xpYNZ5P46VliRcmYHKDKDCFmH3zm3Tqd7WRbS2UAicZgvWqOLJTS7kCkRBFrBiJO7pggTQeSkwHwMtEnEMmh7orsGcvJzVUHRV6jcpdjfIz3wcpffcdJfAZDrKeem+sfEhxjw+tiMq8Hhr0n76EuUbVZnGfk7bN1TOkrrlxNzNC99hLzEs5rLyfviS7S5M9L5cfzO87rqE6Q==;5:imtCQBOBhNg98BAcwqUvKKoxvS0q0s+Eur0/RNCFWhRxoJul8oPNHcu91EGJeBkM0XALt/ta7udkzxoivnAbauOVcyiRKY4Si16KDULdRpT2MD3nJCgx2f8sivwS//sFOBWcmrTlHthEgrGstH9ITIFRTSCnImfPPmp2W7KdIBc=;7:nOCqjzZrkD0ulJHEl+OLpqL5fpjBYKWEsnq63f01X3OiK+r+w04Ex5J8nBOar5248BCiLNWHga7tRovkbZ8ZY/GJmZOnQJGYYX+x6viIpoUs3Eu55t0tx34T1yb5a2tcW0KoORO/NlbmA3Kz6csMwg==
x-ms-office365-filtering-correlation-id: 7ae5092e-cdc1-4df9-14ad-08d654f689b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3691;
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB369123F55274060D6031E868F5D10@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3691;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3691;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(256004)(99286004)(36756003)(81156014)(2201001)(2501003)(110136005)(86362001)(76176011)(97736004)(6436002)(14454004)(316002)(386003)(68736007)(50226002)(486006)(39060400002)(52116002)(8936002)(81166006)(6506007)(71200400001)(2906002)(11346002)(71190400001)(2616005)(476003)(6486002)(7736002)(305945005)(7416002)(102836004)(53936002)(186003)(478600001)(3846002)(6512007)(105586002)(5660300001)(106356001)(26005)(6116002)(446003)(25786009)(66066001)(8676002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3691;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OuTR40zCAsi9oUlX76Yd1vbJcD3CiW4LhFW1vbgEJL+/FGhkN9vdsP9RBGbp1hjU+SbDacy/YZdI5ni+3oajIPzQ8DQL/FqFH6zWABkz1YzdBlY+jkNFyQrMukcvK7W4neoYvdqxmw1DuAc3tA6x/tMCa785m2eweV6996uLLpkEJ6wwEcXXmj1u0VqNRRn4mdBixkmRryKuDEl7eoesf0TJs2zfSuZUDb7YHSFobI5xCRdZRXHtmcs9XR9J4oolJ5xIABT+Vv4J7THrWRpQwED/LqAy/Q1xFPgZufz8NuU7amR1NwtOyoqVI6Lpigm6UdTohomanpfeRV2W0dgL7Yr+ONeBJ4bVWHiMe8W/oao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae5092e-cdc1-4df9-14ad-08d654f689b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:58:37.3487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 ++++++++++++++++++++++++++=
+
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 5e8b554..ef57db6 100644
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
@@ -85,6 +86,32 @@
 		};
 	};
=20
+	tsens: thermal-sensor {
+		compatible =3D "nxp,imx8qxp-sc-thermal";
+		tsens-num =3D <1>;
+		#thermal-sensor-cells =3D <1>;
+	};
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
+
 	adma_subsys: bus@59000000 {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
--=20
2.7.4

