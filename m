Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C74C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B081E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Y9HCfYbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfB0NNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:13:24 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:6446
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfB0NNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVB05HmwQe3R7xLi8x+oCjTXlaH8QPcP+BBhzZ/wLIc=;
 b=Y9HCfYbq4rlQoN8lH55Ggsnm9hJGOX6qprySGoiG3+wSogdXLCBlvqr3I3i1xARnhlfGCZKFNm0gTTO8xD5StGwV5b+hwGhkG7UZtAoPjTJlYTLogfzaLv/Fu66He3daPnGAcCL1z60YYKxLP0Fi6MA9Dhf5DhmUBt1XuoQXXQA=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB4235.eurprd05.prod.outlook.com (52.134.108.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 13:13:14 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 13:13:14 +0000
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
Subject: Re: [PATCH net-next v2 8/8] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v2 8/8] net: Remove switchdev_ops
Thread-Index: AQHUzpjj30rUrraLB0eE2JTSslie1KXzny8A
Date:   Wed, 27 Feb 2019 13:13:14 +0000
Message-ID: <20190227131312.GA17964@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
 <20190227011427.16487-9-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-9-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::41) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51fb23e3-65eb-4a02-cf81-08d69cb55498
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4235;
x-ms-traffictypediagnostic: DB7PR05MB4235:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR05MB4235;23:rO76S9miGwELU8L3hjYPD8w2ANKZewxDHN4eLjvaE?=
 =?us-ascii?Q?R1/JkeY+Kumog8lOj7oS7AP2xcvJMtL2AjsKOdSrs4limKd5/mUildqu7ADG?=
 =?us-ascii?Q?RkImdOpQsNnuL65eZBmuQmVCHW/VuZS2hoWI7hwkXFN3Ixr7AgtCSmow+V/k?=
 =?us-ascii?Q?XWbW1gBRDL0IDvArJx3VF4v8ys5kX+qGiAbWc54VRa7OktnNJ/7BCSZZ2Sa7?=
 =?us-ascii?Q?kPntMG0G0IIVmyiU43VzYVBXQ/MLNMMpqXv9H9N2dUCH4xTEwQ7LG1MjRntq?=
 =?us-ascii?Q?ZrpS64fCV1d3t8kaDkWZeBsLWnJHu/+Zbg2h0Apf2mkWZHv4WtmIo1YPGxIJ?=
 =?us-ascii?Q?OnTbkgdgLZDv86z+2anmQi3iD6uUxhE78KLDzQ1smJz3fBE5JjvKdbbZcQRk?=
 =?us-ascii?Q?+bYpl6Fi8pwdwgz21Q35LBQATuZPNCW4Aqi1a1wuGIH8s3P2GU7aqKzz20ci?=
 =?us-ascii?Q?4UZ7vAvysGqu4CF0D0lsOSl7vUW756IG8A5jOuRRp4A+dh74G1IWCU/ssn+P?=
 =?us-ascii?Q?72zq26teFclFQ9qmS3UGSYLU36uBZDZyNqSm6qWIp89W9X+gWx0Wix+b3zsn?=
 =?us-ascii?Q?jcPE/Jcedibh1hhz05yeW2OUZ0LIe7SlndQcnnNyb78eRr0lM6meWUzribdj?=
 =?us-ascii?Q?xipHcyO4Dp3CcXcRKwx60jsgivQjzzLpWLzPDW0H8U/qZZlKF4v92Kc2NiEK?=
 =?us-ascii?Q?aNs1s2MkUDUKH/f/WbM5+jQ7fg9hQ7Vv4+liouddvcPNZ7T40M6Ao5BzQwMy?=
 =?us-ascii?Q?opEPvUwgjAQ6cSiGhKub3PYS1iM0ubzDDx2wjz7LHhPN5kF+p6pHFF5nE1wn?=
 =?us-ascii?Q?87rweyPnPul2ACKAtNe8Sb9DjDRks+FWRa4mIgx5GlYmIe6Q3hTnfRHA7G9/?=
 =?us-ascii?Q?mMCVgBl9yAIw3/4vyu93w27ctibwI7opPD+Heams0tPQYhfUmuBy0TzV+HoD?=
 =?us-ascii?Q?PdzAqgRYdP/eJu3Xyy5SIKR90Q3UCvU2+j87/mRaNtP3FQL4U5yhEwh47HlW?=
 =?us-ascii?Q?p7wDicLrd8rc2p7pfsbfNpzyBUyO78lkLVrHLVkArEoPzzXCKQF3j/uxIii1?=
 =?us-ascii?Q?msCLAB7DdBj7/gWowK0RH1Ub/VLwCh1oiDbBmc9lzmF+YsfSnQKURR3oeSJr?=
 =?us-ascii?Q?am6h7nJjw/0saMUzmgy96/Rcr2+RpUS57HeYHrQjkUl+c5g64mtz5AiK3OzG?=
 =?us-ascii?Q?MJY2l8sOT/GI4oztwnOCqq9lmT0UA+xK7jbD3vs2IFdijO0mnd6f7HGvOWGo?=
 =?us-ascii?Q?wSkoMxAQPGp2y+dG0u9fPS/8GTCeZL4hJiWz8QW?=
