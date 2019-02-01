Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1778621726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="yzjY+8OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfBARlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:41:16 -0500
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:11609
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbfBARlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wp0KqTl0o+TgPMs7Q3907F1hg8RbAxNo9YbYCFQU2Y=;
 b=yzjY+8ODZOkilal/7ao906dHARaPursaq7MhIvDjndGqnUC+kJVwc+zO+phOeIMrzlL7Dy/RcGaPr30wmOmYWlqYuzHxCkSz0dGXGCIGaMn4OQv7pKPh5OkBWa4OpQ2BdYM+Z/pS6zly4clw3Mj2FnDG4y/7d4dltV5L0b095pE=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6540.eurprd05.prod.outlook.com (20.179.43.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 17:41:11 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 17:41:11 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUulVSyUTMgg1A5k6NWXwwFDG+tg==
Date:   Fri, 1 Feb 2019 17:41:11 +0000
Message-ID: <20190201174106.GA25156@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46)
 To DBBPR05MB6426.eurprd05.prod.outlook.com (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6540;6:3WycAJve2FLARvK7y2jDw1/jrJxl0TTIHjyRg0UCubQ3nPrG9UHuPzpt6Hyo7+I5GSi4JMgSaPlSjnWnlm6SBtCGtcJIqJVEYDJn7VfLXETUdoOcGR2SxL3oF3paXT6n6Rp23Qu0j4ea/ysKqXwX5r0FPrPFZ2UfHmH5FmYON1q1VNoOq5ByJM6wzbgmnosjgb4mXe0xliZmCi3K9318qi7mK70u8HY2L1fj6nGRCNXPVr7gnpwCOQv7lI788sDmew6n02tMOpzdT4e1HK+fr0dqCzViZP78BXKedH++d7q1XvUVYM8KcEUuSYtNw1PQ21QrmPumKasuEDQnUtCX2An4VkBSU52vHm2iOYDm3qTortT14HA8PPaPSWuSM/sbgUKjnyYdqgmZ+Ts97IGZ9erR49Vb4QWbQgJN8nI1OuobF6RmCLqjnmbd6pOSZzQ7QMmdJ3usMmKJKKrrFH+rxg==;5:fWK7bE1D7A/XI6wZ/xNk9RlhcVwWErbNG2NRCgeD83tNBrfgi59yNbWetW8Tm/0LYQSnigSIoConcqiNr8A8JiN3mFBcum2YJLzAjcpdpg6+WZDXmaMj9tSpCtok9I1K3zEEG43QNGylRxsl77N1IpuF4Q1UwGkRQ0RiLCrbIbNfN+BTnK3d7tBZ0gG+WNquvcz5KBasZelBBs8LvWA3Ug==;7:Tj8nutj86Zw4oFJkmmCVfc8qzFjb9azFKR9++O2LvsZPT0bmAa/lrC/mng9UtYfA0t4yxRQAHNh/7aFjhAgKPRne6M/UpJTzsDMMZmrg1nsU723eYut8UBCt3QahVdZ5EaP3QpzB3QrXACw3FPUvew==
x-ms-office365-filtering-correlation-id: b258ff20-5a0a-4781-54e9-08d6886c7497
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DBBPR05MB6540;
x-ms-traffictypediagnostic: DBBPR05MB6540:
x-microsoft-antispam-prvs: <DBBPR05MB6540F873D4AB939ADBB94A42CF920@DBBPR05MB6540.eurprd05.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(71200400001)(6486002)(36756003)(6436002)(256004)(1076003)(9686003)(68736007)(14444005)(6512007)(2906002)(71190400001)(86362001)(25786009)(4326008)(7736002)(81166006)(26005)(33656002)(476003)(8676002)(102836004)(386003)(6506007)(99936001)(53936002)(305945005)(486006)(97736004)(14454004)(186003)(81156014)(478600001)(52116002)(99286004)(106356001)(66066001)(6116002)(54906003)(316002)(33896004)(110136005)(105586002)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6540;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dbYyahXkcoWIq3oiDNggnEMyBcMepSN6J6CTsQCwrAJdB3cEpIgXw0wMyWsvlJQctyJyGhJjCohDtPI0ShgocKksxJRnPfqffQYB2cgRY5OAEvo8FPA9W9SU5E4iWJStP9PZEZSXNsdhoZR/FjbmSO2+Dt0PjDpAiQAJWzQ2cYDMS++xx3OUNel//sr91Y2ULVbcDTVGCyFDjEiIigyS8P5q4tLC4L7r/WELVDPeKFlJyywQDcRMEZ2r8fVZvO60WRudRH2X9c3MftAhSdOR+JAUptfZaahbjCbvkKfMHqiNDt+ax9jeS7flIMfhU96fpjB4cvan7DDx0mSCzzel1XN3BnOT5TUK/FMFBF5zrentZf8ZOdrn/bcy+aBdwUq6FpwCwWJhks8D/avzzkN2iYIwjxBp6FeYmJo7Pv9Mg7A=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258ff20-5a0a-4781-54e9-08d6886c7497
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 17:41:11.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

Still expecting some more bug fixes for new stuff merged in 5.0, but
at this rate that stuff is looking likely to go into 5.1.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7b21b69ab203136fdc153c7707fa6c409e523c2e:

  IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate (2019-01-29 13:57:22 -0700)

----------------------------------------------------------------
Second 5.0 rc pull request

Still not much going on, the usual set of OOP's and driver updates this time.

- Fix two uapi breakage regressions in mlx5 drivers

- Various oops fixes in hfi1, mlx4, umem, uverbs, and ipoib

- A protocol bug fix for hfi1 preventing it from implementing the verbs
  API properly, and a compatability fix for EXEC STACK user programs

- Fix missed refcounting in the 'advise_mr' patches merged this
  cycle.

- Fix wrong use of the uABI in the hns SRQ patches merged this cycle.

----------------------------------------------------------------
Artemy Kovalyov (1):
      RDMA/umem: Add missing initialization of owning_mm

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Feras Daoud (1):
      IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start

Jack Morgenstein (1):
      IB/mlx4: Fix using wrong function to destroy sqp AHs under SRIOV

Jason Gunthorpe (2):
      RDMA/device: Expose ib_device_try_get(()
      IB/mlx5: Fix how advise_mr() launches async work

Lijun Ou (1):
      RDMA/hns: Update the kernel header file of hns

Mark Bloch (2):
      RDMA/mlx5: Fix check for supported user flags when creating a QP
      RDMA/mlx5: Fix flow creation on representors

Michael J. Ruhl (1):
      IB/hfi1: Remove overly conservative VM_EXEC flag check

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Yishai Hadas (3):
      IB/uverbs: Fix OOPs upon device disassociation
      IB/uverbs: Fix ioctl query port to consider device disassociation
      IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate

 drivers/infiniband/core/core_priv.h               |  1 -
 drivers/infiniband/core/device.c                  | 13 +++++++++---
 drivers/infiniband/core/umem_odp.c                |  3 +++
 drivers/infiniband/core/uverbs_main.c             | 25 +++++++++++++++--------
 drivers/infiniband/core/uverbs_std_types_device.c |  8 +++++++-
 drivers/infiniband/hw/hfi1/file_ops.c             |  2 +-
 drivers/infiniband/hw/hfi1/ud.c                   |  1 -
 drivers/infiniband/hw/hns/hns_roce_srq.c          | 10 +++++++--
 drivers/infiniband/hw/mlx4/mad.c                  |  6 +++---
 drivers/infiniband/hw/mlx5/flow.c                 |  3 +--
 drivers/infiniband/hw/mlx5/odp.c                  | 10 ++++-----
 drivers/infiniband/hw/mlx5/qp.c                   | 16 ++++++++-------
 drivers/infiniband/hw/qib/qib_ud.c                |  1 -
 drivers/infiniband/sw/rdmavt/qp.c                 |  7 ++++++-
 drivers/infiniband/ulp/ipoib/ipoib.h              |  1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c           |  3 +--
 include/rdma/ib_verbs.h                           | 24 ++++++++++++++++++++--
 include/uapi/rdma/hns-abi.h                       |  5 +++++
 18 files changed, 97 insertions(+), 42 deletions(-)

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlxUhK8ACgkQOG33FX4g
mxpmNhAAmSLASZl//oihgybO2fez3/V5VLEhBcOpJf3bHDf0XYE83fjrZzrFE3EO
dujw2Zb9Xpe4r21ejQwgpHMeHmqgrzplk0Lmk2xGEK3lEUNIGz+SX7PDr7J9IcWm
ojw31ySL4l0GmqUYQVTbQFUg1aNa+1ewa2CRRtlusM8BlrY+A6DrhnNpgLPVBJ2K
rvOc69Sp/UBb7MLgopT94PBEpT1SvRiCH5D360Vw6u0nMvW4h5P7OfHab3jMbgy1
LpkbjmTdZnNHdM0J47Bk2dnU7ATu4C4bpCoZhlrefJPItg7wdt+DZo1y833vk/Ah
c+uDyBhaLsuZIJCve5er8P0RcC5/10mI51HSTap3uQHIxYkD45XED/h45qlRsuJQ
SypLy5lAuVXmMcgUYxBXde/BFXoBlHJwAWOqGGDRobW7PtOp+s5L7Ca06DQ4vbPy
nB0yun7lGxfSfet0mMV/b4ifPH8boe3ekpAS9mbwoVZQjAy7yXs+SUYOZcWF/qDD
Nc3dsxkzBr5wpTUjNLKHpiAblrCMZJCujWg7nHbYWABAKBtWphXK9/xBWyBSXVwe
B+S8Ke5iG2sBdbmqAYZTgWRpHOIok9nkY9YTYljX8gQjVObxh5vviHL9VDmQChL2
ZkFP5zI+Mqy9OhJkO08HgZVgA/1dgaBOEgpl27AVgkLoVaCNlko=
=PCvs
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
