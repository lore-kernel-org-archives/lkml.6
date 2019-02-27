Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xuSUxj1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfB0UQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:16:38 -0500
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:23136
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfB0UQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/GsUgg6V0Qm3dJI29WE0dFeCZiRRM50FdKRSxc+FOE=;
 b=xuSUxj1a5zHHUqmh/+ugrumJDrLk8eRSqeeGyMdOaPtYszy/xSfUUjZawBfnsTAx+BeRKnl214JXbFhW/rCiwARAqSfh7u07UoGGDGBN7tTIYRzwq0KLYT6lkcfm6hSQlF7HvcBmLSNOJ7IjoBLIaq7GixB08pkqdP6l4QO5Uy0=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6264.eurprd05.prod.outlook.com (20.177.33.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 20:16:31 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327%2]) with mapi id 15.20.1665.015; Wed, 27 Feb 2019
 20:16:31 +0000
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
Subject: Re: [PATCH net-next v3 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Topic: [PATCH net-next v3 7/8] net: switchdev: Replace port attr set
 SDO with a notification
Thread-Index: AQHUztUFZTjhD0K0RkSNQTDr7y735qX0FPoA
Date:   Wed, 27 Feb 2019 20:16:31 +0000
Message-ID: <20190227201628.GA7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
 <20190227194432.725-8-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-8-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0102.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::43) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.249.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 357bb162-a19a-4513-bf4a-08d69cf07670
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6264;
x-ms-traffictypediagnostic: AM6PR05MB6264:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6264;23:Ed/uQj438ctJlCOMT+s45MkcqEIDqF42fa3EmOsxL?=
 =?us-ascii?Q?/nrmSOpEh1aT+MAZJRnx1Mx6GhzibR2QMcskjtaT75Efn+68FSJgtBAYOpfP?=
 =?us-ascii?Q?D0K+9bde7axjxWR/w+8uh9PTL76xzVYh1l+qd2KUV1WvhSCJ8fuCKoB6/0tF?=
 =?us-ascii?Q?IXLWHTdkCuVQLgs+VIGFt4W1QrzremkCeI0MsPCgNS0cScDZMX4uezVNh3M3?=
 =?us-ascii?Q?Upk0PStgL6IROVB3mljQeGtivgfKI8gcuTZNaDVJ6/89W1A9pzK5Pd6akBcW?=
 =?us-ascii?Q?x76/0zBTLAdxaoSEr3gcs7+/1C+UJt3PJa6DPrtJlTBg6s2XWuTNKDI+v2Q6?=
 =?us-ascii?Q?xuTPSsIE8uhMxDLpy90nOQVozjB280U9IscPrh+H0ShNd7T7yUqfibZFLNNW?=
 =?us-ascii?Q?5ifVhCo13l1LZdW/BvcpJtLp4xAQvuOtisNMzYtxFgw8jM/Sk21RJokFyqCO?=
 =?us-ascii?Q?x99jWz6xOXPemJxVjYGZuTyO4zFsqYpqchOfp9zfHsGDAsGpC00huITI71q1?=
 =?us-ascii?Q?wZRZlW2FdNMXhVXXXm6jWqXVRqOpwLa0g40894+9RKG+jceIdS97L5s8KDSy?=
 =?us-ascii?Q?10dwWGUXyFEIB/cZVl3baVgWJLVsT7Nfm2Az1Ay7ILYFMUPgEv7D93bsAZEU?=
 =?us-ascii?Q?u3RAM0/nZwe4Da5PaHPhh2Hk5qLU8DHVnL88mUXkP6Wi/bLw14JWUph4ilTo?=
 =?us-ascii?Q?gk71lXSPIS5yqlvotwavYzZR4B+/oKEjKmRiLnTMBFcS7vym4ZbpCId/XugJ?=
 =?us-ascii?Q?5KmkLQErdSErtfN+L8kv4wbm975jfYeTc/QaH2s/HPuZV9evS1HBF/HlbPua?=
 =?us-ascii?Q?7mMUx0f5TrEgkJRb/YDpF1VZsCaIBhGTk0XW+IkYy+R9kz7ME2vYattfSiVL?=
 =?us-ascii?Q?BMXgzItAE8h5KU6kueD4JeK6Qt5XfTdBDh5RaypKYyeFdqLrbYRkFGGnOsgW?=
 =?us-ascii?Q?uQbODCx45b74sZmLwWfEi3hKcUHsnarAHGTXAwpvLwS/TaUwGUdiPjPJbSAc?=
 =?us-ascii?Q?D8yaP3yEKi/CPMXIs5jjp4sr7SxQg/CWjj5TX8YXtypTFCIuT7/8entyimY+?=
 =?us-ascii?Q?MhAVzopK29QMeySjLtvjbmjPNiP1c+TYrKwwydQRYyEuTGTiqB+44os2VWWj?=
 =?us-ascii?Q?97ZE5ib8dYTeuie4QqM0nVql1ozIbxKn79TFS7Uow66VPY35niNns6BDFCD6?=
 =?us-ascii?Q?a0Nk4vU1vpDipPz0oc11KX0/QAP2VIiZAgVGgO91nO+ZD1x3oE6Nb0Ff4ZFw?=
 =?us-ascii?Q?RlgnECoqkdFiVIYZdf+SbYdY8cZBU809xsTwxRPDKpxTEGllXxCoLH5f+THs?=
 =?us-ascii?Q?PJUDaEU2sYtzBe3cbPQd9XinP5wwkBc9MNdgL+Im9sP5iiEXXxl8LlLWWx4a?=
 =?us-ascii?Q?4RJ7B4dV9InKTGehNp7E6n+TCC+Mxy1ElxrajksN2DSg3kB?=
