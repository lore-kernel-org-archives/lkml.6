Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4287B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWxOxJdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4287B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJZSXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:23:39 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:57778
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJZSXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EXktDXlAj96feWq4XLYblhmZeDvwE6NxTmUzSYalXo=;
 b=UWxOxJdDms4Mbm8x7oJNnZCflP1iftFDgzYY6lvBqltTJ1xoemji5TExTr/6PWm+qtnofPW0QSaF1RaFkIdIuUXxeO8dUF20aH1obUA22cMwtoFBJGKqwUpDYnSt807v25igZtFEfo0UOcDVLLHWXeoRPMHQsq5yZc92C9TpCJ8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5225.eurprd04.prod.outlook.com (20.176.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 09:47:10 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:47:10 +0000
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
Subject: [PATCH V2 3/4] ARM: dts: imx6ul: Add flexcan stop mode wakeup support
Thread-Topic: [PATCH V2 3/4] ARM: dts: imx6ul: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUbRDdS3SnLIS/wE20L1HZkw4Fjw==
Date:   Fri, 26 Oct 2018 09:47:10 +0000
Message-ID: <20181026094444.25305-4-qiangqing.zhang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5225;6:MABEAN0erI8Pj2ges0c4UdCkd4B1E8XE7nyWw0g6sTLXNZKvhBoQlM4BTsbbPhmvDSemqIab3FwhLd53c0D5BBk8UgyKWKHRt3FwbxwmDd7QKtPAG97b7rn9fui5Z0sB7CI4uWzSJPhNfax6Aq8Df1Sh7fksobFmOPE80ATA+pz8S5Zcb8IGRAbFPXnSsSQudJAt6gtGDxxWQf6m2IxlpM0pH/7Y/InW1/K8+KFeXPKKv6a1v8A3vuVbmT8WyQ750q9cOT9ZwtefVBgIQQkqmLi4ZbKW5r3MYXWKd95IhPJ4/jr/WpiOYxOw07xGVXPf42YDv9BppJ73Vx2VjVSbys4a/4/SAIBpLb2g9MPvW5d12X4xGqTVsfK48m25MROoMCUxn9FPttRMvG4NunKpGiW9LbPGBPm3pP8CnnUXbZpgiB0BoyFuEhqxzca/T0mgVNDzJa0URwPP6sl/3qizqg==;5:iEy0NZ7xgzeEDB9K/yG5amkSt/nBnrQ1En6ev6XUw/JaQOTzwyw4h9LJrq6pHR7ptfcHfLbqakRItSOFPlMcCVVbOqw+8ANsZlIIIPiNg9vM9YdV5g74u2kefX0vbPAIJHr5pVz7nVsjcoANXDO5+T4Efcyo+WV4ev1JJrS8OXo=;7:qGop0JBklkaucCtU1sJyCsYikLVeXIYD1RvF2CBYApQ+2NG0u0RXlZPSuS1fCXb2ZSfiAGdXr1L5u1vaOQG/hZsFWZ0ExmZdXXFYd3WwBYBLoEN01jlfIK1gzqmASnKeK2xdySh8XCDrOieTSaSM6g==
x-ms-office365-filtering-correlation-id: c02465fb-4541-4d34-dd75-08d63b27ffc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5225;
x-ms-traffictypediagnostic: DB7PR04MB5225:
x-microsoft-antispam-prvs: <DB7PR04MB52256637BA3007F47BE2DC30E6F00@DB7PR04MB5225.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5225;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5225;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(476003)(14454004)(14444005)(486006)(256004)(110136005)(54906003)(86362001)(5250100002)(2616005)(97736004)(71200400001)(186003)(81156014)(81166006)(305945005)(8676002)(7736002)(4326008)(53936002)(71190400001)(6512007)(8936002)(50226002)(25786009)(2906002)(26005)(99286004)(6116002)(3846002)(6436002)(102836004)(6506007)(66066001)(105586002)(68736007)(1076002)(386003)(2900100001)(52116002)(5660300001)(446003)(2501003)(11346002)(478600001)(6486002)(316002)(36756003)(76176011)(106356001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5225;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k0tZzH9+KusGDouoRm7cO5hUN4MjdVP3Iwxq+EkmjczLrBRUSvoz8MghB4d5nOjW465YfcoonFEuIzX+f3Zvgggr6c6HbmElBgUXUYDJbhmJ+V5hDFAM9PhQnOMpASXz3O8SnUrKcXO2gXaDj2nmJeCLwCGVj12h0sJ5HTlh5inLuCexyF4TQwgiGKVkS4Xhvourwyc2tbR9NBYUYZsVJlib+BQZPQEiAWXlHCJ0oGLBv+rjK6on1dcCoheqoy2JHs5jhkcpRI8BNthYNst0uPivsIDylIPkNeIrDlgOZ79MaLq1UMHfagnkSGjSJtQ025BupZ4Gje1LtL3Reor6SxzQjf5EZRLN6jq1HrcZzIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02465fb-4541-4d34-dd75-08d63b27ffc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:47:10.4794
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
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 083d3446c41d..26e2e5da8170 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -408,6 +408,7 @@
 				clocks =3D <&clks IMX6UL_CLK_CAN1_IPG>,
 					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -418,6 +419,7 @@
 				clocks =3D <&clks IMX6UL_CLK_CAN2_IPG>,
 					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

