Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC4D2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="F9oHKJH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBUJz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:55:58 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:16253
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUJz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGSR5mGN+meGVq2pHYzBlLBhcWRF4FDb9ZnxN4ndLNk=;
 b=F9oHKJH+L+j8gBCRjmsTVi7ihjMW9YaIK+KLQH2umzC8GonqJqilMlaXiKIZOedldpKggax0izEwnR5Fc3cSZ/Z1IE3l+rxwc7Ko6Ms6kbUQ4Ua+eIU8JcGSA1wgaGJ8A2YNi6mJ7zJymxkq3VcTVW8BE7FYTdif2j5kQP/pd/Y=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5426.eurprd05.prod.outlook.com (20.177.188.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 09:55:53 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 09:55:53 +0000
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
Subject: Re: [PATCH net-next v3 1/8] net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
Thread-Topic: [PATCH net-next v3 1/8] net: switchdev: Add
 PORT_PRE_BRIDGE_FLAGS
Thread-Index: AQHUyYCZAzLSCZo97kSd9sLjc1HdS6XqBD+A
Date:   Thu, 21 Feb 2019 09:55:53 +0000
Message-ID: <20190221095551.GA26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-2-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::20) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b91dd14-3443-47b8-8726-08d697e2c45b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5426;
x-ms-traffictypediagnostic: AM6PR05MB5426:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB5426;23:o2kgrR8fEh//SCqIJnA8BOZxhhef9BVgHNvkQ1KQ8?=
 =?us-ascii?Q?WFn5a8nOHVkdz+978W+10oaezc5YVhx5eftHrRe1eYTginQ6GF0+EobYpm5D?=
 =?us-ascii?Q?aBsT1ob01ZUfs4RfTWn3EXwBAyWhtlYtcpyuaAv5LT8aKxGPi531mgmJhp+b?=
 =?us-ascii?Q?oMUkfd1OuGF1gBbX/Y8mImJANUQ6wDTot1k2F6wfLRxSi09J+Pb3N5Qlhcmj?=
 =?us-ascii?Q?BbeHeO2jfbP5UjIB8ZEc8eezBDoydq3aIjL2eYIo/Qm1uu4H9V6BaUzd9jh7?=
 =?us-ascii?Q?TqkgOKdW2Dm6bOGzeCRmr9Caq6W3zoNlL0u5AW2Q6HgQV3N/zeBdDk8X0VCY?=
 =?us-ascii?Q?CDQKvI2QvV+4ZQFXhyCmBia1tM9Tr8EtaKpvSrJEAtsvhZAxE5pWug4W/hXY?=
 =?us-ascii?Q?utxWVIVFT1rlDtSrxNqzqtAT+lPKDLIfWzWx/RH9ORwoafd1nTpf/iNfoNM0?=
 =?us-ascii?Q?yRVeO4x1AZEWhnSQHpmVMnzr4DrA08tlQHuIDp8FCu/KMFGPbiIUziNRMQkj?=
 =?us-ascii?Q?Oo5SlPNFa+yPBxXLD2Fyu717orwSX6PjZL9SWYxrM1lpGTMNMQ8Jg5x4Njc2?=
 =?us-ascii?Q?BtJ7QBe2FUlA9yyJxR3Wc1jba09wktY63uUZ/iy8JNIGa/lP7fCrJ0Il2H2S?=
 =?us-ascii?Q?e7mhlrqwEzipmWMjjIsXxi0+LMReZnk3QPfX9fqSTDvFdMld4IdfvXpw9GYe?=
 =?us-ascii?Q?ioAzmRH1i1yPfe+K6rZU0WGerZxVmzvY/4CpxmGwWpBAXZjorOiHFjnD+q0g?=
 =?us-ascii?Q?ePJwq/9oFemkjbC38jK73mYmGI2BxlxlNu4oIdI3gwBOoKxIMn3yof4TYurm?=
 =?us-ascii?Q?1CP+6SERrsZA1DYkCe+qASMUyNeInGIof7l4eHVHvT6xGBbVhOsIaNYFoDQb?=
 =?us-ascii?Q?u3Q+RrDIHfXNkvyOUfbRxQMWf6mK6JvdD0O5lqlW8pnlVwXQlGhlSKhrlz0w?=
 =?us-ascii?Q?WVlDkqkV9wRcqsge9Szblvecn/firQ7mLHdJx01Da8m98aJQJmwsdUd5oI+c?=
 =?us-ascii?Q?KhI4Jh5Z4kiiWOPMzXQrs4t3Nqn950IIsU5ui0xkGv4fNcg6JJs/KaA1Gmnb?=
 =?us-ascii?Q?XtQ/+RhCU9yWSOO83i1Wb4xrXnlvw5rxqH0LLdDUpliOtJ0l76bERQMgK620?=
 =?us-ascii?Q?KFdJoVN5x3RZdlpUxeYIeqhtRiCC6e2pj4pNalOXdWu4V3jaA6N/RFYHliCK?=
 =?us-ascii?Q?dEgPJqUzIvewsndKCiEWaZ4N3Vow/bVpCWLiDvKUYlWlPEC4b/w4LTff6itf?=
 =?us-ascii?Q?kuj4083aWcmyGvTpBVmYX8qYyKeTWFWULY/cl5raMSkuMXCthcKs79oB/Zh/?=
 =?us-ascii?Q?bGjhCaHqQmud5SOZBarTfI=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB54269A54B1A2AD9FB2A91CD9BF7E0@AM6PR05MB5426.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(39860400002)(366004)(136003)(376002)(189003)(199004)(7736002)(5660300002)(1076003)(99286004)(8676002)(305945005)(2906002)(71190400001)(66066001)(14444005)(186003)(256004)(11346002)(446003)(71200400001)(6506007)(476003)(53936002)(26005)(486006)(33896004)(386003)(102836004)(52116002)(76176011)(4326008)(9686003)(6436002)(68736007)(6512007)(14454004)(106356001)(3846002)(229853002)(86362001)(25786009)(316002)(33716001)(6916009)(81166006)(81156014)(8936002)(105586002)(6246003)(4744005)(33656002)(97736004)(54906003)(6486002)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5426;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +aPXveCRIT0r5/VCoWywEd1Fb/xXQHM6qDTbimM7SEIqPD9HW0uvnZcLxggixZh0WtfyoprHN09PSoGORijC9Ti6FrGVKpxyYm0yhMaMCNpxmA1UEPuIlrGP+SIOSyi3BzufG6Q41PPzjU2dTRWqJBzo5qBwiZ9VjNlc0RAxOtd5102ohIwQ+Ot9QsYoEbZAYU51IIBzOuVCrQO/Iy6wOzx6j5gCyHTtQnpuIQWFQYcYQQnmpDFqB47zcV9tssKs/WIKQHnUYeNgqe0vMX/2R7FvB9YjipwwAumV1+Eu4sHnaFNxZ1ApWzZzTSFxY7xJc76DxwtzkCIMZLUNbjYiiLNkMHGwfxoTV5nDlvBsPD/lIiujqSGoFvub5NqsdSqdmXUIgUl/DK+3HzwyeZioapmmEM7I1NCnM5f2zTwOGyI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F738F26E89F661458779B6074D46D068@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b91dd14-3443-47b8-8726-08d697e2c45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:55:53.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:58:19PM -0800, Florian Fainelli wrote:
> In preparation for removing switchdev_port_attr_get(), introduce
> PORT_PRE_BRIDGE_FLAGS which will be called through
> switchdev_port_attr_set(), in the caller's context (possibly atomic) and
> which must be checked by the switchdev driver in order to return whether
> the operation is supported or not.
>=20
> This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
> except it goes through a set() instead of get().
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
