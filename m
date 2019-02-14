Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971D721900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kc0042vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394777AbfBNNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:02:09 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:26908
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727411AbfBNNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taoqKH+u0vFdnuhCwIy9rb2Pz4hvXRRwDkKg+1C/JF4=;
 b=kc0042vm45RZBSnaOAusSYl7wcN8mSzO3JzBvwX2cwWQCsB99Hun3h8JKzx426wrbgMQ5iklmKEhwLQtV4e/399M+bLPZ25PJKtx6JW64ELWK+qdEFdBnKuGRycuuRPue/Zd4JSxVf1qyQGHRpVb4+1hqr9q9IOa/NPOO0WW6WA=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5015.eurprd05.prod.outlook.com (20.177.36.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 13:02:04 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 13:02:04 +0000
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
Thread-Index: AQHUw+iLO1HVI2mp4U2l6bBnmXFAs6XfJqMAgAAcfQA=
Date:   Thu, 14 Feb 2019 13:02:04 +0000
Message-ID: <20190214130200.GA11526@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-8-f.fainelli@gmail.com> <20190214112002.GA8698@splinter>
In-Reply-To: <20190214112002.GA8698@splinter>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d944c2-ebbf-4c2a-4f84-08d6927c9d84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5015;
x-ms-traffictypediagnostic: AM6PR05MB5015:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB5015;23:7JWIh0JYvf/eyB/MbPRGpniRD00oUhoBVBzgKMccB?=
 =?us-ascii?Q?eMfxSe+3NMGHXvNQkArbwvYR4st5VwOojhL95D4PIrMQBv7+ciEjAsq4mnrF?=
 =?us-ascii?Q?i9qJEEQrRO73SBzrc3qQuJO8MwI5yYDgFm2Y2DPTxOl5hUyYU59Pae6GqZLE?=
 =?us-ascii?Q?ApWEKbGFfA3eb90hCMInz4KfTO3EXfr6m16QB9rpa255csPvZX9DUd0VUXEA?=
 =?us-ascii?Q?jT+DpOtNrhOLh+dAXbsn4bz+GCEn05N6xXE2auBgeNQaTc76mpAJ/4Ctr1u7?=
 =?us-ascii?Q?QRYs2yZ0x/W4jRu5+kjfuH4ZLK5+l01pEhgWay1hVK6TE5uk/zen0e9LLJMD?=
 =?us-ascii?Q?IJEh7wuUlIQ+pFCgqAWiPKcMSfWOJ2EgZRpgD3jlPJ8ZoQhbnDZLtweEX7m+?=
 =?us-ascii?Q?TcDCTrkVknahzzG+MBy/2seE+WrMsv4aSDTIh/U6fwDQUCYdvJXXr4WvQCsq?=
 =?us-ascii?Q?U0Fy5Ki0/18id8J+ADUvAdcbICUB371jrVKyindU7Rg3KbDsiFVR3vaPT3vI?=
 =?us-ascii?Q?uzQ+PLqK/gSvMmBzR4AEjtBsE0Jkq98Nrh3glN3Tww3QDyw5dluVm63phbz0?=
 =?us-ascii?Q?VaGCLa5caO+Qx+pHpFGXEc16X8g7ejetlyBTTt0YdtBXrFU9t6Cj79GzGsAb?=
 =?us-ascii?Q?UhQNv/Hwu5ebuNkJbm+BHpCmpUSr7W3nXQFVd+5BKnTPrIN2yODTCTBhZBTb?=
 =?us-ascii?Q?kxbBEd772voGLvYVAYwYswartXHA5mMj/Ij88heIut81Q6Q4AZznKEPJIZ+8?=
 =?us-ascii?Q?FSI2vvzVY8+AltVqu3Uiiq2aNgBbhhADqClxdTv1mefB3tofMEzvlR36VVHl?=
 =?us-ascii?Q?aPH65N6Rmv+6hhAopIDzd+GJogRkvk39ZFqtell5g1QkV7OXdmSMbjlWX+/h?=
 =?us-ascii?Q?fjkN+rD6vde75CXp0j1budubCrgf5zHSkZfhytPk2e2SeCPXW5fo3vODd2W/?=
 =?us-ascii?Q?G04WDBZ3kSwM4jqCQ7HdKU3VtesfwjyMw/P81PYJSHSoi+N+XTWs9M7rwJaq?=
 =?us-ascii?Q?Fg6Qbb1GeQnonrLsJBWSwCB0eivr+K2yk0x0jToHz0vGELHL+W4milh+rXIh?=
 =?us-ascii?Q?HmsUqtmHMsK+fVGS9gP2lqkuY5mNwf+nzbnYk0jpXyryXe90lhPhG9bUgHLE?=
 =?us-ascii?Q?V2MKSZlwHtGpVDS0p7ssAQT6EFU1IuIkqowPg2L5G+ONgIEO68ZjTgATgnA8?=
 =?us-ascii?Q?utljd+sDpqrqTS6yC/s/KTlR//U96rXJI/Lug+P48efTWfwVWwkXnP3RbF+F?=
 =?us-ascii?Q?LQVESEjuSTkc31BQ5Y=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB50155E838BE13DD269BB1AE3BF670@AM6PR05MB5015.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(68736007)(446003)(186003)(6436002)(6486002)(26005)(11346002)(476003)(53936002)(9686003)(6512007)(6246003)(386003)(33896004)(6506007)(7736002)(305945005)(25786009)(4326008)(54906003)(316002)(71200400001)(8936002)(86362001)(478600001)(71190400001)(81166006)(8676002)(1076003)(14454004)(81156014)(6116002)(2906002)(3846002)(486006)(229853002)(102836004)(33716001)(105586002)(97736004)(33656002)(52116002)(256004)(106356001)(76176011)(99286004)(6916009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5015;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: epDODqXkjFDehrMcBQOencC/9V6O4H2wIYRbdbjfEI2Qq62Ftf6CPb0iypZ/dt7mGs1T+d75O6vOXwtGQ7CJagfNSwlFFFKpwQZqsWGbrzOGJMcui2X8JwjN+36BvKqEPfqKziiKBxNeWuO47zQgn6/uWpNNNTz5kJ13gL6ad3l4wT2Fv8EaBTRtKyf7cLEc5dY36FYrPJyU10Ht27HI5Gi1eNEdO0W/2g43Jq8P12WTTcFu9YmknQzQDE5og9wIzCznKmMJM13P6myOc5xwlAOYZOR+Rk3rxcYfDI8sibGs/jE18SjHEW7SG172pL9Q3koVgh9h13UF1/4BpRaWTYuc6+MPSRcNmP+r5h6LwL8bCi51UZF1wF46Qw68ceU2FncpFkp4n4O/SbTsGt1OyYFcLufw6kx5qdtXW1Xvbyk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0181B3150F1CFA4AB631F6788876238A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d944c2-ebbf-4c2a-4f84-08d6927c9d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 13:02:03.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:20:02PM +0200, Ido Schimmel wrote:
> On Wed, Feb 13, 2019 at 02:06:36PM -0800, Florian Fainelli wrote:
> > Now that all switchdev drivers have been converted to checking the
> > bridge port flags during the prepare phase of the
> > switchdev_port_attr_set() when the process
> > SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, we can avoid calling
> > switchdev_port_attr_get() with
> > SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT.
> >=20
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  net/bridge/br_switchdev.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> > index db9e8ab96d48..8f88f8a1a7fa 100644
> > --- a/net/bridge/br_switchdev.c
> > +++ b/net/bridge/br_switchdev.c
> > @@ -64,29 +64,27 @@ int br_switchdev_set_port_flag(struct net_bridge_po=
rt *p,
> >  {
> >  	struct switchdev_attr attr =3D {
> >  		.orig_dev =3D p->dev,
> > -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> > +		.id =3D SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
> > +		.u.brport_flags =3D flags,
> >  	};
> >  	int err;
> > =20
> >  	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
> >  		return 0;
> > =20
> > -	err =3D switchdev_port_attr_get(p->dev, &attr);
> > -	if (err =3D=3D -EOPNOTSUPP)
> > -		return 0;
> > -	if (err)
> > +	err =3D switchdev_port_attr_set(p->dev, &attr);
> > +	if (err && err !=3D -EOPNOTSUPP)
> >  		return err;
> > =20
> > -	/* Check if specific bridge flag attribute offload is supported */
> > -	if (!(attr.u.brport_flags_support & mask)) {
> > +	if (err =3D=3D -EOPNOTSUPP) {
> >  		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
> >  			(unsigned int)p->port_no, p->dev->name);
> > -		return -EOPNOTSUPP;
> > +		return err;
> >  	}
>=20
> I see that you return -EOPNOTSUPP from drivers in case of unsupported
> flags. I believe this is problematic (I'll test soon). The same return
> code is used by:
>=20
> 1. Switch drivers to indicate unsupported flags
> 2. switchdev code to indicate unsupported netdev (no switchdev ops)
>=20
> I guess that with this patch any attempt to set bridge port flags on
> veth/dummy device will result in an error.

Yea, that's the case. You can test with
tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh and other
bridge-related tests we have there.

Another problem is that during PORT_PRE_BRIDGE_FLAGS you pass 'flags'
and not 'mask'. This breaks mlxsw (and probably others as well) given
BR_BCAST_FLOOD is set by default.

>=20
> > =20
> >  	attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
> >  	attr.flags =3D SWITCHDEV_F_DEFER;
> > -	attr.u.brport_flags =3D flags;
> > +
> >  	err =3D switchdev_port_attr_set(p->dev, &attr);
> >  	if (err) {
> >  		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
> > --=20
> > 2.17.1
> >=20
