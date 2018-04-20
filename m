Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDTRV4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:21:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752456AbeDTRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:21:54 -0400
Date: Fri, 20 Apr 2018 18:20:45 +0100
From: Roman Gushchin <guro@fb.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce memory.min
Message-ID: <20180420172039.GA4965@castle.DHCP.thefacebook.com>
References: <20180420163632.3978-1-guro@fb.com>
 <527af98a-8d7f-42ab-9ba8-71444ef7e25f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <527af98a-8d7f-42ab-9ba8-71444ef7e25f@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:c4f7]
X-ClientProxiedBy: AM6PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:209:1::38) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:h6u7Z1MOmkYfATjfliSSqxqTQ2vKjPAzvGWxoaotmiO7Wa6HPD3CZlVIXGVZi24w1OPlVc1w7pQ9592ptqHufMl9FTQdpo5RmWrS2CTdCA3OQ2wMSBwBBy46c1ubGoG3U6nOKGxLy9ofZjwP8SE6gO2Glm9UaO9WLrBVqAePq+T6JKEeVc9cp2FJSJ5C8nudDxX5pr79L5gl2ahJ2te50osZWkmYDfy92VMcrzTt9il8lqrOLuJE/dm+0d6x6oqu;25:kvj2AKDm8/VxfIyb0lnTduJ3TVUZSpKusoSnLBYxTIXB+RbMqv3wIHR3lviTsVHbHMRIJvvDeddOZ5RZj3q01y9NlRE1iMf8S/IMcbsqlhOn0ZUgGilZBR6ToqVH9fhKZzxqNXKl4uCHsF3JeR/RcxVZ9lvFcIm/f+ZoNxbqesnxIt8vRRU/KpnPE0fVcffHchfnfSsf+Nlg5/bY5xsvSUaUiSP2PRIPX2QrLTCjpsZjP5n00VZGaJ8WHq/uPhVI7ald6i4bBOVi61k/cat2rDrk+YzS9QAYmXUi3V917K0UeZiGI/0WaOazcV6Qv5GQhryjdguZFt2R0NkC4lYEoQ==;31:DTicwE+vVFvPbySvjlpSbNKpRXVU1/4b6GWj+fsgjTWg+byaOhpMaMrDWAhVC0w96w4RWlbtpJ7HraBza6bUDOc4RiKrNRKiDbx4QDVtsOwcPcqKwAt+nn35c0nuohSo0k+N18BAoUyHaShqKQ78Tvu7KS/NMnpopF/Eq+VJMK+E/R2YZc/nZM11efOT/ZH2DK03HbQJUSU6am2j9dYnyr9szZaruZkZLd9Jcj1YfZU=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:WOPryLIiSPMc1Q35ON1kau7UQPXHnxP1XTzXMO09UKxSPyE+s6ysMSgl+ht3xyozPUd7g1sP5LxCsmVJM3KB33n1XdE4TnDsDJbRj3QOy+Tn5IL6w6BTUfBCC8VNfBUwlMhp104uFe96hxVz7P0yfEgJ8dXjLAiWf4dNhRSBuSCKtlZASqFypTuOOR8iZoRq4s97l44yED9uMcITQNta/JfLNjdl17cpyWnN9ocYtn26S+QvImhwR353gi29+KPlqfxJSa+Hqx0lbGGXqtJda9fpEfqc0CZ48tnW/xyG5JpG7cSiOMc7/92mgy9kDjeW+2ULYMHZPAIO1TLkcW5awspgWyFQ6GXJ7YVZAPoPjS7RtCbtcK8o03w8QVI7zLfprbZSNe7wGcyVq6CS5RAk/c2eLeSYXVrBMqGWKSN15i6GtMLB607lHBa0XgaAKYe5h+ZDUosy7s20QtHzRng4ZJqRrz6h2SE/1Fs8jke0i1fkSLiL6v2Rmuo7txSYKFLZ;4:O3OHZZJ8RgHwhM6Q2XduK/r07Fd/aXoJ+D0bx2HO8vKTa7yDyhlaYseh7qnRFeraAs1I78fQMu4usohMRNqmL9G41GJBkBNYw7E/vZ9XvP5L4ar6zQ1MaRPRRWV9jSEz5BlZSD9IpekEcKHfTbVRNXyn+SQfS0PKyCGkT/N9J1cNDKtr2bEyU+1UaYA1MdVUtcB6hDsRj3ZjpS4+K+rs4EDIeKV3cxp4vnwYJmnRduaBeqKJU+LCz/MPIacS51SsBsK2kEnc0tI/CL0jTRjL4YmbhGfOT12zt9/8ac0rZ7lvm/7S8Kqjnwrm1+M4cMJy7H/CWxl+NFqdodqf+i2BKhoOci2sahTjkcmkdfqLMcA=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076B4FE2478444BB381A046BEB40@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(11241501184)(944501396)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(53936002)(11346002)(7736002)(316002)(476003)(50466002)(52396003)(305945005)(54906003)(58126008)(55016002)(2906002)(16586007)(81166006)(8676002)(229853002)(33656002)(7696005)(446003)(76176011)(6246003)(52116002)(9686003)(6116002)(478600001)(46003)(6506007)(386003)(1076002)(8936002)(5660300001)(59450400001)(16526019)(4326008)(39060400002)(186003)(25786009)(23726003)(6666003)(575784001)(53546011)(6916009)(47776003)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:PNjmh95CRYFKDZdKfMh+M0CXvTOhNe84RNE/V3mZc?=
 =?us-ascii?Q?vv0TNcw+k+zXqsTWTdh24UdRKE+31UyEKf+yZbs6BfGFx0W1sXKyOL8ACYkd?=
 =?us-ascii?Q?OKCjajlX08xz9DQ8mIiVyLBGHxuLk0o2Suc8nBG+CXrw09+WGGlByYTtKThU?=
 =?us-ascii?Q?q6RwdRmPuaSTjNRBXSO+kbwLpeEO5Btsl7AQfRbglWwzBe9x080dEgloZM+T?=
 =?us-ascii?Q?VI0ECtLB4ifWC0Vv0u1355lXCULzVhQD6e/ko50Q5CnGE7HsbyRy9A/SdiUZ?=
 =?us-ascii?Q?s8pit1R2yRKRFMj7CbOfiluH88nuW5FWUMnclUlHmkRudWGYaARRHiKbid21?=
 =?us-ascii?Q?rmoWHd/QuHZe6YCU1QMKWKiclne3dINgnyM1gNzvhb1EkGO+QHXAjNQmfFgP?=
 =?us-ascii?Q?5AB2LjZJ1h+ttLJhqx64l18ZQqdVUtNUek9MRO1HWQaNmLv1r3vmAbi3oJT+?=
 =?us-ascii?Q?hrgq1BJ39I4hcw1nT/dRmiwqyVdUlU/bivAHsDGliFqwDZhZxRlOpkl0E3XC?=
 =?us-ascii?Q?+3oNiBctLW4p1XbD+82OdVjsLl8ArUeNUD4Gy4LRl//B9IHkUm0Oy05zcfrw?=
 =?us-ascii?Q?kdnpPN+O6/syo0JK3pPJ8BfDQDIMM4S0bbr2MCLprp8xgu/tDQ6dDlwP1GqS?=
 =?us-ascii?Q?agmvYDvDNsWg3mha/BCr143T64db7QxTSFgW4AoVTtYEW8SgbCULBqytIgUR?=
 =?us-ascii?Q?LZUckuL+ORRunE76Ei9RYV8XuqB64eNEKN/sKYFvRjS4+OsWHDEUTNNrzVy6?=
 =?us-ascii?Q?FglyaGnqdcR2DZEYG2zgK07baE6dFI9jr53Uo/uqrjjSP2Xi58bK3uiAR30u?=
 =?us-ascii?Q?DUN3zutkq5wxwUyHlu39zqnbFCJeTMcG+iDCcOSZ4iiXtv+HquIhSrUWLuIe?=
 =?us-ascii?Q?kDbfqH29+Ouhyuq1U3YqvKlKyEEkKkHZV/HU9HgkQstb1RdlUPdfB8jnwIGn?=
 =?us-ascii?Q?H90P82Mqk1HqjXqG0dI8qMaMvv8OolgU0+fRnPOoMqHdgAUVz0iwFCZpkQIo?=
 =?us-ascii?Q?69S8rhZmOBUCk1QgIElcXpVdP6Gmn5o1CvkM43VAh/KBFQKx/z5TJ/Dt0ynj?=
 =?us-ascii?Q?y9HkILX6RqukIBimcMqNid/H7Ewfi0fWF+N/ldt281YmHW1NTj3g55SdpGRP?=
 =?us-ascii?Q?T98J46ZPFDAwEsU/0+JiKyFpn2EKNywpg9Iz/i1oiUwrkVPeTSQrjiIFN+0l?=
 =?us-ascii?Q?sKE7CQPFVoihGikt+LrqZ0O18TByJq5um6T?=