x-microsoft-antispam-prvs: <DB7PR05MB42355E597207ABBBF5667C8EBF740@DB7PR05MB4235.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(33656002)(86362001)(3846002)(81156014)(6116002)(14454004)(4326008)(33716001)(6246003)(256004)(99286004)(106356001)(305945005)(105586002)(11346002)(25786009)(7736002)(52116002)(186003)(71200400001)(71190400001)(54906003)(5660300002)(26005)(68736007)(6436002)(97736004)(6512007)(476003)(53936002)(9686003)(6916009)(66066001)(8676002)(76176011)(1076003)(478600001)(316002)(6506007)(2906002)(386003)(81166006)(486006)(102836004)(6486002)(229853002)(8936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4235;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AyszbzE5Nnxa/uIRbFXWfv9KJgEZpbk/VeC+bSsj7j1RBD+KukrA4Oc9etPdiRtNpRxtf+PzZOGSzfu+Qr7FXqbBlKddoKBJiNRxAYhaMQRd6LQrJ6D9XBp57zLPb4nS9AUD2h4DiBz3Z0kJSFzCqbrc5s2+6ksZa87RTRlLvrmlyMPOvgfWqfwoAgkjC4UIhxcfR2MQkD/YlVKYoK7EyFpc2vcEBzafvU/5Z7CUb4cXic3zCkCuuxtFS4fwHPkWCcv7Gzf+M3ieMSTyUTOPt7mSOukXI4mIHSvQ8KEXNnJQqZzwcSFxENj5VW3XgQl7VxTCr5HRxbW1lVCeOAbDN39zmQVa5IvpJIc9slv0bolspeg48KEHJtE+Hru4LqMrDeqgZmJHy5vXnNBDyksqA45K27ifww2jacdHpc4SjGs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E39FCBBC94A814BA95AFE2C74F3D4CF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fb23e3-65eb-4a02-cf81-08d69cb55498
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 13:13:13.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:14:27PM -0800, Florian Fainelli wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net=
/ethernet/mellanox/mlxsw/spectrum.c
> index b00f6f74f91a..995426ea9a43 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> @@ -3660,7 +3660,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *ml=
xsw_sp, u8 local_port,
>  	}
>  	mlxsw_sp_port->default_vlan =3D mlxsw_sp_port_vlan;
> =20
> -	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
>  	mlxsw_sp->ports[local_port] =3D mlxsw_sp_port;
>  	err =3D register_netdev(dev);
>  	if (err) {
> @@ -3677,7 +3676,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *ml=
xsw_sp, u8 local_port,
> =20
>  err_register_netdev:
>  	mlxsw_sp->ports[local_port] =3D NULL;
> -	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
>  	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
>  err_port_vlan_create:
>  err_port_pvid_set:
> @@ -3720,7 +3718,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *m=
lxsw_sp, u8 local_port)
>  	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
>  	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
>  	mlxsw_sp->ports[local_port] =3D NULL;
> -	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
>  	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
>  	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
>  	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
> @@ -4441,12 +4438,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_=
core,
>  		goto err_span_init;
>  	}
> =20
> -	err =3D mlxsw_sp_switchdev_init(mlxsw_sp);

I missed that and got a trace as soon as I tried to enslave a port. You
should only remove mlxsw_sp_port_switchdev_init() and not
mlxsw_sp_switchdev_init()

> -	if (err) {
> -		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
> -		goto err_switchdev_init;
> -	}
> -
>  	err =3D mlxsw_sp_counter_pool_init(mlxsw_sp);
>  	if (err) {
>  		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
> @@ -4517,8 +4508,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_c=
ore,
>  err_afa_init:
>  	mlxsw_sp_counter_pool_fini(mlxsw_sp);
>  err_counter_pool_init:
> -	mlxsw_sp_switchdev_fini(mlxsw_sp);
> -err_switchdev_init:
>  	mlxsw_sp_span_fini(mlxsw_sp);
>  err_span_init:
>  	mlxsw_sp_lag_fini(mlxsw_sp);
> @@ -4585,7 +4574,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_=
core)
>  	mlxsw_sp_nve_fini(mlxsw_sp);
>  	mlxsw_sp_afa_fini(mlxsw_sp);
>  	mlxsw_sp_counter_pool_fini(mlxsw_sp);
> -	mlxsw_sp_switchdev_fini(mlxsw_sp);
>  	mlxsw_sp_span_fini(mlxsw_sp);
>  	mlxsw_sp_lag_fini(mlxsw_sp);
>  	mlxsw_sp_buffers_fini(mlxsw_sp);
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net=
/ethernet/mellanox/mlxsw/spectrum.h
> index a61c1130d9e3..da6278b0caa4 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> @@ -407,8 +407,6 @@ extern const struct mlxsw_sp_sb_vals mlxsw_sp2_sb_val=
s;
>  /* spectrum_switchdev.c */
>  int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
>  void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
> -void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
> -void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
>  int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 =
fid,
>  			bool adding);
>  void
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index c1aedfea3a31..f6ce386c3036 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -1938,10 +1938,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port=
(struct mlxsw_sp *mlxsw_sp,
>  	return NULL;
>  }
> =20
> -static const struct switchdev_ops mlxsw_sp_port_switchdev_ops =3D {
> -	.switchdev_port_attr_set	=3D mlxsw_sp_port_attr_set,
> -};
> -
>  static int
>  mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_de=
vice,
>  				struct mlxsw_sp_bridge_port *bridge_port,
> @@ -3545,11 +3541,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxs=
w_sp)
>  	kfree(mlxsw_sp->bridge);
>  }
> =20
> -void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
> -{
> -	mlxsw_sp_port->dev->switchdev_ops =3D &mlxsw_sp_port_switchdev_ops;
> -}
> -
> -void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
> -{
> -}
