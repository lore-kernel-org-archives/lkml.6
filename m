Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZp3TPrBTJ1QIMzunRJ4kiwC1RowochtgDosI0mWDujJK+SabupS4f2vAbu+oXxLVamfwBsl
ARC-Seal: i=1; a=rsa-sha256; t=1526632954; cv=none;
        d=google.com; s=arc-20160816;
        b=G35p2Qy5YhyaFQ+mryDytdlipeRGOCGlbvZ6/2wqqIl09L1YpMBa2mRlkC3XGxnZwr
         qfJfWagSknXFAFJlXJoKwdICkUnbraidy//KZZlxTo5dxxP64PuB7wT/efzhCTD3RJH1
         a4rOMX6MiTRX7HIVMxixlG9tpHupSs9qwbg5JwdMF097tZKEHZ3GDbR5+lVXCGbHyt0V
         a+8M8V/HnkkYfKpT8lkd7nWUGwPpNhRTIBUVr4QW1QmmZ1VTFiJsE4BMOvGIeHNubIIO
         jpb5UTNWFMVte9dXtJvrqUASQg/zN5Fk3kyIFkI9Lo6uWo0Qq/Hpt7I/obb8OD0kYiTz
         B8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=UZ0QN3U3mn3AEHQuc1AoNfRGEEMzOSFCs8YFu4fZFZw=;
        b=NzAX9p+NcPC3m7t2NBPmLl7SFMOQBDT5vDNCkgrwWIUGNQlO5mHBLI/OFoNgdxOP1D
         /X7Ga9uBZflC0QR6BCr5iTC1Txx2PJMXgkdJ2MxTZUqbTgKHUzizu6sz7Q4ZjxvEYWyt
         15B1/1KgYviKIxqiyv+3MeoVWTwZ+Rbi8ldXWPMkplw2rR0rzh6tXsfojIDGObeXGaGf
         LtUSSo29YoO7x/NyEB6qYf6li4H4QmGj0jhpwaw+x9mSMs9uvlUwm+0kJMB+hlzqEH2y
         bflE6vQaHDwDN+b/apebFv4jpw3cSZRdVUuc750yH41oOZpBGic+LoeCzsNaLQni9w3z
         58wg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=L95c9mad;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.114 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=L95c9mad;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.114 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 04/17] memcg: Move up for_each_mem_cgroup{, _tree} defines
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
Date: Fri, 18 May 2018 11:42:21 +0300
Message-ID: <152663294106.5308.16116088688197815775.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0010.eurprd03.prod.outlook.com
 (2603:10a6:3:76::20) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:Z5jli/5B/s1+M21LW/Z5e6t7cz50MnkqznJkEr/LnVHsBGMDuInCtpdqPqTmbfhGrYnhLJYkzdOip6BmlLeq5x39+pu2txyJFWv2Ekaz+n7jdwAYmm4lcwH8mqAIdi4iEADvqmpypdqhDrDVdfJKxYYvUhc9TdCDajKn/fsSkmLN7/Qx3uHb4FbhRF32H9myLFkjsV9++e48g8/UtdXNNEex4rXcWxJbmi7l+qf72zJiUC6rRHVoySABMOTbQjoy;25:fW/awNhNTUv03z+GxDh4e535EKeTawNh4W01kEpcx+VtAVBLWdgR0lWyivurVqeIvVp6fTUdxwNfgXG8iP9/zdKN82SSwBsAiN7hW8e85dsD8FRTxpuUcbnlTETYYcqYLU4GpzPhvlANdF3TIIYX7Hxzs0+dJQNf4arBr6bnhr2YV/x2k1zSFydxfVosCcd91ODMNJC+AQpXz8kY+RubM4O11ebeZQSexUqI0eMLi1mWvS9I4bUP59tFKnJXz14sCukyfaVYpGpfuoPIPQP+uYzDpfyz8V6o8vbd8z1cvEptx+wU+fAiWIOrzY5tdvy1O0HGL2SNPTyseGh1tYtdHg==;31:Ou7lObF278mrUgoJkKhIKWm/ESCquQCQ4sBDifxFd9kK9cw7haIKVKM5ShTmZabj1WYgMVrZOj89TyGT1pYdvWh69zYBZX9FfE1uJelaDpXbE58zaKLsc7KCmEKjtYBwC1pEYt4utSIvpNgoxLXdsTC0vg1WknZ/A9uIz1WolgRk+yheiVMHttSlItBkx5I4s4NQD37AlcXmOxUk+PxwhhOpR8HSWN0r/I/7Wv29g+0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:+Zl0afxmeO52PJpIFgEFabI51UzU1lk0rC/zZ6hsCnWymx32Iaq63tBFwBFmO+L6FZubvEbBLcPB82ympA7cCl7KMXR+J8uimr63iNFQ4UHtVBsmhB4lcAFBjHwqOmS7N4KxZdWUW+AiOof/bnKz5ZUuh+7TOm0HRY3lwA9xBqq6L1ZcNHfSIsAPdtdmK56ZFWFaiGRJljADhvHUcYU5Wh6Dz26Awh7IhO7i6GIx5x3dnJgkgvEpIkAMnESvTdW1b2ddJ3872JKLu9TEpJ1z1peaG/6CWuXfykSi4qeSGqNoNf4K82Ae3/RXbpcDQ/p5lUCM3tuSzdTQDrjZEgJ7UwPUHs4NCUDju8Ojm6FchEeiJ82hpQzlsVsR964RTfQvlGpD8kQ5Q2Tfml17OY6her6hkHSG2CySkb2Ds6wjCwTTNGpJNFkuP9C9e0ScHPtZSfE3j0ZJnEQ1+C00osAl2b4kCFPSbtuO3kVODQc9Ll2UnwhbxXcbqv3nMQm/knLd;4:K4khYEzf+kxG+gy4b3AbD9Yby9fS/x28reMitBSEJTadFTOX3zlFvaJs8Rf29a9DysmX8YIDyC/nlawV8sJICJpqTK6jZ8WQHpsr/fDbLGWqEhZrUYF+QgWxDqCrYEmZJZnCJUeT+J72GnGs4tcyIaQ77hmgLCRaMOnSB34x9V8alcKUXpQZ6IpsSzGGhWy8xOFSfSx3mxPEMdatNzljeIee25eu4Sj4hue8MydLLuS+4+3oD27TdEuKiRWwWO+ohIzvclmJHvkOj6MjgOi9kw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13421CBF4186CBF836B59066CD900@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(396003)(39380400002)(376002)(346002)(189003)(199004)(11346002)(23676004)(8936002)(7736002)(476003)(8676002)(81156014)(81166006)(105586002)(106356001)(50466002)(2486003)(446003)(230700001)(39060400002)(25786009)(2906002)(956004)(103116003)(486006)(6636002)(55236004)(7416002)(76176011)(5660300001)(52116002)(33896004)(6666003)(16526019)(186003)(6506007)(386003)(478600001)(26005)(7696005)(68736007)(316002)(58126008)(97736004)(47776003)(305945005)(86362001)(66066001)(61506002)(6116002)(3846002)(53936002)(9686003)(55016002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6UnduU1pjTnQwdVRRM3BTYWJSUGdNNFZZ?=
 =?utf-8?B?aGZYdlJTQnR6QzBJNVdlblRLajkrQTNjMnVxdGhiVTMweEtlU2RFNHVic3Rz?=
 =?utf-8?B?ZVB1OWpVQnRDRHRLcDZIRjhJY1VOWFZ3OXdiTDZ2YUZIVTdtSFZGaHRQWmov?=
 =?utf-8?B?SU9qT2FQdmlDd1dhQWpxS1R4WWhxY2s4T29GdkFmRXlqTVF0RlZENTdLQWlN?=
 =?utf-8?B?NEhxSkxGSzhyUkxUUFo1a2NJK0dxdC81SnFrSXJTclRUaWhza2tSNE1COHZl?=
 =?utf-8?B?dkFySjBCaFV0UFczcTZhMFJXUmZYSllHNFdrRkVneHgvMjhiYUE5NHNNSXlx?=
 =?utf-8?B?dERSRm9PNUxUb3U3VDE4endEaXhZeUIyWTA4eFNyRlh1YlNQckx6VnJKeXpM?=
 =?utf-8?B?TGZnYzBPOXZtbjRvN2RnSUZxLzNKWkRSU2JYV2wxT041K1pOcEtVVE80cjg0?=
 =?utf-8?B?cVIrWC9FWEpSckVIMWN4TkJUTjNadUN2WWZWWUNYV2Rmd2RHejJkQjFnR2w5?=
 =?utf-8?B?WEd5SnBHTFJod3RGNUhQUlhadGlmOExGK2EvSkhrT3pqY3gyZnZ4WUw0VUFX?=
 =?utf-8?B?c04wTzNkRDFZaFBYSjJObkdOQ3d4TXU2NlNyTmVRTFJTK3orOENFMEZNRkQx?=
 =?utf-8?B?NVlBSnhJdkhNOCtraUFhdUNKUFQvQlpkcUNiV2hYbHMxOXNWR3dGREdwMWg2?=
 =?utf-8?B?c2xpR1F6NER0YUJ1ekNFNzZnVEh6QzFMMkZtNW05QzAwc1lmWFpPcXcxdzN3?=
 =?utf-8?B?S3lkenJETEpEVHo4RkM2ZU9aS0JrL3cxb0hLNXQvUGNBYkxhQllZSEJLNU5Z?=
 =?utf-8?B?Wis1THIyeDZVS3F4WDVGeTBERGJzZDZVYVVvSENEdzE3ZXg1aWxXczFuZnMx?=
 =?utf-8?B?WWZONXlqNHRHczlSL1JtSzZtcGhMbWUySlh4UjRTZVI4N1BVZElDZ2xrQVVm?=
 =?utf-8?B?bVlLeEltVkFYR2lGUW1jbERuV0E2OVdjaG55OC9qRWp1bGUxY1p1SFV4cGFh?=
 =?utf-8?B?dWcvdzZ3ZHFJQ2ZkZ3pMVG40MFU5NTRkakZPRHdHNTQ0c0t3alNIVGI3UzNQ?=
 =?utf-8?B?RVc0ZDNva3ZTUUJvYndiRFlTR0RDcHlDbUxQUmFkWjBpa09aY0RuL2dHR0t1?=
 =?utf-8?B?S1NCc2hySHRteEhMVGtFZzd3N09SMDRpU2thNFJvcE5ObkhFclIwdXlVMVhp?=
 =?utf-8?B?ay9BVlJXbjJaYmJqTDZ6QnJPUVdXaTE4S0ZWMVIwbC9VWGFtOU1GcTIwbHVQ?=
 =?utf-8?B?R1MzczFhZXhhc3dqYU55djhtNm9nVkpHWHB6S1dUbXhidHY0b1huMmVsdHRi?=
 =?utf-8?B?dVdrR1JHU1JUMTNzbDV3VUluVTZ4cEFjSFA5dCsxcWxJUWV6QnFoTXpDYVVz?=
 =?utf-8?B?N05tNitQV3ZINnVjaDUzcldLNlVLWStNc0JaeXIzL29HYzFmVXBiVDdIc0E2?=
 =?utf-8?B?RjB2RDZodXkzbmU5aXV2cWFoU1hQNTRIbmhqSUpHY0I3czJwVUJNTHloWUVI?=
 =?utf-8?B?TXJSQ0FCS2pVRFVCdnp1VXhqWEJETmFJSEorL20raUZqczFnQzBPTXloWTEv?=
 =?utf-8?B?UUlqOTZITkgyQUM2VklJWk82OFBZTExCWGU4aHJJRktIQ1FKcjZudmhyZ3ZC?=
 =?utf-8?B?Y3B0aUYxSXR0eTlZRWZrSnZKdk1xSVdEK3Urelo2Y2ZHVUFWVmNNeGZKYkpN?=
 =?utf-8?B?SHIyQXhsRk8zZEZHMWRhc2VtUlVac2dKV2E4VHJUWTRCRHNid0UrM1BOU1I2?=
 =?utf-8?B?eGVTdEVtZDJVTG9JeWxvQmh0ZkhOZjE3SkNxSi9EbEVMeEloWnVXcHVPMk9j?=
 =?utf-8?Q?24+1ZENtcwHhDfn?=
X-Microsoft-Antispam-Message-Info: QrlgqENljow/kjIRoyMbzAPeafYRgOfwbMq4UXVPyxmYFCbPO5FR6/0sZZP4aCE+U0yh15QoY4/PdTx3PzW0WpkF+d0oL9OE+IdYo+Zvq6slM7Ot8TTvWfNbQ9oPm5z+U5VLOd0HsVKJSbs5pYBU3detI4kxkFR2K8oYAmXgxTIEY63PmPsTjicuoxkKq4fE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:pnhrcW06aWyRGg5BiYIFn+xtQ5iV+IXyw6rJS+Fa9maoyN7N02cDVjfL7Q2eO39QFwHnN5uIW2DvLjPV0eQ6OPLHcfdwoH4z9x/hOffo7wOj0IFpjFtgTDCMyNl51mfgD6AIOdJ54erlKbqI0IpUjd4p/f8myHVIhvdf0rELht4wYT4ICOTDorrHojTCYl8CjMf7v0O3uKYtVmLNTUiSb7jto7Hazfwb5H21QxeZ2eYD7PjvdaZ5vR0fgw9PJREDIsxkrzWnjmHBfU45XZnZh9yL/2GMAh3i7cEi68pdJRrSuBpndPGloSmKK+Ab9ZBVlOELz/Fayc+apXyivmWaVdx53+EwSSp5q9mojYo3ymo+0NuIyFacKPTmz9X5byU5ZcddWBi1a+aZ4+AXOQcx86v0PfydVY9DqVs9KmxLMnPYi+j9igKj9ZHtE/UI1mxvyHUWJ8/9Sl2pmjst6r9K6w==;5:MPiOuPvMFtr+BrBiJBfEBuwMBSMKFw2Qm/yNW2UpCMbp+X0KiAP+v+QLCxW2HnLS/8gKCEb1mVTiBxp6rI8CeCaPGyCEfHBIEyeN1fOSvtiS1uUbPODIFhcGt8gpsmV+rbtDa2AKsYTl2R7rtyjgWzQ3PF8/s2NTo4e54Lh6hwU=;24:JvwsPHIqZbdbGYyKMp7JEknrxbzD3rZ5z5oGcRimymQXq7NZ4/S0uFTF6C27JhgGhEhiXuDOADDaDwIxJDjVKh7HtStI9eI54bG/bS3WZ7Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:oujPvQfnKEnFd7SpG8cnJZzC0fN3nmUEEGVqdK58kroQZvzDaEwycKp15Qly2c9fv51CMdqSyUPBg9Vm92NnM/N2UEuUHvaC+HOBGzEvGxocYe3tFQJ6o6q4v8bMJKDf2JWRDlRBGt+oJmWMntZjc4U1ByLZs0/Ih/SzkFmIMSmn1aew+71v9ArV53uspvuH6rBJcInGCsVpG3L4pveFbiGOZLsca4rcCxPpDS8cfUrkTMQ/SrZY1s9FnUzgGiQg;20:r+xXxTzmvKxmDMvkmn4gNPkYqblT3DuVYlnSIedCiOBkzCv9Ukoa7ZqDa0dW9z3xJ6jTquf47Y/LVN2evkevZLlM+Twa++e1boGulneJiXmQJ9kr6kvmnb8uyk1bttkemdO/G1gI6cETera/lZ5hM5uk4mL/fnW6uphu0jjcBFY=
X-MS-Office365-Filtering-Correlation-Id: 6a9dbf17-265a-47be-6991-08d5bc9b4b98
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:29.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9dbf17-265a-47be-6991-08d5bc9b4b98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790677757178571?=
X-GMAIL-MSGID: =?utf-8?q?1600790677757178571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fc67e43849eb..023a1e9c900e 100644
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
