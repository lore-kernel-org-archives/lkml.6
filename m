Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrLdsSmT8WN/X/xmlKfiyp6bPIhzK1dBWtosVqTNzNk4JXqlZ8vctU6X7caCHJ41cy81UU8
ARC-Seal: i=1; a=rsa-sha256; t=1525945955; cv=none;
        d=google.com; s=arc-20160816;
        b=NJ06lVKdunkDrnYmOy8u3yUe9IT7pHI4ItUJTJfZ8euJylGaWJOYQHF2KQ4RReLiR0
         wuuPbcNEa7V8i+nkiXN293nzhQUJ22lYHorrJDOco7lNm8U/OxZ69nFj8YCMrPa+32Kw
         HHsIYF607J+5K+Bsmm9iI06gK/kvlCB4H5ryAY3fy4x3vEPxqW8Hk2TvWBt4vobCa5Zn
         OiTHKXxmeP5at8gho6mCl7oyIcPHxcqHnggsTLbjT/jvsYNgs1pkwmHGM/bADnFN7i2q
         XHccvCr33g1Iyc9pwBGEEvzNCBcq/2S+IKEbKjULIyflJWDI4GYyk8NhsEqZ/BIoRRQW
         NQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=bvTOhhzafBIbnrGHiSvQjRCEOJbvnQjYti1uuw+Yl5k=;
        b=XrgZUU7eikZ8VEklPNPGvqrZRSILf/zmvbzyvVNwIYpwCfTYlEhXe1DPN1vBX9NpCa
         bZb/HG0HiV7hxpsxxhQTdelkqxvSSJR0wQCNt4os58lmDLocfNWX7UrIm7gzM5y6kdCi
         zQmB+Xs9TxfW/KRa63lMBwy2UdOgHVUOxSFqtRFgHHdWAnv3Q+auGRg/YYMb1AZML41U
         h/dwIZFjJZtQaFAk4fkowMQDE+dp/cgCi/mxexj1F/OfnYb6cFikO3Q9oZJl473jMOd5
         eYPjmsA/eukP1PmPZOkDPxxu0xQl/JP8aKo3J3Xc/KeOgYo+ZUuhG5G9aZ56m3u/PxxX
         8JlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Fhi6i4IZ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Fhi6i4IZ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 02/13] memcg: Move up for_each_mem_cgroup{, _tree} defines
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Thu, 10 May 2018 12:52:27 +0300
Message-ID: <152594594768.22949.2451669820790556832.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:206:1::23) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:oGcN9N7nfnmNwZvTQurN8HBT3aHXpypZXBax/qYZcgssLb9hmOiAQ4AMAbXQdnSSB4/fHeLexOyqZ5Yn2quDOyRc7O/W1juT0Tt0EdQChSRjeyMKV1i1JwZcCm0avlGURL9rfmM+MAJ8kcJDc82tvCTGfVgs6s7QBUQ1jclrvZPF02cXLuToXk3ndCsY3u6vFu0+SJaaJe7Fsj4yTIADLsiarq3tc0EaJKUIzodCYrtYme9sBcYmfkO5nGVrj5gi;25:6hCGzuN2mf5OmZ5XEZmGrvYeKUoJ2ZHVHDHa8W2M91a/TjKgrp+0EgEn/nxafMKtpMxJ4pveyq/o+BVxYUK3uJ70d8jexOidT9+J5ENaXPg/ns88Hx6bXk3Y7Jj7H99tR/OeVYl2ca3y/GR1wqMiUxIV29EhukTJKfOUPYVOIjrZteGtUBTFYtxkKlltIIVSuRv+HpVQBUFcvnzJnaZpOmGs5dhjKNINj2dmsLVrDWfK5j2WxBC3oLjBGhMlT17AqtM4YZR6hQR6ZHEy/EtKoCmReEvx9PYW38mpPa+t/sOa5PBWW0gTFzmi+nEiwvZ2N+BG+Rhfo5AdZFqWucnPrg==;31:Xfx1+CYkS07MujMGw4WzkuIcHrGc02kiF6lm84WsXWNvStFY+B1Gydkdx2BUDIHHeAUrIdcZ1t7AieWZM9ON3iMJTPspDCV98GHI+8X3LoVnA0++/rDGGZDh/PZCIQhI0x7vOw1VMY02g7M4/7ymQfCTgItNTZ150HAQadHj00/roVkgaWOcU/E4NtlZ3dSmpn5OGceUXtShunIycIiE59RTz5A+onwiFNV6t/sTF5M=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:bLW7L147/LZq/MgBTjAwPKqcNDPalAZHpG8h5KxBck0c3Iz77joMjnLvzc9QMM9rMp2NOM9d3P2DXUYSNh6hwlTyjzDhfpTamaYUQK+PXVvBCFtO0H7oPsb4y3WnzU4fIqKPoqzBAadNwgVFtlAKA69bYMPGrq3Gz/ueMZ59Ncm3M18Wogg/93J4FtQEq1SX8eRvyJ2KK9GKZ3TjSIsAAVQJdKlDYhzmKHzHnNjlmeabSJe87HG8jDyvyZAWWn6VQHX0788T/ro11RixG9Yo/5/TSfbbZuoi+8YUq9qedOKfw3y+HuhWf7RZdrxu+/VGXrdjYLmxMsbOb8xsgsFuQmqvXm4TJHcW1OB3N+Mgq39Oj6xolKH0Ay32ixVpoiZ4cgHNw1/6NEIsez7pu2IJvcOXyxEo6ea/zYITvRZUI4qTudur1FElm2xhx8NO1VnrF69Jv341q0ZmASnzVDg3YMR1q6HsWpz1DyIobpFHURq3AxfP5SIeEZuo1V8yuu3i;4:xdNbL7RuE/lIm6zx69YPD7cUipEfRA1axwHwvTig4L2tpKDr+nbkIRV0niK9YZmY8iAsefLx5EK4k5KqV4zWjsfgCGflwa3jv55qZYM2Rx+UMD7PZ62iT04dFtz80mzVUmVj5Z2d7yYr8qJcV+G9jfQar+3fPu+2YIYcwUTxrTlQxJqXyGqk+sVkG4kRjDD5ELGlEE0HzTcpcnqbhirY3xpHMRQikb755hwnEv6dMfEV9bcc4xBWwe3f4YEkQHO5I1GAX03CuTDl0B7ndBrrzA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330C825341C8A81EBEEF2A6CD980@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(346002)(366004)(396003)(39850400004)(189003)(199004)(305945005)(186003)(86362001)(103116003)(6636002)(2906002)(7736002)(478600001)(230700001)(11346002)(16526019)(52116002)(106356001)(97736004)(53936002)(39060400002)(476003)(58126008)(6506007)(956004)(76176011)(2486003)(7416002)(68736007)(316002)(61506002)(486006)(55016002)(25786009)(105586002)(23676004)(81156014)(7696005)(446003)(47776003)(81166006)(8936002)(50466002)(9686003)(55236004)(5660300001)(386003)(66066001)(8676002)(6116002)(3846002)(33896004)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6eDk3OGYxK2p5M1JtclFQQ3AxY1NIWWU4?=
 =?utf-8?B?ZjRiWjl0dE1vMnAySjhHVFRJOGNIZ1l0cTgyRXlZQ1FjMUpVcXpuRXFjMmVP?=
 =?utf-8?B?R3g1NDJ0RkUvMENYY3FFRi8xMzhLQmdFYzNHdnI4THc5c3lOc3IzRXQvM24w?=
 =?utf-8?B?NXBvc2V0WDUwUFNlKy9CdG53ZnNRV09BUXQ3MXErdjNJWTlUNDBmVjFoL3Vw?=
 =?utf-8?B?amh0UlJtWGtLQytjVmF0eXdxeTA1OXVDVnV0UU5MSWdoYjdUZzZROENYdmtL?=
 =?utf-8?B?UDJIdjZXUDFyS3Arc1VlOUVucVNkQ1l4dmxxaDIrWEhObGdiSm1RU05mSnhk?=
 =?utf-8?B?R2o0WE14dXYrVTQwZ2ZFMWFMb1ExTXNKdzduUTVpaUVPd2cycEsvb1JjbW40?=
 =?utf-8?B?Ulo0SlZXS3ZhYzFRZjlmSEFVM3d0UGxQNVVFd2U0Y05JOFJuQlpOazZtNXl5?=
 =?utf-8?B?TXpTZDNvME5uZjhraTd0Vld6d0hrZjRITTI3U1FvUUNDTWNsaVo1YmR3c0pl?=
 =?utf-8?B?VWVKQXlWM0UwNExsaWkyRU9Fa2I0blpZTWF3dFZiRjVXZ2FSZ2t5RDdBYVZB?=
 =?utf-8?B?V3E0U3hoWWdsRlY4Y1FRQ3NDNlJNSENsUFJVQkxhb2VDaVdMOENHbExOdkxj?=
 =?utf-8?B?NEkyTjEwOVc4Z1ZUR0tqS1R6SSsrUmNIY2RXV1ZhZ3lUbXd4VDRhd09JRmJ3?=
 =?utf-8?B?UG5hK01VdFNJNmF2UHQ2MnNDK2Y5SW5iTHB4TEYydnhWUW4vc1ZIdG5TSHVE?=
 =?utf-8?B?S2k2eU9SWENFRVZhR1N5cWlSNGdnV0lRbnlJOVhWUEVNYktpS1VtNjluQXls?=
 =?utf-8?B?bkY1QlBJM3ZFc0hNMzhqMnNjcno1ekdPWUxzOXI4blUyTUdJRHFYNG5qOFg1?=
 =?utf-8?B?TlZ6ZTJ1VU9ubU00MWZUUWNWWWlJQnNBSEZCb2E5ZkNuakxMc0xrdEVzMC9h?=
 =?utf-8?B?cFoxTjI5Rm9FTGo3bUVBL1A3YkVlbi9qYS9scjg4R0hHNVM5eGhHdUI4QTE1?=
 =?utf-8?B?QlhXbGFSOTBIZFRBL1V1c1JYOEtaVTF6WFVYYnZLeDE3aFpZcDFPb0NBa1hV?=
 =?utf-8?B?dEJSclIrc1EreEJENmJEZm1qc1plUjBzT3dLY3dhbExsSG9zY0ZvUlgwN2pE?=
 =?utf-8?B?QUFwa3l1N04rUWhNYldHeXlwUUpXNEJjMG0zYzMzU1UxbnlwMURQOTlZVTU5?=
 =?utf-8?B?bFdidnUyZDMyVmJnQktQVUIyckg1MEExQUpVOVBMbzVmUHBMTTQrSHhPRVVO?=
 =?utf-8?B?MEIzZCsvbHgwdWYwSlFrZHdSY3Bhak1FYktzc2UxMEJBV3lkYjRId0pQMTNk?=
 =?utf-8?B?S2lsT2d5NTV6Nkl1Qktlc0lGTnFBczV3S3NOMEJoeU84K29CMlEyVUQwRGRI?=
 =?utf-8?B?VkE2b1UzSzJFcmx1V3dobitySkhNajFDNE90M3ptd1JXRVRIS0dSMEI5SzZW?=
 =?utf-8?B?M1MxcmU2RlZEdVc0QkhXZFhBT2JaL3cyeFBndW8yNGh6SHR6bTRrMFZ5d1pv?=
 =?utf-8?B?V3M5TVhqNmtEQlEzRHRPc0o0TUV5WVBYbW9xMUxpVVRaUU83cnJtZjJzTVpC?=
 =?utf-8?B?RUNmMHE2VEpwa0FlSGRKcm9ZWC9kL28xbFM2ZllqaVc5SEF5ZEx4MG5oclNs?=
 =?utf-8?B?UmNqY3NlRVJYR3BLWTZsN3dvSlBSZUhYeHpzWnBockE5TEFtVnVLL29xZGo0?=
 =?utf-8?B?MW0reWl2cjNJRU1tVy9HRm5ONWZzNUdCbjRYL0wzbUxMNkI4Wnowb1Y2VEp1?=
 =?utf-8?Q?PBAXxZZXdJb1DA8nsHPYMD2qLHXUifL6gX+94Ak=3D?=
