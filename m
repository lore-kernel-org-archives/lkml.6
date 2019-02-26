Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9035C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E66B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpTujP7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfBZIk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:40:27 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:44614
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfBZIk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J56u5zKa3o7W4BcRbT/zKdw5Yg0Tc2boP015dYkJvJ8=;
 b=fpTujP7HwMPuOWbai0Kz3Tb/I7xzEQfPvH8OVGqpQc/7+I/dU5ulfrD42pfpfgVc4rrCdlWDhW6UXjU3MgXh6D1MLzzpkUxAvnZMwMz/Xfuy8duYZMQfJPM6sxWv/ydDZLM8o/T1yWAYpA/Qfkkisls0aFygNPMzDSPTbJUtW/c=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB3118.eurprd04.prod.outlook.com (10.170.229.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:40:22 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::3d6a:1448:117f:5b06]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::3d6a:1448:117f:5b06%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:40:22 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2] ls1021aqds: enable esdhc controller
Thread-Topic: [PATCH v2] ls1021aqds: enable esdhc controller
Thread-Index: AQHUza7pjKGN9TrYZE2CwoZXpABaxg==
Date:   Tue, 26 Feb 2019 08:40:22 +0000
Message-ID: <20190226084121.41499-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f41f46ff-052d-410a-5d7d-08d69bc60b4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3118;
x-ms-traffictypediagnostic: VI1PR04MB3118:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR04MB3118;23:tx3d5a5ueef2lGfXIpIJSwdpJl0kj59kPeqmVz3?=
 =?iso-8859-1?Q?P3YyrJkhKLFozQrwgAATZ7t0/evplJCt5OcC9aRT1IkMmqJ8HoJoi++6ZV?=
 =?iso-8859-1?Q?dbZn1sVatovDSSHGp5hnf18g2jZH5ot2Oh0Lnufrggjggnl5wBlzRa8fOs?=
 =?iso-8859-1?Q?f1Vbxykzw5U6K+xhsAfmoAthKJZwqtaXtI9qKX3bLKd5/7VCtgOVMIj23P?=
 =?iso-8859-1?Q?FlwtVsYgW98h29v1WGzu5JakdL4qeVwxl23rOEUqEo+vYe3qYWb2CH6K/a?=
 =?iso-8859-1?Q?WXQSbsujClPy/L7Kq+dthxOIzyY4O+4D484rfB8EGqp/fF882B4KIq9eW4?=
 =?iso-8859-1?Q?yYEFvsNoecd9wmTEBDwuy9N9L6DZ+7pxepF/vCpysTsSkhKsPT8ycb9KMf?=
 =?iso-8859-1?Q?ebpARu6iDKKZvU1QxcdSAYryGSBs9XCol4nyTZ4LeOs+y/fBuJGn9q0vlP?=
 =?iso-8859-1?Q?YY8xIi1xOnCf0DXo4yDjeNcpjQjVy3h0HYSOkn4S4XOcT2K3xJGbVTOFU+?=
 =?iso-8859-1?Q?JC8d1AbtzfYckpihaVLS+0IwoFi2llp6qnCXYIjRm1kVkj27Uq27WIlVMs?=
 =?iso-8859-1?Q?ih6Pqmjqgw/dstVk83M7o7zHSc8wxEvuTosbrER0FWI1GuKSAFINFcA+h9?=
 =?iso-8859-1?Q?eOyvljQB6mrlFZODI8nDJkUmprdAnX8wKMzVvtOBMvKvYuYe8oWv5Lij81?=
 =?iso-8859-1?Q?F8sOUAp0/3MBi+zEfzKwJjJZkIRA2Pd0qKTkBZuQVelUggAfYs3zsMu/cL?=
 =?iso-8859-1?Q?BTqf2ysu4abkHIj953urfOFd2V02lRCS2KJazKTVkUbLVY5VjFFNF2JAeS?=
 =?iso-8859-1?Q?//7V5sxl2ugk0LMaRodQghiuf1QTYVo9gEeIhe5LxHAJQkSdFoyIrdcJ2u?=
 =?iso-8859-1?Q?xXkdZzmjPN1Hl3bLxRdd/wpICIR8ouYib9H8jZzWlfhel/MFagZhcBRwq2?=
 =?iso-8859-1?Q?hv47akWUa4ymveR/8iqfywfmEbLL0X5mmgQGnjbbxR4+maJzlCt/ZJvotn?=
 =?iso-8859-1?Q?Wooy81vVw60jQJv4rkBdKB3psRb4XVt0EL8EaTe5/faMtmvp4pxu8yXH60?=
 =?iso-8859-1?Q?gf9uJNC02vvtV7PJbXCi8DVCxOx/XIXTZq+2u38ppiOku6lXe6HdtxVb83?=
 =?iso-8859-1?Q?r4OE/YoANe4By/RXLWqCygzrHLaq8IYivyO42USEz2vZmWxL9F1vUCbAld?=
 =?iso-8859-1?Q?IhHxtVTFQSW9cSJYpa9WJtgx82eXhw2CKazVUKwFX7lPtERS6uXwRE=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB3118EE783D4341D790F2B266E97B0@VI1PR04MB3118.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(66066001)(6512007)(186003)(53936002)(305945005)(7736002)(44832011)(478600001)(476003)(26005)(105586002)(486006)(2616005)(14454004)(106356001)(386003)(5660300002)(8676002)(86362001)(6506007)(1076003)(102836004)(54906003)(71200400001)(81166006)(4744005)(110136005)(81156014)(71190400001)(316002)(36756003)(25786009)(99286004)(97736004)(6116002)(2906002)(8936002)(50226002)(256004)(6486002)(4326008)(68736007)(6436002)(52116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3118;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FvDOhrqM3+RuBuQQo8hxEU4q3nJBhth7GOthAU2OTMQmkHM3aKNTOUPy0gfO/Ydc0JnV3PtcbaAhSD1AbyKjXOh9ggKB9EuEhNF5QAi6Mn3c4AXELl1voOm9fc3hQzwh879bOkHEKFv+C9e9zRUKskUYX+CdhJ5gy1BnsrCRXvS4sW5P+Xy36Ut4gvdZwxQAMKKr6EhZeXEBJ44LFfdXZW5aL4phIHEFGXxm2vDyoSPJTc6F9gnne/unOzeqvjLA6ift+kG+qpzGAqK4y6nSsxKGgfTI+0MPeYsBoakzHTZV5xE2vyWJiVp26h45kzmEKQyowNZmyn9Nguiqgy1d4vbQsoifW7dtLtC2p7/cH5aDH5q6lrwphldijySu2+FEb6tcmwnOx/hc2h94SllklSbat9NTvm2nSqIPTzEImxI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41f46ff-052d-410a-5d7d-08d69bc60b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:40:16.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch is to enable esdhc controller in ls1021aqds

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Add patch code after &enet2 to keep them sort alphabetically.

 arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-=
qds.dts
index dac61e7..ae26f8b 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -160,6 +160,10 @@
 	status =3D "okay";
 };
=20
+&esdhc {
+	status =3D "okay";
+};
+
 &i2c0 {
 	status =3D "okay";
=20
--=20
1.7.1

