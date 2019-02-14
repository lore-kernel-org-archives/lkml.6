Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB1218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Fxp8RL5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbfBNMKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:10:24 -0500
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:60495
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfBNMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQXvtCS4f4SwLfqPzHcrX2Vq7NAG/Mu5tTTft1kSskk=;
 b=Fxp8RL5XnWx/mc+9AwjckRSgSnAjI6i2qLREEXvEFeDUvwv5YmYvo7mJ/x9sjBv2iKUQ1fJ4Ckk6T9qArql9ghKja4HNMracwfYjWPgshpCRvS7pNcD+WyGXFAE4OH0c0LEqejqKyufW5/eOtfjVF6Q8hULfOJT+4A4bHjxcaxc=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5334.eurprd05.prod.outlook.com (20.177.197.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:10:06 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 12:10:06 +0000
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
Subject: Re: [PATCH net-next 9/9] net: Get rid of switchdev_port_attr_get()
Thread-Topic: [PATCH net-next 9/9] net: Get rid of switchdev_port_attr_get()
Thread-Index: AQHUw+iSQCwOPnWAGUu5pephKEE5faXfNJ4A
Date:   Thu, 14 Feb 2019 12:10:06 +0000
Message-ID: <20190214121004.GA10467@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-10-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-10-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::24) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3dc2288-cb0c-4d42-704e-08d692755b7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5334;
x-ms-traffictypediagnostic: AM6PR05MB5334:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB5334;23:yIvtPt1d2CiaTFInJ0E80JcblNbsT2sM+1VOXEVV9?=
 =?us-ascii?Q?VM9buiOByZAgt7+bITP70FwlPeQSp28XVa1dkuq5lykqRz62ha6L3HUWYsfa?=
 =?us-ascii?Q?u8jbNsFmd7bkyob+6/yI6oQ1TFOKNPUzi9rGZjDnMvAebUlr6qVKjb5MYC4S?=
 =?us-ascii?Q?EYvxdiniUAtgJ9JQM7/X5bJi5qfywhmVs8D/4wbBQfWSrmRHH4H7pLDe8VeY?=
 =?us-ascii?Q?CleVsF2iaJ6iNdlf/XBpKA8riBxcYsJ3CSJZszbAOjB8Z6yd56/hV6gzWw/i?=
 =?us-ascii?Q?RmNwF+KJ/SSvaawStmNn5uY/x7axcXmJBybrWTUGe8Eo69N6/Bra2lK3tq1h?=
 =?us-ascii?Q?mHtdW14t++N3tLhuQ/zjNt0QaWO1u5gri4aZCZtuHYbYSRJSfG9hfdgKSF7w?=
 =?us-ascii?Q?QqcEzttfKi2gfmWj0HuORulHiwC8+2vPQjrhBKNVkOQlj1ErDS5CE15l68qt?=
 =?us-ascii?Q?XE4nrfjFItFjs5688IbpjN+e/dqSj1F8yASdmasc3O47ak38y981an8cWdnB?=
 =?us-ascii?Q?ImbudFw6kWe2PZsR0KXkFYizzm5IVkkielfmY/k2OT0xENnymqgXrTP3RMT0?=
 =?us-ascii?Q?Fu5SjPK30mA959jo0fgG/s7N2t9+oFhTrvEVrZYyPrH4PPQF78BTGhCoyHb6?=
 =?us-ascii?Q?+yZ4+sJkUpsfwQLaWViFHPebmDUQYQFMOuyVevnTnrymS3laIItOFlwYyGiv?=
 =?us-ascii?Q?ZWMTI3y4KiAewaLo879jtPzMCuSm69SUQh8nbYz0cPhWUpcxO3s1xHQGMiUR?=
 =?us-ascii?Q?XipsheCxQG5/VI8gF/moSqiMSzBkrSF4oUHRAKHlvMubAs3brPuTRYPSIcoO?=
 =?us-ascii?Q?WF3b+/34kgR5ojeAAzG1gSceL+pHp1+za1JrUq13F5wSoeobc87A/2tiuDrn?=
 =?us-ascii?Q?TSR5re9tE6nrNC0VzPDsASfELkxfZ5TuNcS+sCwt9JPUHdfh/LqOYf7syMJU?=
 =?us-ascii?Q?K1EglOn9rs+mdLYAigiU9eNtXkaQXteHAwA9Noqix8YxGfS+knqTwiruw95l?=
 =?us-ascii?Q?DwA/qjrPJZIvvwnbnzvYchKM+6bWHFnROEjIDWa4mYgur4ePJ6ewSU4uSc9e?=
 =?us-ascii?Q?8ApCCwhyZE9gGPrZ0GLyWa69uU13i24+yJQBGqj8JafZnlL4ms569dA1N5gM?=
 =?us-ascii?Q?wcpNO5h8CaCxHuqE0W66BfmCY21f6CpviVhFYCk6ud5aHq6L1NgQQjR52C78?=
 =?us-ascii?Q?uWlZGEmUqRjjYByCdVLGNOFABqCwoLxUg8q/xbqevdoUVRkyeMTleCOH3NnP?=
 =?us-ascii?Q?lA5SK5hC9ZaggODc4f2dhY1GF7sGOAgOIqfsN3T?=
