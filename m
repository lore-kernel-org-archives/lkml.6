Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78270C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA4A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dHYHAsU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfAaIDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:43 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:27568
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731484AbfAaIDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpuQ0LSCLl+Zknilxue8oeZxIOd9yYpSy4Mj6G1za8M=;
 b=dHYHAsU1leSyReokHex1tcVoLw8Pzl9EYta4TeuOymnhiSew1rlwiDDZNejPvqkxMbSi5RxxscSIidPLeETNn4BiuarIIalKuH1uHpEmCqTzYZ63tMTiDnTcKxtTiGw/MX+PQurU0Cby93YRjSsTZydRVXYhHEpoO4jVaAbcXaA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5298.eurprd04.prod.outlook.com (20.177.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 08:03:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:03:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number instead
 of group number
Thread-Topic: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Thread-Index: AQHUuTt5Spk4kSNY5kK4EHnWuE5BYA==
Date:   Thu, 31 Jan 2019 08:03:39 +0000
Message-ID: <1548921464-28917-2-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5298;6:EHbWy0qkFBiqXH7t/puFTYrFiLZ9SqxjQEmMyhdwHQsbIWKpkbFQ6l33KIfGkoX8szVG8qAr/2BJ9Mmy+LIZHSlZqGXHORihwGLs336gNIkQ7g6bgtc3C03mokWNEtoBUxx1no98XL/ccVwy0vqIiRclxapJpaYG2xxOist9IYGKotTEx1OFVpWxeHy75jeKacnEtuQFiS4FYqWA/Fh771QrpmDTtm2HVWzWapn9p9oeRfAWF493RJRiRTLH7lxFm7wzRD2kb1hIesB3kmciF3uFgjZQ8XXpyuus/FJ55WU7b+31JKIgmO0BGFbwpEaQiErJVG5ydY65A4z6AdUbbpCQ/Yda7Y4pH/9Am9BPtBwTKgU5hRrg3iYFMAFrTYWQX2Tegsi25KWgAry0lQbP68i5Gm2bpT0XAYo1JnsDJTfdv0Y3H0RfL23BPUmnAdtXiZ82ydP0Dfe+L5qUyvS+0Q==;5:ngIniz/skXjVbMjTWW6eKontw7hM3dyp+kwyNXnzL8lyx2nnMqSQpc9YqH1h5KIXTSzYGTkfBROlunu3CFD6h7lQlfnfqXcS5WBt78C0AhnhxWYdBFRcm36zxJa/BjEswnO9DRW7Cq+7tKtsXeCKpoMpq5wuuaK+uzJHD0RPGA/4Oz3Piey+LczPqILJsLvpFwTC3SbS/xzQk90oNyWV8Q==;7:WRgQQeayfTIpUC6jotDEFUBw+o9QrneoEa1gXpitulQhFx2sj17ptvIAMd9vR+TMbrXNGrHYA+4GW0feBSZVjnb1PSICAn30xpA2fPpauyS/5Gml+9w9Fbk2N2OOujf8+OhKmdutwqnYrx0w6qdlgw==
x-ms-office365-filtering-correlation-id: 9b0747b2-b95b-45f4-904a-08d687529bc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5298;
x-ms-traffictypediagnostic: AM0PR04MB5298:
x-microsoft-antispam-prvs: <AM0PR04MB52988E45A83418D3947C1DD280910@AM0PR04MB5298.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(54534003)(97736004)(256004)(102836004)(5640700003)(316002)(6486002)(386003)(6506007)(71200400001)(71190400001)(2351001)(36756003)(2501003)(4326008)(54906003)(2906002)(6512007)(25786009)(6436002)(99286004)(53936002)(86362001)(305945005)(52116002)(81166006)(44832011)(105586002)(8676002)(486006)(446003)(3846002)(7736002)(76176011)(6116002)(81156014)(11346002)(2616005)(8936002)(476003)(106356001)(50226002)(478600001)(6916009)(14454004)(186003)(68736007)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5298;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gJRU/TufCovAqfzplbdmBxCscdB+LRt+L40vfYrulbJ1nFePjtmic4OcZXB0g52xJuvHaXxmSqoyuutHzYiDOU7RsceluplYIaFeSAOO1BsKa+XdWcdbzsvcyzr9ct1Tprgn3wWLVr1IzvXrEP2B60R469y1eG6430XQk2NcmAjznSWTNPRtMCsGEogcjDVWHxXujCB1ePDfQU9mRJqYiRzrfXWpq5IB1/PzXdgUSishWz0il7LcfBS8SjvgALMTaogw1JeXTpIl2HyUle9IBv0re1crDF3T7PiJubEvtyfPqKK/F9qiSbNfxVngR+dbvbFGj4aIH3OP0jQ6UNjrTIO//t262bKsJiowVs4YmVZOO2PVimEuzWU0Ssem4SbmuGgspNLBL2g1+444atyTQdOzxwSgEOC+RIOOg8+9Pgg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0747b2-b95b-45f4-904a-08d687529bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:03:35.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.

As the IP integration parameters are Channel number and interrupts number,
let's use fsl,irqs-num to represents how many interrupts supported
by this irqsteer channel.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v1->v2:
  * change property name fsl,irqs-per-chan to fsl,num-irqs.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 ++=
+---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index 45790ce..6d0a41b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
@@ -16,8 +16,8 @@ Required properties:
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source. The value must be 1.
 - fsl,channel: The output channel that all input IRQs should be steered in=
to.
-- fsl,irq-groups: Number of IRQ groups managed by this controller instance=
.
-  Each group manages 64 input interrupts.
+- fsl,num-irqs: Number of input interrupts of this channel.
+  Should be multiple of 32 input interrupts and up to 512 interrupts.
=20
 Example:
=20
@@ -28,7 +28,7 @@ Example:
 		clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
 		clock-names =3D "ipg";
 		fsl,channel =3D <0>;
-		fsl,irq-groups =3D <1>;
+		fsl,num-irqs =3D <64>;
 		interrupt-controller;
 		#interrupt-cells =3D <1>;
 	};
--=20
2.7.4

