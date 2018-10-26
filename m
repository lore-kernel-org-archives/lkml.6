Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD77ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075E420868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcSc9wcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075E420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeJZSX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:23:29 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:33174
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJZSX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fDcKqrFtViNJI7iKSr7sSxgbIkq4EscLwd+lRIGo40=;
 b=gcSc9wcsL1aGt70ONB80HHLao4kruFIx7AY/xsOiSBdAVgzjJW3DD9gkFPnQA6U/bPyxYbsKoEPK0TVQzSp+HwAn0Sm9qeBodYawSPYkqk0DlTMDYvuBK7tjlTzc6UsYPsn4lxxMGklz0pJ13tP4zQMrkWjiI6b1UPoR+52kEEA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4137.eurprd04.prod.outlook.com (52.135.130.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 09:47:02 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:47:02 +0000
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
Subject: [PATCH V2 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup support
Thread-Topic: [PATCH V2 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUbRDYDB5lt3Eg5Ueco/W/DjJVyQ==
Date:   Fri, 26 Oct 2018 09:47:02 +0000
Message-ID: <20181026094444.25305-2-qiangqing.zhang@nxp.com>
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
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4137;6:1FvqFVJmaX1GWOl9LPahDRZtpdvFSjixiJQiEv2akw5UcpKAuvh/kldy/npB/QOm7IUjhKM1SLJriOhv+MP9oWeE7z6HNnw/VLnf/DSdzXOTcg+EIkA/1gjWYG7InWCs2XiDOp513bVL1YupXGKIq8ZUiLhZ0KSGwNSdWctUnt8c8Bq6AV9Edco0LFxA3cumqgTYWrlK0zYCU0KFeq9Zcg/6V0pC/CA9bLoSwsyXJ+MOBviY4UjhNvuLw36GPXQ6WGVzQkCpzBsvE8nn4hehSAqC7Q+E3BSUhmlPD7nn8yaVFS2Pwc1lgiytnwvIRXbcmJ5aIeooeCTy3VnAU5xgvC5xlMyInM5gUeHHfoWhgx0KjzrZm2FdVTxvlE02heIJJS918yvhHPDzXNDfnzY2cIvVx+8kkZFaZASTDhVPzxKTLPTQs7tzASIrhutoGNLXaL5q0dAguhqQKo1KO0Y54g==;5:74UPw3qNxN3twCPswvnr874tVWHgHWtgzYoweSiXZ3Cva6rVGYmkRbeSU4A17x6+YosDfPeaxd15qQWbp63qK4sjKI6ZtAckkU7I6VET/BfTfemz7r6LBxVbf+vYBcKZyD1ig0attISGvpZiUoWNkz8wEe4hMuTBh7xS4TTBk24=;7:qrVTa/IJSY9sPRmi74gXBvNqI+UYDsijBDZbLJV8uekXVUIjoUReAMS5HtKZ8899iz4CY22w7SVQ5IVFQzIODqNY22YrHu0MxlECSGl2kEDaFdxbCkPGvVABJk/lZvEhWXJFkdfQtDclK/ROcNvN3A==
x-ms-office365-filtering-correlation-id: 6a77ed15-5056-4a4d-4b91-08d63b27fad0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4137;
x-ms-traffictypediagnostic: DB7PR04MB4137:
x-microsoft-antispam-prvs: <DB7PR04MB4137F77FE66E2EF3CFDE602DE6F00@DB7PR04MB4137.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4137;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4137;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(54906003)(4326008)(316002)(110136005)(6512007)(97736004)(305945005)(2906002)(5250100002)(2501003)(6506007)(14454004)(7736002)(6436002)(6486002)(53936002)(1076002)(386003)(66066001)(102836004)(5660300001)(3846002)(68736007)(86362001)(486006)(6346003)(99286004)(8936002)(50226002)(52116002)(76176011)(186003)(106356001)(71200400001)(446003)(476003)(11346002)(6116002)(256004)(2616005)(36756003)(2900100001)(26005)(25786009)(71190400001)(14444005)(478600001)(81156014)(81166006)(105586002)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4137;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-microsoft-antispam-message-info: mVXqp6BULhsAPZZUu1+JqrCL5qjaKaqqp/jcy5tn1nZFiMJTWKccfFrMHAKVPN31t+iZaPQK3tzoSt7Mo3PJTXi++07Fv40B4kYBC5SLjsnU2rMGLgVM/RhTJJxxGSgsdVbzkKAZfJicJVtRMoR5FBNB97lvr+5690CnCTpYuXNKLzPcK8aRuyOn5LFVnxmPrGpslZekE2zgiN5eH9ASmHgiJJkbNdxQANBCvYju9++7MRP63/NVM516zLcDobBYE2L/v4BKVw/JIxYI1wI6QYU1F/GFOefTlCDgL4lfkix+ooiVLnrNgddR+o9Tww38z/EiCDFsAt4vWtdfXudwiKdSDNCkf5TpBdNu/Lk/ve4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a77ed15-5056-4a4d-4b91-08d63b27fad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:47:02.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4137
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
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 95a3c1cb877d..75e2ad880b78 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -448,6 +448,7 @@
 				clocks =3D <&clks IMX6SX_CLK_CAN1_IPG>,
 					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -458,6 +459,7 @@
 				clocks =3D <&clks IMX6SX_CLK_CAN2_IPG>,
 					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

