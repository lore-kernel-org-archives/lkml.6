Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935578AbeEISMA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:12:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935159AbeEISL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:11:58 -0400
Date: Wed, 9 May 2018 19:07:39 +0100
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] mm: ignore memory.min of abandoned memory cgroups
Message-ID: <20180509180734.GA4856@castle.DHCP.thefacebook.com>
References: <20180503114358.7952-1-guro@fb.com>
 <20180503114358.7952-2-guro@fb.com>
 <20180503173835.GA28437@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180503173835.GA28437@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:ae64]
X-ClientProxiedBy: AM0PR0402CA0034.eurprd04.prod.outlook.com
 (2603:10a6:208:15::47) To SN2PR15MB1085.namprd15.prod.outlook.com
 (2603:10b6:804:22::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1085;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;3:BfFofNOrzp95fRJX2fdkAOB+C1j5hvybzyWIibm2VCxuvr8HIH72c4YjlI13PFoZ5eLohgekbycXYA+GMA3TErpqfb3aClMe4vzwdVtl5Xx8PY/sW9K6pzfpAwxS2dIFi+jYMsxcT5Swl0hNXyRy5GlJt6JaAzZoNIbutsda7XAqCunS6icnpRbDLpuon0AD2choaQbgp8SVAko15qSRAPu2mKiPG9aNqb68yEH3oqSM9SPYGd3tLtR39Jmtd1cR;25:zbFJp5H40NnrEE8KLEh08FaEaYqoD4zR7YuqvxJu8wpz/xAMW5w2MXQSn8KLvhKKG1n4oa6toZMshaaQ5ZooZsmUfhYz8+k1QT5rs3VjIZIHZPlpIzsKJR+ytQX7/oDn0OFLlot7SyCmYLTTvCYic6hhqx5km0sKxinGkXvRCuvW15ywt/H2xjeQYCed/MAU7ZV1mkoWuFFebT7cYfg7kM2QbSCJiUIkp9taHtYuiP9SZg+alfjB0ZRxT+qxJPSEApVLzocTmcF0zO/DPeOrlRvvb0SKnhjP9Qv7fNhc9QOyYNEZO1zjz3geYtTUs4NvZZ1NPtA0trcibB3Lt0Z/EA==;31:fdXgN3vuT9k6OTB05NDsw1hsmA9d+4MJXUKMlmqFhqbnQcRvamr0wMyR/TTPDvgriIcXAoE75AdRTe/L20YPiigfRU8oT/IiVEQU1f8o9gMvLm+IB6u9h/v9FpVwnGVQ1YdxiJBJF5MPeXXmk1f+7/SyTVmHZ1dWA+hBzedp2tibWHq+ufWw7UrGyRyjHD/ULii68Dt8qY0KdZui2xVRqLpWlWV5eBW1jZIOhj1mQus=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1085:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;20:6DvUoNniJd8YfY90ioMClvTfsvrugy1Uckh0b0se7lpCyjMT9lQnOiX2xaPyynxOkypRW18yKKtP6WcOHsHO1kyXbt5kue1EhnqM2T4fn2kDp6pybQa09THdx+/eiDT6WSdluw9+khiLD/DcGCmu/IpjQ3fzS3mFwmkd9Yb0MjQB82EgRaqgT+X4uN4LAV67fgwg4I0Ul5AX9TmiF3uTd2lkBM/O8cZIkcjX0xlsDnvW/9Z9YL4LK9po8t0TjTv4JVyen1GMq742v/XlJOb+NPe870jGN5l6Jk9DFVVWkFZepY2ecij8pZojR6KDq6OmUVKjzEDaNBZZ+2YHIuoCOktiIYprc2ELe4DilvFeTBjK95lxM9WNK9Zlyf5MpyxK7nRKuDusrNKTIGCkAoeTu0BzT5TjCpCLR+xnzECL4SVnwGeRcZiJShHB/4znFkneGhbp70D09qEg+7d1KgDJY/VWEA+m5ZPVEUoqbnnSKWDaJhQeuU842MJnOP2OPwTW;4:EiHJPoDtThkLhu8ogAQke9QXeVkJffnWZKX8RfM8uL9m+1ZgKjraWf9zTxEDyGqQsGCKFRlxeJxUTlE2V33CuNlJP0ZU9iFspi2zqo6abqM2S/OCRFxVFAxbpTqVZnbs7C2fmVl4dhaYvGgVhNfXKiYf73S5qZHcE9GXqnr8UxVeQa5oSIXntvywfD0XiTMKOLdf3Z/ZzuP2jilj7W5Njrk/u0laIbGn5gCkpIwF+hieH//bOeF+qCzfJffjZz9LHFZM4T58mfo/VPPTn9qVKUCSBfSSKz2hxulA5GGR9x1mhj/gXtzdW1rG14s/MtJDIRY0GAL5s7vHJ/AC9KoM7jbvZsWzFUPqLwIxV8dx3zs=
X-Microsoft-Antispam-PRVS: <SN2PR15MB108577AF9ECFD5089A285C73BE990@SN2PR15MB1085.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR15MB1085;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1085;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(186003)(486006)(305945005)(7736002)(97736004)(76176011)(446003)(11346002)(476003)(106356001)(105586002)(46003)(6666003)(50466002)(478600001)(58126008)(110136005)(16586007)(386003)(54906003)(7696005)(52116002)(86362001)(52396003)(25786009)(53546011)(59450400001)(6506007)(16526019)(229853002)(33656002)(316002)(2906002)(5660300001)(9686003)(53936002)(4326008)(6116002)(55016002)(23726003)(39060400002)(68736007)(1076002)(6246003)(8936002)(47776003)(81166006)(81156014)(8676002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1085;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1085;23:lcOPXqvEB80Gd5bqF26CadyMdfh+YWrz3f4XezTgg?=
 =?us-ascii?Q?mY6qGYCSr9RCMYavZ9aDOflKrV0cL01R3q8oM5hV8rM+ANwCQ53v1AJnVSOF?=
 =?us-ascii?Q?4OacwdWrjU5B1KRp7cSFyKJu96MKrdNU/5NhawnRavHWj3+6+nZ4qmpiI99w?=
 =?us-ascii?Q?42XDWaq2llkWlUh+gFFetamiZETvCSZHHk6XV9b7XnJMspm5d6RhiRabDJPc?=
 =?us-ascii?Q?aTFIumYOhQWIPbA4whk7CIN/qeykwBkQ18i33C6hyTjg3X+DZ4Ciiq2l8z4r?=
 =?us-ascii?Q?XmpnHKXS2tU7NUklV9NySi3RP0hznKG0L06Ay3Toxlwf1HtnG6y4RaGIKfvR?=
 =?us-ascii?Q?6G8IWHHhmCPw/DkztJpP7FOQGGNMldDzQZM9S/5HggnLSOJIPSI9PWhK1vzK?=
 =?us-ascii?Q?9NsW7bxXsqI8bD9oytjwojr1Jw9eRIRx8h6yCaIcagEya1qTbzcZwa7501v8?=
 =?us-ascii?Q?s1tvxDSb6gS0/E1lQ3JpYEsQxfSLz8tTeJ1W+4VRLveXo3NBZoVKdPpWyYVw?=
 =?us-ascii?Q?Zq5IEEikiiqLj/khtHmCWNvsLRkcw0KTf4NkYnQ2ST5UmZppWFpMpTXp9rBZ?=
 =?us-ascii?Q?8gBR4+YUnDsP6baRNZxMwKregfwmohN3DLg6bG84YjpHct+q2FfnYUw9+BMh?=
 =?us-ascii?Q?sk2qW9BkDqECEuTKU64xRZAYhnsFBs14jHslL6Rqy6AnenYrQiglLdsbDr2F?=
 =?us-ascii?Q?DNDP2EgaC+34YfbYdatXJrmj0CFEChXCeIhFI7nBWHbPN8muTs+7cZsEYKiT?=
 =?us-ascii?Q?VKCQVJR+aOIUJYqPPslHhvOFgBWhPV2Gpo6G7kZDsdGFuT/4AjJkPKf2FJb2?=
 =?us-ascii?Q?BIE1egEtM3AaK/wWU4ocVkMreWzRPHiKWfWoAaRnCG3TsygsZwxWUmoSosfZ?=
 =?us-ascii?Q?BlliYVbmaVXBZVdDACjzs/KeJK9IvFWUv4NfXrO5FU1XJDsmxqNDmm9Mb8Hy?=
 =?us-ascii?Q?m2GRb2EXPeKZDhGiY+aFspajcCgClGpIeeY3LfFkDTaNag7kcW/LKsnQDEci?=
 =?us-ascii?Q?ygRoRDyKcYP0yTbLc9TIQgh7MyJmsZq8jv3avlejDPzkVmPFSN8+DAanONFY?=
 =?us-ascii?Q?PS+jHkBSo1P4NYRIDgW7yPYxAUjjSkOnviioxkuCgiAhPrP5qkgBaryZdIGu?=
 =?us-ascii?Q?Pfl30xdX1idQqL+NUlN2pZkhlGmb9XX5qvk78E5wxYcKu6r8A+68DaIX6GfL?=
 =?us-ascii?Q?rl2zMhmAzxfJou7YlgwowD5y8K+7kqNRjo2hEImODqj8s1kOh/ntndTQXNKR?=
 =?us-ascii?Q?gvDPmtDA63vNyjbVm0wUaLTuL7ANxaz7rqKb5wgc5HI8WzATa4Js6fItFcFX?=
 =?us-ascii?Q?nBHqd6U+SrkvjitgxoUzyZMScoA+6LMVxZ+pk5bQ0Q6?=
X-Microsoft-Antispam-Message-Info: wNbCGHSbgMy+Ioz/u7igKDEtAnETO+p3HSQcrd+whkul921hmAfGnxd8Rtx4s88mWGwAw0hnkSyEPRDxkYTGaU5JU8vnryep2y/NjhaYo8ifqQAWtVbjVsJ03XH4nSSSC+a+jHSPfJAxpxC44Oau2B2nCdoqUiB6sgTaIRS8e62yiDIEsfkWUKaAlLomSvU3
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;6:Krag1a/qmNMY4XHo97lSkPbtvz/DoLVGZQ4WS413MVaQ4argDFOKiDg2cgFgorHN/u43INUhtbQSCNCLYnW4XtDDhB5A6JpAyyUiAM6qb/yQk0++heIusHSnFh0F63BhxhTANv1/XKZhfosTHUDASguWbcnIWtR1y7qH4/7YkmOPlhMScANVzP7XeNI4tq58f1iqaZCeIfjpwpU5YoYyeYRL1clGgnMnRAou7bT/+4ueirjXZmlLp4j0x7YHmrsU9FfXAUS79QFEYOw/tMfsdGCAno6IU4MMhEw3dZS1L4F7Dw/TbUfJneZHMGVDEXrQIvVHEPkZtWOSRdPSQRqIazROtl6Bbrvd/Cl2RboIruUn5Xvc+Ow4ALf1JMXFred0b1xPKHFAW8eEDCQ9y+GrAPmQh87y8jLIPNgBXfcubVyYQUqK7Lg64/K6cVUwBNgo8zohMCfKIiHl5+sCJxuXEQ==;5:GhYm1CFfF34ZGwQEyXmtvXleqbzoVuYADFpkS0KxBi95dymSukl4vJ3QP6A4cNriNN9CZ3jCE0Q8b3sfRaknsk3zMZkrg+k3fepF1/riSh5aJ5WuTpzeq44r24q6kcN4UoD/7XWtBCfQYyAbZnZBTremE4nnM+ZkpeHyO9uSgQk=;24:Q6iRD3HJZ1bB4mW9Y+B1L/pD1h1IJjNUtmgZP8SEq9l1XZwp7G5jJTFOGWKvK3Y7jrW/LgNYdY9cmrJS6ruPEdb2cn0ELXEJNzoRZpzMn/8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;7:ssicEJHld9gBgbc+K/gqti6s1GAaKzAz2IDX8FPzhecfd9ZXp4QSzPv+gbgBIj0uipAYzg+y2v82snQDCeBM+lEEdKK6huvPIn94Am6Rmrcxl/2iKJfJGg3fKCwT7oClQrpP1rj/5vgjWVva4I8ItaBdhkPA+v2sTFTdL3PqCOgDPd1drMsPGjlxKufeuLVb+9G0NC/Tmjr+c843zQuG5UWAzbFHKq4rf06vIv688TG2Y87M3nHqS1egWFwmq0cj;20:VedHcMmxuGk9lh5Y+nW8sPK05QPJDaL5WkHhDM3gi2dVP8+/GB0HL8qU4tDfkQprJUWT6F1tUMFjLSpTiqZs0V69JUkhDrSmO7C3lk0gEY4u9KIp1LEvObqP3CXvoKW6gf1ZiREG1aBJP1AO3DPcG93vOGh+dsX5J0yzSMlUHLE=
X-MS-Office365-Filtering-Correlation-Id: 1ee70b7e-f296-4e84-fad3-08d5b5d7c743
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 18:07:49.5228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee70b7e-f296-4e84-fad3-08d5b5d7c743
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:38:35PM -0400, Johannes Weiner wrote:
> On Thu, May 03, 2018 at 12:43:58PM +0100, Roman Gushchin wrote:
> > If a cgroup has no associated tasks, invoking the OOM killer
> > won't help release any memory, so respecting the memory.min
> > can lead to an infinite OOM loop or system stall.
> > 
> > Let's ignore memory.min of unpopulated cgroups.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I wouldn't mind merging this into the previous patch. It's fairly
> small, and there is no reason to introduce an infinite OOM loop
> scenario into the tree, even if it's just for one commit.

OK, makes sense.
Here is an updated version: I've merged two commits into one,
added a small note about empty cgroups to docs and rebased to mm.

Andrew, can you, please, pull this one?
Thank you!

--

>From 963b29d85a3c4624bc5fd167a645737c7cb54ed9 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 9 May 2018 18:43:34 +0100
Subject: [PATCH v4] mm: introduce memory.min

Memory controller implements the memory.low best-effort memory
protection mechanism, which works perfectly in many cases and
allows protecting working sets of important workloads from
sudden reclaim.

But its semantics has a significant limitation: it works
only as long as there is a supply of reclaimable memory.
This makes it pretty useless against any sort of slow memory
leaks or memory usage increases. This is especially true
for swapless systems. If swap is enabled, memory soft protection
effectively postpones problems, allowing a leaking application
to fill all swap area, which makes no sense.
The only effective way to guarantee the memory protection
in this case is to invoke the OOM killer.

It's possible to handle this case in userspace by reacting
on MEMCG_LOW events; but there is still a place for a fail-safe
in-kernel mechanism to provide stronger guarantees.

This patch introduces the memory.min interface for cgroup v2
memory controller. It works very similarly to memory.low
(sharing the same hierarchical behavior), except that it's
not disabled if there is no more reclaimable memory in the system.

If cgroup is not populated, its memory.min is ignored,
because otherwise even the OOM killer wouldn't be able
to reclaim the protected memory, and the system can stall.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/cgroup-v2.txt  |  27 +++++++++-
 include/linux/memcontrol.h   |  15 ++++--
 include/linux/page_counter.h |  11 +++-
 mm/memcontrol.c              | 118 ++++++++++++++++++++++++++++++++++---------
 mm/page_counter.c            |  63 ++++++++++++++++-------
 mm/vmscan.c                  |  18 ++++++-
 6 files changed, 202 insertions(+), 50 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 657fe1769c75..1764a627a120 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1002,6 +1002,29 @@ PAGE_SIZE multiple when read back.
 	The total amount of memory currently being used by the cgroup
 	and its descendants.
 
+  memory.min
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	Hard memory protection.  If the memory usage of a cgroup
+	is within its effective min boundary, the cgroup's memory
+	won't be reclaimed under any conditions. If there is no
+	unprotected reclaimable memory available, OOM killer
+	is invoked.
+
+	Effective low boundary is limited by memory.min values of
+	all ancestor cgroups. If there is memory.min overcommitment
+	(child cgroup or cgroups are requiring more protected memory
+	than parent will allow), then each child cgroup will get
+	the part of parent's protection proportional to its
+	actual memory usage below memory.min.
+
+	Putting more memory than generally available under this
+	protection is discouraged and may lead to constant OOMs.
+
+	If a memory cgroup is not populated with processes,
+	its memory.min is ignored.
+
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
@@ -1013,9 +1036,9 @@ PAGE_SIZE multiple when read back.
 
 	Effective low boundary is limited by memory.low values of
 	all ancestor cgroups. If there is memory.low overcommitment
-	(child cgroup or cgroups are requiring more protected memory,
+	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
-	the part of parent's protection proportional to the its
+	the part of parent's protection proportional to its
 	actual memory usage below memory.low.
 
 	Putting more memory than generally available under this
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 30d7b495b02d..c6d2ca859802 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -60,6 +60,12 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
+enum mem_cgroup_protection {
+	MEMCG_PROT_NONE,
+	MEMCG_PROT_LOW,
+	MEMCG_PROT_MIN,
+};
+
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	int priority;
@@ -298,7 +304,8 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
+enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
+						struct mem_cgroup *memcg);
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -776,10 +783,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 {
 }
 
-static inline bool mem_cgroup_low(struct mem_cgroup *root,
-				  struct mem_cgroup *memcg)
+static inline enum mem_cgroup_protection mem_cgroup_protected(
+	struct mem_cgroup *root, struct mem_cgroup *memcg)
 {
-	return false;
+	return MEMCG_PROT_NONE;
 }
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 7902a727d3b6..bab7e57f659b 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -8,10 +8,16 @@
 
 struct page_counter {
 	atomic_long_t usage;
-	unsigned long max;
+	unsigned long min;
 	unsigned long low;
+	unsigned long max;
 	struct page_counter *parent;
 
+	/* effective memory.min and memory.min usage tracking */
+	unsigned long emin;
+	atomic_long_t min_usage;
+	atomic_long_t children_min_usage;
+
 	/* effective memory.low and memory.low usage tracking */
 	unsigned long elow;
 	atomic_long_t low_usage;
@@ -47,8 +53,9 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     unsigned long nr_pages,
 			     struct page_counter **fail);
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb92c37c29d3..bdb8028c806c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4505,6 +4505,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock(&memcg->event_list_lock);
 
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
@@ -4559,6 +4560,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
@@ -5349,6 +5351,36 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static int memory_min_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+	unsigned long min = READ_ONCE(memcg->memory.min);
+
+	if (min == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t memory_min_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long min;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &min);
+	if (err)
+		return err;
+
+	page_counter_set_min(&memcg->memory, min);
+
+	return nbytes;
+}
+
 static int memory_low_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
@@ -5617,6 +5649,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_min_show,
+		.write = memory_min_write,
+	},
 	{
 		.name = "low",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5674,19 +5712,24 @@ struct cgroup_subsys memory_cgrp_subsys = {
 };
 
 /**
- * mem_cgroup_low - check if memory consumption is in the normal range
+ * mem_cgroup_protected - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
  *
- * Returns %true if memory consumption of @memcg is in the normal range.
+ * Returns one of the following:
+ *   MEMCG_PROT_NONE: cgroup memory is not protected
+ *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
+ *     an unprotected supply of reclaimable memory from other cgroups.
+ *   MEMCG_PROT_MIN: cgroup memory is protected
  *
- * @root is exclusive; it is never low when looked at directly
+ * @root is exclusive; it is never protected when looked at directly
  *
- * To provide a proper hierarchical behavior, effective memory.low value
- * is used.
+ * To provide a proper hierarchical behavior, effective memory.min/low values
+ * are used. Below is the description of how effective memory.low is calculated.
+ * Effective memory.min values is calculated in the same way.
  *
  * Effective memory.low is always equal or less than the original memory.low.
  * If there is no memory.low overcommittment (which is always true for
@@ -5731,51 +5774,78 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *     E/memory.current = 0
  *
  * These calculations require constant tracking of the actual low usages
- * (see propagate_low_usage()), as well as recursive calculation of
- * effective memory.low values. But as we do call mem_cgroup_low()
+ * (see propagate_protected_usage()), as well as recursive calculation of
+ * effective memory.low values. But as we do call mem_cgroup_protected()
  * path for each memory cgroup top-down from the reclaim,
  * it's possible to optimize this part, and save calculated elow
  * for next usage. This part is intentionally racy, but it's ok,
  * as memory.low is a best-effort mechanism.
  */
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
+enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
+						struct mem_cgroup *memcg)
 {
-	unsigned long usage, low_usage, siblings_low_usage;
-	unsigned long elow, parent_elow;
 	struct mem_cgroup *parent;
+	unsigned long emin, parent_emin;
+	unsigned long elow, parent_elow;
+	unsigned long usage;
 
 	if (mem_cgroup_disabled())
-		return false;
+		return MEMCG_PROT_NONE;
 
 	if (!root)
 		root = root_mem_cgroup;
 	if (memcg == root)
-		return false;
+		return MEMCG_PROT_NONE;
 
-	elow = memcg->memory.low;
 	usage = page_counter_read(&memcg->memory);
-	parent = parent_mem_cgroup(memcg);
+	if (!usage)
+		return MEMCG_PROT_NONE;
+
+	emin = memcg->memory.min;
+	elow = memcg->memory.low;
 
+	parent = parent_mem_cgroup(memcg);
 	if (parent == root)
 		goto exit;
 
+	parent_emin = READ_ONCE(parent->memory.emin);
+	emin = min(emin, parent_emin);
+	if (emin && parent_emin) {
+		unsigned long min_usage, siblings_min_usage;
+
+		min_usage = min(usage, memcg->memory.min);
+		siblings_min_usage = atomic_long_read(
+			&parent->memory.children_min_usage);
+
+		if (min_usage && siblings_min_usage)
+			emin = min(emin, parent_emin * min_usage /
+				   siblings_min_usage);
+	}
+
 	parent_elow = READ_ONCE(parent->memory.elow);
 	elow = min(elow, parent_elow);
+	if (elow && parent_elow) {
+		unsigned long low_usage, siblings_low_usage;
 
-	if (!elow || !parent_elow)
-		goto exit;
+		low_usage = min(usage, memcg->memory.low);
+		siblings_low_usage = atomic_long_read(
+			&parent->memory.children_low_usage);
 
-	low_usage = min(usage, memcg->memory.low);
-	siblings_low_usage = atomic_long_read(
-		&parent->memory.children_low_usage);
-
-	if (!low_usage || !siblings_low_usage)
-		goto exit;
+		if (low_usage && siblings_low_usage)
+			elow = min(elow, parent_elow * low_usage /
+				   siblings_low_usage);
+	}
 
-	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
 exit:
+	memcg->memory.emin = emin;
 	memcg->memory.elow = elow;
-	return usage && usage <= elow;
+
+	if (usage <= emin)
+		return MEMCG_PROT_MIN;
+	else if (usage <= elow)
+		return MEMCG_PROT_LOW;
+	else
+		return MEMCG_PROT_NONE;
 }
 
 /**
diff --git a/mm/page_counter.c b/mm/page_counter.c
index a5ff4cbc355a..de31470655f6 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,26 +13,38 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
-static void propagate_low_usage(struct page_counter *c, unsigned long usage)
+static void propagate_protected_usage(struct page_counter *c,
+				      unsigned long usage)
 {
-	unsigned long low_usage, old;
+	unsigned long protected, old_protected;
 	long delta;
 
 	if (!c->parent)
 		return;
 
-	if (!c->low && !atomic_long_read(&c->low_usage))
-		return;
+	if (c->min || atomic_long_read(&c->min_usage)) {
+		if (usage <= c->min)
+			protected = usage;
+		else
+			protected = 0;
+
+		old_protected = atomic_long_xchg(&c->min_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_min_usage);
+	}
 
-	if (usage <= c->low)
-		low_usage = usage;
-	else
-		low_usage = 0;
+	if (c->low || atomic_long_read(&c->low_usage)) {
+		if (usage <= c->low)
+			protected = usage;
+		else
+			protected = 0;
 
-	old = atomic_long_xchg(&c->low_usage, low_usage);
-	delta = low_usage - old;
-	if (delta)
-		atomic_long_add(delta, &c->parent->children_low_usage);
+		old_protected = atomic_long_xchg(&c->low_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_low_usage);
+	}
 }
 
 /**
@@ -45,7 +57,7 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 	long new;
 
 	new = atomic_long_sub_return(nr_pages, &counter->usage);
-	propagate_low_usage(counter, new);
+	propagate_protected_usage(counter, new);
 	/* More uncharges than charges? */
 	WARN_ON_ONCE(new < 0);
 }
