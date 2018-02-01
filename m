Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBARZ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:25:27 -0500
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:43952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbeBARZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:25:23 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [Next] [PATCH 0/2] Fixes for bitmap_{from,to}_arr32()
Date: Thu,  1 Feb 2018 20:25:06 +0300
Message-Id: <20180201172508.5739-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [42.107.64.135]
X-ClientProxiedBy: HE1P191CA0001.EURP191.PROD.OUTLOOK.COM (10.172.132.139) To
 BN6PR07MB2898.namprd07.prod.outlook.com (10.173.28.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab5c64f1-14c4-4147-4ef9-08d56998c63e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR07MB2898;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;3:svwCe/wWS33KTB2TJ06Y3hRYSyetdtzORwOT5y0jQQotnmqOsoNnuJC/GiOP2LOttjfBH+jfoZ8REwtE0h0x1YOKGJ/7DvlrDDL3B0y+UG5m9aPTuo+Ia+k7j8d4l5Pd+j7gOWLr8rqeu6c494wh5v0Rd3+pjU7m+eSzc0nWnbPXb8sAXg3LlUJVMNUrkWVp7bQA8IV3gkVQpmSYknkwNmBlRKhLpEbAedO8DCMlHaIEDRkYNgg2JXZTZQ/kGDCd;25:LsTUptsNQ00lZRbfeJG2xtiA9EGvc+xExgXNIwvDpPbKoMMPQGPCtnamuzm1JxyXow593lB2NTDB/nnavZHoiHdQpBU//rMRwHozJ6Hd2LTMZpzMJ75qowI/ZBVbbnqf2N5rhpX+Te8tMPpa7tk8oNvpT7kawvCD/UpOgCNdT4EcAEOB/xgvfMbIxinM1TOeVSqXIdHgbdlt1B8NX4f/mpShsTIusjGql1TXA6i6oMlTRU00qupSpm1ik09Z3cq2IDlbzfIKRaEsGw2cGjLel9tBHz79c4CbfKqbG0leAyCeYKMMamWXr9cVE23kq0Y/qN3TfZUYsfKWEKTFr1I5ow==;31:bLrQ/B1Syn7drnKgvHKZcHBBwiGxhNvEXaNgtIRNxNVpBznASOxpnWccDnxQR3ozy4v6nuLjBWhi8xPRYYkUbmlSP63zf/QRzkn87g3HFARxmT/uAt2fcN54a66OgK/vRMGucEoWjE2htIsKVLs7xjpEs6fxnad0DbzlPyDDjOmgfhWB+qflcPoeh8dmxuY8Q+qdnDMbGxs/kWv9Mh37Fj7E501IIE/H0Uz7fnUIu94=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2898:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;20:o1dyYGCOK/ZpnrOBrk7QzcnZTzpT1YNLX60e+MYOyEkF1abw9yHmSDgK1unN8NpED2bVnBLgnsBuUx53YONozJpBe+d3DtW1F1SPpRdFe9V+AMN6oE59/+Uh9rK54rQ6WKpehGLacoWnMKEdyz3tnGcRkzJJ/GV2QBZBav4d7XO8fCW2TGqxBUN7J4/OyJydh/GwAkNfqjLACUEtj9IY3ii1d6E40liZk58yp81IlI58xSFYghGrpdW+RqkY2oybtxPlOkwATPMMrAP+AjQ3D8MVMXcEBmBFza8MdU2NLZrJPr8IQqYt/cFZoQSlDMy+Vl7GKilmeHskotWLDUq0GkqFF0Y2ua1PTIkooNhMLj6dbUEvvGdJpbMES4gE5jzpxXFeFRNUCqY69lfde4iHXGS505OrdgrWZkeuHDXJ+pqiBilwOn5j3y4O+iNwnSjholq/da82r/BqgLVUAqyG60EkdjVZXCjpvpuP+ETd53wqXn742rKmvlEhLoDxkhMYWNGM2Gf0aG4LLTigBaEDa4oi6xmXNEOrle/h119fJ8HHTYzOTHH2QwCuhp03u0i54Zt7E3Gxrxa2DC4J8EaeWBxGYdDO4SMxVt1Mo9GZc34=;4:x7vJ7C9zA6cfxFnMQSEUHxoZRBHQN/fSPrgFs9LPk52/shHiVd2F3eloPxpOlWKs9wi4UgOBm+UDTqkNHaQwWXa79Rb86beZJHYTf5xzG+6bgmMx/lGktAVK/zyn9DO0Axqglaxs43pxoBLoM6qqcBNmRNC8F+ORvNBI7+ZgNkmpMIs4VyRS90dXFEMmuSp0kzMNnaWECnbx3jjpQfAXfZyPQYRL8H6G80A5psU5pEv3iWjLTInh6BAjZMxj1nFirgkpPUSzWGYWyVZT51Yh9mb5DTy8Stk2qXAcq4GkcyH7W8vuUln+HqEgVaR4tyLu
X-Microsoft-Antispam-PRVS: <BN6PR07MB28988F4B7F3D4BD4D9971A5DE3FA0@BN6PR07MB2898.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(93006095)(3002001)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR07MB2898;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2898;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(376002)(39860400002)(346002)(39380400002)(199004)(189003)(2906002)(5660300001)(106356001)(8936002)(25786009)(6116002)(50226002)(110136005)(478600001)(3846002)(81156014)(1076002)(26005)(105586002)(48376002)(16526019)(76506005)(81166006)(16586007)(66066001)(7736002)(186003)(54906003)(6306002)(6486002)(50466002)(97736004)(6496006)(68736007)(386003)(316002)(8676002)(6666003)(305945005)(42882006)(51416003)(4326008)(5009440100003)(53936002)(72206003)(47776003)(966005)(52116002)(36756003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2898;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2898;23:/Yuk+WscEfgmDhVR0Qst/9EbcndkX/eRRBb04QRSf?=
 =?us-ascii?Q?qoidI0IV1AhJEJ9DeZ4v5ceLyIxYrmSz1nehhypIiDX3FrSyspOIG/iG/L2t?=
 =?us-ascii?Q?Ivt48vi56QjLSh5zN29GisqQUkRasemlmRPzY7poWXwy3exK6hL9Iw6AchPi?=
 =?us-ascii?Q?j2RtxJSmVqalu6e2vAIvxpLsymlXyLYnmzXAukuqQ4G2Prz0pTWMQ0vwUNpM?=
 =?us-ascii?Q?rmPPJhmGRMgt8MSnjNeR3ZPYTw9CZ2ojx5lrSNV34TJ+sOX5El+FInKlYCZ6?=
 =?us-ascii?Q?aJD1tEF9NFo4VJwJZrGC6QiUC0ZenaBbiTQv/3BSaeXua4kL8GN0szAi2VkW?=
 =?us-ascii?Q?/pnXNqo/LtpU2eyUpqVzm0wG0tR90TBw95kmYL3UeEgCy+XvZ4UKGhbyrN1F?=
 =?us-ascii?Q?83IKCAV5OsHgY6+37nS+r2GgKoXxi/6AuHEDpiyF/xWluRP0R8KXqtXV7Nmm?=
 =?us-ascii?Q?7UgFHdkCa7VxKCX1viqk1u3vZ7EnSEDrE1o23Zk8Q2OcJ0Aa8g8eND3V2j4j?=
 =?us-ascii?Q?FlWoHnffnp+iufHG8OOEPM6snQYaCzVWj8aawW7RnJQmLIR3B2rmt32tqI5W?=
 =?us-ascii?Q?YRZQbuh0n+jkaG+xilGwclogYSpxl6EcFpS3eJVeb49WKvDYTHdi/fXn6g3w?=
 =?us-ascii?Q?9hOAdkBk/F8OfduB8+Oj4TwlnfEsuRevsqO2OrbUUyf7RkKjRzkcUPFRl4KO?=
 =?us-ascii?Q?O1QA/1ZtRk3ZWkWSHNanmdm/5J7jkLdM3/nzDLij1GLSawR75FJuBifT05VB?=
 =?us-ascii?Q?5/iJYk1wOh9Ti+mJHn8lgi5M4TmbSZ+vi34PQuQehQUjm7sQpjoLlw2NP21J?=
 =?us-ascii?Q?LkM//69YgK2EsAiPGd27kWqyAO5p4inSJd7aSZGE61Cuo8zyB7ux7+K00TWB?=
 =?us-ascii?Q?CiHXVpjhQIkzHxctNVIgsaoTZw/IalBIOhfDen6DyfnOD6E4jAAuVw2UOGAp?=
 =?us-ascii?Q?Q/0+ER2akYqlHPutpLEDxVHya7W8aI2KepLoGtVPfmPPd/sMAPSNMHIBp71Y?=
 =?us-ascii?Q?xiEDUazt5FsA9Zrz9ONFPs7xruybG7bT6E/eockRHaZOM8clBttWOJiZbH5W?=
 =?us-ascii?Q?RiAaGG8HzeEOlHxrHJHCh0GZHiL8R7K4IZniIA4WCk5tjTXibBWaHzlz2Am7?=
 =?us-ascii?Q?K4aUPkGthlVdD9IJz7kUX1pplkhIMTHt2YMDvRn1dDLyPg2FLZSQYP+N13/E?=
 =?us-ascii?Q?aAmoYmS6ihd6yIyVKQ003mlPMcRGiE6C2WsHqTsQngvJ5WvXFcBOhAERg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;6:FGB7HzM0HiTrzWRTPOg2d08CeVWNyD6JeQKt31P6FD0knR3gJo1wWAeuHZj2I6ppfAuj6vpwcIDla59px1PeReH1qWVOwk7nWS+Eg5p0yflFY+xI9ym6Xw7y+MeUZeKk8bTVsTfos8i+YFSOzaDqEzOhhVgIBlnCgtOYd4xabnPSArhlZ3Fll0nDZw4HBp6wIuATjOvHTdslvpQa/vpFE3wOw/nqaLvifDBKxkuE+BBEbAbyUgni2F5a8Y3l15Y+R9HKn83Ah7ug3o9cUmDd5nAFgF+7xzcydjdZ4bVcigYg3tS5/E0G+m1UoB0DbOV48h65pFfjBuRCTJwrE75h1inKcXwuWlORvpl3ts5vSgQ=;5:jYa5CAYZN/XzzFUi/KjaImIK7DwDrAQdKcIbkZ775kkUjwFpaoTKAwqYwoDfZWu0/x25m+hkJnJRZjIzv6noInkkYR/pqakNI4mQw8fJyIEaOBovBe4qOR2//K8mg0uXIQj4OhfLJdPq48A9zPtpEKVvRjRA95TG+Z8O6rHqoUw=;24:0rHHtb5u9og6Y85Z8hXYR4IkbFo4U1mtQ2BzbcF1xaUEYm1N4eKMo0eYLyGjfFdZBP/5/zvkpvO+P3d6qenYgyoezgEDGy/8nUGXuWvysA4=;7:wsSy7C9yrijHB4qp8Z9FKp/AASYELLBU6GTUquIL/dAQVejSpP9zNB1JTstaq7p25mwmCPxlEOhoICq8YnDa0bG0fRwbJty5CJSBHloGwoyn1TdQrEn8k0hakc1kwHYYyCNsOWU97qZ4ySiK+6JkFIcFWUvOyAlYILzPIHInSVRwArDW338hTrkfl5iu7TIK0KP0saBl22JovZ5kqCPn0jmbHG5AI8hci3tFd8ajTK/0DIhQz+gCqQQBzEZMFaZq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 17:25:21.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5c64f1-14c4-4147-4ef9-08d56998c63e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2898
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch replaces bitmap_from_u32array() from
drivers/perf/arm_dsu_pmu.c. The change that adds dependency on
bitmap_from_u32array() appeared in linux-next recently, so patch
may be applied only now.

Second patch renames bitmap_copy_safe with bitmap_copy_clear_tail
as suggested in review:
https://lkml.org/lkml/2018/1/8/1052

Andrew, Stephen, please apply it in linux-next branch, or meld in
corresponding commits if you prefer:
87e93201a5264c3 (bitmap: replace bitmap_{from,to}_u32array)
c27460ea428a257 (bitmap: new bitmap_copy_safe and bitmap_{from,to}_arr32)
(branch next-20180201)

Arnd Bergmann (1):
  perf: arm_dsu_pmu: convert to bitmap_from_arr32

Yury Norov (1):
  rename bitmap_copy_safe to bitmap_copy_clear_tail

 drivers/perf/arm_dsu_pmu.c |  6 ++----
 include/linux/bitmap.h     | 10 +++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.11.0
