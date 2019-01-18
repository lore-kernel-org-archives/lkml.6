Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA272C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4B220896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5yGDaW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfARIXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:23:02 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:20480
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbfARIXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EADeY62914D8roSRucnjeiGluNhw5ywIwQ9T0whRdfA=;
 b=A5yGDaW+LBrQ7gcmdQ+0vnM8bodPZAhIur3dTvcYQ44myaFR++Q5OAuu/9cKgErF2m/qjTTqtLtF9k8OaQCwSKPcGgkxA+1duhpj9RYf3BNLOOfuzxdFzqwqh4CEDKQesBPvCNl7+w38sO724F5KHxjROyHp32KNRwTQR2SlLWk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6148.eurprd04.prod.outlook.com (20.179.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 08:22:18 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 08:22:18 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anders Roxell <anders.roxell@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] pinctrl: freescale: fix link errors
Thread-Topic: [PATCH v2] pinctrl: freescale: fix link errors
Thread-Index: AQHUq/ozHTBMMePm4UuvH/j+5bs8JKW0tO/Q
Date:   Fri, 18 Jan 2019 08:22:18 +0000
Message-ID: <AM0PR04MB4211E227D5F21802479C6ABC809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190114111327.27272-1-anders.roxell@linaro.org>
In-Reply-To: <20190114111327.27272-1-anders.roxell@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6148;6:dt4Gz2zS9bG3QJSYxCqP6xstUMrHB/jeLhxP7MYV9v+trsc/wvX4gx0LfnofAbdLrodWhQ/L4/wuutpQU2ILXSES4RogmV3FzZ45MFazIN3chYDiWmY8Ae/PCP0Oh7ZyIds7LSBG9YI3vcNJnKLjNSUu9+gYYXQ91typQ2e2h1u8Mk+FZBS8hUwJKs4B50S7UxI6ogBDimjGoxo/o16uFr3clBterVGH3GxeynGtcPqJOkD3R+bP5rEQ7B/oKTKiKI0zWzMrEgB9aha/ACG+36z2AdfMjuCKp+rrpdtoLBVb1SsUhIkb6EIHuoC5/RHOwpSwJ/hZRm2V7tqz7x5jrmf7Hvtlub+nKaYLRXgbqIujPirHGXqW64obFDEpHQZLrlA5MqBl6+j8jjmlVTId+xy2NPmjD3aR6kahQBlpwAqPG2LQ1bKJ9Q+qGxD+b23s2TNK2cJwTvjhmfRLVaz1Mw==;5:Xz6CpQmTAWnocfIJYy6fcbg1LQ4DtLKTmkgndKrv29GFhWIPgxcAp2EHW+9k+dK98HO7mXV+HPyEkqUFYDVIhtqZhi+klfCqwR4p6vpguXgDQ/7tuD2x9J5YNK86eKAEVCfPfEB4SGPx7BDMHM1jtFDgJs7kiTqpaGHlCZLUCPVhcR1QuqkypOsir45a7w9ttXkupx3sgWptPq000JTAbw==;7:YjEwdUcRMB9Yc/Hme2oXbqhoNmaaCW04c2WaSqY8rNUizP6afAiy6osKIw1NJoxdGh8I9sNnrHcyZ0eD7LPtB2tDqm3NF5oChHqhPJxkDhzsvhBRi7qm8MHebJgG/kV16hX0nMNQQBvknZOnSPC7nQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 44506b0d-6f05-42b5-ae75-08d67d1e0f99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6148;
x-ms-traffictypediagnostic: AM0PR04MB6148:
x-microsoft-antispam-prvs: <AM0PR04MB6148DCD1EACBEE5AD7970D1A809C0@AM0PR04MB6148.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(51914003)(54906003)(110136005)(81166006)(316002)(7736002)(14454004)(44832011)(53546011)(26005)(74316002)(81156014)(9686003)(6506007)(86362001)(305945005)(71190400001)(8676002)(2201001)(71200400001)(102836004)(478600001)(97736004)(55016002)(53936002)(186003)(486006)(6436002)(2501003)(25786009)(66066001)(8936002)(6246003)(3846002)(7696005)(6116002)(476003)(5660300001)(11346002)(446003)(229853002)(68736007)(256004)(14444005)(4326008)(105586002)(2906002)(33656002)(99286004)(39060400002)(76176011)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6148;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JalreGtV64nYVs9yPEIGTlyuShf15mZLmOhQ4AjtCCDxZ7JJ3xmuDpVf1eENYTB4QfPjqiYOwaFn0d22kmhxJHj1/jVjeWPoCE/OcUO2xV6gGTRbtBofLMJDSVJ5Hu7exCXpi7na4XI1VcV5uF46750NunsVJ7ebsLbXZM3VvN5kfjWmjjEC1Q//1MBpoOEGZ5nJ0Aze5ng2KXJiZF3akjyfb58PE/dYgFT2kPSAFq8cvpSIP+ttuKVxu+W874a0r/2JBxjvPM7mTPkAQk7Gi+UTe5qG0YHkbWv7EnISthdw1vndpXaatCgCVZ3L7oMZuVwzyHsZa7tD5ZHn435OAYMoDoGGsrTCm359LsYhB/+2NTEqSm7zCMWJD9SX+B47cSoWmg0MOyqTL6KytwUWcQgptz9qRe1W4FExKfwAkAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44506b0d-6f05-42b5-ae75-08d67d1e0f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 08:22:18.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anders Roxell [mailto:anders.roxell@linaro.org]
> Sent: Monday, January 14, 2019 7:13 PM
> Subject: [PATCH v2] pinctrl: freescale: fix link errors
>=20
> Fix link errors when PINCTRL_IMX_SCU, PINCTRL_IMX8QM or
> PINCTRL_IMXBQXP is enabled as a module and the dependent module is
> built-in.
>=20
> ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinctrl_sc_=
ipc_init':
> pinctrl-scu.c:(.text+0x10): undefined reference to `imx_scu_get_handle'
> ld: pinctrl-scu.c:(.text+0x10): relocation truncated to fit: R_AARCH64_CA=
LL26
> against undefined symbol `imx_scu_get_handle'
> ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_get=
_scu':
> pinctrl-scu.c:(.text+0xa0): undefined reference to `imx_scu_call_rpc'
> ld: pinctrl-scu.c:(.text+0xa0): relocation truncated to fit: R_AARCH64_CA=
LL26
> against undefined symbol `imx_scu_call_rpc'
> ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_set=
_scu':
> pinctrl-scu.c:(.text+0x1b4): undefined reference to `imx_scu_call_rpc'
> ld: pinctrl-scu.c:(.text+0x1b4): relocation truncated to fit: R_AARCH64_C=
ALL26
> against undefined symbol `imx_scu_call_rpc'
> ld: drivers/pinctrl/freescale/pinctrl-imx8qxp.o: in function
> `imx8qxp_pinctrl_probe':
> pinctrl-imx8qxp.c:(.text+0x28): undefined reference to `imx_pinctrl_probe=
'
> ld: pinctrl-imx8qxp.c:(.text+0x28): relocation truncated to fit:
> R_AARCH64_CALL26 against undefined symbol `imx_pinctrl_probe'
>=20
> Rework so that PINCTRL_IMX_SCU and the config's that 'select
> PINCTRL_IMX_SCU' depends on IMX_SCU=3Dy.
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the fix.

> ---
>  drivers/pinctrl/freescale/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescal=
e/Kconfig
> index b318c24b61be..a599b72b350a 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -7,7 +7,7 @@ config PINCTRL_IMX
>=20
>  config PINCTRL_IMX_SCU
>  	bool
> -	depends on IMX_SCU
> +	depends on IMX_SCU=3Dy
>  	select PINCTRL_IMX
>=20
>  config PINCTRL_IMX1_CORE
> @@ -131,14 +131,14 @@ config PINCTRL_IMX8MQ
>=20
>  config PINCTRL_IMX8QM
>  	bool "IMX8QM pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on IMX_SCU=3Dy && ARCH_MXC && ARM64

Neither IMX_SCU nor PINCTRL_IMX8QM can be built as module.
So I guess the fix could be simply:
depends on IMX_SCU && ARCH_MXC && ARM64

>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qm pinctrl driver
>=20
>  config PINCTRL_IMX8QXP
>  	bool "IMX8QXP pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on IMX_SCU=3Dy && ARCH_MXC && ARM64

Ditto

Can you please check if this works and update the commit log accordingly?

Regards
Dong Aisheng

>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qxp pinctrl driver
> --
> 2.19.2

