Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E6FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="fRP4drKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBYNNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:13:38 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:7811 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfBYNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:13:36 -0500
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id 27/FD-22588-CF9E37C5; Mon, 25 Feb 2019 13:13:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTURjHPbt32002O07Dp6FCN/yg7a5tUBr
  1oT4kA3sliBDDrnpzqzlld5JF0Io0m2RhZbT5mlai5kyyd9MkKBMxLErNIGlUvpupGL3Q7u4q
  +/Y7z/9//ud5Dg9FqNplaorLs3M2K2uhZcGkabViDfNjhE/RtXavTLg47JUltD6MSZh/VShJe
  Hm/TLaRNDY9jjHec72TG1vqT8uMX1uid5DJUrM1LTtvn9R09kelPOcjzns/1CZ3IGeIEwVTJP
  YQ4PaOyoWDChdLoLmzJHB4i+BDcS3hREsoGdZDxfgUEoRw7EEwVPRVIggE3gRv2yb8HIaTwNH
  X6OdwvAUeXRggRDZAqataLjCJY2B6rspfV+K9MHD2m59VeDXc+VLi9yzBOnjheY0ERjgKZo83
  EOJbETDorfTnA8ZQ+7CXEHkZjHz4JRX9qXCqfUIu1jXQ88aLRKbhWr9LKnIU9FUWBepbof5Zq
  0wYDPAggo5ZdyA0DroK7gSEAQXcmvoWSLXAjfITAVMkzNxsDJg6pDBZdpIUx0mH6fKewIVoqD
  8zTIqmFwR43C65OI8Gqh7MyM6hWNei8VyLJJFXwbXqMcLl/7JQ6LrsJasQWY/i02zmTJM9izV
  bGL1Ox+j1BsagMzDx67TsESZdy+Uyhzjezui17CFeyx/OSrdkaK2cvQX5likj5/n2u+iTM7MT
  Lack9DKl08unqELSsjMOm1jelGrLtXB8J4qkKBqUk598WqiNy+Ty9pstvo38IwOloMOVu307q
  VLyOWwWb84UpeeIoTquDJcTKtKabeXUEcrmzz4TFkymXOvfiD973Yei1GFKFBQUpFLkcLYss/
  1/fRRFUIgOU2qEFIXZav/70qivCYmvieLZbKEJO/tPUjtQfP7V0om6OJrfWZMfUrOnadsw+6T
  KnZi8UPoGJa0f+NKSMbZArb8fVD3Yff5Sw7GezV4N1fs4tb274unPucnr9lWKXbXnHcUr++kN
  jnxjTXJSb9SBtra4wu4xT8lRw56D7rqCfufB2AcpQ94VY2t7GWNi13yj7enmcU3yUvXtLd9pk
  jex+jjCxrO/AfEvRKLSAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-27.tower-302.messagelabs.com!1551100412!2405967!1
