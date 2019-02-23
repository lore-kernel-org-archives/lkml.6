Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522462084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Gdj4Hs6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfBWKcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:32:21 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:4582
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfBWKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx4BRCoQbKMbn1t9YHRuEytsxONyc7BqQmViBsLuiho=;
 b=Gdj4Hs6Io8qDf4fGJVpzIYR2byvZGz1Ch6PkLNJwi0e/VoLqr7mAc29uZbjzBcNV7AmoJxgjCEYm9ZvQZVrxzLaGciKEH10FyhW+UNz7+igjWvIetI6G2DrtaN4BCUu2oa1FkVXvnlFl5mVKVwaEEhPy/0npXZpP4q8SVIpmfZg=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4392.eurprd05.prod.outlook.com (52.135.164.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Sat, 23 Feb 2019 10:32:11 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Sat, 23 Feb 2019
 10:32:11 +0000
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
Subject: Re: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Topic: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Index: AQHUywrdkdsT/LOBwUG+oBo6MXUQTqXtL/eA
Date:   Sat, 23 Feb 2019 10:32:11 +0000
Message-ID: <20190223103207.GA13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-8-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-8-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0007.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::20) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c34e36a-7512-467d-8bf1-08d6997a2b4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4392;
x-ms-traffictypediagnostic: AM6PR05MB4392:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4392;23:hbkmox1A0MeVnipsnCBpcqYjoc2mJ7VBsxvpdc/YO?=
 =?us-ascii?Q?kmKMP6Rin6Qyf0Btdg0nyo2GiyuFjidKcxXgpNcCFAE34Bhn2vzxUdP/7BWJ?=
 =?us-ascii?Q?vcJXlzCY4LWVDVdMSy1URtc4UZCMW+LuCqeOHr59VbauDTsmfOtA4FQT7Uee?=
 =?us-ascii?Q?AocwCn3DOonnZ3XgQ9/V/4yxNOIj2UTJnshD73M9TRxREsrAPQt8yf4JLrxB?=
 =?us-ascii?Q?C+1y8shmv0nLQXOtgeWKiK5WV/seorBqTS8sVIzb6qBdy0H3nkmTJyycDOQd?=
 =?us-ascii?Q?dK/lvskDps3lomlBzx0Rg2Qk/ptZ7PslbT3LOIOBxsURAfZZ31LRyjh+0fUd?=
 =?us-ascii?Q?9HzEMY1WNzE3fzEBaKvD3RGeP0bDv/jAszoKcCE50vmyGKsAYJSNc4UPEhP7?=
 =?us-ascii?Q?ay2RZQzsJMjWLJRjUAd+X0LF+ev3uZ4t+3XB0ZTnFGE9/A1bu7B6BSIowGo1?=
 =?us-ascii?Q?E9+VFsrnAuMqsWS+/aJacy0HokzFd//sEbs6z5Pw3EZZgAzBbrJgM27a1Qi7?=
 =?us-ascii?Q?55QiL/yAJ4SJV15YmSr9m/txsD0fsByOaMXpBV82kJZpbHS7HRCn85wmzHx9?=
 =?us-ascii?Q?CcXmhvlAJRBSPrrxXqifqYsIeaAvO7rtGmqmBCdao/dpCKH9mYJA0NcYUyl4?=
 =?us-ascii?Q?wv6IyGzAzSHCdDzp+qN+Qz14sFbrlRJJKsN0y/scAXXz3vZd7Fwpmdd90jqc?=
 =?us-ascii?Q?WyLmGZhVuFGqzAwQYfC6UOFzamkitjvZcww7CaVOSVuvynPEaVNBl7n8DGUh?=
 =?us-ascii?Q?dGH/TZBHsCFJ8u0pWXTXpV5Lx9RDRohv75l92BneL/RAet8IejpNL1onkpVy?=
 =?us-ascii?Q?nZGlrYEFKZiqVtlFtvp9eBRninAWr4c/VOJ9GSRAUe9RdduDh5aftxEPgrDt?=
 =?us-ascii?Q?iW/Y3Q0vxCNq/2zFZ0Txyj7rDPeRK5Xo4goHB2+VqfwAERMUmW9plUpYvLqF?=
 =?us-ascii?Q?qBSA9Ol+iXTGEabiqLsKG7ab8CELrX2iKyGm6ar+UlcfOPOyHHXRJQcaHrSj?=
 =?us-ascii?Q?+4V2QFeTmUtRAAllkI7guIb42kcnaGPC6xZ2kcX0plsPkdzZD9L+RcDXR03E?=
 =?us-ascii?Q?b4PIOa56Npq2uNSnbNWkx/NrvEiOz+nZPCxhfR+fHQ4hCcGDHFfHNcWJYEt0?=
 =?us-ascii?Q?URV8eWYNvmKMqxldTN+uNF8GH6R072+2qFB2ifDuvR9wUWsmSygHd1ujO0I1?=
 =?us-ascii?Q?lypkgFcMKnU5yd8yFwdQ17ZHvDPb1x4KPy0u1xBuZNe8suQHlcYTOAc2yGFR?=
 =?us-ascii?Q?2Sdn4CS2jfy3jd1D8+QmswTnjxMUriKbeD7wOYkKZOT1V+ZNNDM7wJ/Zz21i?=
 =?us-ascii?Q?a7bRb8e6mAx1Bn6sDT8PVqde0julmQDkAma1TE+Wb5P?=
