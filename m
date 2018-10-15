Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59191C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1238A2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B5gr+9kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1238A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJOT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:46 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:39904
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbeJOT7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQBWRU1PYr+2Tj7T73znBG3zb246sOoVkLm4qXHLuvg=;
 b=B5gr+9kPtzNCXtM2SnUFB6436PgHdKZhfyjVKquxZVm6jxdeyCb9ff+XOqrhytJFM7jfHu9UJ1M3RZE7jDur1lm1zpNbTRIwHndxF3/mu/A97Fta2Aou8y3M0XUPQfGxznDIu5W92ROIO0beOzhnFlAVao1jbTtu4D0OELilFgg=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4224.eurprd04.prod.outlook.com (52.134.31.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 12:14:40 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:40 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 7/7] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v2 7/7] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUZIClji1t9xKYIEy2xvJrA08STg==
Date:   Mon, 15 Oct 2018 12:14:39 +0000
Message-ID: <1539605534-22302-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4224;6:ovsMbxrPCAImH5duoSEU8TVTq61YbCBaksqzwGXvA+7pdhgO/FPzXcC9A5BygmB5i8QHLKnBj0QsnEAr/1u3jWP0eK/RtGKq1DsEZK/a2PJ3f7iseUYj30WPaeTJHjxGGq7apROnKL+DFqXeI52CceQbzSzn2ZeCTOBadF1+lyAp9xtIN+1Wzd3otFzp7MGjDqTTEZY9SxwJhUDVgiH1E73gykln+qnzNfX1kHbgbZaHd+WSrAWyizx4mQhBgHx+0tDreIkjouNHIEcmDy/Jr7nFrgRVxsDSoA9rsOJc/V1D0ST9FGPfzOLWYIh5GMczKV7IipG6k6cemHzq/96CWYCWVwqkw9CJar4km+6BHGPSZigIDVGitTMSkUUK0QLgK+qlHBnSmkxCYNhoX/QuQZ8mIBUn1G2cylG4oTJyXGfyw///HotrkwckCv/pC7jVeVbLm5lPcuAxIxRW855sMQ==;5:T8LBpvUIZvHWlVqIM0PtJeoanSxee3bIyDsbAGZAZOa2+fSL5tVlwMLMmzMAvZsHKx0X7X/HGbGvCYp4DYFkuQUOwB7dSy18jWb2OYwetLKgU3MyH3qc4XCsQCwXngZLUtYWBhir5cDh+eZK/f+pSH6GwEb9W/gBE3btNAOGdYE=;7:gkmhr3EXK//UbcrN8wB1hNqjoT7/b+WEWiTEFRjynL+U9PUg7BP7kbuDvOzDZ423X7G47S2ObBuNrE2wJagePY/5n7Fes5Txxbhuelzm1sHUvJsSF0aJkakFbgukXUxcEKjFc9EUf339BdjZulI4sfOeGZ7/gw8ZvefLN73hYNcClhbHxu5ycffiobHtYlIAfnLXQYUd0H2yIHsl1Ei0lBqzFki+TlYy46k/r6do8Hy/15CeCh6hs/d6f5B/KwS8
x-ms-office365-filtering-correlation-id: 62c2867a-40b2-46c0-4483-08d63297c7cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
x-ms-traffictypediagnostic: VI1PR04MB4224:
x-microsoft-antispam-prvs: <VI1PR04MB4224F297C91053AF36F656C599FD0@VI1PR04MB4224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(71190400001)(316002)(8936002)(81166006)(81156014)(11346002)(2616005)(66066001)(446003)(6436002)(6486002)(256004)(2201001)(7416002)(68736007)(36756003)(478600001)(4326008)(14454004)(86362001)(39060400002)(71200400001)(54906003)(2900100001)(110136005)(52116002)(53936002)(476003)(8676002)(25786009)(76176011)(2906002)(2501003)(99286004)(97736004)(106356001)(5660300001)(105586002)(5250100002)(486006)(55236004)(386003)(7736002)(6506007)(6116002)(305945005)(102836004)(26005)(3846002)(6512007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4224;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CliZGfUNxpnJUn9DNAXpnFooyYsDAbDGJ1S9hSEDCn9PnIeyGuMVgPZ5hLVt56dQJIGRgEkkrTiFW3y9Vka39fIH6D19fezBPmyrknmGiijqeXifg4uT/eiXno15qZpCpNJCznmka7V4/eKfbg3Oxuk7wj5RJzWAdakfUyjvxgDeiFB+IQzTnm2pd5ZxvkbegFmMbuuXh9sLqBwVKVLzzYDUvC/vRNpyDvue00/mvHUBJCY4C/48+Jl4w7B840+p97XUEyfMDZHnme8jnu6ZLhZegKu+5QgKE7d+lTzElsp279o17hIDvRpGQ5trrXaV+Cu+KHiIF0pbHJwJCXGutq5scHIG+bRyX8EbycmEv9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c2867a-40b2-46c0-4483-08d63297c7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:39.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Make spi-tx-bus-width as 8.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 3b20c97..24cc41c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -45,6 +45,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <0>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
=20
 	mt35xu512aba1: flash@1 {
@@ -54,6 +56,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <1>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
 };
=20
--=20
2.7.4

