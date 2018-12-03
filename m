Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EFC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B6020881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i8QbJ5Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B6020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLCFUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:20:32 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:4880
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbeLCFUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yWNH50ldW0qNy5+lOLgtGaAOEouDiA2X9QIK1NZ4qQ=;
 b=i8QbJ5HzMjwlfVuoPRa7bd44GIFNG/Xg4dDdMiYan1lj4ck7duBzutnAXyw+6m7gaPy6iceMyj4XiO0n3u2UU/EUX+0rw/LcpsfYomOWP+KU1uhKwoXI+0IzPstcanvl480exDMAostdSuluAHE/7NOgzKtmnh0YC+GYqbkK7Z0=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4138.eurprd04.prod.outlook.com (52.135.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Mon, 3 Dec 2018 05:20:27 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:20:27 +0000
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
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND V2 3/4] ARM: dts: imx6ul: Add flexcan stop mode wakeup
 support
Thread-Topic: [PATCH RESEND V2 3/4] ARM: dts: imx6ul: Add flexcan stop mode
 wakeup support
Thread-Index: AQHUisfmrHQZrN4Hbky04BidIpqP9w==
Date:   Mon, 3 Dec 2018 05:20:27 +0000
Message-ID: <20181203051753.1532-4-qiangqing.zhang@nxp.com>
References: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4138;6:cBEv7uP0A850iKZ5PK63ncFvERJbSBJ3CFmhdImtbyPHCo8lwmCBjNglyT00C5ShRd7b0RdeB+vMjC+BGl7SI8nLnDgSKGQ7hwDOP+KQHg4Y3f4M2ZzDqceeF8Tcx2OKzTzTvvBGYIRk9vLd23J9kAcl37rfCW0tzje27Mus1XcRmr6aYKz1iYFMiB/mholsO5hjWyP0/qg1YGzcNmSvPNeReFEZBJby1pH4P96NrcjPd7ZDiUI56g1dSsutAdIXP/OdJWNORe0j366dfCTPn2pvHyIZzYUVzaCyEiRzuTLTafXYSJycvA0dV8HS4iBPhGSqnMLGUVNv4BmhQwn3lVedt6EOGjbygA6/h3E32SxIqpAZ9TFJdNBdB5PRE8kA2DLzh9ZgJPmNhxENk9TEV0fz7b4ZUgsrOudDl9URbPKWVjKGYpsnIqxt8QcbQTVAJN6Mu3Q61NlJ4q2/kl5iDw==;5:w34Ru3vUun7CsuYPfBMuDkt04zAbsAVsW4hgh3qdwiS00DAlx9qYe4FYSbb2ZukP8b6PRoaL4IsjQebzzv/ksPJZEVwL/HcqQZwD+T+N3gDwfKkiTSjxlUR3RjaW4Z0ACfPsH1FDyvtrg5YULjVzgqnXR8c05LzYvWoaX9HRIow=;7:mmBBBdWimx4G3DOuY4ggWvuxjvDwYRbDojVMI3IBNTW1K+9CO/1ivpqP5KyGDH9czgQGFMT1CIlxtm//UKmL1WZA5GDRpfmyH05agjYMessrgl4iTKAVAsJ9sda2sDyvAU3KmxRrC05knsIXEEvuwg==
x-ms-office365-filtering-correlation-id: b7a02880-055e-4922-828f-08d658df0910
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4138;
x-ms-traffictypediagnostic: DB7PR04MB4138:
x-microsoft-antispam-prvs: <DB7PR04MB41383F9B7787E6D8F8875E60E6AE0@DB7PR04MB4138.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4138;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4138;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(6512007)(2906002)(81156014)(478600001)(11346002)(8676002)(6486002)(446003)(110136005)(14454004)(486006)(81166006)(476003)(2616005)(71190400001)(53936002)(25786009)(6436002)(316002)(68736007)(54906003)(4326008)(50226002)(86362001)(2501003)(186003)(8936002)(66066001)(105586002)(106356001)(7736002)(97736004)(5660300001)(305945005)(14444005)(76176011)(102836004)(52116002)(99286004)(217873002)(6506007)(386003)(3846002)(6116002)(71200400001)(256004)(26005)(36756003)(1076002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4138;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /eszCXb1QbRgp76jFsXwkpX32/6Hrs5lwusChPym5xmiIN3DumcgpFA4E6r4kVUjG0k/S2U5Kxgn+15nFpEfMpIqFYBnmdDldqOsmR6hm6To+DKJeUtqXxAWL6BDtMQttC3GjS1vhdm638mkCFOOnL3M75m/VgxR62rzpvf2Urjvid3H/kJpNYETupCeg3N+04I4QyE2T5qJ70U2EbHEvY2HpFrrx2gNPHnr0GHfnwf+nGgpLvPlDKBQRA3KWK33I+R2U/GEwVqHnVnNuW0eKXIA2td+odLEsZwGWNuoDFXbdHEL1zPofU6eik9JbeaSpS70EyCZ8B5Vzkg7MUn8S/HQXPkDQMQl3aXX00PpyCo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a02880-055e-4922-828f-08d658df0910
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:20:27.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 99c366303d73..e14f46ec4d7e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -406,6 +406,7 @@
 				clocks =3D <&clks IMX6UL_CLK_CAN1_IPG>,
 					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -416,6 +417,7 @@
 				clocks =3D <&clks IMX6UL_CLK_CAN2_IPG>,
 					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

