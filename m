Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38246C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F366E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LRRWk/A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F366E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeK0RPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:15:44 -0500
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:36020
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeK0RPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnEG042/NYY48L8vvFy8KH8OG1tZWNfmkfbYA8X5+Wg=;
 b=LRRWk/A4i2g95moiKHsPbHwwpvn3oE8OXLuc5FViiCTNI0QS7UT9moxMQEaUcEWTxSGmZz338oLlr4dmdtGeNtn8rhH/7kzQInvwp1adFHOJqgzsBWjC0Bsxbivf8g1a3SchNw2azcCgxt/XtwvSsLBv/NMvxnQieFHRnH6U2ns=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 27 Nov 2018 06:18:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 06:18:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUhhkRGF2zbaCoWk6q9yXIOFtdVA==
Date:   Tue, 27 Nov 2018 06:18:52 +0000
Message-ID: <1543299200-8526-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:203:72::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:cj6VYSpC/T6VDCnmm81175WV+zpgwGnOqjty4wgc2EBpAQIX/iMSROHK5Gec3uiAgk6eGAz6rYVgQRK043AgGivATQkcwQBcR2V00+euFNBBr6sh6UpBrXR5ikc+btyrp2zKZ39DfvY6vn2et5W0mfKo65zgm+aEjh1BD1yRuBOXFdsZDDhDJS5mqgGRgc3WarJR7e+tCOdUpKi42BWRaSsdFlgPA3KHDS8yxAouQVm+ihS+OmqztmjJVb4ItL/gf51EXrspOmnMmfNQESF0DMhQe19gL2LZHSFw6lup+vPbIX02WDYRYK+e/74Tveljog0rqGQ8GBUMrpdGbreW0E7wvuDdnmjbBBD5qBIChxmhNrgIwbS6zeF62OX8kgVDcahYjF+Q9fCReTxH6K1mQ4KiaS+X6+GG/IH/j3vUQ3kApA32qTkOOOn8d05n7I7lpD/5IZ6s8ksPgZNpTUy35Q==;5:GiSzoS6BibJLt0yATHQN5jVRCcKnO03hOJBM/EoINGegq+Gn4TE96mm1zkL7CdyOvzoseGLfo/sZYB3raARoncwf66bLy3lPXNBrufbs8TS074Zmun4LQ8ORgodnfXRd78xhaDXKjgXdTfyPhBeersAzKRMtU3LDZFme6vj57+0=;7:237WcgaKBVYnH2+t7DilUqW8wBtLiAIZkdLUZVhwJ3Es2bZmb/u3WYjDNU2sGo1IJ4hpLv1t7CyuniU/qC1wspzmcpRuocEopQqUqU0Tc3gTCjRtgdzUCbIAoudDL0s49zffKuCn2TxYGU71BJszaA==
x-ms-office365-filtering-correlation-id: c0f68ca4-2909-4928-0de6-08d6543033c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36597F67E1A61BB364555B66F5D00@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(68736007)(106356001)(66066001)(105586002)(486006)(36756003)(2906002)(316002)(3846002)(99286004)(6116002)(1857600001)(5660300001)(6512007)(2616005)(71190400001)(71200400001)(256004)(305945005)(14454004)(86362001)(8936002)(52116002)(26005)(7736002)(6486002)(2201001)(110136005)(4326008)(97736004)(386003)(6506007)(2501003)(8676002)(25786009)(50226002)(102836004)(6436002)(81156014)(81166006)(476003)(478600001)(186003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8ez8JCRYWZZyvhPp44on+W7C/UZY+2+QJ6Hzsfnu6iwtzwN2SfzOfFANssCtHV+I4/LzTFaWtIpicM9ZdfwpFazFj96SPg/CZGwCs4bhbaLQ0QEsCVm3DBm6/5+legpcxIRUegkmweDUdFeAMnDggCpzbcEiVC38CChyBZpQqiVLMYMWUywyVM/giJDYGxsrS1tlyqErnQCNAFKMNvPxCQHuFrnQn4Dzo/VzFLJ8n52Yq9NRZhdNPgr/Noxo6gwG/OOvAfTYO5anuFZy4CNdjgCuKW4G3eq6/6+Q7hh6LZOHBe1Ewg3nEbBMMjoRH6+u3/AXgkRWgCUGYfHcpfP1mxLm5Y2oh66LTPYrS45RI+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f68ca4-2909-4928-0de6-08d6543033c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 06:18:52.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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
index da99b6f..9155d45 100644
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

