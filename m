Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C36FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1C6206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pmVW5+Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfBWKhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:37:38 -0500
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:27451
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfBWKhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9lqsyiDsNGH2ZD3Do7ufAfzCq+bh/RR2twbrnzslow=;
 b=pmVW5+Lo0SjkM75k8txsjhQPAHLKL0QTn+SdXR6RTvGuY8dT75XM+FPOgtu0YFcMRqK1Nvhy89rEKeT/8YHLcBxxef8Z3m7qgknQmFa2bUUXKuFVpLOutYUrYyZUPXyZbLo+LUusXVdSqJCJG3Bs3BIZJU+df1Ii7H0GUfwB6ls=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4392.eurprd05.prod.outlook.com (52.135.164.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Sat, 23 Feb 2019 10:36:54 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Sat, 23 Feb 2019
 10:36:54 +0000
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
Subject: Re: [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_SET
Thread-Topic: [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_SET
Thread-Index: AQHUywrS0B9mbgg3+kGRiBM7AH92/KXtMUmA
Date:   Sat, 23 Feb 2019 10:36:54 +0000
Message-ID: <20190223103651.GC13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-5-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-5-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0109.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::14) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c0045a-37e5-4029-3fb5-08d6997ad3d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4392;
x-ms-traffictypediagnostic: AM6PR05MB4392:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4392;23:WiNSYkZqxQPEmG49tGHiXnTF56u+cZ+q8+wJRLjVU?=
 =?us-ascii?Q?40Lg4WE9f3uF5ruXbxwz6h5+GKX7sVC3sJ6wQi+OyETkC6NiV50lCDKLs48q?=
 =?us-ascii?Q?wDPuq2UX/XMBl1+SR+87ViHwfRiuPt6EqIaqarLNsqjAEew8c5F2qFy9WsiK?=
 =?us-ascii?Q?m/r1CoILa9ybhZ+U4Qc+WjNIKXKHLXyRvB1YhYYzjhYm7T8ggfE1PkiURdCc?=
 =?us-ascii?Q?QWzVp66Reun37KbWDHP6QMjFOwMbqMEIGIw8XMJJGqM7eECI3/2GkVzB2O1a?=
 =?us-ascii?Q?OE1vTfePQ5X/e37GeUGjaZkFL3cZpQfrE1LF6sUtDtYJvc1swgyCdNrNUa1T?=
 =?us-ascii?Q?AFU4J6GKWouAi7G6S5inZA6SFi/07zWjdVNJg7uT7xJnbndOhpMHi6cO0ddZ?=
 =?us-ascii?Q?ROtDcja+NCfqITKK33cOVb554xDyM2KuRxZJg0PT9Zz+hXwWf9buM5X3aHCc?=
 =?us-ascii?Q?uU5Egry+O10WUPK1dR0xu96X6+pZCvrcgWH8UviTbkBCZ4mOHN07VIQJ7Chh?=
 =?us-ascii?Q?+/5IF9WTPLxeuDXT0yHXUbXwziSojfxncD/lhpFwkpGSYXgTiChFVsWcH2aL?=
 =?us-ascii?Q?k/BiFC8hwHNo8/GbJcXAhJyz7rvdvEWoWDHorX+xCCNzITz4+IjmTSBf7/Mq?=
 =?us-ascii?Q?cX/A8Z/kJvpDhGL4tGqEYPLjNgxHU+9zVW/M8xH9ERpGMKwz4HlSRhPfjuMd?=
 =?us-ascii?Q?zuUZKTnasfUC6yVVRySQJXMAL4P7fSve6blw3KkgNn9MrhMXu4nK0Equs2p0?=
 =?us-ascii?Q?rtSqQRms1Jcs2vFrvwcsn7tVL1ifUfcpJwGrg7JzVpoFzRLQaNN/Y98QWJJq?=
 =?us-ascii?Q?X/40edtJRTvcD86P1Iu560qMa+2nIWS0GxxSKQzneiNwX5hLTo4bTP+InllP?=
 =?us-ascii?Q?p9zhnnT0KaqwNIndwl/Hxc25AHQ8aLGvg73EjaBsR6bciCLa2wlBsKwH+Fx4?=
 =?us-ascii?Q?Q8WtbCa/N2hkMf/la36Lk2BJb88A+0L7WoumYU9CSGMUDWnJCf6z2yrGSI46?=
 =?us-ascii?Q?nj5skD1Cb9Fy2y58Rmafy8EGA/PFhouZrKEx3ZQfkeDvga2VTJY7h49h3kMd?=
 =?us-ascii?Q?VS3owM3IVG+tr07LpEYUNyITZGhwXi6qcqAAersYWzCI33JHialXJcW9NtRt?=
 =?us-ascii?Q?oZWIhoTxxYUGl6lfZeXPSYelBo7eMAjOyG8OdSGv2n6frHyKpZzyAUhvR7e8?=
 =?us-ascii?Q?vBlqJQ5tNvVWaoUD/m2Kr9crV7Qr5Ax/zRuW6xEBH2rK2as/zyb8W6PdZpgy?=
 =?us-ascii?Q?hYTxyBUp5i5xcmyDdEJVVP4AVUMiYbi3ZfdLbNt?=
x-microsoft-antispam-prvs: <AM6PR05MB4392EE829D0730CDF082EF20BF780@AM6PR05MB4392.eurprd05.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(76176011)(25786009)(316002)(99286004)(4326008)(81166006)(8676002)(66066001)(5660300002)(2906002)(486006)(8936002)(81156014)(86362001)(53936002)(6436002)(6486002)(9686003)(14454004)(6512007)(54906003)(256004)(229853002)(52116002)(6246003)(478600001)(305945005)(33656002)(476003)(6506007)(386003)(97736004)(102836004)(33716001)(186003)(1076003)(26005)(6916009)(3846002)(7736002)(6116002)(68736007)(71200400001)(71190400001)(106356001)(446003)(11346002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4392;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c21FN9FruRgAJOBpy/PWY6S3WM1YPMbpbin4BTXcolZaDik1hShc/lZF3Fftday5CggpBncGHHPWSEGgI8t/KDTmxWFVjaUeXIazdBv6m76GaIg0h6VuqBSiOLgAJ51pF6QxtTNRfjcvj/3pIusYpfMRtwfwx3x/4vf+rc5cSFLvaxRP5uO6qnghtf+oAWkRld9S4IGWVYFO8fmTQMZGAigTCBxnC+wDEa98VTr51i02KECba7a1RhNhxLndPBEopC4jzZpLdHVaD33s1/T0kKelpOM+7l0Rv0ih7Nmx4fym9Q4RhZ2Gn2bTfDXdIHNmySDrY3S6hFgp3ECZHMeAt9x4FwNMXwAszUkJZAEvXvAF0aJb2WSFylaUmYA4thawl5eMNf+oJ9fMq0JM6kkQ5yg+e5AuXZjBemsnqaEHgMU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E20568B61978194FB1D0123B536834A2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c0045a-37e5-4029-3fb5-08d6997ad3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 10:36:53.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:59:22PM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate setting a port's
> attribute and use a notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
> to handle stacking of devices.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 766f5b5f1cf5..c1aedfea3a31 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifie=
r_block *unused,
>  	struct net_device *br_dev;
>  	int err;
> =20
> +	if (event =3D=3D SWITCHDEV_PORT_ATTR_SET) {
> +		err =3D switchdev_handle_port_attr_set(dev, ptr,
> +						     mlxsw_sp_port_dev_check,
> +						     mlxsw_sp_port_attr_set);
> +		return notifier_from_errno(err);

I don't think this code is ever executed. And if it was executed, we
would have problems because switchdev_handle_port_attr_set() might
block.

> +	}
> +
>  	/* Tunnel devices are not our uppers, so check their master instead */
>  	br_dev =3D netdev_master_upper_dev_get_rcu(dev);
>  	if (!br_dev)
> @@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struc=
t notifier_block *unused,
>  							mlxsw_sp_port_dev_check,
>  							mlxsw_sp_port_obj_del);
>  		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err =3D switchdev_handle_port_attr_set(dev, ptr,
> +						     mlxsw_sp_port_dev_check,
> +						     mlxsw_sp_port_attr_set);
> +		return notifier_from_errno(err);
>  	}
> =20
>  	return NOTIFY_DONE;
> --=20
> 2.17.1
>=20
