Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4213C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7A52133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TdO7mDAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfB0MbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:31:00 -0500
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:15054
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfB0Ma7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF2DPQM/h2pAHkWfftAEy8gv9951yq5x75hNP4aoJQ8=;
 b=TdO7mDAiWMLFLBYDP+j+mKEro7alyc7Ur3KQO3Rxgj1Jfs4h/3N1rWtgMpfWj9nYPs1uZ+l2KggnX6wng0xYJWRvDM+Z5d1WtNrNIfrCs6PFDXwNyZnw7cIOERMc8C26C+2w/rTYrGUHjvg3lrGyylClXzyruYVdCx5h4mkENZQ=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB5209.eurprd05.prod.outlook.com (20.178.41.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 12:30:55 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 12:30:55 +0000
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
Thread-Index: AQHUzjnl2DtkmmJzfUG7KQyITrdbn6XzlBuA
Date:   Wed, 27 Feb 2019 12:30:55 +0000
Message-ID: <20190227123053.GD13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
 <20190227011427.16487-9-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-9-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::29) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab69894-393e-4529-ceb7-08d69caf6b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB5209;
x-ms-traffictypediagnostic: DB7PR05MB5209:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR05MB5209;23:F5pno6XRBB1yRjE0pKi9bMWFD6F7B+nHdb9jea7Dg?=
 =?us-ascii?Q?84iBvmPYacr5Pw0YHMwOxX0c07NAq+1MSplT7xilfZAqd4lPTbkS3OmITvTf?=
 =?us-ascii?Q?pmLZ2Xr+XwfTDL+6kZmw7HK+ufpj8tTKxEdol0uj2Em9/0a0c5jUBSs93ydd?=
 =?us-ascii?Q?S1t/21tCGayNZzJSOCC9qC1rwfAS0oWmUTLkSAOaGUWoURF1sKmmTsy+fWm5?=
 =?us-ascii?Q?nDRHs8xAobT1tGAfmqfWCt+b3SZ548APkKVb5gS3trFV9O8YUGApojI5MROx?=
 =?us-ascii?Q?ZMq6Au3OxDiRrp2FyoMB/fph5Ljm51X1qpVijJRWfqlSuSK//qsfj83+s79A?=
 =?us-ascii?Q?8nZhCC8iMwWI2bawxDMrYYQ5dXKX2Ny7+6GlBHoHQNVtdy1Con0SWZh5NPSm?=
 =?us-ascii?Q?k1AXJtymj6/El71OfWSrDZliNHuiBjpHmIJHCTFoFyFXPFAg5jRz9lIp6E5D?=
 =?us-ascii?Q?KGHCnFPrqpQ2qoh0lCUcIBcYuaA7BFo5tYChKYOV18QlNAk8pSjb3PxbDbcD?=
 =?us-ascii?Q?0SRt2aEkZMeyH7+SQK/648HdQjLwCEF96EzIwQk1eDAgwnAv9mdx3iPfrcjC?=
 =?us-ascii?Q?9/67F3n38wLQ3ZctaEK5JfXNlcHAV93+My+h0+A/+Kvn0B2gbTCKPKz83v7i?=
 =?us-ascii?Q?FxM7hgZ0d7YGgX+8ZZ5UMmNrGw/FuafjnaCsss6P4B3/xbbfXdZ5h0jkbIOI?=
 =?us-ascii?Q?upR+pU4cXyEKgtePVVNEtmwIe1tClP60cybZt9kktUxQrOIDT3g5FFUoKILP?=
 =?us-ascii?Q?PBJjWXA//aAg/XIWFnfHGWiDprEFL9hK2kWrC9MgU1ix8gUofSHVkLTgmbqf?=
 =?us-ascii?Q?1Zd35cAar2q+Y7DbyR8zm/CvARdiutxm2f+py7q/lU/nTDYVtdickOxndSnx?=
 =?us-ascii?Q?Iy+EtlpcCBjNEOt4H/V0E4l3E1cKOCjqCOT0BwADieeO6XMcURl8ZOF4X++g?=
 =?us-ascii?Q?0z0VxCQlCISXdGDTW+Za6iQ9kTVOuytsiXqzWQh/bqkGFyoLgtWQH0L6VoEg?=
 =?us-ascii?Q?bs+uzVadXNsqMp/CnkDtZQI7clr8ukCwkaf/PSVXFdXf9fF1E4AAz56p285U?=
 =?us-ascii?Q?GQcztthZUGcpvUCUyljxaAj80VincFig+egBcUrUOVX1AKE1lKIl+jbA43W6?=
 =?us-ascii?Q?CyBYLTYLnMxzua2rhjwRFvoOcZXSRizoKvIFjCMWgsDD3WAmdJRpaBQgLCY2?=
 =?us-ascii?Q?CtVvgDtiQ2KJhVlk3MGNLD7DHcuxF6MokofQfHD9dCHUNpd3iui/X8GiLd6L?=
 =?us-ascii?Q?+YJ+fBpdCSniAkyvMduHbIXw7EarxQEu5OZuGDgMexkG48CrUghXy5xqshyO?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <DB7PR05MB5209F7E1A55DD30B4AD7C132BF740@DB7PR05MB5209.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(3846002)(6246003)(256004)(2906002)(478600001)(4326008)(99286004)(71200400001)(71190400001)(68736007)(4744005)(6116002)(33716001)(6436002)(76176011)(52116002)(102836004)(316002)(7736002)(54906003)(25786009)(33656002)(1076003)(14454004)(186003)(9686003)(6506007)(66066001)(386003)(305945005)(6512007)(8936002)(86362001)(81156014)(81166006)(6486002)(486006)(106356001)(6916009)(105586002)(446003)(53936002)(11346002)(476003)(97736004)(8676002)(229853002)(26005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5209;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HAz94YEmTvcACC63KQT3fiTo4hhjMcaVNdOtnlXsY8/41zW4XRuHJCfYbY9Bk8be2jfcZvhqzaVnehJg4LMTVBK9rkdC/AssoJ5OK8PA0xK3N8cCii9pc9T9MWeBlkKKr5ezFZ5TyJ9DBQ5xTSs+y7MAtGw1Mjz1DYxhSOkkJ/9xZVam+1KDH5QqTKmfzOlbLNkLqPGxyjBbWInJQTXvWFVMkxTrureanOsK29Z8R22kb7dz9YcY6/QIKAq4F+hr2kZHngi3TftzJEsAcSrhyc8Z4sFn8y4lh8WfQ4iKBAG62abIsnQNx5rduZV2+ryH87r1GBj9hG3znvaClJDDrlQH2bQrSDy1AcbSDW7QbiOQgL8LCjEJLdmaPrgaIqnlREqQ13UVek/Www3gAl09QuuZRKlZ02y1sY4lX8Hp2+Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5718EFEE89C03B4B9B1CF1AD45E048DD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab69894-393e-4529-ceb7-08d69caf6b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:30:54.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:14:27PM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