X-Originating-IP: [104.47.12.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2000 invoked from network); 25 Feb 2019 13:13:32 -0000
Received: from mail-db3eur04lp2053.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.53)
  by server-27.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 13:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3kUxIGGIvKXgz7meWGJGzsenStmcpxPdEItJ7l5/4c=;
 b=fRP4drKydOf9LO/43/7u1f/DElhtEWdDsULK9jE0NeIf22xh4VU3+sMKotCgLRtPBU/KTWbf+PgLZxG3ly/kXjAQJZl3P3/8Blr6AqREgIu7nF3B9UgAJtA5rONhhBgnWK8/Xq41CbeiuoQvR2hBaIzmUUjok8N/LKSakBl45nA=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2495.EURPRD10.PROD.OUTLOOK.COM (20.177.59.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 13:13:30 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:13:30 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9062: Use struct_size() in devm_kzalloc()
Thread-Topic: [PATCH] regulator: da9062: Use struct_size() in devm_kzalloc()
Thread-Index: AQHUyxrMo5SeVuxO+EWlkadc1j8wM6XwgMfg
Date:   Mon, 25 Feb 2019 13:13:30 +0000
Message-ID: <VI1PR10MB2352218825B8BFC3D4F6C6D8FE7A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190223015451.GA24619@embeddedor>
In-Reply-To: <20190223015451.GA24619@embeddedor>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d03b020d-32d6-4d6f-4f5b-08d69b230977
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2495;
x-ms-traffictypediagnostic: VI1PR10MB2495:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2495;23:FKN/+S8r2qzxYOWbIRtgDw5dcwKv2SuaqXH04SJzh?=
 =?us-ascii?Q?1FOh9ii7lW5NlkTGdFsVEHy5CUjunVcqVj/qi4TamIG7RMliUDcWmgTSaikn?=
 =?us-ascii?Q?uGCg6okdP02OapYIaYmmHLw1mP1tmsh/BDomLM/JWOdDJRaxk221WBbuZdB2?=
 =?us-ascii?Q?hb34J0JaObhGB31yQF58uOgpJzvkLu2a7IDO9c9zngJG8XRLInVaqHBGc63H?=
 =?us-ascii?Q?6a9cI43M2Lgcn1ie1mYSPqP4WEus5vpraoypNgde3NupbIr9GTlfTXSoF2qU?=
 =?us-ascii?Q?AhlnEz+PC3OTUb/50iwGhOKUBdexc5hoel04ZNaa7YFKNMiQGKWdSZmQwdYM?=
 =?us-ascii?Q?yMMPmhD0RplMVc6YkXuSY7lbKsPGGoGBbui3XgD2uBQEF6YlpZSTscP93zPf?=
 =?us-ascii?Q?4FsHXYF9odUPzIJDl02mPl5B6QENMUIfv9K7i0Yeoj6pAfhanHlLfK7WH0d6?=
 =?us-ascii?Q?9WXVdA3rHNaOQa1/66S071RkpvNfELP7SLp/eNNK/bbsox/Ff/c3C/Uzj0JS?=
 =?us-ascii?Q?vxnOf9pkpOtRKJeRv7X7pqtWMX59ReL9tdKIAHVViE39dIDmmHPITPtzZ8qX?=
 =?us-ascii?Q?l1q1ox5mkQWRV8TrTViBKICTXa9QeUDxPXeu9Z8xxgomf3LIiSUtJ0m0qxUL?=
 =?us-ascii?Q?2bhnR8TGGHP23pm8PTSP+3GOLstq9fS49VUmsSS6rZnAFlThL80R83pyF+n9?=
 =?us-ascii?Q?zCTPvAXdU0nCRT2rkBliL6nhkf5SV1eqAiG2qPIKeLc0V9eNnJABb5ONE/Zn?=
 =?us-ascii?Q?JCRzaE9RRXNB/4HCe0G1MCBPHz/0FilF1LKo43He2Jkc6HOWNnVt7bQ/2kB8?=
 =?us-ascii?Q?21Fw/cf2h969HWfuEDAzelKGGKaWS74bZiviwjhW9wpaj/Qx2jGczMX0IeId?=
 =?us-ascii?Q?G1HMPf8PZLgDqHAtHp9sNZBmh5Avg3Z2+wsz8g5E20qCkYC975oAwiEhm+yI?=
 =?us-ascii?Q?ctncvXoL5B/Nr0dYhxaK72KaKc//KAU4Nm0dde2r9MyRCANWfuJt7DFXAbkX?=
 =?us-ascii?Q?jEe0g77wtGwl6L7lc5svjjdhyvY8Zsibheb8nENDKG1RdfRxmq8QgifXEOQ5?=
 =?us-ascii?Q?JH3m/PPh81quojo83Z4MlX4IHbRxmHztkezkjiyx/WDpFUqgPW3mfD8QLm4m?=
 =?us-ascii?Q?E5FVPT6DJeOnRFdmaxSSUVnMEV8x9fEiocBaGZMWHnPuMsqq4gfSfa/vsLmT?=
 =?us-ascii?Q?rlyh0BcW2Hbfl98YdlJ5NuiNm1F/74XBSMy?=
x-microsoft-antispam-prvs: <VI1PR10MB24950A953F750B98E25E10B6F57A0@VI1PR10MB2495.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(376002)(136003)(366004)(199004)(189003)(3846002)(81156014)(86362001)(8676002)(6116002)(305945005)(14454004)(4326008)(99286004)(6246003)(14444005)(256004)(76176011)(105586002)(106356001)(7696005)(7736002)(11346002)(25786009)(186003)(71200400001)(71190400001)(68736007)(55016002)(26005)(6436002)(476003)(8936002)(446003)(97736004)(66066001)(33656002)(5660300002)(110136005)(2906002)(478600001)(6506007)(53546011)(316002)(74316002)(53936002)(81166006)(9686003)(102836004)(229853002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2495;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cH6wQp68D9/p72oB56OPudQ/QU29LJ8pfxrLVjNkRrahfy3PhitqD6hySto3gln39dRI+UyDr9i/VmQFZGrz4llR2YKaT7RZhYai0RZVdvJXl4qM173HHtvGFxg5shhFMr6COhhuRBwluxOR6uETxYvc1+/yozS4KrKsVjebSGINT/k5BvlOZPVJIxrM7h/VjF52Wc8LQeuF7lWmL7dN1mlZbuBk1vc/vTo57JNba3idVX3+BcY2qw3vSTEY8vXHnsR43JGWH9HxMd+m0nnUX5O+V7jFlp/Ank583H4ERiyh+ZLwNcTyuMOKe6yS+cf4a146per2+mgQZpQRXtPMQENffJpbfzqS4no0cPJyOAd6V/EXszttk5UkQKUNywGX94MfwjtkD+olC12pnWvK46bT9eJ2HmyobLEQlly67Gg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b020d-32d6-4d6f-4f5b-08d69b230977
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:13:30.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 23 February 2019 01:55, Gustavo A. R. Silva wrote:

> Subject: [PATCH] regulator: da9062: Use struct_size() in devm_kzalloc()
>=20
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>=20
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
> instance =3D alloc(size, GFP_KERNEL)
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Thanks,

Regards,
Steve

>=20
> instance =3D alloc(struct_size(instance, entry, count), GFP_KERNEL)
>=20
> Notice that, in this case, variable size is not necessary, hence it is
> removed.
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/regulator/da9062-regulator.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index 4c5d6ad853f8..b064d8a19d4c 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -992,7 +992,6 @@ static int da9062_regulator_probe(struct platform_dev=
ice
> *pdev)
>  	struct regulator_config config =3D { };
>  	const struct da9062_regulator_info *rinfo;
>  	int irq, n, ret;
> -	size_t size;
>  	int max_regulators;
>=20
>  	switch (chip->chip_type) {
> @@ -1010,9 +1009,8 @@ static int da9062_regulator_probe(struct
> platform_device *pdev)
>  	}
>=20
>  	/* Allocate memory required by usable regulators */
> -	size =3D sizeof(struct da9062_regulators) +
> -		max_regulators * sizeof(struct da9062_regulator);
> -	regulators =3D devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	regulators =3D devm_kzalloc(&pdev->dev, struct_size(regulators, regulat=
or,
> +				  max_regulators), GFP_KERNEL);
>  	if (!regulators)
>  		return -ENOMEM;
>=20
> --
> 2.20.1

