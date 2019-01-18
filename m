Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D44C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA042086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ffgjt0ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfARD5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:57:30 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:58299
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfARD5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoVQ+AAxmvW5aa5AhMUx0blVd0tYdfou6cWIeO9DaBs=;
 b=ffgjt0zeFC5qq7Y1QKMImO8m/hXKUpt5fv2O81ltiM9BlyDoyeDPiBRoExdPSy6pvafhwn+MYufHfKujfJh9bSkJKVEwahiojB018Eox8nnGp3CIcGgkrMbjkqNEl/MmcJrC4oAls8nwIm/8aWX4j35hV6DM7m9IOFIERrlau14=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB1131.eurprd05.prod.outlook.com (10.161.119.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 03:56:45 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 03:56:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUruHU72Oz0ysj0kacvU4fy/WD2g==
Date:   Fri, 18 Jan 2019 03:56:44 +0000
Message-ID: <20190118035637.GA19600@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0076.namprd17.prod.outlook.com
 (2603:10b6:300:c2::14) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB1131;6:qlbKvcqadspGt9Q6IGxxb7IH2hGSaUbypRtxJunYwEyafczclPQ5LUag320mDWr6Z+waajGSbxfmgaWA4ZU7x+6cuFHJo6iWQjkzSXvHmDuLq4K6Rl+qbm/rOOJIPXloOOH11p5FJjtBSuZBBUNEg4pJgoi1P3v+5InR9Wg6Sk8kSXL+ERd0CvkGfNH31QX37fg1z3d/G4oUJQplcgey2LBG3ZODfmloF24qKO6oJO4Acqb4orKUYfl8QZ+YpW9tud6JbDL1+LUFkkETciJdnH/bylexK0oUa0MVJkrtWbj/nRSx2TS05CZ1UPp60eKt2ur64F0VujPuTPsWQr8kiHVfaTVACk+G6gkFBYIatU9hBL7Pv/vqSGMksXOgYt/qb+3zBLpCS9EBUUdutYnaOLuA/ahzkQRHXuDZTQ6KA6wv/0R8lUWlSsl5ONLCbahDx/WXINWe7DM8DGHF1QX8QA==;5:4Vz8hSK1xILuTU66ML95c60WA/3SpfkoWwYZCws+ZKSBExzyed9H6Qf8gPuWKFHheOwEEbqKjENf9vFBOqA9Ow81gtCMCLalAt2wgd3NQ9DAiWjBbeJBY0B3OORyj3lblxK2ZlCwviBixNCFhKzc4BhO6ipHXuVC2BtpIOln2JILHp3KQKoMt7fTcOo1gXuaQBUv5FVEhDzKK5aiCQxZgg==;7:+21lfHzNhAM8seW66mxuGmMBkfkxCEb6A/rUyzsyDMbJWOuqbydfOeQ/4HuOMe8NL2qpMKLXc8IjKLhJqqapqQmznx3hgzgJSC/ZBRfUPLhP62uCY781pTzrTOTBn/CGac5ZQ9daIX4HXEHlaUf1fA==
x-ms-office365-filtering-correlation-id: 0f79a351-56a2-4c8f-188c-08d67cf8f662
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:HE1PR05MB1131;
x-ms-traffictypediagnostic: HE1PR05MB1131:
x-microsoft-antispam-prvs: <HE1PR05MB113159109A6B0383FD159DCCCF9C0@HE1PR05MB1131.eurprd05.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(81156014)(86362001)(110136005)(1076003)(66066001)(97736004)(186003)(305945005)(26005)(6506007)(81166006)(68736007)(102836004)(8936002)(8676002)(33896004)(386003)(99286004)(53936002)(6116002)(71200400001)(71190400001)(478600001)(3846002)(2906002)(52116002)(99936001)(256004)(14444005)(106356001)(6436002)(36756003)(5660300001)(6486002)(4326008)(9686003)(6512007)(54906003)(14454004)(105586002)(316002)(25786009)(476003)(33656002)(7736002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB1131;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3E1LhOdM8LSOuNYB0zGL3AL8jjQOFKWKGbdLJp3J4uaiU9dM32LLnCZmO9I2ZCCUPAGjLSfMm8JbG9eo0sIKln+jAMRj9HzjRAAGVod6LLdP3TQ6PRjjOMNrc4GHjlsrLOLr8/jHkjbHbckb0pHQ5dZ7ahRnAFRqwSnFoHI4OYGbEKhCOSn4pXJP9b4TH6x0frJss5jIJjZWBmWe0YPUlBvDNSn8tp67bXQWlDIf+EFnXhNhGa/DdTSRZ5btHn1LES0Jf2oeBArhwrhmfbhHe9pINe9anwfUS8109qgg5H6aMrb+lLJjsIRWDmhpNlrLyLcUPcKYoefReKIERYw5dH8P80KZmQHyuBqQ31vsg8PKm9+qTEdtAFJ6aTaqWLuNkmq8/0PPKMs7j38Ru2aIermZpsiVKSfst71ZP06T7lA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f79a351-56a2-4c8f-188c-08d67cf8f662
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 03:56:44.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB1131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a small batch of patches for -rc today. Thanks

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d6f4a21f309dfe10a5693ad236358dd6fcc46f7a:

  RDMA/uverbs: Mark ioctl responses with UVERBS_ATTR_F_VALID_OUTPUT (2019-01-14 14:02:22 -0700)

----------------------------------------------------------------
First 5.0 rc pull request

Not much so far, but I'm feeling like the 2nd PR -rc will be larger than
this. We have the usual batch of bugs and two fixes to code merged this cycle.

- Restore valgrind support for the ioctl verbs interface merged this window,
  and fix a missed error code on an error path from that conversion

- A user reported crash on obsolete mthca hardware

- pvrdma was using the wrong command opcode toward the hypervisor

- NULL pointer crash regression when dumping rdma-cm over netlink

- Be conservative about exposing the global rkey

----------------------------------------------------------------
Adit Ranadive (1):
      RDMA/vmw_pvrdma: Return the correct opcode when creating WR

Gal Pressman (1):
      RDMA/uverbs: Fix post send success return value in case of error

Jason Gunthorpe (1):
      RDMA/uverbs: Mark ioctl responses with UVERBS_ATTR_F_VALID_OUTPUT

Leon Romanovsky (2):
      RDMA/nldev: Don't expose unsafe global rkey to regular user
      RDMA/mthca: Clear QP objects during their allocation

Steve Wise (1):
      RDMA/cma: Add cm_id restrack resource based on kernel or user cm_id type

 drivers/infiniband/core/cma.c                |  5 ++-
 drivers/infiniband/core/nldev.c              |  4 --
 drivers/infiniband/core/rdma_core.h          |  2 +
 drivers/infiniband/core/uverbs_cmd.c         | 11 ++++-
 drivers/infiniband/core/uverbs_ioctl.c       | 62 ++++++++++++++++++++++------
 drivers/infiniband/core/uverbs_main.c        |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    | 35 +++++++++++++++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  6 +++
 include/uapi/rdma/vmw_pvrdma-abi.h           |  1 +
 10 files changed, 109 insertions(+), 22 deletions(-)

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlxBTnIACgkQOG33FX4g
mxp/Ng//S3v33wYj5OI5rTMVeWrMm8F/FJxidLJt43v+AH9SmMF6jdvMQZ5s6ekU
tll7poTvZj3tnv040o7G6kumH2GOcx5i2CzqJ/hSmSha/7Ir3PEas7zhgMZSJMx2
r0jFFy/VikTIXLN9hJIWs6J3X2Thvz72JScDPlY4Y7muxTgeXWCVFQ4HLK3htG52
q1WKw0xLhokF8C8DNUnwr4SjHLfFxyJAbA0Bo2YgPML05a7uY+fVnRJQMo3nuuCC
zY+PHmiYpCnubl7SEc9iUzRNsvm0k3fetqJymx1KPltpJnja7mjAu0JbFcFFWVB8
ToWo21N3O1Mg7focHauvbTH5iy8V9vLad4eqmmbIjHDGMEzy544lAcz2flf1OI7T
MjAOdPIM26JyKOmsyLSC0k6WJlwotaDNSyRjqnLDSXrZmQZi1NmWtdg/toicKo5r
MGDYivM5WxrfAzPcQbnD6w/jhTnOVJMAcgtgEYsL4yQAvBHFO168kDpyGYkVtnzL
6kSmW54bclhBhHk7llGDjUsBIN+fhKe+jw2gF6AW7O9b1acxdPe+fMsQCLty36gh
jdTIm9cq82276tgE0AZQGF1EN5j4STF7+DqZqxLIAK3MhZkMhIK83hyYyaULrxbE
2uNjEW64edf7MeTjWjizHpAvbUMbtbAlueipKTCNGYVz+dP9bfU=
=gd17
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
