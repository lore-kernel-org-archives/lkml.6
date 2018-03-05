Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935106AbeCENi2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933862AbeCENiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:21 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Date: Mon, 5 Mar 2018 13:37:40 +0000
Message-ID: <20180305133743.12746-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305133743.12746-1-guro@fb.com>
References: <20180305133743.12746-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af82e2d-badf-415f-14de-08d5829e54be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:MWrHlS9zQ1pej2/1uWExDLZIPP6acmf3ntOcKV4wvK3y7rZisY3v7zhVADMBu1gvPsz8SDT24SJZ6I9ZHPZ2wmvK0Qi8yiLJ2cgw2aSGY2O6CEf403n6KchRM1hlBDDcoK7livWpi9VFunxDMWkiISnuPjeZGIT/92OI+Pielhkzt3EyZYm6cussQ5oNVY+BmV2i0gLDsqkx1lREop5L4PpzBfppI/9JFbSN3Jrr2g58eG8FfjexhX3tdJYtPQqq;25:CL9jWHFF+WoxYx3zvPrSk6E+JeCHlVEVINTerYI2gKZkkouuvI4rfLrdShe0H8A2jcrkJbj4yhn6zdPDKc/kNRpRNN3x06ZmRzGqJq3rytYJwMm7y5hMiyEP//BZ0S8ZrwF+J1cf6RU7Jv0TLANT3zhMiysaRs6j/Mdh4AdZcqML6Ni8r7hi8VC50loEriWd+4piOBGMJPF4DTQFZbCG9LBMCpE47o5ENkz/rK+g8XjUC8+lYY1njznI84WiBl+1aqpr7iJxWVvossx/UXSnhwsXhXDsd88kgeS3sNXdcMmOinW18m/xr//Ms+0zAzFTT67sdRCwj8zOzWhmD2+MAQ==;31:aF9WPaZLMTqpwPtjUZVF9yskdqMi5aE7ZhP6KXqH01fELYBZCm+rMp4xwZjaSR9T9ivXuDHPQYCA57rI1UKxcPXOPte62ATlx9vh2+0Il1wGlkRYp1DXeBscreeOz7v3VnLd92QAbcBAWQb7POyfUgvxVkGhoNBicQmOnf6pGJtt+aCXZmJhHm4oJ71/ar9E41A9Z5fjNWgsTeGwBiknMVowIo0lNXk+Ksv0PSTQyJc=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:Rsas9CxprQD+wfP9LT8gtdcAD4eYJWrxtLhsKFh/ywO2pWEfmr6d2GkR1ZKLdTmfKB9dSbjvu/958Dt1MsmH+3hMkK0p1JZd2xC12pPf6OixO0pk0CJQHQ7Pkl1uMpm0YSh0CouZzhN7QjB5MV3sNuBJG+Y2G1FtCEvmlrOEGgil17Pr5wZDLQ5b0IjVqW/666n2smGKqexYmEYJAZy11ZsDfHypVexIgM5fdeGVVQ7GIA8dNwFgsEde094AhflA+SxIBpuG45uuJ7c4YVMBQbFMyTNezwy5BOUPZBkXivW8fQHyHx6ouJBTQLRIY4HkIIVw+RdKc+66PPV4HECnZujPvB6gyWSy6VY1nih7YI0tVmDRQ7LpLpZdNI0p2Q3P5Ll8cjgzmXN8qh9Rb6d/FTUjNJBCPfGbBzxKTw3tfki3WQTk4mQLo0V2MdiQHRR0KzoK6aQvBP/e9GktAoTg42O/SmtfuAXqVajS+bsrQgKqpT4oZA4CNZau/zMfdLik;4:7nu9vfBkIfdVH3WmFuVK0nF+i7wGd38Olq7ZVHPLsblMTAYyQ3YDFEB7bXKPP0/sHv4HYhpMDXT5GxxlzCNLVof1HufjTLqkAJcqdHfAHF0/kix93GEZ4YBiX5efysRZt6EkcIPe5UUb6gywU4uPd39aovfnz19jOdlXLMbC07rQsS5aO5x0d6Ua72yd8L1MjAenReMROPek+r+oy9N/vTCzEXocKnFJ8ciYuY4lP+fHIq1ePusD83lmTZ/XvI09y+6b7lzs439fxCBehyHoZVjZDQpRlEfjwyfuwZmkTXHJUX/BqYd7d2lN+GcxAo3thRAkiEzeNJkyl1qvimLYs54tCJ11+spMqvMQLy5wuUg=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076FDFE37C69A9B7D7DB7FBBEDA0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(189003)(199004)(8936002)(47776003)(50466002)(1076002)(50226002)(48376002)(7736002)(16526019)(186003)(4326008)(305945005)(8676002)(81156014)(81166006)(2906002)(6506007)(386003)(2950100002)(5660300001)(2351001)(478600001)(36756003)(106356001)(2361001)(6666003)(6916009)(6116002)(6486002)(16586007)(316002)(97736004)(54906003)(52396003)(76176011)(52116002)(46003)(51416003)(53936002)(6512007)(69596002)(105586002)(25786009)(68736007)(86362001)(53416004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:hM8CsiWjJ/S+rXPcXoTkDw5b8cHgGvv8LDTd7RlPq?=
 =?us-ascii?Q?l0u+TIcwXc09Hw4t1B31GeCxUU2AmhPVloYRR4tGLSVcE8lJarfSadjH/HA5?=
 =?us-ascii?Q?EdUtI41OqxU1gQr1+s4Ry1GTH3bEr5r28oQaDoe+pEfv/7bnPYqYFhGqBeM/?=
 =?us-ascii?Q?IZw4j7uVN+FEPfP/oSlgBpxtVWJA9V2zoM8g90TI+Shv4rYfw6esLqkrqbc9?=
 =?us-ascii?Q?gav/+HbxGXfV6ujPwNbl6OoHHgr2vQh2uPVe5H+m5oTq2S5HoNVtGKX8doyO?=
 =?us-ascii?Q?JzUUfFtysRFjVrGMX3NfT9+MQLNNl5AF6BTT5CWAHYiSVxM1Qlmqwvj6/pvi?=
 =?us-ascii?Q?8e1frWC/NtJfjnocWmZoh0P711xOywETx6lM99OHeDxhEUSxffTsZ9sg62rC?=
 =?us-ascii?Q?UcotZ0iWW0KyWeSfxOK+NZK8V40MbUXT+Rl+Cz6+ApaBBbxF7XNeDkO9sJtI?=
 =?us-ascii?Q?DJ7AwdrxamZuMVIOfHMBZgSsGr6yEqRVQ8QVWlDMKsDOc0hnSidesRy5S/mA?=
 =?us-ascii?Q?HUXAfOojwogHYEkOpN/K72/OI8sykzMFjGTmKOGKaUa5xxq+uWYd/alX3utG?=
 =?us-ascii?Q?xdgAIco6uj0s3Gc8LD7BbpowcwHtDbmKs6XN7nu4IeglcR4d0I+XlRwYCOnx?=
 =?us-ascii?Q?UCIeLNgf+FI+y/EF4HQ2bXEjOvDUMYv3jkN2t8fomIGukDO8rn56xM145ifB?=
 =?us-ascii?Q?lYjU6outwv/QacOLzoB6GLZ1n+Ny7n/R1CLhctgXxpF2FIh0nRIfuil9ul5J?=
 =?us-ascii?Q?s5lClvL9M8FFbGUiIhVRW0InlHdxoSuf8x4Y6NKFCh32lTbUa0MCnFSAqOkd?=
 =?us-ascii?Q?mrqsuPF65uLrpSElRmnrdVuQ6edvsJoewkUXbhqQduAYBDZa6lDvf34m4tMV?=
 =?us-ascii?Q?cdSIU7CUCmQSHq+xqWMsYM1UQNWRZ6fxFfBq7LUzMABdjBglg+IbkUn7Z12k?=
 =?us-ascii?Q?Dg5fOMWTusR+bmH4S6mHRuwpXQm26UatwhVd2SbUvGFS/842SF6dpJlDuyvH?=
 =?us-ascii?Q?cTZfla6RbT7M7HJF0McJTU4aWviOUw8rV3+fWAF4HYsUVxhIoC4pTyy46Poz?=
 =?us-ascii?Q?koid3L8x/IWYWwjnLgFn95OeURmcHG5zS0Lbw0gU75vlCqKhN+rBqrlNBCei?=
 =?us-ascii?Q?Yho9VWMblDC6e50CAONw/Ahb6L0RlrWEN/ame1IlXQqDDpFyfYy1/PYM/u6+?=
 =?us-ascii?Q?mCD3fPhJG2DnJt/1KrMjAZwXoiF234Yq1TMZJqSZ/ncoByzmDcF0QhPpA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: x0oi6CWW4o6FCWhYXDKOEtnZtEE8hol7VUykFhIWDqHTv77TsRvAUqiSnhrZpRXKd7MybsDzc+zbDIRGntWwhemAC3guJS6OzFV2dTeH3iKWzpbNaJghYwn61An+hoU7+OV4KdU1zG9yU6Aij96gwrwQwp6Mwxk9nWpw1ZKd3JTBVfo6TE+goo428RZ7qM+N
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:cTMHpDX7Bu7yIhXlkrkEymqulctJ46kdZaVEW/Rs2MJl7+Je+9J3zbS8592AhkaKaLuLn/sJdVqL6+wmhPh0iLKZp1qb+xfTcQg8s4oWjWOTiQ/sjEkEWS0Ri+IV3hmfDj5cLHxiKTN8EoeZ01cJFa+CEIHrZE11Wz1tImKY1YmLrhKWv4hCfFhlnqZ90oT4nWU3Mmpy7mVBgbIGybVt3DJHwHLyzcHcFoogMpu85/JCSSNs8Mol330OHa9x8bywpjFJWpGWcJ4ZZqDfN3D9WhLyG97ZlHJH1+A5ZYsw+0CWgKs1vTDeNevbmnaOZzsapuyKHBWDPq/iOAvpOrf3F/9ksQchp9CO0VVMq6YUfq0=;5:Q08TXyoMVCEqO3lC87YfYAnmbVVkU2UyHEoSdEqCFM3ZF4bwZXXd+0229JjA8qC2lHs+BFlOtaVJ1pEfSQmnBWTFEI8XocFev039qH0tQ3NSs633Xv2+nwbGOFCMrFmh8NI2FW7B7n7MDy3r3TemyQTF/ZziuEIwKi3XpfSK2DE=;24:d6Kf2Wm2D5X6kdUk3Pbb8+cmZoassR7QsPfldqZWQ6KgRIbdRYYf+2tmJ1dIErR5zq8zhuryfTwrbx+Ge0PEbOCr9A6agLoYzVH186OplmM=;7:MWb/4HDqh5KfYjZjJuvqx+QCZ9e/Qa3dTeNAYpR2fR26752tunbWXySn+gkgLtH0CngpWUFNZwhDtlE+Dcxm17vsE56eo9KaBq9WtV63Ku5f3ZDObRrxqsvI3xYFSjLJ4RqqfGcnSEBoXcT98MZcialK5OhYWP49kdRMCOKlOvy60Lx8ychAMdsuv39Akf4YpmVMKkC21i/ue4pBjdQNyvcF5Jb0YZAxhY/rhFDhhgDqOnBoKIv1FQDoCWOCkC/b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:3fEO9p+t1n70M+59vg3cvBswB6XIgg9q1iXk/okJsAmGWDp8rcUwd9AnDF05YccMIw1zVFuRXrZGBQfNlzkk4UaBa96bxLLKWZCQ16ONjio91k5Gq8vefrAIx/e8LqmOYhKAYRyVwzJ1NZ9n1TfBZ1FOw9dKr2xDzKJeEegulTY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:38:06.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af82e2d-badf-415f-14de-08d5829e54be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a concept of indirectly reclaimable memory
and adds the corresponding memory counter and /proc/vmstat item.

Indirectly reclaimable memory is any sort of memory, used by
the kernel (except of reclaimable slabs), which is actually
reclaimable, i.e. will be released under memory pressure.

The counter is in bytes, as it's not always possible to
count such objects in pages. The name contains BYTES
by analogy to NR_KERNEL_STACK_KB.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 include/linux/mmzone.h | 1 +
 mm/vmstat.c            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e09fe563d5dc..15e783f29e21 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -180,6 +180,7 @@ enum node_stat_item {
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
+	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 40b2db6db6b1..b6b5684f31fe 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1161,6 +1161,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
+	"nr_indirectly_reclaimable",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.14.3
