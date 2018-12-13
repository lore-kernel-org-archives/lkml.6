Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7777CC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZoOB9Bj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7D32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeLMNWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:22:49 -0500
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:22411
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729265AbeLMNWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNdsgy+lUivqW2/D/ExAL4spZ50TL9YQavuXNTBsXLM=;
 b=ZoOB9Bj+2x4zAuJgLiV4FZ6ZSZ+og3MS2Zlu/K+hRHsktsa4RkrgPWuYaN6FGCE3j+s0E2ZL7ju0V22tCT4Uuyu9ynMGdKn1gzswkn1273JquuM23apE6orG4IdGhyup+8EWJYKpFO+oCMZN04+GSEMsFekuVTOOcU9Cs2lONGg=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3948.eurprd04.prod.outlook.com (52.134.70.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 13:22:44 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:22:44 +0000
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
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Topic: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Index: AQHUkuY53d/oCm2ngUK7tf7BE0j/P6V8qA+A
Date:   Thu, 13 Dec 2018 13:22:44 +0000
Message-ID: <20181213132243.5onni3uvuvoon3sz@fsr-ub1664-175>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3948;6:IkoYoH51GgiyLA7vZjgeKMk3mrrZCYoEVVG+0kYnqpk/tzjp6k6Ir1FVC4/NynDXPJI/fMfGBO6xKu27QiZoJfZQmnBFbfbvVD+MRlsAa7ZkPLWQhc8U4jZfwqfaYV4weB4PUB6+2MUXOsj0ybgdOUcMtV67a/x7IzheRiFdu2omzqVyllpoLp7kZfB2g55/S1/F2adv5pSK78c/nNuRTpg43yMstLYaT2a2wzYg16Vif3gNCdvlc6OzzntGIPhupl/JKGCUw1lVf16tN1jVBrMDYZ4DPDngP7fVyb/nJsI6twDe64iDpcHiLpECbnZeYco2J4o6c9vmgyMOfLVUGSMb3FO7/WecvggTzQgC2+dNvNs7gHeEcp0gaFbEAk9+RIT6pO67do0gP8OtPbeql5AM3g2TBR/4aHtMTJ+8ENZhjJPbbiMeqsdw3h7257XT92UAsJGzpU3qndtmDSfGWA==;5:gxL0W6hjiVSNdrdXW09ypPety2tZGa1K0IHbsrQijHQk+pJk60q30rm+Q5oPBT222HxUEmqHL1d84kzrVrfV/NAd32izuzrxR6IvdCEk5V4S3hobHKmU1vsyhWdsR7Xy+tSxbf5FHIc8B+jwnDOUz+mjXNrPR+SMIKqXUlVigWc=;7:4m2dqYk75G0fg3beDRocmqXMgCNLF2y1zTnaAR4IES3XbJWFB/AJuRpFEmJNgo2E19GYTq1TgM1+OW9t9T386m09Q+MUVZIHmSXrg9J1K9G5JB519cbuQrE2mwZZznlUhOBU3gUlh+MYAvDzAwCNXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb703484-bc5c-4e1b-3bfe-08d660fe1146
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3948;
x-ms-traffictypediagnostic: DB3PR0402MB3948:
x-microsoft-antispam-prvs: <DB3PR0402MB39480EC33BE24D87017C7527F6A00@DB3PR0402MB3948.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3948;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3948;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(256004)(14444005)(102836004)(6636002)(6116002)(478600001)(3846002)(316002)(54906003)(33896004)(86362001)(2906002)(6506007)(53546011)(110136005)(229853002)(106356001)(6486002)(66066001)(14454004)(105586002)(1076002)(44832011)(7416002)(6436002)(26005)(5660300001)(486006)(476003)(11346002)(446003)(7736002)(99286004)(81156014)(81166006)(53936002)(33716001)(6512007)(9686003)(71200400001)(71190400001)(305945005)(8936002)(68736007)(76176011)(4326008)(6246003)(97736004)(25786009)(8676002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3948;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qSjyLfv5Co/0uCi9MlyndiajfkYBMjmjOUHlibk2nLKevvBZ8MAi1Dicpak1ewH5y1G+wGwqgTHp7iji55MpDQ5T2LxdnNVcuUodN1NfVQbPxMqDCGm+FBEpVjyw3xpVWayB6Ffziihq9c9/8WC8Ao1VdhY9DIrhWA/l7n50qten5IpFfAVrj16GsqWnUsoU3zgpBvlg3+d25w8GBG6LDCYOWjMW3z7yS85vY20yAG465XbwWLEkytMsQhPNstSsKUoiZAzpWPvyhmaQxFnpkqJRqo0/zmTwg8bHMN3OuY43MKBfoq7nz0uecuTT3VxI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E6D80BEDA130C4EA7465CAB3F78C21D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb703484-bc5c-4e1b-3bfe-08d660fe1146
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:22:44.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-13 13:17:40, Abel Vesa wrote:
> These patches will probably have to be take through different
> trees, but the order has to be kept otherwise this won't work.
>=20
> I can resend as separate patches (if necessary) as long as we can
> get them in together.
>=20

Please ignore this patch series.
Seems ARCH_MXC is a poor choice. Needs a proper look.

Sorry about that.

> Abel Vesa (3):
>   arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC instead
>   clk: imx: Build imx8mq clocks on arm64 only
>   arm64: Add i.MX8 boot necesarry configs to defconfig
>=20
>  arch/arm64/Kconfig.platforms           |  8 --------
>  arch/arm64/boot/dts/freescale/Makefile |  2 +-
>  arch/arm64/configs/defconfig           |  5 +++++
>  drivers/clk/imx/Makefile               | 11 ++++++-----
>  drivers/phy/freescale/Kconfig          |  2 +-
>  drivers/pinctrl/freescale/Kconfig      |  2 +-
>  drivers/soc/imx/Kconfig                |  2 +-
>  7 files changed, 15 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.7.4
> =
