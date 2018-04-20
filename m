Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDTQhX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:37:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752689AbeDTQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:37:17 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] mm: introduce memory.min
Date: Fri, 20 Apr 2018 17:36:31 +0100
Message-ID: <20180420163632.3978-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:b8e3]
X-ClientProxiedBy: CWLP265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::22) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:1G1BK/tlhunTPXuhKdSbtfQal+I3L6RnbEEgLJniGGteDZejzKFRYdT4LjtImQWAoWMRA6tmmpNIRsRQ4tPQYF+DONEyTh7hPKS7JpV5PVKVxFN8pKB82gjKTatsOYo4/tH98T24Fqb6AyIbc/Qjk3vqss+02FLFC7jKFdCMeIg19r7u7cqISXtjR7h7RmddW3Rxs85MOVa3C+g63Da3UhNqQB/teaQfAAHb/ozk90XBptHl0YSDH4St5HA2x/+g;25:5BO8+66B5DSltBlOzvpLKxFdVo0wQ/mm5dmgyPuJlTWPAP6zwo872qKEe/hKnuG3aTUjezdwC41vDnwfccExBRAv7HiD4HFf+ppwT8XZ9s9xEguNG2/AUGA1jFw1p997yte9/rcXjlCv5dZPqSf3nIYiD+cznGEksQdNGIzwFO8tkIHRZU9bMYtuustq4gnKV7lX2wsNiwxHi1CxP+Swrdzf6EV1bXmxw0Zt5/viaJ2RVlaCO9SB3NppK1DuACGD1GDZjoOW//bbByVXs75+f36MFcAWQeZnjMa6nugMyKeHlc4HYEqOJcwZ3YCa47S2fkMHZasHtR+QEoPBIV/qkQ==;31:0m8QkQ2SeS1yxM2cZUow9T3Lqc3XBufhxzxiLSCDIGogU9NvkdBskgAvDzx86uESZjSlw7VmReLzHNuXJLUNb5Pht8HKlVeLPz+bkYwwCeT3JiTlwqqp+q43u+e7ZJ6MrFvbDsbRWk9GbqolHNfv/jOo1mCo6DGx78n6DsY/VdP9cd4jwdRVbT9UpsDOslR+pJZfLZ/mr0Ds2yTJeTHI3utxPN4TmNWEOKViA74UTZc=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:OVp7of32r51PP+UyqzciC7dLYCP+oQLZuar6z2PmrTiIvZ+lvCgZNCLs6o8m8gXSJtoO1BzSXnJTxqnDBnCGae1+7cGJnYyZlNUgT5Bv9Cv60mK+f21OQAqzRJpvNz/oJBRcac5Lxk68EkgqfZutb1KKE7s8YRSvFBGipvdQITrQr2YCN4cyJHlmDBiiBidViIjCXQvxk/IuJKznBlY3qPX5E6QsO74IfZSU5OBxM4KzavFfeb5Q2oygqcR7KI9CXrvGZwhE7zUdgxzDANc7vbmrcRvVdlfGCRWSi/AWyZ6NPJDNKU2Cs4FkGawkAOrYZWNd6DnuWvX1ykgaTQJnBi7IFE/1CYo1OOkY82skc4PkgDhGMsz/gwIZMlZzE3WvVmTfQXe7fXoNNqKqOE35QwfsV5aHw/tWD4kfI6E02ukdIB6QaagZJHH/PR3P7Oq8CnwIDzJcWpyBrBlaRV+EVEmkzBh/Ui+30t+L84n06YGt91+vd9m5iaVo/PLhzQRr;4:/wr+KBgX/+NokI0JCGK1Si/4NasNyNflfEp9t2Yrq8m+SBYOXyvQdCqrfEgGOMtCfH2zyY/M4y+BbflkS/lbtGb5whx2riSiEuNLnBtcmcXjlIEcskLx4EyoB+zpPfEUg+SIhziqO/x1hgOUJIJW70bNZisnmA0Kw1mGlf5ADnoVpYq95cS6hcR1W78Fxpac9K4x06dITdUWJclYEskY1lgWoOJXgKIqBkqGHo/v4qgjPWwSTsSy2JRdFk/8C3t7uQ4XklfXxnfHJPxgGF2iCYxbKxQdbBK8r2X4S4Qko/MAqbs2SInA92YaZHqV58we+jf7VqPAgn+FRc+DeMtvqEgPFlsINdCaijVMstSnlxM=
X-Microsoft-Antispam-PRVS: <CO1PR15MB10784546B7611C835806DC52BEB40@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501396)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(2351001)(2361001)(53936002)(47776003)(25786009)(8936002)(36756003)(476003)(81166006)(2616005)(6916009)(478600001)(52396003)(53416004)(46003)(8676002)(6506007)(386003)(51416003)(1076002)(52116002)(59450400001)(6486002)(305945005)(7736002)(6116002)(16586007)(39060400002)(54906003)(50226002)(4326008)(316002)(48376002)(6512007)(86362001)(50466002)(16526019)(186003)(6666003)(2906002)(5660300001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:MTiPdnnXxGwh3xdIlC8IHkfdCkqKz650a6f0J0Hre?=
 =?us-ascii?Q?u2+fCfg8ZAhQ514+l3XK6WSpeSsOOFi5pW6keeHcmAf6k3BpqyXdxqPCUuvJ?=
 =?us-ascii?Q?teZpwZDid/+ZF+Ykdct9m5cL9MBPpxekaDoUvDRy8dA5GYSUxdPnfxOv8i6t?=
 =?us-ascii?Q?9oR44WHf6dulnx+klha8xiogYv4Hd5t8iYlAyuGvhWVHqwQhdIPhJUo3hpHM?=
 =?us-ascii?Q?wmVfYxtfNSJujGC9pz0NH+LVms9lE1k7GgS66HNqS7INsU6LA65gWRSPILxs?=
 =?us-ascii?Q?r5lQy2smILMgvGYttgfajhERr5G8bodQz/GIyMmJxf7AKInl2Aryo/NxnOAo?=
 =?us-ascii?Q?ID4kdQpF1IZmcBDyxhwCV3Vc6/XhU8ZDHC7OzABh29FxolDJPZHOSXzVUXDK?=
 =?us-ascii?Q?8ZaLEKbj7fCL4xPwwBuRqGs4LVkQGenJSYBtT1g/r+r2mr2DnQdKip0lzKk5?=
 =?us-ascii?Q?dt19vP/S0kjiQx1zAYFXU8r6gOsOdG1kZpgloULWeOv8Q0tulQWZIoo5t91d?=
 =?us-ascii?Q?cvXC/L+eAnfyxPWsCQkOw6BrGU5Nxpjp/0gDPz2dA7btN+XLUtHaECqnmykd?=
 =?us-ascii?Q?HKNA908QPym4lmPL8xPxXO6f2FEZAwNkmzGeyo7+no4kB/2Kpya0UCJwIgw0?=
 =?us-ascii?Q?k9tUE8HFP0XTYX2262a4rpwrmHRmF7T6EjUmneviiITO4iJecPAGUP5CXJS+?=
 =?us-ascii?Q?YCfUUDJXMXoo6mgcquzan29YukDI+4qX0lOnTacfMPe/e82iP9j21OcX+8Wg?=
 =?us-ascii?Q?IdDHsDXD9KT4SL/o7er29fAxEwdJOcL1RxEw+rIY0TQfhunrmdwkwsk0oD+q?=
 =?us-ascii?Q?/Wh3CgjSeqR3kwRVyn18kaOuOqPt4trYoyFWaXlPVNiGBqMqxmyTY2R/wv7g?=
 =?us-ascii?Q?Y1bpDWuE9ZTnBgfXuIpV04vGN1JCvUcjmaw9vYm72ClovYbDY37sZ8+Sr7VM?=
 =?us-ascii?Q?oN6HztJnoLrTtaCiHefpEA4wEt2RCseUUt4FEaeuLNitf4yrA0KktY1ZnqbE?=
 =?us-ascii?Q?1ctcYrhTkDrTZltG3Ou+hSkJM1+Z9iLhums8l6uZ9bZDtqfdu7fiz+cKSo7Z?=
 =?us-ascii?Q?tgt6sAIEeqpbKP4JLUlROAvLLPLgdCu3TWgXYCpSs7RFrFBegijeG8tKRzMh?=
 =?us-ascii?Q?wPwLDVunnkyCVCTALD/cUALsrjCkuxWfA8hq44UbbD1uK+X3jfmzb5r2QvdT?=
 =?us-ascii?Q?5TIPRwLOJBndEFiPisCpiFy3q3rNwzdUxti?=
X-Microsoft-Antispam-Message-Info: kC/vzaiszcScTpywfNRZ3hbJnWrkk6BtElrJqnIXt44UEmz9+aorHA+bwXug/Fqk6Ay+njAeDM5B+6HwBZnPG0jkPjI2jjmtROB/ywcTk6Rqwqgb+HA3iiJ1DvpSvxna1ymKk+RHKY349Ef6s5nNeTr+KicF9Xm3InvQDFOW7ZhSlAxohVnWsb8D3fD1HqZ5
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:JjLi014sutu7NHGD4+2WvJEbSUdmT1ff/a0rQZXtM0kG5fluwwi7XWXEc03pPtUyhRhR7w2G8Y0IenuIWVDxs+p0QyzPF//EhOxkBqgP/vOwiJXJlG9oyhxkom6MGHtwg+s6LzLsjObFZqjoTh/PTgZpS+vTOVHNrVM5dieYgyuxVA9RS9UqbDQQ3eXL0I7v9ETliOFhfCvsR6p1uIfCKY688lbCnmy1JEpA2rvuaTigtL3x7aCgCKWxi4wAdel1f4gw6QucIP7Ol229GC+MDXBJ3SHOQN4TU8aDFyNcRmgx/kc9KwrdMYj0kNzhpxPR+TSroBsmgQtl52+j6xZ4WDJfC7xHJ5oBLKZBL4N+x/ozi/JA/pDmUNwuxCYsndNFKhQWf4el0/s1gtJyAoqtHkusYKnoQmUywGBsVeRmgbyrxwz6k6mMsGRSumUsnuD/r68elw97qBJQ7Jy2fukfDQ==;5:SPmYWo5/X6kwojYsOzmNiHAZNIJUJH4lwyOdboNpk2+OGmsgDZuuWuBP7EC1Q9ce/hyVb7Ps8Dmeh48POOGqPhgL+E3RNyyQUxvFEVT39yAkg59wDPfDs76sxhqToQh7yoxzd8alqe9p2zL86LC8DmupF1xQuhquHEySWGq/+Jo=;24:TnjvGt3Ua4WTBdrO3DLVYsbfJrezHmmtEhC1tILboo4BgaWY/mkUKvFKUk7Lwa1VOdKqXBH15bfGxo0gDy6ehWxmbBmWG3ZMajRC4NflCcA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:1NSIP7CbmfVWplCBJXj4Q6AMBVAxijc7KufMuGCnoUcdyVHm80CuxLhv6395G9a2hCUduEoWNPlNgo3afXvGGo3WTg2oE/r3JqOPIBYXHJFhqiopsiLjjrh4I6SufWhn0Ckxw6m097I3yAZTF7hYY/234lGOU9ilc9UEB9IHyQq5K3rD7qNWla1qJ/N+GLgmjv6WRU1nHAq9CsEbiBcoaRD8/I7wyrNi2NBzV67Xt8ZmytQpBCrHNBwMAuMm/5MT;20:Es13/05tfKJCRXROp2C93pleWuwDFlvlTAABS9eb7KSvOiKlPgO9+TXcgB8VDHdglL4fl9IDobaTiGZg0HlHD464iAVo9rli7opOYj5qt0YB8d/mes5WdiNzsLfFGfbw8LJ8hK9CSmzoRGYJBSXZoLdHx3H20Yxxp30h0RNwS48=
X-MS-Office365-Filtering-Correlation-Id: 4ff8f0ff-ae61-492b-c528-08d5a6dced6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:36:53.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff8f0ff-ae61-492b-c528-08d5a6dced6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 Documentation/cgroup-v2.txt  | 20 +++++++++
 include/linux/memcontrol.h   | 15 ++++++-
 include/linux/page_counter.h | 11 ++++-
 mm/memcontrol.c              | 99 ++++++++++++++++++++++++++++++++++++--------
 mm/page_counter.c            | 63 ++++++++++++++++++++--------
 mm/vmscan.c                  | 19 ++++++++-
 6 files changed, 189 insertions(+), 38 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 657fe1769c75..49c846020f96 100644
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
+	is within its effectife min boundary, the cgroup's memory
+	won't be reclaimed under any conditions. If there is no
+	unprotected reclaimable memory available, OOM killer
+	is invoked.
+
+	Effective low boundary is limited by memory.min values of
+	all ancestor cgroups. If there is memory.mn overcommitment
+	(child cgroup or cgroups are requiring more protected memory,
+	than parent will allow), then each child cgroup will get
+	the part of parent's protection proportional to the its
+	actual memory usage below memory.min.
+
+	Putting more memory than generally available under this
+	protection is discouraged and may lead to constant OOMs.
+
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
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
