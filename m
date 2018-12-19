Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70774C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3283F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i00vHdoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeLSHJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:09:17 -0500
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:3157
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727904AbeLSHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNyQ9rOMmTt3t4LgNM8ytmVDhZxQ7hbtYzpK7kNWRTk=;
 b=i00vHdoVgHaF95JFemixuxTrBtQfJs8rBvPnnNww/dxP0kbwCmk5YPbJd7e19sfOGYFPAva8dngSIeGrd0x0LGMRZQwyUENpUSMuaWl5HQK0wfzMbYZHzGv5vO/WyaVasiOnqsGdierTS0425KMuKpAsEshVXZ0yUgPuBwgkocI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 07:09:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 07:09:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH V3] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUl2m9OXNFO0V0L065iM7FLdEHQA==
Date:   Wed, 19 Dec 2018 07:09:10 +0000
Message-ID: <1545203073-10659-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3787;6:xyeTpcIHc6Mb/UW2tCqe05iMrpvDv0QyYeap4p2NdESboga+hR6nDvd14B/PsrrOGmcMzIOFY8cjE2y2z1MQPxwx1RUzntowQKlf/1vlBnkbszdo+6wn0WmTOUR8bhv6MkqRDf4WcHaSLzkbJlqia68V2heoe804pPbnSPD5jaGywXMGUu5YqcwQuriQ45RLkqjTm3DL/KH4Hkej5e6s4YGN3nBdTGMIysuA/gZAyNplkktbPKgLNb5yx0NJoSbvgI73swgZUvv6ei2ywfg+mYiYiTyWav6f7g/wLlKWrd1JJrN9Ie/pHB6vHxs4C+0hy9hTo5smWYCunaYvZX8GwEoF/uYLIP/0dqLGx/1Jyy8EZ6jaWQ3Q4s+gAX9urZkLP6uqia+IGDc6ofOxGx81KT9e+VHnbPFhQXDkYUs2DbLY2pGdSv6UrJqAVfwFgaX6xlp4OlhEt2WPPQ/RQLY9Fg==;5:j9T5LzSse+vv2E6OJ0+uxoxeczwdI9P1VQLOg/gWYiCAZ4/e6R9X5O4Law9+7tf2RNJtnt4wILEjGOQKBmRPRsBlTxmN/icKNHnhtES4MznCnyHdmH2+F2EqwDKvxUbeJuEn7ZXlIHVvInG63wCTEWCcmBxzq8wdVAtXobHuL9g=;7:myTQg3E8VPqs+H98U6NFJ7ld/Qh0GA7Ledb+HEj8+XdZ1LcJihe6xY0rGx3WwNUpPXNER7pscNCYg6KbuC/XeqT44G0FYQSkYArRrqoiM07yqZS3dgTJlPfRv8oEkjeVLZzJPHDEofllqUxDq450tw==
x-ms-office365-filtering-correlation-id: 731fc57c-9105-49d6-6012-08d66580df7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB378706FAF6A02688EB65C7DDF5BE0@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3787;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3787;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(189003)(199004)(97736004)(105586002)(6512007)(66066001)(52116002)(106356001)(68736007)(5660300001)(2501003)(14444005)(4326008)(256004)(478600001)(476003)(2616005)(486006)(53936002)(71200400001)(71190400001)(14454004)(25786009)(386003)(50226002)(6506007)(99286004)(7736002)(6486002)(316002)(36756003)(6436002)(186003)(3846002)(110136005)(81156014)(81166006)(8676002)(86362001)(305945005)(2201001)(102836004)(2906002)(6116002)(15650500001)(26005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mE2xeyKTHEVJRt7Z18aZ7JMInJoMy5lobgOELK3FNlC/03J4uSTwJK7A7NybwcuRtMvMuc3VbGOJX09Ftm85YM8WlnW6xdp0V7JfbmQsoIs4jLdkQy54ZPIE0dBa5wCJesjea4xhlk5mKD+BddLlUp8+tNf6+MhpTlW/ZOz202T5DNgjZmJt5PnhlHsIrgZkD3tlLFdkPAeENI1JM4sWo6DdpHu9kOoceePU4E0dLpW4ckvt3Lz1bzJS9P551GxoGXvNf/4Z5+QJMxiEhXhlw/m1owvvBHeaaA4jOiZMqdtJy2Fx8yraB7bIxUxSqRAu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731fc57c-9105-49d6-6012-08d66580df7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 07:09:10.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX GPT timer driver binding doc is out of date,
update it according to current GPT timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 35 ++++++++++++++++++=
----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Docum=
entation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11..a7f23a6 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -2,17 +2,40 @@ Freescale i.MX General Purpose Timer (GPT)
=20
 Required properties:
=20
-- compatible : should be "fsl,<soc>-gpt"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : The clocks provided by the SoC to drive the timer.
+- compatible : should be one of following:
+
+  should be "fsl,imx1-gpt" for i.MX1;
+
+  should be one of following for i.MX21/i.MX27:
+  - "fsl,imx21-gpt",
+  - "fsl,imx27-gpt",
+
+  should be one of following for i.MX31/i.MX25/i.MX50/i.MX51/i.MX53/i.MX6Q=
:
+  - "fsl,imx31-gpt",
+  - "fsl,imx25-gpt",
+  - "fsl,imx50-gpt",
+  - "fsl,imx51-gpt",
+  - "fsl,imx53-gpt",
+  - "fsl,imx6q-gpt",
+
+  should be one of following for i.MX6DL/i.MX6SL/i.MX6SX:
+  - "fsl,imx6dl-gpt",
+  - "fsl,imx6sl-gpt",
+  - "fsl,imx6sx-gpt".
+
+- reg : specifies base physical address and size of the registers.
+- interrupts : should be the gpt interrupt.
+- clocks : the clocks provided by the SoC to drive the timer, must contain
+           an entry for each entry in clock-names.
+- clock-names : must include "ipg" entry first, then "per" entry.
=20
 Example:
=20
 gpt1: timer@10003000 {
-	compatible =3D "fsl,imx27-gpt", "fsl,imx1-gpt";
+	compatible =3D "fsl,imx27-gpt", "fsl,imx21-gpt";
 	reg =3D <0x10003000 0x1000>;
 	interrupts =3D <26>;
-	clocks =3D <&clks 46>, <&clks 61>;
+	clocks =3D <&clks IMX27_CLK_GPT1_IPG_GATE>,
+		 <&clks IMX27_CLK_PER1_GATE>;
 	clock-names =3D "ipg", "per";
 };
--=20
2.7.4

