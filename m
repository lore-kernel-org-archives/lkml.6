Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180272081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DlhqIXxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180272081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeK1U7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:59:04 -0500
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:34688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeK1U7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvvfdhXpISHXvvq5egsUMVjfHJw4Tf00jiLTSmOt5HE=;
 b=DlhqIXxDrEVBlI0QVa9wLr3LHDSVzgy3IjhyDWHoTa1TTdEiqEWhuWQEIekzfrKAHnG4lzYNW9QBa5gsMMAJgABm5yb0WFEoA/EsS4D4IQrZCeSS30GoXBVwhYW/8U1wedbuSZHe834iSeStZ+n0eNgHmTIETMANFFQBlA37710=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:57:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:57:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Index: AQHUhwDPZlPoSbCFlE6ovThk/zmGCw==
Date:   Wed, 28 Nov 2018 09:57:45 +0000
Message-ID: <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:ovgDJjQGi2oR57iXqL9XZTjpZ073SnwdcOcVzWCWJY0e4qp0cJgtOxxcdSZE99C0hBBc3g6BD4oQlrzyjb7XAVTiPr+wN1L1FFZiGRfeyDOeUVocjadPLPhHol/e3tngpFQZMtvQGMNtoC01PpN3afgfoe1Szp5hwp5xQD2h+LsaTqMHTJDLZ7q6qNpmCIFEvK7lWOOdnmAxCRo199A9X0CKvUfF58w8qwa3wMUTmx2OiI0Ade0LZR69vXvCG4o6C/W5o+0Edy63vMdYgk4KH/R4Ia0b9vn3mU7r67DHY9+Xv8+lHW4yuzbYKDUeaHeeazTlGrAsY9ZFE7L9UMXPZlSj291Y9pHdfQIKNUogc1sV3jrcyXj0cEGnN1A/Sq2/ukWaCUfVYH2teVlAl9KUdJ1P2/WCbGU23FwGdqBkMrBMhF/qZinirnkJj0T1K5tcxGCWQRs9hVlyGFZzqdMoiA==;5:+x2PDiqsR8ql6LUKdnazzQke61reg2eKzGR+25yV3lyp/KhbP2nAUNmcFlkSGp64cekyNtq7mqBvFkowXRcggz34RxUzEsd1NShumSELs/aQgAKK3DzlXRaEzdr7kaEql75860OMp/Td4BO5A8GItHkkZJN3VyhF1N5i2KAbF+k=;7:wW5lghO9Uktxa4eefb72Iih+YODTahIB7to8xXqJ8WqAfqxx77zxKPVKu/Ost3nWUj3nju6NLd+tXO7/F++FVJ9yb1MKZ+bm2auxyCsdsyTawRyVg36aZ4H9FR9v2u1D54ZQXa+UGNqc8Kyx9Sz4tg==
x-ms-office365-filtering-correlation-id: 66b48dd7-8150-48b6-44a8-08d65517f19f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36904A8831ADA884D9AFF405F5D10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(50226002)(106356001)(256004)(8676002)(105586002)(305945005)(81156014)(7416002)(81166006)(71200400001)(53936002)(6512007)(25786009)(6116002)(3846002)(71190400001)(446003)(486006)(11346002)(476003)(2616005)(6486002)(2906002)(86362001)(2201001)(36756003)(186003)(110136005)(97736004)(99286004)(52116002)(7736002)(2501003)(14454004)(66066001)(68736007)(26005)(6436002)(386003)(478600001)(6506007)(316002)(76176011)(5660300001)(4326008)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lMriKuNTW4qd+5Lxe2ECcgD8emHD2Gn32rSoJnjzAN0Nw2IGNF4FlvDtozZ6hhuSNGZeBwz5hMFjSPK2yRurBL1ZYT2lWeWtqmSjAKKF9YO1Q7bakAIv+PFFEgBT4i8LTNOOSgOzfi6IMlxdpn4psylpnat09qACjcCi4wDyyStHT6hZrR8ucSRttINsoZa0RyqoFTKzvn14n24pdatxMeJlc5/J6s6QMuEbfw4enhEC5Xkw+IGnNvP5s9ONIohBsp+9kALGO/hWWnXkpagG4JzGUyUmqeBvqlCICXLCCt3dYEzD0EQ0sYNixQdURTqQQsIAIjUXtQlHwn8yFB0wydzHDJMnsaLJn4cC3cJWyZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b48dd7-8150-48b6-44a8-08d65517f19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:57:45.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index da99b6f..5e8b554 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -406,4 +406,8 @@
 		#size-cells =3D <1>;
 		ranges =3D <0x5f000000 0x0 0x5f000000 0x1000000>;
 	};
+
+	rtc: rtc {
+		compatible =3D "nxp,imx8qxp-sc-rtc";
+	};
 };
--=20
2.7.4

