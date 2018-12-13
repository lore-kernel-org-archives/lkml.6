Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534872086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZCnPE5mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534872086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeLMNYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:24:25 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64256
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729338AbeLMNYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1fX8r3+esjyiHrDpU+aaSx/kN/QQYEn4NdoQw1vV7s=;
 b=ZCnPE5moGElEa6nTtIT2Usr+FFWGxyiNlVbPhWXuzZt9S3gTXO8VGt1LtWby25NIMzqjIQpWuI4+11L6UJq3tbGFqgwH2qqqyPNW6Ld10m6tU9NtDU5dsdiOCdjHDwg47YXdysnTy7kVxXErAMJNc4kwfKHn3ssHOTLIbCBqlbY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4625.eurprd04.prod.outlook.com (52.135.149.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:24:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 13:24:20 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
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
Subject: RE: [PATCH 2/3] clk: imx: Build imx8mq clocks on arm64 only
Thread-Topic: [PATCH 2/3] clk: imx: Build imx8mq clocks on arm64 only
Thread-Index: AQHUkuY76f6Gv4pzLkCV41rtHGtj9aV8qAYg
Date:   Thu, 13 Dec 2018 13:24:19 +0000
Message-ID: <AM0PR04MB4211437CCFC05595014B934780A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-3-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4625;6:OD6zU/z9lXFtlpzi5k4Ue0XfYkAhdElohg9X/4ZkX+adAdsg/1YjxJVCdWxICg17FjSI7xhCI4vMrS57k8+NJL/zeiNDYiZl3Ry78h6IEcdNrpApuIkppNhAm9xJeZT6cMPOpF8cUuHgWzWy78LJwIEd7Ob440vKe455ghpENex5x+TYWr/TBT8LYGy3KWlNZEh5rhqAWV/wAJpvSWxBqKJXayZhTOHPa+77n/2xlTxEtemHr43Y/G5uqOdkqme+BkcbJSsivu+mv+FXQ2lHH0IW7YqWvaR34+EzqDmgkQlQokJd4aiTgXw/GdL7qIouVYcyVKdlPamMD6LQVeFtc92goWTwiPLCfU+XGHOEmhXhb3ObAwwJdoDkBwOh1Nea96tgfVsLzm1e4d7AL4XTDdcE9U3eAHaMLCTZaDwesMmBgR/U0dd1QrlRI+Ffl+2jguhpqnPv+jO75/20vUlH1g==;5:xne75+Ga7hAncfi2UxMWoiyaLT69dRrGN+6fRc2+7y4YbQRZUFjVJsNRi7FW2p/VTtSrAxxfU7/kaAqeRiqWA1jYFiyVForUd8KkWecxBs3hx9oltIt8ezwXIO7Xpb3EMJtXWRgDn97Li4OKXsWp2je3/kFWAHvPvGSJaSsN2/g=;7:KApb6utGCt0E5kgFDQS+WWbvM1LcbPjtzNlpLC2cp7VZUwmZaMHQjWlgn2mv7G+jvGZkMO7Sy8OqITGDj8QTtjTlENT2lBaMbJ3ixEQioEn27oEEWYADDG1tYk5F8e/EHKCA3jqsonRi39uDZbvjog==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8720ca33-a7e4-441e-72f1-08d660fe4a1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4625;
x-ms-traffictypediagnostic: AM0PR04MB4625:
x-microsoft-antispam-prvs: <AM0PR04MB46259447D69781A949F9622C80A00@AM0PR04MB4625.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4625;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4625;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(13464003)(3846002)(110136005)(5660300001)(105586002)(53546011)(229853002)(6506007)(6436002)(6116002)(7416002)(7736002)(316002)(2906002)(102836004)(305945005)(7696005)(74316002)(71190400001)(68736007)(76176011)(71200400001)(66066001)(54906003)(26005)(186003)(106356001)(55016002)(8936002)(14454004)(25786009)(53936002)(9686003)(478600001)(6246003)(11346002)(476003)(99286004)(81166006)(81156014)(44832011)(8676002)(4326008)(486006)(446003)(86362001)(97736004)(33656002)(256004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4625;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OPlznOGzwiDuMOxnnsA7ltX+urnly09Pe10bylDEomDrf2w92DV7CkZyXGiN831GaO5+Gj1VYBj9Wv0hBJCcPowyJQWoyX0vtqcUKQy8zq3Z8HJjuPXHYaPfRjqXsT2fqG8riW4i+ozOBwF1GTtOfhQEcNBGpu6UVbO5sHYb0qqaMidFEGK9iWMyPZzckFPT3ls5UVE78qyfwzfZta9xZX7e8dAa+XwMgsUyH/4fn1KBElwz0KoWU85WqiLT9faMum2H5t9AbInUOTgjE3eGofXktJtk96TlCrBL4OP6oq+SZNtWnlTvQ/OjdiAcVFuh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8720ca33-a7e4-441e-72f1-08d660fe4a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:24:19.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Abel Vesa
> Sent: Thursday, December 13, 2018 9:18 PM
> Subject: [PATCH 2/3] clk: imx: Build imx8mq clocks on arm64 only
>=20
> The composite-8m, frac and sccg clocks are not used by any arm32 IMX SoC,
> therefore build them only on arm64. CONFIG_ARCH_MXC is arm64 only, use
> that.

CONFIG_ARCH_MXC is not ARM64 only.

>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> 62a1882..cc95744 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -3,13 +3,11 @@
>  obj-y +=3D \
>  	clk.o \
>  	clk-busy.o \
> -	clk-composite-8m.o \
>  	clk-cpu.o \
>  	clk-composite-7ulp.o \
>  	clk-divider-gate.o \
>  	clk-fixup-div.o \
>  	clk-fixup-mux.o \
> -	clk-frac-pll.o \
>  	clk-gate-exclusive.o \
>  	clk-gate2.o \
>  	clk-pfd.o \
> @@ -17,8 +15,7 @@ obj-y +=3D \
>  	clk-pllv1.o \
>  	clk-pllv2.o \
>  	clk-pllv3.o \
> -	clk-pllv4.o \
> -	clk-sccg-pll.o
> +	clk-pllv4.o
>=20
>  obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
>  obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o @@ -36,4 +33,7 @@
> obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
>  obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
>  obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
>=20
> -obj-$(CONFIG_ARCH_MXC) +=3D clk-imx8mq.o
> +obj-$(CONFIG_ARCH_MXC) +=3D clk-imx8mq.o \
> +	clk-composite-8m.o \
> +	clk-frac-pll.o \
> +	clk-sccg-pll.o

I think you may create a CLK_IMX8MQ as I said in other mail for IMX8QXP.

Regards
Dong Aisheng
> --
> 2.7.4

