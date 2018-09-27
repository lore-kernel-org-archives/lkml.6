Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B9C21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ev7hbhPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B9C21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeI1AoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:44:23 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:33258
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeI1AoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgXmdK+scb/EV/87JdMAmBENo/o2UAwZXl6+V8c65ws=;
 b=ev7hbhPcnItrthZzRi3J5+N1557UjjN0G0BvZy71Oflr3pWV6+cQgN7SRz3YXGRn9iJwF5PEJ9MFonFWMISzzTdVG6dxpQR7DMrmrqKKqRsO80sm01VJqCqePqwzD8430R7T8Z5cXCeymUtc6CK5tGgie6SwLku4zvOwuysmdv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4460.eurprd05.prod.outlook.com (2603:10a6:5:1b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 18:24:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1g5axk-000310-5J; Thu, 27 Sep 2018 12:24:32 -0600
Date:   Thu, 27 Sep 2018 12:24:32 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180927182432.GA11505@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DB7PR05MB4460.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ffef26-8f61-440d-0b3d-08d624a67e41
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;3:eYaA6K5DJUJdUn7OfjbRKz4G72eLmiiJHTlLYFJT26+/ABOAgdyeytdUONUeSzF8tcY8XYPJWPyhgfNcCgS0pYyQvl2e0bEUWd2unrsRVnX6R1+Pilhd4Jh/xu+8hLmIykk/6wXQPQiMNqNrCKZptuLsDJKVtY8sniR4lEzkw2xolmxyihAJJLueU2JMAdzavHDtePtSg3N/q1RoLkVfG0N5w7iYg4+zfcvcB2JLbUFo/9jlGPr+MjVi1uv4W+UP;25:/e6tcTTSrg+L7gdUfegYDvtpNSH5vW5Qt10DLsCXyQF0U8Zvd3jO/1UrZSqDJ+J5H8vOsQQ+EvIiALZ/XnPjyB1sotZnhZRio8xOZBvBr22NYhvPnH9m474qz3zK47F0xgYVmGoijypW7Z0Xx24fos/3Q54DHBVzL8b7sSnbtVl0n7uunTxr1ycLSwLSeH1+XD3XaVp/SPrNIk42s2gAmVvEMcSWwJ+81fvNYCGuueKgSLXNonuHpgk5wipV4LHTp18FrJpTOWWZC9YwP/iYhBedJo48b7Cw4KstuJX+KH+resmnaWt2YdUpoG5aMsfetV0ADmkekHFf0cCDqf27TA==;31:3IutGC2mbdcWgPYE6KS08QBiZDqhby2nuE6kk189pYSrzXNnuwIOwHV/LmTesK3c5RMEnNfCO+v0cRyHjkWkaT/43olUa/okkc5zYwc0giAVZyct0PziqVVghp/P9sc60uBK/9/nmKskkKzXkDTCa/wujY9H0kmbOaHUkKVkVURmCdqe90jjXd3POgvbsEqZQ1fTfAwBnBHGVzsmTq3Gmk9lGC6wNrTEBgYG1rycxoE=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;20:ciZMUqZtX4uZRcsEiuNPet22cdvdrbXf/tDXFvULkCKKT81aXVFab4Uj/syUuXuuR8s63Ds68pPxWSYeuN0d73Pv3zZThzX1ohvq9LixPCOQlrcDLNO/KASZf+9jSUZZdWMzj578iybvlsCUFQ1it4TkKi9mFOJuHaWK7mm6FVwwzKZSUO6Yb9M0peE3Uu4YT2RSys1knPbhIz9xaxE9YG3XMhiQ9FHW7kUElut8zIFmWmzeP2znxlL5bVr805THfb5TRHBQbAimFejcbqYPxDmoUs5mXbx9/CKts45oO/vlbcaeEgHrmaaMclOxK/jnQfXBiQMHRV2/ZFn4qLLs4WhUb3Poqp+fP6WrD2JWPNUGllWsKLZKtrxfL9fg9vEaps3HD+83I15rrQRQ8pIiJViwZkgPOMJwPUpFtGhxg8RxuoCZoHVuaqfoYTt2Nz8sAo7VZuKuV7gLUR/XysYxaGlQgK7zmaZS+YoK2zCF0KsqJs4vfM/YLGXjsrC6bvba;4:MIB/8sb4ffjhV66RFaqtw8r3/Ea5uDNFv6nd98f3xveBkI+xFEWzYnq5p1PG/NjkNV7Iyqzw3MRh4sYkFqrmo1c0VrqKzLPk7l2gg/fqRtTZWlSkE/3S6uI56nxUyvXeNKaYgA6Q6DDizSWdugWDKPL/OnH60i2K8MlMQxV1VWa7Dsp9uldUpgx2Z+wBkZR+P56gPMFQg9+UKZk1RsucH5VNKqZ+r5YiPuaQ5yPLJfw7lI/gnYL59IMPY94k74rvWaMPqugJsFBRA3wAmBUkrsOoAVbjuAnfqXftFR2JkDIEFjCo4fStokky+FhmhWfq
X-Microsoft-Antispam-PRVS: <DB7PR05MB44608F4670046CDE9E71A64ECF140@DB7PR05MB4460.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:DB7PR05MB4460;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4460;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(86362001)(575784001)(46656002)(4326008)(68736007)(97736004)(110136005)(316002)(26005)(69596002)(16586007)(106356001)(57986006)(9686003)(83796002)(2906002)(7736002)(186003)(58126008)(105586002)(66066001)(386003)(53936002)(305945005)(63394003)(36756003)(81166006)(81156014)(486006)(5660300001)(21480400003)(1076002)(8936002)(52116002)(8676002)(478600001)(84326002)(3846002)(9746002)(34290500001)(6116002)(9786002)(122856001)(14444005)(33896004)(71190400001)(476003)(44144004)(33656002)(18370500001)(24400500001)(2700100001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4460;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4460;23:k/vnHLtEzigR02VfpcJb3D42021FzBFgwxsCemRrr?=
 =?us-ascii?Q?ngh7JYxaFAhaJj7f5TFi1T9pi9lWSm8GFKtB4eiphnrgF8L/Ll3FrlOPo3uN?=
 =?us-ascii?Q?SI91spOE4fwNwsAcv1Ft8CMAsMgrvU50SrlUkILQj5X3KaypMszy0sLHzZEi?=
 =?us-ascii?Q?XwryQoYJraNofbm0G+ll9Be7pVu0IFODdIvf9U+kZJcyzs2n00E4u8xshI4/?=
 =?us-ascii?Q?+hPsMl03wbH4W4xa2gjlADsYQnicV99c3Zpha91ZWr57gQE77+Joc0nSM4uZ?=
 =?us-ascii?Q?vWplwUap5WbsuOCfRn7kVVC3dfnuIpetkA57bNbikcS3ix8pPajQC//RAUMy?=
 =?us-ascii?Q?CmBdjlzUVq6ZCyzdjY0J7Sc+++XSqn9MLV6NbPgGONZw1F07IQwWFrSDP1F7?=
 =?us-ascii?Q?aCub6Ie4oE6+C1NQQ/4h+YkpLkbsuPgRsxqvmV/4feVNOn4hGPwB1hpVHAdr?=
 =?us-ascii?Q?eoWsVVYJBOSX5WvBNUIH5+I4wGcHxOR04Y/7MY9BCQDilSS/s/cNvRbbfBSY?=
 =?us-ascii?Q?YzfxBVu3d1VH57wLa6Ih3OLq9hBfO3Cg2USuodLsqSSKtLdBhTnmMVgYIWFK?=
 =?us-ascii?Q?0MgaMw6dMoQhaHyexjmFUAKugwgDxNYObcsc3E5WRGoCkJ74r1chbBErg7RE?=
 =?us-ascii?Q?BOfFR6+B4t6FkmuVsgs8YN1uI68uHSaDdtE3cysDDuigPINGTzzmk0M34fxr?=
 =?us-ascii?Q?nDkYPD//ZUP/Tp3P69cEGj0YiGPreIn/cL9OdqyS3g0uAes9297VHq7Wf8HT?=
 =?us-ascii?Q?FJv1m7HK/FaF5U7OFkY11PnQ0hrMBtJzAhV+U2yoGhys8SNYh//S8Jx7Req1?=
 =?us-ascii?Q?Vf0G78AL3K3aWWEWZO1uob6UMWWVaYUNgyWpKnLAFzmzjbLGofkz84ML2exs?=
 =?us-ascii?Q?SMne/1t7OW0rueLD8UrKCzOLaW1S7EPwS//ynUlkSLKuE2Z+ZkSBK53utK2x?=
 =?us-ascii?Q?EbUmudj04++3ZpKIa0hiigs/cIF7TtbGHS5kCSawQMwxybLwMxpNcbZbEuJh?=
 =?us-ascii?Q?UXRPJP7/haDyc/iPr6iA4gptNPK3mIu5pyUy9B7AktxANG9sFsG/DkTQ6Lsz?=
 =?us-ascii?Q?ff1mRSGUZfdN5/s56mMmTbkAJsCJpMdtf58vt2prleh176kf/bs7+HIylHx4?=
 =?us-ascii?Q?bUYsjFG4n5gwarYnsdg9UPoWcGHVztdHRI06W7t9lk8CzROiFl9FUp+tBGTk?=
 =?us-ascii?Q?efY3s5fBINvyEJ86wMvsZHHBkb0dQFIBLUpWsGFvIA/blFxm6/I/BSzEwSUA?=
 =?us-ascii?Q?ekbG9KrWGseyb62feiE3yxq1ZiGWXOMvFpjwpNL6zv84uDTtzLadLL1KMNdl?=
 =?us-ascii?Q?BdkPARG4bzRsKQAIrGxN2PDIswXCtUsqV73PkvdRbGJvgbtgFfkpid3PGT4b?=
 =?us-ascii?Q?nnEreArqjAczhnnZ6qnqIz4BmWHsSDx/hAQ41FzvynIu1sx?=
X-Microsoft-Antispam-Message-Info: kLfJ5B7sHkD8Y8GKDbDhYlrPLEMFpp+z4ImCX0xYWUXqCIyrsHdIxivuK/I1UGwA7ACTrFhrS3iPvJ/qRVsoaj2oep1rMbjs/KQRN4cX+T2IiHIilLDk4K2MInZbpYYLur1zcro+1RMFH9xa/phmQ4UB+FP68+oFSGg9IF0YvOKZC/O4R1c4x9XaCs6C/FdSUnDf2ixXjcwaUR+E4woESdacqwL12B/hSmhyj9xjxMbRjpc7MjU0tpm+47lSfiTS7/dRs/wbMB2/O4xKe6ImW3ZBB2ZAg4CK93HfCG78lLb86d/x6gR89SQ46biQQiaeW0SP2TLh/H4Pk25gZLM+sYLpnfuTbC9Q+r1QWzbHpys=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;6:guWqG5LdBp7FJNxEx0VnGwRd9ZsTZubt9k4hDoSPyp7OLggyn4ZAyWYTuOYjt+1PsmEY8Byi7I4bANeICPLpPPTCG9j4C9yvCSwaEeXpH/laRb24FbH2KJ7omo6xV9qe/QNzvhC1/aoEx1HKXm/1W6qnNIibbOKVRQS6pZH05TCVg32n33j3e3pD6QEY1Z9U4MUWJeY5HGw3XBjf0jofk0bcXlW+3ZiMHsNbLHlgysYxLzFl9Jzgxc8gqZw9vK4XVtsXPcSN9n6tJdb+jxpN5gJuyb84JPALaLgPogIdvWRi+TfCILKuIeOl50mJk3Fr3oDPSlE8PJ5Mtbg4O72WbC6EnNmNcu+XZo+qmRqi3rrgcqGkvKMV3J45YbSmgJgpRAKYy2qkfy3eyesVVv5ayvnj9CqfkMcIO6xDiKEONozikjfRV/e3Yn8QRjqKw/pBnjE1Ky9tfa0WB7+Mcdiw3g==;5:3ZU2vvkHB/31vEVORbXo/0aNFClz+cYkUca9Ybex9bS8D5U3FAyzurhBeOciG8AKkcsa8geLIKffo+r367vY2u3mzy4a0zNO5e6eEzA9oHKSlBanC2r132bzmI9ccjusCDE4oLsMxSRKhlU1/C/vXq9hNap6357Macsc2N2RjfE=;7:uLbZjIYJg4gJF4Met4lzdRKABCpz53ok+GHTsPLABDN4H6xsPqutYfWq5cts+sLzKx+Rl6d60HE0HfKYqB8lFWKHbVLdXEc6cpoRDxgsI1WJyZV8kbn8ocucagZfMx6RQNlfl+c1011GSAOcSou7ogSv6f58xUtJBsdCZ4zD85+JXI+9Nuw6168Jy+YjEWUVWNAfdWaytqvEw1pEqTtmnT8g8oLIBSQ8FLFnflK9jN0s9FB9qfEJlz1G96NivLlx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 18:24:42.0856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ffef26-8f61-440d-0b3d-08d624a67e41
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

Second rc pull request

This has a few fixes for smaller regressions introduced this cycle and
the usual various driver oops fixes.

There is one long standing race bug in the comp_channel that Steve was
able to reproduce, track down and fix.

I believe the HFI1 driver regression breakage has been fixed in
Bjorn's tree and I'm currently expecting the lingering ipoib issue to
be fixed in the netdev tree, but patches are still delayed due to
various holidays this month.

Thanks,
Jason

The following changes since commit 8f28b178f71cc56eccf2a6e2c0ace17c82f900d7:

  RDMA/mlx4: Ensure that maximal send/receive SGE less than supported by HW (2018-09-06 13:16:12 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 5c5702e259dc66e6fceed5117effab79c186e87a:

  RDMA/core: Set right entry state before releasing reference (2018-09-25 15:01:09 -0600)

----------------------------------------------------------------
Second rc pull request

- Fix a long standing race bug when destroying comp_event file descriptors

- srp, hfi1, bnxt_re: Various driver crashes from missing validation and
  other cases

- Fixes for regressions in patches merged this window in the gid cache,
  devx, ucma and uapi.

----------------------------------------------------------------
Bart Van Assche (1):
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Cong Wang (1):
      ucma: fix a use-after-free in ucma_resolve_ip()

Ira Weiny (1):
      IB/hfi1: Fix SL array bounds check

Majd Dibbiny (1):
      RDMA/uverbs: Fix validity check for modify QP

Mark Bloch (1):
      IB/uverbs: Free uapi on destroy

Michael J. Ruhl (3):
      IB/hfi1: Invalid user input can result in crash
      IB/hfi1: Fix context recovery when PBC has an UnsupportedVL
      IB/hfi1: Fix destroy_qp hang after a link down

Parav Pandit (1):
      RDMA/core: Set right entry state before releasing reference

Selvin Xavier (1):
      RDMA/bnxt_re: Fix system crash during RDMA resource initialization

Steve Wise (2):
      cxgb4: fix abort_req_rss6 struct
      RDMA/uverbs: Atomically flush and mark closed the comp event queue

Yishai Hadas (1):
      IB/mlx5: Destroy the DEVX object upon error flow

 drivers/infiniband/core/cache.c             | 68 ++++++++++-----------
 drivers/infiniband/core/ucma.c              |  2 +
 drivers/infiniband/core/uverbs_cmd.c        | 68 ++++++++++++++-------
 drivers/infiniband/core/uverbs_main.c       |  1 +
 drivers/infiniband/core/uverbs_uapi.c       |  1 +
 drivers/infiniband/hw/bnxt_re/main.c        | 93 ++++++++++++-----------------
 drivers/infiniband/hw/hfi1/chip.c           |  6 +-
 drivers/infiniband/hw/hfi1/pio.c            | 51 ++++++++++++----
 drivers/infiniband/hw/hfi1/pio.h            |  2 +
 drivers/infiniband/hw/hfi1/user_sdma.c      |  2 +-
 drivers/infiniband/hw/hfi1/verbs.c          |  8 ++-
 drivers/infiniband/hw/mlx5/devx.c           |  5 +-
 drivers/infiniband/ulp/srp/ib_srp.c         |  6 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h |  1 -
 14 files changed, 184 insertions(+), 130 deletions(-)

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlutIF0ACgkQOG33FX4g
mxpvPQ//QrTdL0zKmuB/nk+HrfArI3Pp0+ZYkOCm9093d92f/aqDuyRE9GUu8Y1j
YfRYlFmvr78yGX6NMTjTKZYJ5S7B7gwMHdWXIhk6N+95dJ9q2ohCS/wjoWWT9qzf
IpJGP9FIpsASD3bMCdfhxjgl4fELcOkDFdQuEZI1zDwlee4sIRDmW/g/CiJQdlK1
FCfBSkANL85s7uD1A5jVSvAsEXXLzQpqK+t6CTdEfVVliJSYUHnehgOQvMU2Pku+
Nys9v7XWi+x1zAL8TkVUEr1xG4UygDvZlRlQBWJ481/rdzLWfh6tfC+TQAK4xPVd
N3VCw6OtwbhZxUDd3KNB/BCZfuGNuog5322aiP3BQcCfiuA+zXm3eOjMo7n38V8P
S5p02YwP2KanmBlBJA6J5FMJwMDTgGD30qU5nUbvoOpDeaj1tlFpQrrUUO0Vea7o
NRYkc81OQHjAA/pc8uZ9FV31tk6DAfI3z++hOC1lqQcz8YtRwd6ohUd2xnHt+VMn
9hS3FtXt9HYl8DGl2sv4y03WCt2Y4er0EW/qbEZEov5NFM9htPI4ObOeL5q2PRfy
+3LfhTwqtZjSaEt+BmIRDvlzBGZinqH0tHmoC1IrGHskljUiyHRd97A4L87IW0Iq
7mAMTfy3QMQdKLJTZAwP8Mmrv99zl4rrBk81Nu6v0izVZ1WsP+U=
=CuWB
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
