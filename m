Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F404C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="mI8ChbQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfBSOFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:05:17 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:33170 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbfBSOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:05:16 -0500
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id C3/AE-17148-91D0C6C5; Tue, 19 Feb 2019 14:05:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfXfOjkfdkddZ+LSyD6OCrLPcgpg
  fAisCvwRBRRGmnbnTNjybdjZLo8AQNQ27QNfVskyFVlSadDHJ0oryQmZCllgNV6B5y7IQJDtn
  Z1p9+z/P7/8+l5eHJrTNlI7m8z286OIEPRVN2lchE7uAEdKTh7rizU8vThLm04EgZf7Zc0Rlf
  tN4kUol0x54+yPTSqb2pdX7y6i07/WLN5M71Q6XJSd/t9oerK0hcyej8kcnmiILUR1djqJpEt
  8ioP1LDSUHWnxMBcdv15BK0IegudoXWY6iaAob4dLwGJL1PLwByhuLQy8I3Ibg8+AjlQzicTZ
  4H/klQEsmASq71YrfBKcCw6E6JF4KM77XoTyDd8GLu5dCdi02Q9F0qpyOwinw6c5EyIJwIvw4
  fJ2QNYET4H2wMtQJMIbqpleEoufD4MDvsD8TSptHIpX8Suh8G0SK1kNtr1et6ETorjwazm+CJ
  729SF4F8HsEN0efhR8nwbHxKVIBJQxUdFQgeVCQ9qo7qVE8i6Cv/SyheNrUMHxjKtRBi7Ng3N
  cZLrQY/BWBcKEuAjpaO0hlnZVw+eEEdQIt9/6znfcfpOgVUHvlK+ENfVgcvDwfJC8j0o9SLKL
  DZvc4OYfAGpOTWaNxNWtiTatTDNwBljPweWwW7/KInEQN3H63wV3gzBKsBhfvqUfSMVn3qsbu
  o4+ltha0gFbp5zN7kJCujbXkWAvsnNueKeYJvLsFLaJpPTBdMRKLE3kbn7/HIUgXOYuB1ujnM
  QMyZty5nNPtsCmoDbH046qAj9CSrhwXr0tgkGzCssme55orMXvX3ShRF8+giIgIrSaXF50Oz/
  98CCXQSB/PtMhVNA6XZ67TkDSEShrCO5MtD+Hh/iJdIbrJ6vgtGb/K3llba8RbPR+YQc3vM+P
  b+q5VZTQMoAvaFfemYwKfuvfbzq0RnF9iowcbuop2Xc3rf0PGNdqTKvFIseXc8Hrrg9yifYXp
  q9aacIXRN3TqCr/umxiz/uDjZRuvbz25/TN1aLlldMfCphPNMf3VS9Q9tRvu9vlTLUnbn+tJt
  50zJhGim/sD+Vxh2tIDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-19.tower-229.messagelabs.com!1550585112!1456116!1
X-Originating-IP: [104.47.1.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3000 invoked from network); 19 Feb 2019 14:05:13 -0000
Received: from mail-ve1eur01lp2050.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.50)
  by server-19.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 19 Feb 2019 14:05:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI6diDzk/Ala8BAfiJVha+W1cVxP4DV87r2I9hzX0V8=;
 b=mI8ChbQb+dZpy5ktHOO1TKbJqEz1os8akgvg08Q1tLtDko9QRaeXTHMNiJAAohvNqXUuMFYm/0m49KBLOVx7Z1zh+K4Co8JBjo7prT7DU056Ygd4D52YlFewYuf+FHypfkdnAYUy8NbI2EO/Xb+036HzabCVTBRrIsZNpEOa1Wc=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0589.EURPRD10.PROD.OUTLOOK.COM (10.167.202.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 14:05:11 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 14:05:11 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] regulator: da9062: Select maximum current in specific
 range for set_current_limit
Thread-Topic: [PATCH 1/2] regulator: da9062: Select maximum current in
 specific range for set_current_limit
