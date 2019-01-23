Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A564C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C78321019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDPpgCyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfAWIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:01:16 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:61312
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfAWIBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc8d1BABvtW63/QrDl2E9nA93Xi+OTpa6DOfV9gLCc0=;
 b=LDPpgCyzGL7OmqoNhM08a1HD2HpqreiJxbUcXj0ZSx4Ir+hN/25FqOryDrEf5mLBhYIytInJOlGmCLT9o9jOiwimlsVnwrKpzHHrC4uExJ1WUMgDWHJ+/JlTOjLTf+2xL1kKXw6AyT6BIlsr7LwqiuJ1Wvu24UjdiKF0T/VvTGI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 08:01:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:01:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Index: AQHUsvHOk0zMHq5joEWG3q1+7cErPA==
Date:   Wed, 23 Jan 2019 08:01:11 +0000
Message-ID: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3851;6:PjsM4vLU6T05JdVE31bDcu8ZZJI4+SDKfoJSH12+lNtMT2tHCAZ+h5sT6Z+dtgVFqsxHotmmA/jCoJZqcw8yIqrHDjZdDCqDbLem3zzMbDtlMvZZUOvkJ6gTuI572E6xAboDIMpJaaCBmbR+zccaV8olM5Trb1PD/GD+x444eCCfABjgYHCr6T22mQYRcvt2JRHZ7pxhFscZ/cDuDAWSikQU0Ete+uuTiLCbO50hxICALEVDqBYMchEroNVqh9Z7Nt9KeidyHnVLaTP/4B4m0IXpCq/PpKWYld6dduatEoGHlkJbQQSZ54pmVsCe+nOuNOTH6Fw2v11U9IgbaJCcYkZrQgGQ51dIyLc5omJAK7nH0i3c/dGBPYn71AksoqzOzhCFVOWreIZMkWtE5CJ8nX9WlScAiNf+69a2QCYWAugEGg7+ORC8a3zc+/grNT++7902+RTBEa8buN9+LckFSA==;5:KfWNF7u9Q0MedNfKd9Pho/oJXARMa5nroJIiIULSaors0+eXxWA68iRO7u6/RYEDV0NmlkqVjWGJY2jPD06oGiTGQWNzd2FXbIwtWTKAMVNZqRyRlynh7kvS73lcWurTNdOcC26cBE9URSuWmvGAaHIyI4zBkIK3xubNUuEabSh84gLtcZxNfipgtEd6+UZMKyZEVydyv6Z5m/qd8QjcxA==;7:ZWm+JcHCstpqmL9bk90vOxbKJt4Z+5JvucFlr32lu7y6bKCqWRd3jZBk6i3YS03khSr53tE6GKQfgODmlP/nS5jLJAxOaH3GcCCOo3tqOnzq8LfDt0EMrn6t/J3JGPukZiJn4IeaFrMyElbGC9Jggw==
x-ms-office365-filtering-correlation-id: 518b5842-f5af-4eff-4531-08d68108f09c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3851;
x-ms-traffictypediagnostic: DB3PR0402MB3851:
x-microsoft-antispam-prvs: <DB3PR0402MB385108394C0680BA7B1088FEF5990@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(39060400002)(14454004)(106356001)(25786009)(6512007)(4326008)(478600001)(6486002)(68736007)(105586002)(36756003)(6436002)(53936002)(97736004)(7416002)(6506007)(66066001)(86362001)(102836004)(386003)(6116002)(2616005)(476003)(3846002)(186003)(2906002)(305945005)(71200400001)(256004)(81166006)(316002)(81156014)(110136005)(8676002)(99286004)(50226002)(8936002)(71190400001)(26005)(52116002)(2501003)(486006)(7736002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3851;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oiEUAPx13lw8fBaFqcoHVXRfN1T2cFSy0ivEKq8UhO8emhV3lLJFKSuVrgU+1m8rdfMt+wdcCPxnA091e1p2EJ7F/tO0MLRF9GWqgv/n2afdCWK1+8+03WlnGIZBYzSKKnnGePOwPgS19TaZebFUzTRGwQZyyleYeay7o7Ozx9LObf66Zs+8EHHyDYyVQkW61KMVCPheIyWrYzXnY575gidhvCVx6UZ6TH6c9FWIrBRThMjztjVoc/UfA1ijv3uH7hds8YNfdtiR1MXXJRFiv/blxj3hx+0kgqnFi2wWakJoAOqNZYAS41Bsp0oVY987l2jnhQ76JxwGL/olwvDYfEE1xovbIf7+VBu8cuN7nD8l8rmL6YwMH5rogn8E2khYqRXh+JHDipKXfw7ygsjP8OwBsc2mWwUWERxMDGQ6h7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b5842-f5af-4eff-4531-08d68108f09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:01:07.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scu general interrupt function support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++--=
----
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index fd2bed2..3c976ac 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -22,9 +22,11 @@ Required properties:
 -------------------
 - compatible:	should be "fsl,imx-scu".
 - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3".
-- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
-		for rx. All 8 MU channels must be in the same MU instance.
+			       "rx0", "rx1", "rx2", "rx3",
+			       "gi3".
+- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
+		rx, and 1 MU channel for general interrupt. All 9 MU channels
+		must be in the same MU instance.
 		Cross instances are not allowed. The MU instance can only
 		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
 		to make sure use the one which is not conflict with other
@@ -34,6 +36,7 @@ Required properties:
 		Channel 1 must be "tx1" or "rx1".
 		Channel 2 must be "tx2" or "rx2".
 		Channel 3 must be "tx3" or "rx3".
+		General interrupt channel must be "gi3".
 		e.g.
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
@@ -42,7 +45,8 @@ Required properties:
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 		for detailed mailbox binding.
=20
@@ -130,7 +134,8 @@ firmware {
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -138,7 +143,8 @@ firmware {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
=20
 		clk: clk {
 			compatible =3D "fsl,imx8qxp-clk";
--=20
2.7.4

