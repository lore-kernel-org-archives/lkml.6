Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31043C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D6F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RgoGLy5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBUNQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:16:36 -0500
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:16747
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUNQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzKq6nog2kSamSVxhpsohjbdfbck8QPy2z1m1/yiIxc=;
 b=RgoGLy5tnR+T79YJvwiOlBr0QfMzL+HE1Gul40k93sF4/FqEZVFabKTooZiNXm2XniItGcYPZj6tMFBO6FzW9iMq0cbP6R2KMshrHgNN8d8mahqJtXm3zlD+u+VUlQ33gub4oKE5+0OhatiITnN6g/LPKCm6EduPSgJ0ml4D2d4=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2614.eurprd05.prod.outlook.com (10.172.225.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 13:16:31 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%8]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 13:16:31 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUyayWu8bVWYg18UOivP+JxM5jJqXqMEcAgAADu4CAAAfzAA==
Date:   Thu, 21 Feb 2019 13:16:31 +0000
Message-ID: <20190221131628.GA23561@mtr-leonro.mtl.com>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
 <20190221234801.7cc07a7c@canb.auug.org.au>
In-Reply-To: <20190221234801.7cc07a7c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0093.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::34) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd4342f2-1586-4869-7322-08d697fecb52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2614;
x-ms-traffictypediagnostic: DB6PR0501MB2614:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2614;23:Arsbybi1DuQXUPuqtAYwYvo9LY/ekHC2J5y133I?=
 =?us-ascii?Q?GDk8Zrk1OreBOK+BpdAOOlst2hRUAg7Q6eixlgKT38w4fupPKu3MhMXWv+V7?=
 =?us-ascii?Q?qfMipL81DavJs+CYAX0jX6jNAmz3HHSREDCmL9fiZzQvH8LdWE2We649zV1D?=
 =?us-ascii?Q?iR0fNhiuyMA5OMKvVUcPSmVqYypM5mMDyQUnGzhE7qdaJZ/t8XcjpyY9CGBU?=
 =?us-ascii?Q?KHkzO5HDFYv1vGL6KUpIRplhm/1LnZDmFdLa0i3fzgk9KNA0HHI096r0jetO?=
 =?us-ascii?Q?OzsEfSHFbwELDF4hdVOkSrc5I4q1W4a9qFSs+h84rhfcbEdjtQznA80+vZfH?=
 =?us-ascii?Q?lhUsC0GR1wjSTQCK1uzbR7rrgDRD1NRweBCSP4f1G3zprZORi5SVy2KDwlkS?=
 =?us-ascii?Q?mqSu/s/7JYlJEqXK/kHaPlGXfnoWyaWkB+rG7OQ6IBeemZTNbC0J3nMxHWbZ?=
 =?us-ascii?Q?MPzPbu0GUYMtuQ23Q4GPr3n7XgQch81Dw1Vyrwgo3QaZyIdwzGB6I+Rxmurl?=
 =?us-ascii?Q?xWD17mhiT7luMxLYQNtCr8XPnSEhH1zjPTQ6360muQqXmIiLEsvgI1urg23/?=
 =?us-ascii?Q?ceWz95MbXkCqP1Qwk7rRj/XX5bDjXStaflQeoZrfwiStRYHAyHwSbqwTE8Tt?=
 =?us-ascii?Q?pPKpYnFek26U4bOWjB+zZsD6o13F5Woave5ojvklSlu+DiVj00vzuxVpng2t?=
 =?us-ascii?Q?k4jS52/32FeXMsLK1GuKmdqJ4+QRR4jCURJwv6Ug37rKDG/PogM2gRs7gL1h?=
 =?us-ascii?Q?I6A4v9X5fPlSwSg3HApGKTkKtrcfqIg9/yhb6dKCpc8A5UVZ++P84vy9J+67?=
 =?us-ascii?Q?RWK4ecjsV1EjQvQkkFJBlZr+LEEAEUagpE/mNe6B1BE7tKWTGwpasQHGfbsg?=
 =?us-ascii?Q?p2KHT8pZabrfOwtqX3mzvcQVjmTdb8vqlQ1nyoZTn5NPpgmEFRNCRYElCqyp?=
 =?us-ascii?Q?LbtV/PijF1w02MoWkO9w/nvcbLZ1A/Nnbkd0o8BjfMHqfXKXTiPlzzXirQlQ?=
 =?us-ascii?Q?DF5cMQtc+VnAXVQVZwnjYI57/p3hvrojT8K8hvQ89TwsUFrepUENdivRbM6X?=
 =?us-ascii?Q?R+tDllUXMpgI655RZwLy7XaZ35nJWkRJYbIKy1kahR6fE7ulU64cZfM/Cgns?=
 =?us-ascii?Q?so9kLz37rSeblzvLpDH9Q0bGl2a4+Mpy3HwOXU9PUqWw11mF445cmuY1Bx1N?=
 =?us-ascii?Q?abylNDFpkhcaIzu3m3ZJpdCgF97soZ89I7OLHAaTVeFMwWoNUcXYHD+EsUFE?=
 =?us-ascii?Q?bNqprC9Uo/Ho+pJ7U4ROiilsFT0tnn0IXhregt3eOaksylorFlLXNc1BMfpo?=
 =?us-ascii?Q?Vss5JzyLaE1J3inCwebTN5jRmLSyixhgyr/UVxjzketbB2iJYh3uccwQxFQN?=
 =?us-ascii?Q?1jjDyK3UnXnhTHvnNtL43LA728vmAfKLJHFAM6ZoTz86X+5f4OMKyzhEqFG5?=
 =?us-ascii?Q?ZgolJUyR1MRpN2KhGwUM3NU6cGrj6FQg=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2614EAD0C30D02B39BF8423FB07E0@DB6PR0501MB2614.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(6246003)(6916009)(53936002)(316002)(6512007)(33896004)(71190400001)(76176011)(71200400001)(9686003)(81156014)(52116002)(4326008)(6486002)(81166006)(86362001)(6306002)(6436002)(229853002)(25786009)(54906003)(66066001)(99286004)(3846002)(305945005)(11346002)(8936002)(446003)(8676002)(105586002)(5660300002)(99936001)(486006)(1076003)(6116002)(966005)(386003)(68736007)(97736004)(106356001)(476003)(7736002)(6346003)(478600001)(26005)(33656002)(102836004)(6506007)(14444005)(256004)(186003)(2906002)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2614;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YxKrl5s3tpF12Ct3uaoXsTwB8Uag2YQ7M1ydbIqHs+daJMSRcNEKgNb1/dmVsxZUgpR67cU9d6qEnhD7FvhMlH+e1vv1nEcXs6K3JGh7tyEKzEJ5uVVed6fj3bxM6gK0tNBcAqrTonRRCCmhB6PbkAnmMS9gZmWKHYnuQBfby0nKuUR5EknN8u3h8263xmO0hA038bXtFd3TopOi/cSWso4+z6WM8OLLBV5miFQHH5bFb3BN4o/VqsO8+PW1T3jhyXLWWLUMnS4Jdzfw9ypYGAXlyWE524/eFsiZaf8fESt7itYrj6n8Axsw2Kr9r835WbHNb+L2XYTR4UJ9fMpnmExZRXYseNbPMwolJ34bGsPi8iR0UqqSuRkFxKDY9J3Sfom0j93MxnPJB8KOpWQm+YFtOygH7Rg6JrzHyj7OaGk=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4342f2-1586-4869-7322-08d697fecb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:16:30.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 21, 2019 at 11:48:01PM +1100, Stephen Rothwell wrote:
