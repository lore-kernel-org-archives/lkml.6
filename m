Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971474AbeEXUv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:51:29 -0400
Received: from mail-ve1eur01on0070.outbound.protection.outlook.com ([104.47.1.70]:60352
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966499AbeEXUv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:51:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 24 May 2018 14:51:15 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180524205114.GA8656@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::28) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:JXW7+yrK/la/XxLy4bjdie6XpKqj2qrXNJOQqMp7G1RWTLWuBoPp7SHDsX+O6lUKrpHVxRQ81I34SftARLZJxhmL9AkXmYpkDU4vQ964bay5Szlm57wkVQb8UoERkTvI+GwTFlDEr6YX/QwquGvTYxHVCb4ieGbHna2ARXkgTcEh8C1qQ25joC5OVxOkO8x7XjT9/uqs09IYL5ba/vUqxkdQ/LDSdHfyVIVRNrTE2JKARiACN8qYa91E6OgThF5r;25:8HTTUCdAbub8XyUimpZpp5v1Da1a+TTyHPC13+5jT8Z1dGJJWJzNy140mabJa2TMaW98QbgmRD+JvQ9+xz/FDOfDGwUcTHEqVcZZMz+TVxkQobFKDejeL+wiFbG/G9KUA9T/pBV5jZgPLepNse+/RIiAm3H7W4YCR+mt2QhPtOnZ/ZIm3e3iRdpT9eyDuIWj027WtEcKAzZz1sLQXKKE0ZC02qdrzQWJnTFK60crhesh0DJXTJ2JBkJIKNfwanc3AcQ1ell3AJGRpAFiG4Qoa+nUr74jIzTtISnjshqNhCDL7M55RQpmLVx5oNa596iAbBozSk3QrCz6VCHUlKqIjA==;31:EiZGYddlSbKdxBEpA3BUx8+d2yxTSIHPwz0xQolGyzyxQUUl+Qm9C9SQBH5WdgyjEC6X07WFEEO8731PhmlThdt33qEXNIopLRKd8FU0ZC5wPj+OeCH+bfzrozYdit02SakeNqbTUYwpw4nHzHDLbGouiortxLLodj4OF554PFjH+bOyOeV/vxedetyS/m9uTUMunEDDbDjRoFySYBDi0fjtsrQtkhHWaPXXg1jhVew=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:XEz36j1EvjsKoXBaEmylUjRAM5NTe2LtUhWKcwxRe8VqVqg/W5FoCBL7K9XqQkqBMszixHUhr19E1XembhpSn5s1OWQYguyN+/nMZ0BvLP+gHkgG0dlCVpwzS+sPeMOBl131Ojg8keSTvYN1kLD+FzX3TcqR2/qwFie+QaQOE0xXyfhjyuchRBVGOJI5j7uWWM/i+qdmAtGG7BNB4M5rDpEXyOcpJ1s58NXLjkbtFea0mqkBsqWr7At85SQijkr9k8U7lwn4Mvi2F6w+IzFyEdft+3hKN+IXezO08vz8EmIrZ7b0izBjOpSbzto/KJFPwqhZceZAQQPHl/yMpbhsSPiNNZs5IJN49MBWNJ0bM4rRl0ucO8WtplsPcx8nsmLruktNgwgqpdJYNnknmK341dho7rY5lfWXfnRqPKZW55OYcpulGxdufC9ScCzUCsC9XKUyjqmNHvHF4yNkEm8v8dXDUi0gQMUhIFM6a53XmNN4VNtiytOlwZAPwY6hrZG+;4:kV8NBpCtpiIilk6vC8wDUv0NrHVmArMl/vT9EVGo6jvjUcq+Z26O5m7WwnNO7+PR4iCJ5GVBmBPXk1bw8jrDVOBnQNTbfJAndiMGUh6/ciM9vLWrZqCGUjoYjhcAI5fa2sVsfgvt978TDg3O9cWS+a261s6fk1Xvrk54Sq7Y4F5mIGHvJW5fkEVKOQAtp0Wtprq6IQtVqddTsTTtf96eOV/oleyM2QAbiTy0zUZo6o9rYl57qnT7q9CAIypEmbXTrKpMTyqXESU5a/MMAYlSjX8+tueyO9+VpK2IOMxIn4ADfosMIaTktZB9A6D5CgV3
X-Microsoft-Antispam-PRVS: <VI1PR05MB4461D3C4B731DB4DE03D7A7DCF6A0@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(377424004)(58126008)(316002)(59450400001)(6116002)(23726003)(1076002)(386003)(16586007)(3846002)(486006)(52116002)(69596002)(68736007)(478600001)(9746002)(9786002)(122856001)(9686003)(8936002)(50466002)(26005)(186003)(33896004)(110136005)(81166006)(53936002)(83796002)(2906002)(86362001)(5660300001)(81156014)(8676002)(57986006)(46656002)(105586002)(66066001)(106356001)(4326008)(47776003)(7736002)(36756003)(33656002)(476003)(97736004)(305945005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:E7yzT/wEJ/kf4twNAcancHywSo9/YTZpvHQj9XlH/?=
 =?us-ascii?Q?STb+5hXgAmy0bLxK1RQ1wP6HI0BPC+ZZEcaLdRt8gtyb3+Rtz7qBTBZrdVOE?=
 =?us-ascii?Q?HKgA/W/+Z9Nw7pXWakrErJ7tAh7JPsP3mY5kN5JXnbjYRC2N+Pg25jbRcdP2?=
 =?us-ascii?Q?jTmn+UQe0z4ATsnFxCU11VOHltIvmG+Fu/vlQ9sCcjPoo5NxHoVKMDlk6/1a?=
 =?us-ascii?Q?Puzzc5An/wdpcfafp64CWF8alIgBuohZ97JMOcagZ0R4shvmwNwpFY08LLOd?=
 =?us-ascii?Q?OM8i/M2Nq3l3fgWmq6+bYVASh+YmohqeW3ccKPZzw5kRGuFs1z7FEhstmS2b?=
 =?us-ascii?Q?u0oRgfu9Vf85IsmBVlIkTp8zEXIyRk8PXMbBule8wXwh8YG5X6tG0V2J4kz2?=
 =?us-ascii?Q?o5fTnARCmhZnTdBMf0AWvR3Avf/F4UvW9MGqYGbwANWBHPcPqI9ZsAo80quP?=
 =?us-ascii?Q?628+jyFrI4eWqqoQC4+b6aGjSgDm4si8BYfFhv/JfQZLfZ7pK3roDXb1iXEC?=
 =?us-ascii?Q?rbMOFt9l499q2pe3EdNZyrR5++3sJGmWZj1AVn9yJp9k+5O0Sm3hYj2308Di?=
 =?us-ascii?Q?XUyix7ZmpS6p9tFZPYnmoQcLCwwIqTFFKQESGrya4NoYCqBqq49HToAMQPnL?=
 =?us-ascii?Q?B53oFrBaKLsAfA8//YL7kvWNrUklyoDUfTh4CNX60D7aDfRQqRqvfjwqNORS?=
 =?us-ascii?Q?1Otfj/rFIg18SL7Rhre/DlrGltecFrcX6bL8byeMbb2qQHY+ZlvJZU+dNTJr?=
 =?us-ascii?Q?n1YkCmQU7AWJjgLTJi8bUXJgC9+TX4JHtfvsj4drKjdtmbV3Km2jaRRVfF9Q?=
 =?us-ascii?Q?zeJQfj6ipEKQMQxmYJCmnI8cQiqMLZ+YjMZr3LX/d28JbY7nYpb4HndLuZc5?=
 =?us-ascii?Q?NojwB1k5DEo1RpB/PZxomAdguF4eTqbmm2mbMWMMHC1FYOoyrzxYLAZn+LmX?=
 =?us-ascii?Q?pohtko6E3mySklGVnT2k8ZzoN6Q7j6/w6iOWIzfu3WEm5owikRsD7i/tS62y?=
 =?us-ascii?Q?pj4jVAG27VzNEnEUtd9l0EGKHnMYGFP8IMsZQczIzpESb+z2DsfpHUmTagcI?=
 =?us-ascii?Q?1oBtIoMgeNzsDUyPPh74Ulzg97PN+mWlcDIO25Wb6Uf6B/CP5UlrejO1qHkc?=
 =?us-ascii?Q?o22QKAqGWrGrdiUioDWIQ5g8s3txW+ZJx+HkRwNDOcTaxF9Z1dmB/coDJAnE?=
 =?us-ascii?Q?kIxv1WifcH3A+XfDIVfvjcn1BJXQCUweo2/TOfn5GPGvDaiHbl5NGUDY2ckM?=
 =?us-ascii?Q?a3EnXqLY+r0HUIWjna+XteGnSKPYwyTRrDq2NwIHVomN+t/68tVg19X93ihV?=
 =?us-ascii?Q?sHIlFit3MUZsCbxj/pnUkE=3D?=
X-Microsoft-Antispam-Message-Info: iSO5Tk9lrpDjp/PztPNXAsiOe/ZdRkvcEUEnP6t2Q7K28HlEvqIINtRzESNFWWJHvyY+8Gt/9WrH3DMhELm17xkM/z5n9hajVi6m3q7RC+QwapHfzrzcTcTMCZCXLVVlv4EB98bynpTX59ELTuEKXF6isNbfd4O6jAjsa7EogQaA5WonwWO/2dCUomgWk/y/
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:Ebc109dEPfreV49iu8AmJVZjnQuESFQod6MTrEnR+hFhScWbJACWp3lWaKB6BwqL0GDEvj7B2BZ0UMsR2L56AoTXBfa2YsvR0djTL76ysRRd3WBp0G/z5AETZT7SHaWRwXn680D8X76VAqTw3ADmPMfRVpw1Xs7h3LI0i7K4gsKadsifAi+OzqSEl9NKYwyIE9rlhjuOo0SNIHsql7koz+NV3kWXi9MdbHOrqcYuRSK3taUyAWgEuZGu0cVI01hjmOfFG0/UKO1QjN4S+Np7eR2grHO5I/PI2D9M6PjoMxWAw3Sigpl7ptT7XkQ+ou1WFRIZsF/kA6Nsq5Lqcta5pzw9V8W25Gnu08CG4cTUdpmeYGLyz3/j1cPlwe1EfaevKEwGDdRWOp0Aykkqleqar+KT5+lrrPYfgX+Nfk6cCuGW1/3ab8tf5yDTr6f9NUcS5WmdPGaXyI9rfxqvjBSC6w==;5:Hc0s8KXoBF+E4wGoUUlqNo5nCArBbPVIe+QtFMd/O/6qd81eBTF0I9Rk7rGRtodIJy1nMEG2wfR+e9UlTq7T/7+w+GT7AH4G1VvEksif713egkaa06GbjkGLD3+GS0ksIyncclMKSL8ashAQEtbp5ITwbfhhP4Hf5UHS9BT4O7Y=;24:St6E9CRrB7eP1B5EafnM5bcE4/Nx6XYWYPzAuEm8MlNxrgjXXBz++lgYNAFesUVdqp5F1KEkqu1j4/HoWh3x/zxAFa0g1cQIXioLpjCtFTE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:/ZUjrDgD050ThhVB9e6VWRym6sXb57uSO3bgTbyCKjReMAMBfhYP60SgXvSxy37vFMHTAL5PiZixn3sqOEtXe56DjzHvQh1D8L4ndpoMOX/sJ8wh+spoITosY6Ro40R4d7p10tqvddu56luRmm5w+YVllLjpf6w+Qn6JXU1W2pcRNoBBSPop4u9hhrLaUzSHvP/29Lez0KzPZjfBK9Fn7ElSpoeosvGGNqdwsjfdYGHG1PMdicT3W0nGGukhaSPx
X-MS-Office365-Filtering-Correlation-Id: 8f9973c4-00e0-47b4-b2d7-08d5c1b81b85
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 20:51:22.0808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9973c4-00e0-47b4-b2d7-08d5c1b81b85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Second pull request for -rc

We haven't had quite the same rate of -rc patches this cycle, not much Syzkaller
related stuff right now as the remaining bugs it has found require some kind of
significant redesign to solve. The -next branch is also somewhat quieter than
normal.

This is pretty much just the usual array of smallish driver bugs.

There is a patch that cleans up the kconfig around INFINIBAND_ADDR_TRANS that
touches a few files, this is related the the patch introducing
INFINIBAND_ADDR_TRANS that was accepted earlier this cycle
  f7cb7b85be55 ("IB: make INFINIBAND_ADDR_TRANS configurable")

The following changes since commit 9aa169213d1166d30ae357a44abbeae93459339d:

  RDMA/cma: Do not query GID during QP state transition to RTR (2018-05-03 15:45:18 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 55ba49cbcef37053d973f9a45bc58818c333fe13:

  RDMA/hns: Move the location for initializing tmp_len (2018-05-23 15:45:44 -0600)

----------------------------------------------------------------
Merge candidates for 4.17-rc

- Remove bouncing addresses from the MAINTAINERS file
- Kernel oops and bad error handling fixes for hfi, i40iw, cxgb4, and hns drivers
- Various small LOC behavioral/operational bugs in mlx5, hns, qedr and i40iw drivers
- Two fixes for patches already sent during the merge window
- A long standing bug related to not decreasing the pinned pages count in the right
  MM was found and fixed

----------------------------------------------------------------
Alexandru Moise (1):
      nvmet,rxe: defer ip datagram sending to tasklet

Andrew Boyer (3):
      RDMA/i40iw: Avoid panic when objects are being created and destroyed
      RDMA/i40iw: Avoid reference leaks when processing the AEQ
      RDMA/i40iw: Avoid panic when reading back the IRQ affinity hint

Christophe Jaillet (1):
      iw_cxgb4: Fix an error handling path in 'c4iw_get_dma_mr()'

Daria Velikovsky (1):
      RDMA/mlx5: Use proper spec flow label type

Greg Thelen (1):
      IB: remove redundant INFINIBAND kconfig dependencies

Jason Gunthorpe (1):
      IB/uverbs: Fix uverbs_attr_get_obj

Kalderon, Michal (1):
      RDMA/qedr: Fix doorbell bar mapping for dpi > 1

Leon Romanovsky (1):
      MAINTAINERS: Remove bouncing @mellanox.com addresses

Lidong Chen (1):
      IB/umem: Use the correct mm during ib_umem_release

Michael J. Ruhl (1):
      IB/hfi1: Use after free race condition in send context error path

Mustafa Ismail (2):
      i40iw: Fix memory leak in error path of create QP
      i40iw: Use correct address in dst_neigh_lookup for IPv6

Yishai Hadas (1):
      RDMA/mlx5: Don't assume that medium blueFlame register exists

oulijun (13):
      RDMA/hns: Add rq inline flags judgement
      RDMA/hns: Bugfix for rq record db for kernel
      RDMA/hns: Load the RoCE dirver automatically
      RDMA/hns: Update convert function of endian format
      RDMA/hns: Add return operation when configured global param fail
      RDMA/hns: Not support qp transition from reset to reset for hip06
      RDMA/hns: Fix the bug with rq sge
      RDMA/hns: Set desc_dma_addr for zero when free cmq desc
      RDMA/hns: Enable inner_pa_vld filed of mpt
      RDMA/hns: Set NULL for __internal_mr
      RDMA/hns: Fix the bug with NULL pointer
      RDMA/hns: Bugfix for cq record db for kernel
      RDMA/hns: Move the location for initializing tmp_len

 MAINTAINERS                                |  6 ---
 drivers/infiniband/core/umem.c             |  7 +---
 drivers/infiniband/hw/cxgb4/mem.c          |  4 +-
 drivers/infiniband/hw/hfi1/chip.c          |  4 ++
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 32 +++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 10 ++++-
 drivers/infiniband/hw/i40iw/i40iw.h        |  1 +
 drivers/infiniband/hw/i40iw/i40iw_cm.c     |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_hw.c     |  4 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c   |  7 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  | 13 +++++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.h  |  1 +
 drivers/infiniband/hw/mlx5/main.c          |  2 +-
 drivers/infiniband/hw/mlx5/qp.c            | 18 +++++----
 drivers/infiniband/hw/qedr/verbs.c         | 60 +++++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_verbs.c      | 10 +----
 drivers/infiniband/ulp/srpt/Kconfig        |  2 +-
 drivers/nvme/host/Kconfig                  |  2 +-
 drivers/nvme/target/Kconfig                |  2 +-
 drivers/staging/lustre/lnet/Kconfig        |  2 +-
 fs/cifs/Kconfig                            |  2 +-
 include/rdma/ib_umem.h                     |  1 -
 include/rdma/uverbs_ioctl.h                | 10 ++---
 net/9p/Kconfig                             |  2 +-
 net/rds/Kconfig                            |  2 +-
 net/sunrpc/Kconfig                         |  2 +-
 29 files changed, 116 insertions(+), 98 deletions(-)
