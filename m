Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973682086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9qYMZay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973682086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbeKHBE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:04:26 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:2145
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727203AbeKHBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFx6rlsYEewhiKIe9T3mZmJfKpEBqv5sg4DkRb8qvec=;
 b=f9qYMZayZCD0xDUYkz4N0twUoYcjh78kEYjoRG2pwc8+lezMsOTJayo7uWxQQ0oIs/QXiETWkHd+1mgX5V/JrDu1rNB5DVMJnRSt+2/8ZGhvS53+eda4BEmAsG3W34V9ImlgtJf4WlCYkoj10pKmf0/hE/8NjCBnDThYKOOjIyc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.176.215.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 15:33:31 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:33:31 +0000
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
Subject: [RESEND 1/2] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Topic: [RESEND 1/2] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Index: AQHUdq88TUDowSpQHU+d3vYHR8R5Hw==
Date:   Wed, 7 Nov 2018 15:33:31 +0000
Message-ID: <e745d22e342726be9a96c2993d8a279d6c5dac6a.1541604742.git.leonard.crestez@nxp.com>
References: <cover.1541604742.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1541604742.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4962;6:+cAcy+yro4xr+RIiWxZedHX8T1l5v/7HOmMOsmIy7B4ExWgBgiN5n0fqeOy8Fch7vx65abIwd/iwJIVsffIyBS5xHraEi16drCJDL0cVSCf1Z8vzg1sCSUmfg3QnjCpY0aT9qyf+Hb78/e7Co6BMmVYyL/aqImicEEWANtRj3G2NEtXp3ds4kTr6x4wzr9FGGhvZduA6o2K1NM0ZxUFShK5anCAR1jp4ON21N3RE97pp3zvwT2ZHPwRAtSsCoe1932YjNcksXUWhEzrZXzRe/6DfjMb/Xw6XmltiDTHQSbujaFzfHtvGX0wUUAUCmVCTdJFykh9EZglBB3Cg8h6u4oL0l6YyJLgAC0P73HEYMZ+mafb8CQlFLTEUd8WME3Fr01GHIXZtj80gg3gYOp/AOEYbNpV1OwEchY1mIEUgdkA3tZgvcbOyFGlVciJ/7G/t0tNA6SWJkhPN4pGCVhVj9A==;5:oGTqsSaSlOPWa3/wJ21+em7sm4AqV9oTe+RGPFTC71V5HKO4JUThShwmRGQy0H6UsOWNWq63rT6oI6q70on/13s1eNGK3cPGhMfVWyR+VVhGpMFPhOQZQNTv0ryxwuD8K/6a/aYJCB+igmzeEXIPnw6JlMYvmn58aUAhbPsYWRE=;7:bfOR0XtqHKpVudy5BcASZNEKAqYQdk/jY550tzMRkjbT+LNa6kaEXkeqLJcGGQyX6vmZwiT9ags74kiTiM3KqwgTGEBrA76MylZf8OHSwRuS2ijaSh1ARyJllyO99hTjKvIIqE6XMdkuYDFcy3N0+w==
x-ms-office365-filtering-correlation-id: 00f213da-d372-46ba-99ff-08d644c65f44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4962731350D2DC9BB75ADD4BEEC40@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4962;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4962;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(2616005)(54906003)(186003)(25786009)(102836004)(2900100001)(5660300001)(71190400001)(316002)(76176011)(2906002)(36756003)(97736004)(71200400001)(81156014)(8676002)(6506007)(118296001)(39060400002)(66066001)(68736007)(386003)(81166006)(110136005)(6486002)(4326008)(6512007)(575784001)(7736002)(99286004)(26005)(105586002)(106356001)(256004)(8936002)(53936002)(50226002)(86362001)(6436002)(3846002)(305945005)(446003)(52116002)(14454004)(6116002)(478600001)(486006)(11346002)(44832011)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JBwoZa6mVslkomxP+h80WpK9ZZSjLnqcJGb1OcBF2q8s+QkfUbNUml2TFjo3O7+UxwdIlg1fwHd4UD9+u+yfMVG5H+1FMVV8xlxkSUXf+RqVDr1LZrbNAQ7B9b7TQ6FrHeYLIjaABYOarfnYwHu9LNms7Pp1ZVhxDCGLhcfMUBA701FwvrLIw4QkqMzShw76HPYPV9V/b5YTVKTAciOc9TqJ84M91vOtAMsY7DZiN7IZril6kok4hxwtdzzxsoHtQk4E17O57XboYzB1uCrqbQ8LVrvgGywg8WLLnopAkMMWHtQS33JdJyLXzWsQMTxGIhNYgof7qRxt6zjjH6Q5vM+3wssQ4E76VJUDZnImp80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f213da-d372-46ba-99ff-08d644c65f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:33:31.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit clock enabling is required on 6sll and 6ull so mention that
standard clock bindings are used.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