> Hi Leon,
>
> On Thu, 21 Feb 2019 12:34:42 +0000 Leon Romanovsky <leonro@mellanox.com> wrote:
> >
> > Matthew, really? change of API in -rc7? And it after you pushed us to
> > base our -next on -rc5 after another API change? What should we do now?
>
> The xarray API changes (to xa_alloc and __xa_alloc) have been in
> linux-next for about 2 weeks ...

I looked on the latest update of pulled branch
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray

>
> > Can you please ensure that you are sending your pull request to Linus,
> > after RDMA pull request will be successfully merged?
>
> It doesn't matter which goes in first, but whoever goes in last should
> inform Linus about these (now 2) API change fixups.  In fact you should
> probably both let him know as he sometimes batches up similar groups of
> merge requests (like fs or net) and doesn't do them in the order they
> are submitted.

OK, we will do.

Thanks

>
> --
> Cheers,
> Stephen Rothwell



--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcbqSsAAoJEORje4g2clin2KQP/0xyZAp+dEVyy2sxhV64hXxN
PRcfY3qwTDZaAYLyfbASgNT7JIVZpGVT2LP+u0gwj7s1arv6XOKmr2Zkl3LpocPi
CtssucoDmJniIRq/XeZWjpvq+fWa6Pg1E0rzLDhPPK9nqNkGo2kyWAFpE9agPKcn
1xDzPLdnz7XxzCHTVandYb5IvDsNDlDNlK4muvALrrbQlOy6Cac2w2ZXqsguVK3i
eGp+gr0oSFLeJSJnG4O8e5z79HfnWVjRp/2OVu0MafcBrjlLQxLU+dyhd3GSM8uQ
QSVEOqvV1JJyHSu/gUGAX5vQ9vbNAcJS9fZZ08c+fzai8NOWx/V7v4sCdT0HSSmp
+DHbEw0lCkW+A7qDG4bzvobTGF/vyZxzTlnhLyKKt/s1pN7ykOlckvFRBLX4Y5o7
T0cY95ofDiymyCVeAGtEju3dKYif+sZdEttOXboCe5oJv18Pw0zXRU19jU5T1K0c
+aTRr7FKSc+1xgCf5QxCELIyJ+sxeQSZ/zeMJ0QSrx5IYVvv24XqjihD7ttylD2A
gPlQrsvDuHN6O3TtR02puJfmH5fe37eyCQ9rsCcWT7cYYg/rapSaavx5n9Mv2dp3
k0Jtnva0ngTxZ/Fcsm0g2tgFFGzuw7aXKmmMjhhh0yZBt9ks7ag5xQq6ZYDKH/Ih
9L0HbwWDwQbkmKncWXNI
=Amvs
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
