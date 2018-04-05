Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDEOsW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:48:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751249AbeDEOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:48:18 -0400
Date: Thu, 5 Apr 2018 15:47:50 +0100
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Shaohua Li <shli@fb.com>,
        Rik van Riel <riel@surriel.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [RFC] mm: allow to decrease swap.max below actual swap usage
Message-ID: <20180405144744.GA15097@castle.DHCP.thefacebook.com>
References: <20180320223543.6188-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180320223543.6188-1-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:a21b]
X-ClientProxiedBy: AM5PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:203:69::26) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b523d519-ffb0-48e3-c2bb-08d59b043bab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:oacvFyjo2ukSk22SjPjamE2SvJ7hlVvAZVQ2Bvw8r/FHjOWyqQ/xbcSFBOHKsMQgP5lv0NeTy5MyoRPdsb/h48ZGcd6BQOWAOG71Q8/UDOFnjl29I7+PoiQSs9nPE+hFoulfPgRDHbkEsyKBsOmolf2U+xO5giIK4g/zb0j+ABx3aVvcvjOPGyoDZkzKmK3idt7hSaVr8Hf3o1aiF5buZSAZiI2MiHA3z7y193Djkl/bbbvUPN9/LOqb+9xERjqe;25:JvwaT9qL4utclRCQVLtVrfiqV53VmIuW3AlsmnYOmyGvvYpO8XV2y9ZMXJx+u33YlzwlB3KgKzJtjev/xnik/ibBvpnNGYbt2rpgj1Eb/PeKTzfhnGScpaamLQBWi0EzySRJV0Y/aG2rIUbYsVW9y1i+r1Hx43BK/oZLQn90FgmoiBoUgYUrMVb5QlPwjafw82x2xFUCjzpZY6oZYcqS60XJb6Ruhtc7/uUd59okbZo29jWBR0NnP53wAQvf8NRYy+1ZMW5onnti1v2LYu+JMaaM8C+zkkQf/q3r8hRnfaj0dBdiYZsBscvI/up0gLQkRZ6tHOULTM3wWsKKnXcXLg==;31:brFIlxo+0T5gvdypVtToQoKyrb4FFxYfcVhVgaaTO5fnCR6Ew6SPrm2fSk0HyKsiV27299exUv+6qNUNlPZWqS6i5CmmKhZfPbs8uEJcKz5ACaP2odf1r3xrv6ZastLUqNd1+XXuxtEdlFQ00r05OVBo0R3ndONxuRVKFOhh0iGZFaOWaJGu3E+ky+GHXjJm7ke9XooUI5/qrUtpODJ5HeWz54i0tO6UiHcUmF11rSM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:wnKJT2kMCxJxORUbzrwU9c5JGKFCv849ShuP8Ezqi5elUxEFaZIZRsSXndtWem2GEmtNHCYuKQSpegd2i1HKwOVn2lLmUgRSxeIDraWb52Wo+sxlU6v6LG8pi7j3v9f3QjgPGK8fAEWhrvVM1dU43NZq/4z6WJ+cdDnuMYc32NkkzBXsvHqoSs4BMBobT5eOHk8hUdbXJsVJ1PkKbPMy3OVkswzwEYotx+c0RX40SqKHfMVG0JC/Yp3nkFWinU4lXV7VD3/O6tBWfkSvit1UV1v0zHRQfODZWiKz2UDqBm0iLzi4XFRIp4VvtbW/IVYyGwyt+wlsircYg+3DG/+8+E8CgJO4mx7FmEYm1XGPEHaJ/8ZzDdEQZfshYfJF0vXi+BC2mL/QxXPDHA1upclcHjhY/zC3grq06beku8eqYazsS7+NE3ZlyL8kZ7PBaUeKt/zPyFTGUQEn/pswcS8cRDXDZmBIrnZj3ZganU8U0PNmFyGXCgy6bc4NWbVeC9rz;4:zupYhcRevr8M0MZWYz596n103BbRlhKjhuGYZuuyuc4z9DJh6/oaeY/sbt7gakm+D7ka3DLGcCbahLmWUJPYvRf26MziRVqSC/PDhY7cmgVCUaTqEYooAv77Q49az55MgoUpJsedj6edJLMy/Gdr2QnynZ/w9WedMb8UQgCTudRmahZcvVt+pcsZwe9SnkgixxFicOFPRnK3NcG0ZLm3eYyrHdJ8EOTmbfObh3ZiA+7t0xQpwV7Veh9CnKbLm6+iMQIcyCatScTb1k7NLzhD1RSjSkKbdvKq6mcYKP8qON0wbijkz+PqXJLCLpfZNhtIntOQL8ddFcOwM6BUjxodxFtg/hkFauCu8IAL6gx/NpQ=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077CFD14EA5E3847D05A477BEBB0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(59450400001)(68736007)(386003)(53546011)(6116002)(23726003)(1076002)(6506007)(54906003)(476003)(2906002)(486006)(316002)(11346002)(16586007)(58126008)(105586002)(305945005)(6916009)(446003)(5660300001)(6666003)(106356001)(7736002)(9686003)(86362001)(8936002)(97736004)(186003)(16526019)(53936002)(2361001)(6246003)(33656002)(7696005)(25786009)(52116002)(229853002)(478600001)(76176011)(55016002)(50466002)(52396003)(4326008)(47776003)(81166006)(81156014)(8676002)(46003)(2351001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:WqUAdLp75HEbhlMIqK7vl03gGxawZS//VOwGpS1s6?=
 =?us-ascii?Q?MQvY61Wr74NVZNwQ/DUIc2I0oSmp91XRonk0wPl4WtgWiQIa99cZySK9tR1Y?=
 =?us-ascii?Q?faAqe2lK5+DRzDbCBUUDB0PdFs+cy3J5C3QmtwRHRpRimChd+cdwx6o9JjpK?=
 =?us-ascii?Q?bquNXRtTiJSYb0kcBLfZGsHgpxA2A3RjxJSbRvs8q/6kkgz3UdhJgVpeAoHu?=
 =?us-ascii?Q?xavbTg7RVAcCum6sqzn4lo6zKF1W1qf5UWOZ6YyrRWSH3+jYct1DEjBPg/0/?=
 =?us-ascii?Q?q4qas2MFOpeZDPDw2MBWwNMhEWWekUQuYwPKOb/LFpA8AlNcbaDU59nvTpx3?=
 =?us-ascii?Q?HmoN25CY3yJioFDMImXGb5yf4M5nxF1HttkclZIMBb8o/NaeYQMQwdSYR+Yl?=
 =?us-ascii?Q?ilz4pIXPb0khuUzziUnRTKZ3elaZT98cFZdPoHjgPOcE2O+Vx9iTZQkMyCo0?=
 =?us-ascii?Q?STCBa8c3CgB08PEBAI96e9hvUbZDe5mU60bDcpGaR9twogxxXGL+ofiywDeN?=
 =?us-ascii?Q?Xe6H5ZSjhgoXnKiw9IIoJpnrT2Zx+Xtw5F/aPL9MGUm3c+glvkZYs2kFROi1?=
 =?us-ascii?Q?Zp9ESU6BhWwQqqGlhYGF+vez+xAQV3Tnyrw96Ywb6VHujYO4FrT7sKZswW6f?=
 =?us-ascii?Q?Nf8zc+YpPo+r5CWiUjGDhn+zUrAg20Pu6jnv68VS7yVvI1rk3SK9hTvMKSto?=
 =?us-ascii?Q?OH++qegBCEP3us4jwK4Qs6i9i6PvHotY1176sxEcrZiPHFieIhr7iS8rVM/n?=
 =?us-ascii?Q?/hhxu/8Rs038U5L4ZB7sH/PKEn589PlhOPWiC5u/y/onOgMWPweOr4SbmcZD?=
 =?us-ascii?Q?xc9/uYmshCD3JGeHJ1wOx37x9sbk2SKSyjWS+XFVoM14roWIf4DTorEU5jzI?=
 =?us-ascii?Q?SwuHQo1qhI135bhfZ14AJE29JCJ06uTF70C5ciEMsgeAaDvzRnbEEZpJWxMB?=
 =?us-ascii?Q?nDWOZvWbmJku6EolPHYTazbTpg0wg8wNLENyEwNNhXyMyl7vKTUhbM/zEuNE?=
 =?us-ascii?Q?GUuUMkLcnpsWW7XnjuKMAXVBXPbx1KJq7EvgblXKnFDARV75HkErrgzq5Vjk?=
 =?us-ascii?Q?6jPFRh0wgTl20iQsVvWOq1fmn4nIbBCbaWJ3qBlb1AktQyRdIb/ntvMmO0G8?=
 =?us-ascii?Q?fEaqnPlaInzmzuq+Sn+iPPcRAQJkpcAMg20Z6lnGMjT/spAvqFILNXz5SqPN?=
 =?us-ascii?Q?WBtt/volq51h7HUWuL9YtNaVz2zGmsSPIfFpbvFeSH04YRcWHgqQEGbpD+kx?=
 =?us-ascii?Q?5Z/gRDBAcV4VfFBxk5zl6p3oOdUmt5Q3Ayv+csFiA6sgOLOOYfijIxNrEtc0?=
 =?us-ascii?Q?aZPficdA4S7TO3r48vskLzJqjj3OkL3WQQEDjUSuXNR?=
X-Microsoft-Antispam-Message-Info: lRhB+Th/EmTSPLiT0CspF5QmILQor6aKOGto7/hm2HZS1IuhpZqgxzFefmOF20pClVu2Qu/yLCfoUJYi0nbsTptM5RjnxFA8ZNF1yb7M7lx4oNtqVZRmtm+bmRE33HKK1vMXKGDxO5O1Kj5AdWgq1dpfkTEPz9CQ0r2zQDQwSiMOYalPLwgFvNRj+kr7huIz
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:KGaiwz2w4umvkWEYJNp5JRD4iFqktcDxJ09Oh8N8mvv10AocUzwtJTq1tmirQBKjChz1JHSGnlmjaIDjQKKkLAToALvxFBxlLCiZqOLeu3dLurFnuKXQayMGz3eRgIYlLxXlDRX9i2h0A370/GKKPSUrnE0axcWYMgdmuy0LM6eEO0Y+FYdOze9t+AuOi8iie+bpq+05GnLKg8i5+GGEwk90bvNAcJ7lyaUdRR22/m9xPpx+Zb7zKB2BkwrDkeonn6s9iVuv08YV09Ixwc6+eSX3fSKvhInYdyXovxBNmk/BcezEctEOHZLC2UrHjQmnNJTcRGVtU5eqUqTwVwOphupfO5XNuu3NKoIxuqEWGLfiD9zZ6WR7qopUl3fUR1XWDS6HLekNy82Y/saFKPTuceTFmJt/c23WyYKrgdg08Cav+d4fb0sd+IjXFnA5kEqIju72iC7ZWerdcfsdnaqNWA==;5:+54IyYStpD/SiDERNCEj/hgMtvqYB9CFWAwcAAKRm2qXfJLWypxvkmKezS3Qovy7i+WXT7KBL5L+xS0v/0REMVHKmhGlyN/+bgSiZq3EazR9gWdt6abRyL4QtK2gAHq4UKtibarOBQ7mc0A7yn1GOl7yAMZNRNmSlEJB1dPVHJA=;24:HUnJpYo2kDTvSV+bIvlIvDnQF93QtgJgu0LG5Fj1o0g1Mkw6B1P+CfktiHR2QFJwMr3apLjeL6hxIFxxncvXriz60oNMyzeHAi9UPEIOLoM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:TgQk9y0Pk3gQ7Oek3fEKuxcRm9dvn3MR0rRndYl9If3EZvmC4BJ1MRyItJUcAZDylo0KD/gAXpDhlmix+651MulaeqM/oT02NuEft2d477H84CZET0GEWvF8aOg++1D6RFWr2pjg6TF5wC6beeOxpxDHhkx82yttCcZSBclpTEZ++ypG4hYIIktrL57F2PXHdTB/+Dd8mHMzxwY02uixz3F7eFQt+Ns2i3ZFX40JWrRAGKXLiwiq2WnEiZJgLDz2;20:EFuewMneZ390Y0tZmCDtXKvXgXbtbXSQFwgZBhFlKipyXdZuiVdscbROwtgzjC3bVHaG5vwW6dt9mn+q1tUNGRr33eFDv6KLimyirl/gqfWhoQTyr1AYT+jXoaBLCYGTBjspzEfFxu/nywqAXvFjfs8tlyveFeJefgFujapoeSc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 14:48:00.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b523d519-ffb0-48e3-c2bb-08d59b043bab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:35:43PM +0000, Roman Gushchin wrote:
> Currently an attempt to set swap.max into a value lower
> than the actual swap usage fails. And a user can't do much
> with it, except turning off swap globally (using swapoff).
> 
> This patch aims to fix this issue by allowing setting swap.max
> into any value (which corresponds to cgroup v2 API design),
> and schedule a background job to fit swap size into the new limit.
> 
> The following script can be used to test the memory.swap behavior:
>   #!/bin/bash
> 
>   mkdir -p /sys/fs/cgroup/test_swap
>   echo 100M > /sys/fs/cgroup/test_swap/memory.max
>   echo max > /sys/fs/cgroup/test_swap/memory.swap.max
> 
>   mkdir -p /sys/fs/cgroup/test_swap_2
>   echo 100M > /sys/fs/cgroup/test_swap_2/memory.max
>   echo max > /sys/fs/cgroup/test_swap_2/memory.swap.max
> 
>   echo $$ > /sys/fs/cgroup/test_swap/cgroup.procs
>   allocate 200M &
> 
>   echo $$ > /sys/fs/cgroup/test_swap_2/cgroup.procs
>   allocate 200M &
> 
>   sleep 2
> 
>   cat /sys/fs/cgroup/test_swap/memory.swap.current
>   cat /sys/fs/cgroup/test_swap_2/memory.swap.current
> 
>   echo max > /sys/fs/cgroup/test_swap/memory.max
>   echo 50M > /sys/fs/cgroup/test_swap/memory.swap.max
> 
>   sleep 10
> 
>   cat /sys/fs/cgroup/test_swap/memory.swap.current
>   cat /sys/fs/cgroup/test_swap_2/memory.swap.current
> 
>   pkill allocate
> 
> Original test results:
>   106024960
>   106348544
>   ./swap.sh: line 23: echo: write error: Device or resource busy
>   106024960
>   106348544
> 
> With this patch applied:
>   106045440
>   106352640
>   52428800
>   106201088

Any comments, thoughts, feedback?

Rebased version below.

---

>From a0811f1d094b3103e50c005586471afbe15e9113 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 5 Apr 2018 15:46:50 +0100
Subject: [PATCH v2] mm: allow to decrease swap.max below actual swap usage

Currently an attempt to set swap.max into a value lower
than the actual swap usage fails. And a user can't do much
with it, except turning off swap globally (using swapoff).

This patch aims to fix this issue by allowing setting swap.max
into any value (which corresponds to cgroup v2 API design),
and schedule a background job to fit swap size into the new limit.

The following script can be used to test the memory.swap behavior:
  #!/bin/bash

  mkdir -p /sys/fs/cgroup/test_swap
  echo 100M > /sys/fs/cgroup/test_swap/memory.max
  echo max > /sys/fs/cgroup/test_swap/memory.swap.max

  mkdir -p /sys/fs/cgroup/test_swap_2
  echo 100M > /sys/fs/cgroup/test_swap_2/memory.max
  echo max > /sys/fs/cgroup/test_swap_2/memory.swap.max

  echo $$ > /sys/fs/cgroup/test_swap/cgroup.procs
  allocate 200M &

  echo $$ > /sys/fs/cgroup/test_swap_2/cgroup.procs
  allocate 200M &

  sleep 2

  cat /sys/fs/cgroup/test_swap/memory.swap.current
  cat /sys/fs/cgroup/test_swap_2/memory.swap.current

  echo max > /sys/fs/cgroup/test_swap/memory.max
  echo 50M > /sys/fs/cgroup/test_swap/memory.swap.max

  sleep 10

  cat /sys/fs/cgroup/test_swap/memory.swap.current
  cat /sys/fs/cgroup/test_swap_2/memory.swap.current

  pkill allocate

Original test results:
  106024960
  106348544
  ./swap.sh: line 23: echo: write error: Device or resource busy
  106024960
  106348544

With this patch applied:
  106045440
  106352640
  52428800
  106201088

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h |  1 +
 include/linux/swap.h       |  9 +++++++
 include/linux/swapfile.h   |  3 ++-
 mm/frontswap.c             |  2 +-
 mm/memcontrol.c            | 27 +++++++++++++++----
 mm/swapfile.c              | 64 ++++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44422e1d3def..788e374274d3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -184,6 +184,7 @@ struct mem_cgroup {
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
+	struct work_struct swap_work;
 
 	unsigned long soft_limit;
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1985940af479..878f111d0603 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -650,6 +650,8 @@ extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
 extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct page *page);
+extern int mem_cgroup_shrink_swap(struct mem_cgroup *memcg,
+				  unsigned long nr_pages);
 #else
 static inline void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 {
@@ -675,6 +677,13 @@ static inline bool mem_cgroup_swap_full(struct page *page)
 {
 	return vm_swap_full();
 }
+
+static inline int mem_cgroup_shrink_swap(struct mem_cgroup *memcg,
+					 unsigned long nr_pages)
+{
+	return 0;
+}
+
 #endif
 
 #endif /* __KERNEL__*/
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 06bd7b096167..16844259e802 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,6 +9,7 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
-extern int try_to_unuse(unsigned int, bool, unsigned long);
+extern int try_to_unuse(unsigned int type, bool fronstswap,
+			unsigned long pages_to_unuse, struct mem_cgroup *memcg);
 
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/mm/frontswap.c b/mm/frontswap.c
index fec8b5044040..f7cb2e802fce 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -458,7 +458,7 @@ void frontswap_shrink(unsigned long target_pages)
 	ret = __frontswap_shrink(target_pages, &pages_to_unuse, &type);
 	spin_unlock(&swap_lock);
 	if (ret == 0)
-		try_to_unuse(type, true, pages_to_unuse);
+		try_to_unuse(type, true, pages_to_unuse, NULL);
 	return;
 }
 EXPORT_SYMBOL(frontswap_shrink);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18dda3f113bd..c1496453d3ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -60,6 +60,7 @@
 #include <linux/vmpressure.h>
 #include <linux/mm_inline.h>
 #include <linux/swap_cgroup.h>
+#include <linux/swapfile.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
 #include <linux/lockdep.h>
@@ -1870,6 +1871,23 @@ static void high_work_func(struct work_struct *work)
 	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
 }
 
