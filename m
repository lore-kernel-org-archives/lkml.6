Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C584C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2625220666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dFLMTVgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2625220666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeJCCDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:03:18 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:51904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727733AbeJCCDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcwUTNMoaGfHgDEWCp4IFCimYYiWDcpvCB29pVxGXr8=;
 b=dFLMTVgrRc3uaIk1IVs/ghvZyNjUl8H6eWE5Xg9ZFYyKT+g1i1tSYXZbutMFKwAyv8giNvOAuXxdQiigvgTMS6zJCNrnbRVxMFLESOFSM4c5lg0F211Oyh1vznkoAYhZYnAmSw/Jp0AN/NEFaEMrdc75nKph0/rYAIumU2NUEe8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4593.eurprd04.prod.outlook.com (52.135.149.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 19:18:22 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:18:22 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Topic: [PATCH 1/3] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Index: AQHUWoSvdmccGvCLokmsTU1KoW/4Cg==
Date:   Tue, 2 Oct 2018 19:18:21 +0000
Message-ID: <46df329cbd78c7238531fa7949419f4cff7ed220.1538507155.git.leonard.crestez@nxp.com>
References: <cover.1538507155.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538507155.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:203:91::19) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4593;6:0V8b8qSVOabbb05IpWUKFv8+WNWMCymO908sM4PBnkEcU1vSx2VzspP4I+cFrYryIZAfr589Tjxl+se8dsd2dRkzEwsrEqwwAinUazZnVCpIWSk1es2lj7ukVB8ZFQ7WdLneXvNEL64xx99f52/Frky7ZOv6BeX18wzTwUribu9ODD7FnhMiEeijtTzOeIxMF0dtcNZe1JvNBDINxffqfGrzt2s/c9d6iAQtlFjV+BAmVOc1ewm6/Ame9/9a6QrriWWVwK/2Ufvi5lL1tYcRCIXISuPCK+Bg36ae+zJTM25e1loUm3avkPrN1Wq8DK1mp1c5DwTQfZxjGQjBg5S62Z4TzV1EvcdgU2RKKGHqV9Pc3wm6Riorz+L3kl02lFGwSynvlXV1IOtmeYpvivNqAG5uuYjVL0QceiT0F88s9jqB+hE1FKcaGTx08b/ACuV3qxWqqj9eFGrhemAorbM2Mw==;5:B1sHDYkPmy4mUXT5lFnQ0tlsWBvoHu7QkcTPqxLAe5CXA7BDgFoHvCNJG1H2XxL/6zrjgpwJth64CCRQOLzO0WaF3epyOxavXHysuPiv0rDZSWKA+wtUfPML/gXOiMfWA9nhNw157Tt+uI973O8dxgkJdeS50mCrMLvXiQkfUso=;7:hr0xRypbMgixgG3tUSKD4PEupK4bjc1niin/E0vl7oSRPUKYqRnOpxm1t21Oys8iJ+ze+7OYo66zXLLYLaqrvlQEn4VZdvaK4/M/vI9dDjXxtuJz0dc+TOFSC9E88M+frKVQL6F//qV2hMLHbFftyTrnlKNYFmL642iowT+ClSCQNjqKPoGb+ZVtapubMYnkfILi4+OEpm9trOh9uQCDOgHxalJRXz+HwTSEF4GSjI/t5ZGyYo8xEW5ju63vW5fv
x-ms-office365-filtering-correlation-id: ea414695-7ed0-4fa8-a856-08d6289bd15b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4593;
x-ms-traffictypediagnostic: AM0PR04MB4593:
x-microsoft-antispam-prvs: <AM0PR04MB4593880E5217538B4C908195EEE80@AM0PR04MB4593.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4593;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4593;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(54906003)(8676002)(81166006)(478600001)(5660300001)(6436002)(3846002)(81156014)(486006)(110136005)(97736004)(44832011)(53936002)(5250100002)(6512007)(6116002)(2906002)(8936002)(68736007)(39060400002)(186003)(7736002)(305945005)(36756003)(50226002)(26005)(76176011)(71200400001)(386003)(6506007)(14454004)(316002)(71190400001)(2900100001)(118296001)(11346002)(106356001)(2616005)(66066001)(476003)(575784001)(6346003)(446003)(102836004)(99286004)(105586002)(86362001)(4326008)(256004)(25786009)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4593;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-message-info: 90QpXttxp0ZKXC1w2M1tk1i6RQbbyT2fsYAKfdmLb+76mjBoQnbYBG4bZXnCz13dAa+GRbqOPn5esAHC/3ay80MkGk+Elo3+w9aqF7FuSRTCSr6mX5wCJEomMzcuM3ed7E08EikDIUBA6fcVpalOnfcbQ4wG16QBACkTw8sBtN0ESzxCXksEbmZIcy3ERJPgXkgedtJlTXj4hIS1Vamcp+48ufF76bI1vq4B7k7h0+5g+b4qa8aMQuamdTI+WubVSOx+pkeKtXGtdpueuwcY9ZY6W7mE3hvVaxykjd3bLXSPZ0F9qlbwMxEWRXkACruCpwmZfvSJAG/mSX8lm1cUx4qPIPXKtKPiW9tHvajmT9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea414695-7ed0-4fa8-a856-08d6289bd15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:18:22.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit clock enabling is required on 6sll and 6ull so mention that
standard clock bindings are used.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-dcp.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt b/Documen=
tation/devicetree/bindings/crypto/fsl-dcp.txt
index 76a0b4e80e83..4e4d387e38a5 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
@@ -4,10 +4,12 @@ Required properties:
 - compatible : Should be "fsl,<soc>-dcp"
 - reg : Should contain MXS DCP registers location and length
 - interrupts : Should contain MXS DCP interrupt numbers, VMI IRQ and DCP I=
RQ
                must be supplied, optionally Secure IRQ can be present, but
 	       is currently not implemented and not used.
+- clocks : Clock reference (only required on some SOCs: 6ull and 6sll).
+- clock-names : Must be "dcp".
=20
 Example:
=20
 dcp@80028000 {
 	compatible =3D "fsl,imx28-dcp", "fsl,imx23-dcp";
--=20
2.17.1

