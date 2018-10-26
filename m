Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BA620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G9a760GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BA620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJZSXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:23:24 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:57647
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJZSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL6DjHK/WlRaA9Bz8LgU9f/H4/E1fgSwCbeeqViASCA=;
 b=G9a760GGSJO7xhhBfhx6DWPbFnQFXaoyBh0N1ATAi7FJtGtq3JsLg7v2pLz040zXhVu0jEaw1zoaLaqqPNT1W7FyKIs/egnN3CfR/Uvq6DSMf5+Ywctcz0ZvcclaBqCcu9tDO10FaVILmFM/GU2Y/GTxv4GYqgwX2EOZFJPCInI=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5225.eurprd04.prod.outlook.com (20.176.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 09:46:58 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:46:58 +0000
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
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 0/4] ARM: dts: imx: Add flexcan stop mode wakeup
Thread-Topic: [PATCH V2 0/4] ARM: dts: imx: Add flexcan stop mode wakeup
Thread-Index: AQHUbRDW8hPuV0458kSIYFTVAStrmw==
Date:   Fri, 26 Oct 2018 09:46:58 +0000
Message-ID: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5225;6:Hp2S/B6CYfGb9S9dDZ+SFXSh0ntg84J4/oVOUsIoOKsAIOiucic6vf+01PhxmHYDwtdh3mxeKs5wH45xp4QNWpkqbPOX8CORwhyiC2QYz5V2zw4SH2b00S48XQF9CUWYeXanz0BwAKm9m2tDIDAQ0Gli9NOZ7Zkyo/A6oQim4MyidGRbvtwDVj0YBX5Rf3OKBr/69aZYCnYdFIedMpMMLST4NLlp00eSl19bnaf64O/FUM76kfzBybMHTYPUHJKg4SBrA+j+K7OQQfZDO61ELd3vKFN49WVjVvpGOA/tFHSYKu3f9epDa4GxvZqa8Qz4zjoe8gAjAF+o4QD+e38FJAzhWun6Z+VhRdDY3YqErS74dP+OXp/Ze8kG2hZoZEohjcKi47EgfQm1v9D//DtfijxnofCSJNNd4YnCpnK+sjfOVVLFRPtYRAS8+55Onr6VI/JIZuWoSqMxxy+l3dss6A==;5:gt7t1Lte+fpW9RB5JdgCVf4PJC4mbcTKi5TY4J9OPF5s5FA94CTfGnFrBug4oQEO+l6kh6C9xafbBi5EbTdMB39ojuA952mgRYnvO/3DnskgxAeAkPwzLoEriTcxzgoFiwYb9ccacGOjHjXBLaQialXrnVNfRmuH2YTovvBuCWs=;7:b4hn9XbSXIKNFy4WT7RBR72PWmEC7tbYl+bPNZVh1+7OtI5GkJjzlWSlnWKIxs6GGoVEASOZ2gKjJxlE3B6ZK9jKAxcgq+Ju27RmNR2cP2Y/akFvWL5AYlZNVIT2a5/Dc3oZi4pzZjsL69BCMvcAaw==
x-ms-office365-filtering-correlation-id: bfc32b15-0784-4950-acdb-08d63b27f857
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5225;
x-ms-traffictypediagnostic: DB7PR04MB5225:
x-microsoft-antispam-prvs: <DB7PR04MB52254A27E91AAC4020932E9BE6F00@DB7PR04MB5225.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5225;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5225;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(54534003)(189003)(199004)(476003)(14454004)(14444005)(486006)(256004)(110136005)(54906003)(86362001)(5250100002)(2616005)(97736004)(71200400001)(186003)(81156014)(81166006)(305945005)(8676002)(7736002)(4326008)(53936002)(71190400001)(6512007)(8936002)(50226002)(25786009)(2906002)(26005)(99286004)(6116002)(3846002)(6436002)(102836004)(6506007)(66066001)(105586002)(68736007)(1076002)(386003)(2900100001)(52116002)(5660300001)(2501003)(478600001)(6486002)(316002)(36756003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5225;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: viiYe/ywzMTbizWZOJ8JkynSMCZwPdElPihyaPjwCMHnEm1Q2cwj5umey4iyZoL1mC8krr4UFPQBKJr63x+hNOqDKVaFROII+7GGHNmCl2qeIUVxV4jZ7QhXm3FWCRJwO9aZ7u2wvVblK73L8m4lgvDjyYhhMWTF3ebTEiY2GhdK09v3MHJvjayO2K978hZMiiFW7uByJng+E5AYV4Y3m7y0jmlZzpMhu6pOWoZIfZYk+2Z6f3gDG4f2n8ZQoV0QpeqQTUOPThU+gJJC3WP51cUJJ6bIuuZQ4j00tjJ+KR+UJ91HwnkzdgVpqabOTiVy4cU8og01zhhvSHCauGVskgreNQmZOQKQ+jdq6PdmZnA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc32b15-0784-4950-acdb-08d63b27f857
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:46:58.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to add flexcan stop mode wakeup support on IMX6/7
platforms.

ChangeLog:
V1->V2:
	*update stop mode property(stop-mode -> fsl,stop-mode).

Dong Aisheng (4):
  ARM: dts: imx6sx: Add flexcan stop mode wakeup support
  ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
  ARM: dts: imx6ul: Add flexcan stop mode wakeup support
  ARM: dts: imx7s: Add flexcan stop mode wakeup support

 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 4 files changed, 8 insertions(+)

--=20
2.17.1

