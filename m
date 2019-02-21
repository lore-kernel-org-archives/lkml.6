Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AA12085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YrZ6Ml9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBUMes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:34:48 -0500
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:32724
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUMer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLTv6GTP3xTb1pSmZ6KXZ8ENd1zx4wWyYfZJPKi2lvQ=;
 b=YrZ6Ml9BUnP8QCRI3nM2i27ju0BPzPbFWs814y3+McOre25Brf4/gCseMKQgckAkZKhIzr9lYPSJFFBcfl5IjSGQKvggXgHF3hiRl2CJtkZgR1QNPaM5o8DGEl9XWS40puFxWbLRAcrC80vWp80yteG364QYlgaIK3F+f9xZBeU=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2279.eurprd05.prod.outlook.com (10.168.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 12:34:43 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::d11b:17ac:dc46:eee2%8]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 12:34:43 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUyayWu8bVWYg18UOivP+JxM5jJqXqMEcA
Date:   Thu, 21 Feb 2019 12:34:42 +0000
Message-ID: <20190221123440.GD17501@mtr-leonro.mtl.com>
References: <20190221171332.262cf619@canb.auug.org.au>
In-Reply-To: <20190221171332.262cf619@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0134.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::39) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ffb6ac-c4c2-4aec-ea86-08d697f8f441
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2279;
x-ms-traffictypediagnostic: DB6PR0501MB2279:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2279;23:33Gk0AXHeoC0l1CTGhlOxVSntNDCrnLiVjxpo61?=
 =?us-ascii?Q?NVhsV2VSOibHqTu8FXHzrsyBap4zWFkIWKofv24S8dGUgkJ8jVYN8t29P7KF?=
 =?us-ascii?Q?ZHSGZVT4IlfJ0qPFoGYGKI23wW8jkMpozKShciLGWImIAWqOhV5VRel/j1Jm?=
 =?us-ascii?Q?dr5JMxwYY6TYg7Ht+P2w3jGDHYs6lk/fEXX2L9Gf9nhsIx+YSChJsjTIcZVz?=
 =?us-ascii?Q?tClnGfqeI1muHpY3Gykh++7Zp+hNZ210ocA+i4aEzfsKTTHTQBMXz81eOZMR?=
 =?us-ascii?Q?97jQZOzgMUtHOpjEnytS+/bYi9Wd46WLcPw5TVBN9NASmgZMCvLE5+hsMWwm?=
 =?us-ascii?Q?kB74X+oBzqkuWXhoZzPJ24gpzFyBei3xBvyPy+1icWVzh61J/3oxdRUuDiaU?=
 =?us-ascii?Q?ZrNoTsizKm8qAejMZAIJ2oMEEkQBEXRxV9tL/pzLq89393cttZd7owyDoi3W?=
 =?us-ascii?Q?lCx73IpkzVOY5gvo6bwXzs436PUWxzsn4/utKGmprhi+nYiISAF7abijHFKe?=
 =?us-ascii?Q?WwsfJO2YifvuVxZCAHzZK05MwgJdCYOdUmFCZvYpvGhmE6BXzIc+Wg2xMOCB?=
 =?us-ascii?Q?Bsj6osk0uZ9l6Mw/M8j5qMOkKb71/8jEkWlQ8ZmvHKiAcHF/tbvMXH/l2OGx?=
 =?us-ascii?Q?ct6FsmOeDYTlZ6hiMPrR0OaRgO1LHlDmsWzx5LVsnbWMEvFCM8Q7Zbwhxxy0?=
 =?us-ascii?Q?doitHK7pRmalGLO7TR7FQXMGjFbm6wiSf2pDdPEV4d617dG59YykidT/96a6?=
 =?us-ascii?Q?wd7RgYJQgT02pnLdnc4sFT6/dscwV1IWv+S3nwa+LkG+UWmdK12ZVDE9OFdW?=
 =?us-ascii?Q?8q+knSRoE4Vp82meKhG708JcNkdkLxXKrTf+0tZkce39bAODnhSUPpvIZGBV?=
 =?us-ascii?Q?nlkxTnSYuj42FuXCZLGlUOYIpWjI/ySZameiwOPeFmt6oE+Y4Yib1Zv/xl1Q?=
 =?us-ascii?Q?QP2VVBaSORCKw4TAxkLXWKQIt241oKUmuCXTaINmDaDGoVTZWOOx6xvP8ifG?=
 =?us-ascii?Q?mw5jeFHvHR1JIgRtpRjM1njHTJBXuKTr2uXxfaRAJztaVLbzTLmTmtFt7Wk8?=
 =?us-ascii?Q?r0XhUPsgHxlGby8a4SgueidxdkL08TDUpoo2GydUlsJvZTDotjt4hFPRgSxB?=
 =?us-ascii?Q?c/4ZA/Y4OmvyOPQRSf+g7+nlILJH+gXUN6xC2zD/gApcNieTywgrlWBduHig?=
 =?us-ascii?Q?NY8j90/3YCJY2QjAZQnYH9B2mm1pY+eDIp4rc0b6LsyGWoaL2UwduMzlBX9+?=
 =?us-ascii?Q?Q74VAryV6xu9mUf5V+nyKVCrxdp51GBsqSqpFTsscJT6hd3MTVxri4SP7FJk?=
 =?us-ascii?Q?fVXHJZrAufv/rfJPxBr7dBXI=3D?=
