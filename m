Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDB120849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3RYvhoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeLMNR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:17:56 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:44700
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729366AbeLMNRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Ryls9WoN2uPfg8zdg2z5SwKrCJUkH6KSy1ovwm9kQ=;
 b=m3RYvhoZ+LQQjfyKBNxVrrbgSYINvdMNMMyHcCgodLvUOVhaRTPaXVEsIHEXPsWzWla98KKRbeS3CfQaJKYVTLtlc47xB//QDrBEt0tNzbq48rmzfUwmU3H71lazmUJ3kLexBjVFd/re6AN/F++xKqV5nuT+EIXHdNDVENPxKC4=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:44 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 3/3] arm64: Add i.MX8 boot necesarry configs to defconfig
Thread-Topic: [PATCH 3/3] arm64: Add i.MX8 boot necesarry configs to defconfig
Thread-Index: AQHUkuY7xsi/enJXskWRpq5LGMGyIg==
Date:   Thu, 13 Dec 2018 13:17:44 +0000
Message-ID: <1544707047-4417-4-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:owjKpEKlIXGMqCYxTtgVzhNSRxqN0puyEvY2+M5SBC9g93RsmkKN495LKmgnCwH9ypNfYCREavwiaN7a+v/QAfjBX383CXjpw53wWrzC4oklWild71QTkRXbD9MwEKXA8O7N7FInfD7XKg/Paw7uWsn0D/c6jrhOcdFC8QGWiL10WtkVsG6wN9Sk/HgLxiH7Yz/Tunw2qgfIxJDq37Ygeh3TkuEbfW/Gv+1cuQqcX8TxYI09jQWxL4oSqiO0feL07KOxtPpmYm8bm8uZWdW7JZOFReLMqpkT8WNvkc+5fp9jBKSoZEr1oNsC8pO66zKc0MOD//EnG3ZRE2HavCAF2ZSnSJJHTfBrfpkNhGXB/pXmPr4uU3QOqHJBBN94in5E+nI1R4o1pbP53WPw1ss7xrWAW75+DbDi0x/SwGaocBTMwq4xuDsl92Au4D5GLt292eitEzgyfDn+XIHsLCWxqQ==;5:HH9mCLWxb+2ifwfW6D+8lUPM+R/tCTg35DlsmvvLtByKv1AhG1ELLr9U8HeXz/djkJAJjM/689s2FeOOlYyxMyx4VcQ0D/9LoRGV16irdLf9efEkG4rSCKeJUHo6P6kCUyZeOjy3Q53o6MwbV0JnC9hakFpHOuGt0o785nqUm+8=;7:0JhnQbtCWt+s6lW7L2+2cByc+Z+JcMRTS+5BPlXqBgAuxxAoqrI60eitusng4YvK1ziME3xJeiu4KxlLAMZXjC3CJVJ0tHCxUIU7h/4SDsqMEL/QOsbxgqOfLJC0KEzv4SE13GPnBeMORherqZqQuQ==
x-ms-office365-filtering-correlation-id: 320dbb52-4647-4120-2137-08d660fd5e42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692031EE5F6E09F4B5F294DF6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(11346002)(446003)(76176011)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qyw0JUxUeVhF+3y+16bEMgQ3yyA/NsIWUoeLaaaMyrCQaK8jK4T3GXEvJDJvWBFoqP76K9L5QxwyXkoWR1GDxWk1/w1+sRJT+HC3tsgceC4nY88AlkmwqWLG+FB0j/NdqVReRXIQUFgVfajqU18X2TuqjkJuydaRrRxPoFHSH5bWzm68D2RLleSTY5qkRG+bu6MIMeWTMNNC1HzguQ9NjemqPt/U5XWDazHljKL2k9jVYT6KsR2hn45W7uCDylHl3VeDOS/RIZxUSlXQLwtcdVQ3ZVPnepJ3Ng/VvuF2gSeMX/iIN/8ptKs2x1PNNybM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320dbb52-4647-4120-2137-08d660fd5e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:44.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_ARCH_MXC will enable all the i.MX8 SoC.
Also add the FEC config for ethernet support, the serial
and the pinctrl for i.MX8MQ.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c2b1f6..a129e5e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_HISI=3Dy
 CONFIG_ARCH_MEDIATEK=3Dy
 CONFIG_ARCH_MESON=3Dy
 CONFIG_ARCH_MVEBU=3Dy
+CONFIG_ARCH_MXC=3Dy
 CONFIG_ARCH_QCOM=3Dy
 CONFIG_ARCH_ROCKCHIP=3Dy
 CONFIG_ARCH_SEATTLE=3Dy
@@ -226,6 +227,7 @@ CONFIG_NET_XGENE=3Dy
 CONFIG_ATL1C=3Dm
 CONFIG_MACB=3Dy
 CONFIG_THUNDER_NIC_PF=3Dy
+CONFIG_FEC=3Dy
 CONFIG_HIX5HD2_GMAC=3Dy
 CONFIG_HNS_DSAF=3Dy
 CONFIG_HNS_ENET=3Dy
@@ -300,6 +302,8 @@ CONFIG_SERIAL_MESON_CONSOLE=3Dy
 CONFIG_SERIAL_SAMSUNG=3Dy
 CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
 CONFIG_SERIAL_TEGRA=3Dy
+CONFIG_SERIAL_IMX=3Dy
+CONFIG_SERIAL_IMX_CONSOLE=3Dy
 CONFIG_SERIAL_SH_SCI=3Dy
 CONFIG_SERIAL_MSM=3Dy
 CONFIG_SERIAL_MSM_CONSOLE=3Dy
@@ -346,6 +350,7 @@ CONFIG_SPI_SPIDEV=3Dm
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_PINCTRL_MAX77620=3Dy
+CONFIG_PINCTRL_IMX8MQ=3Dy
 CONFIG_PINCTRL_IPQ8074=3Dy
 CONFIG_PINCTRL_MSM8916=3Dy
 CONFIG_PINCTRL_MSM8994=3Dy
--=20
2.7.4

