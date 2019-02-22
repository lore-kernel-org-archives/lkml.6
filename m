Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004D12081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DYgLgjbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfBVNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:25:19 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:49472
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfBVNZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrphwlujvzXFHZppdq9lZiAODziMOH2Qie0CnL4nhj4=;
 b=DYgLgjbGM1wcEJWTE5e5Ekv/Pll3puzwQZ0g/1YaEqm8ilEJuU2I3JC4SLA7xHwz1TuipK7L7Hsqer6YMoOfZY8r8OgH2qOM+31AC2su+OEUEI+2s1upnFR8w8rsSPvxrtmlalDPdNsEnzwwJCkPaFUQ7xNQF2+GISPPN6va/w0=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4488.eurprd05.prod.outlook.com (52.135.168.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 13:25:15 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Fri, 22 Feb 2019
 13:25:15 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] mlxsw: spectrum: Avoid -Wformat-truncation
 warnings
Thread-Topic: [PATCH net-next 1/4] mlxsw: spectrum: Avoid -Wformat-truncation
 warnings
Thread-Index: AQHUymR0GuCn9Q7SlEOAtan4g9k9n6Xrz0oA
Date:   Fri, 22 Feb 2019 13:25:15 +0000
Message-ID: <20190222132512.GA24455@splinter>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
 <20190222040929.16657-2-f.fainelli@gmail.com>
