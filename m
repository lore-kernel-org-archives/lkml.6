Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6920868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ocUr99QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B6920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJZSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:23:33 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:51904
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJZSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeSiai/ULXbyyXqcvK3W1z0lmUNdIaBnY4Q2C0DXQy4=;
 b=ocUr99QEPg3r4VKnCIdpswnANiNrvPJoAYORlv2aZZmCoeAtOl5qziJ07EHVJTLPdQcQK+14MgZAqsA61s682M0GkITiscpED+aHGU8scgBJdL+JtBX4Rvbq8klO5vrpQHmWX+XqESB27BPtezDi7DKoCpeqDeZL9omvES4U+WM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5225.eurprd04.prod.outlook.com (20.176.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 09:47:06 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:47:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 2/4] ARM: dts: imx6qdl: Add flexcan stop mode wakeup
 support
Thread-Topic: [PATCH V2 2/4] ARM: dts: imx6qdl: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUbRDbiKknfbR9mEaCRejjx8GHWA==
Date:   Fri, 26 Oct 2018 09:47:06 +0000
Message-ID: <20181026094444.25305-3-qiangqing.zhang@nxp.com>
References: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0094.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5225;6:WyyXb/IvxlGgUhj1L9p5Yj74KoG0+1YuAyd4ik4QF+papuRfHuHiGuE8VfT0CsIi7y0emyRgl6steSahb1b6R7IEk27IPFIzSq0wO5kEf5Bmc65ED6gNN1or+ip1TcjcMrTr5qrkEw6znxGOCM33igXZsEwOyhBvHPwZr+YJyMxKgFd+SxIXndOb8TZgQEdZrXIILh58sZVRn6ltcpzBeXmiUgX20XqZSPjRL1CPWGacMrYcLLlr03Kx2JfCanLmIqjgDSPXc+qIQlgVS+yCKrsJi+yi6fdw2H/g0YNaoFCyso34tltHCkHcx4AC7BML1iIigRGvJSn/cq3sI9Tjy4/ytf9GQK+DJQVPd7IFEJ4Kb9+l9P5sMAkM0eX8io5W+h7mrXBDwf7wyj9IKq3kZkmW2SvAVwHn0/+Z1AHECwM8jmKjjFx5Y8eW/ADrCqAK7MJKrfSBjT6PUwZCkovEpg==;5:RsqJS4X/lPZEgUZtkQNI9ng/u6vBb7t/eWjH1cX4pSwuABgLOpgSi8EFvmSvykkEvyxgnpKiWqlShWeuBtAifVd3Wr+m0XK0wIjbeeskiZdH4cu8Ck0tSHoro6RDe7EVDqyY3iwR3sqDbSkTSWpI1VH1ZW9QEwfUgsefCXSzNK0=;7:FnxoJx6ObT4gYXW4T6UV65+E2IJnX2ViZ3aEMyty1yZW5RV1QjiWhMnKuITk6oI3J5ryMSzb4ypjPHurr+UbBy7QW1ErHiVXLfeR8nzGtZJSzKR0JD5BrA/lDWqealMkjDXhgdwj4vTsQ5gEUJs54Q==
x-ms-office365-filtering-correlation-id: ee6d03b9-1274-462a-6388-08d63b27fd47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5225;
x-ms-traffictypediagnostic: DB7PR04MB5225:
x-microsoft-antispam-prvs: <DB7PR04MB52251C79A4916869AF4BE0C8E6F00@DB7PR04MB5225.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5225;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5225;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(476003)(14454004)(575784001)(14444005)(486006)(256004)(110136005)(54906003)(86362001)(5250100002)(2616005)(97736004)(71200400001)(186003)(81156014)(81166006)(305945005)(8676002)(7736002)(4326008)(53936002)(71190400001)(6512007)(8936002)(50226002)(25786009)(2906002)(26005)(99286004)(6116002)(3846002)(6436002)(102836004)(6506007)(66066001)(105586002)(68736007)(1076002)(386003)(2900100001)(52116002)(5660300001)(446003)(2501003)(11346002)(478600001)(6486002)(316002)(36756003)(76176011)(106356001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5225;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a/xz2JRGGb3Imf4nGMw/CwgCpzgOhuBj1sJr9MN6StosaswbfRIedq/HJIw1PdfKP+i2tz1Be9BPIhqBKgHBTTBtGG9BtyfL0GzLjhJJTqxuFaaq4UWyhRaJTHqij3mCMlm09fglprVj1iBx1T1GCy/pChUSxNb/MwCof6VyH2yWiOCmUX6iJZ6NwEJVy+ZQ5WF8b6nLqZTl1aqmLbTLYfpGwJUQvT18hwbrvGy798JMEIWAc35vReml7sZy8JFBJotwV9h3MrLEhX6uQiKvEH9mBn5IWa7Xxy/e9OvAlClgMFs4Blv/Ufz73XKCoZS6yezKGaaN7nfclh0hppx4zJfAbEiAm2MXtaGs0oWK570=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6d03b9-1274-462a-6388-08d63b27fd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:47:06.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index e4daf150881a..6ffaed0f0bdf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -548,6 +548,7 @@
 				clocks =3D <&clks IMX6QDL_CLK_CAN1_IPG>,
 					 <&clks IMX6QDL_CLK_CAN1_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x34 28 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -558,6 +559,7 @@
 				clocks =3D <&clks IMX6QDL_CLK_CAN2_IPG>,
 					 <&clks IMX6QDL_CLK_CAN2_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x34 29 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

