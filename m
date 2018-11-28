Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ACFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FEC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ex54Mt83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FEC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeK1VAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:00:10 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:14095
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbeK1VAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as4m/NfN28VLWQ/jBdABKBByH39gyGKnAaNwTTv5l5k=;
 b=ex54Mt83k19CAJeOAI+tlOY75zjM5PHedN6QA5g88GhQib9XqB0ABwHaIzYsXzIfEA9Bs7NCnvJlAUJ/3EHleyhJoFYu6fBHqHulZLW8yAzn7KbNsCVv8pu5PBhsSob4EzKzh96tweP5exOSc+GMuATcQ/AoB1DYf4Oq7r0H/FE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 09:58:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:58:51 +0000
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
Subject: [PATCH V3 1/4] dt-bindings: thermal: add binding doc for i.MX system
 controller thermal driver
Thread-Topic: [PATCH V3 1/4] dt-bindings: thermal: add binding doc for i.MX
 system controller thermal driver
Thread-Index: AQHUhwD3+gQaPu5dSUi2n1eGdQLGjg==
Date:   Wed, 28 Nov 2018 09:58:51 +0000
Message-ID: <1543398783-3185-2-git-send-email-Anson.Huang@nxp.com>
References: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398783-3185-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:VFtC1I4J3hPK5L07mFjuopg5IS/57t6evdz4hpVfsSeZQntm6Rr/fYMdZX/GHKuetwLpgS4Mp1vP7/nQmaFNkn3umGArR5o6abM32cyU0ZELwHgVv60V/Wl6qG3fOwWlI7dJr4UTPwqntqOH5myssmhxa6XcNfLDN3EI7ub6hja1wI0sErSuHD4BjVHm8qu2s2CUKm6khutUx+33jMUL5kJo+/Vk9Oip2U7PkgwPX3ALA8/8eCdMDWknXyFmq9p68NYAmtPDCNjAKA9bge1ZxDm0hkh1SJRHQaIb8iHz77XurS/yhF2NiUAYkI/yWnzLrVvF9YVC3FHIj9/vqlTgB0Rbi34l5K5+pl2E2TeDwr5AIWtOIEC/VY9I+sBIgFRsQGsQ9XZvySa2qFpOG9398QsG+nk/AWjSFdKeG3JTP2t+qeS1wSOF4hEpSHYGrfq8hc6BBMtte0GKSQdm7VcoAA==;5:hakdupOM8w84279tPQ1SNDMRWwhFeYasRBLKs8NkaxaGQg3aHOuNEIzzJ6ZnmDTAFwgdrbeVLxQJtwUJan5PwUV0ojAJwfL0ZuWMP8UGDnuibN3FSiiew1GjO6/VoMkj01aLKkfhcjYYE+9Nc7mZ7y1VEnG6vOQdjoMY3Orj4n0=;7:2nIhJcchkVI6LNzKCMMVhr5HruwzOyb3s1zOzuxKTnsOIY9/dV2oFTAQgNhythVvZTmAbF0r2UfWEi1DY+DY2PP8shDXRHvrvfD7YOZwrCBjnJEAjFlRfMQ6aWtHYU3s0F6SNLjMH/H4ZGNKTBEPMg==
x-ms-office365-filtering-correlation-id: cf71814f-0d82-46b5-e7ea-08d655181976
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3659150EAD3E918110E6157CF5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(110136005)(4326008)(97736004)(186003)(6486002)(102836004)(52116002)(53936002)(25786009)(2501003)(8676002)(2201001)(26005)(8936002)(39060400002)(76176011)(575784001)(7736002)(386003)(6506007)(86362001)(50226002)(478600001)(81156014)(6436002)(81166006)(7416002)(476003)(36756003)(11346002)(6116002)(99286004)(66066001)(3846002)(316002)(2906002)(106356001)(68736007)(105586002)(486006)(2616005)(71200400001)(71190400001)(305945005)(256004)(14454004)(6512007)(446003)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TkcUPpXUHFyxLmHHJgKuqV6UJoGSurgvvCshWnMND6xBfzV9lErZmNkXP0WBM7ccM145Em2LuLIJMsbQs4zXWh9rBrerNHkzYH9xB9cIGdIN9GP5FfAvVBLgB3jhOLmO4pjLOSm6e6x08GyXmDtd6IjV6FuNVwduQMZoSWZ9KdDjFL+22iCymmADAbcVJ1fHDYgcFam5il/aNP4z+8wuwa9twomk2aHwPyUzTLziwaxbtXj3X5oBNf5Od9NrYyA7Dir6RJTuDCA76uLFKs/+MYl8UW86F/iekPNL8iZq+BqCQQefykfAGChYkey6m6uFKNUgNvnGENUPGmVQ7AMkm75DibL+h62Y7gOM+zhYw2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf71814f-0d82-46b5-e7ea-08d655181976
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:58:51.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V2.
 .../devicetree/bindings/thermal/imx-sc-thermal.txt | 33 ++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-sc-therma=
l.txt

diff --git a/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt b=
/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
new file mode 100644
index 0000000..2f5b0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/imx-sc-thermal.txt
@@ -0,0 +1,33 @@
+* Temperature Monitor (TEMPMON) on NXP i.MX SoCs with System Controller
+
+Required properties:
+- compatible : Must be "nxp,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description=
.
+
+Example:
+tsens: thermal-sensor {
+	compatible =3D "nxp,imx8qxp-sc-thermal";
+	tsens-num =3D <1>;
+	#thermal-sensor-cells =3D <1>;
+};
+
+thermal_zones: thermal-zones {
+	cpu-thermal0 {
+		polling-delay-passive =3D <250>;
+		polling-delay =3D <2000>;
+		thermal-sensors =3D <&tsens 355>;
+		trips {
+			cpu_alert0: trip0 {
+				temperature =3D <107000>;
+				hysteresis =3D <2000>;
+				type =3D "passive";
+			};
+			cpu_crit0: trip1 {
+				temperature =3D <127000>;
+				hysteresis =3D <2000>;
+				type =3D "critical";
+			};
+		};
+	};
+};
--=20
2.7.4

