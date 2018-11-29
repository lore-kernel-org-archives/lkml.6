Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C43E20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="D5zlUYX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C43E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeK3KAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:00:03 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:3552
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6hPJBE8rp/dkBB+9brAIxQIGhYcJJJ8W7oFy0DG1Wo=;
 b=D5zlUYX9/shdDgqm6ItyDAfXmmcXQ0OowLF66JxEk6FCuDV5OZHa6+MhxobGqczUejjMCvEYt+Ifl7PQCvgI+WcXcGAoP/+1XSjS+so7l4CBAFImo6uIlTYZQxdxXAI4FJNlF9L4cpN8YhPtG1+N/UBk9V8FjtbNv2suAXOjoiI=
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com (20.177.119.202) by
 AM6PR05MB5395.eurprd05.prod.outlook.com (20.177.117.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Thu, 29 Nov 2018 22:52:51 +0000
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::6136:d1d6:67c2:3920]) by AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::6136:d1d6:67c2:3920%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 22:52:51 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUiDZBRn+r9vI2/kutvufzRjsenA==
Date:   Thu, 29 Nov 2018 22:52:51 +0000
Message-ID: <20181129225240.GA2179@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:300:94::17) To AM6PR05MB5553.eurprd05.prod.outlook.com
 (2603:10a6:20b:30::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5395;6:i5dLBH/Xggv+SmSpPRa6VXtsW0FJXbzJBisoXEbWSd+Tx1UoGrrLaKqZ9mXkRdfurN5dXZmNjnysfRIfmem7IAO0F+Pkl9vkBmlKTZAe7Ni3zokaLitbJusGURk3R+/90KFPXWMAm12tSc6YOSuHgepZybqeKzK45sl6/OK7WnLcieNSJfJl+0adXd7b3SSq7qS3wwFRKQyo9U1DGoIBKLlJZ3LmbtjKRD4qmOy2HhGWuU7l18oA/9TTcYN7n+nRAX+QA/FmKZMF89lEtY+9cN4KUA3X+Dw977QD+i1yxNBUsSw3qxveMYLpTc1YOMPv6nXskPkK1VB/fMaqAln2S7knkfxd6OqoEQju8PM260Z4vOruHBImEGFdtqbfsOyTDHl7NkRFKp/YRouYq7dI9dpuTBCiiYnPWhkWgq9gdWASaoGcchkvJpAiUzjRPCi5kgIHWuoldQ46/5F+2wKQzA==;5:qPXRvLrKagw9GoNMIOmgfrEjO8VbXVXyLMuwGHv5YgeZAmFDQZ+Ckj4njatwTsQbpD47bI9qlUnN8LxFNzywZGVM7YvDbLKFkIwK/MFZvN50FV0gaiLPll5u5c8f73EnfpsPRqpI85noHv3Omdk9vQex5TIPAriWcxdm2oK+/nw=;7:8AENFbwIApK6VNFtmITB/OuwlFuMrdNbtRiFYtD9bYssJSs61pl4O/10bhGTDV5QITnhCc5N0Yw5fA5mNncM+s4IjQPkXEIaBU++wL5Sx9SKCTWKDSqyso95nK7RdRDz2WBVf6jrrfZNuk1spi27sQ==
x-ms-office365-filtering-correlation-id: 4b3bafe0-7036-4369-3e86-08d6564d6412
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM6PR05MB5395;
x-ms-traffictypediagnostic: AM6PR05MB5395:
x-microsoft-antispam-prvs: <AM6PR05MB5395DE49AD6390CE38710E0FCFD20@AM6PR05MB5395.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231453)(999002)(944501410)(4983020)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR05MB5395;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB5395;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(52116002)(99286004)(110136005)(6506007)(7736002)(316002)(386003)(14454004)(186003)(54906003)(5660300001)(66066001)(4001150100001)(478600001)(97736004)(6486002)(6116002)(3846002)(102836004)(99936001)(1076002)(26005)(305945005)(33896004)(2906002)(86362001)(575784001)(68736007)(33656002)(105586002)(4326008)(53936002)(6436002)(8936002)(71190400001)(71200400001)(106356001)(8676002)(81156014)(25786009)(81166006)(36756003)(256004)(14444005)(9686003)(6512007)(486006)(476003)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5395;H:AM6PR05MB5553.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4DnRzbWH6YnLTMnRu/w9135NYQRtcEgQ2bVdb0sLl4vdgr49n1m5NMNls91R2pbGhZM5PDTQ0h14WbMZVCAXVQsYgNaL0iLhMKwUEeFO/dSGO2uEriMjFDKgA3m+vZL098ekSGmSP2FnXGQiqMQHdHmQIlJXC4kZECiuSCVS6d3zyXOOi0Y9ZGiv+L8wAqnSGqdsvf/MMw/UKeYkxsKBpdZQuCjJ7B3Umqwz8wVzVFQJD/ve4uEZp+HIWnkQ8/Tp9Es8EK8z9kUuRtAkyDklFRQlgui5Xn3We4NEKMEsv4g9uT0nThzXBM0Uo1y4nDfY+4tNY8ziKOuo0ygMXM1MwirJ5ZKNnpNbwnfwi2hmk94=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3bafe0-7036-4369-3e86-08d6564d6412
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 22:52:51.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

