Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3602089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OuFr5Bwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3602089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeIZNzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:55:02 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:46160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbeIZNzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO96D1idoO1AfmX//S20xDtJTCIOTV7RXRLgbsw4jt4=;
 b=OuFr5BwyxBzjLNBL31x1TulvhT0MyPyAggvgHOkErNUnZJ/gmR0ymeJR7PaC4uLxBm/DNeIp8U7O1nEqVi87i0oRgTFiHteSe8sajks57dL3Gl6A8h+j1i0J6EDyjhJmVS18PJSadH9lBImOUu3jYPgwkKRvRScf5MEtfrZCVC4=
Received: from DB5PR05MB1640.eurprd05.prod.outlook.com (10.165.6.142) by
 DB5PR05MB1653.eurprd05.prod.outlook.com (10.165.6.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 26 Sep 2018 07:43:23 +0000
Received: from DB5PR05MB1640.eurprd05.prod.outlook.com
 ([fe80::31ed:3943:eeb1:d04d]) by DB5PR05MB1640.eurprd05.prod.outlook.com
 ([fe80::31ed:3943:eeb1:d04d%3]) with mapi id 15.20.1143.017; Wed, 26 Sep 2018
 07:43:22 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: mlx-platform: Properly use
 mlxplat_mlxcpld_msn201x_items
Thread-Topic: [PATCH] platform/x86: mlx-platform: Properly use
 mlxplat_mlxcpld_msn201x_items
Thread-Index: AQHUVVjF72pKkeGH60en+Bip/zo/eaUCLjig
Date:   Wed, 26 Sep 2018 07:43:22 +0000
Message-ID: <DB5PR05MB1640104C32067C3BE43CA529A2150@DB5PR05MB1640.eurprd05.prod.outlook.com>
References: <20180926052115.21223-1-natechancellor@gmail.com>
In-Reply-To: <20180926052115.21223-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR05MB1653;6:GADroHjGrieyIJrbvfoEY1fDMl9ghO/dkdocsOblDRyuzp3h+1khyLRF3rt+REjo/TNvey3IDA1eU6x5nsmWhKlznXqkI8pGasYNs2VN/dcBjbJRo1HWlkvDzD4I6OCaQsA53BM+x6XGzLxGZI39qmmjA4iCO3j82oVxJsEHBtpn0o+Sl1yKOGfe13et/Z44jmZgKeOTKc1+RNjPvfpk1XRieORlP+GW8ibOa5yZJaRChZkEkZw38l8d9S8Kbzy7oL8vGAs/kCn2ECxsErBnd43P6V1A2SYGjkLvLl8iaWA0zmKqQ3wlgxShOl9h9aO0LQLyx0e8xZlRbHVEo5HCKCGPrwP5+BpOMnaRUFoOWCIdxjVCtqSOCqdNLf9WLtST4SlAwr0xp/e6GY5WZ0FI2ACqBDh3/YhCpmvXBzoBEOEOvnHuEvsz2V7BunFjsMvUJRp2gfAqI8mMxCCigdIC3A==;5:RQZhLkFH8g0LOqYnr4+QVhTlAokGKh3IBZhOQLVChGQndvj49Qmlvar6dsnsBvCSwH3FyCA/0vCgM0W6MTnMUOlwDXFpi4ObCiUb5IVEbeZ4KNzCjsJR0JbSDV0bRJzMeg/+ZmbhyS07jktmFg1CcwYaSC2dc/L+Kgjrcu4sQZo=;7:N21pehv6w4A/hzVYqV50/2TyFtEuSak/28yTiBlYfmzXOzd8ITsom5I8WfYs9lgiaAtiVAjxJIJiAHBroeiDm2Zd17gtwuB6M6TC2QUojW8AU4iJu37kXloBuOQtLgW4ubPZXkSnFdeJ2KTo8/H1BRKQzrzdMgV92Bbw0VYZloJH1zgqchs7rUPSR5+ez1J+494La65L0YLgYbqj9uvbvqKNFtvYqvCKov550YFvCItf9ay7OmeyQCC0DTKTZA/Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 79b9d926-cccc-47de-c360-08d62383bc7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR05MB1653;
x-ms-traffictypediagnostic: DB5PR05MB1653:
x-microsoft-antispam-prvs: <DB5PR05MB1653512CD05FC8818B5E208BA2150@DB5PR05MB1653.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(166708455590820)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DB5PR05MB1653;BCL:0;PCL:0;RULEID:;SRVR:DB5PR05MB1653;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(13464003)(199004)(189003)(6306002)(9686003)(53936002)(486006)(5250100002)(76176011)(7696005)(55016002)(8936002)(316002)(86362001)(66066001)(34290500001)(74316002)(7736002)(186003)(102836004)(305945005)(6506007)(476003)(446003)(53546011)(25786009)(26005)(11346002)(71200400001)(71190400001)(3846002)(99286004)(6116002)(110136005)(106356001)(105586002)(54906003)(4326008)(2906002)(81166006)(6246003)(81156014)(229853002)(6436002)(8676002)(2900100001)(478600001)(15760500003)(14454004)(14444005)(966005)(256004)(5660300001)(33656002)(97736004)(68736007)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR05MB1653;H:DB5PR05MB1640.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jUQeJ1LVZ/OUqj9yVK90JulV6u/+8mQiVuIPPgLoNSQ3/9pKbhh5Xvo1QIzxZSql4SQb+xwmUT5o467oXbOSJYRLhR0mu1cikkY0yWdhtP8MuSd7SM0FQWcJUa7eOL9Qi7hVFWUVcPPAujZeSqK4kp6oha+QS+JYvUYiRq+ucVhWlNAfNiqclgM46mjYCYuwwJD9D4hdbMClajo/bwST7w4ooi6cimB4lUfiJZx5+cGu+gNn+wUpS88Q4TQHLzfh9Jn/MhTMU5igA6jfkbpzeXE9I2Lz8bYg84h2RLkv3m/OyaJNfSvefGCvie6ahaH0h/doMnJDzqW/qd8kgtwGfimmGHVXnYNfBN5CJ1lnTRg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b9d926-cccc-47de-c360-08d62383bc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 07:43:22.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR05MB1653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Wednesday, September 26, 2018 8:21 AM
> To: Vadim Pasternak <vadimp@mellanox.com>; Darren Hart
> <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Na=
than
> Chancellor <natechancellor@gmail.com>
> Subject: [PATCH] platform/x86: mlx-platform: Properly use
> mlxplat_mlxcpld_msn201x_items
>=20
> Clang warns that mlxplat_mlxcpld_msn201x_items is not going to be emitted=
 in
> the final assembly because it's only used in ARRAY_SIZE right now, which =
is a
> compile time evaluation since the array's size is known.
>=20
> drivers/platform/x86/mlx-platform.c:555:32: warning: variable
> 'mlxplat_mlxcpld_msn201x_items' is not needed and will not be emitted [-
> Wunneeded-internal-declaration] static struct mlxreg_core_item
> mlxplat_mlxcpld_msn201x_items[] =3D {
>                                ^
> 1 warning generated.
>=20
> It appears this was a copy and paste mistake from when this item was firs=
t
> added. Use the definition in mlxplat_mlxcpld_msn201x_data so that Clang n=
o
> longer warns.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/141
> Fixes: a49a41482f61 ("platform/x86: mlx-platform: Add support for new
> msn201x system type")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Acked-by: Vadim Pasternak <vadimp@mellanox.com>

>  drivers/platform/x86/mlx-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/m=
lx-
> platform.c
> index d89936c93ba0..c2c3a1a19879 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -575,7 +575,7 @@ static struct mlxreg_core_item
> mlxplat_mlxcpld_msn201x_items[] =3D {
>=20
>  static
>  struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data =
=3D {
> -	.items =3D mlxplat_mlxcpld_msn21xx_items,
> +	.items =3D mlxplat_mlxcpld_msn201x_items,
>  	.counter =3D ARRAY_SIZE(mlxplat_mlxcpld_msn201x_items),
>  	.cell =3D MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
>  	.mask =3D MLXPLAT_CPLD_AGGR_MASK_DEF,
> --
> 2.19.0