x-microsoft-antispam-prvs: <AM6PR05MB6264E798E2E3787C0E191150BF740@AM6PR05MB6264.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(256004)(6506007)(8676002)(99286004)(52116002)(81166006)(2906002)(3846002)(33656002)(81156014)(76176011)(102836004)(386003)(4326008)(229853002)(305945005)(106356001)(105586002)(25786009)(186003)(33716001)(11346002)(6486002)(15650500001)(86362001)(446003)(6116002)(14454004)(54906003)(7736002)(486006)(71200400001)(71190400001)(66066001)(97736004)(53936002)(5660300002)(68736007)(476003)(478600001)(6916009)(316002)(6512007)(1076003)(9686003)(8936002)(6436002)(6246003)(26005)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6264;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cm/n5643/H7rVb4gQddtQHQTmTTBphAFgt/O4L9xRAJvLbS8vxATZR+EEOHmev/6ChPZM8entUhpMMvSlvW05/LBucpZHw8eZqDPvkeDCm8v94UblOBbPTDa+1S/G75g8XzBvoQk6ZGAD2O3EIEZM/JWL4LeTn3X+0H2sQmMtPO0DF3HODsRN/BomV1aFC+jlLTYlejQpgHFYIrM35qy1Cm2hf/4svpDoJ9rV9j7H9uVVZJtHnHC81RPzbDqP7sv7muiipMw8wPQUBDZiwrviGS9pabtznqHP777gtjZv0O3ktYfDsFEokLlT2CHH3GIujyS6XThLjF7QrGvhwyU2hLJVoyhq4taoHpk2vS0Mp1jIAW/cYoc5tz1hdTupPT/ZN/nNoREJN/k/IcBSyQmsNAswj1ZuBr15fVZTU0EHsg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A900F4E71779D34F8B6C0E492FB4363A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357bb162-a19a-4513-bf4a-08d69cf07670
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 20:16:31.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:44:31AM -0800, Florian Fainelli wrote:
> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
> from all clients, which were migrated to use switchdev notification in
> the previous patches.
>=20
> Add a new function switchdev_port_attr_notify() that sends the switchdev
> notifications SWITCHDEV_PORT_ATTR_SET and calls the blocking (process)
> notifier chain.
>=20
> We have one odd case within net/bridge/br_switchdev.c with the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier that
> requires executing from atomic context, we deal with that one
> specifically.
>=20
> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
> likewise.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

One small nit that you can address in a follow-up:

> @@ -67,12 +67,18 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  		.id =3D SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
>  		.u.brport_flags =3D mask,
>  	};
> +	struct switchdev_notifier_port_attr_info info =3D {
> +		.attr =3D &attr,
> +	};
>  	int err;
> =20
>  	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
>  		return 0;
> =20
> -	err =3D switchdev_port_attr_set(p->dev, &attr);
> +	/* We run from atomic context here */
> +	err =3D call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
> +				       &info.info, NULL);
> +	err =3D notifier_to_errno(err);
>  	if (err =3D=3D -EOPNOTSUPP)
>  		return 0;

This check can be removed. The code below checks `err` and fails the
operation in case of error.
