Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38DEC6778D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292FC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="im4TpruW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292FC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeIKEB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:01:26 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:61819
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725266AbeIKEBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGoBWzXLxZL6KRr2fQv/ZzXiBJcxh2dBOS2ueJPqcbI=;
 b=im4TpruW/2Xue4BJNSbErfX5HgAuUtPhFBMJezcNf3uDs3JmwR8SFoM9IruHk2Bukcn6sCNzWnB6sPTbeskeVeTrVjPQXLBlaDduS7iX3InQvaU/z3cLMhEU+0jTLv6Ln3zVl6gfSB7U8I/fmTm7JSyES24sfzYFuQzqxEowz/A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 23:05:03 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fzVEi-0003gC-CV; Mon, 10 Sep 2018 17:04:52 -0600
Date:   Mon, 10 Sep 2018 17:04:52 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180910230452.GA14095@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQBPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::31) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f096c138-ad2c-4393-7e68-08d61771d76e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:PeXkZq5eGFV9jCYIxx+SEe3RqhZMo4sP+PFBjrCXe8sjDfeR23yG//osF+ShxKaQI0jswmfULky7LCniHrVhROmc9PJ/hP/fdtEXvT83fjXJUB3yVh9lWpUXUcq6OsAhzv4x56uS5nObGFJ1QKsoTzb60QchIOugyK6dUiOfIVvC56DKX8uJfr5w44X+QU7oWTdI4TTK3vhc9ah4Im6YngUwFkyRGoqu79uWHOP1NRjtgllQ2cYLCRrC4BoZhlAh;25:CCu1E75yx1dAQLV/rbLumk/wB+DXX81uzB36iFvP69/Zig1j3Pjj4l0Y6V5ZgS0njSeIMD3Q1F8IzqkjPgVd1OsPoAlZu5d7eikN6wC+ettFyTAweAn532O0VaQQMUESIqexzPGNd+Lde0qbuwYprMSFZ/xU5HEruoSa2V8DCIidQyjwrIXKN206iljLaVJ1qYpDMN1ArIZB8uafmI1B7y0ia3El4dFPrhNoMdczDGRB3hQGBxwOtk6aLrnfb/1zX9WhCNXUAKw8C66+vfsLfScp7YUHPWIKCORiMsEA/sMoY0lhyc1MzarMvJ0Y0vxkw/4+axpm5OZXu4mCEhHnkA==;31:E2WHyzWb2ypYrlyCXwU8vWv7frn/mORs7qtap3hRgtpL8ajh7ULDhFymgDSBQACAOXwhii0ES4oTsYLjW6B5CzaFNsIv+FP3mQAI2OxYVGzeZWzpeGTSzNGCGMlmTz2uOhAknMRssXyM0TjLBCE9feBmcUtd6lms3WrBaeqdK2+epG6gv5QdDU34r4U2D6rDD15z2MG12xRXRxknGZt40YDcwtfrgwL1HvGZiYekTdw=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:LSLvM54K3K0fR7KQI5uMp6nSdbBLGF80nqtqKc2wBvSwao4hrLZy9hm4FE5YYqTWVvYCDo5soyKJIzHHWB1cDsyZwT8PVsSPpr7yCqlTjOGHU8c0U81kT0qbXI/jwLwWHHkrjmDe5NIKY/F8UhUCBKjeUZdTNqMYkr+kswqKzZBPccbaq4J8DtCQd2/wO7x72s/wEbs6abhnHyUO9tMELYKxPwzXgbWREHNsLmdSqoR+qUgiCw2DebyjUvtPohE5tIHrV23q45humvu/0gQnsrs98g+7N51WyyyhHVZsX12bt3uC9hISSiEzgkrD1kOIwE9xRaPa6TKg51CifwwjwWI9DCEsAYB0BNnZsfI3B58SYzDPQoSGjsaLyenuEeUetK53W0QYePnqQ5sMzVMmoCFDIzj7+uiM5xpB2CP8cSkrTJY1/fVMl/7ahta9lC5dROsWxqtjYPSf8kpeIj6LOxr50eytZuW/8zM0wIuP+rX/DqntfNKdtDreAz/0/ePT;4:YaSZS4KmPRE7Li/rX1qn+zbLtNl8vGcuvkW+wS4q5MXlCWPtW+4ho70cid5t0vQkfIlO59HLpPaUlOoxfZmIBBSzkkpOmGsN/tgeDftN561c1HyVmm+OA4Ae2FOqFEbHnSP64pBQ4z3YXi+tn/HhdBZWRHftzmXqAIF6VDTtTxcbQ66xoaYw0BpIjAPqylYHZj6iEmTRaRnzjClkeJFB13Kj8F08b3FaE8x8XNSCkl2jeShWDiz6GEej6GMt8VK/A3MiezY2B3mcm2fFHONESNnAKPxeJzb6ibTsc4O6Z7eLv3O0GyynCGTIcvmiwsC8
X-Microsoft-Antispam-PRVS: <AM6PR05MB445493B0F1FE30019551C42DCF050@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(478600001)(1076002)(52116002)(8676002)(8936002)(33896004)(33656002)(36756003)(81156014)(106356001)(81166006)(4326008)(53936002)(122856001)(9686003)(9786002)(305945005)(9746002)(83796002)(105586002)(68736007)(57986006)(3846002)(23726003)(6116002)(7736002)(50466002)(58126008)(86362001)(110136005)(97736004)(2906002)(476003)(16586007)(186003)(47776003)(69596002)(46656002)(26005)(66066001)(486006)(14444005)(316002)(386003)(5660300001)(575784001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:Ryim39MO+ll1N83YM6NzX9K4m+9F++PhL85l8pbxv?=
 =?us-ascii?Q?Dy6/3B7BuchyTUAbk7ksbTb9UCxMizeQWHPylNvtSMGXcSWTpEwk8b0otkVj?=
 =?us-ascii?Q?qVQh+dDrvzMvF9JiAMxqaUExgVXzS7LK/y3U3CvzutjefTo11SFRj3yZnmxl?=
 =?us-ascii?Q?5PMpeeDYuuAJjn1+JMpU1PdQEhY1N2K/EcoUsWWm0R0GSuIYv4CCN/FUZrgZ?=
 =?us-ascii?Q?uZc1ghkfQM/pesIER463iZOdLg4rJJSUJRD0uyu3dPLy0Vl6IpKjRMT3B+dA?=
 =?us-ascii?Q?GyiOFlvrw4cfjOC4BlTuP1GSxLwtyajICRooN+Wal5D6ld3DLunf3RdfpiAm?=
 =?us-ascii?Q?dA+BNfUkYchERtUTapZNVtd7KsE4VDSWJf9JpADH7+9mAfF0KvQx4KCU4zol?=
 =?us-ascii?Q?oQsKeX00Lp3uU4EZRu2l3TAUXTiJfqDHAfjZlFIw06qRMWWN45hyrtksfWU5?=
 =?us-ascii?Q?AxYn8hsw24qz0oDvAF85bHqDnS1THJgIqi20yTLHQgxahoRymxBj6QPv2uhN?=
 =?us-ascii?Q?dDqtWNRcILFxVWExCAju4lgs5nrHGPJ2+wxomZHRIEBM+PqS/MWAy8aaxM54?=
 =?us-ascii?Q?1GGTRVwjYBXME1vejpH0AsWh4ZHwd9sWBjnltwvzv8Ouq9FJaE9Ta1/ARQno?=
 =?us-ascii?Q?IwptJ9W6zpY1ZNoY8nEPm5xaBCGpTsPHRfKh23MdmvjAh2WWrJgZ7rjyGdcb?=
 =?us-ascii?Q?GHbOZjri+V3+iQNDoacjCVE8jb6zl7+nfK59+wQWdPSKc1qIJPqjfrX0CQPk?=
 =?us-ascii?Q?1jhrNzYqmoFel7ufQyIO1G+99+YvyESkrsLwdDkTb984JHP3ITjKnG0PfWiU?=
 =?us-ascii?Q?TV8JfTWOSHMci069fxEFroy5VHBJfkCZzbhnlV6rLQyTerS2qyXR76SwBBKN?=
 =?us-ascii?Q?5j8tl8YCqPYQ/rcWgg/g7WcylU0f4+vqrAVIj6wks/A/ueOgA437cYShJrB2?=
 =?us-ascii?Q?rE7Z+i73rXBP54FF57CxKbBgGVfYND7JPRuDs9nkmlcK+7I2QzSy2qvZMIxU?=
 =?us-ascii?Q?RKXxyb7teBw9PYKYpor+RIMLoeMYKufipd45y7CMi7/9fIH3S3mcmcKJ8AsL?=
 =?us-ascii?Q?TazQ3e9hzHhKTT9IO3CAvlNmZ+JBjHSh4+L0f4M5cc/nHxeuSoSePaZIy4q+?=
 =?us-ascii?Q?RFfoVh9fFAISXgh1AxGsacioq3zMvuDQsrGbAFIs9RNNSPRmIGzB6T5O/Ycg?=
 =?us-ascii?Q?9BHPj7DIDDqLAnhK/oQVI+bBY+V0AYbDVzPB9zrYbg1pDyYMcTiw05UhZszS?=
 =?us-ascii?Q?/ek2jVffn81fG8GUEa5AC8TicC4IdpsuRrtpDCKC9a4yz8gRCe4iswr5LdPG?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 4b+Osc2RY3VEGgSS1+05qhWh7vhO2zq6TfaUQp/gULxm09hhhltvkQ2UDBoxzYyOEmcI8I77lpGvW9eW8X9Y6+fApUH8UflaIYMoWbAdvStaBkmdbIYbcv0ojDyOktn/DkYoKQvNic5TM9f1JCaMifdjcikibkDpMA2J3fyoJmzwpI3jt6dWcdfxgyoK43lv8YDcVCwexxmk+0pofSpl2SOcif5ysrOe9n3zl+zmbMGsokjXak3it6MCMs3kHcf/pr+vPdQqd6JFGY7rD+dWhTJf9OoyfLFnBB0bXuc5KJoRBCBxdRuBdytMXfbYbG0cibSBAlFpa8KhdAmy0sZG8UvZ3Sjip22/ChF5Ii/9fu8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:qj4RGl9mlGYs/tQ4q/IU6bvf01cF4mKZU1O2Yk6iDVls+5FB4SsCVNuiLHOW9W5RNZusK0SEflBoL1TOoKigThEc+SUdMx9wmvIstD6y63jMr2bHziKrRLjtJTaxYzbklMqpz41ofLGQkn6/AzvF0g9vH/svQ7Cj5hYCNsqTQYSzBi5PSW7nco9BjrB8nbhOThZbShOIyKweOYun5EkEHkr5c10tNomTqR/tSAFa3hR23p1ZrfIZUXhNfU4ryMxdEtj1DzQxp6vkryoBQtEMksijevLrRGiMCefORbB3sa/BVKkrkCp7SLktG+paoXY8XXTvSW6rPQ/s4ozHhTcWvYYfA3ENlzHePLw1id3oZQgPsKKyyJCi7FYkpv7LhX7wpH1bgnXWwvWR4Lk9NQCvyG57pP/vdwGBYcm/vMEyok+1T5QJ2NyXGtzMDtfuq1eBr2nDnoytJUvc/w26Jc+syQ==;5:u34kzOIq6YvDZzeEgAHyzHxiuKqOTWl5WFUqhMfqybNEaC3QwPPgicUolGiTfZm5oBvJlHHLXuQQ87FHh5B2wY37A+oiSSuP2zvhOrR5UxzSPtc543oNiEVg4wkpsOSGK98u5SB4BZZYZOBEdBCFJi2UpDkZ1y5ihGHKlNGzQUg=;7:Gp0nyDrW2Q1XMqsVJorbLfqZ22G8iRVGv01ZorlhN0dqCV/4QTl4rIZQ3TmwZIXynnq5FIwjZkVh33+wHfbRxiPFG90+UIcqfiIXT+zZ0/FfI7JRLFwn6+uVomNx1fVrhJAru71Vm2VYoMF4j6CYGvk7c5HvXblBw00OFoE6LOubOZhZpxInYZMDSqfDtIj/eW+nOHDvmvDcWAsp8rKrVuYKMaH9lzvyC4irOxfS/t10CI0IbFGGSTOcBR87TWzl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 23:05:03.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f096c138-ad2c-4393-7e68-08d61771d76e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This fixes one major regression with NFS and mlx4 due to the max_sg
rework in this merge window, tidies a few minor error_path
regressions, and various small fixes.

The HFI1 driver is broken this cycle due to a regression caused by a
PCI change, it is looking like Bjorn will merge a fix for this. Also,
the lingering ipoib issue I mentioned earlier still remains unfixed.

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 8f28b178f71cc56eccf2a6e2c0ace17c82f900d7:

  RDMA/mlx4: Ensure that maximal send/receive SGE less than supported by HW (2018-09-06 13:16:12 -0600)

----------------------------------------------------------------
First rc pull request

- Fix possible FD type confusion crash

- Fix a user trigger-able crash in cxgb4

- Fix bad handling of IOMMU resources causing user controlled leaking in
  bnxt

- Add missing locking in ipoib to fix a rare 'stuck tx' situation

- Add missing locking in cma

- Add two missing missing uverbs cleanups on failure paths, regressions
  from this merge window

- Fix a regression from this merge window that caused RDMA NFS to not work
  with the mlx4 driver due to the max_sg changes

----------------------------------------------------------------
Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Artemy Kovalyov (1):
      IB/core: Release object lock if destroy failed

Jann Horn (1):
      RDMA/ucma: check fd type in ucma_migrate_id()

Leon Romanovsky (1):
      RDMA/mlx4: Ensure that maximal send/receive SGE less than supported by HW

Parav Pandit (2):
      RDMA/uverbs: Fix error cleanup path of ib_uverbs_add_one()
      RDMA/cma: Protect cma dev list with lock

Somnath Kotur (1):
      bnxt_re: Fix couple of memory leaks that could lead to IOMMU call traces

Steve Wise (1):
      iw_cxgb4: only allow 1 flush on user qps

 drivers/infiniband/core/cma.c            | 12 +++++++-----
 drivers/infiniband/core/rdma_core.c      |  2 ++
 drivers/infiniband/core/ucma.c           |  6 ++++++
 drivers/infiniband/core/uverbs_main.c    |  5 ++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  2 +-
 drivers/infiniband/hw/cxgb4/qp.c         |  6 ++++++
 drivers/infiniband/hw/mlx4/main.c        |  8 +++++---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c  |  2 ++
 9 files changed, 33 insertions(+), 12 deletions(-)
