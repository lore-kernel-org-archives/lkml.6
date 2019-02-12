Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835A2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C520838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XYEOlfJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfBLOIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:08:05 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:13920
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730016AbfBLOIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAJVsK8hiHFIB9tUBItftnwv/AzgwwxpOx3Es/kuofA=;
 b=XYEOlfJGsYvgCTLASixkDD12MsGFOIylML+E8/WSDCazwqR6HPnAZfLgFVn/CdsRrkpgwBIJIampj2CvzrwBERV5dzArrtE60+cr5j9a+att7l4ysZC30oA9EjA1zhFJUQcOlBZEt8NcLF0yTO1MQt1SFz3f7ACROaX8OSh2QCc=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6565.eurprd05.prod.outlook.com (20.179.18.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 14:07:58 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:07:58 +0000
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
Subject: Re: [PATCH net-next v4 4/9] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Thread-Topic: [PATCH net-next v4 4/9] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Thread-Index: AQHUwj1+hXo3LUWAYUOGbjBeaZPEQqXcNDkA
Date:   Tue, 12 Feb 2019 14:07:58 +0000
Message-ID: <20190212140756.GB16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190211191001.8623-5-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-5-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::18) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB6565;6:GFvofxHsBagaIs2stlxmbyU4ZIyHCv3Z/HfIMBCQph1GwHm5gALawYf+JKqTsC8dJ4c2loaqq7PHWzHlCk2od5Up353ToqUDKu7acalNq+viVaPjyA61gpdNjFcoNTda5JqzzKqosHel02hxIPsjdvWwhzxRGhD3gO4ajyiKq55T0w76uhtnlybju7fr2wje7iPq9Aa1Lbf5tQ3lEqbnJNvrEcy/4tvsbDyIHlz91mYjo1ALBLVYoESAsDoQsr2wnHBTcrMt2jAHG2oDEYLX2h9R4AJGW5sQEGnsbraXSwBmWaRZoRf+yEDPWv3x7P2lWLonk9iu30GlZq/yBRop8378fhpdt/EbL4scvFSIBy0/S0R9pJKZ5bl/mGtgysFw8qbDaQN2mPtqgLn3aN1KTNukUDBENyvImgkHhCPb7iGCuICuvEnpIdE4jSdH7XzJjt0YsJO/doWdL1xa75mqKg==;5:3O8TsEdJktHWsaaFqJ0+cBBwXySfFRAsrKPddPzw9tGL2R26LJKAhr9fgEhMdk7GiqYk8y/JYDEfvHdMsd0EiAoOCB2uA9cCX4tsFF4//dkreFlBCkmnDQFqliUnVwlLzhFTeHN2OF2K1UObe1AFsS1W6izCaZzfGxkYva67Z9QJripKPpeb/iCIg/IiKFgJrQTF7Ee9zMlKRKuFeRlPmA==;7:rCsIcYluxeflG1lX6ynpH/MP+fM9VUmjTBs4vKJpZzwJ0kHuE8CsVTENbwCVhGV5TPkx2KUjtQOzhWKWUe2ckQJfePYH6wxRp6Wlmm9PYfTo5XQuN2ReW6SLq//LVnVp3xcwBhcu1eOR01W0V9r67Q==
x-ms-office365-filtering-correlation-id: 77dcee78-419d-4aaf-524a-08d690f37dc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6565;
x-ms-traffictypediagnostic: AM6PR05MB6565:
x-microsoft-antispam-prvs: <AM6PR05MB6565730EA79AF877D172C69BBF650@AM6PR05MB6565.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(199004)(189003)(11346002)(446003)(66066001)(1076003)(33656002)(53936002)(476003)(6486002)(9686003)(6512007)(229853002)(14444005)(256004)(6436002)(486006)(71200400001)(71190400001)(6916009)(6116002)(76176011)(186003)(316002)(386003)(6506007)(33716001)(68736007)(3846002)(8936002)(33896004)(97736004)(478600001)(52116002)(6246003)(81156014)(7736002)(14454004)(26005)(102836004)(4326008)(2906002)(99286004)(81166006)(305945005)(8676002)(105586002)(54906003)(25786009)(106356001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6565;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1RwtZANLZiWcYohtuHUUibSFAsvWQfTsHUhVWRhu78mHmJEq4jVM/2n/QefTLnKqbvPsDGmeGAWfy4FoWIMVKnAGyO0pB3VNd/KzJizEdkbReVzd95tj8f6Y0PDPdMiwH1c5Fd8vf7MufIllN0f/YCbo8QJt98qgUr0C2tGRwFc9owUYoCm+GpB8TihcKPGFYhvqBYbjil4f5d/RrlvVISesU6WoQtMbvUTBWH4TNHgwgVJXB5zFUiWQjeGwmGDmHsl2GC8vxbRdTVatSTgMh7mJWGqQpWdisOi3kB+VPN66xUdgOXIfT+rgkUb7kwRp2a5OloPxNb0LqVhMtbAKOX62t8fQlBrCrKfXtuod3uGzhHqefzWtjtz4jHP9S6ZN1DZlaB6bqjrfmvJWLbokSkju7Lp5/LmkPBBxCqUquH8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7357BE726D79B14582CF9DE74276DEA6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dcee78-419d-4aaf-524a-08d690f37dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:07:57.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09:56AM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate getting or setting
> a port's attribute and use a blocking notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
> mlxsw_sp_port_attr_{set,get} calls.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 95e37de3e48f..88d4994309a7 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -3443,6 +3443,26 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net=
_device *vxlan_dev,
>  	}
>  }
> =20
> +static int
> +mlxsw_sp_switchdev_port_attr_event(unsigned long event, struct net_devic=
e *dev,
> +		struct switchdev_notifier_port_attr_info *port_attr_info)
> +{
> +	int err =3D -EOPNOTSUPP;
> +
> +	switch (event) {
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err =3D mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
> +					     port_attr_info->trans);

It is not that simple. These functions expect 'dev' to be an mlxsw
netdev since the operation is propagated using the device chain. This is
not the case with notification chains. 'dev' can be any netdev in the
system and then this line in mlxsw_sp_port_attr_set() is not correct:

struct mlxsw_sp_port *mlxsw_sp_port =3D netdev_priv(dev);

You can check commit f30f0601eb93 ("switchdev: Add helpers to aid
traversal through lower devices") for reference.

> +		break;
> +	case SWITCHDEV_PORT_ATTR_GET:
> +		err =3D mlxsw_sp_port_attr_get(dev, port_attr_info->attr);
> +		break;
> +	}
> +
> +	port_attr_info->handled =3D true;

I believe this should only be set in case the driver actually handled
the notification. That's how it works for objects.

I suggest looking at the series merged in commit 06d212900ea9 ("Merge
branch 'switchdev-blocking-notifiers'").

> +	return notifier_from_errno(err);
> +}
> +
>  static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unus=
ed,
>  					     unsigned long event, void *ptr)
>  {
> @@ -3466,6 +3486,9 @@ static int mlxsw_sp_switchdev_blocking_event(struct=
 notifier_block *unused,
>  							mlxsw_sp_port_dev_check,
>  							mlxsw_sp_port_obj_del);
>  		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
> +	case SWITCHDEV_PORT_ATTR_GET:
> +		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
>  	}
> =20
>  	return NOTIFY_DONE;
> --=20
> 2.17.1
>=20
