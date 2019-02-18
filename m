Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5014C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF4217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SY24Hdtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfBRKtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:49:01 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:56512
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729842AbfBRKs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0H4t/4CFOO8f9rEcQOf815dUldHs60AsTZjyyOsN8E=;
 b=SY24Hdtlw2ILAxq74jnAFaWh8D2xHGlgDUf/0HQFgsdvYGT4NMDSzfQYIZQMKS9+bBYd+1uRFKTvrKoNe6kQyT4ywrbOgr3hwU3kF7yyS5I313JbnyMuNx+7LifGpq0YxqUNScOW25r5znMHM4O9UJezncgkupSUp4lxxPwc4Mk=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2262.eurprd05.prod.outlook.com (10.168.56.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 10:48:55 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%8]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 10:48:55 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Topic: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Index: AQHUxx29JbiNaadc6U6JIet3iPH6zaXlYNcA
Date:   Mon, 18 Feb 2019 10:48:54 +0000
Message-ID: <20190218104852.GC16218@mtr-leonro.mtl.com>
References: <20190218110549.7f22feda@canb.auug.org.au>
In-Reply-To: <20190218110549.7f22feda@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:203:2::22) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1833d077-df2f-49b0-b5fa-08d6958ead53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2262;
x-ms-traffictypediagnostic: DB6PR0501MB2262:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2262;23:xtbr3Xs2geIXE4kcX5h74deRnlLDgofFOjJta8C?=
 =?us-ascii?Q?dLSOukYuZ8gteDS41K4Lyv8KE7MFSjLA25LSjSiQe/nQKCbNVT1RX0JQwyAg?=
 =?us-ascii?Q?TMEkmtO6v8wqk0cb96YetG5WTjG14N9FSNBlllcgsFgxpDEYyc/j4oFbWSSP?=
 =?us-ascii?Q?hzYKMpJLrKvuhHVpWSRhGLts6DhkNLlPRNtPurc0d6E+wDTVbJaT66irhcuo?=
 =?us-ascii?Q?3aKOSfTccpe3tmNEk3kHBwJpC6lAIwWUQR4muEjuqjKI6Vls0m3uEMN+7UYm?=
 =?us-ascii?Q?1ZIWaK6+RkYZE8SzTkgu8QZNF3Y4Dtd2Taw38pnNTYLlz8EYMmY75iP1nIoo?=
 =?us-ascii?Q?EvN9l4ZKlP80UDj3mwce1ynuyr9xTl7VN7PqJl7y53CXZjwtouJz2x4anAts?=
 =?us-ascii?Q?BxGDtpaqpR5oeWnpoSq6e1rUl8Lplos9/rh2/q/zzNhRu6uV1YCEpCzuR47x?=
 =?us-ascii?Q?k6k2/2yCtknHAWiB3j/MMRFJR7TREUKmOpD6GVozpGlTw7LNrDTYzcljojeG?=
 =?us-ascii?Q?2VmFB5IdhfKSr0MV01I+JhE3XJ0OsWF9rY4mwbTA3La0xdoz4nh1qCFV9iG5?=
 =?us-ascii?Q?UMSztR1Z8uggstDtX6KEN4kEo2IYuj5FtyHT53A2LKmqhBidqAVqyuyFj9eP?=
 =?us-ascii?Q?x6Wze4laArKDBjep+9eFfkLZQOcW7xpBk6hByZSRkxHVw76X/HVn5qgPIVKT?=
 =?us-ascii?Q?b3sCBFjf8v0nmP1FJUz134PLvcDHLir2ye9hm05PEyu0iALkI7rIVh8+y/bB?=
 =?us-ascii?Q?Va37ltrixqewj3rPoiG9PnGGXAFPR1wioU04WHI491TKaVom+ayhhv/flfYx?=
 =?us-ascii?Q?toggstZjutaKOruTVhCE/wgKETqAM/VnVVsZ/4egyaMfBGhRTA0oIMxIlgmB?=
 =?us-ascii?Q?VWWBuTlCejCLzQc8KF0xboOSbCeVxaFTVeUUmsVd+DHZuj3L4mPauA02VpRd?=
 =?us-ascii?Q?/oWYySoEcR529+r78TDd4B0SDeYVrvxzcXU50LC8LWPMELqOF6Fk7OAnH0yE?=
 =?us-ascii?Q?EWL1YywgWe1CvKlS9oBgcEiA6/dFgargM6lb0C4RierihgX/aqJBJy1G6fOr?=
 =?us-ascii?Q?oaqSkBRUsnDzl/RnWy13w0N2m9SClMtNy49Uc4GIRRqns5SniNcE4Jdt+s4t?=
 =?us-ascii?Q?2+lsu/G33UMR8cgkvbLxWXVxFNYHQVR0udg8EYZfFRUVeMWHfmSpRErrs6Vq?=
 =?us-ascii?Q?ESeVV6gruFywN9B59/juow46z4PRlN2JuOxWRxdU4AxNXjzf45qeRMuoxDP9?=
 =?us-ascii?Q?MoW/b5agBwFj0nLRSHj4NFE0YJ5Gq8JKwEpaVTDe9PNlQlp/zDKkImIqsCa3?=
 =?us-ascii?Q?RateEWtkOOsDUkcRPkm+UwJUVaHsrs4xXd/EHRCxbcLcy?=
