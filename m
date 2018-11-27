Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D821104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qEk+vETF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4D821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeK0Q6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:58:19 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:46928
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbeK0Q6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWFpU8kkXH6k0ow9JfSiI3eo+iV9eJEfgdrINiitIdk=;
 b=qEk+vETFrfvzyinxulwIlLf6MpPOm2t82BnJRU/n781cZoutjT7OsiMctFAPTxB29y7JbmE0TBVJqR8OXaHkIoXeWC1BHyMRz0D6hyg4RbINdqSAXJZeNxxdfdddvNHX98Skd+zqiBmRtghdtWEJpyqyKcRTngeFSYafJ92bMvw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 27 Nov 2018 06:01:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 06:01:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] dt-bindings: thermal: add binding doc for i.MX system
 controller thermal driver
Thread-Topic: [PATCH 2/2] dt-bindings: thermal: add binding doc for i.MX
 system controller thermal driver
Thread-Index: AQHUhhainrgyDrCRXkSl0okqRGMtvg==
Date:   Tue, 27 Nov 2018 06:01:27 +0000
Message-ID: <1543298147-8155-2-git-send-email-Anson.Huang@nxp.com>
References: <1543298147-8155-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543298147-8155-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3836;6:52fSC+PuafRl7uLT6DSybldpO9vuATx3eWoSaZ1F9kIQQKOGmuofGm1wzrV0wnzl/vQzL0XcRNjMNQiXp6LRAoxDcHUuLO8bkv1aawoxkAJZ6R9ceiM8wcDsAOZWAbRA49tENYkPeZHpaaNjl+8/djIuGIvIYDI+8mt6PcojuDVDu6wq5VP4v6mc//GCNMJrB2tcYpbY5iRHUeW86TziL08GeIMA1S0tb6NHwcOrVc8N5Lxrl37qZYIfIr4tSJjCgRe3ei1FiSqvZllSnwyiHzTVl5s2Ppr6DBsq3UhKnXxdzesRSttif/Yaw1eWO28siyA87RrzMMo75ovghucxjJd6Vw6VmVYB0de7iHbZrKdCtDFk1papuyDfFjc0+H2gDGKIEieqzrnYGABlP577sVqVEz6X/sSUVYrImv3BPUGpKjqlQQj2bcO3Bp6pATRBhXeuFbUWCf+6HurCW1eksg==;5:x91hHAvHcAdjWgmwIUpNji+7FbcjZWTFYbRen9/JyUcaGvTigtIvvttQCTsXWXXHm6xXN/A3f281LFfUdFRy6eGabY15zzAjwhNmBbiZbTePJPhMRiApS7K8imTEjJisiRpnw9IVFQnQF3TMpKhMpl6zQCBbmTZTjbnqyMQ3Kzs=;7:zvVkz8HmNr6mJEJCoJhzqSoS3NiUgLp4hwm0HwtkxeMQ7JrZ89G95Fz0UJoixGzoUMvqAxn2K1p/+mgnEuPlyp/Ji/A400YkRuBc4PQjgi4ErJOs4piMo5kw+Qgifo+5utGPR6EWK4fypnvRu95YLg==
x-ms-office365-filtering-correlation-id: 0a7a7d23-0827-4a91-79b7-08d6542dc510
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-microsoft-antispam-prvs: <DB3PR0402MB38367C599565BC995C4F31A8F5D00@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3836;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3836;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(2201001)(39060400002)(71200400001)(71190400001)(110136005)(486006)(476003)(6486002)(8936002)(6436002)(478600001)(6116002)(3846002)(81166006)(97736004)(86362001)(575784001)(8676002)(81156014)(50226002)(4326008)(76176011)(105586002)(52116002)(11346002)(99286004)(26005)(36756003)(106356001)(2616005)(68736007)(446003)(2906002)(14454004)(6512007)(7736002)(25786009)(66066001)(305945005)(53936002)(5660300001)(6506007)(186003)(102836004)(316002)(256004)(386003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TMek6yuZOOE+dk7p7/a6DUnLNWQPh3oQ7WvR1iq3BuhjmshrHqeGTLbuxv93qhH8aqEz6xImMH4VnYFqru1k+fcFd/quwFi8nsffokAqUOdPDoukQUl+hjf+1XoznlPTMCLIElcnGMNlHAaFiV1dF0F/cHkjFmlFou9Za7SC1QQT1DYZGHoYI+rHThaD6QeGeQT0Jh0tmu9FU1e+EtJjUYcaJ/VyzMS1paC3n9uH1IBMe6WOZl2/bUeIfECg2SnKaYlxG8TAJbOR6fUngqruuyzfA5zA014XX0kfHYlRi0ZfAG92wZIuMHhU1wER8eYpmc//CakwnLh34iXrB11YhkMht+0X0wFjz71ZbsZfABQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7a7d23-0827-4a91-79b7-08d6542dc510
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 06:01:27.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
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

