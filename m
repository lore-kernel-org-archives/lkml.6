Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C1BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BCB20854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hJeqTxSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BCB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbeGMR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:29:16 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:37792
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729736AbeGMR3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSyzznIK/Y9kwyPRs8b7Fe3ohlggyEVmBw/YI4qoNP8=;
 b=hJeqTxSPcAYjtPzClrEXvIWAXjWGknmi9BMeL8d5XdFhOq5IxSsgcYvL3FE6+43y+c0KK/z1W8lxtNGO15xOMrGLD1RvHOrbT3NezWa9B9c43LXhw4ncex9lrnvJzB8K0mFWTFM7EdYB8v3DxuO7LGpGxJhgYmXU6ZcNUMC2SIA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 13 Jul 2018 17:13:41 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fe1dL-0007Ez-7i; Fri, 13 Jul 2018 11:13:31 -0600
Date:   Fri, 13 Jul 2018 11:13:31 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180713171331.GA27807@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eee37f43-d47b-43a2-85d4-08d5e8e3fb7c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:JrSHa4IPbmWxATi4JXRKC3RDBLSTuKXg2LwrJD51kJaHpHjkAD0LH1Ihw81H713lghhMcG8bNGJmkcwmTDRJDBipMQuf1eoIcMaukkUfuVya5hIEPb96gHXt4AdUKgdQdqOp3lYHbj3OgFhCpo5drFKi2vHKfPq++QH2AsI3no4yu0q7Pyop4H8XJYYoX5oFijJf2tO6IoQIs8EFHbe9ENStCq0Sk2VCEFPRyK0fGLJQfm1HUoGdFYhb5iOcdQME;25:gjo5pPdG2vaB6k3oICkEh+8LcXiJcYYldhTSNHzHFuJMNJ5wJTjXP+XXrxcMKyMJCLqDPXkXsIApSPKXWHxJCWXAuYVViwSzw1iWRVgI0yzjVYCeHCSWUUoZnz6KDT7ZzpfgGVSPy9qg5XzVGp5JLS9pFe0pNnkHHhL2Ul9stRPvcykpNJ1aXADfT18YrzDIiTCIfh9prOSCHr9qMIB3wu2Tmqs8nNoQtS1aNGU9HaDqljyUzkna/u7c/xNDmqglZnU3tvb4z13Ijw1EB48MsC3CpaIsooKZKngnzdxABDNaejLkro6CUTmPJ0lRvnp0Jq65R9FKXPRxIdRLYgyp5g==;31:EHpXkkh8ps+gfQgbCBA1T6bV3fLP1M8TG0D7Uqwk8MJAiNystWzh14oVNmr+RbnYxOgFmkwt/GGBmRbLqprYqLGDqPbroVRMVi53OUspt3T9T8aMGOGkf5405jDZyrjfERyHTBUmhnMQZ1JOqbMzL72r1LDLimiMyASSs9P2qwio06qe2wQqHYpWIHl3IXhnU0pRjYXCqaATGOGfn058wI1GqiWP6Of80jciXfOT5eI=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:dCKOrSdMVUIdagpbJ8VPbyYqI2BN+covB06AqhefsLRAjRy1tdsEdVB77BkalY03Secv4tCDnx2djet5q9FqGNspFxu4hvQRAhR+hm7waSSk+97l+4RGhjYUXwlczkjd5pla/fTfZcIVTrN037S0ALHSxM5m2z3JFCQKOkMHSQ/k6qEHy3b2NXbMVdnXKjXkZbBBn2FtOglFyuhHlb/QSRBZ6qshbuRgasHNutvsUxOvaMc9vGJmSW7rjXogpBtLeUu6G6jUPP3v/DliklMrGPRtIvhiXuWZhunwzUjAE66/Ty9R34ZuGDqNwSmGgTMvkI88H9+/F7u99UE+XT1rQr2oEXG9INZP/BU/PMia/unI9nX52vplKBoYSAj0VlqvUg2tmtzPPJlb8yrPikoRejnIfk1OIsZAj9Eed21hM8EFVOP+y8kiarqPAaKFR2DrYCZNvYzcV26znLu0i0Oz7yyExs3eJtLJ93AmtqxWJbowk2KjfKstlXm1t6svOqvT;4:rc5P33QcSDy5fNcgVzjTeZZ8c2NnghxS8gdMH2RSA95n4PymiAMdvG8QmCtDI5ECsV+thxaquRUKGt16QYQNC9CvrdHo7W6QFUCY8YoJmqLHuJUS0ewXEc1xZcrpw3XQDj9cvV7PveH3dThMSt2fO30whJfBZgbh66gjw3NUB9ogZrm8l1VYOEnu4SpQZf2+eoamma0P4V/JvRr8i0odZ/ZhQjH7xWhOsA4rgwWlALOsDshUAVpFUJhz4xm9W01QuufONQfeTeFPnpG0nDGfCF8SHqphC2SX+6X+3tyNyduxRGRo1wtepDI+jA6ufScr
X-Microsoft-Antispam-PRVS: <AM0PR05MB445090B4683965B67E850C01CF580@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(575784001)(4326008)(6116002)(3846002)(1076002)(478600001)(53936002)(122856001)(33656002)(57986006)(105586002)(106356001)(83796002)(46656002)(97736004)(2906002)(110136005)(8936002)(186003)(66066001)(316002)(86362001)(81156014)(26005)(16586007)(81166006)(9786002)(58126008)(8676002)(7736002)(305945005)(21480400003)(84326002)(5660300001)(14444005)(36756003)(9746002)(68736007)(44144004)(33896004)(386003)(486006)(69596002)(476003)(52116002)(63394003)(9686003)(18370500001)(24400500001)(2700100001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:W13kiQqkQlt1Aah0RK8lr279sXw2YLcnFEMKihVBU?=
 =?us-ascii?Q?CcBRMwPf6xkw+HnWAFYFmtPnV6kLleFnrPKmzolGumxujIvD7qDzbPZE4n/J?=
 =?us-ascii?Q?1ZqdzIxsP7Z3cwEWyLUaq0HJkeRkrnjc0GCS8vt4Qt4tLoV9Dv4n6T7RcQtc?=
 =?us-ascii?Q?6uDLP8+SULbQnQTLst8TJeSqE7zMftpDRg8krYhiN71sBpZW7kUzeidVZwQQ?=
 =?us-ascii?Q?nouxa9ILIfCHaPoFsPiCT/lI7RZ/tVtzxH4Y0DaLLqTfvgPMp/oEsYMwYiFg?=
 =?us-ascii?Q?uiCusQoL0Dx2/HDeU52K9Qy7RZfwnnVOoDPe/kQuJZMcjQiiTIswOBqXjoZY?=
 =?us-ascii?Q?AUzzRjq155JIj0PJu7EV0i6uvbiDYTfIKaykeavpygBK7kY5aFo6WTl84hZr?=
 =?us-ascii?Q?AcdzhbAnG7fUPxGDQRvXiqiJr1Zu1irmSPJe4WNQ1s+99Dof3fRSKdTTqooK?=
 =?us-ascii?Q?Y+iacPxS392MGQ/LErougghNkCYgXRzXvBmRW0xP9yn8eU0f3NusN8lp+rCS?=
 =?us-ascii?Q?V5sOjs6HKwP8zKrdFwt27/sG55T9qXG9+GbzEaPoayVwOC2teHa021ugamCx?=
 =?us-ascii?Q?xc7Aiw4YkQF3A3XGMB0I6Z367R2liy6xZkenxIkDOj3L+hlce/FJj1nmNyGg?=
 =?us-ascii?Q?DkGBPgrNUwdzn3xwCt3q89ujiXIW7rna8h/nE7D2XiTnG8hc9wumQPmo7fCG?=
 =?us-ascii?Q?gNo3vDbzB09qCErADUk6k6ITFfElKQfybwl9pPSDsmAEG/XHGSXIzPfv+zJ1?=
 =?us-ascii?Q?i6xRL97IiB3O9y3Sx7rivyv53bMhq3GflyhttABZKGypZDv9Abc303seIAWb?=
 =?us-ascii?Q?2m09YZEX0rn3hccUkuQ3ZiZ+uVOiAX6ZQbWa4sgdqzd5AF0KjXI1Eh97zIoF?=
 =?us-ascii?Q?OW4MteEUS5i5AOJX/Q4D3MAYrjdnR3NHIE/axlAdNY0VFpG57pwegXB80AQa?=
 =?us-ascii?Q?TddpZjiHaPoqBTbibHWAz2Nc8/INjklIQETKMIrmKCgvO/aeTB8UIuoL39LN?=
 =?us-ascii?Q?tRElrkXR04hsB4usSBUiz2y90lbxvdWxBDvKDZ9Ipz+iF26GfBc5/27pjO6t?=
 =?us-ascii?Q?J3fpchMjOkR+FCUybqQoHKyJIUK1KuX02G+jYsiMQrLmNlGPWMTk9u6SrhrR?=
 =?us-ascii?Q?eQOb9b4TbbMgew34DsNxF8/tD3uwrTvk8mj9DDt/NwK+sBcSLGw7yNEsrno8?=
 =?us-ascii?Q?jHTQIaAJPMFreV4kUP4650N9o7Iy1jJ6fdVeTCyQyAw/fO87wY1jDBPpocYB?=
 =?us-ascii?Q?IHhwN3vmydEfm66GsQgWnML/ruidDXxzBMpLpsJV8LQbGAL8ESPrQRvUSxzu?=
 =?us-ascii?Q?AO0Ef+UbHogAdeooKkgP0rimbgJa1zbbjhKqjdoQBT76x4VPcORc8GXaEgBQ?=
 =?us-ascii?Q?HZE6Dp0TDY/OeOsCn66XITunPgdkUDJjQ6EPPq6HBEzpbDUM+ITLWG0nfBln?=
 =?us-ascii?Q?bNoXhLlF5qUV34z0CYj8bgR6fuMtnY=3D?=
X-Microsoft-Antispam-Message-Info: JExi8QRt86GWQBPjNatM4hvTuKoMRcMY3KdNnTxi80jcMYK6flMbRKVRNHvCx9CzM+vTEzNjeELEBngI5Rc2PpX9kFwhQzsy7kH27nvLGDvX0bSQnJqY3KHNwq2GcY/dFPXwzAGVPR73dobq9ZlrOmMLc5Wgenmx0ptJ+69YqNxwGk9GXod9MiIeiKSawia0SPZAJH1PMRbvFoP+PtAs9hCzpk/RVmy8kHZREq1gtSfRY++xZlqSbMFfnKfz+Vk0dZmb3kldTxj+OpC37v3JekEshn3E6bYKSrbZkmgmWFzr0Y1lsqXEgSEq2rokkZ8/9RLyCW1Y9OraM+0QLhQv44SBIhjpySfj3TAFhfhVZmg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:24Oh93Ir95bA7ojtPrXgyWeyEJBl/W/UAvAJq5eTlrqwYr4f0uBurW150T1d//9E0k1EpamCfsQ09v5BqfcKCTK/hrC0d5tWoE04LRICxhEyXHgE4DRA5soCslP77lguLW+WXSqYwIxtaYZV2gr/HiskA04LyPim0wCNtCKiNzD+RlY6dvIbCl9vMQ5ASpz4obKikHI4/3NIm8iRX3JM/aySo7bQd7M3Lvs80xcjwMHKxJX5IY3ql5l6CSNPx/zBZvaRgw5hyHTCA+t91JXYhNZRARdnSQoSZgx+VKEuUYry4ecUpM67ZNQcK3ZbipSoUTIC7OyZkufrcLSy6zdm+8CEq4ppMpKSIO9RPah5INecVBRldepu4ukgQRXQ/W0zoQDGGPBxkIm2ZP22CfQ4IwSmRPEXoe7fFpzoJ093i6MseMU0C2ZIVXXCQO/Z1hMJE2Ze3iblXATMg14AhJbHSA==;5:T0lsPiI5LZeaBBRIBt4htHxNlp7bw3eJX2xyRLZI5QGWi9lNJzG0A4lXL3hJw5ZRswBw6XuT+PXZLhscPRuO4iY4MvQZP8jivXEb+yNX5gVZ7Gu0sKea7ftn3DzMK31oPCYlABCl9TtLHbXBl1wZq30e84CZqvLQJol0a7vrleU=;24:Y27n3lGAGys/X4WqDC/QhXkDLF3ZN+QI6HrDilxBEBRqhgQ5lUaCuqvHLYLcyPR49wmqMa4LUUH98yJYQDP2UtMWX7Abmuv9vg3OYdtQf3A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;7:i7dGEnPLr04c7FGIXDv2tozXeLhZrUYiVoaLLFEbSnXAmKpPvnxAHwru+nJ3/5kVCDJ7UImDUY5slhLB8WYHmASrn+YgvdB5affychmYnt+rEOVGCWzgmzcW5yIK27Yfp000VzPiYig4CDVonzYWxH9rap1XAAAXrUIiGrkdRKencR0osnHl/ETB3i8yLTSjMnwEuOQLJZ6V94AfjXk7NyvLA8vdTMi1IkIvvkUBdhQkzKBL+UXDgWapIjWaLlXR
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 17:13:41.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee37f43-d47b-43a2-85d4-08d5e8e3fb7c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second pull request for -rc

Things have been quite slow, only 6 RC patches have been sent to the
list. Lots of stuff in for-next already though.

The following changes since commit 6f0d349d922ba44e4348a17a78ea51b7135965b1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-06-25 15:58:17 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d63c46734c545ad0488761059004a65c46efdde3:

  RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path (2018-07-11 14:16:13 -0600)

----------------------------------------------------------------
Regression, user visible bugs, and crashing fixes:

- cxgb4 could wrongly fail MR creation due to a typo

- Various crashes if the wrong QP type is mixed in with APIs that expect
  other types

- Syzkaller oops

- Using ERR_PTR and NULL together cases HFI1 to crash in some cases

- mlx5 memory leak in error unwind

----------------------------------------------------------------
Kamal Heib (1):
      RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path

Leon Romanovsky (3):
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP
      RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create_flow
      RDMA/uverbs: Don't fail in creation of multiple flows

Michael J. Ruhl (1):
      IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Steve Wise (1):
      iw_cxgb4: correctly enforce the max reg_mr depth

 drivers/infiniband/core/uverbs_cmd.c     | 28 +++++++++++++++++-----------
 drivers/infiniband/hw/cxgb4/mem.c        |  2 +-
 drivers/infiniband/hw/hfi1/rc.c          |  2 +-
 drivers/infiniband/hw/hfi1/uc.c          |  4 ++--
 drivers/infiniband/hw/hfi1/ud.c          |  4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.c |  4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.h |  4 ++--
 drivers/infiniband/hw/mlx5/srq.c         | 18 ++++++++++++------
 8 files changed, 39 insertions(+), 27 deletions(-)

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJbSN24AAoJEDht9xV+IJsa31gP/26hmxUoeTswL/2tYQ5bA/HN
PjH3WGG90qPOI2aDxl/eWYuju5xmeE2aCc2s/tJ4PXIcCJwKx6OdJ/fneXMHsuun
oYT1z5DCk3zlXdsHMQz6XqOoSMVyEdKz3y0WMQn7DJtOIq/6XXRRAvTDIIDpOs4B
IQGY7VZSn+qjnV8pyQs8L6kDoUU1Sppa9pQlx/zY+HFwXLDom8btgzkBaKF9j8SL
IZZXi26P+Fku9acDeTRTl66fAYYxieSBdfYUwiJHJmdp3KgMcdqoKamQbhUkrh7V
hsND5rLh/slQvIm4RCP2uNhT9d7KVAA5VzylurLlfl4+VZisuzmaX0tjkdX9JbGh
2LL86nBvql6+Kbqs+6jYu+BoDFGR2HrDELWr/PlHqBu7Qe0HJgQGUkwRVSXPzblI
fEa6OeQGBLDJxsNonvkCk9Q5JtiucNgub1J8iaLq/w/SrK6JZ3UuxiNgOnT8ksck
fQatESKpSNsBdWRRP8p26HH/4OgyT8KYCYXlwqSl9S0rJFcci+Ov8zupx/DIGAd+
6wuA7qeqmHY7ix29Y+Bn+kZ/RB6kBD4fhlbj6VKjwxZbN1OWmhNScbshhR40z/Dh
/3+DrZ+BHYBf2ZrI9ZG9b3bAV2H3J5yXmk7h//1Y2sLt6405GjQnKu0xbzXAv/zI
9XQcHnM7bwFyvEdRHvdl
=bcbr
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
