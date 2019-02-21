Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241FFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B92214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Am1rDWzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfBUJ45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:56:57 -0500
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:34880
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfBUJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeHlHNNrzNPV3mCygDTWlC1E79Iod/vReO19jFONyj4=;
 b=Am1rDWzZMtt1nxSV+I9ec5gSJr3+hQpF3mV7DqdPWd9YHGThUAWr8OZ3Z+oRyxk0zSV6mXmLkKX8pXozuQNkFz2a/H4qFqBWOOYsOTGw2Rp8z540GhSpEI8pMAut06IoXtEJDyD1hpYahlY1G062uYKQcURsVgjjyRPiaE1v3LI=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 09:56:52 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 09:56:52 +0000
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
Subject: Re: [PATCH net-next v3 6/8] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Topic: [PATCH net-next v3 6/8] net: bridge: Stop calling
 switchdev_port_attr_get()
Thread-Index: AQHUyYCj56FRy5i5ukKh+EbCkmc3sqXqBIMA
Date:   Thu, 21 Feb 2019 09:56:51 +0000
Message-ID: <20190221095648.GC26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-7-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-7-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::17) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4ecf87b-87f2-4ea8-32dc-08d697e2e73b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4472;
x-ms-traffictypediagnostic: AM6PR05MB4472:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4472;23:OMuGfEtGawpHgEz9ffjr46b+cYLcpBl0Npjc3acjS?=
 =?us-ascii?Q?MIy19SgFiKhwNMkGeUcIxqYdmeGdEYgfFRHiFVWOf0z0oT6P4fb9MG5v0Y3D?=
 =?us-ascii?Q?smr7UjC/y5y98ZBfEIBPn8qtnC2CXjve15pjqTq0PhEGRBhCH2X2XAModMQ/?=
 =?us-ascii?Q?vYTVp2KMQ8lK0MZouysLTdQKhRWvwngYJpVQieWjqK1bnKGC4duYmZod3Rip?=
 =?us-ascii?Q?JJvHQjsHA1ZnhI+MTtTcVU3qivL1UPz+iTT1Cp+1gMBf2iaZLoAI1WZZPjm+?=
 =?us-ascii?Q?7Ud/E1hA7CM8qs5OZ0jgr4YnjtYidw5r0oU/NJQKbNU5kzqTOEAjv2Omsn1p?=
 =?us-ascii?Q?1PQKha71bf4sZhdZJqkL5yYGyskF87v77MkjlkfrnTGL9rRJDfnjrVvQ2gxb?=
 =?us-ascii?Q?hG94GFKZCvU9qv7VaQGqwfSZKc3IsXLAeNSGRZDNMaVecMOzRDPQqDrb5dpS?=
 =?us-ascii?Q?HzbIyWDpaEcY5vgv8c5Tz5WWfOo0uSynZBaFVdjdZm/YYBwElY9rdnVeR+V8?=
 =?us-ascii?Q?shE43gWsD8k4Jak9B+y1eS8QjCcSiBpmmp8Zg60PY38b7Y8JZw7oU5hBw2Vu?=
 =?us-ascii?Q?CWCOVkK7jTuUYA/kOgBw0hftA3+J6twld8JrPKZkj/md5xz6T3ClgoDUr8mz?=
 =?us-ascii?Q?t3d03OXJ3w8VwIkkk2qagIwEAlvOH8qt4GWMLdZ8qLUl9qsOOekA7XmN8ulR?=
 =?us-ascii?Q?Q7AF78ZsoHdPLcCxPSX8RPoqWrYgT5CtFTte/lTGw5cL2qWxCuJPh9QuSkQx?=
 =?us-ascii?Q?FQU6sYE9wQLjvjx4z2+PHnq7usJGUlJzN0FjZZLufBdU38yhVUX2hMZHXRKb?=
 =?us-ascii?Q?o2ci0ggfTjX5PHcYfLydcexK3spxVRz/57UAONbzEBsl5N6VvFzaQCBHLW8M?=
 =?us-ascii?Q?4rqaHpM/rBNM9znBidicItqcGkltNDLOS7P8BSizg/K+uE4y6MN6xc1gGMyB?=
 =?us-ascii?Q?F+29fjrZkBOjF4jjna3H0NDyWOL44rO4OA9VmSxHwgMwkY38pGhxcI+O2jup?=
 =?us-ascii?Q?UUh2BMzsDU0+R0oIMHR/KGSZbtTEpLis/dlUrp4dISOdO1pdCrC+b77i/7wq?=
 =?us-ascii?Q?lFT1z5B/6UyczZLAJl/SOL5Zx5JJdc6GMfuhzDVepPaVVVCRP1gzGCQT+N7V?=
 =?us-ascii?Q?Vw5AiO05/GrqWjd+ZP2PIv6djde4vR0wmfw9uyka4bJMVFC9cE7cwL20ZeSK?=
 =?us-ascii?Q?97vyyVb+CWTysurvl1BxJhl00/gmLrZ1EZBU/CKRCwY9qD36xTyywPAnC5u3?=
 =?us-ascii?Q?nlJ7OwnrA9oOsONEARdy01jkv6zbgDtH5Ny1Aev5bA0ZNNyz4/JbBpBhTLD9?=
 =?us-ascii?Q?0fLImhd650RqKIL9+njLoo=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB447205EDC5A677BAA8585D47BF7E0@AM6PR05MB4472.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(53936002)(71200400001)(33896004)(6486002)(71190400001)(52116002)(4326008)(1076003)(6436002)(6512007)(76176011)(99286004)(9686003)(66066001)(54906003)(97736004)(14454004)(478600001)(6246003)(33716001)(33656002)(256004)(186003)(316002)(476003)(229853002)(6916009)(5660300002)(486006)(11346002)(6116002)(86362001)(8936002)(68736007)(2906002)(81166006)(81156014)(4744005)(7736002)(446003)(8676002)(25786009)(305945005)(3846002)(106356001)(102836004)(105586002)(26005)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4472;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tkQUQm01JZlLwbjzT6YIyucIPJ7oUAwfQa3HfMmFzVjIMw/KAHhr77sqdBizkgYm30cShkZ74pWg+LPBiGAVuvVOiyN3ENthYBlgHOhfaiBz2zVjk43EsqYROMtgL01fU5Rq8CMM9TJ84GtGR1fEEsPoNlcMML7gFWQEMgotVyE1WXKdHFPdO6dXN5VfQoiRkLbsZEexj7+g6OLW/A7h1q50tXTz/PYjBhZ7OXlD8IzPaIHGKMg/4URmTywOcTqfsUEvHa150ZSX7jk57FTvqf8hTKMeYoc2eONy+UfGT2ESewWJ7oF6Rtkn7dbf171+lL9Q+ap9BArjohVv8zf1xc1v9HyG76miQinOGorPuucS9p3Z4LgkKF9BBneAWId8rgJ2ko07HC7zbaPPRNmG+I9RJRIoXK4gdwrUCwt7xXM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6987CB80C7D91F4FA3DCDAC03AA8EC37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ecf87b-87f2-4ea8-32dc-08d697e2e73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:56:51.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:58:24PM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to check the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
> do not support accordingly, we can migrate the bridge code to try to set
> that attribute first, check the results and then do the actual setting.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
