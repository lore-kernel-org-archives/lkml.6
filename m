Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB05C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE352084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQN5Bn7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeLQHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:51:45 -0500
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:6336
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbeLQHvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHEmSQ3zv7fBp05BnwpYlDl0fWBb+EAKamPsa0X26EU=;
 b=WQN5Bn7FA9MagFQqkAy+CbdL9LYYYXtUcFo78m9o+UgNmJssYZgi4bLKP+ITLEh9BqPdAHp6Vihlt/5QGEJytSCFccOzslMbJrOFlWK6TvT32KFzdGYTZQkAXHpozOqe91FcEh7OSdG/QFML2pjrJn+uXywDggQIHz5MJcqnZBo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB4769.eurprd04.prod.outlook.com (20.176.215.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 07:51:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5507:f6c1:df5d:ba18]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5507:f6c1:df5d:ba18%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 07:51:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] irqchip: gic-v3: remove dead code in gic_iterate_rdists
Thread-Topic: [PATCH] irqchip: gic-v3: remove dead code in gic_iterate_rdists
Thread-Index: AQHUld1Z4nCDCNy8lkywCFiFN/Ga+A==
Date:   Mon, 17 Dec 2018 07:51:41 +0000
Message-ID: <20181217080040.6790-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.14.1
x-clientproxiedby: HK0PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:203:52::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:73::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4769;6:k3lJ7q5oqQSeU7JdBuJAHMRRFpqD5xmcfTqX6N36clmFi0F/5ZQKpjg8G9IJ+AJC3JbTxdYW0TToJr60tvEkITFvgMmo0lPal9tVExvyFl5N0pJnrALxf1FlaDBvbsfu28ZCrf54SrSfKyjmhs8BN/53A8aKgLES0C0gsdN+MK4a/lOFFoCxFqyOKQ6YcQVh4hquj/CQz4ZaQ0ktBctuH6FAoLshnZgWke/bBC15m88WArFf6c3F9EeS2gOHJAe6d9E2swAAYPJW9qHUBHUMGZ/DNWbduIfO1qlytOr2hDI9z4xv8i5j8Vh43PJzFjgeTfnMvHHa4aYIdJn/nAO2pFBgGKoWKS0HVdLORgS/sQK4myENaySaPK3AsdGb7Rn8ciLfbrxwelDSPM2tqVnC9Vyf4qjpYi7y0t/PEgKulkoJbdlEyLU/0OqY7/KwtlyBCSS4OOucJayjADkHkBq1ng==;5:TfNi3NH8ucZ1gCqtsEWU4cm7kORo2eL5hoGVOdLJKayoGSscr99fQq7Fnkjn4jdOx1nSKaFaHswMElA7u+j9LkA+b2OX8Eklzgcwt3rKImSnSBmSg1D5SqVIOQtdca4U2kD2BiJzBSxUcIasJaPApmqmpJ0R5Dwc3uq1WqimVpQ=;7:Q8IPBpsoAfuk0UAVtV9Id64mmK0pkxwB7FpmOqTY07a9Q4y/jgpiIwl1LTXqFhkctdmKX/Bbg+DhYjPcpuHSFCQra+UknzuMlR/QgMe/6oqddKO6rhdM+bCuoP56KvIlEzjzFwiD1uzWUeZPouVtBw==
x-ms-office365-filtering-correlation-id: bf3b949c-cf0b-4436-0877-08d663f47b6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4769;
x-ms-traffictypediagnostic: AM0PR04MB4769:
x-microsoft-antispam-prvs: <AM0PR04MB4769BBFA89C66C8F29093B0888BC0@AM0PR04MB4769.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4769;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4769;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(105586002)(3846002)(68736007)(106356001)(52116002)(4326008)(54906003)(6486002)(8676002)(81166006)(81156014)(25786009)(6506007)(8936002)(386003)(6436002)(256004)(1076002)(14454004)(186003)(26005)(110136005)(316002)(2501003)(50226002)(99286004)(102836004)(2906002)(5660300001)(2201001)(71190400001)(71200400001)(44832011)(6512007)(476003)(486006)(36756003)(97736004)(66066001)(2616005)(86362001)(478600001)(53936002)(7736002)(305945005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4769;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HL2j0duIRqIDm1LLl/52rE7+v+wklLLY6Uuvk059vQFYuPr9NxmBR2Xqr+Mym8Gvj2OutHu0RPlzkZHFcm8CEOqrJgjHv4RaNRo+g35kOPxLnAWqKYq0OUV2vP4lI1wS9+UvBMvcryJhSjXGADo/Q4oOYe8kZ7EdJM0FazQn8ehDRjTFSrM4Q/Z3zZs+X3nXqF48qqrEuAU3PfCaqUe4MMwNqc3Cg8xRZUTVLvTuCbXQ839+9EXYy0gWVF2bQk0gZ2a+UeHQO67o5md+VZcRCPcVV5EIrYt04eo9fPWe3UhnlE8HgXnj7LQzBYbX4Pc3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3b949c-cf0b-4436-0877-08d663f47b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 07:51:41.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gic_iterate_rdists, ret will never be 0 when `ret ? -ENODEV : 0` at
the end of function, so let's directly return -ENODEV.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8f87f40c9460..9d6e802e29ce 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -425,7 +425,7 @@ static void __init gic_dist_init(void)
=20
 static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iom=
em *))
 {
-	int ret =3D -ENODEV;
+	int ret;
 	int i;
=20
 	for (i =3D 0; i < gic_data.nr_redist_regions; i++) {
@@ -459,7 +459,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_r=
egion *, void __iomem *))
 		} while (!(typer & GICR_TYPER_LAST));
 	}
=20
-	return ret ? -ENODEV : 0;
+	return -ENODEV;
 }
=20
 static int __gic_populate_rdist(struct redist_region *region, void __iomem=
 *ptr)
--=20
2.14.1

