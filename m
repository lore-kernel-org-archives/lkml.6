Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A7DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQkMDEZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAVLjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:39:48 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:42283
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727919AbfAVLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pqWzl3N9/GM0Sql2by3rZ+a70w97Pn8kSBq5IHPntw=;
 b=mQkMDEZb5/9dkXrSycNlIm19Xnl8j60CMyaHMOV4tspDKzAFZqVavk1U1XSeXFOaIrv5q8ac+y3eX45s3tosXhZyHIv0FQcTLI+nVwdWGg8vw98uSyKCkFsZcnhc+GimxAs+qeNHveETXXAPeMiNeXXhvzCprQlirhOsoR6W004=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4371.eurprd04.prod.outlook.com (52.135.148.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 11:39:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 11:39:44 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anders Roxell <anders.roxell@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] pinctrl: freescale: fix link errors
Thread-Topic: [PATCH v3] pinctrl: freescale: fix link errors
Thread-Index: AQHUsi3KP1/c1Ky7Lk2wYrTC4Trbk6W7J6wg
Date:   Tue, 22 Jan 2019 11:39:44 +0000
Message-ID: <AM0PR04MB4211497532B3B84759C3F7D880980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190122083735.13286-1-anders.roxell@linaro.org>
In-Reply-To: <20190122083735.13286-1-anders.roxell@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4371;6:b0aX6LF4fOfyvQRHuLnuV7kajg+1KkZbaD3BZtFpoHoet21a1g+HawL1G2azfIWuKcM/lafL/BYWVA8OMTjUw5/e2cKtRUlZt9dLPJHBSzYchDdwVWE8CFsIBTQjJlUygofEcdjgdAZcl1XpAhideE05eP+pIu2w7Xvwe5tSE++qU/IDiKO3z9sI5qDoGOXk9HY2utAuI6feDDCRaoSQv5I6wykmrlx5+LGSGl+PhHYk9lXbSoZsp6LwtDyLQUrEKEv3VNoD0pSJNxfwmXDIwV0iK3CI2ff08rYlJT6MYL2jRONKSR7dfS/DV0gsqNuT41TFeI0TWm+cbK++b4p/oJ+N6a/LtvAzQ29zA+olfbzQttkSBVNAnHZBNy2y5vYzeqQA4VP2adkuhvRwRWl2IW+3Qlj0lJPRuBcw7/VHSUUc1e1PFk35dbM2JC8iwozOjS4NSLbOostEOzjo7Qpc/A==;5:+BILYwNl3eaa5eL4eWhVszW9UTKhAcWEP+b2IYcufiWwhhNVKifJ9Jrm5XEtX8R/w6DuQhODULe2tCOIa/OoTPqn3YTUWo+yon6ZKKvFei+EeJHPQ1g5D4ZISt4+sRn58DzpSphAvFfVj+MalNvn+IHX753tiRrQ2G8JepOvG64o+eaTRr9TcLV34+YPMcFpEQLdvxmWtitYaJ3kOAqdWA==;7:fz8zFSh3giZcXaOyPg83/PmbadKAiczWxwh4iYZ/58TTfcGm0N6XvPqf1Ijuoj2CneIGJhiaCjVdJyn+wjCbgMHbagt43hA6bG4eCIzZcuuUTGXMcI/ObuuxaEMeP3KKkS0CXhBAcE74s3u8lZYjBw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2955000c-b677-472b-b8ea-08d6805e4e35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4371;
x-ms-traffictypediagnostic: AM0PR04MB4371:
x-microsoft-antispam-prvs: <AM0PR04MB4371A846CD4FA3F15FDD489F80980@AM0PR04MB4371.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(7736002)(2906002)(71190400001)(6246003)(71200400001)(305945005)(110136005)(74316002)(316002)(54906003)(55016002)(68736007)(11346002)(8936002)(9686003)(446003)(53936002)(2201001)(86362001)(97736004)(14454004)(6116002)(3846002)(486006)(99286004)(106356001)(33656002)(105586002)(25786009)(44832011)(478600001)(2501003)(14444005)(7696005)(76176011)(256004)(81156014)(26005)(66066001)(8676002)(6436002)(229853002)(102836004)(53546011)(6506007)(39060400002)(186003)(81166006)(4326008)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4371;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qGeF8TnhqvJ0TEixLM06Rm2KTkBYynCy98nkoHZ4FjGn1lBOdTTNOL+Bv/RJUWAIFh7vDEV9fnfM0r6ysr/EEifJ4fAT44VdQtbj8F5G3yYn3LDMe3BnZtfGYc5gbp714LRh5OmorknUycgNRGqofMyWHMLUu2oB/RMxjqeMXT+alnCtDKn2iAV+8gJLyKo5mPI2KuUDNVpCwWdQ1Zz8kFmHIrBQ1i4Px/udQvcaps3ZEF9W9cLlX6aOEL3kfM97ILdip0Up2wWg8rQWd8lEQwq8jcysevuw/27sNeEMMGSCJDUxU60Jejdn/GK5KGhh82wzL5f4dUfK7Z/I2y2SvPoyTRHZ6uBlaKpBB0D2lECCHw4PpLONqjQQqj0/E/TWB22tlEDIg1IYEXV1ujvn04rkjj2JGNFzZRJRUVKo5ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2955000c-b677-472b-b8ea-08d6805e4e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:39:44.6047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anders Roxell [mailto:anders.roxell@linaro.org]
> Sent: Tuesday, January 22, 2019 4:38 PM
>=20
> Subject: [PATCH v3] pinctrl: freescale: fix link errors

Please change to:
pinctrl: imx: fix scu link errors

> Fix link errors when PINCTRL_IMX_SCU, PINCTRL_IMX8QM or
> PINCTRL_IMXBQXP is enabled as a module and the dependent module is
> built-in.

Non of them can be built as module.
I think the problem is that the dependent module IMX_SCU is not build in, r=
ight?
So you need update the commit message.

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

Update here as well

>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/pinctrl/freescale/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescal=
e/Kconfig
> index b318c24b61be..af141dd2331d 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -7,7 +7,7 @@ config PINCTRL_IMX
>=20
>  config PINCTRL_IMX_SCU
>  	bool
> -	depends on IMX_SCU
> +	depends on IMX_SCU=3Dy

You don't need =3Dy here.

Otherwise, you can add my tag when you resent.
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>  	select PINCTRL_IMX
>=20
>  config PINCTRL_IMX1_CORE
> @@ -131,14 +131,14 @@ config PINCTRL_IMX8MQ
>=20
>  config PINCTRL_IMX8QM
>  	bool "IMX8QM pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on IMX_SCU && ARCH_MXC && ARM64
>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qm pinctrl driver
>=20
>  config PINCTRL_IMX8QXP
>  	bool "IMX8QXP pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on IMX_SCU && ARCH_MXC && ARM64
>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qxp pinctrl driver
> --
> 2.19.2