X-Microsoft-Antispam-Message-Info: +wNhMut/KdJlMKkV9gUws8FEaos9z4DiX9HNYpSHu5V58SyfpjkcEXEFj8Vn4ZqwaYm1imkKECt45o0iIXu8+I5ROZ88kEZS7P6T6GRo8hDw6ZTt5TbiiIAg7Jf/3Qth7oNAmcvxbWBLzoaifBN4CEkZ7bGr+FF2vCYwJhLkhnXzCs0/pYwz3auLQT0ZBDYn
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:XI7oZKnAhbT/LhC1/JCl4RQRMLrXoo7R2MOtkaXDiA4ISINDpYpM+6KXoRZmSvfEE8offpqLSRDcifw+WwTUoFDYcskTt6r5ruACzhglKZa4CEgjg0VunMfngN9kDVJHWUl6vRsO39VfhEZ0IRAQi1giW/ixZawUWhObU9uSHStkvwhy+GgKeFj4FJhgikI0Iq3EPJk7XSeS1bW16Sr8bT9oAr4tA84smqj8Hk3Efi2zZD+c1hqjde+8NJqrxukthjIeT9Gss71vTwBQ+wHknZWvKJiSg2FNVtJeXspPCZSwGv1VW9JV4MSjq6VFB0FqeJdeEaz8Si5Z2pKuyKPrGd1nkQYArhwH96hqZtCim7DsjD/xVsjQmcZ5Nt1nlFuNwohbEbmFopXrO/zMdokxvCmn/rJsDi8fMq/yPng0rA6WbJHVFY40XXe9vdhPkwZQQ8Ojpvlrhh+xLklJn7ZT9g==;5:Ba17EeZigH3VKmCjGTkaeX+qytB/A9a5dYWYtpf1rqIsF6yPws3w3KoQLUvWYqNYyFMDiqJhsWZVZrvQx0a7PKnZhjP0RhPuEw5xUZ7WtF4TItk/RIySVycvPC1aGB//GNcPaoSBwkOGxLX7lUE+2qTmuICo0hyKZkrZM0qcsrs=;24:/Y01/DpxBW4qoW4gsc5LLJPrWUlEmXsFFW7e4yj0e8M/5h6uJObGIdt4C5JZUIVo8XR67RHeq9XkVK1DCnbPllbxwjskBurxV8+C+1vzWRU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:bAS3M16siOrPQWrjufuw+DrWSx8VUI0QvBnB5Su0XtC0RzC2Fo3EE6W9AVBXymHTWB+/6aNR2UO1W+emd9HigXVhi7zkCCfyQa+OQN9maqpRu8nLWX5PwhxEJtcBrV+skdqxA+JtTYaEOEL2o5xHmqaGKqeRdAdGZsNOm22jpbSwDfOcueISp2XIFx6/nLZz6r5CNcLGq0jSU1aeKtPANny61m+ErJS2o9kD9qkeFVJcHj1Pru9R9lm7KZ0At433;20:szidGn6Gb/ULWmb5MxpgWh13CXnteqd4X1O302kv7JRJuVXucyyrTPsFz53RfhDZ/QpFwFRJZPEIA9l3LPhpYI0J9te17OZgHKzNJetOWElJeAYuw3mvzwNE1CF2kbjTqakR3NSiJskZcQUoPZH3dBDHj6m2u0gw3mwToRu96WM=
X-MS-Office365-Filtering-Correlation-Id: 00675c89-3c7a-44be-9b72-08d5b65bbf53
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:52:29.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00675c89-3c7a-44be-9b72-08d5b65bbf53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070306327088728?=
X-GMAIL-MSGID: =?utf-8?q?1600070306327088728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bde5819be340..3df3efa7ff40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -233,6 +233,21 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -867,21 +882,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	}
 }
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