X-Microsoft-Antispam-Message-Info: +hFgsuZ2/JrZ62zL4H/whCnflROuySk7OxxNCpmKndHEo+C0qTxkVpX6Yf+YXwDhmUSScn7wN/eUhYWl1PqUHQ4cvwm7W4KQFdqBlwSmeR7SxoSLL2lXlDv3GCV2kLO9+JyKzJGNSIExySZR2unVE1YQzjKpoPXn+0IPKEqNXHVTDsyuFN5tqMls27PCyn9q
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:47AJV4xAM9C7M2qdhzZXtqm/5n5elcoxEMktNeOliPAIIAQpW2+XZtJWC6oIEYu3eU0D+vc0YFDEX7l0rElP9U78RDI5bTp59sycq1Heju49Bks82iuDmHAZOupg6ylO4VTlt0XjKkwHEKfx+9umir5rR6OqnseShAlkXp0vt4NWwJVmSCtWgZuTzHXs0/BdBeIGzXSvIjtWLcLUgM8/IFebOLZ5G3lgF+n3927ZF0eSpLlqGKo6l+DbXXPN6V88pOhmz4VCDgNGArewm/i1PYPvd+X3GzZGT3pEwzJq603JVOmxKf3Xqd3LuMAijGIQuAuJi6nd6JITfEXUWqWmoTZwFg9L/gwLriDs2XWyAnUe79U4yM/CicCSk4zgCqc1wjI+1nwTwIhJSlhfelA7eTs5jZK1G9twwnkfAzSoTQizrN3paOB3tFMoIfmc5qZ2klhyIMtIpF/zBaOP8851eQ==;5:PW4x+ZjAZbTE5WwmYkpEQspKEeDAk8giepKL1owQAPOhAgzn9by1rt1yGhRwHCeFTXMruxrjYQmYhTp8uullmzOFCaaNj2y0Rp6W/vlVE7lrFOBFEU/qoilSgkp6DnBVsrVdVpvx1QoisrMLJajJAkG56qIKuNFTRcjpVG2Ymy8=;24:PYxO7dtHtiYTTyqgzSoKYJmm/p8pFKL/w9YBze93XUoxDbGahAMxz07gQ1I+UYW3IT7idxnhQ8OdkvAgH141NzIcqiLKCQTkX2RW6otanGQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:6QoXQ2TcU0uB5GvHpLAAeANb/BBu3lVbIJ5UHtgUsez4Bzn4xxIBPOFmSi3OWBBW4EOc8WXQISdWU8c5a9/z5B5QuKjrLBOXhklcQxATTdnmvdnnvL0Zu46PIivkYponzrIggxdmlDfZjZvES5ushmy79d9OrffzoyX9V1s1uxDKYGQVf2CrTqHQlCpUQ1FyDPD0eQIwZYzezinxsadVxwEb08lDxcEP1kVw09R/ItnbK3Fz3jBowILf05qPqslw;20:jXa2iBbfRPGJMtyVzWChyhxY5RamI4g5+vytLQBPmFE2a9XPiNsi3jbDTrdEL/cXHvb08ZdU2xkd9/0hbycKbDuRf+kQvwn88xedPCDONfar6RUER0IxHw/JxbSwPnhJp6+fOuBuzKmp5Gz+GXCAspjajPUBIuJrfaAjA/B4Z3I=
X-MS-Office365-Filtering-Correlation-Id: c39c3c25-c914-48b2-525d-08d5a6e31496
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 17:20:56.2935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39c3c25-c914-48b2-525d-08d5a6e31496
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 10:01:04AM -0700, Randy Dunlap wrote:
> On 04/20/18 09:36, Roman Gushchin wrote:
> 
> > ---
> >  Documentation/cgroup-v2.txt  | 20 +++++++++
> >  include/linux/memcontrol.h   | 15 ++++++-
> >  include/linux/page_counter.h | 11 ++++-
> >  mm/memcontrol.c              | 99 ++++++++++++++++++++++++++++++++++++--------
> >  mm/page_counter.c            | 63 ++++++++++++++++++++--------
> >  mm/vmscan.c                  | 19 ++++++++-
> >  6 files changed, 189 insertions(+), 38 deletions(-)
> > 
> > diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> > index 657fe1769c75..49c846020f96 100644
> > --- a/Documentation/cgroup-v2.txt
> > +++ b/Documentation/cgroup-v2.txt
> > @@ -1002,6 +1002,26 @@ PAGE_SIZE multiple when read back.
> >  	The total amount of memory currently being used by the cgroup
> >  	and its descendants.
> >  
> > +  memory.min
> > +	A read-write single value file which exists on non-root
> > +	cgroups.  The default is "0".
> > +
> > +	Hard memory protection.  If the memory usage of a cgroup
> > +	is within its effectife min boundary, the cgroup's memory
> 
> 	              effective
> 
> > +	won't be reclaimed under any conditions. If there is no
> > +	unprotected reclaimable memory available, OOM killer
> > +	is invoked.
> > +
> > +	Effective low boundary is limited by memory.min values of
> > +	all ancestor cgroups. If there is memory.mn overcommitment
> 
> 	                                  memory.min ? overcommit
> 
> > +	(child cgroup or cgroups are requiring more protected memory,
> 
> 	                                          drop ending ','  ^^
> 
> > +	than parent will allow), then each child cgroup will get
> > +	the part of parent's protection proportional to the its
> 
> 	                                             to its
> 
> > +	actual memory usage below memory.min.
> > +
> > +	Putting more memory than generally available under this
> > +	protection is discouraged and may lead to constant OOMs.
> > +
> >    memory.low
> >  	A read-write single value file which exists on non-root
> >  	cgroups.  The default is "0".
> 
> 
> -- 
> ~Randy


