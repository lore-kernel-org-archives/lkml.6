Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E31222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="AAe61vEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405663AbfBNLUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:20:11 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:38000
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730191AbfBNLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbzDrE30QcsjBKK5pVdW8OvspW+LUH0Ej/TrJYAhHq0=;
 b=AAe61vEZ7vXFZcrMBieoZV9xWyJPObgLHnNU9//8rNmoBPh0lg0VbAfmN4RYwloxDTB1EWdRRVXbuSR8XNMeVGhnYMaIT7WESzvGMDwaAcCGDBwRY11PH0KMHhCrYLk0moeQstc9HAQ/kKGHGx2FUA88XkkBwYALvRYbKLPd36A=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6376.eurprd05.prod.outlook.com (20.179.5.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 11:20:07 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:20:07 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next 7/9] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Topic: [PATCH net-next 7/9] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Index: AQHUw+iLO1HVI2mp4U2l6bBnmXFAs6XfJqMA
Date:   Thu, 14 Feb 2019 11:20:07 +0000
Message-ID: <20190214112002.GA8698@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-8-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-8-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ffe17f0-3f89-4f95-2d42-08d6926e5fa5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6376;
x-ms-traffictypediagnostic: AM6PR05MB6376:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6376;23:JUNFDGNjV/yuRgbn92Pcc6MzeCu97iXmigNCUqjEj?=
 =?us-ascii?Q?TszpbVs0KiX4RM6zfmIzdWq/tNGJdBKVxRga3PblUI4VCrCm0YZ7J2H6m4XX?=
 =?us-ascii?Q?Cm+lpfPDbm20e08IHoXjdJAdfFg9sqwtlydus0TSYvNIOK1L6ABhh5mnTe4h?=
 =?us-ascii?Q?y5SbgiB3dV8GhNLUN0L+tGASZkpqcO1Fj2cIy2oGNhqErSU7grrNX97aZnB1?=
 =?us-ascii?Q?B1cT4ML5PWmJL/BF7HvbDylzmnJx9Xm1XX2jc7FfnmNOiJIWjclPyTafAkvY?=
 =?us-ascii?Q?ZcEG2ukmt2OtfIxoUhisfGe1H0+4PdV8DwJDK3Y2HKgN47x2AFAPexZLnxIp?=
 =?us-ascii?Q?GWDK08TIvXtmry5/WK4vSR6opPr46wtzuzivYWCrX71UwmTSp45yGkxmk5Wb?=
 =?us-ascii?Q?KUsmtEEylBExZc9PcxsgrSUp0UxF/m16i75i7BRb687OUTwcqJxEBgrZ4iE/?=
 =?us-ascii?Q?w2BdoXCAqAqwurgxyPBtHcuLkxNggAQRjKvUMAWt3l4VB+iHR2bMV6NINvrl?=
 =?us-ascii?Q?TEkURmToEY2WudNlfA692yN9CSwjPLGnAcywBUDljoPY6np9eYyJxXtT4Q5W?=
 =?us-ascii?Q?I4EA2jHD6sLYflcUQ2fv3twNk5MlMhfME0CB9+HXR2VIpDiCV6PdC/BWbP7C?=
 =?us-ascii?Q?l2CL3uDCilxmbkLhZI/luUntF/6cGQadIBPSfEUrJr69M9MkJdI/LGh7PPJN?=
 =?us-ascii?Q?/ZgcBwgzaWRCuaL7e0JM/9DxWtAiubucm0CfENi1Jhp9JSpxY211/PIosX0n?=
 =?us-ascii?Q?KcJq6hD7sK2u9YqhvZw3yy3mRO3is7k9BEWqSLFwm9MMRZuSev0uFaTB+WTj?=
 =?us-ascii?Q?uajVkamkE+EyKJgkn7TLOymPywiHut9aNFszsunjbReGPqHJh5fV8YQEy1au?=
 =?us-ascii?Q?uX05F2HyV/XiQZEj5lKwPA59EdHcZCBN9tIEtWqIIHFCg4eWV0DI+ZtoxWC8?=
 =?us-ascii?Q?ht/ejNxnAcu6fDexpImmgLyPcjQp5XkYagA/MXRUs+FstO5XOOkyCskYA1Gq?=
 =?us-ascii?Q?Mqw7aesStgOHvFdPk37AtsRQxEw5wTgDgs30El6Rz/28urQOb1MiGj+ZlkMI?=
 =?us-ascii?Q?sC0gnec96D1XWHUsko+Ejz7UA19be+V5zODmsHzSH4+IIn72B1bk3aLEYxxv?=
 =?us-ascii?Q?eJn85LcB1JvAfeShJ7U7D0dYhrtdnSypfAvTLyvvYz3k72Fj5iCZWsJfv+d9?=
 =?us-ascii?Q?4DrXNWwjj8Y8/1SxtEgcDvcXI/hhytZhxz1U8ry3XJxdSTkJGl5Uoxxja0Mz?=
 =?us-ascii?Q?GspjTB+b3hK9iLww08=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB63765336BE6F81EBA8C77463BF670@AM6PR05MB6376.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(6246003)(11346002)(446003)(476003)(1076003)(68736007)(386003)(102836004)(99286004)(6506007)(186003)(33896004)(26005)(76176011)(52116002)(478600001)(25786009)(6916009)(86362001)(486006)(14454004)(4326008)(54906003)(71200400001)(71190400001)(316002)(105586002)(2906002)(3846002)(6116002)(66066001)(106356001)(97736004)(53936002)(9686003)(6512007)(33716001)(8676002)(81166006)(8936002)(81156014)(33656002)(6486002)(6436002)(256004)(7736002)(305945005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6376;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XHslJ95umSa4t503qlVIWCNDMtGECRnY4Hw/QxHyUIT98HBrw3zCe0xqU+p4Szj8xvM6gizv+9uYpZ/26Q16YUugDl+8mfs1oF0aAtsqfRQPdMP3a9546fxBGufWdW8VYvacA092ekLB0Ch+kvYN7AU6N0GK30BESMmS91fhLsZNtaAJG3/I41/eIQ16/WY6FSri7mMo9ro4LwP7+82KkHb4bNqmsSfWKwP7fOMVY5GIl1BVmre0Ke4UierLoZfsHmVhjdy4dkHn6HuZ/NdhCrnpxJkpek4HBujGgmvDSlXydhYXw6ULBepNvX5Lrj7nt7hE3ttUqk3zSzC504ACtEGIB7itqNAtIhOdgAyF/vVmt232xVdq76g1DAoy70YpHOH6zO3yYe8Rx7ennfcbXq/b+ymusxkchAYiCRyMK9c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E18242A66F1D9841904291B1D4DD715A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe17f0-3f89-4f95-2d42-08d6926e5fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:20:06.6170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:36PM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to checking the
> bridge port flags during the prepare phase of the
> switchdev_port_attr_set() when the process
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, we can avoid calling
> switchdev_port_attr_get() with
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index db9e8ab96d48..8f88f8a1a7fa 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -64,29 +64,27 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  {
>  	struct switchdev_attr attr =3D {
>  		.orig_dev =3D p->dev,
> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> +		.id =3D SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
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
> +	err =3D switchdev_port_attr_set(p->dev, &attr);
> +	if (err && err !=3D -EOPNOTSUPP)
>  		return err;
> =20
> -	/* Check if specific bridge flag attribute offload is supported */
> -	if (!(attr.u.brport_flags_support & mask)) {
> +	if (err =3D=3D -EOPNOTSUPP) {
>  		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
>  			(unsigned int)p->port_no, p->dev->name);
> -		return -EOPNOTSUPP;
> +		return err;
>  	}

I see that you return -EOPNOTSUPP from drivers in case of unsupported
flags. I believe this is problematic (I'll test soon). The same return
code is used by:

1. Switch drivers to indicate unsupported flags
2. switchdev code to indicate unsupported netdev (no switchdev ops)

I guess that with this patch any attempt to set bridge port flags on
veth/dummy device will result in an error.

> =20
>  	attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
>  	attr.flags =3D SWITCHDEV_F_DEFER;
> -	attr.u.brport_flags =3D flags;
> +
>  	err =3D switchdev_port_attr_set(p->dev, &attr);
>  	if (err) {
>  		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
> --=20
> 2.17.1
>=20
