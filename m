Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F332064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UMR6hNaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F332064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJCCDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:03:16 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:51904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbeJCCDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0ic0fZ6XMLxrsyYXtAtUZvzYGMgmOLgoGk/sN+lEBc=;
 b=UMR6hNaNAxK1WRuNPq0YcdX7UXdziyqcaccWr0JJnxV8ptUYkeFtxs43O8KhaeVuIE1ORvQFxgnUq878TaISQoFqLLzTtt8C9m/0XLvoXe7yg2WAvtygKG/SoV53nLVGDySv+wdfNXtENTYIbncjD61EWhL/BTkugR/Io0Ugq0E=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4593.eurprd04.prod.outlook.com (52.135.149.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 19:18:21 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:18:21 +0000
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
Subject: [PATCH 0/3] Port mxs-dcp to 6ull and 6sll
Thread-Topic: [PATCH 0/3] Port mxs-dcp to 6ull and 6sll
Thread-Index: AQHUWoSu3c1hkwx9a0qjlkSgiHJVFQ==
Date:   Tue, 2 Oct 2018 19:18:21 +0000
Message-ID: <cover.1538507155.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4593;6:KSwsSyKqneu+qcw8X6QRrzAGEO1YIHx5ndBGHChe5kYbNZg3rZx8D001ta7tUUFXT5UB85f21fIOleram9geav6BONQqWJvAWqWZfoURZL8809AXkizgxudqybgunP+2/mmDuxc2uVsPrR5bR7FhcuDYaYG+7So9gf36hr0bsuj19dJpSIwWeDPJxPw7/lM0M0ynxPC54SO7fwHC6oMWYmirDIkE6sBdCnw1ntYGKdhi00uZQWqouASFw8KK2/1qpAq5Q/ZHBIxcUFkGlKdGi5y26PAQugsxqdn+uvKigNvIXn9/nN9AT8oNIDnkgsBkOibFtdXufCw1RVkoeWTMRLEGBfH1dm6ZKC06Qe2Kfe+0Zbde7VFnzhY1u7koufAyvgD9ufruVIxCbiyOt0eTyZbIR8XTqBekZBUu9RkS5WXJP1JjPHjqG80jU1oYhHBL+vFApkPRXi2Q8KKDdDuVfg==;5:zJcEbwv5yGhtGBsWIgziWJ48ImlHYMytxRSQR4ybO6A5Av+3zQvGXPTCDAEJjg4Zi1uiyNOrEaVHnU3ZxXvzLfHWlWiHwc/w6E8Gk6oTeyQmiFsbYlW8+ozYC+l+nUIFKkbeEuKQejojEmtFQfaSmwo734tDwBSFX3vgFuhUfew=;7:w0vriVsixYiMPKQ0Qn0P9L5A4de1pHA/xeVBxda4PQ3n6xNtV+ibrD/yFt2RL0MLL036yYjwYYslRvrMc5ULNvP7WiOsRwBRTktIzifaDddq55kHVZeQLkt5aRLvStEApbqeJXJ4ezc86lQALEJw+eGqJTJZvi4aMPthN1mOt0n5Mk79aePeoaLrUjZWs2VOE71JoyC3om1TQpudnMfyPRrAMIMmRtoZjF7jbaM2BHePaTJLlsOzuGetfwzS3SPL
x-ms-office365-filtering-correlation-id: 97149e60-7267-423e-517e-08d6289bd0b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4593;
x-ms-traffictypediagnostic: AM0PR04MB4593:
x-microsoft-antispam-prvs: <AM0PR04MB4593EE513DCC767516340869EEE80@AM0PR04MB4593.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4593;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4593;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(54906003)(8676002)(81166006)(478600001)(5660300001)(6436002)(3846002)(81156014)(486006)(110136005)(97736004)(44832011)(53936002)(5250100002)(6512007)(6306002)(6116002)(966005)(2906002)(8936002)(68736007)(39060400002)(186003)(7736002)(305945005)(36756003)(50226002)(26005)(71200400001)(386003)(6506007)(14454004)(316002)(71190400001)(2900100001)(106356001)(2616005)(66066001)(476003)(6346003)(102836004)(99286004)(105586002)(86362001)(4326008)(256004)(25786009)(52116002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4593;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-message-info: 53vKOxRfIgvEDliVfkV7HYJtyourPzGZ4qz6AX78lQoibA+0bPU1ZrhElvc1pAkU9fK55l1qjdQ0D8lJiKcKFKbWP0OVj95eYPlJ1FbQV9uPKRGIAtLcnWk15ZlGSUqLecABW1y3OUvtKMcV3br4IxamRZQUFcsiCJ+P2YRfi7CzwVTeGUOYXoc8rKHEJBRHb1Pl0/s9uPMC91VMzAE2+VA4tqGLe0931NnJziHrohcDffMDZkrGXFITyUWQrPsgZE18KIhbs2T4aSPD7tJUBQRz9DExJ9Qc9X0N8oX0GzmtG0EPW/i+/W9ZaddLa6Pi3fhuwgd9dn+u1vQiWufPaOQtYg6E0Gq/eQyMj0Y8gpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97149e60-7267-423e-517e-08d6289bd0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:18:21.0866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only important difference relative to 6sl is that explicit clock
enabling is required.

The driver currently doesn't even probe on 6sl, a separate series was
posted to deal with the crypto functionality, those might take a while:
  https://lkml.org/lkml/2018/10/2/1355

Since the functionality issues are not SOC-specific it seems reasonable
to deal with porting separately.

Leonard Crestez (3):
  dt-bindings: crypto: Mention clocks for mxs-dcp
  crypto: mxs-dcp - Add support for dcp clk
  ARM: dts: imx6ull: Add dcp node

 .../devicetree/bindings/crypto/fsl-dcp.txt     |  2 ++
 arch/arm/boot/dts/imx6ull.dtsi                 | 10 ++++++++++
 drivers/crypto/mxs-dcp.c                       | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

--=20
2.17.1

