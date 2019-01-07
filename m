Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE69D2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilqK+vE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAGTbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:31:32 -0500
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:25466
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfAGTbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccp2neXIsX39kaSN6iaiYXT5mBxcN3DltKwY9odXdxA=;
 b=ilqK+vE7iSFz2gfa0Rp9DTTq8Mh56D8n7vkv1noJuXQ1xOWqsznvnZG2dTNLXlG/AxqHrkqf5DahxCI7u9Nnx1MDvDrdzgsvPnLLHys3SkvOps1iJfIJp5qpBE1/+jUlaZOfmUuRWhZSspcIc95xlf5iKrr8R8meppGsVMbzoc4=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 19:31:25 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 19:31:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Michal Marek <michal.lkml@markovi.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Topic: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Index: AQHUpr+U4MlukrPd1USdyY3EAbizyw==
Date:   Mon, 7 Jan 2019 19:31:25 +0000
Message-ID: <cover.1546888138.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:209:1::43) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5311;6:VzjAfR0ycbWwq2XFE+bHzUjrNZeFDbDRIOC9fwvpSsCQatq8lSQO+h3hePqwW6lUgKULpuYQ637wCGzf7SHzM7favyYHkApavPDGmbkVMxF1n1O6SdX22yyB76cMO5SxhxbjZvgYOFLkt++OOfEhAkCOAP9hoP6TqSjVDSwDl5yu4c/YL6ebYJx4PCzrcrhBhtF+d6yp409+yahCj/VmrkFpobte99/KYBYINu4zMJYA4Ui1vOu4wu+u3uEfBIfwhStFzBzZbh57eCiSUNMGeu4BkGeeBo2nb+aQ3lCXDrso95fA2Uk8NOKLKGjmpOiZZPVUt+ESRaUyFtFUluoGXFlMtXIRvH9igD9l97ZWRwgNiszbDUozbUphLtVJs3hyyfHciu79shvoriy08fENsorkHgWERg8ajFh6XguycIR8Gxd9EbqPIxE7MYB/5NAtrtajRvAQOLKf3eyFG1K0Tw==;5:JhghjwxO1jWOP6zmN4Hd4M75zlo5e8MxWedjBkKmOtgwjvdGgZtYRl7UQ0iCWDp+xTdQp82RlcN2UlhDBfVO51SJsbK+MhWZo6jm7soOIvlF/HndbyTkChWLXuX99ftbTcASEZUDR1seMud4/NR96ibLOFSgG2g6I5FRyo/kEyCyXMDA6BQsDZNTGqZraIcmTOa213pK1rbz0fUWq/qO2A==;7:jCMrVZ8dYJy/U+imL/c6ZIOmdTVr6+sLTAiyUFLyKvmLf1gWr5zValAdHDxbiMLhUxtIoK+7ilmKup9G8J3Xd6JWQ7eCI4WF7UHSHpegYB/m3lNOko0cKZvedcqYj3VkipotoZHWSOYXKFaXTLz1+A==
x-ms-office365-filtering-correlation-id: d71949d9-0336-4547-9485-08d674d6b663
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5311;
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB531172B04F5FFA6864784AFCEE890@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5311;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5311;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(5660300001)(102836004)(256004)(7416002)(6436002)(97736004)(478600001)(966005)(25786009)(476003)(2616005)(14454004)(6116002)(3846002)(8936002)(486006)(66066001)(4326008)(44832011)(305945005)(6486002)(2906002)(7736002)(81166006)(81156014)(99286004)(106356001)(50226002)(186003)(53936002)(110136005)(316002)(54906003)(8676002)(105586002)(6506007)(386003)(86362001)(52116002)(71200400001)(71190400001)(6512007)(68736007)(26005)(36756003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5311;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OcXRMocUjB9zhwtsgJ09W4NGByo1Ylgltdhbq3HR5T+MHUEwC+CNmMey9k8Rq2JZZORD/SvwfGSzceZt7i21AOFelsmrfMzOSyiX4z8DnkCkb239vhiJrbEOpUimACE6HknOQKg2O/K7DXjHMs7Y+joouoURdHIQD2zR21OOjkNlWV0V3YdEbroR21z0+FCvRMXR8eO7PxW6IS4rwVU91MWthaEtx/QW1uNnsUsAyc7sCFX/cBORyZ3YeDxJKNd9UhjlKIFiEp5Pr5rWKFdEkPNQRe4pHrHl+DkGZnKFiILYdCO6yoeCX1f48r8CLiIf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71949d9-0336-4547-9485-08d674d6b663
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 19:31:24.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dts makefiles go through a lot of pointless churn when boards are
added. Many SOCs (such as imx) have very simple naming conventions for
all boards using a certain chip and board listings can be easily
collapsed using wildcards.

Add a "wilddt" function and use it for imx6/7/8 and layerscape. This can
be applied to many other soc families later.

Previously sent as RFC: https://lore.kernel.org/patchwork/patch/1022737/

Changes since RFC:
 * Split into 3-part series
 * Move the wilddt to Kbuild.include so that it's available everywhere
 * Use $(srctree)/$(src) instead of $(dtstree)
 * Also use wilddt in arm64/boot/dts/freescale

Series is against next-20190107, conflicts are to be expected as board
list keeps changing.

Leonard Crestez (3):
  kbuild: Add wilddt function
  ARM: dts: imx: Use wilddt function
  arm64: dts: freescale: Use wilddt function

 arch/arm/boot/dts/Makefile             | 201 ++-----------------------
 arch/arm64/boot/dts/freescale/Makefile |  25 +--
 scripts/Kbuild.include                 |   6 +
 3 files changed, 21 insertions(+), 211 deletions(-)

--=20
2.17.1