This is a bit later than usual for our first -rc but I'm not seeing
anything worry-some in the RDMA tree right now. Quiet so far this -rc
cycle, only a few internal driver related bugs and a small series
fixing ODP bugs found by more advanced testing.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7bca603a69c0c239654a8f0bcb99e1a60b30040c:

  RDMA/mlx5: Initialize return variable in case pagefault was skipped (2018-11-29 15:16:45 -0700)

----------------------------------------------------------------
First rc pull request

A set of small driver and core code fixes:

- Small series fixing longtime user triggerable bugs in the
  ODP processing inside mlx5 and core code

- Various small driver malfunctions and crashes (use after, free, error
  unwind, implementation bugs)

- A misfunction of the RDMA GID cache that can be triggered by the
  administrator

----------------------------------------------------------------
Artemy Kovalyov (3):
      IB/mlx5: Skip non-ODP MR when handling a page fault
      IB/umem: Set correct address to the invalidation function
      IB/mlx5: Fix page fault handling for MW

Kamal Heib (1):
      RDMA/rdmavt: Fix rvt_create_ah function signature

Leon Romanovsky (1):
      RDMA/mlx5: Initialize return variable in case pagefault was skipped

Majd Dibbiny (1):
      RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Michael Guralnik (1):
      IB/mlx5: Avoid load failure due to unknown link width

Parav Pandit (1):
      RDMA/core: Add GIDs while changing MAC addr only for registered ndev

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Selvin Xavier (2):
      RDMA/bnxt_re: Fix system hang when registration with L2 driver fails
      RDMA/bnxt_re: Avoid accessing the device structure after it is freed

Yishai Hadas (1):
      net/mlx5: Fix XRC SRQ umem valid bits

Yixian Liu (1):
      RDMA/hns: Bugfix pbl configuration for rereg mr

Yonatan Cohen (1):
      IB/mlx5: Fix XRC QP support after introducing extended atomic

 drivers/infiniband/core/roce_gid_mgmt.c    |   6 +-
 drivers/infiniband/core/umem_odp.c         |  20 ++---
 drivers/infiniband/hw/bnxt_re/main.c       |   3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 128 ++++++++++++++---------------
 drivers/infiniband/hw/mlx5/main.c          |  29 +++----
 drivers/infiniband/hw/mlx5/odp.c           |  10 +++
 drivers/infiniband/hw/mlx5/qp.c            |  22 ++---
 drivers/infiniband/sw/rdmavt/ah.c          |   4 +-
 drivers/infiniband/sw/rdmavt/ah.h          |   3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c   |   7 +-
 include/linux/mlx5/mlx5_ifc.h              |  12 ++-
 11 files changed, 121 insertions(+), 123 deletions(-)

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlwAbbQACgkQOG33FX4g
mxp8qA/6Ag6znaRCHWIbRYSEWymYjJ1fxSX5wwAhdNX7Rmr0lu4u0+UPdYfjPdoH
0m5YJSLW2QavvXrykipClW+tnvAv+Y9G8nfRUQ42v/V0YEEko2hjQ/2hxu7cJzSB
dtqYKD/DfRUkaIBuAXYU64V5pR+/cYXVDj3+6e4AoX0YfrxjlWtwIjU8iWvgeb7A
+UnmR5jkq34d+TPmSpDq6myadjcIsNlDoNZh72y+mlbESLX90T1xSegCRlxeFxsP
9Ri7PckIWUQae9LxKBbwcmHL8pFslxR4YQLz2QyaQh7nzRxk+d9uQSozhdNDQ3Nr
oDiksGx4LbqnoU9swbNVZNfNZOhOesh6I6tsWKUDpqObJZ1kzRViW4K56Q5WcQ0T
Fi800b62Sw7pMgdPK3RIneA8GXKqRd7gTYG19iLTD0ZDAMO0soP+ccvxVJ5qk5pU
VQEk18UvCvoF5xKQuefT5pehr0lEKdtuSo/I9ZODwoszIHtng7CT9l8lfbyKGNPV
SgMNwe4rJBchbp8tTDTa+OHOxfqpI4C8lBgvZ7FdPa3Bi67hEtdeGl9YJXnnz1mX
HbmDLQLPLxSssI6abWq0n2wB6sF9JGMvW4/1Jq3ajcqnaa9P+gZdh5VSxaLDJ5ya
YDWU9n4BL4JB9OUpNBsrdS7a+QBo6tGc2DrAKvmdeOYgWzO3p6s=
=V5h+
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
