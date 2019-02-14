Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC36222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ga6d2gkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438813AbfBNNLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:11:54 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:49095
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731764AbfBNNLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAY+bonFh6ivtbjOPXMXkuk9C2B287LoDQOniKarWDc=;
 b=Ga6d2gkQyCRVVGcVe5Qt9xzX1iGxo+InUynduIGAWft9XjshKx9aI0ZNIU5LtrmldPMlEf6/JzIc+6ebR4tO4rdHG7QTKEt0VqYP61CWt3l2FZtUDE11wA+bG1htfJFv7CEEUsZ7mGlP84sAauMkyKwHri5SKKaxq25huDhCerY=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5960.eurprd05.prod.outlook.com (20.179.0.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 13:11:47 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 13:11:47 +0000
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
Subject: Re: [PATCH net-next 3/9] mlxsw: spectrum: Check bridge flags during
 prepare phase
Thread-Topic: [PATCH net-next 3/9] mlxsw: spectrum: Check bridge flags during
 prepare phase
Thread-Index: AQHUw+iBKvpL63SHLkiIkWWqyb1xRaXfRdeA
Date:   Thu, 14 Feb 2019 13:11:46 +0000
Message-ID: <20190214131143.GA12064@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-4-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-4-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6ad30ca-f68e-4031-fc2d-08d6927df886
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5960;
x-ms-traffictypediagnostic: AM6PR05MB5960:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB5960;23:FwtEXxKTk5aVj4NPL0WAUsVuQun0rX45kSoLlrZ+j?=
 =?us-ascii?Q?rxHZIKvj7Bs0V+j8GDFbsiAPGH0aSxHTRrjYDCLohhbn5OPN85DwBP/UoiCj?=
 =?us-ascii?Q?XkKq0mdKYCMlMVxZYyDNWD7PoF/pqRnX6k41sP9uHmwSjg+sa5CvFx8WnSht?=
 =?us-ascii?Q?CNbNaPvIxaFWATjvTuy8af0687g7584GNlHKpjyJuTsvXsvu+aKAiBKmt3ZI?=
 =?us-ascii?Q?kGStr45aQtT1Bgh3AP+bQAdKPfBhe4KpBNmIiIVkDHlC+/tUbS6qOubu30b+?=
 =?us-ascii?Q?abiFCk7ncK12Pv9ExzvUqJm1H5AfVf2qTgVKvfUjWsTDlVBTmcQNxMyaf7Ng?=
 =?us-ascii?Q?ZDHBqA1tM8DxHrBb8TeUPW2iKBAnmyqI83ZfDApdDUFqg10yI5UzdT5hN+UK?=
 =?us-ascii?Q?3qz4xWlGhklalvTBXJK8TPxnlwaiqXS5XJ3QyYLFArVQe4RxJ1lqgS3knRto?=
 =?us-ascii?Q?rn+x1eNrXlGivOYTh+6bI63/fKszb0wxRUW6Jy5s7Ommr27YVJ2HjWIIASM0?=
 =?us-ascii?Q?gxNDGLCwEXXrLRV3NuRrRsE+qab5ybEMUK+Qb7x2il/P38Fn0zi4bDZM9ybO?=
 =?us-ascii?Q?QPctwMyQyuxPcbsbXi8z0Z+y+yuI3jAFVqybBV3BR09xrOVvo0vktAOb4vWI?=
 =?us-ascii?Q?tR2JtJaJD05WQEwdWYgV+iAvrNzB9tSyZSzLDdwZE608T8madvUWYWkmoWxS?=
 =?us-ascii?Q?5d3hsfHA4g4wToJ9vVkyTvbjZPUxwJHyqfRQgpkK2+P1kHyqnR67uE0hDMnh?=
 =?us-ascii?Q?zY31P/3mBDEVxJ54Mcd+Ue9A1ZDmkOfjd2f1oA3j9vmOKnMqZt3FTRQkxnt/?=
 =?us-ascii?Q?I+gqaGJNRVE8GI1OaebDKbgqgBtmzWm4ySxVfC98qHoQNrufJlrZ86xedmLn?=
 =?us-ascii?Q?YkIpq5ODz+xYw+4T0h4tj/p+DpxHK7VW+AKOpZWEIaNIXysiEcaH0PZzlS3s?=
 =?us-ascii?Q?zMjoQnEfNlvwjTdrjMoaNVsaEJsD3P4X9fOAMsQ3+lC0HYuMijowkpKPh2Xl?=
 =?us-ascii?Q?H0GnIVQxK0yMf0rYbugpWm9MaF625ATFeVaKCvL0pLH/sLnR6eQz8hzfSmus?=
 =?us-ascii?Q?8nd2E31g8sbP2xpfVmZlqh9Iu4iyMvUb6RsIeoNdAXuMcAd/79E4gCAGE5Q2?=
 =?us-ascii?Q?9GbD7ecy/wQrZs9UdWaO5U2KAjMMJn6N6fv28VXiZ8WgYT6J7yHUXKXCZ5+o?=
 =?us-ascii?Q?XzbMtUKFFNogU7H7HIBKzCqISKYePkB04FqK9aji/7WMPc1dRU97UGiq3Wxb?=
 =?us-ascii?Q?qJgE3NiT8eXppF0ifA=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB59605AEDFE9445B0F5421266BF670@AM6PR05MB5960.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(229853002)(81156014)(33656002)(52116002)(446003)(53936002)(11346002)(6246003)(8936002)(186003)(81166006)(8676002)(6506007)(386003)(97736004)(76176011)(486006)(102836004)(478600001)(25786009)(2906002)(54906003)(7736002)(66066001)(71190400001)(305945005)(106356001)(9686003)(316002)(71200400001)(68736007)(6512007)(26005)(33896004)(105586002)(476003)(6436002)(99286004)(256004)(1076003)(6916009)(33716001)(86362001)(4326008)(3846002)(6116002)(6486002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5960;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h5bztNMkZfUkSby1ndvUy/JGkP7jMdGK47nVzaFtOVHYyDCol6IPf2vrNcYFO3H+5bZc9oRB4Ds/Hk4edCcxSB5nUm03PV7vVIUDJ4/drr/0hfkU5y7fOMvFqPL39ypRzMvapPkynjVvyl7S7ttQ433CbOa6m2f7KM6A9JZR8K9tiTybDEvt/c2B6rhT+GT4bgFyGlJ6ftfS3BhAbAUfFlCLHGgv8HxYDK+ZP+CKdhCSQibovi/8NWIgsQ5iZ7g+5+i5xU8LnuvOzwNRzzbszLMs8Z9/4SjAQmdyyv4Oq6WHvwCJyjDb6qdbxNp7MV2zjWsypuQv4JyTjw4U/Zo1D1Ej2XLjFH/C/xOu4Qh4iEDSJf49JV79ySjfFz6qk9hrJ69vU+PrESP+RpGTs6IXxSU/RRuLE3hNlh2KhkmUYn8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB8CC15313445A4F83537A62675CD75F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad30ca-f68e-4031-fc2d-08d6927df886
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 13:11:45.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:32PM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
> check for the bridge flags being set through switchdev_port_attr_set()
> when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
> used.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 1f492b7dbea8..7616eab50035 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -598,13 +598,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_p=
ort *mlxsw_sp_port,
>  static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_s=
p_port,
>  					   struct switchdev_trans *trans,
>  					   struct net_device *orig_dev,
> -					   unsigned long brport_flags)
> +					   unsigned long brport_flags,
> +					   bool pre_set)
>  {
>  	struct mlxsw_sp_bridge_port *bridge_port;
>  	int err;
> =20
> -	if (switchdev_trans_ph_prepare(trans))
> +	if (switchdev_trans_ph_prepare(trans) && pre_set) {
> +		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
> +			return -EOPNOTSUPP;
>  		return 0;
> +	}

When we get SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS we only want to
perform a check. With this code in case it's not prepare phase, then we
continue to set the flags. Better do:

if (pre_set) {
	if (switchdev_trans_ph_commit(trans))
		return 0;
	// perform check here
}

> =20
>  	bridge_port =3D mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->brid=
ge,
>  						orig_dev);
> @@ -833,6 +837,7 @@ static int mlxsw_sp_port_attr_set(struct net_device *=
dev,
>  				  struct switchdev_trans *trans)
>  {
>  	struct mlxsw_sp_port *mlxsw_sp_port =3D netdev_priv(dev);
> +	bool pre_set =3D false;
>  	int err;
> =20
>  	switch (attr->id) {
> @@ -841,10 +846,13 @@ static int mlxsw_sp_port_attr_set(struct net_device=
 *dev,
>  						       attr->orig_dev,
>  						       attr->u.stp_state);
>  		break;
> +	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
> +		pre_set =3D true;	/* fall through */
>  	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
>  		err =3D mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
>  						      attr->orig_dev,
> -						      attr->u.brport_flags);
> +						      attr->u.brport_flags,
> +						      pre_set);
>  		break;
>  	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
>  		err =3D mlxsw_sp_port_attr_br_ageing_set(mlxsw_sp_port, trans,
> --=20
> 2.17.1
>=20
