Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4762320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UfPULVOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4762320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeLNIU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:20:26 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:25952
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNIUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM/nfZ6PybOd0XAwGhp9tp7Z5xntz021mGBsxZ9pC2Q=;
 b=UfPULVOaZc0TdUMNVHXuCsD3RDd1slArWd9x0DdqP5s78ngqwg5BF6OxKh3yTNisJgGEvH5IW3JG5scTt1AGcOO3rmoVulNCHWUxK9ln58msriEfFV0Kky4HpF3Dw95ta9Y5KX9gj+1xFBkC6eQQ803nPXFrAr4WnknGIrfoULA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3740.eurprd04.prod.outlook.com (52.134.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 08:20:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:20:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Thread-Topic: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Thread-Index: AQHUk4Xbpx1GKPk9bkG4WDKn6lcg0w==
Date:   Fri, 14 Dec 2018 08:20:22 +0000
Message-ID: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3740;6:6myagCO/cO8orbfSfEQZ9O1QYFMD8yOZRgxL1cvLcM6FZanVk2OIzQs9LbDjcuCbb+dJbrLxmi//r8iFOp70vJXOccrW+AmXdMtaH1TaE31ty3TNHFDv/5f/hcPq3kED9fxJ2kZAtOocbGVZLH+wxr5xuadPT+eRqXPTx4uS8Tke/qzeFZSnJAeMMpb4sc72MiDiLAa6ceGsruiVl4MtWXT1DHcD9f2rFHmMVovo74SyvRi22YrFDgxFCBheMEM8u2CtH55Ue/2WBTb7uW9+Cc6j5F6C7yYN/9YmcNHAxTsEtE/S9kA63A6F4SjJckP5EOUuSNCCPPWNeAXC6mwTpYnVgZbTKKDW0oZPiBE7PKtASuoD4eRFmrG7SvKUdLVbLN4VWSdYPH94xR/L4GT+qlRMKQuRb76p7PdRKDa3iCwTPqTiXHstTfk6r5u5CFCFmP0wrwWGaBGDYqtlZNBD4Q==;5:Q8ktsV1ifXBKBEXmN1eo8er6UqpkCgwgYhJP2yR3kCKo8zmnq3KOs4sIuNiffSvNAq5jyTfl7APfg5t2ZbwYpkbBjDZqPcfJAh0GZXFXlNXfYvJRAUXEOzrARJzPLbmyr5lIuD9JdS1C00n5dPsIqnCxYtVgllyFwSnwoJ+w7H0=;7:zxmM1txvdrNdCQjg6EUHBpwsd48/gV0BttxREII3VJazUjvYm4xdyiB9pEJcj16t4Q0V/+JxWM36qCzfOdDAns//a26jkSst8IfpTT7RwDPPqJAQeGSTYWaXTZIJFvj1u5etc+z75RWVmqVNJgp2qg==
x-ms-office365-filtering-correlation-id: 787845e5-59bf-4570-eec2-08d6619cfd75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3740;
x-ms-traffictypediagnostic: DB3PR0402MB3740:
x-microsoft-antispam-prvs: <DB3PR0402MB37404C3E9FDFCD63940D783DF5A10@DB3PR0402MB3740.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3740;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3740;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(7736002)(476003)(305945005)(86362001)(66066001)(2201001)(486006)(2616005)(6116002)(3846002)(71190400001)(256004)(71200400001)(316002)(36756003)(110136005)(99286004)(8676002)(81156014)(81166006)(105586002)(50226002)(52116002)(6436002)(68736007)(53936002)(5660300001)(25786009)(386003)(102836004)(6506007)(186003)(106356001)(2906002)(26005)(8936002)(6486002)(14454004)(2501003)(478600001)(97736004)(6512007)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3740;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AxqMl2MOuGSFpGxpxdV/9LOFZv21CP1wdsep9Q117st9KJhnGOifRl/nPpgybKHggMXC25LptprigyDpnKuT5XCbQp8hpDdqT2vhNfFycd852JWezdcYDuyRQfZCvYVDU9Ol0UG5pOrDY+q5BQxG5e+vU8SdaqFwyHZ+F7m1h2UI8AEHw0dU1OnMsVqECeMeQg2pqf5Q75dgDYh6vnmrHnMqjulFwV1Q0gad2IGQNzQpt/VUWmg1OvkCnQbKLzsllg+TCT7zymamanOrGRa6hcIJeUGhFFf8FL9XebiJtjY1lrMQZhrNZqESRcfeb5Cu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787845e5-59bf-4570-eec2-08d6619cfd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:20:22.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP SoC revision info is inside the SIM mode's JTAG_ID
register, add sim node to support SoC revision check.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index b86daf7..fca6e50 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -347,4 +347,17 @@
 			gpio-ranges =3D <&iomuxc1 0 96 32>;
 		};
 	};
+
+	m4aips1: bus@41080000 {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x41080000 0x80000>;
+		ranges;
+
+		sim: sim@410a3000 {
+			compatible =3D "fsl,imx7ulp-sim", "syscon";
+			reg =3D <0x410a3000 0x1000>;
+		};
+	};
 };
--=20
2.7.4

