Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B75C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF221874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pr/Ux1y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfADFAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:00:55 -0500
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:36294
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfADFAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lj/kMCE58EOX+p61ezZjiUfpkbkWIwIfZNGZ2zeAmE=;
 b=pr/Ux1y2eKH6YHFzyIN9HBPV7ODi4ZUnP7PKF9Yqs6U57Dd7lTS9E4+TjTl9TNKosvZK7I7wEG5JLrLeFWzSSl6Ib+pOKgROij+ntitYGYzhKJedTiDf1EdRd4HiJgu9FjN6Va8kf/xkYZpWcTaQbUqiXj0rCqkVJVYTtmUbFk4=
Received: from AM4PR0501MB2179.eurprd05.prod.outlook.com (10.165.82.10) by
 AM4PR0501MB2705.eurprd05.prod.outlook.com (10.172.215.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 05:00:11 +0000
Received: from AM4PR0501MB2179.eurprd05.prod.outlook.com
 ([fe80::88a5:f979:5400:adf]) by AM4PR0501MB2179.eurprd05.prod.outlook.com
 ([fe80::88a5:f979:5400:adf%5]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 05:00:11 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUo+peroIC9bX/gUqW1YMgp8su9g==
Date:   Fri, 4 Jan 2019 05:00:10 +0000
Message-ID: <20190104050001.GA26256@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To AM4PR0501MB2179.eurprd05.prod.outlook.com
 (2603:10a6:200:52::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0501MB2705;6:G+Kt58/EWTBc01qrgLb/ItrhFtmI0Zk9XGSzeMmIuNIXabfXzHI0yGTJYMJAx86G8CQC0dJuueW6MGKRjt2yT7x4+ZVMc2Rtb69F59eZmimRxAf6oIlrWVLvNutjk038LHSp2MH/bNnlJwgzsiu1QzsWfi79YCNyE77NLMFzCoYOsqzvqvaeY5NBBSzvXSZDN7QaBYnt/Lcdzc3rVXMBJf+Lfxs56MiJADisCtrXrj+x/uHjdgg1wYj+A7I1cjrMLDujh8cpX+kFA+SjJha+fhe0v0d5fTndg9gnye+040pGHd4db6tqlsEQSFAHgW/0bvikQvudpS16swLw7ldKQL4+1J8X5YOwjm6dDjSarPh46jxJAMy1ZpqyunpEHObn5x6FtgHdxUeUE7HGM0Fgxy959aA2s0XJYUfHxBrIylkVQMUDEF+Hji9XfJ540uekOQhGEkA5nsCC9HFgghisOQ==;5:QQAF57taOOfFQdZtTGdQU4R6rYgDprYboGHY3HEU7jQdDlVqQjPhij2S85taTi1GS71vswDA4NfiMhAGeXFj2AP/SGmnGAYw/Mskc1zlnitXAek99FGWASniZXDzANfpLF6doh5JdVIJl14lKSgh/6OuIPKtZ/+waxQ4Xx8bgk8PSrk4dZpD2Qqsb8wqb272e4/tojwMgsaUDF4qvN8keA==;7:gXAeRM/pwsHKXaA+q40N1wxsAsCqth2/PbyoKsQy8iP0OfrUQHKNJLF13V1vF32Pjb4SB3icJ+WPP+yUZXACxBPdrRJ9FHmCfYYi3LANYTFdLxc65GedkSGKCeI++5jCc1f3SGknuVbBuOEPL5CQQQ==
x-ms-office365-filtering-correlation-id: 31aad066-29d2-402c-c0b2-08d6720180e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM4PR0501MB2705;
x-ms-traffictypediagnostic: AM4PR0501MB2705:
x-microsoft-antispam-prvs: <AM4PR0501MB2705DECFE236B9EA404F1323CF8E0@AM4PR0501MB2705.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(102415395)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(4983020)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM4PR0501MB2705;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2705;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(305945005)(7736002)(36756003)(99936001)(97736004)(68736007)(86362001)(1076003)(478600001)(66066001)(14444005)(256004)(14454004)(316002)(54906003)(110136005)(81156014)(486006)(99286004)(5660300001)(81166006)(8936002)(4001150100001)(106356001)(105586002)(2906002)(6436002)(71190400001)(71200400001)(6486002)(386003)(6506007)(6512007)(53936002)(476003)(9686003)(186003)(33896004)(4326008)(26005)(33656002)(102836004)(25786009)(6116002)(8676002)(52116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2705;H:AM4PR0501MB2179.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o07inxE9gV+DAXpBwTWbi1R81JmfgNDVpbX3zBzcZ5yKOg2W1VCNmy9jGGHBnqq7Xi8jeMXm9sujcAN2Yhf0sVD6DIWrT91/ffteVVt2+df6sIRpRwLBgmZLvRYW+lydXE6nzTITTF7ZQOLVYl+XNpXArCHWVCPcCRnFxUxTzcsWeKkl8O0yWTnsFErcM6N6wjIA8YlkCiLtppU8X3bYFP0lcwNkWsf+YK4V3GhSxDcAzA4bVuSqBO6NNvnH4BAKophW2L+mCjZTUu3Bp9Zuzs+e7gDzn/gFE/6zOhQgIWTBiJ6LZXMgrG+RGoZnG4qs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aad066-29d2-402c-c0b2-08d6720180e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 05:00:10.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second merge window pull request

This could also be applied after rc1. It is a small collection of fixes posted
over the holiday break. The merge error with advise_mr is worth fixing right
away so the other, more minor, things are coming along for the ride.

The following changes since commit 5d24ae67a961c51beb255a28c9c417d9710247c2:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2018-12-28 14:57:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 9c6260de505b63638dd86fcc33849b17f6146d94:

  infiniband/qedr: Potential null ptr dereference of qp (2019-01-02 16:08:38 -0700)

----------------------------------------------------------------
4.21 merge window 2nd pull request

Over the break a few defects were found, so this is a -rc style pull
request of various small things that have been posted.

- An attempt to shorten RCU grace period driven delays showed crashes
  during heavier testing, and has been entirely reverted

- A missed merge/rebase error between the advise_mr and ib_device_ops
  series

- Some small static analysis driven fixes from Julia and Aditya

- Missed ability to create a XRC_INI in the devx verbs interop series

----------------------------------------------------------------
Aditya Pakki (2):
      infiniband: bnxt_re: qplib: Check the return value of send_message
      infiniband/qedr: Potential null ptr dereference of qp

Julia Lawall (1):
      IB/ipoib: drop useless LIST_HEAD

Leon Romanovsky (1):
      Revert "IB/mlx5: Fix long EEH recover time with NVMe offloads"

Moni Shoua (1):
      IB/core: Add advise_mr to the list of known ops

Yishai Hadas (1):
      IB/mlx5: Allow XRC INI usage via verbs in DEVX context

 drivers/infiniband/core/device.c         |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  5 ++---
 drivers/infiniband/hw/mlx5/mr.c          | 19 +++----------------
 drivers/infiniband/hw/mlx5/qp.c          |  3 ++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c  |  2 ++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c  |  1 -
 6 files changed, 10 insertions(+), 21 deletions(-)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlwu6E8ACgkQOG33FX4g
mxpEQg/+M3QO0bU1gpZ70aKTJyL2oyOlqI/gJm/8FFkwVzJEIyk0v1fXv/1jgdDm
fYuhW4HH9dRrDAhckrJYtAvZpmBd62aVbGWwB0e7TZzPRYNpo4b2z2oWVsiMBKb6
SZTFk2VkRCgbCTo0zPAv4+kKOBGjQ7k1CMCcBWyrPL0sMGdlqOhb89bBqHSTmEAw
bjHP/5GDjoOH81+S3udQ6XlMkrCBa8szoPPWdzqIsXP5qkXkUejSB4wcp2HA/0TL
5O0uRE1Mkmx4FfS6+iHUdxEiuVsAzsMHXjuX4WHmnH1MOPxJadCG89zwUwraCj1q
O3WnZNBiKc1787iYBZtMgh0KrqGy9OAcJmMicsSqQXSTZBDpceRGxC5vJptrwBDC
j1Bc9qfJIob3hARtxslc/LWHR/GjIBlxg6rMUd2GUHG//bljYp+pbPsVKdT7M0VA
PkWvHh7n/yrrsiqWQoCpsB9gYKZaBbnR3JOxP3ELw2WCv2eu2curoM4n9Z+3FXYn
FVOFIhtx/j8rgJsUbR+da3//PoiPaUJcAXAXl3R8qJ5wwwJfK2lZk0aQjbiq+X7M
3RO6voSKEJdh75Imyc21lbHfOfj8B+vQ+qpWbAv47gNDNAu1HzrOAo/5HastXLmx
pek8HFzLshDXEa60YC+R4KZ4vTFfwNNfuZEQk4yXENV7vNVE3b0=
=TqX7
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