x-microsoft-antispam-prvs: <AM6PR05MB43921879FD6C9198D70E7254BF780@AM6PR05MB4392.eurprd05.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(43544003)(199004)(189003)(76176011)(25786009)(316002)(99286004)(4326008)(81166006)(8676002)(66066001)(5660300002)(2906002)(486006)(8936002)(81156014)(86362001)(53936002)(6436002)(6486002)(9686003)(14454004)(6512007)(54906003)(14444005)(256004)(229853002)(52116002)(6246003)(478600001)(305945005)(33656002)(476003)(6506007)(386003)(97736004)(102836004)(33716001)(186003)(1076003)(26005)(6916009)(3846002)(7736002)(6116002)(68736007)(71200400001)(71190400001)(15650500001)(106356001)(446003)(11346002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4392;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S981Fkk+vTBDa3XcDBjhkJW+IZ5UKAeukcq898kygTpwD3FxQCIwMDgvpkhh2u4RYffWPUpD+zSrv8PyhMIbO44z2zQ2m322qgIfnMEytHxIZAKMFV9F+VMgXsosoEfGNw+KCnDRGG5mdCnnIKzHipBIr/r1BHYJttdlfHfY77RAlMA5deE0eDIQvUl4GMD82EDpIvGDbhUzeDXxKOl8zbXHX5t39VA4PHCRp2NnXWjbT/gFnhkxd7RT9VNYp22Pumv8dCL9vuWUf1z6MrlzrtBiDfLEHOMXwBU+LYo5k4PE8A102fuJonD/9cZNcjOhyn3oP0Zoo5nFctwn2/kwmbuwlCE8cdggSzAIPukRfcEWLyqs9rjHwkPefrHffH/Bu7qGZtyEVXABoay+1xpoQsbZwHArlXxTF7QoWvF5ot0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88304ED7E217AD4B8CDCB26BFD99FEC1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c34e36a-7512-467d-8bf1-08d6997a2b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 10:32:10.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
> from all clients, which were migrated to use switchdev notification in
> the previous patches.
>=20
> Add a new function switchdev_port_attr_notify() that sends the switchdev
> notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
> SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
> (atomic) notifier chain accordingly.
>=20
> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
> likewise.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/switchdev/switchdev.c | 96 +++++++++++----------------------------
>  1 file changed, 26 insertions(+), 70 deletions(-)
>=20
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 94400f5b8e07..a1f16836ef89 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_de=
vice *dev,
>  	return 0;
>  }
> =20
> -/**
> - *	switchdev_port_attr_get - Get port attribute

Hmm, why do you remove it here? Can't you remove it in a separate patch?
I thought we already got rid of it :p

> - *
> - *	@dev: port device
> - *	@attr: attribute to get
> - */
> -int switchdev_port_attr_get(struct net_device *dev, struct switchdev_att=
r *attr)
> +static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
> +				      struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans)
>  {
> -	const struct switchdev_ops *ops =3D dev->switchdev_ops;
> -	struct net_device *lower_dev;
> -	struct list_head *iter;
> -	struct switchdev_attr first =3D {
> -		.id =3D SWITCHDEV_ATTR_ID_UNDEFINED
> -	};
> -	int err =3D -EOPNOTSUPP;
> +	int err;
> +	int rc;
> =20
> -	if (ops && ops->switchdev_port_attr_get)
> -		return ops->switchdev_port_attr_get(dev, attr);
> +	struct switchdev_notifier_port_attr_info attr_info =3D {
> +		.attr =3D attr,
> +		.trans =3D trans,
> +		.handled =3D false,
> +	};
> =20
> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> +	if (attr & SWITCHDEV_F_DEFER)
> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> +						       &attr_info.info, NULL);
> +	else
> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);

