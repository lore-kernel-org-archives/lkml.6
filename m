Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeCVB7i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:59:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753789AbeCVB7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:59:36 -0400
From: Howard McLauchlan <hmclauchlan@fb.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, <kernel-team@fb.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH v2] bpf: whitelist all syscalls for error injection
Date: Wed, 21 Mar 2018 18:59:08 -0700
Message-ID: <20180322015908.30433-1-hmclauchlan@fb.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:1eb7]
X-ClientProxiedBy: SN4PR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:803:20::12) To CY1PR15MB0534.namprd15.prod.outlook.com
 (2a01:111:e400:59d8::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8105768b-734f-4ef7-0000-08d58f988a95
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0534;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;3:9tFUFmXV0zzEr+fF9cTYNViX6CWOCAFfVGstsUDMY81YInjVRvNa15sJbC7cUOXRJantTiAQOQGNcXKfvPd6xxlD/qWDYduHfXOlZN+x4TAIyFBn1Mj3RAHmVFu98zD4X7tnDIjQycyRQnCNVuBKC5qRkcAdhAShArtWUvj2+ReYhLwUKvCQBbwRLkDjCfVb+zajrmHezTYTTvEgsIAVnubVfTbXjvtcAH9RNxTiqb86gneAthcRP6zphBLNcPFR;25:uF/yomSIovQ4RlVCRJGA3YOHyrQ2J/1CGr2449ORCAQggLYVvQRFkqea5DO+X3fCFibk35C61oWFxFuh4DgESqjg7Fegn+6Ck1h86qy/GHxFC30qmPBN+9nRAjMxwb3Z+pLLLqSQ4RHbpaNEMQxjTYajyk6bDx436A24dR5eYny2tcvE5PhnNWHYlgj5oImxrKPTeHXknHvE2rHRO5YYStBhKYuPAapT7rgJ06KBchAwkBAs3Sj8Wzpqi5OC1S7SIR/jf5S4WKu/h26LQLIzMPjKHPn2aSNHQp9HJkK0o2WWBPpDft+1eMhZ42dS8EvkiOgOKKK2XULw3W5liUEO7g==;31:0MlJN5jV/6CZSp/mVZxWHsbN20x/xsnLW+wgoXgP8LYKevViHxGerhvE2lXm3oeIcgwX6I3jX8UuT9n3ZMnr4uk4MTp+OWwPdgOMUe0O7CfIIHa6/c8TARk+eoDSa2g70Y3372SNTQFoO8s0MJCop/I602I2bQptNagw5cw7XI4A/HFrN0vLXA90lQB59e01YqfKR9O43TXXfDqNV7YaICABibvEbKcoeSNeDYvQz+M=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0534:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;20:ta2dYBvfTu431vj8ndwx8htL68NYLnRRhED3eWLd5XvC+mEyO1RN5t635ScVtgTJQF9tehhIHeFzJAJ6GkCHu6uzTdBc0wn7teC3IsvsRGbEpuF5r9aDY+MUWADYB/dXJS1drhLlHFwNU5O+UoAqZ1c8o2iIXM2kOZZYFtcosD97ki72hKmnbFy2fl8S7OpkcS6gujitB/OoxSguh623tuVUFGcTMU4uYHv271T+c0r1AcTG7q6tTY63n89QtRFX0Cuz4qPI09zzmxKsV1Uu7VRiSnAnkXr0+6DumuroHiGHzwFlosFW5pq59hT3ENVmASuj9+WJDtuenMXbgKoAJ+rF9w7OQOe6wHvVuWH4GNP8TQXtJkukXzeQvRmqSYNhP39nLE/xxG9/23tCnkeSq5XDu6BFQefemrd0mfGTDSzIo+OUEkPoUaK9Ed9OkzR2wO1hZfE850BqiIR2UDVvJJn4wasCj1DCD8sSWfzQVxgKny96Xz6eqKsI4GInODzY;4:NVncrvP2ouiZPTTGelC0vzj1xZWxOPGGzMq9JSzlOGmF2VQ4p8WTq0frz9NRSCzox4BpvS5bYCzwZ+HBJUPOvSJiesV1Mc+o6ZD5aX0hLv0MrlzEqviPPXNleIieVr82e2Sbo6OmFBz0I5BAcUfgHmn6ZkAlI69oUu5AwIKzbXLKsRPQHIsqONu4yl784+zAK+x4Wpap54O8TVXRod9jR1vhdKyELaUyP7nXmcxpiD9Kkb7P1wCIXqfLoXKTeAHbE9sJ4xT5EVkEqfTZOVHmIzfAyPd6SKY6PtAlriWjYE+a7km1H+CKjBX1iVaE5dKU
X-Microsoft-Antispam-PRVS: <CY1PR15MB0534287BE722F271408B5FE1C7A90@CY1PR15MB0534.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR15MB0534;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0534;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(1076002)(6666003)(7736002)(8936002)(50226002)(81166006)(6916009)(50466002)(48376002)(6486002)(6512007)(25786009)(305945005)(4326008)(81156014)(105586002)(16586007)(47776003)(386003)(106356001)(69596002)(54906003)(53416004)(5660300001)(8676002)(53936002)(6506007)(478600001)(52396003)(36756003)(68736007)(86362001)(2906002)(316002)(51416003)(16526019)(97736004)(6116002)(46003)(52116002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0534;H:hmclauchlan-ubu470s.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0534;23:QBxhX48FpK48CBmMmDs2Z1SRrPUGIQEOtSg0kgoHa?=
 =?us-ascii?Q?gTobucGe8jSWVm8cWostmHLeCDgRKMXIWVTPCsMrTnHd8rn6T20iiuqIUPev?=
 =?us-ascii?Q?VUkr9RVyKfGpZkH1Mz4awm8AN4LzPNiX+fL2krwUhAuDjtbZWrybfWMNjPVU?=
 =?us-ascii?Q?C9+KKSZEuK21T3flyu50FNu6avgQzNHM3DQrzH39cst4s0iKyXCG6sKILpk3?=
 =?us-ascii?Q?sooHePQRV3VRUkfM0bfnR+ZKc7aYfp3gLVw/OcCorYUG9w/S0b0vNP+c/H+n?=
 =?us-ascii?Q?BPIZmOJAKsH2oSdh/b3B2wK5jTRuep6cq0VWMOEOmrrqQ7LGJm1M7qfGU8Hd?=
 =?us-ascii?Q?O8A3he7OPrtQJ/Z3FgV5iRU16GB6aOCWBY/bqhoWZOFtM3f4u79WZV6zo5uM?=
 =?us-ascii?Q?9GD3IfB+D1U+/Oc1xrY6PXaK46fBUwKBJZV6cK4flip2yAsSfV620fsHUzxo?=
 =?us-ascii?Q?naODlFllnDsZqARZulIkAhY+lTLumwymXbe+/IgTGDjuoiYCWTkHrXf0VGUn?=
 =?us-ascii?Q?mRnz5DyXHS1UUhz3+0O7b7n6AfwOBw2rv0mDJo+AwhtgQK00v5R+powKoZYI?=
 =?us-ascii?Q?IJcgtJH2O9saucqDii+2vn+1aOZ/l7QcQA3GwwKFHLEPRQx+0Z/Qj0qxdm+H?=
 =?us-ascii?Q?xSPZoI01NblxQ951YYgHNZVFpwQzKqfX/12skeLUbV3V6KxW7GBFnyA1VfyD?=
 =?us-ascii?Q?7jsq96XhjBG44rP00ZdkL7/pq69W45dyucLhbcLkeS5MJGWKiuGbXOBwKgDX?=
 =?us-ascii?Q?v+0eivX0eO1VEd5+OfD6md4BHOmyJSfVnIxoXqWzcwUKayQCk63aX5q9IAB4?=
 =?us-ascii?Q?JJntnsuoz80smLeHpcTsdgZimuyVYNPOwovB8nDy9hmFaDtDnw5wVeD7O7rD?=
 =?us-ascii?Q?4G97L8Dqgi8T8OFtTLf/2yRVndDg0krSdWB2qDaFmVWDBlN6xfwjEQpRGZfd?=
 =?us-ascii?Q?YHAkcSHsU+Zhd2aiRO8u4KNyHTXhXOMVnSZSrgfnz/uDl6/ysBK2oU+5p6iQ?=
 =?us-ascii?Q?vYp9knnN3q7azGnofeJ/A8nr7I9xTfdZUOfQ6UKMpCmA3EN+4WrWvFLcegJ9?=
 =?us-ascii?Q?OIteh3XTGpUpagSqUixnGwcHl4AicBUXIVqGElSpTb+W646wcjuo0GlvxH8J?=
 =?us-ascii?Q?HGgc6VfXno=3D?=
X-Microsoft-Antispam-Message-Info: EyzPLarggmyuWtQG5rdkdR0vWx98ekhNENFsNHwsqsQV+rxnFLaWkOdF0tMy6Pz0+y78xYj/lsA/B7rIBRJCVWlG2A6fHpfiUKu3mHOAWeSemZ2dvaP3hf+jglQt0FPV5bwAHOvTs2VUb27lHjdJyUhQW+DPgR/ZpwG0ssmzZJ4LItKOcGXjA/kc9URJezju
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;6:SwBURUwMpr2UiXWO7BzAK54LON1qvD4hCvHBoDfeQlIX0XxFhko8oCG6GnHrRqmso2KiwuiaiwmT3YqRb3jAlS+aprMf8pBI5tUbbfplX7e5HS9r9gp1y+z2oclrwP0dSB6N8+J0FRRruob9oArLIrDU6/x9i++U1naqRK3cGXGfZ2UGN3N+trVo2+xXf3JOHU1f9tb2FHGUecxtX24wnl5plLcpSJ6xee80Sqp6yvkuccs7T+EhIW03tW2+ZhD//WMRHBoRIKsN61NVKB9BakYOTr3uyq7LqlK6yBIMleSYv2SoOqefanhfr/6SbRPRQiMFNA4PZpWcQVNyWgprVV6vWk02YvFwBBfPWsJRiTQ=;5:pHHkEo95vtS0tbnuBQa43T7CGLeicIEgNp8lIDt37lpepsRgXZLJoARtSlcnONGyZK62uNOy3FM5jUpL1PwDoz9pM/15nkQYTQ5I4PpBby3DvF3w8f2jcoewAAoMkzZE+VnLdbiSBSQE47abVvXpjDXW5HKo0WKKnhjmL0AEnk0=;24:t6NwSDB2ItnoOH/HDrd6NJ45PVaSA7pY0F7rhZAEHc8RJmNgbHaqvJhUt1WCYHXjI8kUfAYZJGurKmMa9GNpBCTsRvv3Zy8rpxJOBe3PbTs=;7:f3VHg5Tk8yS2bPKu7h/efzLoTP0d6pt9R7wlYzTngF62UDfNE4lNY/n1v0/aMjmIZ8lG82DpER3o9NEuy6hcNoqpWExGuCuMxPfMGUkv+1JwA34UqVZil8a/+LwJh+R5UY2hlg3vuvvUNAv+c91lp4+fJKfSjzJXcOeQnjGeqZn5LJsUUzJdprK26twuQnMZLyLh/MckzV/G/0X84ucDU0SRvXOMNszXaFjoEV8j0B94kBkFBKhvaL6G71F0wwFw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;20:HMaCDKswnVc4eh5Ezt9KoZk7YhQamK9PRB4D/7QlKAdwQ/qNU6xPBl+6hMCDfH62i7EOk4DrblWBwlwcNJERxQiBXaJcmLikHevmCTYtVZ+JgTQsvNwhp6cscLXNARgWeDcIAuwiBFBz9xwdXvHrfxVS903ZR732/C1N3nI+5G8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 01:59:25.8114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8105768b-734f-4ef7-0000-08d58f988a95
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0534
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error injection is a useful mechanism to fail arbitrary kernel
functions. However, it is often hard to guarantee an error propagates
appropriately to user space programs. By injecting into syscalls, we can
return arbitrary values to user space directly; this increases
flexibility and robustness in testing, allowing us to test user space
error paths effectively.

The following script, for example, fails calls to sys_open() from a
given pid:

from bcc import BPF
from sys import argv

pid = argv[1]

prog = r"""

int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
{
    u32 pid = bpf_get_current_pid_tgid();
    if (pid == %s)
        bpf_override_return(ctx, -ENOMEM);
    return 0;
}
""" % pid

b = BPF(text=prog)
while 1:
    b.perf_buffer_poll()

This patch whitelists all syscalls defined with SYSCALL_DEFINE and
COMPAT_SYSCALL_DEFINE for error injection. These changes are not
intended to be considered stable, and would normally be configured off.

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>

---

Dominik,

I've updated the patch to support compat syscalls. Please let me know if there
are additional changes to be made.

Cheers,

V1->V2: added similar mechanism in compat.h, clarify commit
Based on 4.16-rc6

 include/linux/compat.h   | 3 +++
 include/linux/syscalls.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16c3027074a2..857ddb1cfedf 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -33,6 +33,8 @@
 #endif
 
 #define COMPAT_SYSCALL_DEFINE0(name) \
+	asmlinkage long compat_sys_##name(void); \
+	ALLOW_ERROR_INJECTION(compat_sys_##name, ERRNO); \
 	asmlinkage long compat_sys_##name(void)
 
 #define COMPAT_SYSCALL_DEFINE1(name, ...) \
@@ -51,6 +53,7 @@
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
 		__attribute__((alias(__stringify(compat_SyS##name))));  \
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);	\
 	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));\
 	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..e8c6d63ace78 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
 
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
@@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(SyS##name))));		\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-- 
2.14.1
