Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582D7C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FABA20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EJyGyNsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBJTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:05:09 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:48384
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfBJTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVaqKF5ruEJqcImjKYCUmLUHS3vhDUqSkvF6Yr3HUWM=;
 b=EJyGyNsZtsZ97N68/gbWz1oQ2CAKmK/wWvKrg4pBjEMhGSZr1mgO4hbSvzoIR2TtYJ/mq/nnRF5TzCRXMpEJOZOxrVPrX9XXmbOqsxnT9blXyX0ftXWm0DuiK84jJliBqVGcHT1woDpe2e+6UFNOsuLIhnrLAb4tCxfJnjEp10M=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6229.eurprd05.prod.outlook.com (20.178.92.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Sun, 10 Feb 2019 19:05:04 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Sun, 10 Feb 2019
 19:05:04 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next v2 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Topic: [PATCH net-next v2 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Index: AQHUwWmHaAhTrOwTokiOiWycLCbv6aXZZDiA
Date:   Sun, 10 Feb 2019 19:05:04 +0000
Message-ID: <20190210190501.GA26726@splinter>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
 <20190210175105.31629-7-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-7-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0143.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::48) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB6229;6:fPyIz65fT6SyoZBr/iZxGd5BgpDrt8NJeBULFPMwRYPJq2n9AyOwNUEaSckM59q6oIP7+H5esPcDUvPGEumD5nd9AGXRKS9Yq4U2CK1zS6ZaSQIppKu4EPKNWvsw5FiE0uSSNd2EcT08HfqHCDQrixtTps89l/QNGNCwjOkTCHh7GcUlk3oK0OOZYvOUDTJDLdeN3DsQOVBs8H5e4XtPqXtdFeo+1lbRr19363g4MzOxsBPSIEv7xQiwNGDYBy0avzN1RHAP0esW5BQ3MYyKIYEqGPFJvyAQA8KiX1xH9zTYD3nQK17VPAnRdcx7CqtBa+Ht3NtRL7DKgRRQxs6CJaQ7S1bcCjnKOgl0rSHXgw49XnOkfpQ5pzSj2rBVn0FXpYDLkD+sMdR3OL4c3ATIKr6uS54zh3XF1Eke7dJgVjCJA4LMDNY80nmaD1D4ASfDoDA6KLI+ARnG8LZUm6c0kg==;5:CKSxdFiuAzmJ/3LAtB0WxJcSWv+WzcFuWS2cCvb40F3xb2G6dhxMatuRQsk436ASfMvdoszP7ahvUlwRW72+nBlvlhaLPRhuVT/AKZi36+cKih2IdAEzJ4c0yRODmqIwEkop4bQJlUnECMmh+PAXqLerzqu2mwfM/YuaB+WY+Me3fxY4ZpQ7bKzzYEH5hGC7Zl7MYdAZwzm74aUbsmBTlw==;7:ro/sSV8+G8TdVZuRXMIIRq0xpL2FjvBmYM52btj9Twr4XJiRBpz1FeQmk55/WT64xzTcWbRZ13cahHeCNG1DZGpaKnCykmr+vRznFpEngubH6u8CrR5tpn5+FYV4MUbAJ5F/Z4wKtRELmuKIo2BZpQ==
x-ms-office365-filtering-correlation-id: 37191140-d83b-4011-16d6-08d68f8aaa1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6229;
x-ms-traffictypediagnostic: AM6PR05MB6229:
x-microsoft-antispam-prvs: <AM6PR05MB6229CF679722AE9CF2D5FBCFBF6B0@AM6PR05MB6229.eurprd05.prod.outlook.com>
x-forefront-prvs: 09443CAA7E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(54906003)(6512007)(1076003)(6436002)(9686003)(14454004)(53936002)(6246003)(68736007)(6116002)(4326008)(229853002)(66066001)(3846002)(6916009)(256004)(316002)(6486002)(478600001)(99286004)(14444005)(25786009)(7736002)(105586002)(26005)(305945005)(486006)(186003)(106356001)(52116002)(33716001)(476003)(8676002)(33896004)(33656002)(11346002)(8936002)(97736004)(81166006)(81156014)(102836004)(446003)(71200400001)(86362001)(76176011)(71190400001)(6506007)(386003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6229;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q9SapPk3mTEaZXrlY11MVyVWI885vM28sSOHDPgqoup6+e/3H1ZSmOqLOe4hJBk46nBRgSGY5chRGZe2vVJ6cNej1dlmHpIIzsNuElnA5VpyvEnDAx0IV8drSc92OySugsMs/jsvyOZAUHraRHG7jkokxsv1seyYJ74X77xVTzkxVHCN0HP9+s4Bfft3GZrYvNgqyri1bJTrgRQGvVFSumUW/+pVzix2rdGmYYhKlWRv8elH0AbXG0MQpSuSAvGDdn8weV18ii+3B391wS7rwz7pvhTpJvsPfc6dXQGFWV81Z4vQZXURTbiF38N9oFDNvYDVodeqJ0mWBhUnx7xFgU67atEV9Y2dkJGxH6CP8C3YYkWy6QdS6AXgDq9YLPqa2pNzLMsTG6DWq2SX5arwAvEcpw76kac6ZcGZqjgqJTU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8504F4294E37B45B2118EBF49BE8AEB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37191140-d83b-4011-16d6-08d68f8aaa1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2019 19:05:03.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:50:55AM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to checking the
> bridge port flags during the prepare phase of the
> switchdev_port_attr_set(), we can move straight to trying to set the
> desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>=20
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index db9e8ab96d48..939f300522c5 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  {
>  	struct switchdev_attr attr =3D {
>  		.orig_dev =3D p->dev,
> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> +		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
> +		.flags =3D SWITCHDEV_F_DEFER,

How does this work? You defer the operation, so the driver cannot veto
it. This is why we have SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
which is not deferred.

> +		.u.brport_flags =3D flags,
>  	};
>  	int err;
> =20
>  	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
>  		return 0;
> =20
> -	err =3D switchdev_port_attr_get(p->dev, &attr);
> -	if (err =3D=3D -EOPNOTSUPP)
> -		return 0;
> -	if (err)
> -		return err;
> -
> -	/* Check if specific bridge flag attribute offload is supported */
> -	if (!(attr.u.brport_flags_support & mask)) {
> -		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
> -			(unsigned int)p->port_no, p->dev->name);
> -		return -EOPNOTSUPP;
> -	}
> -
> -	attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
> -	attr.flags =3D SWITCHDEV_F_DEFER;
> -	attr.u.brport_flags =3D flags;
>  	err =3D switchdev_port_attr_set(p->dev, &attr);
>  	if (err) {
>  		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
> --=20
> 2.19.1
>=20