+static void swap_work_func(struct work_struct *work)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = container_of(work, struct mem_cgroup, swap_work);
+
+	for (;;) {
+		unsigned long usage = page_counter_read(&memcg->swap);
+
+		if (usage <= memcg->swap.limit)
+			break;
+
+		if (mem_cgroup_shrink_swap(memcg, usage - memcg->swap.limit))
+			break;
+	}
+}
+
 /*
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
@@ -4391,6 +4409,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
+	INIT_WORK(&memcg->swap_work, swap_work_func);
 	memcg->last_scanned_node = MAX_NUMNODES;
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
@@ -4526,6 +4545,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
+	cancel_work_sync(&memcg->swap_work);
 	mem_cgroup_remove_from_trees(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
@@ -6408,11 +6428,8 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	mutex_lock(&memcg_limit_mutex);
-	err = page_counter_limit(&memcg->swap, max);
-	mutex_unlock(&memcg_limit_mutex);
-	if (err)
-		return err;
+	xchg(&memcg->swap.limit, max);
+	schedule_work(&memcg->swap_work);
 
 	return nbytes;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0b3674b1409a..1e7f9502e3cf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2093,11 +2093,11 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
  * and then search for the process using it.  All the necessary
  * page table adjustments can then be made atomically.
  *
- * if the boolean frontswap is true, only unuse pages_to_unuse pages;
- * pages_to_unuse==0 means all pages; ignored if frontswap is false
+ * Only unuse pages_to_unuse pages; pages_to_unuse==0 means all pages.
  */
 int try_to_unuse(unsigned int type, bool frontswap,
-		 unsigned long pages_to_unuse)
+		 unsigned long pages_to_unuse,
+		 struct mem_cgroup *memcg)
 {
 	struct swap_info_struct *si = swap_info[type];
 	struct mm_struct *start_mm;
@@ -2192,6 +2192,17 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		lock_page(page);
 		wait_on_page_writeback(page);
 
+		if (memcg && do_swap_account) {
+			swp_entry_t ent = { .val = page_private(page), };
+			unsigned short id = lookup_swap_cgroup_id(ent);
+
+			if (memcg != mem_cgroup_from_id(id)) {
+				unlock_page(page);
+				put_page(page);
+				continue;
+			}
+		}
+
 		/*
 		 * Remove all references to entry.
 		 */
@@ -2310,7 +2321,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		 * interactive performance.
 		 */
 		cond_resched();
-		if (frontswap && pages_to_unuse > 0) {
+		if (pages_to_unuse > 0) {
 			if (!--pages_to_unuse)
 				break;
 		}
@@ -2618,6 +2629,49 @@ bool has_usable_swap(void)
 	return ret;
 }
 
+int mem_cgroup_shrink_swap(struct mem_cgroup *memcg, unsigned long nr_pages)
+{
+	struct swap_info_struct *p = NULL;
+	unsigned long to_shrink;
+	int err;
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(p, &swap_active_head, list) {
+		if (!(p->flags & SWP_WRITEOK))
+			continue;
+
+		to_shrink = min(512UL, nr_pages);
+
+		del_from_avail_list(p);
+		spin_lock(&p->lock);
+		plist_del(&p->list, &swap_active_head);
+		p->flags &= ~SWP_WRITEOK;
+		spin_unlock(&p->lock);
+		spin_unlock(&swap_lock);
+
+		disable_swap_slots_cache_lock();
+
+		set_current_oom_origin();
+		err = try_to_unuse(p->type, false, to_shrink, memcg);
+		clear_current_oom_origin();
+
+		reinsert_swap_info(p);
+		reenable_swap_slots_cache_unlock();
+
+		if (err)
+			return err;
+
+		nr_pages -= to_shrink;
+		if (!nr_pages)
+			return err;
+
+		spin_lock(&swap_lock);
+	}
+	spin_unlock(&swap_lock);
+
+	return 0;
+}
+
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2693,7 +2747,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	disable_swap_slots_cache_lock();
 
 	set_current_oom_origin();
-	err = try_to_unuse(p->type, false, 0); /* force unuse all pages */
+	err = try_to_unuse(p->type, false, 0, NULL); /* force unuse all pages */
 	clear_current_oom_origin();
 
 	if (err) {
-- 
2.14.3
