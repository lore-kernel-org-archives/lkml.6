Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeEVKJg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:09:36 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:62231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751161AbeEVKJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 12/17] mm: Export mem_cgroup_is_root()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:09:23 +0300
Message-ID: <152698376317.3393.15242457477338422253.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:209:1::37) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:azb+Hkfc8KQ1ZZJEg4MbgbziOmgsAEw/KRIjjugDsfZCa9bnzF2R46mUazxKNLavM+j8vNsQWtaFTVD9/hLC58hax6efvvo+EOrY/O8fAdosTKBPp+tnBYo+LF73VAiiXPW9wUaYkzzFPG3F4tAnhOngAtE0o/ZVVeJqTEWljm1kuVybIeN+PHbrZdDQ6T75QmbO9gJEkFWYnmiOPPTQviOTw1pqN4iLH7pzqCtOc5CbjI5WQnPXRDBoQxkG+ITi;25:69Xd2NyLtnbCUkKWEr3l3aYhB74NcorKeoCY6OpwIyknY9lGJUnYtvz+wwg4v7W47LkINj6ET1HlkDwRTRj1U/fOLFBRZfGPldOTlvwo3JFWuc6qQZnuqjJOzB/8nPd5pGpbnUM7YEDVWbW9myEEBcbdSGJ+JNHPCpUTqPy29o8txM3E6dd+wMutjQrZfC0inxsZ0ora21Fa83kCp6NMp+4HusEvDl5AFBoyAJ5WqK9RO0r4YRDp6UHxEzbEyyzsHw5yir2I6osmL38QfU2cu7PmWCMXWDJ8tQtp5xsVtHcnwfFBQbFV8zyawoAKJQlpY1Tt96lFJ4UUQLvOBUbs1g==;31:5DM6Bh7pnKxxdtWs+wFT+9ZmIwLmod5bx0mr5t61CGSP5g6+c+mAj0tpl7hz6uAKv5X/ZRHKjwQ71FmZdRfavSA6b4CltQLwLFm01OiU3Z1nTyp4VB3nFhdIxbH9/iOs7RlXha0vh/b8dLmWOtXj0k6ooMFTnGcUVo0vfzKbkcfZ7yweh1+M+kqCJlRZTSt/VqzAGzuY5lGuv8Tnnc/TUY9bvM8r7rEA3ZyzQYAYwPI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:EJP9XvxykgDtjlWOM/Edept/Xg4lSERppqxSG2FoVY3ALty1p7kwMJy0vfZWt9IOwJk/ROUxYIPmH3nl1ipCdakkKjI+gB4bjtyVenU94aqWqRWdWm59UP6H11Ec80HZioL8Z+sdB/+sNJ0l/Zr8QzSs2pRQhvns9ydOd9UPzbFOJPb7q/qNgCxoqKKz97tDnav9WZuDwCazQfjyZN0PUK+kfLoAFIEztTt5oqHGrSxMqhK+SMIn+PKLq3TpXAlxudI/0AOcFoHDQH/IdunOCRKGKygRFd4pXWnSsycrgLvJ507TNaPLmhZClkPQdT+kQFGYt03DGJQzXHdNwANOPJ2EJYl5/Hn5JW87olg5Y28eLc4Ej5QeO0Ap46iQTKW3F7vLomXmyNByEFM8vLS7hBmFcCtjU6ZCfL/lMcvGAz6E4lET9gQQt7A9sp0p+1Eu8i/JPF2th8ufk7eE9vQiQFjseZDdni3cYyezIIRTwnvdDfI9xjHYKK0knB8pSwkQ;4:VSC0u0n0tratmJ3MqSdzrxy+T3Add8rVYmsm4uaUumpTyGLO15dpHPlUIJOwuf26RiPZwWjxq19G2YlDoDdPML+gk1oUKXdUJo6DYxT4dXdJowpaaTjJTohJEr1FVmcKFrvgLJohQ8islMqJ5o+p1JC4ZHFyrZWZmOH2X7ANU1ZHbimSVkm1wm2wge6TMy9IL54PqHc1r3eTWCsOE+JVGlQaijWuF/4lW3jdoYfybZ1DJaAICQbfvSE6vAHriIjRbAmaJAnGwjqYNOInhdiIGg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13381611F48976E9FEE56020CD940@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(396003)(366004)(346002)(39380400002)(189003)(199004)(50466002)(105586002)(6116002)(3846002)(81156014)(81166006)(106356001)(68736007)(25786009)(305945005)(6636002)(486006)(8676002)(956004)(476003)(7696005)(23676004)(11346002)(52116002)(86362001)(2486003)(446003)(39060400002)(76176011)(9686003)(5660300001)(7736002)(53936002)(103116003)(97736004)(316002)(2906002)(58126008)(33896004)(61506002)(55236004)(7416002)(6506007)(386003)(8936002)(47776003)(478600001)(66066001)(26005)(230700001)(16526019)(55016002)(59450400001)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6T3BTZy9rVExESWJPK3EzdjFjVUpZSDdK?=
 =?utf-8?B?NCtCeDk3RWFoSjFWUFRvSXRKZyt5b1hweU5wS2Y5QlpYVU9JT3IyVmk5dFhw?=
 =?utf-8?B?TnFPOVI3NWszL1FFZUZYM0RveXFJWUhmK0xWek43blBYUE81bzd0UlNNbHhy?=
 =?utf-8?B?V0lqNWZCQmcrNzM4U292R2lHc015Qjd3MEVxbjNTcDhxVVBiZE1lUFp0bUxl?=
 =?utf-8?B?VjdoVERaakRhOEsyN3cwM3BlVmEyMEkwMFpRTGNkSEpTN2Q0dkNaL0NlWTl0?=
 =?utf-8?B?YTJDZDVkaU9hWmJNU2NEVG1uakFWdk55dDQ5UXl4TlZZK0FlMktZR1RpL0M2?=
 =?utf-8?B?UEpDTkdtN0o2R01qbnI1aFMwTC82YWt5dXJyeEc2dzNteHBKYlVHdVhLUW4w?=
 =?utf-8?B?c2RGaW0yU2FoT1U1dWc0RnIxSGg0b3g0dHJXV1ZLY3VJcEt4bURVK1hFeUti?=
 =?utf-8?B?d2NpK213amVnc0tNMWJhR0txVWN0bFJPU0JCblZ6bUZBdlIrS0lBZndOMjVB?=
 =?utf-8?B?czMxdDM3QUcxQjB2T1hOWW9VQjhLZkZRaVFTVlMvTzlERVBUZkNobGZ4V1hk?=
 =?utf-8?B?S09qQkczdXRuU3NlK08vdWQ1YTFFS2lHems1WHZIcmV3Uy9jY09CdFpBZndV?=
 =?utf-8?B?aXBnb3AwelVYTXFnZ3RuRHZtVDhGZTdHN2ZCRzRWSjlxeFZpUXlaalJkWmZs?=
 =?utf-8?B?OVA2T2ZUK1BJZ1pnU3V0eDFZWmZub2psZUNmeUhUN08xVW1GQk5VbjBEMkFL?=
 =?utf-8?B?UVdGYlpRekZocHJMa3h3U2Rxck1XSzhBaitMNEpQS1NlOGRteFBmenVDc28x?=
 =?utf-8?B?WUpSeW1PeWpqZmsyMkNxdXgwTXM5MlBvSG5ud2VpRG5oSDQyZmhabzVKZnli?=
 =?utf-8?B?b24yTkRlS0RaTU1TM0pGRGNLUGFVcGRzM3pZd3RtRTBVR1FZVVZ0K2w4bjFj?=
 =?utf-8?B?RWpFZHBSTWRPRDhYZ3dZd29EU2RFdHhoZjUxQ1RScHdjRWhuWWZvRU9KRTY5?=
 =?utf-8?B?N25kY0oyZ1djbGEySXBzYVRFYm9PclZtbzd6cjg5Ny83ck4xN0t2SThiZ1Jq?=
 =?utf-8?B?N0E1R0lJR1piU3FJV2NiR29jSUFMTW9pcVplMFhhRjNoMTUraUZYK2NMbFJi?=
 =?utf-8?B?Zms5ckdjOVpGVkw1OW5pS0lKUGF6WTRhRjNxOVBHMFN3OGJCZWYvTU5JNS9h?=
 =?utf-8?B?Y1hmNm5xY3d1UlVlbHlBNUVvMnRJZ1IwN1JhZWh6YURQZU11M09sbk9HcEIv?=
 =?utf-8?B?ZWpDQmxMaHAramNPejZYbGpCeWtVdmhjek1QQXoxSmp2UjNCeWhUVlNrKzZq?=
 =?utf-8?B?ZThXc3JZSmxKM2s4a3NONG8yMnNqTHNHZ3JrTTBFZWF0Z1ZkV1hvT0tJeWpS?=
 =?utf-8?B?ZGhqTzY4K1BuMzlzTUdBbDkwLzZiU1F1MG8xdnh3dnJ2YkM5bXlIblFFZU9Z?=
 =?utf-8?B?U2xOeWpSY00xbFpURHk1ckVRSDdMR1E1RDdjZTlJOGVabm9ZWjU3eS9ES3BR?=
 =?utf-8?B?eTJSdEQrRTdFb09kUDRNSU1icjBEZVBIS0U3M1BDRmhadlVlbDJhbGZBYXBJ?=
 =?utf-8?B?anFVNjZBdUtjMkNlZ3dDN29FbWZRL0djRlcxbnl2SlJMZDhyaXBQZWVMUlR5?=
 =?utf-8?B?aWlBMXN2ZEJyUnUvNTBLWGppckFsNDcweVJyNzlwdzdOaHFKUDNVS1UwTkpz?=
 =?utf-8?B?Z1VEWXVsbm5mdVlGdDVLbVAvL1BPTGVzV05UckRPWHpNN1JyQWQzMjlNblVz?=
 =?utf-8?B?dlpSQXZLTXo3dmR4N1MyMWlUUDlvK3g0Q0RRNk5aMFlqc2lXTERMaDQxLzNK?=
 =?utf-8?Q?vyYWi3wHcCtGF/1?=
