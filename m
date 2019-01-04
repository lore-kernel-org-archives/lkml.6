Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC8C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D3E2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CM3i4YhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfADDWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:22:37 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:18816
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfADDWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+mUXokKDo5ZZUFtmW/QNBioNesw1sDHe0LZaOd86mg=;
 b=CM3i4YhLLNJ9sCT45bpHN8nPWOAXIlfix5MIOS/ZH6A43ELA5Z8E8I2rGJUkyLAjbmJQZJ5nqz0SSFQC/CYDh4iCE5sHVRylCjlJi05gQAkPXdzuswFdIQztca6Vez0lqNkNrduwCb8R7W2eyfj6va85B24V/U3kDB5n+60MgBQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5457.eurprd04.prod.outlook.com (20.178.115.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 4 Jan 2019 03:22:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 03:22:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: RE: [PATCH] clk: imx: Remove Kconfig duplicate include
Thread-Topic: [PATCH] clk: imx: Remove Kconfig duplicate include
Thread-Index: AQHUo4WH33o9lH+uMEu23HleMCSa5aWeci9w
Date:   Fri, 4 Jan 2019 03:22:33 +0000
Message-ID: <AM0PR04MB4211D60709FC53F8058B043E808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1546534688-17842-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1546534688-17842-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5457;6:wL0MMjiRVYrpvlbjVM94RPXiToR2WQrLc+cx9rO1aL9o6Xd3z3y6sHfvXnnfPvdmqxd65glSsKUFNFYOXTzgzRT+3beszoDpEi+BLucq4rXOhUaB+iXdPXGtuRy7NYz+17Q5CWV4t/I9Y2T9e6kshkR44ZickA+Cb0nEemMGsPHPKrjI+o0Mf8Hdf41r0WRW2nNIgMZVkIwpO+hqZGgQbUosKt30kYNNeBped1H+wSK73LDkfxPcu+UC6uR9NRrOJWyCvxB+0+Ngucu8Ftockvpj0CACCVl/+qJR+1ECOcULpm6aw7GDHi6DKAAreY0/Phs38AQQy2OBQmgoKOKAV+R2saQSTEjDUfwLLBLR6jkTY0DD3Wx/XIt0FozimIq9hhjLVVDn9wpo0OISNLMHN2IKFi1dgV7dgfDQKvQoauBPF9NCoCXjifEEhW6tOkvKVrqFVTvzzTaTeW6+lHE9RQ==;5:eVbNNGj95C7USKeWG2La2CFTArb/JGLAPBPj/co7pU/I5jYEPwRY+99Naxpfd/AVj4dEk+v1UWS0Uf8cVDSR7ydvsFRbJzwZVP2dF+JsnE3Y5H0NG8TGZ0X+r4+BV/9cT3iAC5wQ5z5foHKB1BLw7j8FbSyQ2rnMf6c5JLXUjBsa2gXGxxaCGQzaDSfkyGciCbS7ep8/zjFNNQcvoym2VQ==;7:OoRbFS5ssLVzHQH25VkaTeXWcQwqfPDS3xTujO6tKOl7HbFXHeRAof0+S3EHu78pyi4yWLXW6isRuWWcGGmKt7+xiIUC7LywaYFSzh5emOoqfQ+kW6TUasChBl7iQmXFUel/iIiTwGWTl0bz9+eK7g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b48b57bd-a099-4b56-fece-08d671f3de15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5457;
x-ms-traffictypediagnostic: AM0PR04MB5457:
x-microsoft-antispam-prvs: <AM0PR04MB5457D4BE3A966D8586B2EEC4808E0@AM0PR04MB5457.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5457;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5457;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(476003)(11346002)(44832011)(86362001)(575784001)(2906002)(486006)(316002)(74316002)(14454004)(106356001)(105586002)(110136005)(54906003)(33656002)(53546011)(6506007)(68736007)(7696005)(76176011)(66066001)(6436002)(3846002)(8936002)(229853002)(186003)(81166006)(102836004)(26005)(55016002)(99286004)(6246003)(25786009)(81156014)(4326008)(71200400001)(14444005)(256004)(478600001)(71190400001)(9686003)(53936002)(7736002)(305945005)(97736004)(8676002)(5660300001)(6116002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5457;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y9rDxHdN5s7JokQfvwCy61/6efihEYdlQo5dZKvKxTqWkH09+J3Fw9LCqQW4ASgAq1nXmZxHAPz0MnNnZocadThAYZMVv4DW5ijiIG3rotiL+4w/Ih+WO9NsnBkqGnNu88sLZs7B5tCp3suUwlCl7ITWFoUFEknBdcqagjfiDWhMnZNFkCON7nRdqzroIsp3SrwXZqJkXk8GCx+0x5Flm7YYuocffeg5DaERVySu04LzIq92Ou6MExV4cD2GEBVfA7CuicQ5yevAxKlWH3qn2f36cpEO1qwrIsWh0nNk0cf8FHqCoryhx82VzQfWr49K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48b57bd-a099-4b56-fece-08d671f3de15
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 03:22:33.5338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Friday, January 4, 2019 12:58 AM
> Subject: [PATCH] clk: imx: Remove Kconfig duplicate include
>=20
> Commit d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver
> CLK_IMX8MQ dependant") introduced this dupplicate (and wrongfuly
> ordered).
>=20
> Fixes: d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver
> CLK_IMX8MQ dependant")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/clk/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index e5b2fe8..d2f=
0bb5
> 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -293,7 +293,6 @@ config COMMON_CLK_BD718XX  source
> "drivers/clk/actions/Kconfig"
>  source "drivers/clk/bcm/Kconfig"
>  source "drivers/clk/hisilicon/Kconfig"
> -source "drivers/clk/imx/Kconfig"
>  source "drivers/clk/imgtec/Kconfig"
>  source "drivers/clk/imx/Kconfig"
>  source "drivers/clk/ingenic/Kconfig"
> --
> 2.7.4

