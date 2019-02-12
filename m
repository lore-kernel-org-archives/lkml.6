Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085922083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pt+FVe2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfBLOUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:20:31 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:46592
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729355AbfBLOUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AGNg/GeKHToB/MDS7WxXteISH803hgikz8I3tH/pqs=;
 b=pt+FVe2VL/m308LgWrGaf5CXk6U7GW9xK6bDN2gATMqsgLTor2IIlDSRuqMEdeyeP79ImF8VyusNZuOV/Rk7DAeaplSDkK05g2/CpYIwoPilvQTaUeY2VTkNOlnK1gtODbzOz5U3xKiu+3nKQ0IHtl75fwmuDjBsBvPWn/llO10=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4150.eurprd05.prod.outlook.com (52.135.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 14:20:26 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:20:26 +0000
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
Thread-Index: AQHUwWmHaAhTrOwTokiOiWycLCbv6aXZZDiAgAAIKgCAAsz4AA==
Date:   Tue, 12 Feb 2019 14:20:26 +0000
Message-ID: <20190212142022.GA18413@splinter>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
 <20190210175105.31629-7-f.fainelli@gmail.com>
 <20190210190501.GA26726@splinter>
 <73a10fbb-7689-74a7-3fbf-076f8dc9d76f@gmail.com>
In-Reply-To: <73a10fbb-7689-74a7-3fbf-076f8dc9d76f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::20) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB4150;6:Qwj1QNCclavUW8OISzYFPh4+eZgF7vL1oKalZE1p9xdUt6i2yUWuESMXd03awOOy6roiX2o1BvqCTSQjTw8P+ttVOWU4CoDmW/B6t74jNUyqg2Q7Smae2K6B9s6P6vOj3oVBpxIRxt1k8WNJvSc7NB/CJ5xvYumMrz2kAdzEKr0uM1tClqtfKwvMdboVsBqAyIkhK5dlAqOqroFaUEk75E61gUz6tiYnIVuq21LCn7YRsocnbGwLQvvW4DmGm51OtrynFE25KrA8BjbFnVxiLzrNLbBRanbW7tor9WYQtN8Yj++vjB9/2qsSHIQ5JnQ2Y+MLLLxx0V1q/luojv8ydv+yZLRZCtC90y+2znUVt3UvMORjBFxHD7OQDnTryphdSpQfavhcBoV0jzVkB6jNZPmzz1Qe4KY2NgRJbIbvXTkoqwYtoz+6EiqzZaxKyrgxc8zrhMmAmwPlHcUf8cetzQ==;5:9RMWXthHIKEHcYXN2bgjIC+J/2jtaFOnej/+sjEvtvh9IWR+Y0Uk/uEoPgr8buCqfBJU84hBnetiEJfPn59VQR+zqyUMr50wtGQA7zTvmOmuNi13Jlmn9OI0Cu6nfO4Q9WntAT3r7ex2BDYPwAhWAJj6UGoqmwf6MX3S1wouLjxHJnf3M38jFfYX1ZOADkIdQqO8yfA4qXlfMnR/ZyrLNA==;7:zXCI+JN0lTucQ5Lq0IVufqkFbvBNFp2PBVOkZL8Y3dZ3NAd5T42xRWMOIzRgN1xyIRL4noBmAYlbaP1nSrmuguQPXBr7RNMYeilzA9yvL/5bboE9g/jE0GsLC6+2lLm9VVY5jyc0qU4NDwrd/ua0lA==
x-ms-office365-filtering-correlation-id: 7939cdca-0913-4437-493a-08d690f53b86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4150;
x-ms-traffictypediagnostic: AM6PR05MB4150:
x-microsoft-antispam-prvs: <AM6PR05MB415070C871D2D48A904BA996BF650@AM6PR05MB4150.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(1076003)(93886005)(81156014)(102836004)(305945005)(229853002)(54906003)(476003)(8676002)(86362001)(52116002)(2906002)(446003)(33896004)(11346002)(76176011)(66574012)(316002)(81166006)(25786009)(7736002)(99286004)(33656002)(105586002)(97736004)(26005)(106356001)(71200400001)(386003)(478600001)(9686003)(14454004)(6512007)(6506007)(4326008)(71190400001)(486006)(256004)(66066001)(6246003)(68736007)(6436002)(33716001)(6116002)(3846002)(53936002)(6486002)(8936002)(6916009)(186003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4150;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFb1LR7/VAC5AxJbTZ7m/RRiUgcjEoHxkq1N9HAolhq/si2+lZQBlCbIkfsRO7K9i6942G0iSpPX6SXpgd8c+xdx1zWdaI26Z3UQaBcQUJTB6kqkDG4mZNOiZVnzI32r3NVQZpSmiHzeV5gJ/A2DfO6xyHcbZcHL2i10SqQop1jQUUqLGzVRsoNcBMHseG5GY1CqO7F9yUdc1DlFlA/qA+N+7bH+sGrKCjXARMF+8nfcJ8TKkxKFFVXx9CZA9FJaJ2C/UnB8uMIwMncrILbrrUxgqw5tTiB+lawK6B2o8794WC+ZfyxEqy1s7CMYH2Ma1rTYVCk9GDrvfWkPG/gpa8vVA9KucDte0I5H+R9YbfaFMi678gZGjZhmfF15wiAZw3EgYzP/UA5KZPXd85DYwlPMXK2SepIxkD5moh7/+lg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <30B436DADF936545A9B793667EE71C4E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7939cdca-0913-4437-493a-08d690f53b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:20:25.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 11:34:14AM -0800, Florian Fainelli wrote:
> Le 2/10/19 =E0 11:05 AM, Ido Schimmel a =E9crit=A0:
> > On Sun, Feb 10, 2019 at 09:50:55AM -0800, Florian Fainelli wrote:
> >> Now that all switchdev drivers have been converted to checking the
> >> bridge port flags during the prepare phase of the
> >> switchdev_port_attr_set(), we can move straight to trying to set the
> >> desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
> >>
> >> Acked-by: Jiri Pirko <jiri@mellanox.com>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  net/bridge/br_switchdev.c | 20 +++-----------------
> >>  1 file changed, 3 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> >> index db9e8ab96d48..939f300522c5 100644
> >> --- a/net/bridge/br_switchdev.c
> >> +++ b/net/bridge/br_switchdev.c
> >> @@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_p=
ort *p,
> >>  {
> >>  	struct switchdev_attr attr =3D {
> >>  		.orig_dev =3D p->dev,
> >> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> >> +		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
> >> +		.flags =3D SWITCHDEV_F_DEFER,
> >=20
> > How does this work? You defer the operation, so the driver cannot veto
> > it. This is why we have SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
> > which is not deferred.
>=20
> I missed that indeed, how would you feel about splitting the attribute
> setting into different phases:
>=20
> - checking that the attribute setting is supported (caller context, so
> possibly atomic)
> - allocating and committing resources (deferred context)

Yes, this is what I suggested in the other thread. Lets continue
discussion there.

We are doing that when processing route notifications (for example), but
we are missing a check in caller context that resources can actually be
allocated. That's part of a bigger task to track resources in mlxsw.

>=20
> For pretty much any DSA driver, we will have to be in sleepable context
> anyway because of MDIO, SPI, I2C, whatever transport layer.
>=20
> Not sure how to best approach this now...
> --=20
> Florian
