Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C36C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IOTUfqLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfAPGpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:45:18 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:32752
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730889AbfAPGpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5EFrSI6jX6xbi0YggkwfxLVpW8YV62Kc5ZoGRYrM/E=;
 b=IOTUfqLFusxaqvTN81iHbnfOsVRLKZfIY+Y4/cEeAcyY4jKZEkhF9dPFUNoxbALAxnOZyoo+G9jRTVJJBLleBotowhvF/tsaZeadqqDX6WH2Aoz93wOiFhVs8CiMhBudq1Gu1wdvlXiYnukHmTdJIqYFmBAV2OQIgkzf/1J//oI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6002.eurprd04.prod.outlook.com (20.178.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:45:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 06:45:13 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUql41bLWLh57rrUukHyLcrmJCyaWxeH5w
Date:   Wed, 16 Jan 2019 06:45:13 +0000
Message-ID: <AM0PR04MB42115A85AE100A1B35E25C4E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6002;6:FYiU5uV6xWgp/OEEmTym8qgEjTfdnqnUFmEeG+zzhYtAe32JHj0oQaS9UiLGrat4FbopGfV7NcSo/Unwxh49ht0kM6tkSlBUS6afPW5orSTJ3e53V6aPejpnfqNnbc9Ra7bExhtPglO29JfiGUrIKQnZXYUpZsR9TDRvsAnEx8Mf+BTbOtyup/2nAA+ucaDVVzhdDW5JSLSaHTemCLepPUc38L5x+D5XbShpSwYjoMBcfILs7unQ2hR2a8N0waViP4x7Ss2SrvG9rSxZKyda7WtRNMkFluzHDCQERpgi6uiJZTlmKRe79h1gs8spqPwvXcK+fLM7cMxKKlD0DbKPvRe0Vx148NIhVmEP7FqquTA56I223xUTW8lcVZ40+u3QPAOIRdyTbXyefhBlmmqP9lvaLfe9aAwcsVwOS8CUC2OKOUyODcM3ET7UxbuP94+bKMnI9eX1dwQq00dqQBG5rw==;5:Uum/Ts7o7pKpU0MgBF5hyVJ9KgpvJVY1+TBiToSOqjuh/+4yDR23flkf8BlutkzaHSFvpvBnehMbf9bPFEbsLg040qbbEhZ7t2kXbuoSJBywosgjzlbFhHM+cfoT1rgI6eJxs8uAr9YKiM+t5shJ+QmRuzlnFMChKmZDDlR5hP7UwhlYZawi5rk2BC/g1vMidPYSS7a1NxYNgHbjzNtVLg==;7:WxQxgMGHGtk4xf7Jt6NLbal/wGs/I0vZA6sBuFAKG4m/ku67Ee2ooZCDQ6mmpx7VDn6H0VFFFZ3h9fYgIiy74Gkk/6hmLdFQv24zdtLA6i+N60cpWLOtuXZoGkKLm2RTK7vGZr+9C7KjB+XkMcG1Cw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0c49df9e-9c1b-46ee-64aa-08d67b7e2b0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6002;
x-ms-traffictypediagnostic: AM0PR04MB6002:
x-microsoft-antispam-prvs: <AM0PR04MB6002132680B97E7E3608980F80820@AM0PR04MB6002.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(13464003)(26005)(305945005)(99286004)(6246003)(3846002)(74316002)(105586002)(106356001)(6116002)(7736002)(4326008)(11346002)(6436002)(446003)(66066001)(25786009)(68736007)(55016002)(476003)(186003)(256004)(229853002)(81166006)(316002)(110136005)(54906003)(81156014)(9686003)(44832011)(14454004)(2501003)(486006)(33656002)(97736004)(71190400001)(71200400001)(478600001)(5660300001)(2906002)(53546011)(6506007)(102836004)(86362001)(8676002)(7696005)(53936002)(8936002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6002;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QbfvlLrjxkNzzvVzgCQYtZHJ2K5FNOhaARxaPxuv4Oq/jKtBfdT8MILpiIpxasE/CwqjPkW4BgxqDNwiZS1XH1pGuDUXUUyKo2rejec1Jhcs6udB6Dzkyb9fkUiahyWsRgNJPQvCXus+y84ZEDUgZcXK0H1hADvBJeX0mtX2l7lKBiNm7xAMpIVQAZXprD2Essyf3uJ0wqyp7Ltti+NDVM/GIruP+bEq3h9BQJckHHfBbrUOGMvLdf6IrctjoYsucbYpydH+hdb+oEa5cjUhN5gyTXHkL1VVPGUdSAJDHztIu6poQ3tFOI4q5uxbyIHj2iGgwpBT4k0zE94dGcdLnZanl+f6eWs9nBVtoKJ3r6YQpEi7RU7HDV/iJ+IeDsY743B5uj0xYT2BtRCISHTh4y/bNbHM1WSI+02bpkG7xuw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c49df9e-9c1b-46ee-64aa-08d67b7e2b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:45:13.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

> -----Original Message-----
> From: Abel Vesa
> Sent: Saturday, January 12, 2019 6:05 PM
> Subject: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
>=20
> Enable all the i.MX8MQ configs necessary to boot.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Would you rebase and resend with GPCV2 support added?

Regards
Dong Aisheng

> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0478ef9..e1d875a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=3Dy
>  CONFIG_ARCH_MEDIATEK=3Dy
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_ARCH_MVEBU=3Dy
> +CONFIG_ARCH_MXC=3Dy
>  CONFIG_ARCH_QCOM=3Dy
>  CONFIG_ARCH_RENESAS=3Dy
>  CONFIG_ARCH_R8A774A1=3Dy
> @@ -245,6 +246,7 @@ CONFIG_NET_XGENE=3Dy
>  CONFIG_ATL1C=3Dm
>  CONFIG_MACB=3Dy
>  CONFIG_THUNDER_NIC_PF=3Dy
> +CONFIG_FEC=3Dy
>  CONFIG_HIX5HD2_GMAC=3Dy
>  CONFIG_HNS_DSAF=3Dy
>  CONFIG_HNS_ENET=3Dy
> @@ -319,6 +321,8 @@ CONFIG_SERIAL_MESON_CONSOLE=3Dy
> CONFIG_SERIAL_SAMSUNG=3Dy  CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
> CONFIG_SERIAL_TEGRA=3Dy
> +CONFIG_SERIAL_IMX=3Dy
> +CONFIG_SERIAL_IMX_CONSOLE=3Dy
>  CONFIG_SERIAL_SH_SCI=3Dy
>  CONFIG_SERIAL_MSM=3Dy
>  CONFIG_SERIAL_MSM_CONSOLE=3Dy
> @@ -365,6 +369,7 @@ CONFIG_SPI_SPIDEV=3Dm
>  CONFIG_SPMI=3Dy
>  CONFIG_PINCTRL_SINGLE=3Dy
>  CONFIG_PINCTRL_MAX77620=3Dy
> +CONFIG_PINCTRL_IMX8MQ=3Dy
>  CONFIG_PINCTRL_IPQ8074=3Dy
>  CONFIG_PINCTRL_MSM8916=3Dy
>  CONFIG_PINCTRL_MSM8994=3Dy
> @@ -617,6 +622,7 @@ CONFIG_COMMON_CLK_RK808=3Dy
> CONFIG_COMMON_CLK_SCPI=3Dy  CONFIG_COMMON_CLK_CS2000_CP=3Dy
> CONFIG_COMMON_CLK_S2MPS11=3Dy
> +CONFIG_CLK_IMX8MQ=3Dy
>  CONFIG_CLK_QORIQ=3Dy
>  CONFIG_COMMON_CLK_PWM=3Dy
>  CONFIG_TI_SCI_CLK=3Dy
> --
> 2.7.4

