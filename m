Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D45C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B308A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="srcCaKKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAVBjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:39:49 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:27728
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfAVBjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jCjaEsMrFpFXdlfQWDK6yo191zjFRdtd0BbPrmDyII=;
 b=srcCaKKTcBLPY854WIu+EC8n1ipwwA96dKoGxjGrYuNvFsTvuuu43xBdBNN922KV6G3IhMmMgKl/mDNmmi/1nFVlzgQ1GJzUWd6J3bMRe7wRKg8x2Cn9qF6hSgPtTi5LFk1K4e3NtflaVU/MCSQEcCAcHQAfMUrTMlhUWcuYYQU=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3725.eurprd04.prod.outlook.com (52.134.15.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 01:39:44 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::6875:ea76:21be:1a58]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::6875:ea76:21be:1a58%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 01:39:44 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "dev@pschenker.ch" <dev@pschenker.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: get regulator optional
Thread-Topic: [PATCH] net: fec: get regulator optional
Thread-Index: AQHUsZnSRnswizwjwEGgd4k/7MMsmKW6g0DA
Date:   Tue, 22 Jan 2019 01:39:44 +0000
Message-ID: <VI1PR0402MB3600576A0BE62C6363F93B45FF980@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190121145847.30223-1-stefan@agner.ch>
In-Reply-To: <20190121145847.30223-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3725;6:ZWeph7Bea39JPa3mpNbf4Mfy3XN9Cp2lj+FgC8ONZhRCaWyPdFXigfimtTWt1RRHJ7jVAkki3OCIb9d5VXhMs5oKd2CzCfZxNjDzIg/x0UeN6GNRoZUEbibEdnVyTNDkAYdoeFir7GYB/j8yjAOnVdiQA+giGxmFHIFBuaQIyRCSZT3HCI/XnKg9bvBKpdDjsBe82sZUz2JIrEH3KxT6V49f1p645EVxJx2HYaauZSYoIGeamkB7oBOAWvWGIGtB9r8H4PMuib/08Rr2BZ7+N1EVuQPMhgPsCalViVqxgCum4IyauT6X8WD4GFJ0GTPOj+CW22PNZudCqh6nwrYvMnovdzsB0pkEbStRU7IA0EAq1DZBh0zNtUBqSIJGs/x/n+G9D/Vf0KOz44yUfMxcPbD9UMxA1hxV9mEI61jMiaRJQK5tEASFEqMMCzY2GoUIxISZpD0N61OYxbLLUbhe4g==;5:1PDVz2pL7HGZ8cIQb/8J5W51cYEsbZ6ITvGutEyWWLOEWelVF9FNMy6WbNgNdkp5cPIV9OldLEGKaG915FRH9x0u6t32FdxaDdwyIiaFVKe1DxerCCyJFg00KU9UOnUOOxrdN0VlwfqSDDW4B7YPtrWA/fX3iFVwqJtDWGUf/9yszM/Ky2HI3P/gaY74AEEBXHCazWt+ULII9ArG8/KJXQ==;7:1SQCp1MoCrfBqvRaTwhzrFz6wspLnOKTA6ftB1YQjLAMmFJh1P3IOkDEd2oePKb6sje1FSl5TT2goM364WP0ReguFQy+A/GHlGbqxIIMTH0GaVClAwUudwk/wg/D9Ums7Uvdq+AZ7VwebxXucrcvqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a543299e-de74-4063-d671-08d6800a7c5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3725;
x-ms-traffictypediagnostic: VI1PR0402MB3725:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR0402MB37250ACF6CAA88A6936ED786FF980@VI1PR0402MB3725.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(396003)(376002)(189003)(199004)(74316002)(14454004)(66066001)(6506007)(229853002)(8936002)(478600001)(33656002)(2906002)(2501003)(81166006)(186003)(26005)(71190400001)(71200400001)(81156014)(8676002)(9686003)(68736007)(305945005)(7736002)(76176011)(53936002)(25786009)(97736004)(256004)(14444005)(7696005)(476003)(446003)(11346002)(6246003)(4326008)(486006)(106356001)(105586002)(102836004)(55016002)(110136005)(54906003)(316002)(6436002)(86362001)(6116002)(3846002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3725;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DeHTcgd51MNLzrJ3T74mjdkiZMSKLbO1Kpo7PjQ4WS2eqB1FB/bA0w3ooayhRZeELuluPJ79iimNkSUkkOVauSr9SxJQkKZx1Is0umsr//j6v5IV+8bVZQ8zy1oxSonUk2M4DNSi9bd7bPwUVPcziZsdVFJ4YWJjtwx2N4tNW7AowpnpOb1ubF/b1fY5Lg8i8WNM+ma0Ap5xv9zJAahlpP0nkHZkyofibxDghsNgiVHlL3UBLZ/99n4rD/qa7ho1ANzOD7NY3F4G2FX73XFfHCGZBk0OzAe5KMGw+03p7jLHLP3KDg9sCwqeCxbm+UcRx0cqv+cMu/LwLzgIfjorRXjpKQZwm6wQpQ0GmrN0FMleJnktZMD+8iSs+Ku+ag2n1gaw/MskDTCgKUFSgDX3ZXoajhSNK1MjJcYle8OqIpU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a543299e-de74-4063-d671-08d6800a7c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 01:39:44.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch> Sent: Monday, January 21, 2019 10:59 P=
M
> According to the device tree binding the phy-supply property is optional.=
 Use
> the regulator_get_optional API accordingly. The code already handles NULL
> just fine.
>=20
> This gets rid of the following warning:
>   fec 2188000.ethernet: 2188000.ethernet supply phy not found, using
> dummy regulator
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Thanks.

Acked-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 6db69ba30dcd..c8315d880c8c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3479,7 +3479,7 @@ fec_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto failed_clk_ipg;
>=20
> -	fep->reg_phy =3D devm_regulator_get(&pdev->dev, "phy");
> +	fep->reg_phy =3D devm_regulator_get_optional(&pdev->dev, "phy");
>  	if (!IS_ERR(fep->reg_phy)) {
>  		ret =3D regulator_enable(fep->reg_phy);
>  		if (ret) {
> --
> 2.20.1

