Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C4FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BA721872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHN9rPZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfBGJxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:53:24 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:54848
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfBGJxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcm5ZlTwO5wdHB/lVH6FfmYaGpNpwLQ3C2M5tTV98f8=;
 b=CHN9rPZ9kDDqLwgHlSaMthocayDXQkJ21/WYaC4YhdWpiUwvDyMAldA8OG27XK6Xci85QjN3m3srvK4l9FajqHzTWMutCh9by0VntB3stQP2Nea1v+vNHW8kTCKrr8z2GpJFZI3XI+tes0ERtu5ByWRYBt0k1No1hLWCOrHPEt4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3589.eurprd04.prod.outlook.com (52.133.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 09:52:38 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:52:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAg==
Date:   Thu, 7 Feb 2019 09:52:37 +0000
Message-ID: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3589;6:JIFkyQTlIX39VKAk5yWZtZVY7KA/TaGA+Bh6uErlIQy1Wl5rD3cnK2MNpzoyoYvzepoEACL83qSY3qWlFZxzg41iNDJD1Twz7LVGKlnIQ6WyQVeELyD8xaqTLnfrOheFvy+h0nJcXU4I5DeOo4uVloEJlKiUn96zzr4ZQfxtqY12+ParvDQt/9bxIm5q+9N8W91rvBArVYl0opzw8ZPOPsqooQZ5RIOi6omJUx9awm3hfJZOydaeoaJxrBlh6BFLMG8eUBBqWbAyXvR++uY88jTknc5PIr79ppg0oE8GqPJCKjROhpkt91IinIunOEF0P7h3KPfAIhqvtvbOZCGvf7xZXMyTVSgbH9JdGdP/JGgyGfVl7zr4Z65Koup7rG/PyuZeLbOkjXXi4tRtwQGDK8reD9jXe9yKqblZ1Om8TZxVdpzKfQ3LzNN7VNS4he7eeA6iyDrlSROSHd4abaNO4w==;5:hKDkY7jhxPBoJn8aef+4JcfJQM/V1mv2smGGRJiaWOJA6NHkZ/A+LYxWyCjtB5rmavxx21FCgXXBkQjN0IRqXoqzQ+dPr6TmYtedJ4xf8UFjw626SqRK1Sn/JH1qJ5dkIDxHxMbltKfYtU+mdqw0c4MjaQbuMxRKQFRvFfh+25I9/pMrKk8DxORDbzNwMB0SIN8bvxQcIj25ddmsEhr8SQ==;7:GhJAyFmMuvsN4hN9+ODB6kgJT1L9FDw3nd/XDkz3Lc981PuJV8moiKnTS4hTlw/4FQNxaBFmf+JUoR5GAJDO6k/ONLp2EHdBMDV/wUn/K4R+XgF1i8/xSMm71cSeOdGU9R5XZfZOG2kVzDRD/5+SBA==
x-ms-office365-filtering-correlation-id: c01e64f1-e2b4-4f80-4528-08d68ce1fdd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3589;
x-ms-traffictypediagnostic: AM6PR0402MB3589:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3589917F10D99B0FA6103CB2F5680@AM6PR0402MB3589.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(54534003)(189003)(199004)(106356001)(36756003)(2201001)(81156014)(8936002)(86362001)(4326008)(6116002)(71200400001)(81166006)(256004)(6512007)(71190400001)(66066001)(53936002)(105586002)(8676002)(68736007)(386003)(6506007)(97736004)(476003)(3846002)(486006)(14454004)(7416002)(50226002)(2616005)(478600001)(6486002)(25786009)(186003)(26005)(6436002)(99286004)(316002)(110136005)(7736002)(305945005)(2501003)(102836004)(52116002)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3589;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: er8HVtngzUtySUJ0xH+t4VPq5Uomh39tU/KDEvszrOJMIkwsTdw+ValULYczGsyyBuUgi+oj4PLxN0IxfI7Jfh8WHpPlPd1X/ksvln9zMg6AmKq9bYItH1TrVmBpS9X9Di+wrlv/eOWeYs++nh/g63xfbWoOX7+FaC/WNdmbqRQQDdRhYte+retNUqaiXC1MqIuU4e446WGvak9fAVsOS6X+A6KKKX3+KDKMulvpzrn0wvdqheJkVCGR9kCVLx63a3qwaNbh6T/CplmIVW7RT/I7DpsQoEE+VjvzLs0e8mxabd0oU1WqcgkP+CnzXzM0DzkJmgQERAdZ96M26D6il++AbPr3veMJt9STupRUe/jjc0kvC2GHFe23XPuGNq5Eyjirj5IOp9AOsC5VC9d0cBLpHoDPtdduG278DVBdJmw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e64f1-e2b4-4f80-4528-08d68ce1fdd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:52:28.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3589
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
ChangeLog since V5:
	- add "imx,sensor-resource-id" in each thermal zone to pass resource ID fo=
r thermal driver.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt    | 20 ++++++++++++++++=
++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..4b79751 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,20 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
=20
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+- imx,sensor-resource-id : This property should be defined in each thermal=
 zone
+			   of thermal-zones node, it passes each thermal zone's
+			   resource id for thermal driver to get temperature via
+			   SCU IPC.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +182,12 @@ firmware {
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
 };
=20
--=20
2.7.4

