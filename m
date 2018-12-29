Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AC2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFgLi0A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeL2Jjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:39:39 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:4096
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeL2Jjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNoUNnSem6EbS3EbqY4NhEL0gLEgGeVuPlrqRrbt5T4=;
 b=JFgLi0A+bnSrk67n7RXDVFEHbaLPyEk9zOxQIgQh5tZ2ob4VKOvdlI8xHuUqivLAgHQXYv8F4Y5Awy3gLtJ6u7yPm7FzD3MyhNUqWwmLxkq03n4o6YErzFPYn2A46acejx7QHFt8aXQhv8BpiyqHnhbx10j3taFTI1d8lhUwIFs=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3320.eurprd04.prod.outlook.com (52.133.18.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 09:39:34 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e0f7:5b3f:bb6b:759f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e0f7:5b3f:bb6b:759f%3]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 09:39:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH V4] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUn1po6Cv6jEkmxkOQOg/6Eu+hiQ==
Date:   Sat, 29 Dec 2018 09:39:34 +0000
Message-ID: <1546076081-23196-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3320;6:nMnTkL1A05/RGNYmsyS8Yimf79DqG29/80QknuxvI128pXvL2WYa/SGP7TkISWyyEltOU1+Yq8lkqxWcWpXldavoxeM7rp2zGKMBhhwdM1CS0mmrOTIw4g8ZEU9HWahiyAgoJeiEiHlDTEhw0N3ni6GvvvrvYsS43Czn2xnIrLtBcTVdzJyQQhKyZkycD5WAHp3TkgKrTNJ7/u1wmQoj40wAMk5ibmegGgPyP8QEz7cGOvCdkG3HY/IHK/amJ33NdYGrR4J77MrI0CXXPujzLNFR2TxFQB2ijTBvFu1W1UZpe9iAF17ZojDTdXxZUruU5gQZliRXFnzfVZDZVkJn72qnEHfdQ1VJwhdesgFMy8g5JrL7Rtc9IPmT1iqr8eec6JBJzC+qieUdRsu5EFI/PE35aUrBtoLsHtZxcrk7O2a1EmkKYuY742U34ZOOAMZ5q/RzG3okEwBFnINi5jXsQw==;5:N6s0Q+iddJ630i0QOxmFeO3NbtCkAFs4MYMwGUr1SpuD88WQBaUOFGdRVM/HSZMkvSfdpUhTxtalqKyiIzCc7xd6CYQlM+Rv3TLQ4LkR1ho8rzb+/bAVz9/2vG11XqTshhxq2gjfRefT9071q313OMjGRt+3bYdkYZXgudk+JQA=;7:ssco69Ism1BwExmq6jViJgRO8Cd6Vm060uMJVbJWewL4AkxQyGhHQV5hopWsfi5ZCTeeO0nUw2jspakY9G20tpAwfSFv1cB/yjKnIpVCxxRV2WiENdiEhR8K/HaPWTLOROMigvZ8z7D+LO4X31Oemg==
x-ms-office365-filtering-correlation-id: f7fdd809-0fbc-475f-60b2-08d66d718a20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3320;
x-ms-traffictypediagnostic: AM6PR0402MB3320:
x-microsoft-antispam-prvs: <AM6PR0402MB3320640B6D44D7742ED1888DF5B00@AM6PR0402MB3320.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3320;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3320;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(54534003)(199004)(189003)(8936002)(478600001)(81156014)(8676002)(50226002)(6116002)(81166006)(2201001)(99286004)(2616005)(6486002)(476003)(305945005)(110136005)(15650500001)(7736002)(256004)(14444005)(316002)(86362001)(97736004)(3846002)(486006)(14454004)(105586002)(68736007)(106356001)(102836004)(6512007)(25786009)(52116002)(71190400001)(71200400001)(4326008)(2906002)(53936002)(26005)(386003)(6436002)(36756003)(6506007)(186003)(2501003)(66066001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3320;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uPXrqLLE9qfE3iVxn/RXC5LmVZQ8FAg10Z/dhKmAAscqwmaUY/B9dDJ7oyUle+qIfNA4ZGtUd2kPGYxSl/jIW0H7ZnPPkNQujjAXIHTKi0r/cjEIlKMXJ+qDnzYI43j/TtROjxg8YBcZpCCw2KniJ+MiNwSdgKcZI1VqYL+2/ws3q4TGul29qMhjJslGbo8ymAl67/rV45SgOmX0QW452/YYe5r9lG61MAAC0JsdY1+kn1tz3YRAOE0ksHobTsv/JGgVYdHlG++7SiCMIjWa9HIpakgfKXnE+3qU5TvijYDBwcASrZG0sqUrVsGnRSKX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdd809-0fbc-475f-60b2-08d66d718a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 09:39:34.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX GPT timer driver binding doc is out of date,
update it according to current GPT timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V3:
	be more specific about the backwards compatible of each SoC;
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 39 ++++++++++++++++++=
----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Docum=
entation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11..5d8fd5b 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -2,17 +2,44 @@ Freescale i.MX General Purpose Timer (GPT)
=20
 Required properties:
=20
-- compatible : should be "fsl,<soc>-gpt"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : The clocks provided by the SoC to drive the timer.
+- compatible : should be one of following:
+  for i.MX1:
+  - "fsl,imx1-gpt";
+  for i.MX21:
+  - "fsl,imx21-gpt";
+  for i.MX27:
+  - "fsl,imx27-gpt", "fsl,imx21-gpt";
+  for i.MX31:
+  - "fsl,imx31-gpt";
+  for i.MX25:
+  - "fsl,imx25-gpt", "fsl,imx31-gpt";
+  for i.MX50:
+  - "fsl,imx50-gpt", "fsl,imx31-gpt";
+  for i.MX51:
+  - "fsl,imx51-gpt", "fsl,imx31-gpt";
+  for i.MX53:
+  - "fsl,imx53-gpt", "fsl,imx31-gpt";
+  for i.MX6Q:
+  - "fsl,imx6q-gpt", "fsl,imx31-gpt";
+  for i.MX6DL:
+  - "fsl,imx6dl-gpt";
+  for i.MX6SL:
+  - "fsl,imx6sl-gpt", "fsl,imx6dl-gpt";
+  for i.MX6SX:
+  - "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
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