I don't believe this is needed. You're calling this function from
switchdev_port_attr_set_now() which is always called from process
context. switchdev_port_attr_set() takes care of that. Similar to
switchdev_port_obj_add().

The event `SWITCHDEV_PORT_ATTR_SET` is therefore always blocking and
drivers only need to take care of it from their blocking notifier.

> +	err =3D notifier_to_errno(rc);
> +	if (err) {
> +		WARN_ON(!attr_info.handled);
>  		return err;
> -
> -	/* Switch device port(s) may be stacked under
> -	 * bond/team/vlan dev, so recurse down to get attr on
> -	 * each port.  Return -ENODATA if attr values don't
> -	 * compare across ports.
> -	 */
> -
> -	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> -		err =3D switchdev_port_attr_get(lower_dev, attr);
> -		if (err)
> -			break;
> -		if (first.id =3D=3D SWITCHDEV_ATTR_ID_UNDEFINED)
> -			first =3D *attr;
> -		else if (memcmp(&first, attr, sizeof(*attr)))
> -			return -ENODATA;
>  	}
> =20
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
> -
> -static int __switchdev_port_attr_set(struct net_device *dev,
> -				     const struct switchdev_attr *attr,
> -				     struct switchdev_trans *trans)
> -{
> -	const struct switchdev_ops *ops =3D dev->switchdev_ops;
> -	struct net_device *lower_dev;
> -	struct list_head *iter;
> -	int err =3D -EOPNOTSUPP;
> -
> -	if (ops && ops->switchdev_port_attr_set) {
> -		err =3D ops->switchdev_port_attr_set(dev, attr, trans);
> -		goto done;
> -	}
> -
> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> -		goto done;
> -
> -	/* Switch device port(s) may be stacked under
> -	 * bond/team/vlan dev, so recurse down to set attr on
> -	 * each port.
> -	 */
> -
> -	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> -		err =3D __switchdev_port_attr_set(lower_dev, attr, trans);
> -		if (err)
> -			break;
> -	}
> -
> -done:
> -	if (err =3D=3D -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP=
)
> -		err =3D 0;
> +	if (!attr_info.handled)
> +		return -EOPNOTSUPP;
> =20
> -	return err;
> +	return 0;
>  }
> =20
>  static int switchdev_port_attr_set_now(struct net_device *dev,
> @@ -267,7 +221,8 @@ static int switchdev_port_attr_set_now(struct net_dev=
ice *dev,
>  	 */
> =20
>  	trans.ph_prepare =3D true;
> -	err =3D __switchdev_port_attr_set(dev, attr, &trans);
> +	err =3D switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
> +					 &trans);
>  	if (err) {
>  		/* Prepare phase failed: abort the transaction.  Any
>  		 * resources reserved in the prepare phase are
> @@ -286,7 +241,8 @@ static int switchdev_port_attr_set_now(struct net_dev=
ice *dev,
>  	 */
> =20
>  	trans.ph_prepare =3D false;
> -	err =3D __switchdev_port_attr_set(dev, attr, &trans);
> +	err =3D switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
> +					 &trans);
>  	WARN(err, "%s: Commit of attribute (id=3D%d) failed.\n",
>  	     dev->name, attr->id);
>  	switchdev_trans_items_warn_destroy(dev, &trans);
> --=20
> 2.17.1
>=20
