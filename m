Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7213CECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299DE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrbwhS1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299DE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJZSXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:23:42 -0400
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:42144
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbeJZSXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kHDK7Nid2PKrrsst2zvNgQOE34Uc2fWL1LFw4pEdGU=;
 b=hrbwhS1dlOtjRdCCD6gKppML3jPDQZ9ExJDWuZ4tQYRIDeP042Vhr3LcmpS9FUtLheiv5S0wYOsBuWalc5MKxlYbg/49YmbLcLdGNVb/7feD5o2JDtfnL3oLEtkMphchQSL3yF81U3iWxiSnEQelzS/5gX05wdUsLCweONa3eVw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5225.eurprd04.prod.outlook.com (20.176.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 09:47:14 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:47:14 +0000
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
Subject: [PATCH V2 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup support
Thread-Topic: [PATCH V2 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUbRDgqNJ43hbMJ06V4JfFlxftMQ==
Date:   Fri, 26 Oct 2018 09:47:14 +0000
Message-ID: <20181026094444.25305-5-qiangqing.zhang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5225;6:1dsojTTREW5MdTBmGBOMFUf0d9m+nueURU8AnXf9e2/ARMDbmIp0c8bmwCZb5s2QZEBx+ttepkFh/O7bFc/zNgJYx5xdknFbaRWFsW5GUQnhJZuF1wVb0Tj87Xos2VlS95BqEfrQGjkpVIruJ0KOwh/dm3Ham6Oy32oTDvbFRhXKlurgeqDbC9GMTCZqPclv0j8f0UznQt9+xoDOov0gWWGG4R6702qrbf28knk36aZK3zgvkrGhS87DJqwd+Tg7mVKc66TW33qYGKaft8QCx1jXsctdxXpR78EoBbVRhDL7eaUiAJ3d3Yedj9pQ5E50UKPDUwiMjK6syvenC6Mr7/QhiFRsbhgQl/b5HtL/ySkFG4165Jp6wmn3AW22DfaJdTqAXYSPTLse9qmiKDObkPucQ+Mf/HHUomNMHcUOPSwuObkg1m3E0eN8f2XhLHD3f019Cth3S71xbUjmiqXp2g==;5:IOphNMRGlFum7+i7b3Z5n2wVP1rGtM1cd/NVkxXDw7TgQMTR/btOz8fU4cgFTf5b2UJajsebDhbHNWEH2DC2twsciWyWF7D5xIs3+6feNkJvrVqLOgg0cfqCsxq5QQlITFausj2n9gTpsAPdNsnBTSvmBCbmAL05pqmaYU3r+x0=;7:1cD2y3ycQ6u5QP2rD7N7tbKRaM4Jqlp90u/M4GR9C/0sii6vmgGL8aSrOnonDR94ijVM7qgaoUmg0H8HXDoQitXrEOVJt+b/hKPco7pfYEoj6xVWQy9oWvsjY61G+O/pBwuCZ0miRbOO6LacrE88DA==
x-ms-office365-filtering-correlation-id: 21cca010-6954-48f4-c092-08d63b28023c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5225;
x-ms-traffictypediagnostic: DB7PR04MB5225:
x-microsoft-antispam-prvs: <DB7PR04MB52254288A418FF2E7EEC26E8E6F00@DB7PR04MB5225.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5225;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5225;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(476003)(14454004)(14444005)(486006)(256004)(110136005)(54906003)(86362001)(5250100002)(2616005)(97736004)(71200400001)(186003)(81156014)(81166006)(305945005)(8676002)(7736002)(4326008)(53936002)(71190400001)(6512007)(8936002)(50226002)(25786009)(2906002)(26005)(99286004)(6116002)(3846002)(6436002)(102836004)(6506007)(66066001)(105586002)(68736007)(1076002)(386003)(2900100001)(52116002)(5660300001)(446003)(2501003)(11346002)(478600001)(6486002)(316002)(36756003)(76176011)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5225;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zpwYj2WYSp/aBZMcZ7XCZhkoX0EU8TlEPiQ8W/FjauJqEmlOV6KZfS0ZoiemwXLFtb745mrJNfsGN6zdOrN/ZyYaP030t1KOMIQiYIdjTEI0duG1QZtX4SFhoqVoSB9C5urp0fzzip8ztPItQnw8jpsasNIqBVdCNj4IXTd6YTzV+bkY9jcSv53g0IAj8Duwesg6oS0ce7r8ovnM816lnjSpBKqtqLMxS6U23uFuBanVJ8bxD/dUGOgAMed6k4VM9L9aBSZVquBul9XhMXZBZPrrfuMA/SrNTJzkVKmZyXXm3im3/QYIGmzl68JtrZ3Ey1G4k4KD5yfReMGZeJqvLxb2CVTjW0WPRltuafYXYHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cca010-6954-48f4-c092-08d63b28023c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:47:14.6523
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
 arch/arm/boot/dts/imx7s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index aa8df7d93b2e..25571f31016c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -875,6 +875,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN1_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -885,6 +886,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN2_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