x-microsoft-antispam-prvs: <AM6PR05MB53348D38F7447D830B4C54E2BF670@AM6PR05MB5334.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(102836004)(8676002)(81156014)(6916009)(186003)(386003)(229853002)(446003)(68736007)(478600001)(66066001)(6246003)(25786009)(81166006)(256004)(6486002)(6506007)(316002)(86362001)(26005)(53936002)(97736004)(6436002)(14454004)(3846002)(6116002)(305945005)(6512007)(9686003)(8936002)(476003)(52116002)(7736002)(105586002)(4326008)(486006)(106356001)(33716001)(11346002)(1076003)(33896004)(2906002)(71190400001)(54906003)(76176011)(99286004)(71200400001)(33656002)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5334;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qYDKjn9kylkbq61X6i1BXDnOZJwvmE21DXnmz3m0YmCKIzORgDvqJ7z7uGgSiFJLojaCclBMRfmE2MM9Hw/lu6xV0fQWoIO3W1OSAfTn/kNumFAm2fT9J46NOgMwO28lXcvknwzbMdlOKI1Vh8i1+ET3E9nAzrdaThNMpzC6EH0A/jcvVTTqLic9RIdCbVgrBLNPwjYuGwk6xvrRWOlBZM8aaoQhhT27Dwc6WD6a5QU3ofQ44SsrO68rneO+HfZ+6HKw41VN3MsrnQDgC3vGPdLp+MU66XwiGCr0xBxU5bUmrjIy+5u/daLpEDOmKB+83ILgOx+/v2C9NvcxGT3/JmWqsbfnuTIiOIBstY19VzLQu7gQJZ2UyJRed/6v0DDhDoBNrU5oYLo/FxE9acrvQWxoH2QYtK9Ml8Ky4Wu8P3M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BD5E98B18EB1941AABCED862FF448CD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc2288-cb0c-4d42-704e-08d692755b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:10:06.1349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:38PM -0800, Florian Fainelli wrote:
> With the bridge no longer calling switchdev_port_attr_get() to obtain
> the supported bridge port flags from a driver but instead trying to set
> the bridge port flags directly and relying on driver to reject
> unsupported configurations, we can effectively get rid of
> switchdev_port_attr_get() entirely since this was the only place where
> it was called.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/networking/switchdev.txt                   | 5 ++---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
>  drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
>  include/net/switchdev.h                                  | 8 --------
>  net/dsa/slave.c                                          | 7 -------
>  6 files changed, 2 insertions(+), 39 deletions(-)
>=20
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/netwo=
rking/switchdev.txt
> index ea90243340a9..327afe754230 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -233,9 +233,8 @@ the bridge's FDB.  It's possible, but not optimal, to=
 enable learning on the
>  device port and on the bridge port, and disable learning_sync.
> =20
>  To support learning and learning_sync port attributes, the driver implem=
ents
> -switchdev op switchdev_port_attr_get/set for
> -SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the at=
tributes
> -to the hardware defaults.
> +switchdev op switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_F=
LAGS.
> +The driver should initialize the attributes to the hardware defaults.

Last sentence is not relevant anymore. learning_sync can also be dropped
