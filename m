Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F79C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25ED2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U0oIRpls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25ED2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLLHUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:20:48 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:55840
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeLLHUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqeRbslt3D75bHZ+RfzUhUye0ntzLm2vdl3ghpKKhAI=;
 b=U0oIRplsX3O/dSbc1QKuQg5PVabkDO4cFxHoUFKM7Y6Y5rD1kKSEtF6Iax2rFYHR7l3RVeKr14WoEVTBv+JUO5VThHZgAZaYhDA758T7hZktscPVqjkPKlnfGDsbAq9C9hMpn1ZsSEy+pD4yjr60zDTqsbARtFMqdu4THdFT+ks=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 12 Dec 2018 07:20:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:20:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH V2] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUkesyTVVs0WJXMkO1LYqT6j/uOQ==
Date:   Wed, 12 Dec 2018 07:20:44 +0000
Message-ID: <1544598889-2995-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:203:52::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3756;6:CQpmw2lnenB1fyIJedzzxTdihcIqeLcjGErwl6nWRlONN8U65GTnYEHPjhI50iR5P9QWPwP22Des0Ym13C1LRXlxL9LAK2HCyNEmxMKUnhj9YKHMCp7pqmbZjnLjp4K1n8SwMtdD7ReSzkGfZ+ZjnUPtiVpq+VZC93G00q/nrtuxE8V0AGCzCtv7F0B/CdrXuHXCdvosYy4rbwXPW2KS47Oy8n4qQWvBQ7rhcriKvY0S424Su6JE4QNvOnAnnf6jaVadVGTItxbG/TIsoEhwLgO/OTI1IYogBWueBzwPxyCkxVpKY05V4aLeep78YNlroC6Lb1F71yxlO8HfGXyF7xi6s+NnKCLzwu6tgv423UfgpseNk6HUo//X1sb4oF5o6Mezyv2MN/GmNKklY8Iljajl08dRbtY1tNQxHmrRyj5JWw/3trPfTC2pb93+7W0d83JgK1efw5UhCyGnN3vZhA==;5:g7Ig7ttlp1vjmstbD12EE1NPYYE1AGdOqYDjFpuMnsrwPaXIMDBdALLmXObCf8bA4jflNq5v0T1e6b7bW6tXZcQgWtBaWd627gp5k/YMKK6hI0XobTYXSjPe4W7F9KoKlUtiz5MYlGT41ALoPrSyt+8TBeu36+PpPTMYPu8ILXM=;7:CleSsYmEHlBjZZqtuN0MDMXjpWfs/MyFc1VkUQBjtLox2rcXbcNs56CQXQqR5XvF4ZgG2Mn757FmfiEXftEyJxHHSLJryWEgpx+PdNPh6MQJ+vOiJHuypSRN0BdwEYC7k3rf9ZTplqFYndn9Goo5iQ==
x-ms-office365-filtering-correlation-id: be658612-4781-416a-187c-08d660025488
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB37566F05900A44B73158DAE8F5A70@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3756;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3756;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(7736002)(5660300001)(305945005)(4326008)(2616005)(486006)(476003)(105586002)(14444005)(106356001)(256004)(66066001)(97736004)(86362001)(6116002)(25786009)(14454004)(71200400001)(71190400001)(186003)(102836004)(478600001)(2501003)(36756003)(6486002)(26005)(6436002)(2201001)(15650500001)(2906002)(3846002)(6506007)(99286004)(386003)(52116002)(53936002)(81156014)(81166006)(8676002)(6512007)(68736007)(50226002)(316002)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +qX3/rLuvf0FaRu1SpsRzlZ4A+mGLensskSwghyNJ3BRVhbn5qciauT6P2kSmwPV0PHozyOlHRqNTfAP1hWCDwHBaub+Frku8zfc/KTsqwV9/DoKnmcMaP5q5ofx+2qF1TncPRAcEbzMXBLqysjNG0plldcaX7qj+ooAi09lEdOE7i50454tQ1pPG1rAUs4ERJLOZPMOaQzL6i+H+p52/szwhdRZZjf8MfbZLoGNu8qNx8Rx9YRkI0kWzJxJz5Tdz+ZnoKwBswNF0PxxajjTrOQVAF7FdShQaTg9rcFa1DEoZjZjOCUlBWA1CWcwBn9T
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be658612-4781-416a-187c-08d660025488
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:20:44.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX GPT timer driver binding doc is out of date,
update it according to current GPT timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 28 +++++++++++++++++-=
----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Docum=
entation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11..2ed84ad 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -2,17 +2,33 @@ Freescale i.MX General Purpose Timer (GPT)
=20
 Required properties:
=20
-- compatible : should be "fsl,<soc>-gpt"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : The clocks provided by the SoC to drive the timer.
+- compatible : must be one of following:
+  - "fsl,imx1-gpt",
+  - "fsl,imx21-gpt",
+  - "fsl,imx27-gpt",
+  - "fsl,imx31-gpt",
+  - "fsl,imx25-gpt",
+  - "fsl,imx50-gpt",
+  - "fsl,imx51-gpt",
+  - "fsl,imx53-gpt",
+  - "fsl,imx6q-gpt",
+  - "fsl,imx6dl-gpt",
+  - "fsl,imx6sl-gpt",
+  - "fsl,imx6sx-gpt".
+- reg : specifies base physical address and size of the registers.
+- interrupts : should be the clock event device interrupt.
+- clocks : the clocks provided by the SoC to drive the timer, must contain
+           an entry for each entry in clock-names.
+- clock-names : must include "ipg" entry first, then "per" entry, "osc_per=
"
+                can be a substitute of "per" entry on some SoCs.
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