Hi, Randy!

An updated version below.

Thanks!

------------------------------------------------------------


>From 2225fa0b3400431dd803f206b20a9344f0dfcd0a Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Fri, 20 Apr 2018 15:24:44 +0100
Subject: [PATCH 1/2] mm: introduce memory.min

Memory controller implements the memory.low best-effort memory
protection mechanism, which works perfectly in many cases and
allows protecting working sets of important workloads from
sudden reclaim.

But it's semantics has a significant limitation: it works
only until there is a supply of reclaimable memory.
This makes it pretty useless against any sort of slow memory
leaks or memory usage increases. This is especially true
for swapless systems. If swap is enabled, memory soft protection
effectively postpones problems, allowing a leaking application
to fill all swap area, which makes no sense.
The only effective way to guarantee the memory protection
in this case is to invoke the OOM killer.

This patch introduces the memory.min interface for cgroup v2
memory controller. It works very similarly to memory.low
(sharing the same hierarchical behavior), except that it's
not disabled if there is no more reclaimable memory in the system.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/cgroup-v2.txt  | 24 ++++++++++-
 include/linux/memcontrol.h   | 15 ++++++-
 include/linux/page_counter.h | 11 ++++-
 mm/memcontrol.c              | 99 ++++++++++++++++++++++++++++++++++++--------
 mm/page_counter.c            | 63 ++++++++++++++++++++--------
 mm/vmscan.c                  | 19 ++++++++-
 6 files changed, 191 insertions(+), 40 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 657fe1769c75..a413118b9c29 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1002,6 +1002,26 @@ PAGE_SIZE multiple when read back.
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
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
@@ -1013,9 +1033,9 @@ PAGE_SIZE multiple when read back.
 
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
index ab60ff55bdb3..6ee19532f567 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -297,7 +297,14 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
+enum mem_cgroup_protection {
+	MEM_CGROUP_UNPROTECTED,
+	MEM_CGROUP_PROTECTED_LOW,
+	MEM_CGROUP_PROTECTED_MIN,
+};
+
+enum mem_cgroup_protection
+mem_cgroup_protected(struct mem_cgroup *root, struct mem_cgroup *memcg);
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -756,6 +763,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
 {
 }
 