@@ -65,7 +77,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
-		propagate_low_usage(counter, new);
+		propagate_protected_usage(counter, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -109,7 +121,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (new > c->max) {
 			atomic_long_sub(nr_pages, &c->usage);
-			propagate_low_usage(counter, new);
+			propagate_protected_usage(counter, new);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
@@ -118,7 +130,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
-		propagate_low_usage(counter, new);
+		propagate_protected_usage(counter, new);
 		/*
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
@@ -190,6 +202,23 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+/**
+ * page_counter_set_min - set the amount of protected memory
+ * @counter: counter
+ * @nr_pages: value to set
+ *
+ * The caller must serialize invocations on the same counter.
+ */
+void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	counter->min = nr_pages;
+
+	for (c = counter; c; c = c->parent)
+		propagate_protected_usage(c, atomic_long_read(&c->usage));
+}
+
 /**
  * page_counter_set_low - set the amount of protected memory
  * @counter: counter
@@ -204,7 +233,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 	counter->low = nr_pages;
 
 	for (c = counter; c; c = c->parent)
-		propagate_low_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage));
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10c8a38c5eef..50055d72f294 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2544,12 +2544,28 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			unsigned long reclaimed;
 			unsigned long scanned;
 
-			if (mem_cgroup_low(root, memcg)) {
+			switch (mem_cgroup_protected(root, memcg)) {
+			case MEMCG_PROT_MIN:
+				/*
+				 * Hard protection.
+				 * If there is no reclaimable memory, OOM.
+				 */
+				continue;
+			case MEMCG_PROT_LOW:
+				/*
+				 * Soft protection.
+				 * Respect the protection only as long as
+				 * there is an unprotected supply
+				 * of reclaimable memory from other cgroups.
+				 */
 				if (!sc->memcg_low_reclaim) {
 					sc->memcg_low_skipped = 1;
 					continue;
 				}
 				memcg_memory_event(memcg, MEMCG_LOW);
+				break;
+			case MEMCG_PROT_NONE:
+				break;
 			}
 
 			reclaimed = sc->nr_reclaimed;
-- 
2.14.3
