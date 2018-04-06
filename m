Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeDFMWS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:22:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752114AbeDFMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:22:15 -0400
Date: Fri, 6 Apr 2018 13:21:38 +0100
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] mm: treat memory.low value inclusive
Message-ID: <20180406122132.GA7185@castle>
References: <20180405185921.4942-1-guro@fb.com>
 <20180405185921.4942-3-guro@fb.com>
 <20180405194526.GC27918@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180405194526.GC27918@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:20dc]
X-ClientProxiedBy: HE1PR05CA0301.eurprd05.prod.outlook.com
 (2603:10a6:7:93::32) To BL2PR15MB1074.namprd15.prod.outlook.com
 (2603:10b6:201:17::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1430ca-3355-4cb3-2035-08d59bb8ff4f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1074;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;3:aJtDxSaZ7P3Z5DFyyCaL0J/v0vQinKK66j2RyYLOS2mZEnWgnBiZVrPac4hSUcuw/WWD/NcHUPqz1k/j6J1UiWePl4sGH8MwI5ATsON3yYshQTyGGsYXvKuRk2ZlBp/4sCHSNrlnVu5SC4O1J5dhxX+Bsq262WotM3Z8biNFbKTi/8hENU3b5sGhv7xHJZCzq49THWPx42gRgmMSMrvx1eIe56wMizOX3rZrpwigy5YmdLa243mQ6GhJxpAsIWhO;25:Kr1Ibe8gi0/Qde6ro5lElqVQAn/UylcN5tjqZ0JgUle6i2m+82QV3nEsa9m2q9X8v/Kh64hdigLxm1JLyRDbRFYQB58UYZxiXkmQVL1dbDKRKWtmF8t0uS1NfDaC7WH40yjvHPz/QvthgCzYd2yhvwl48kZ5MM7jIJa7jJTI3ukBDGRqCB3cpLMVhylfPu42PYLh67SowdwPdSkI6WxqmU9c6U78SJlgPL29LctOdQfKG+jdtqUl8g7OhZwGA0/ettRFxMn6RrNKRW3D6LPWkYpY9kt2LnixE6lLjoXZCeflskRLLmszRuaANRKLKcjFO51GCE/NZiDKySICCsBi/g==;31:DjQ/BsmT8ZzMOZtud45XibLSvj5X0Svxr8rsgVSVp/e7F3NRu1bTP86t2xI2xd92a5iirKF99gMY146MC3mTfV3ENAUgjsPRZFK5pVweF5F8Pboirss+o/m7/p0OvqaeXkAxhvncPjuQqBh5rQYYbS36gOr+A9T0oCXAplIhRED6Kj96WQls9H3OFFpUUoELvo4Fj5u9/cXPrZhAVQ7MCNoj2kN3+9nztBZ9KpMBk5U=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1074:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;20:BjHBniM8WOsCu4ogOlw5u8oXxC1uLp76Ym8paEi4HX/MDBYLdfloiTZj2ccsk1A7U3iErZF54Wzol1kiHcRBBEAv3/lK9WL0dWehVF5wNKKSwDp4ZeJLo16Ff3OZcN0YM4qWWYdsvEEj3QEeNGN+Wd3qC1EiaWOVXZjlcnNiQCjF+aU/GRmbDvYadIsA8KGp9bW1I6QXg56eh74U9wBSubnBm2eh1Lpm1J7Te8uXSqFs/nS/Vhd389env4YJA8BgTThVwrWA29cQY7jLdyqDdLl02mH/3ZqQWm2p8A0utjJz0f9pAb3/CWVZh5Kn5oYg0j+o9++3QUYnc9fF9S/P0Q/D8uZUCetr7uP3Urqs2ORL+yj1cXowYW/GiOlufeI87r1JI0E0PgqLx5EHVtwNvD/Rioq441iKSYNHkD2sTriD2Lt5GRObn6rWnfeNDpAY3UUFOWuThadBLlJEf8NaO9Ne45qpTC7fs89uCw/z0nbfambaMafcCtNpUZd3Xlau;4:qH7KiBtjHK9yUA6OB6Qm/9L2qF7x2QIZZJufovBMJPmzv/MO7U4YbMxOptLnrwdG/ZiEH7I8f/WxBFVTEfqaNilgXKPEwCyAStwA5tyHSW6RKvIJWXHU0JKvfGjN4iDttgW42LSa82d7E+KgBUd2auKKw8HFGyZnECvXojSt89980xEEhw/WKCSFboOPyVPibvDVFe+NmoxOUdRyYPBVR+KUGcbxuphYOWvmGa0+XDyNhIMhVdpthoriY6sQIyzinbYUE+xZ6YNHx+KBiNyabICWXX9HJLVy7e6EPOk5YPm6YcqZKQS6245mKXg3EfdPCxZfB4mn+O5eFecZLYE3mOUdtB6KX55vMOfPv972zhiKQxCtQIwhv22mCKDOK2mQ
X-Microsoft-Antispam-PRVS: <BL2PR15MB107464BAE58B7BB76C9FA225BEBA0@BL2PR15MB1074.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(11241501184)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1074;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(39380400002)(366004)(199004)(189003)(11346002)(81156014)(2906002)(39060400002)(8676002)(476003)(106356001)(5660300001)(229853002)(6246003)(9686003)(8936002)(81166006)(33896004)(59450400001)(25786009)(386003)(105586002)(6916009)(52116002)(446003)(4326008)(68736007)(6666003)(55016002)(97736004)(76176011)(478600001)(33716001)(50466002)(16526019)(46003)(23726003)(86362001)(33656002)(7736002)(316002)(53936002)(52396003)(54906003)(16586007)(186003)(6116002)(58126008)(53546011)(305945005)(6496006)(1076002)(486006)(47776003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1074;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1074;23:rEjb0hbZL6uJmuJSXq7kmqc8wpxrG3QRWbOCfJGTQ?=
 =?us-ascii?Q?M0+xVbNPEBYkNq3xRaz8uKFCb9Uf8mXYvvRWRw68UTC0YhvFjRyUDOO9qxik?=
 =?us-ascii?Q?hZMc1UYxScJ0WMsJovYvnMK7JXCZ2X2p4fB7mgmKAg2W9KpF2C5+ZC5kqAd6?=
 =?us-ascii?Q?jVEMEBF4QvT3SvUF4LWEVgwizBmhcDC1+AyzaZIjMua3DniNIBUjePWMp8Ht?=
 =?us-ascii?Q?wbU36e2RtBOGGblwLWFCVm7UcMXBuLGiH1mO3/YTORlMeLyFftykU8gH11U5?=
 =?us-ascii?Q?NQsC2ktwJVOO9nzeGQPPANEiuXGN/TmC2NblyazKZOmhYlYOddt1hzQcjHIF?=
 =?us-ascii?Q?n9NXtG24eFRe00yvf1U6ceTxZngZPIo07IFMXQA4B4/LO3G5l1Jl6Rxjb99D?=
 =?us-ascii?Q?QMWK6uvuwYRs6laVJvZyog19VHr86ktuK7l/1uJTkgPpWx4zjJ81/j3ta/2O?=
 =?us-ascii?Q?aooTWQ1mCdiCc0j6QzqTQzTA/ESzheqPg+/9sSXPnMz7F2Oa5BP4/j4YcwIv?=
 =?us-ascii?Q?N+3ofaCZXqlTnM1OLyptd9abEGdPNPceAwCRa431AlD2yyz9N1RzeI2Gkb7X?=
 =?us-ascii?Q?98o/wjmLAFB5+xKnR6HSx4gJL70ka8Gzc1YR/0MD8IGPcQrn3eSWkJ+oP/96?=
 =?us-ascii?Q?wvtCAaof1En6nsNk1TNngcyM8mJYqe92GHvK7FqcELxPgZp6pBCm7lyGb3Wp?=
 =?us-ascii?Q?vFWUDPEvbsDmXuGRCk7PeVtg49fkrvA5rP3Nuxw5acrdGO8T3G7wk+RscMIK?=
 =?us-ascii?Q?trxxTlUpKxPV/67r7XM8lXTMqN7UNxeWavpHaCAsl20o8Bt3HKVQZe/BrpXa?=
 =?us-ascii?Q?017Uw0tPlta5oVYaCO7J3X6CdgeOldwzaUEGE7ICC1cSb/ytA30TGLYhXWAt?=
 =?us-ascii?Q?e7mmk/fNZNh+BnVubUNAe3Rit0XMOS7RsGr+4ZxfxtiqUIr+NvX88TX0z6a5?=
 =?us-ascii?Q?28FeCkhRw75r+6b55u+i5M9BUwKI3KEu5LWE0bNzLe6FEugQ2VKkMJulq87k?=
 =?us-ascii?Q?BNkxy+NN1PL7eZmYMB40uevVXeAXg+NzsRlS7m/zUJ1YWYCx/FzHmy4Ydpq6?=
 =?us-ascii?Q?gdnK8Kzg+fecQRp3e8dPbGJoKvPiEEir0tSKl+h953QMbBMdZe94xJRp7VhB?=
 =?us-ascii?Q?Bch8r420j23HFSwk19I11IjU5xJxmOMwS0QYIT8yQaK87OZOqA6/tnBCUfq5?=
 =?us-ascii?Q?a7qKmZCT6zeFLgSBKHEmY9kvmAHMZv0jwCM7UuYIdzRw7ovFv+vC1/0Zk9gx?=
 =?us-ascii?Q?RetBnpXtjtjG1CyWZj95V7CLVqcCODbfQM3GumZML4F/krsxmAQPa9ZMX09D?=
 =?us-ascii?Q?E5eIjUxFhWVixoWxZDWCQynLVyQwXFIMSfRmpJhlUEoXuv8+j4XU5gxazGIk?=
 =?us-ascii?Q?vUu6g=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3jqSy3XWRduaw1D5tQQM0yHLtkp7Yjo3JbPR6yGY9NO6yedeqBYhGdoylM2yoRL4B7kkkQJPAOkKgAuZQkBLw++FgymdpiC+nxZjO6P7FUWD/SBP064SuXA70blhbnmMP7VXrtrFdHOYZqUCX3vFVqjx7F1eauHNDDaeD7HeusNeKwdz/oSlPLCUAaMhimD0
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;6:jcVVEbIkJm16kICiPqN2LMZIUpslspqp7jAujIXLdNSIfBhT//ry76L2zFgwqV59nRbW31VgbXSQj8oadgK0AoevUnXFVGOVQoO72ztdovZbZML+iH1sfwcFjF+7scpZ4abCGG/ooEy2FCnOSTqjxTjYm2ejxxfr5Z9ifgaxCx6/rUMEvzppwWX6u0XsfbkzNYgvjaGfb4pkm6F2VaOev87Zt9z6fK5JEAm4UXmrdHANEyJXvs7Kt77L8qhKjfzWtJI+ifFd2c6ozjcUlQtly/a8rwOEiyzvrA9RWchR04Wg2mc7OAyG80qYFNuxNKiP6BvoAWP5lxb33K25TULx5lSZycrp7r38t0MOXyNlYHNYu6VL2W/fJIcOSa52bRnsxKFBGhx/bDI/zKxz0v3/E8p8K4Jl3MD0lI06ZPu394p0fiiph4UqQ9RW9teEmt1p8oFj3TAeVbewW5uF4n6FLg==;5:v+ecvvtukGwygBc9GJFRIsbv/w6GUOaUboAQ5fmm2TTg+/GcK3m5L0k953+VBjVb9Lw5FKMVAhykhu+q/nkCRMQylQQ0eZHoUsHXeOEYw3LilmgaZE3cARo/lZBXNbIwNOAGj9Uw28aI4Bv68mRdbEVElLNdBv17PwFLuYd+JmI=;24:F3nfkmAEKVbWlELBDO3ZPPlWV4FTDd/9Cb3HHCroncE/XYo4GJGDSHN0pZeaF9wVrygHFd1PI2vG99tExgOW9eU24AmV2ZXlQpeBEzCg42A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;7:F9DLu9DhMD1ZXr5IqER70ojsofcdtJIz/FUkvVCUeUqZrK0hDTVgsptKvLVF2WSpSNDidwFOoso39u3pCPIWK9BWBC+FUh70xhP5uS6dnsqK/D4XumkzgCYr5bKkoZtunRjYB9quEx80HVl2+MI8mRSIxETCL0pzqRvwEfmyC7rTHNs/jJwjw2Qw6n6vVh028hrRVbGuu4KL1bDkZCLUsduYEj2/JR50qHTciEMG+6Wrbt/Gi2uLKucXR+RDhPIm;20:VfMHAAQ/mJtmd43JsP9jk1vcPGq5fYZUSEPvkIyknw7S8c6u+aOsaB2BTJspwrbb+bCqDTeQyz+XkwDG5yk7CFlp3SIshcnoRYBoQEVbmQJZJ0x4zv1nULINWSTvp3AbYzctD2YZLBoXGu4OQRh9c4oA5RUDEBBc1WCzbHnqAh8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 12:21:58.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1430ca-3355-4cb3-2035-08d59bb8ff4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1074
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 03:45:26PM -0400, Johannes Weiner wrote:
> On Thu, Apr 05, 2018 at 07:59:20PM +0100, Roman Gushchin wrote:
> > If memcg's usage is equal to the memory.low value, avoid reclaiming
> > from this cgroup while there is a surplus of reclaimable memory.
> > 
> > This sounds more logical and also matches memory.high and memory.max
> > behavior: both are inclusive.
> 
> I was trying to figure out why we did it this way in the first place
> and found this patch:
> 
> commit 4e54dede38b45052a941bcf709f7d29f2e18174d
> Author: Michal Hocko <mhocko@suse.cz>
> Date:   Fri Feb 27 15:51:46 2015 -0800
> 
>     memcg: fix low limit calculation
>     
>     A memcg is considered low limited even when the current usage is equal to
>     the low limit.  This leads to interesting side effects e.g.
>     groups/hierarchies with no memory accounted are considered protected and
>     so the reclaim will emit MEMCG_LOW event when encountering them.
>     
>     Another and much bigger issue was reported by Joonsoo Kim.  He has hit a
>     NULL ptr dereference with the legacy cgroup API which even doesn't have
>     low limit exposed.  The limit is 0 by default but the initial check fails
>     for memcg with 0 consumption and parent_mem_cgroup() would return NULL if
>     use_hierarchy is 0 and so page_counter_read would try to dereference NULL.
>     
>     I suppose that the current implementation is just an overlook because the
>     documentation in Documentation/cgroups/unified-hierarchy.txt says:
>     
>       "The memory.low boundary on the other hand is a top-down allocated
>       reserve.  A cgroup enjoys reclaim protection when it and all its
>       ancestors are below their low boundaries"
>     
>     Fix the usage and the low limit comparision in mem_cgroup_low accordingly.
>     
> > @@ -5709,7 +5709,7 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
> >  	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
> >  exit:
> >  	memcg->memory.elow = elow;
> > -	return usage < elow;
> > +	return usage <= elow;
> 
> So I think this needs to be usage && usage <= elow to not emit
> MEMCG_LOW events in case usage == elow == 0.

Perfect catch! Thanks, Johannes!

Updated version below.

--

>From 466c35c36cae392cfee5e54a2884792972e789ee Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 5 Apr 2018 19:31:35 +0100
Subject: [PATCH v4 3/4] mm: treat memory.low value inclusive

If memcg's usage is equal to the memory.low value, avoid reclaiming
from this cgroup while there is a surplus of reclaimable memory.

This sounds more logical and also matches memory.high and memory.max
behavior: both are inclusive.

Empty cgroups are not considered protected, so MEMCG_LOW events
are not emitted for empty cgroups, if there is no more reclaimable
memory in the system.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 78cf21f2a943..3d039fa1a8f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5608,14 +5608,14 @@ struct cgroup_subsys memory_cgrp_subsys = {
 };
 
 /**
- * mem_cgroup_low - check if memory consumption is below the normal range
+ * mem_cgroup_low - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
  *
- * Returns %true if memory consumption of @memcg is below the normal range.
+ * Returns %true if memory consumption of @memcg is in the normal range.
  *
  * @root is exclusive; it is never low when looked at directly
  *
@@ -5709,7 +5709,7 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
 exit:
 	memcg->memory.elow = elow;
-	return usage < elow;
+	return usage && usage <= elow;
 }
 
 /**
-- 
2.14.3