+static inline bool mem_cgroup_min(struct mem_cgroup *root,
+				  struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_low(struct mem_cgroup *root,
 				  struct mem_cgroup *memcg)
 {
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
index 25b148c2d222..9c65de7937d0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4508,6 +4508,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock(&memcg->event_list_lock);
 
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
@@ -4562,6 +4563,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
@@ -5299,6 +5301,36 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
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
@@ -5566,6 +5598,12 @@ static struct cftype memory_files[] = {
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
@@ -5685,44 +5723,71 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * for next usage. This part is intentionally racy, but it's ok,
  * as memory.low is a best-effort mechanism.
  */
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
+enum mem_cgroup_protection
+mem_cgroup_protected(struct mem_cgroup *root, struct mem_cgroup *memcg)
 {
-	unsigned long usage, low_usage, siblings_low_usage;
-	unsigned long elow, parent_elow;
 	struct mem_cgroup *parent;
+	unsigned long emin, parent_emin;
+	unsigned long elow, parent_elow;
+	unsigned long usage;
 
 	if (mem_cgroup_disabled())
-		return false;
+		return MEM_CGROUP_UNPROTECTED;
 
 	if (!root)
 		root = root_mem_cgroup;
 	if (memcg == root)
-		return false;
+		return MEM_CGROUP_UNPROTECTED;
 
-	elow = memcg->memory.low;
 	usage = page_counter_read(&memcg->memory);
-	parent = parent_mem_cgroup(memcg);
+	if (!usage)
+		return MEM_CGROUP_UNPROTECTED;
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
+		return MEM_CGROUP_PROTECTED_MIN;
+	else if (usage <= elow)
+		return MEM_CGROUP_PROTECTED_LOW;
+	else
+		return MEM_CGROUP_UNPROTECTED;
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
index 8b920ce3ae02..39ef143cf781 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2525,12 +2525,29 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			unsigned long reclaimed;
 			unsigned long scanned;
 
-			if (mem_cgroup_low(root, memcg)) {
+			switch (mem_cgroup_protected(root, memcg)) {
+			case MEM_CGROUP_PROTECTED_MIN:
+				/*
+				 * Hard protection.
+				 * If there is no reclaimable memory, OOM.
+				 */
+				continue;
+
+			case MEM_CGROUP_PROTECTED_LOW:
+				/*
+				 * Soft protection.
+				 * Respect the protection only until there is
+				 * a supply of reclaimable memory.
+				 */
 				if (!sc->memcg_low_reclaim) {
 					sc->memcg_low_skipped = 1;
 					continue;
 				}
 				memcg_memory_event(memcg, MEMCG_LOW);
+				break;
+
+			case MEM_CGROUP_UNPROTECTED:
+				break;
 			}
 
 			reclaimed = sc->nr_reclaimed;
-- 
2.14.3