In-Reply-To: <20190222040929.16657-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:203:90::32) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaaf6881-40b8-40c7-781d-08d698c92e04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4488;
x-ms-traffictypediagnostic: AM6PR05MB4488:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4488;23:hiJVDfcynAc5OQaJL3BhEaF9oNsWU9ReApvR+tFPQ?=
 =?us-ascii?Q?dMfW8B/LXhaJy3kVlkvV4OFUIRVJznPP16UBB9e+KrsTyWKGVbl3bvJpqTo2?=
 =?us-ascii?Q?isHN+JoB/+0DrstwcL+1Kf54bwg+Cxfco80o0DHHK+2otlM0fCG6y71ELhXZ?=
 =?us-ascii?Q?FrYlvyTlrGwcCm+cfgJ5hDZMf9RuIXB8jxY2KeK5WEbQ9Kl3nI1JBJ4Be9HQ?=
 =?us-ascii?Q?OQ71gQuc8fRWjH+HbRfdumtTzkaplKPBGpmBzT9B3/+9dGpOw4sG5C7OjS8a?=
 =?us-ascii?Q?NUaQ+wHJ1Sr5oO3FtMax7+Xsk6ruVbnJQZwd08n+0Xv1cbZ3EYxicD5ihI2s?=
 =?us-ascii?Q?+2bznn6Q9bNMvHzLdZxxAT1DV2HmHkXAkJRcJycN66qOeD9rSA+/yzu57/x+?=
 =?us-ascii?Q?eG/8YJzgSbDy1Gy16fiRMxyQxmMOwKqd2GcG8rw3oQ87zifZUQjDld8y6fFI?=
 =?us-ascii?Q?Sxa0COK1j5cKQ9CCeccbkPx7AoxClntSPwJgSzw4dulXvtl6unN01oA1NZdK?=
 =?us-ascii?Q?5+l6r90Xj84ojydH/S0vWnn8JBUK9mnprhIQ1/DtFAUKzcbviNqw0jZserA/?=
 =?us-ascii?Q?mvtQ6fJx2Hx2V5nreS55cwV7S9P3H7Jt+Io3jcJTUopAx96TQgKJ8OHv0Fho?=
 =?us-ascii?Q?GRmLHPdVA+xO7PI/Nie8aLZltlnxn0/mhek5Edf8uIkw4IRwqZ8ioNtMyc1p?=
 =?us-ascii?Q?Ii2locfP+bMe4l7YPMI9Japw3nKBp1lr4O0zzYloJJw+SoPMEqQZHHJhUepw?=
 =?us-ascii?Q?jEVxu+SY88qY3KAE00+zSl4ijIGFHzv+JRp+G9YDTpKf4J6bKiWFnecyslTd?=
 =?us-ascii?Q?kSCib7daQ0PFKg13dNaDLfIdGAiSkLKW7yYsokNJzS0UQ+OaJfQ9il1T2LOz?=
 =?us-ascii?Q?+LfYiFO9Itb6Yj+Po68pDP5Nfa9R1egAI04knI6aw1agZmaLkx2rsAA1fCCB?=
 =?us-ascii?Q?GtppAo+XXafpYeCcaScYbv0JksPs/1z2NKBSaezAftxeMghu3MC9Fj32lqfP?=
 =?us-ascii?Q?3vfFM8DlmM8J6aCg/MWXPkWaoox9PszeXb8yWcdETBuepUVmPv6NJpjTGgLx?=
 =?us-ascii?Q?S9ZOTkaI9rtudkByI5VkX+x9V0QAUZKZ6dj9pFFWIkq2yKsTfDZQ+CVLTZGP?=
 =?us-ascii?Q?wLL0qpla7tSxlIuLzh1MD3v+rgLU7HGM5BkyMBbZev6yeMEZ5wScQx4RKb0f?=
 =?us-ascii?Q?s0z7MWK41cXM5+KLX01zXomL7YYXxWYU1HN7kXPFWYb3YwXivpRxIgasfLwl?=
 =?us-ascii?Q?kNnYfqTvEynkqM/0kj4owM0h6g6unGOrChoNSqCH+srYMF8OPFFrV4gGKaBj?=
 =?us-ascii?Q?9MM+qftYJTfiTjD/TZbask=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB448851B5F5CFDF80F5F7496EBF7F0@AM6PR05MB4488.eurprd05.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(6506007)(25786009)(186003)(476003)(8676002)(486006)(68736007)(478600001)(3846002)(71190400001)(14454004)(6116002)(102836004)(446003)(71200400001)(386003)(86362001)(81166006)(5660300002)(11346002)(81156014)(14444005)(2906002)(6512007)(33656002)(1076003)(105586002)(106356001)(33716001)(6436002)(256004)(305945005)(6916009)(6486002)(9686003)(76176011)(7736002)(54906003)(6246003)(52116002)(53936002)(33896004)(97736004)(99286004)(4326008)(316002)(8936002)(229853002)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4488;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9QlaGb2rFfVq2VU95asFrod2PO/vi7+cSHDW/4gdoqNq6QTT5pdNjqD/mIs0rNJy7EEoeQ0q5hRGjZ521M1s6y8KCWpHTVWhM8M7X3jmbpXpD5keAnESG9xhu1yel+Jn45j98iObFX7ZR6Ow7CTpP9H3rWlof3kd4Gh4mFNbKoKbUvonoIBOPBhSNXM+bIiuGmcI1Uu6hUipJZ0BMrYuS0v7d4ZzRP7uW+yV5m3CbUe12VHIP3ZvNo/6NCCPA3wp9t5jXK2SutzAWosISuLgzjb5roA5xaNr64IWVTizBhkpMF5pIFsi5Qogy6CwsIn+vHbQWtmAm4QJ00jmV6oyUYb5tOI94CO01bg22bLF7xmQZNvMjHvaxkb1asXPrV3nH5NRhmH/v1aOwf/LdK/s9WkVNlQZGKUdy42giO3EXvI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <057557FFD5865B419337950337E3536C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf6881-40b8-40c7-781d-08d698c92e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 13:25:14.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 08:09:26PM -0800, Florian Fainelli wrote:
> Give precision identifiers to the two snprintf() formatting the priority
> and TC strings to avoid producing these two warnings:
>=20
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
> 'mlxsw_sp_port_get_prio_strings':
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:37: warning: '%d'
> directive output may be truncated writing between 1 and 3 bytes into a
> region of size between 0 and 31 [-Wformat-truncation=3D]
>    snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
>                                      ^~
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:3: note: 'snprintf'
> output between 3 and 36 bytes into a destination of size 32
>    snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      mlxsw_sp_port_hw_prio_stats[i].str, prio);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
> 'mlxsw_sp_port_get_tc_strings':
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:37: warning: '%d'
> directive output may be truncated writing between 1 and 11 bytes into a
> region of size between 0 and 31 [-Wformat-truncation=3D]
>    snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
>                                      ^~
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:3: note: 'snprintf'
> output between 3 and 44 bytes into a destination of size 32
>    snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      mlxsw_sp_port_hw_tc_stats[i].str, tc);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