Thread-Index: AQHUyFd7tgF0qu31WUurAWMyYySjE6XnJZcw
Date:   Tue, 19 Feb 2019 14:05:11 +0000
Message-ID: <VI1PR10MB235208241DECD3156E62EFCDFE7C0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190219133101.20892-1-axel.lin@ingics.com>
In-Reply-To: <20190219133101.20892-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e96b4e0-8aa2-4d2f-96f8-08d696734398
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0589;
x-ms-traffictypediagnostic: VI1PR10MB0589:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB0589;23:8ZxGyd/e3oRHLX84gC/kEpyhgD1OT//x8me1Wq/yx?=
 =?us-ascii?Q?ygZ8T0wgfrwFxc5B/fa+D5gm+96o9NDdWhsocVEFv21vK8fTyEyg0mPSVDNc?=
 =?us-ascii?Q?uaroqjazq862jFoKsMfPLXaFCtSLKB0h2p0NAd9/T5iw2rqSXZ5nMzaBLMQT?=
 =?us-ascii?Q?7CcdnnjO4noo+UB9ZsrSahgScvkcFMvQxl3eddSbjBDc0X3OgDvLjX1lNY2C?=
 =?us-ascii?Q?sER7EL8D9LeAAVYR7L86cbQTgotGRoIFa1i5q1TJecJ9j1p1Ci47o5qdghqN?=
 =?us-ascii?Q?CnWwM+/zeSa/T5LyW7SDxj4vwSY8J6X3RBJoYJrENZKlvXsegj2gBPQj6z/D?=
 =?us-ascii?Q?3246T+6ZQR26jzefB7OY6TLotbhTnTlaom08eBzINmoK+Ad5oFQi3jdMqKDB?=
 =?us-ascii?Q?1Dvht4aMU1GsdGnC4UUhqDg5y/irskS/kgN1jU+MG4XyThPJyunVVImH9SjA?=
 =?us-ascii?Q?VpYt5a5//YTEp58wU7GEeMhdQpq1J0L81uK6bWJaZskdXlO9dydvqhwjyysA?=
 =?us-ascii?Q?LWXFT4gvzQiIVjex+qVKCfo4uhzGxpdUUgjgJAx+IaCcTCEmmE2h3TD3dt4c?=
 =?us-ascii?Q?734NOeJ6gLArJ/HJkc4k4EFw3dH43XOdp4aM+L3eZe3X8C1vudQRGty5v2BR?=
 =?us-ascii?Q?QWvraEmZ2+ZRMu9Jl60XyHZOgDDMkEbMOm5FYUwJKNrN51yR3Vs8BKm4Zg4r?=
 =?us-ascii?Q?Ri5H9fTUIU2lfXRALX/OTbMnsizMZubBrOr+GTlm/JkXHb27qsL97ihUdT+I?=
 =?us-ascii?Q?KiISnx74xnNSm3S/7dsRcbTOxnur0i6WoZBJ4Aef5W39/bVr/VLlSXTVa4//?=
 =?us-ascii?Q?8VRN0T4Oggl6/kchYv0p2PfdfYRuWhM92KaxXGZ+iqQ8OP1cKoe1oAES2sNp?=
 =?us-ascii?Q?im18Hl4NSDML/V0EQcmehOGg0moEStdbroQjTnyF4a1QR+2UDmsi8zuuuHcI?=
 =?us-ascii?Q?WW4BfJkZ2m1aFYRn+RJPEyteOiOM4wTUJaelv67aaNW873WQaZfdXdrITI/v?=
 =?us-ascii?Q?5LFXjim925K5rHLCgu7t/NRzQ7HQ2R0gl3nxJG5wYD2JR4UHq58VVq+7TJHb?=
 =?us-ascii?Q?1XmClVD50PeNF/JETXRGInUwZEPxK9C8OxSdBK/J/h/mlWDZzhiWZhmMC1Ep?=
 =?us-ascii?Q?gqVeLfrgBM/IoegDxN3QQaEjD8GAqydRGQe8DNMkVPp7wdEZZHlNDhFWxv46?=
 =?us-ascii?Q?fV+EKRQ9iz9tnx1ds3WbD05e5sXtK18lU/pidoadHGfJjlFmrtaWznV4Q=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB0589CB6D94644353C73A7B32F57C0@VI1PR10MB0589.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39850400004)(136003)(376002)(199004)(189003)(66066001)(68736007)(71200400001)(4326008)(186003)(71190400001)(6246003)(11346002)(2906002)(486006)(476003)(256004)(446003)(25786009)(14444005)(6116002)(3846002)(478600001)(14454004)(53546011)(33656002)(99286004)(53936002)(86362001)(7696005)(76176011)(74316002)(102836004)(26005)(6506007)(8676002)(81166006)(105586002)(5660300002)(8936002)(81156014)(106356001)(54906003)(110136005)(316002)(229853002)(97736004)(305945005)(9686003)(7736002)(55016002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0589;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TdLZDYe9stMtmW5UR7dD8mNLarEMiebdpKTpnvxZOIxr9xFkbESWzL5hv8aA6WxwXMxS3AA8+o7JFEC7gGzbIHA3B/6jnS+CYiYorVkKCpWceQBDfnFMEK6LhRLV6oLWKkUvLWWNfdi3pu5K9j255th0giE2kkPtD2SIwfvP813mTvHKMfg8oLQ/gqHvVJwpasKYGKoTQks6Hf2kshu0cQ5B/Qau/nNZa7132U1qXNDnca0ixcBk0Y098TOq/9m/53I9BHJxPmez5jPoNQrCw/qhZgOpdn1MrbA/4As+YG5sPNDygs8yF8F/r5seATFLLiyrAHUIakTTp3u97oDbotOBEXFrA3ZNnbI3qhOxURaWYaJJxEo0DtSnXtIgNbNXs5tk2O6tD8XWHNQxEpMvITIUFX9akPJt6OybxKHHxRk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e96b4e0-8aa2-4d2f-96f8-08d696734398
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 14:05:11.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 19 February 2019 13:31, Axel Lin wrote:

> To: Mark Brown <broonie@kernel.org>
> Subject: [PATCH 1/2] regulator: da9062: Select maximum current in specifi=
c range for set_current_limit
>=20
> Selecting the minimal value is only true for voltage regulators.
> For current regulators the maximum in the given range should be
> selected instead.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/da9062-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index d06e9600fa18..4c5d6ad853f8 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -126,7 +126,7 @@ static int da9062_set_current_limit(struct regulator_=
dev
> *rdev,
>  	const struct da9062_regulator_info *rinfo =3D regl->info;
>  	int n, tval;
>=20
> -	for (n =3D 0; n < rinfo->n_current_limits; n++) {
> +	for (n =3D rinfo->n_current_limits - 1; n >=3D 0; n--) {
>  		tval =3D rinfo->current_limits[n];
>  		if (tval >=3D min_ua && tval <=3D max_ua)
>  			return regmap_field_write(regl->ilimit, n);
> --
> 2.17.1

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Thanks and regards,
Steve