x-microsoft-antispam-prvs: <DB6PR0501MB22628B3BE30DF1576DBBC6BFB0630@DB6PR0501MB2262.eurprd05.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(53754006)(68736007)(14454004)(186003)(6436002)(6916009)(6512007)(9686003)(25786009)(8936002)(66066001)(26005)(99286004)(3846002)(8676002)(6116002)(33656002)(256004)(6486002)(53936002)(52116002)(81166006)(81156014)(99936001)(2906002)(107886003)(6246003)(71190400001)(11346002)(76176011)(33896004)(446003)(486006)(5660300002)(54906003)(71200400001)(1076003)(4744005)(316002)(476003)(106356001)(4326008)(229853002)(478600001)(102836004)(305945005)(97736004)(86362001)(7736002)(105586002)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2262;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F1TYYXKPehJIw2dSJqTAN5uvyST4CEy4rB0/gnt8tPFLtJL6awaNYvVl+oCtvLIuU75PN4VAk5rq+KQhY9mYatJ7yCS0Dznv0/2F2uF0s/Egpt6Fc+qhPwA5rl79AO0fqodaU9aGDbo3Cg9ZZN2VREh+aY74Z/3doENUpa8zCJ2+QSt7tMFQUAD5D3xiL8G6yOJR4jnnwa7pXFhdJ+2s/CMllEbW1fkcAJn6W1oQGVHCap5oItcUDHrsWSE3t/4rlBCkIvbc7a9Zl/ZGOQfZrAnvLldOSkXlb0sqN7EepRy6BSR8MumMjPtlysYdIiq6KtjleH7EsKxi7q8yz+FgWL9gwMkw5zYOty1eWWFravE5Y3QURbEJlUJmcA9CNC1dLYIFgFgeQ/wh4h28dxa5AS6aUGp1BPiiKUe+grk4MTI=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833d077-df2f-49b0-b5fa-08d6958ead53
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 10:48:54.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 11:05:49AM +1100, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   drivers/infiniband/hw/mlx5/ib_rep.c
>
> between commits:
>
>   459cc69fa4c1 ("RDMA: Provide safe ib_alloc_device() function")
>   fc9e4477f924 ("RDMA/mlx5: Fix memory leak in case we fail to add an IB device")
>
> from the rdma tree and commit:
>
>   f0666f1f22b5 ("IB/mlx5: Use unified register/load function for uplink and VF vports")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

Thanks a lot for your resolution.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcao2UAAoJEORje4g2clinTmYQALOnHgN4H8CEH+WZnZ43pELw
XDp2l3IYkBSoHC9kzLoTnEsX2rtyD4nnrwYF6C8oHe2tW9jQ2IpGXdlenqEg+4IM
HjR5oJLFd1m15NWSvo+epdOoLCHQdr9OhrlrdiF1vfyRD0iLeDZt+xSBuscEcFKx
M5VTRVbFfdSBmqxCniqvWcf4v3yOwl5VORseOkN1Ml9oTZoy0MR86CL6m01cBTA0
N9H8bcBEyNmcDit7v5r0d2hogfvPBogtJbi9kAyfQDNCxBS07q5cmT7o2HGP80Ct
8U04olT0kokFtMZKImEJ9HFPrFxyqOMB3RH/TlYDUCesQhVbfE1RnIbWWepsZ6lm
cmDC2vM00aS9TXeh8EyDW+vqBrsMjIRRqXEcZ8fxAJW9pS/LHDf4t2LrhQYbnqbl
ttpeZjOAAbbgpYkWMBPSWm/2CiN0MncdcIFzC7JCJ6SlvjlFNQNpLt3JHvOU3OQh
Nfn4ov2W2WroISbTxIT/A007qJeeck4snPYpCk29Dw45jsTzKkGVfV8qJusmj+uy
mUa3taDe/uwVvV3bRSiXH4mjIHAAQD6PojtFrZEhR0TSRWeI48U6hT0uQ5WNyyzj
N6h49KIdnGFaR0D3dtmOVerBdXeMq9FPW/b7m8Wxp4fWxH7CH7lztcoJLF6S1vr0
jLVcoYoEz4nbjNaF5TcD
=NaCP
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