X-Microsoft-Antispam-Message-Info: DVrgLkBSH+9IcgKm0kZeRHJFUPILYH0rK0kbyscYZX+6hG3iNkQrGjnN7OYk9zTsX49vo3uMGr1CSfd9l/KF3vKJQV7VugLroQZMJ4uNnZKGElIZBAWyCNlUJkILJ+GESOs75NBE05AY5MWtoKfcDymojOtZnxv23gwYQMfPBFuyOIKapDZ2PMPiuZsxPxh3
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:O+Wgq4QTBvr2sn4yIObC3USl50gHP1vFlmQxOi3wt/ZMmO7ZHNtaMDcBxZcn8EYX/DPlSO2K6lHSeptfpHC0dhl9xaDfSzt3V1cFnD+4r7/tbJEMsEM71tcc8IgFhkSfjNUiGFZxfnGQ1OfgmgjYo6w3BLEATaQxGEGV5jkMHEdPP+jgxQT+UDCnu+jZj4A/qwbMbf2PhBYpWjB29T+s4RPwTIlXhK+xbIgUndDBPwEIHOhccMgg8YtMpp85ByZnSEue1Y+DNemOYoY+P4r8rB2/S1wZ2Vm4ixFf3EttrYtP1S6ke4/XhwC0kw0rLgXcyqo3Nc25tIB4bwkco6f8sZ2Lthadx8G4PqVO+c5K7L87FjcMIjig0w1QYvunakJpH5hbhfeo6bS1paDMr2iyX/zXF5R78UNmXUxY5mOZDNnpABgTIX7wNjnpP6LMTc6mCfuGTwdyPfbIDL8piGx7lg==;5:Do199GooPfVWf181+DKDEXTzWENMHAAV5HYOwNhWByqnwbPmsuiDAGlAKlYG8bHYq9VCKpqHtjLfiHAJJJTxyu+WmYlDZhiv5M+E1IJc1xEMCI3Q4D03p7iRW5EJOtZ7OLXr2zrI69lQkALabXnkw2R0tChjels75ChD3RliIh0=;24:EjvcJ5DYLD5t6E5qS3q2NzcPadtaTziegZkUPBSTHSIt6S+W1w0ZrDZTnD8pVOLAn9IY3/uc490GLdBiFcc7Ss08EtHNuW9xxYX2rGch0Wc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:KHOK91c3kHy7rY9/XBwOG1f4vBjrNMRUh93ISE3UKBGecFAY2dQ/6lWtj333NF3vAb8GynmP7jXccj1et+ArK3siGISijfQekEoKS5SysMS3fxcONXseJs0kUeD5gva47IJDLjtxCY0MefRNHrW9jGm5xCNrOJP1FpgbGxUBUi5y9Qf+uKB8oVY8dXShNm983hgOo2Xmz0pTRR7w1fxHJlLC3VCk7Uz5ibGuxMkbiIL4PzWX8iKtvcBq6VU7Ravz;20:KnCa6HGk4So1KxmcaPY7d/Wfp3v9CLPRwQHVccbFHhG84ZLDSby0SmVYTRoZt69Lz8x+Ng7wCFZXtYyOuqOoeFT0nN7fZZ7197CKMUkQy7I+qaCv9Sb847DLGz7e+rMQHUcZIejsISwpFBZDFOLo35AybdV0VCz/L2CBx/W46Oo=
X-MS-Office365-Filtering-Correlation-Id: 66d8dafa-72c9-468f-829f-08d5bfcc1a57
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:25.4903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d8dafa-72c9-468f-829f-08d5bfcc1a57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   10 ++++++++++
 mm/memcontrol.c            |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e51c6e953d7a..24abed028c6e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -311,6 +311,11 @@ struct mem_cgroup {
 
 extern struct mem_cgroup *root_mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return (memcg == root_mem_cgroup);
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -780,6 +785,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a86dfeaa9aa1..a886fc7398e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,11 +261,6 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
-{
-	return (memcg == root_mem_cgroup);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