x-microsoft-antispam-prvs: <DB6PR0501MB2279C4446399F19AE054ED53B07E0@DB6PR0501MB2279.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(53754006)(199004)(189003)(66066001)(68736007)(53936002)(71190400001)(1076003)(478600001)(476003)(110136005)(99936001)(71200400001)(316002)(26005)(6246003)(256004)(14444005)(3846002)(6116002)(5660300002)(6512007)(11346002)(446003)(9686003)(14454004)(25786009)(54906003)(486006)(106356001)(52116002)(105586002)(76176011)(229853002)(6436002)(386003)(305945005)(99286004)(8936002)(33656002)(86362001)(6506007)(2906002)(81156014)(4326008)(102836004)(7736002)(33896004)(97736004)(6486002)(186003)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2279;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h5tIY4EaltqSxLXOeYx2ENsCYKE6+miczZBTa7HZbEcF/2Cs81CJh4Jh/RP2F6VxDUppvQ59eqkl7WuLfQ5Ks58AEg3P010M6dSNb/aenC7RIpypeBpqdvPajh0iM+DxK6bYZZnEBt3aKYTRF2E85NVOBtlhOmNRyzxpe4b3coZlbLFLkvac8cI6VbUJFi9rwR3ZznGPXW21RlBEtXZbVq9D710+FsTxa7KASAMmip48IpR3iurA1GqczX75E65lacDkGfJuqak11DmXNWnF6MK01Ii/GOmv22v5vw3g96zo5HaBPlHZdSVHqVWH8vAzrt3jlqxZ16djJA53wjxHC/oRegvcfVFvkvl9LkkNdyLzL7sXIA1GoG2ITMm7bkXgQb9/UUM7h3ka6X0IY+kU0IZNJag7h1A0mZtk4yUOSLo=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ffb6ac-c4c2-4aec-ea86-08d697f8f441
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 12:34:42.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 21, 2019 at 05:13:32PM +1100, Stephen Rothwell wrote:
> Hi all,
>
> After merging the xarray tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> In file included from include/linux/uio.h:12,
>                  from include/linux/socket.h:8,
>                  from include/rdma/rdma_cm.h:37,
>                  from drivers/infiniband/core/restrack.c:6:
> drivers/infiniband/core/restrack.c: In function 'rt_xa_alloc_cyclic':
> include/linux/kernel.h:40:18: warning: passing argument 3 of '__xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
>  #define U32_MAX  ((u32)~0U)
>                   ^~~~~~~~~~
> drivers/infiniband/core/restrack.c:26:27: note: in expansion of macro 'U32_MAX'
>   err = __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
>                            ^~~~~~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/fs.h:15,
>                  from include/linux/seq_file.h:11,
>                  from arch/powerpc/include/asm/machdep.h:12,
>                  from arch/powerpc/include/asm/archrandom.h:7,
>                  from include/linux/random.h:166,
>                  from include/linux/net.h:22,
>                  from include/linux/skbuff.h:29,
>                  from include/linux/if_arp.h:26,
>                  from include/rdma/ib_addr.h:39,
>                  from include/rdma/rdma_cm.h:39,
>                  from drivers/infiniband/core/restrack.c:6:
> include/linux/xarray.h:524:61: note: expected 'void *' but argument is of type 'unsigned int'
>  int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
>                                                        ~~~~~~^~~~~
> drivers/infiniband/core/restrack.c:26:36: error: incompatible type for argument 4 of '__xa_alloc'
>   err = __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
>                                     ^~~~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/fs.h:15,
>                  from include/linux/seq_file.h:11,
>                  from arch/powerpc/include/asm/machdep.h:12,
>                  from arch/powerpc/include/asm/archrandom.h:7,
>                  from include/linux/random.h:166,
>                  from include/linux/net.h:22,
>                  from include/linux/skbuff.h:29,
>                  from include/linux/if_arp.h:26,
>                  from include/rdma/ib_addr.h:39,
>                  from include/rdma/rdma_cm.h:39,
>                  from drivers/infiniband/core/restrack.c:6:
> include/linux/xarray.h:525:3: note: expected 'struct xa_limit' but argument is of type 'void *'
>    struct xa_limit, gfp_t);
>    ^~~~~~~~~~~~~~~
> drivers/infiniband/core/restrack.c:29:28: warning: passing argument 3 of '__xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
>    err = __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
>                             ^~~~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/fs.h:15,
>                  from include/linux/seq_file.h:11,
>                  from arch/powerpc/include/asm/machdep.h:12,
>                  from arch/powerpc/include/asm/archrandom.h:7,
>                  from include/linux/random.h:166,
>                  from include/linux/net.h:22,
>                  from include/linux/skbuff.h:29,
>                  from include/linux/if_arp.h:26,
>                  from include/rdma/ib_addr.h:39,
>                  from include/rdma/rdma_cm.h:39,
>                  from drivers/infiniband/core/restrack.c:6:
> include/linux/xarray.h:524:61: note: expected 'void *' but argument is of type 'u32' {aka 'unsigned int'}
>  int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
>                                                        ~~~~~~^~~~~
> drivers/infiniband/core/restrack.c:29:35: error: incompatible type for argument 4 of '__xa_alloc'
>    err = __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
>                                    ^~~~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/fs.h:15,
>                  from include/linux/seq_file.h:11,
>                  from arch/powerpc/include/asm/machdep.h:12,
>                  from arch/powerpc/include/asm/archrandom.h:7,
>                  from include/linux/random.h:166,
>                  from include/linux/net.h:22,
>                  from include/linux/skbuff.h:29,
>                  from include/linux/if_arp.h:26,
>                  from include/rdma/ib_addr.h:39,
>                  from include/rdma/rdma_cm.h:39,
>                  from drivers/infiniband/core/restrack.c:6:
> include/linux/xarray.h:525:3: note: expected 'struct xa_limit' but argument is of type 'void *'
>    struct xa_limit, gfp_t);
>    ^~~~~~~~~~~~~~~
>
> Caused by commit
>
>   fd47c2f99f04 ("RDMA/restrack: Convert internal DB from hash to XArray")
>
> from the rdma tree interacting with commit
>
>   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
>
> from the xarray tree.

