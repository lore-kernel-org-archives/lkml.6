Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54022C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJU/SuF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2F72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeJOVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:12:58 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:30160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeJOVM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YODhhvAkUhFNRCCLNkAi5rue/pr29pROfb5BD3ojvx0=;
 b=XJU/SuF9OterUKrOyLAqqni5mOTfhtZ0tDtFtvTwnGOGn9KcMeoFOPqTrE2r9kbQcUYJivAArmLMCaHc7CMBlJa7TH7bsACXqeMPgCVlajZZ+nAnSbOY9Hq5QCE23wCzKsr7a0+E8YPGHgBgCkKKRo4YbS235ipSVxK1FgMM35w=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.176.215.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 13:27:35 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:27:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
Thread-Topic: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
Thread-Index: AQHUZIrVW85xcbkx8EaJGu2CO/Ct4g==
Date:   Mon, 15 Oct 2018 13:27:35 +0000
Message-ID: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4948;6:be///9kHyu1RN/CObEm+KxKFkGdPt/5jXmbTrHobSuY6lTOfc7KroAPO9GM7YsobXCQ3DSuhEYgXbsyZxJSk3fhm47BnkqmL1mrnMxqmN1/8Dy6B247NQqIawMUifufEbNqMvdBxvvjX8MfaIIXi5bpi62BrRZt/s17/tPUmab5QTY+qEcTFoAo3B3Vscog+VEx8B1EhyG+28sUndaKW8oyQqj75nlY1LUKKz6tWZ/I5kzHDcmPMxGNgof3EhiFFkyVP9TCSIDr1Ve3DFPPUFIAL/HpP6qeKgQj+K3BRvhlDWQ/OUZzHsE1Mo0NIQ8V/tqt8/aswTESUGLWDTVDb+RO/cMGQ5+Oqy3UAoBWuAZQeqoW/8LqvJTKM9XXdo4NGNdNBf3X76m6w9CwS7DKQMDImC/pc00iIBwsJw2cm97A4hjkRgAYvnNPWXCeJ17gRIOku4AeMuStMWkSZKPw45g==;5:XXs1dmGyKtU4MH9a8dxodPL/9d+UQLHISC3sPSxUlFOTvDuGHa4mDYfeYogim3U3gjS8Qlw/Yn3S1qx2Cn8fdXZxgbKIeY1MAXSlTZnPbxGBdwaEaC3iikAfhvB97E04KEhRVwcLk1fO2ueiU58zBeSLo2ici1JR2AWu4sdnq6s=;7:QL7KS12nI4RPgeDTLJJEXM21JvhiZqF9XMdbJUk1DKcMAiOqzf/ffEy6ijpt2uXcHlv3w+Y1HuYQZJ1bYAEphoTuLFMdMObE4fc6b+dp6nXUTleTumH2w+K1dXeT6+ktJFbdMjXsm7BGX4E1B0WvbK+mIxTPgH2V5q36t68xfpdxWM7NYbt7VG1JNzoA9/NmWM7Eg/t5szWbeJYVKerd32rV8Lx2NCebZb86egKzkXB3el0KlxgzW0aAbqlR4GR9
x-ms-office365-filtering-correlation-id: 61ed229e-b002-49a6-f4cd-08d632a1f7d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB4948D8DF96B37C26F1A8556AEEFD0@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4948;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4948;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(97736004)(105586002)(256004)(2906002)(106356001)(53936002)(102836004)(52116002)(6116002)(3846002)(36756003)(14444005)(5250100002)(6506007)(386003)(66066001)(81156014)(81166006)(305945005)(486006)(8676002)(71200400001)(110136005)(54906003)(99286004)(966005)(44832011)(71190400001)(7736002)(478600001)(39060400002)(68736007)(4326008)(6436002)(25786009)(6486002)(5660300001)(316002)(6636002)(7416002)(2616005)(186003)(26005)(8936002)(86362001)(14454004)(50226002)(6512007)(2900100001)(476003)(6306002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7kV9a74GWzyooQAdupmbGEBPJ7vNBhfFG+Q26jErGQBAhqOwsT/fHc1nbX0FnzBkEGu5BRivvvafG2Z3YGQX+qizTcLgvIHHoeZGBbhi1VGnWsW/OdDYSfG/ENXowMe/OG6H82bIkpEoCtCJ/M+KLxTo8uJ/wgp97vNa9GH/jA5ELCnd2y2MSIWi3wMXuW+6HSn+1UPtshPPLJZDshVZOij9peszInuDoWTmS94hrrJLNaJGZXBSGOV7bqWvFDzviRPldXzfC6PtQPq0pEd9LSFCLFtOawpfVh1fstF9wyZfIycpUvnXJD7FbxASXzibD7N2D0xgBfmLWXlL06XYS/cJog1Gg7lK+HERm3aq9QI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ed229e-b002-49a6-f4cd-08d632a1f7d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:27:35.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCP block is present on 6sll and 6ull but not enabled. The hardware is
mostly compatible with 6sl, the only important difference is that explicit
clock enabling is required.

There were several issues with the functionality of this driver (it didn't
even probe properly) but they are fixed in cryptodev/master by this series:
    https://lore.kernel.org/patchwork/cover/994874/

---
Changes since v1:
 * Add devicetree maintainers for dt-bindings
 * Add a patch enabling in imx_v6_v7_defconfig. Since tcrypt now passes thi=
s
shouldn't cause any issues
 * Link to v1: https://lore.kernel.org/patchwork/cover/994893/

Leonard Crestez (4):
  dt-bindings: crypto: Mention clocks for mxs-dcp
  crypto: mxs-dcp - Add support for dcp clk
  ARM: dts: imx6ull: Add dcp node
  ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP

 .../devicetree/bindings/crypto/fsl-dcp.txt     |  2 ++
 arch/arm/boot/dts/imx6ull.dtsi                 | 10 ++++++++++
 arch/arm/configs/imx_v6_v7_defconfig           |  1 +
 drivers/crypto/mxs-dcp.c                       | 18 ++++++++++++++++++
 4 files changed, 31 insertions(+)

--=20
2.17.1

