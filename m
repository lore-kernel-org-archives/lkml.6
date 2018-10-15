Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7AD208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="beRv9onm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7AD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeJOTdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:33:38 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:47765
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbeJOTdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlTvKAy11pYmvkpxMUN8SJAvwSjb3FEvtpgnOcrcNKQ=;
 b=beRv9onm2R0567x1uBPPkvybjX7RVAhV2+yywrKNXTLNQGV9q3X/f+k0OfQkH9T26RYHhACy3maR47pCpZePhXNZ2GOs1X2ssVmC+OVlr9NEbYYxzYeR04uQU3bPT0xbraRX3GAVYPqlHQ+cKdFdC9lUGny2vcnYkpYGZFduw4o=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4912.eurprd04.prod.outlook.com (20.177.49.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:37 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:37 +0000
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
Thread-Index: AQHUZH0CH9NuyTQbaUSk9MuShuFRIw==
Date:   Mon, 15 Oct 2018 11:48:37 +0000
Message-ID: <1539603969-21076-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4912;6:O6Yp6ff8+9SlkgTnYfhHPHMd8BEscJM7/yBZb37wIwkMorwODKqva+EaBUe71i78nOCM+6PFJMqVsfnM7BETUI9CCKrwfZFCDo6PR+mwcA+1d5R7r7AUspF/Rlk7GqySUwqgRAinVkR+Flv49+4B6DkjjVbDSAsu6fBDfohAdZvW5e2wOc9cxqYqhuGEP2fwwI28/NstfSyfbCQPutcYccM+6Vp/jCHybxvoAKEhCniUCzHHoWy49c6o5aaFXhC3kOL4uzdUFYv+ACBm6A7Hy4MAlTWoIYmcfNEkQZq3e/gU5BMVGaCEZIfVJC9GlEFHfMjHlDeV8GeCuE6bKgmDgmOdV3M0wPUYDD4JLHDs9bZNnxeQUR/q00u0DfndY7QCOINSnWiX8SFFNJMth/XofL7f682U4hcYWs+GnvShZEYlNNncjl5WBRl0Ca7Gz8Zn+iPkosd1Mc7TV8x8Xv9a+g==;5:ynXZGlA7cQa0TPX+AwIcBuFRWQtjZlDi6oJ0wWvgj1H2PB9Q9ruwn9XjleKm7Yrw1CInFGIefzCJu0uHH5jy4tz03ZuIMZIPbSJBFYVP0oEM+pQ27BFz4y2TXIVxSy+U2cJMK2Ygk4DRH1CKbzG/47PJqg3bypne/Qwzh8xghYA=;7:iyj9gAJaH6Gv241ML0l2Mh4wPUqtnqMWZ49jLj0UMRh6DqSI6kD6VldDyxcPeOIfO8tQxOYEHjoxaARedC4eoC4QTsbbK+EHIGFqEUd2rkX6Y2YcfwaVm6NGnR4nAXlabL8c4/1n+uhnxcwPC9/h0aJPACUlz23gmDZVoBfEo8zZcTtwi8EQKkuV+RkwDtCVG9f+Xwoy91oVK0GdDZmyMC1xiaugECRDNl+PvaKLV0rpNwZEWrvWu2zAr+CzB1gV
x-ms-office365-filtering-correlation-id: d41eb8b3-665e-4495-7bf3-08d632942492
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4912;
x-ms-traffictypediagnostic: VI1PR04MB4912:
x-microsoft-antispam-prvs: <VI1PR04MB491206DE166D09F4481CF4F399FD0@VI1PR04MB4912.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB4912;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4912;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(11346002)(39060400002)(25786009)(478600001)(2906002)(2616005)(476003)(4326008)(6486002)(6512007)(54906003)(6436002)(55236004)(6506007)(386003)(76176011)(110136005)(446003)(71190400001)(71200400001)(66066001)(99286004)(186003)(52116002)(486006)(7416002)(53936002)(2900100001)(102836004)(5250100002)(2501003)(26005)(97736004)(14454004)(6116002)(3846002)(256004)(7736002)(305945005)(316002)(8676002)(8936002)(5660300001)(105586002)(81166006)(2201001)(86362001)(81156014)(106356001)(36756003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4912;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aLu6I6sSOuocrGcISn0v4ancRXqz3y7Cfjq57cCicmGFGsvVd+AmmAQVmgRXyZt1DGkaBZDaJehQH3i2OuFCFECzEEcJw6BJ+GcS7ql98geJtQdlHB12ubUVy/+NwXH6AdEnNWv+JoFxv/Y7RIJndXgmJCY5zmudJcRmSEZ+iL6p6BZyQ9Iq3DTJVTG9iwtSJhSl4tcSaiHmn0AHOH2+voXZK2nQtwXSqemFYovJI/zJ8q7hBYqwAgBcN2MypwUzVlCoRKg4fI1sg3IjOEdF6oxsaRLEQQjEizZ2kHSWN4qQU4O2QnKheOk51iIG0+Et1k2QNw0i5TekRmaIrpdCl2UK9Tf8GYFhGuncP8cIddw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41eb8b3-665e-4495-7bf3-08d632942492
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:37.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
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
 None

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

