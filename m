Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeC2TRn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:17:43 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:20288
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752135AbeC2TRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:17:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 29 Mar 2018 13:17:29 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180329191729.GA24187@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: HE1PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:7:67::25) To AM0PR05MB4451.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a485323b-3809-4fe3-5180-08d595a9bbd3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4451;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;3:+85ymNzTFmbbH/jgDcuJMmIVeRZooWWbhoVHXs1Hx/Xh4OJi+h433bj5e/b4IR+y7vh4LvTKVT3nTz6OW0Iw1d/X34wZXDH9JVJbiGmAMOPztDS/i3Z1+XVZiN331UD7ELaChaZpm/+x1HjKzsUJsR6lWSh3yhQdV5g6pt8FKomYh7rpcp2o01fveCkHcynrBj7hXXO3/lh9tQxydrihQsX8kFLT+CCfXjU2eo4rdjyfEJwARjLTUDuxgKTb2sHh;25:s9JcB1DdcdN9QP6HNMc87NwUB9NEySvN8ijwcN0CKi+2g45aQchstYI7wp/KEAhSJxJXLMot4Muhi+UCF+ffNLzWJ8oTidEXQdQllaLgJnkZ6Gn6Edmk6O5BT+iVeJM0hVxQuvbfa/TBOb7ofkSh2JBGEG+HBQt3Zo0oQ1ReqkkmqherS8F/0Is3kuHPk6cFu3v+GYPuyvUilMmNwYiVJR0urhHrTFKTVgApY4fBRWxEqdwofoGblT0TdLJVrOS1Hoc/A9yfdbXbAtd/p3LPFqctjAZz2TybX5EMEARRBd7U4Q7FkZp4Pgc/Y9s8O8V/ML49LCOYbqGWl6F1MAj19g==;31:Vw/aI5cz52pCgxcPFk0Zg2dk73xu1Fl33Lx7vwf6EHmn1DctptjPLYHyrYuETm1edOhO4bhjVbPneKAZ0P24TxyQhyEdOGsgvpdMuJKAR5AsiSTy4g2nz+Mf0JVwm5t+vxKLxOF9yy68A14CVrNxhaCdpAwJYEedOsm2RcKCdd31Sx3fK3mtLJgq169tN1jrejWE/4paKhoBTdziJbnOX2Aet29ZPXkffzupMhsQnn4=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4451:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;20:vQbG5LZwFbw5yNWt3kUxevIun65EtIgsQ7rK7X7GAo5N/M9QFWHESN/6+Ekg5qBiM+bWoSSVzU7Za8lvEhISzWFwuvZQI47r0toYsq466XsQfcPYDRTW7jsw54Fse/Z3LyhUYCypukOeJBkPOJoyqEC9SQB3jw5k3K6fCk37vYPXz3+mvH50jts5vZqbOLlLbTVtYp2MmDadQqyzt/OBvFMHBjs3P95aU4toOnIiLUFkUp5OGb4I6z3/lPXiCVQXoYfvPukQ/KNe7nE+zfjUjEdkq+NExRWmIGBvZhMT+rXQau4X3X0Qucf+HxkCgQufJrS/LBqu+zlEJE5/606jggBlIoaB3aNDbdcVNW7p0IFkdxcpgY62b13i08KQdQOCvXAyeQ4J+y0LiyhvKjsn8CQvt6Z0YyCQE56XsVieXjnWQqRbUMbe7xTwRQP7ldjQZ9dxCBEvo6j6NHvgGkEoxakIAycmzhxzFQkAQV4ULNq/BM42WRJ3pqXh2kihQJKx;4:gT3eDVcyi7PpVHi0aqEl2UgzI4GZzJfoMqPGxFsUAMUikoEyuNoYsVD04ewADy5zy9MInaVGUmP3NKqqKEHcaV7CagHzi52mJl9yKrzulxr9CxmIPQKTXudo2njyZWpl2+LsGY51ggbNjetfU67dh/qfzElAfER93HtCF8GXKxTwYywELMKunRQdsIZR8OpoMgTMgxte9y00RlUpa6dtp6WmDmNzdhvHMu5D8ljAODuXHMsYSvXEZD3h6bXpT2vC6HTz1cngOr8x2p+hhJed1ZU6CfY/kw/mdYp1KfcI/uqyou2bBK7cOEMvVISeMnMJ
X-Microsoft-Antispam-PRVS: <AM0PR05MB4451892008A713D2A407FCADCFA20@AM0PR05MB4451.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM0PR05MB4451;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4451;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(377424004)(199004)(189003)(86362001)(26005)(2906002)(46656002)(106356001)(66066001)(110136005)(23726003)(4326008)(9686003)(68736007)(47776003)(122856001)(33656002)(186003)(53936002)(3846002)(1076002)(6116002)(58126008)(105586002)(81156014)(8936002)(81166006)(386003)(8676002)(36756003)(9746002)(7736002)(69596002)(9786002)(57986006)(50466002)(97736004)(33896004)(52116002)(83796002)(305945005)(16586007)(316002)(5660300001)(476003)(59450400001)(486005)(478600001)(486005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4451;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4451;23:krBA3+rqhZscSCaQcvrZREfxF4Q+P95ek8YlKMzgS?=
 =?us-ascii?Q?E4eUMLAIcWx03P6wHEXcTPKvxIQy6g4Y0nk4zld/Fd/emY2gPVxcbF7JOxDO?=
 =?us-ascii?Q?ZmJq3dKQy48bKAooFJFYvaURGNbpumOiY32HI1fiGiHU4FejXDBR5Pvlxj7C?=
 =?us-ascii?Q?uNLB9d7XQtAwNjL91gED6G2bmFGrj58ngIw/DCitXbV8OT6tnNUdlPvXP/zJ?=
 =?us-ascii?Q?32jC9DYThlCzzvG0HEyKxYjzGlZQ5spsdAbktXcQED3u+dbEu8Aa0aQLIWW9?=
 =?us-ascii?Q?CFqT0MUv6saG4Rz8w+PXAKOnxNJ8DLJkich91KuAprk7jaBwJm73Q/9BQuP7?=
 =?us-ascii?Q?hTzJZ1cl2o4zS7Pg4PNm+aWBbz4PlCeyYApQOX2xPg0BAIS5FUQB7p5BTeFj?=
 =?us-ascii?Q?pz6oSN8dRAsqT7h3+M/DnBNW+RZaExhzXofk1DrC1yr6hw8anIrdM3xcjluh?=
 =?us-ascii?Q?LqHihqTYEl/olzF6PNAuObihTzdMfL9RxSJb5Vsg5a85VWXFUWCzf1BhN/T3?=
 =?us-ascii?Q?TbBo64s79scuVY4SEpdLYlaCl72Jw+n65k4rjZnsAzT8CcSh3f0wWd3ozKWu?=
 =?us-ascii?Q?AbhVDCq/E+mrcDBwtIE9Uxg7UbfnA13dT1dcnXfQ6g6ulddakO7qp6Zzj1Zx?=
 =?us-ascii?Q?9MKiPWswsEEySIG+c3FaMUh98VbxI3F3IBwVNkd7S8hDW/imcnk1vWnFpW+Y?=
 =?us-ascii?Q?UgfcJz9SopvsdwFDb0Npdp82esbEdUzKebizfehFxcD2R7F+0yLlP9gRiE53?=
 =?us-ascii?Q?dHeNjotaMNPPg6ws8Cf1hgU+bFkZyhxlJOFCVU5MVl8DAeBHqQRNKI1xYfL9?=
 =?us-ascii?Q?rT2eKvWBAl/D1eNBtirWID7TW96KxKsfy1f4zz8dSzvsjfCkNFgxXK0s/ekX?=
 =?us-ascii?Q?Mc8zaxhaQkfueNl01/EOZQzis3GnFOl7cQchTvfNan/d63h3I/20nbLzZkOM?=
 =?us-ascii?Q?mqwzreP/Y8bBmfLweyGs8tq45zDEiy7WjUCSZnPX9k2HX/f98ot44NPuo0r2?=
 =?us-ascii?Q?Dpy9z1I/FaJhrHPe//gDJkB7jh3ahBFd8Fl5QS853bK5xsl2MFW6PSqhgYF6?=
 =?us-ascii?Q?qgK6GqyxjoyNIYtezstWbw8COzQlnq0STZbPOxM9q07UD7cuQhAiZZN9o/6k?=
 =?us-ascii?Q?BNe/2wDJ1/q+3RJGWLpub7wNU+tFwMK3NhkB2DmSfVSv/AJfZ6enEPNCycpq?=
 =?us-ascii?Q?M+yZJUNfzBwQzqOlb3wcE6puV39f3JmN8V/9gsef5dVor3kil1LFoofX94fv?=
 =?us-ascii?Q?3hCYVQpfPkIoos2YpxocUvG9X2LpM6cWS/z3fq3W9ETReOyPr8rpZoXwJZyr?=
 =?us-ascii?Q?P852Mon/ff/PLkUjTQd1QQ=3D?=
X-Microsoft-Antispam-Message-Info: jB0Fa24pXtHsPjzy2lEcW8LCKarI3yWTnrzmI7mGhXOvC7Ht9p9WGKM3Rpf3UGws3bDku4D0+PR7T+TXjApeEvL1NEf19RLNZ3keHCpSaOJmlu4Xf6marVvWD1ca/a1U2arbuJ7HiEnzH4KNaFeYekbjzAfQXOt1AQGCGNDEErSE/w0BCtTouurah2w10C27
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;6:WrDVxA7QvTV1aFC0iFiHAqOyj6UG+qodwhqMnxQd74oh/TwjZtJakCLfzEM8RA1+qDp21pqt/dWg0oET/S7OCpQntQ9hC7x88C2NUxqOMjq2VquUsU7MGDuG2mYjlZAcR880e0zl+JvYL3or7Ax1B8uFOWCLoctTfVtnxNMEMgs9H3hhvpTbdWwfVLbqtLnEYsrQyfuewB3ZXQpof9N27ogh9N8E89XU40yScjt1kEFbhtcqWSS1ofGXq9zQumSPDHZ44eXGkuRkDijOtDiDRCUeEpZSa25d8taBn4zf46ifMx7YSZ9hjsP5EedI9KOsoKU0BVnYV5c9AH508J1wBRWDyK4kWzua0Rz9F0hUjL94Go1syXSt+H+UzoKB9YFJ1oL9RL/951CROOajKl3Tmufa8XvKpnaQG+kZ5QBhH6BY6wet4tKWnjR8jUQBYonh6QTi+2ZmlXPReMzecayyiQ==;5:8NosKgEu9yb5ryrzgJJfya6D8ciJ3r+FdFbCMJIn0Af3ll6IF56vVoagCDwZyaiTaB0aZZC9NzkJZN7FqFENlL1UiOsu7BCPHe7uZkWXhJBy004aJeF5AJ32EfbCQZZvEG0IcCCkLPSCjkm/9fAEuybAVVO6ud3Ts5xALq96u68=;24:oQTI7Zhpx5GWb1xTn34tqpwxJdgcxvNv36UeUoih2Dp4cB00HY3TyDWlwku0aBsPPhEm5CwNXI5rFVSxOsTfftL+tiMBW1wdtbXRysZoZ38=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;7:pWs+1ZE94xKu7xceUcbIrAkmxQ/7MB4O6iAwLsz2XsqD4Nf0dbwV07qupsZ/cdOeY4jjfFen3DZ3cLju/GrByxn9XEklOyzf3/Eh9E6tb/qY1pAk8SAhSrYHHOMdrOLUMk1xmmqGKXoGnwyn5F6BWKUsV6y1MhHTYeT1RnSVgH19dVY0ilxQmORHbGvBaJcjOdClVG/mc0X5uYUoYf9Lkzdq6skx3aDUrTkcHRfBwSYlk5XOHi/lfH56wKy2LUCp
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 19:17:37.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a485323b-3809-4fe3-5180-08d595a9bbd3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4451
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Fifth pull request for -rc.

It has been fairly silent lately on our -rc front. Big queue of patches on the
mailing list going to for-next though.

The following changes since commit e8980d67d6017c8eee8f9c35f782c4bd68e004c9:

  RDMA/ucma: Ensure that CM_ID exists prior to access it (2018-03-20 11:07:21 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 84652aefb347297aa08e91e283adf7b18f77c2d5:

  RDMA/ucma: Introduce safer rdma_addr_size() variants (2018-03-28 16:13:36 -0600)

----------------------------------------------------------------
Fifth pull request for 4.16-rc

Bug fixes:
- qedr driver bugfixes causing application hangs, wrong uapi errnos, and a
  race condition
- 3 syzkaller found bugfixes in the ucma uapi

Regression fixes for things introduced in 4.16:
- Crash on error introduced in mlx5 UMR flow
- Crash on module unload/etc introduced by bad interaction of restrack
  and mlx5 patches this cycle
- Typo in a two line syzkaller bugfix causing a bad regression
- Coverity report of nonsense code in hns driver

----------------------------------------------------------------
Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen

Colin Ian King (1):
      RDMA/hns: ensure for-loop actually iterates and free's buffers

Jason Gunthorpe (1):
      RDMA/rdma_cm: Fix use after free race with process_one_req

Kalderon, Michal (3):
      RDMA/qedr: fix QP's ack timeout configuration
      RDMA/qedr: Fix rc initialization on CNQ allocation failure
      RDMA/qedr: Fix QP state initialization race

Leon Romanovsky (3):
      RDMA/restrack: Move restrack_clean to be symmetrical to restrack_init
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it

Mark Bloch (1):
      IB/mlx5: Don't clean uninitialized UMR resources

Roland Dreier (1):
      RDMA/ucma: Introduce safer rdma_addr_size() variants

 drivers/infiniband/core/addr.c             | 25 ++++++++++++++++
 drivers/infiniband/core/device.c           |  3 +-
 drivers/infiniband/core/ucma.c             | 47 +++++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 drivers/infiniband/hw/mlx5/main.c          | 12 ++++++--
 drivers/infiniband/hw/mlx5/mr.c            |  3 ++
 drivers/infiniband/hw/qedr/main.c          |  3 +-
 drivers/infiniband/hw/qedr/verbs.c         | 45 +++++++++++++++++++---------
 include/rdma/ib_addr.h                     |  2 ++
 9 files changed, 102 insertions(+), 40 deletions(-)
