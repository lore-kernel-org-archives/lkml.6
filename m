Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18DBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43359208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="psRHq9+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43359208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeHWBMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:12:32 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:53792
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeHWBMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+7EabcWgKj/oYmBfMPFWJ4hfk99jmw0YIdNRl/RAwM=;
 b=psRHq9+wWV4pR9C7SfU/lzCO3cY/VVb3kD8lghpkb2Em/PUcs0KpWbtJNFkTsJ4yeAqlUckQFJo+msRbVct/zoTEMkpjuAFUML6Nr7Cr4kt1JNCd/S8VZqvB3L4BRQT9JgPdBERDuU1FxRI8F6GvOoEA4XYS65KzKuHiDbdNFTo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4457.eurprd05.prod.outlook.com (2603:10a6:5:1b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Wed, 22 Aug 2018 21:45:07 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fsavy-0007Bj-PA; Wed, 22 Aug 2018 15:44:58 -0600
Date:   Wed, 22 Aug 2018 15:44:58 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180822214458.GA26822@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To DB7PR05MB4457.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf8436e-4a76-45b8-a1e4-08d60878875d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;3:T3Y0APYIuRghmKhZBZUNUO574MVLTgn1ds7xMYSJn2jTb+GKB/etdf9k/Ep/jhswaBMW/yPlZWE/qLdxSopkVt1NJ60f05sbmA4bJrIFha80++ulltYhZAWgJKu5Ps6HMu1wJeZ8ICSRQolFu9U/6nFd4+HeJibzPNf+Pjmqz2zEjixc4yQckt/+muYilKCma67EfsDYinJvjn9yBMu5ZcbaVpK8NHDUOwCCfh6Sq0tnFR14N2pCNMpUYFCkPM1t;25:WLKO1BKdy3arfQyyb7Hzl6aQA3mVDOfgFs/bMj0LMRGeOFcfnuPP8bl+9m6/tWvuRrdG6wdi5+bkqyFHFVqc9VXWApLDCiV96SkZ7n+IrVxf9Dnz8Rv/y0KWYgLV9qjzRIIJfXlFtKHnztpPdPVTsy0bP+yntGhlrHZxwgKvLFQt/D+/B/V3QTpmwzXzQSinhmLXMTbACaVrdiFw96RI3Hr7PV3xQ66WXUeWcfIZG968xIPhYaIAvXBSxPCv+uJl/RrB7vAi9WqJ0DBJ8I46RgPQZQeWe7OCjpI1EcObZ+TfVbzyvdVIJ9vrHOTcpGcmjCGqkHBRg36ZQ1TZzW0y3w==;31:XLPMDCcinPLXWk1XQ7Viye2+NLmyVnWFQRsRMq0FKmGTck8fwe6nbYDY7RJvQwmnMwvmAqNRJ0oJJc11r/ZNIY5WnqHAmkOLeQNPqB/abh17lnRLez7v9Ehv2EPkK0JBkiy7GTCTx8DnLTLd0L/S6a5UozyP+cyy3/b3qGlWbg2VjEQ/Vp0MA/5unCIx8p6cuOpEA2xZ2lFyHn81knZOso2O0CjSzcGp22hwbn7dbew=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;20:N/9tu6/uLl1ngjBJIGKOMDwG0ufks/lPzwkVgGg1eGCeb4DqL7c+1Ob5J20rr04fxYc7bw3sMRW1AsGKtIDRBvgEhGe8TJzenf1zYREA9PC5xhDgoSMFH9YcHZa9aGdOKHmZFVPe3K4rhu6H8CDkextt0lRCwhoZ97x5jv/Th4BDDISXi3y5OU6VNOFGIHYWmeJORR9YMxZLBCDgIfPiDIHZaq7e+H3X4H///4joLKV1bpWYsyINEtgXeOWWJVMlvT5bHnmi0NNfzw0sxwJ97PVoXe8DZB2XzrQKCbx3W5qDaEvI+vpRoKEUC7LXfDXNHzSLdvBYCl6h87TPEfG5JFIPYoOmkHmyeDGqLSLDEYeW/jmGIQHOdJ52MeW4n77Jkf7bpZ2/MHoPWmt8naoFfK0AqFGs2GN7Q7s0OZotxvV/ff1XP+HuhnLCoh/DZr/0IsCRz2UveqR9MVCDzv4VcDWkYi+uU07HIGDr+ZIEu/AEBh62E6Asv6AtHdzoIB/t;4:G/XuBzuLzaGLgMUqENm15nfocgqp4PbClexxgZafcyxZEnrRds5S+D6kgEfUEJuaIHuwXGWsFmQcpKJsCXAYHZz7V/S2MtV7idN+XxsKXZ31Lh3mIalslZEaHPjmZ7ZTxowPtq579vesnnjbmQ9nEQkSk2x/T8O2hLOmJZ9IB+YmHY1yjrrwr+Fc44nz62+QyuUl5b0SxhYWTV3FJzLgLCGMl5k4fDiDLLCUE+GR+18wClUcZKezcDLWwggEKH/507TEc0RXQZAoFNZ8iyMSRv9G/5YhBVH1NuKrnZSgaEkZvswnHcTDeag6SRrNCoBK5yXd3ENwaCRM7dMM8ezMpbuKhrXVOk/DOaAO+0Zw7SI=
X-Microsoft-Antispam-PRVS: <DB7PR05MB44578314BB2D4E1A454693C8CF300@DB7PR05MB4457.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB7PR05MB4457;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4457;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(14444005)(426003)(97736004)(186003)(486006)(26005)(476003)(386003)(36756003)(79686004)(33896004)(122856001)(110136005)(58126008)(316002)(63394003)(8936002)(478600001)(16586007)(44144004)(69596002)(52116002)(305945005)(106356001)(575784001)(81156014)(81166006)(84326002)(21480400003)(57986006)(9746002)(66066001)(33656002)(7736002)(83796002)(46656002)(4326008)(3846002)(9686003)(53936002)(8676002)(6116002)(68736007)(105586002)(5660300001)(86362001)(1076002)(9786002)(2906002)(18370500001)(24400500001)(2700100001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4457;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4457;23:xjYAtwnExS3XatZqLNbS1AmIFIXBFXl5/fs35wOjR?=
 =?us-ascii?Q?F55OT9f4Q3bESMKe8PjMovVZRBhXAwgX/HBPBmzAcFNmU6qtluezjAKLCf4E?=
 =?us-ascii?Q?m3/VJaqPUoTxBfnOYCatVxXq9GhqXOJapjlbjsfYTEb1jAAwn0WwUF8ZBWb1?=
 =?us-ascii?Q?hM/4oUfwmr+cr229yZOedQY5JAV2Emkw/q05lQg4RJqihoO2q9SRxF9HPS03?=
 =?us-ascii?Q?WzTCmaIHEje/gvl8dN53Xt+nOGR9Q2NIiWEd+43m416WQCma7CRxFv8PwPGy?=
 =?us-ascii?Q?miXktdw9Qe9EychmV2d5nYqkfl2sxu/4d9nOJBD5rBr99Dj7fzXMrd4h7yg2?=
 =?us-ascii?Q?5XUAWyrlR+ArHukI7UXWdD5S+z2KRMzAIVgm96y29fZQ1FGVyGR3G18lQym9?=
 =?us-ascii?Q?VKWOcj18XtYIcQytNUDcobEQSsY5BWA5H+2VYx1NQAr4HQVMO9uVrAhlBXyh?=
 =?us-ascii?Q?X1vyd5pW7HdqB+Mg4J9csxw7zVDA3eXA6ObwF/0V6aMvsFsQW2U70CUelfRa?=
 =?us-ascii?Q?/L8r0Zj8TXWV0e2zw4mqfnAoFWvYeOA0bsRjS1PoGl+gychsGSRhbvoUN7mq?=
 =?us-ascii?Q?LKo2NbXNyUxXoS3Mb1cdI3xTYUl3olD+cS+aAhPptQFm0p1ctLEtiNhGDV11?=
 =?us-ascii?Q?Azz71KKPt7AjSlzPtWMfQ1NexnqIIQ59HtcjEWxDeicpQiemeXiEN1geU6u7?=
 =?us-ascii?Q?sV6M9JctTgyNDa5JBuoPISi1mEFTV389MmhtKwCmAqZR43IQaeMq6gGX/Kk/?=
 =?us-ascii?Q?nCoz1q/AenuRSNEpbP/Yv42CFOcpIs3DkktWpuHOFHJtW1U3GyJfAEl7k3Kl?=
 =?us-ascii?Q?kCS+dK6dAbQAnrlQFnBSFZ94Ug/LImgJIdH7MNN11xrO+UuezECrfZ2UCaM5?=
 =?us-ascii?Q?F51lvqKUVqGDrQVFXWxYrrAz8bC89kbB+558vg/WHXT+5Iqf/nwnp3/GNUY0?=
 =?us-ascii?Q?jQH1zY0c1elW5vYZcJmKdh6MHYchdIZFIziWPYJAl1GJ8LR8hCsgExuOcYSp?=
 =?us-ascii?Q?9ZmLfwxoCmIfOqM0uiKSBOOjpZm4mYcWtfFHtXWznPuJ7mpJrci1iihndTZI?=
 =?us-ascii?Q?a68pl1BRfI3YYcmrcV9p9p1tnSS1u7sdzoPZZfYrtsHorXsS171zjrDYpmpX?=
 =?us-ascii?Q?VqJy7g23qa+KSzA88URHFNrrZCZncG2F/wTyAXfucmjI9EhDa7uq/C8xcdMU?=
 =?us-ascii?Q?IWOp6Yr08jYLQLpBjFWyIEpuhjQwAEpYMdXfIFgfH79sxVMx9Vgtg31vkuMz?=
 =?us-ascii?Q?nAMqNPnEwvZE/hKxF2HsvpVujHKj2RdxW9F49iic6QCC/xhlxGTRiw9wLo5u?=
 =?us-ascii?Q?knsKTL4OVf3eUI10uZXfbFF6V5xcGGKaxNYN8eeynuLPKk5kuHrWIAQfr4/9?=
 =?us-ascii?Q?dVZExOh/KyrebmYUpcojEN/E7s=3D?=
X-Microsoft-Antispam-Message-Info: 9+9QcN+5y5g1HoXsYancYYzr2E/RkkKCsa0guqUR2fEKoX7jVETA19ASieRkZpqobLbPdrIFzRC2pyqtvTlnZObB97aSjW8aUG6NkV/UifxIWoh4a7SS4Qh+38gKPdRGzHbgsfD+qV3G5eB2gDz+DnXbMvzzDXBbIhBrYpWD49THh97NRD6EPc/ALVeQ6V6MAGpaTq9alL8v2lgnb0max5lEubWgI1huI4zf46PsUIV4ND6+hdw8AynAYkygTT95gifr0MvOA4sN3YY9oICOjy3zCr+RfjTHkq2dQfOZ6smK+2cjNWrOTf5CdOCegJI9BbiYNqfiTsqlK8x4f+yUtpUUsuYeLe0OI9C8jF8cTDs=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;6:T7gkxge+JwX3KUB2jUIat8P7Pgo0x0PTMySdeumJ1w5aJe/2We/DQ8gmvABCc9xr1PgbCsXQl5z/c3QgWyBtdtwmiu8Jv4C3ClZMfSJOR3rQxxQHdYy7VQJO4OXuyURXTWB75iuizYfxdyb6Vuo8kUhHCJ5xC2lYPQ7mELEa2ozVQ0AbhOYf2+dFdcs9M1G5LfurP+lNIbSh/iPedLP25XuLHKtxDqq2R3wc47ZHK4Izp/WTSPtt1cUzQwQJuwV7LyyjcNIpRL6IG7vv0/4z1jgWE27lcrbXFSkT2b77QJur5DTXH7rfQfvBEt4AKBX3OJDhWimezwQMn4xDol3PDjwYi0YznoRXwE/pEXPKYNt8vo037YO7mMTyV4GH0O2nFxNcYAOj32uicPvdkJZOyzrK2r9YK+IqHIFRyQ4DwR03XGLQDk08zv9WOEd+uglgAFCTu8e/A9zidUs/mhbpcQ==;5:RRc6B2Q6JwqhaZRkMlbw/aULkORHl+JfOSjLa2wglrHEb3n8kFxpi00N503TQPVO4ut2507dnyDPOTVl1Sce5L6e4gpixLITtyEnOySJE+iedsSSXeKOxLalG3br1si6+YdH1qnGts6+HTyH5Xu5bpzxdKCGBSW5P9vCYUNN9eA=;7:zseZXT2OAJYB+jtwptBflnahiYTUQJQyYam1f7srXKoF3Y5gmIHeWV9ticSc8jA0JsdW2aPHkDauwazaujcVRXSAawquKiLYgbQwLAkiMkxRpWT6sfrG3BY49DhpWK5CuXt/LNtH2DxSU1Zi56uYPQipec6FVfGUcWIdJM1HijQ/kDnYpmRL6IXb7NUWAsBSldXUUDZra9tGGWq20x6xGrRnjHwWLi1KNWpeuqa1s8FjLIfFYeGMWKor6JSTWFH7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 21:45:07.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf8436e-4a76-45b8-a1e4-08d60878875d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second merge window pull request

This is the SMC cleanup promised, a randconfig regression fix, and kernel oops
fix.

I've learned we have at least one regression this merge window in IPoIB,
which people are working on.

The following changes since commit 0a3173a5f09bc58a3638ecfd0a80bdbae55e123c:

  Merge branch 'linus/master' into rdma.git for-next (2018-08-16 14:21:29 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 845b397a7771f2d3504beff5521f452be0d22eec:

  IB/ucm: fix UCM link error (2018-08-21 16:56:32 -0600)

----------------------------------------------------------------
Second merge window update

- Switch SMC over to rdma_get_gid_attr and remove the compat

- Fix a crash in HFI1 with some BIOS's

- Fix a randconfig failure

----------------------------------------------------------------
Arnd Bergmann (1):
      IB/ucm: fix UCM link error

Jason Gunthorpe (1):
      RDMA/smc: Replace ib_query_gid with rdma_get_gid_attr

Michael J. Ruhl (1):
      IB/hfi1: Invalid NUMA node information can cause a divide by zero

 drivers/infiniband/Kconfig            |  2 +-
 drivers/infiniband/hw/hfi1/affinity.c | 24 +++++++++++++++---
 include/rdma/ib_cache.h               | 24 ------------------
 net/smc/smc_ib.c                      | 48 ++++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 51 deletions(-)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlt92VcACgkQOG33FX4g
mxrw9w//Xvs2ltPmikbtL92R6o2kFIWNJemfvUnJmVkwjAAdrAOM89h81apygOMH
yW91pwFSQomwc3YEU5p7lFVztiRZdAS0yaRPQeHyTrl/q2JeeBJa7h8BRtDVFRPC
jBGVCket6EkqmDW6oNlbc6b5AKIuU2LP/I6gFp/qmWKgQ/65Y5yHfT2T3LUBh0nK
0ANvz/bbPpvl7pPGd8DWx145L6KpA+VZTNOA37FXDBa8ZNs3Px8dmrq6QFtWoAz2
ibsHXUFHC8G22n9mqWvyl/IPdFqvh/MTRF9qUAlufC//VVvqCaxIwMfXjPRiwUZY
1Q+uoC37L3JYIsSd9gmcGeZQM7o/Vg2UKqlQ3iY+Dl5m349klvNk8SH1G2iby9Tk
t77uGjiuNsho6tYYSgyFe6YWbjvypk/NWVBPLG6JhLMeoSQy1XTprvwiCOfgsCFo
fQSgr0VGh9xZJ8DxT2Ea5BjXpE69bG/2xWzSPuRwja/sDZQbUa/U/2Ca4/m/j5tM
57Mz02zJq4s/gOawRaqy7cn5dW2yQON3aoy6OX2rQipQ7/9EAdKEedXQm6V8GcHm
ApiULqjaMmUbKZ+sKgB29V88VKXH5fj7kCpxnkQJkAU1R3l95vZOfI92VFYGEnxF
speTMfkfN4rM1ClCIfs5wQZws4XbTsSbTD2dkJdoQJRsU0z06Bo=
=9LN5
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
