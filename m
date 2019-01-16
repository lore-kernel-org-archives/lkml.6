Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fZSJKo8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfAPHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:13:28 -0500
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:63408
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfAPHN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJGOPmBhBBPn6ugl6mwOfFg1mU8apxJxXuBPNqx2aZI=;
 b=fZSJKo8UiN9dyDI5AR1rw5xRw+/DLUstrUnoSsfuWhPZDj8UrdEI8WpmbJV4A0OxpKA0tLjF8NSusm/bk72u0ttIYLvlI8JpAznZhbJVZj8oGeay9Sk8gPmRz8Z5+rptgsW7tWovMFuK5zgmJjeiyRxbV4RlUb7Q5gHMsVUYtag=
Received: from AM6PR05MB6056.eurprd05.prod.outlook.com (20.179.2.148) by
 AM6PR05MB5539.eurprd05.prod.outlook.com (20.177.118.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 07:13:24 +0000
Received: from AM6PR05MB6056.eurprd05.prod.outlook.com
 ([fe80::5490:e4ea:7798:e65f]) by AM6PR05MB6056.eurprd05.prod.outlook.com
 ([fe80::5490:e4ea:7798:e65f%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 07:13:24 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_nve: Use struct_size() in
 kzalloc()
Thread-Topic: [PATCH net-next] mlxsw: spectrum_nve: Use struct_size() in
 kzalloc()
Thread-Index: AQHUrSgU94oC0mslJ0yta/WiGP/bBaWxe5yA
Date:   Wed, 16 Jan 2019 07:13:24 +0000
Message-ID: <20190116071321.GA22825@splinter.mtl.com>
References: <20190115231429.GA25525@embeddedor>
In-Reply-To: <20190115231429.GA25525@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0068.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::45) To AM6PR05MB6056.eurprd05.prod.outlook.com
 (2603:10a6:20b:ab::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5539;6:61j1VJQe5dKUmg+DwnKhGQDa+F16oyaWfQYcLqeJ+eIGRRstdCZCndTSBfHxFPYvtcM/xiNgYvPv8EtEzZzO++mdvCDDGPbc/apN0HJGMYDbwds2htHLfCYbLPR6VyaTDgVy+KFbOHgxI9FWTI3vs2grR1Z460r3tQn/2dZBgUdNlHkpiNipyfXsuTUUMWcmfmdAR7yKS7U1RqknCiiw0SeFWhgfeILCtnUjpPOZnXudXNCj+8qdXJViqrFV+1inNTcOk4smM4WKFelGpKwgXolJysrODmuEP9AQlqU2qWFZx8sVG8bFTV3a5Lp9BOEDbZ5qIgvttEPZSsyi9VPzt7ed1ZI8WyYi0NjUJTzG07eMJJU/19WxGhf/LbccuPU1pRDSiusgCpPvhn8Rm2co8EZj3YOJX74krO5Nhv4BVIH+ekGL/MqqvHCzRRqWpTd15DTCE7DIcDUowu9ofjBGZA==;5:p7Zez/NKVxyMLf0XLsy31now4iM0z7oK/Z2dhnnqbSoybeVFfL7oFQxeyn8PkFWTARJP9Hbox97DmUDQ5D2k++QOB7FrGpj61tF2p/N5vZp+MctN4nKT2tPxEUYqJg5C26SZgRge7XitG5O0+iEYQuaOtPVgtgM/BeVMwwzotVNbuoXnJf7rI/r/BUUXUumSA0b92q8RyI3Jz1rDAkBRfQ==;7:tngERDn6BQ0mqVNf7zJA1W49JPTlfX46qlhyKBHbUoCjWaz9gGc5eRyerb89LTJjq+qKMmhlgoZJ3xgeIkLW7KbF7kv6aMld9bNXPH3NQD+MQ78wgo6N6iPlQDdL/iaL1gAXsK2Nimdywu6BQCp1RQ==
x-ms-office365-filtering-correlation-id: eada1e9d-e7ba-4dd7-0f18-08d67b821a76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5539;
x-ms-traffictypediagnostic: AM6PR05MB5539:
x-microsoft-antispam-prvs: <AM6PR05MB553975D5061F1C961C235306BF820@AM6PR05MB5539.eurprd05.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(6246003)(2906002)(71200400001)(71190400001)(316002)(1076003)(4744005)(102836004)(26005)(54906003)(186003)(3846002)(6116002)(5660300001)(66066001)(105586002)(53936002)(25786009)(106356001)(4326008)(76176011)(14454004)(6486002)(68736007)(8936002)(6436002)(386003)(6506007)(52116002)(476003)(478600001)(8676002)(446003)(81166006)(81156014)(6512007)(9686003)(97736004)(99286004)(33656002)(7736002)(229853002)(305945005)(6916009)(33896004)(256004)(486006)(86362001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5539;H:AM6PR05MB6056.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6J/dU2vepZPQ0FwSCyLHy4cSRYgBryE/so/ObT2nlWI6tWujcC86d7o9MPBNz0+h3DbGkvAi76CifVeEdeJGjyYnpHtvLeufaoXU97gM7C+sPO2WG1RbFWmiRioNVeY9O5cFPfdS/kAVonOVT5JIyfTI5NuXlze1k4EO/nPPkxO5a7mwAS5SNV00zU1VFssVtokdRBSTuj7JJFt9XHAMxe7IA9iOxS18wmBsWz7rWixDe2XNTxdpg+nWBlI2bUJBj23GjjD105VHFV2exwlsCvNc24mF6N5cfFPFbrH2uz1aIaJ99IMgTdr9/vSzIQDX6vZcAo0NYy+MeKYaCFYIgJ7WECo4m4l46iTePTA3x4764ok1RwLbGEMpQEpnl9rujvUHoPC3uL8dcR9odlyoO6o8ZIDfJ1iYNw0WvBTMTEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2058DFDFA0563341AC68E8713753D366@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eada1e9d-e7ba-4dd7-0f18-08d67b821a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 07:13:23.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:14:29PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>=20
> instance =3D kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP=
_KERNEL);
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>=20
> instance =3D kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
