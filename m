Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E203C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF512085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ivffY1Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF512085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbeKHBEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:04:25 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:2145
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbeKHBEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks6h10RvqtuwjI//Q9W8wcarBPHYsMTJItbpbvIrfmI=;
 b=ivffY1TbyCE+VsIRHTJ++8KaRGMAxk+XXgqaOI3cXErqIhOCmHr2HsJffa7axHQ/rGB2J3qvEqHNpD6HW1VRFUWmxmIl8Bw3BaiVdnTLcDhl14mQ+dJ3ForQGBne/vgfNFoQ1etpylbYiHW4bznAr/k/XVutyJyMGv59dpk1PzY=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.176.215.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 15:33:30 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:33:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller " <davem@davemloft.net>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RESEND 0/2] Port mxs-dcp to imx6ull and imx6sll
Thread-Topic: [RESEND 0/2] Port mxs-dcp to imx6ull and imx6sll
Thread-Index: AQHUdq887TFhXv3jTE23/HCdOHa0UA==
Date:   Wed, 7 Nov 2018 15:33:30 +0000
Message-ID: <cover.1541604742.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0701CA0008.eurprd07.prod.outlook.com
 (2603:10a6:203:51::18) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4962;6:7ZM3BOtd4AHLS9G3IA0PXkWM6I8llXAADH3yvibylV9d0GHrHKxPOLY1m6JoPil7OZyHJpfc6y1cfMpGhCsy4hxm/hCeDFG8RwSR9i+kuvoD6LDYCJJWBJ8Azge2aHDWcPCYanCJGfv7Y7Hv3rV5rv4JzjvPJk+vWImK6wXW2EpER52gRrYBTE0O3iyt6YvZqVoHqYOgy8t2lEN4mDVfVP/sjQ5ricPSLHMOKv0urH1UK+ATcRdmTaEwYyX0j6qmtU3uPpyQt/e0gZZBrb+FE8J2dNbYLA1KpB170GeCp7c19B1AsxrC6kILXp3i2tYxqFEKU9YbvoIORWA4QaCF1diT799YzfqleEj3cUYTYR8ntbbZp5Q3nVYm3pHFjpt4uUs00qzesvV9Yp8bRYbGWRftZUsB6ZLkVqiimIwMwFSedeeFeLTC42XETJz0qHA459SgQE7EUzWSWh9GzKEw+Q==;5:K/4Lq/linylvcECq/n2x84YNSqV1r3/BOwVdMWq9Zw64xgetMeqEQXoxEvAuI1sTvF0Po/sbZ6QiNaoRPm5ZWyYHAbauEQ1WkpVvjzdRDeJxEbu9Xd2mSNOzkp6+qYsalgV59hl8x9mU3srTK+XjM/Y2bE2l4sA0fSypoYJYCGA=;7:iCAAs/C892sYQU5MTFand982yaK8ghYJcdnTTR0klRGmKST1q9EnyCG6rBrL0y6dO0rotNgwOHvaUTOerOFblZ2WD3SiSsY0Y/676kq/5lpFU14ZM+KjxZ02xXiuoomiLhUighL85CGlDKAs9pURpg==
x-ms-office365-filtering-correlation-id: b5d93003-d6d8-4ef6-3d61-08d644c65ea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB49623A14AE8A2D111DDC1318EEC40@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4962;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4962;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(2616005)(54906003)(186003)(25786009)(102836004)(2900100001)(5660300001)(71190400001)(316002)(2906002)(36756003)(97736004)(71200400001)(81156014)(8676002)(6506007)(39060400002)(66066001)(68736007)(386003)(81166006)(110136005)(6486002)(6306002)(4326008)(6512007)(7736002)(99286004)(26005)(105586002)(106356001)(256004)(8936002)(53936002)(50226002)(86362001)(6436002)(14444005)(3846002)(305945005)(52116002)(14454004)(6116002)(478600001)(486006)(966005)(44832011)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l84XXew8zBnvkwxw7Tgq7Yzc4uDDOg028VLWvd8gImr/LKbSvyqK8GkbbDUosHLjxW2GjY3JuaANMVGP+dwt1KV4zTwWPq2LKa5UuW513GA2m/Vxd2wqrO2fN2+1cuYVwWfGrxPkdZj59yoTp6PuaK9w+qRRBA4yeg7LIXLohetwGXnAsvVSNVjA78TenJSG3Or8ArmAV5t9ARlCQ1OY9FUlitQRg+KO0Bx25b2ZYpzqEomaQigyDpFztXv8XcQu5d9BGj4EOvQZfmI/b4dTe3WhNk/OM86zNQnRB8elV76l4m/w+Xq8EwcH96jhzBJTOPAeaANntinIS/ipGjVwVifUydDNgTQcP6ghf/shsQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d93003-d6d8-4ef6-3d61-08d644c65ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:33:30.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCP block is present on 6sll and 6ull but not enabled. The hardware is
mostly compatible with 6sl, the only important difference is that explicit
clock enabling is required.

All patches already have review tags from a few weeks ago. No changes
relative to v4: https://lore.kernel.org/patchwork/cover/1001134/

Patches 3/4 were already accepted by Shawn Guo for the imx tree, this
resend is just for the crypto parts now that the merge window is over.

Leonard Crestez (2):
  dt-bindings: crypto: Mention clocks for mxs-dcp
  crypto: mxs-dcp - Add support for dcp clk

 .../devicetree/bindings/crypto/fsl-dcp.txt    |  2 ++
 drivers/crypto/mxs-dcp.c                      | 28 +++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

--=20
2.17.1

