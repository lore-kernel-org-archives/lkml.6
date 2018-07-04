Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A557C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B6120878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KX8ZhmQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B6120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGDTja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:39:30 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:43392
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752607AbeGDTj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMEj4sIcw9wvqLvTB63U8p2Mv4X3xJe0PSPRsB/AsBY=;
 b=KX8ZhmQuXEiKwfp0MT2GbSxwD62brAkwjZl/pLJscMQ8wO7j9106euPSppiYH0nu1wY764pSika31pXzjgGBzTvyspt9EiIqZFTqkv54LOg3Av//ag3BBG2p+hB3tnreL6kw4wM3uVTSA+3S80SCYDXTiUPCBCChRAiz2/4jgQg=
Received: from HE1PR0502MB3753.eurprd05.prod.outlook.com (10.167.127.143) by
 HE1PR0502MB3020.eurprd05.prod.outlook.com (10.175.31.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Wed, 4 Jul 2018 19:39:24 +0000
Received: from HE1PR0502MB3753.eurprd05.prod.outlook.com
 ([fe80::34a1:d2c0:ac35:1eed]) by HE1PR0502MB3753.eurprd05.prod.outlook.com
 ([fe80::34a1:d2c0:ac35:1eed%4]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 19:39:24 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: Use 2-factor allocator calls
Thread-Topic: [PATCH] platform/mellanox: Use 2-factor allocator calls
Thread-Index: AQHUE7yHyS+e6j2cBUS2Ii2Y5rt9XaR/dYug
Date:   Wed, 4 Jul 2018 19:39:24 +0000
Message-ID: <HE1PR0502MB3753318D0C380DFEBCD6E452A2410@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <20180704172908.GA33650@beast>
In-Reply-To: <20180704172908.GA33650@beast>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3020;7:0UWwBFqnuW8mJGvGpMrgE89FfLAhK3z1Ue48Ks2fHHoeY4+OExHTR0ZF7154eMn67ROhu4g6RL0eLLHnDX1DyWIpT5hj5MiS3eEuz/zo4WgtUWVwt3rjGYGBEoVldYsP6uh6AiXsy1zy58uZ/bgeqE4dXFlLEyEJj/vNA3ud3E1TRlEo41jIVTsp5fepFLLPPDzvTngdwAOPdvRw3Z7HIiKyWNWNkWIAVsSpPqawtMorYan22OI+SKjiwuO/faik
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e71a71e7-0bac-427b-44a7-08d5e1e5d8e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3020;
x-ms-traffictypediagnostic: HE1PR0502MB3020:
x-microsoft-antispam-prvs: <HE1PR0502MB302083027B1127DA380C562DA2410@HE1PR0502MB3020.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB3020;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3020;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(13464003)(14444005)(74316002)(53936002)(110136005)(2906002)(186003)(86362001)(5660300001)(8936002)(305945005)(7736002)(9686003)(316002)(54906003)(6246003)(66066001)(256004)(4326008)(229853002)(5250100002)(33656002)(476003)(6436002)(55016002)(2900100001)(3846002)(99286004)(6116002)(478600001)(97736004)(81156014)(486006)(8676002)(81166006)(76176011)(7696005)(105586002)(11346002)(106356001)(102836004)(446003)(14454004)(68736007)(25786009)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3020;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i020Ppugfv6HXBQ0p1s6j55nk5DlcvqlVyTULu/wkcFT4I7aY9YCcnaGpvhURNdlPYDk+eAsjVP3aeJPDu+zY88zRKhflc+SNjp/u4HKchrbkSxVbRnM7icABT31jO4L2wAv6wTXGEKGkEExgwUfK5FSVlAedhIsWcDt28sVuaMGUpJwQy2eAhq4YHihvp6Dus+8PWGNZiIiVXTtjuYwbeyZ5LtC5L/+B83qbq0X0CmycO0lYT/uzVE7Lkw49Ij8lQweccyQaVaLU9mibaozc5sAIMwKSdGSEvFOiKw9dOVlpmWtKKw+0zlBIGbONVrcSbU9Eb4DqPNVzBXnWtwhETN8qJ2QDF8mb7R9vGZ9ZAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a71e7-0bac-427b-44a7-08d5e1e5d8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 19:39:24.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kees Cook [mailto:keescook@chromium.org]
> Sent: Wednesday, July 04, 2018 8:29 PM
> To: Darren Hart <dvhart@infradead.org>
> Cc: Vadim Pasternak <vadimp@mellanox.com>; Andy Shevchenko
> <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] platform/mellanox: Use 2-factor allocator calls
>=20
> As already done treewide, switch from open-coded multiplication to using =
2-
> factor allocation helpers.
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Vadim Pasternak <vadimp@mellanox.com>

> ---
>  drivers/platform/mellanox/mlxreg-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/mellanox/mlxreg-io.c
> b/drivers/platform/mellanox/mlxreg-io.c
> index c192dfe6bd65..acfaf64ffde6 100644
> --- a/drivers/platform/mellanox/mlxreg-io.c
> +++ b/drivers/platform/mellanox/mlxreg-io.c
> @@ -152,8 +152,8 @@ static int mlxreg_io_attr_init(struct mlxreg_io_priv_=
data
> *priv)  {
>  	int i;
>=20
> -	priv->group.attrs =3D devm_kzalloc(&priv->pdev->dev,
> -					 priv->pdata->counter *
> +	priv->group.attrs =3D devm_kcalloc(&priv->pdev->dev,
> +					 priv->pdata->counter,
>  					 sizeof(struct attribute *),
>  					 GFP_KERNEL);
>  	if (!priv->group.attrs)
> --
> 2.17.1
>=20
>=20
> --
> Kees Cook
> Pixel Security