Thanks Stephen, your change looks good.

Matthew, really? change of API in -rc7? And it after you pushed us to
base our -next on -rc5 after another API change? What should we do now?

Can you please ensure that you are sending your pull request to Linus,
after RDMA pull request will be successfully merged?

Thanks

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcbprgAAoJEORje4g2clinQqQP/3qNED089Odg1mbtQssEfK3n
LkDkm4i0/XyFPP4LnpVi0S/pIoILK5ZsUL9MzRyC/KZsUGZhtadLiqnLYlkgi6Rk
qwcGaubNBBZlRpmQa+r4fNPWafAj/+20svZcdsDwYEXdDKIrQRz1IE8ZSdKQ72HW
isZBk9vp1v695WpSlOZzj/ePL4uCes9usqIpML+i2AvDPiAqjY3tx1DtuMUT2r3x
xULExYuqTETbH4G72YXgKHs+l9cTAs/44Crcfz/wGmjF81aP/Q5ufrN2ZTbtZOJn
L2eeJ3T8jPlA/V04YSbAG0EuArv2VKfkr79UtdhA53hD+HWTIOGbJ80evnssjCMI
brexMbdaUtpe6ZG4d5IqjWFhWDLtIryrV1DXqg11cdp0bhLrr8BHnoPM8x/N/Jxg
DVg5ep6S9jEk9IE3TCOvdVpGb2FWSDVnoDvY6cmiifpT94HdS9fJf59Ku5VG/+vV
pppR7oIaXIU7PeScnC/KcaXkb40VQGTiKhV0UlWE1UuDxAfcT0k0Ax6nfA/cgdEf
pKdDsrDnQ7dovRVL5MtBso5MZXf9pkaXhZlyT9b31i+ZKu5SGKS0rmelSQhbH06G
ithKdSNs825ld2l0QoZ1lPaBYNKLOxRE7Vd8JKKpXS/sH8K61GrrKlf4lvaBc+d9
3chYIkv7LmXt1RxrY7ye
=dq3x
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
