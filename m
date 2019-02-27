Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AC1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781120863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GHhAfypf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfB0M2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:28:39 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:32462
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfB0M2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB7WEjmYFebb1ka2RaEWjr519S6avl7PPHLsjQg0yJk=;
 b=GHhAfypfKwFcGcoUYDvZVHW6jSg3TF5RCW9pzgK3NRwnNpZ8YzLo1uzNB60LDYOqaip76pVLndClAJA8L1j1/lG/3TgJVKcL2Huq9QFeDYdoJsGEXs4buV3dB+yhb03exBa42Qa1HNsvdjkgpJneh4zL0U0YQ85vuak2lcmAMmE=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB5512.eurprd05.prod.outlook.com (20.177.192.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 12:28:34 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 12:28:34 +0000
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
Subject: Re: [PATCH net-next v2 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Topic: [PATCH net-next v2 7/8] net: switchdev: Replace port attr set
 SDO with a notification
Thread-Index: AQHUzjniJhWVT3lsVUavY9LXj8/GzqXzk3GA
Date:   Wed, 27 Feb 2019 12:28:34 +0000
Message-ID: <20190227122831.GA13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
 <20190227011427.16487-8-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-8-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0082.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::23) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63a2fd11-19c9-4db9-c10b-08d69caf16ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB5512;
x-ms-traffictypediagnostic: DB7PR05MB5512:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR05MB5512;23:Qwrk78QXtYW/VzE/EbJwwNmK/pXYFyeYHMDHPhVC2?=
 =?us-ascii?Q?XJcyW+NfB1twk0ff4q3DRJuYTOmk8ICGJZh7V8rh8ygopt9rPv110aQFf4Ve?=
 =?us-ascii?Q?Qc/mf1tGVaccgcWcivkGakC8XAchN8VWbJ6ZXHY4Cbk5jAt5CCzCfXluZLI6?=
 =?us-ascii?Q?9EQaN3HXwBhtQEgwPuD3iS3bjOvfXXzUJu2bbWGYzrZci4giqtRQNgH00t3U?=
 =?us-ascii?Q?TRDtRy9FtzEVB7eIZBljsA1PNLppjMTk404IXXZn+Nr97Bq2BnzFx0LhO7t9?=
 =?us-ascii?Q?SyHub4VlBHKJkvsddOzkdMXyMpXZO8e1T3wMGptr5itVv7YCMOfxkAB8FcJx?=
 =?us-ascii?Q?2YGwWgHu4AKLjrubGEdMPYJajm13ruttJIFsNsD+XsOUfypr18RDBuH2+p5E?=
 =?us-ascii?Q?6gIvYm5iE+8iGdE+WlJ0kfqnxwbZwQ+rJf+jCz7jqoQ2nc4deTNRerhKMD9D?=
 =?us-ascii?Q?fWQ47FGUEEMMohsfRWFLo3sLlonF2SeEPhUfavGE2FAlq6GdAxwGHtMPRW4u?=
 =?us-ascii?Q?cGiaKm+meCZL5svJHuDeNW37+lwy0Tjp0YmY8QGuHmIxUoSKkVCp48kul5NZ?=
 =?us-ascii?Q?2o/i2THX98P+5cHqOb/SwUknECgDpCmRGEaPfqQHLSzMF38dmYv2dy6GwUSb?=
 =?us-ascii?Q?6rvgGlZ+MdyYqq7aLFAdyja1oSXC3AoFinfkdkJqQY7sRm07Rl00zypNDmHZ?=
 =?us-ascii?Q?6LvS9TPP2Ig313fgFaGXHc7GS4B56lPRhRD17mkhBVE+NTBdAneFGZPFJQQq?=
 =?us-ascii?Q?xhc4hwSaskdJwm07aIonCTqJAznYhqBs9y1yFMVkcp17YdkBQzn3KvBpmC2u?=
 =?us-ascii?Q?wbNuc1VbNi3uu+tR6GxmAn5LSpfZy/hlHt/M9OHEBBqBWwi5/ogTbxu5jfTa?=
 =?us-ascii?Q?hLxvGlVRurhNjA+vMMIY+hOwd+Dz0LBxcuYVA78U3xxiPIYXjyd4LssI2U+0?=
 =?us-ascii?Q?zB7qvmPa+kWYQ586B0IQH7aSv3AnwcB3fuXKyKNkeb60NvTUw7dncVDRd0in?=
 =?us-ascii?Q?cCttJls3ueRI7rrNCTmTPYvqtLeUGVb99vnus/Fu4/67PbsgZtHGnf+4qLiZ?=
 =?us-ascii?Q?2bUyNsjSid/+iihQzfwa4Lk//xZfPvVh433uSLOJtkJvizlxS3jX+DoX63tp?=
 =?us-ascii?Q?MRX0ztZpmO1yxz+YfxVvMEBp2G8zoq2aZ8rUV+1WaRJ7pnrpsK5OaLuyWrIS?=
 =?us-ascii?Q?2vl8e6oPGkkD/Xo1Mzr2NEoq/JK9wT/2UUvrtFzVp7uCYV/bIiV6zmHUzi50?=
 =?us-ascii?Q?ZSRw0Y6747qMyDdoiYiBJTInepLbw4YnpjSJOAO0QUyDmoonAV4snypsYkWr?=
 =?us-ascii?Q?JroHuszZq1gbNEt5YtcMEnx1d1PViZ2WH2gUyqD0rrr?=
x-microsoft-antispam-prvs: <DB7PR05MB55129A2A5DE57C04BF19E292BF740@DB7PR05MB5512.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(86362001)(14444005)(6916009)(256004)(8676002)(446003)(7736002)(99286004)(52116002)(11346002)(6116002)(3846002)(81166006)(14454004)(6486002)(81156014)(6436002)(15650500001)(33656002)(229853002)(2906002)(5660300002)(26005)(54906003)(186003)(316002)(305945005)(486006)(106356001)(105586002)(1076003)(68736007)(66066001)(25786009)(71190400001)(8936002)(4326008)(476003)(97736004)(4744005)(102836004)(53936002)(76176011)(6512007)(478600001)(6506007)(386003)(9686003)(6246003)(33716001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5512;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BmttWfOHwsi/sxw7athdPLy0RYwUyVji5xJ67xovV56+GqyiMwfLAfrElYBuZTmlIXffWCIgIGw3EhfYGDVV/wTs4Ooq60KeVvsS94ijxsXoOKu89nPRnoCI/iyT8G+Yesy5i35GuQFb0J7t2HUBH9pnYGHtS3Kwe1hzUTz9b3xahz8ZBhiiQuvsmpPIsBBUJnTD9ktbOd/tRetmhLxMFGQNoc7tIm5TT/H67o9Jvw6AxBpkxV7yZB11wfxyEicpvfCfIl1AwnuggrBgH3k8AohxqDWnI+YxE7+VCGIEy2s24/ysGwIE0TeyhBaWxRqj5fUCNEWNw+wAt5pKXzWafRJq9w1Vh6G+KSGifOFQp2Xd/R4BUFXskiQRGxvzNcLi6dL3H3tS01J+CkZhgO5u4IH6zJBqgfx2O6OlKZhf0v0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F77EC415C0476E40980E2EDD1F90F65C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a2fd11-19c9-4db9-c10b-08d69caf16ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:28:33.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:14:26PM -0800, Florian Fainelli wrote:
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index af57c4a2b78a..b7988d49d708 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -67,12 +67,17 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
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
>  	if (err =3D=3D -EOPNOTSUPP)

Florian, this needs to use notifier_to_errno() and check for any error.
With the ops, `-EOPNOTSUPP` was returned for devices that did not
implement `switchdev_ops`. Now they will simply not listen / reply to
the notification.

>  		return 0;
