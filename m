Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8641820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="upq1MJxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8641820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeJKS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:28:03 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:50555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbeJKS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnK6v5vsJ7Umgt5yF4KnUKEIOHe7cCFP4OXTjhmSUE8=;
 b=upq1MJxBbIHObgA9Ia+hdh2JWCsKik7eEZMhGW20CJlgaSBFytwFIQi5ErKBV1YPkHYJcguam4o86Eny+Fy3KWgxW62Fv8Fx4qX/Sex+xXrf8HckRAX4vMVfa/SP4vqx9DUwFdp8jy6XhiZlKhDzOC/DP83WsOUxByrutNuz8Dc=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1024.eurprd04.prod.outlook.com (10.161.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 11:00:49 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 11:00:49 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
Subject: [PATCH v4 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH v4 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Index: AQHUYVGrkfAAcVsJREWOXC3aKbc1Ig==
Date:   Thu, 11 Oct 2018 11:00:49 +0000
Message-ID: <1539255519-1408-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0173.apcprd06.prod.outlook.com
 (2603:1096:1:1e::27) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1024;6:vtajIGBqu6HSaoIhih/CXuWBUo2atcubWurQcH+MvT+N6ovLkr438dCbGAR+w3GfGB8+GpKC80wQv6jCkDj1HPT9gghPdybvHj0Mi5CbOuqLHmKzCoi64Yzdk5mXoiEG+g8l+LHp9kPV+CusxZPtQpFWyNQkHDLwwXo8U/UrVLft7jc1jjGTcT83aA9TRzInwY+0mKJWir9pjh4/fLEo9iQL1CIxcS/CVXaiwdAC2+sdRjWqU3Dhsctg1uHhG7TkJpaXsi/jtBfzWuKYPynOS4KzAcvbjfC8JU99UMR73lXRswUDhEM4jJHryhbD5l/QbFHkecFwYcJ4PHxbXjWYrnv9/JBPfQjlT98yFWD4eMyXAPyz3h0XiuTOqOpgC20wTKu3Xdf/4YGy0+3XFqblEKEdNfY9oRLwR7+r+TLGHTCjKOzDiG2KrBqUJ/ARoKk5E0jwLv6E6HG4mcU2NgGiJyrKUTFyjyEW7x7hCz0NJeo=;5:74yTdSFrwYv03dd49OZuQ/Qa9SpPZwtVkyfIbUkbPB0h+YP0dNOu2unZCHM9cw7p8a5WQHXSGYD2Kxj/fZU5B7NskK9oEYJkuPlMZ7LjYbDgHISnFIaTfxjPGhg23nUSfZK+mZ0Lodi8Bv6Ks1k6QOEko0OCK2w9vWXSDX4NQj4=;7:tQC0AF5NS+QXvyE6MP2jmqV01zqjv71fba7sFnjFvpWhbWF0+b+INEzkGKOGr27bQi0KcRhmRBJqgXWFmhsLaBmsQDkW1+eNWNZjjJmLhcJm4RcUga9+hYTZOoMlEw4Dos2UeCWFpXxT96LoWNo8jn+vbvAJP8U0X5jaNwWHVrMFaNYfg6/U2yKiyNnTM8mgcqC5YbM0PgMmLWWGvbJEgesCRRp8An+b9s69hw+p0NvM3W+B37tbBa5TbLNQMV/m
x-ms-office365-filtering-correlation-id: 89d509c1-1c80-4298-7af4-08d62f68cd94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1024;
x-ms-traffictypediagnostic: VI1PR04MB1024:
x-microsoft-antispam-prvs: <VI1PR04MB1024A696D0A528E6D8093E2F99E10@VI1PR04MB1024.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1024;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(478600001)(39060400002)(4326008)(54906003)(66066001)(25786009)(8676002)(2201001)(53936002)(68736007)(486006)(476003)(7416002)(6512007)(446003)(7736002)(3846002)(6116002)(86362001)(11346002)(305945005)(8936002)(2616005)(81166006)(81156014)(256004)(105586002)(106356001)(6436002)(186003)(71190400001)(71200400001)(110136005)(2906002)(55236004)(6506007)(386003)(5250100002)(99286004)(2501003)(97736004)(26005)(52116002)(6486002)(316002)(5660300001)(102836004)(36756003)(14454004)(2900100001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1024;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mLSFtcgcm77bQWZLpDjOZUWww/MbeTt8AYjufrYIM3q3nDkTrIKcuRil7p+tgzvFOWd5Kz2J5Iz5UjODMjlpzFlIaOA5sVbMX+Tu5aDg+MRHmc0R8F2kLmHWyvmkDBNh/dSdrbJceO/6VAGV63pDqIkSpazauYd2adxxw79vvNQVSI1OsbJhcUWf2/fN8u4OnDR9y22hOngNO1l519bOt+u6vXlGbvcnTK0EguGRVsrUz7zgD0bYWmt9PfcMjAuQtI8UvG1xW5ggMGC5piU8JSX9oawTtdK6R0EiOrTiO55awHTKDYlUHwrlAZdH3XFL2oLWgn/7yYsDk3QueznxsY8j5QssIQu6K9BtdhdTFxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d509c1-1c80-4298-7af4-08d62f68cd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 11:00:49.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cfa8ca..75ceddf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -335,6 +335,7 @@ CONFIG_SPI_QUP=3Dy
 CONFIG_SPI_ROCKCHIP=3Dy
 CONFIG_SPI_S3C64XX=3Dy
 CONFIG_SPI_SPIDEV=3Dm
+CONFIG_SPI_NXP_FLEXSPI=3Dy
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_IPQ8074=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
--=20
2.7.4

