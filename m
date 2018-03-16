Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeCPUiy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:38:54 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:55584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751672AbeCPUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:37:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 3/5] KVM: VMX: Bring the common code to header file
Date: Fri, 16 Mar 2018 16:37:24 -0400
Message-Id: <1521232646-79580-4-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:404:65::28) To MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d13dfab1-3e2a-4601-b63b-08d58b7dcc9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:Sw5HHjg8FsUGTOO/CjphecgdJ0TkpAYZRyLKkneLIQyqaiuJxZRbNuszmHUDmo6f/CzaPvDNEwmTRtV6WD3+HmNsJhgzdHqJM1Lvj22lRqDxR6y4/E6BTY/U4p/NiC/oTh7S/48F+pad6r+LDT62mPiCOkZCYTrUsfX+wY/3I1OPvTabTrMywZEZQPj7pEvG2PuOAAsS+dncXugjikKgbNOiKJWDfmjrwmFSqajQuIhdJBSbjNtPLMmbXrr93qPo;25:NE0nmXf/G1lkSEcvJJgJ+oMDAkSEZre/BkfYaJM9tktsmBzex0rmbAK+hNdtcy+291AcQirHVekNIJcTYbGVQM/1pvG104LeSEjzpPa9m2kFMfs96jkT/G3q+sr478JtTlSTE7O+/GtzB+AYfG8SOjEXBMIN6gJMKe0P30pwKzwo/F06Spcid7JffbJqnpbaJzczcP8Va10Pgob7I0EVMUjRGvb4MX6bR258tDGi2avDsyQbkl8uaQLVqB2X5WovciBFtLtaFg8z3AZGgFsBdpGpvWB2pw/ucDgea+DK2DUbAhPvMZSUq+VACx2JOw+dIg4nwXjrPTed4ahwn0ZHJw==;31:XT8unQ77009500eLV8EM+2LkY0+QIpJXWiSzD7Qwd+9RhX7+ipyfk7nPHKuyXav2z9cFkiwmXs0SRAAKl1TJY68lNk5Zf14lRN8rvlC23fCRHNVjGIsD2DNrgASEaSGJCjDfYMCCrdCmvrJDkwQuM+ZfDNZZ+QOr//52csFoItfRAwsO1e7fPc6svu33jSDeTEARTxEQKtqDQiRcwrP4nKo6CpNNHGH/s+H12C4KVmo=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:eFIc2Ench1KMsWTsimYE6+ZTtREf7MMh7e/uuvCn0YYaVFdLephZVpgUN0d8EFCE8KRPKqzyFhbfiovzAeP+u/u7saSsidAkhGAsslyz/B/g6r85K/sMC+SP11ml/inDV1jvXQaIK9Pm9qAMMAWaC3RdTAMgVKWYtkZZ5njCfW91jiQZiCOL0t52o3UsBGvIo0vs69CTUunMY4WIPHl54s3P+q3cDYGUE88qer/36U4N28BGus2pmaJ9a0Rdg7wF9GCquDikx4Ne23oAXZodMCkwpnbETFzRRzXAV+Hrywy1w7gkySYARg/MH3KfwbEav7NmnqgZ4JbvqJQh+IMAxx/PMKuuZqlyWrAgWtvZuSvSUFkuhSNwkMXbNTo2KVE0j9BH8dQwl8QDK1KvH/J7Jbr5d2Ahv3FtRkTktqH1ln8UXXLLqZgO2IuW+cbz7pJjRszfkT01AbLoicX4PKCI/VrMh+Y39UReQEavALODkQ0cH8Ybm3MkGWSBusZ9/Fcb;4:snK0ZmkOhJ9Xsw6UTfsq4IJN9FND7kcHZ6UkvcWf8dbj62Zs8GR6+LW+4sEFXOx9lR/zf63tGpDKHOownMEeq7GAeOC0xvcnGfCINDjgQrvuIrFewmjsWEBt3h9F9pKBxbmcin3+2NCgJ9QKOSJ1LKTxqehGCcwimnsA2BTjg8F02fcyuKg0iOduaOtx3XCJ+5mzg/L+DGUVisuJAwb9KZNsMo0EfNOdsQhVUbXSQexSasIRqqS2NTSPr4uJWhRCYVJY48It2Mza/yPEA4uPl7H1oLxpdmwJCQARFnOqv1YEe96iDCRrXOwsiIwKpW7Q
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776E521E087944C3336D32495D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(2950100002)(16586007)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(66066001)(97736004)(8936002)(4326008)(50466002)(48376002)(52116002)(51416003)(7696005)(68736007)(53936002)(76176011)(72206003)(36756003)(105586002)(53416004)(2906002)(6486002)(47776003)(575784001)(5660300001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1776;23:zps4jkykqo36Jtiw7zf/RadSG09OSpTe2ZHpd3uws?=
 =?us-ascii?Q?xcPs/EUGFsRojuZ2A9sBlW44JrcZ8S1Mta9El/3ZiMSK/Ko7cBJQDIqDcH20?=
 =?us-ascii?Q?9F1KV+agEf/ZMcXLjXsnB5dAcqUTfNHAaZtRazpyG3Vk3WSo7PhBk5LNRbrJ?=
 =?us-ascii?Q?7I9yPP6HDhUpzIsccDKON6ZTtfdNlEcriVz0UpKeEIYLhd02CUrA2mrSi54k?=
 =?us-ascii?Q?5b5XPjZtnMeIzUgp7E68abR6fXyPwz8NOl4raQo8zMrieNnKvi5OsDJKPr+6?=
 =?us-ascii?Q?h/fKpMPoGluJn9JoucPe0eGpyJGoN/jTIXeu5FnmliMbqMYXOK+MxxSXICdR?=
 =?us-ascii?Q?IE8ZiKjH89l54UEJIeUBEhgzEWXqq7inJXpyY/umiy/LA+Zr5kODfh96QqeK?=
 =?us-ascii?Q?yDdlPiI7Ty7YJdzPgsJTtuYdCTDyfQIGDEvWNuOChyJezV8Vx12dx/3O//Ch?=
 =?us-ascii?Q?4utseoF5xfOZi5Yu6u655mWNRLJedp6yR3BIta/9Q/Oh2NRU8hUUQmu4//w/?=
 =?us-ascii?Q?vmbTBz/yqnI7IlsPTOve8dJLI+fMY0a42RUoU9sw+zmwUjkkWXM///rL4sJ1?=
 =?us-ascii?Q?LGnMyBrnJaXD6BVjMAxyp+C0sTJCWxN4MFlgkulBF5qnTUyIOZPfNvtfAKof?=
 =?us-ascii?Q?KHN/SxuaIzHUQrPMH9KT7hSpUYPC8KGod3/lNaB1n73O/JgBj+FpSG4BiV/b?=
 =?us-ascii?Q?bk62Q57tUwhx0umibpjrU37CrWOSHBCnohIOykOZGqShSRMQCTahDlyyYd1V?=
 =?us-ascii?Q?wM5tCXWwRzUpJsL/3MX1/aV/leEBBDqxjMh3iUsw68xeDQ8HnH7G1VeNL06H?=
 =?us-ascii?Q?Sj0XR38PlIazrZc5JQpVyhAaW5nBGd/sH4oRnKrm+0y9cjSbOdsTjPredn6z?=
 =?us-ascii?Q?2PF6XmjkVnxLkesyQoM2Ww0d7xEuKzM2f9ciTXADq7BkFwOHfFDLOp06EL0X?=
 =?us-ascii?Q?AN4FPzhZi2zOAc5fD0BdDBpKyeHhvP9DBqhSR2iDjQ1haWuiWh4IQkMjrl1O?=
 =?us-ascii?Q?kbwd3cA03Wuqhu+WXLLNP6ov2eZ41zr+s75aK6jXJqaKlhIS8gyzwYxm/ZHp?=
 =?us-ascii?Q?k4IMFWvpzKH/pOLeYMCipc9erEJpoIFG8T7AnLi7Evwu8h6KSLacwna3nz63?=
 =?us-ascii?Q?1bI+iVF+ixG2AZj5Fjad2yOPqknRQpdsBwcxN2djbnQsFxxHA/qBQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: H0saZDZtUa94UAo5A+FXx2m0IMTFUjywH2wjq0XaS6p5WPvJ19e3TOxNk2rFcuBJscVlXu2DBetXg4BvrVESozCKaQ0JqyUdEZ/BsAOs/9vrpD4vEYTmtYXX9vrJeuW8kHqtDE9DHic8yHH1obJUjPx9b52FwETRwRmgISpeERit+7bG8UozuBweXHaMyM4h
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:ayRGt3iQqJVlUb+vkrBRtCZjYo7wgwhWXGHFYc+NOfGjUIxr5p/+q3ETijTe8+Vp5WxDcYaV8LlJUGDok3qiAIvcPX3x/63l21DOgFex5P82AkRfza2tn0zr8yOri6E9Ymo8Tz2CVQBBbWYYixIZBihsNvnTXj/8ogoSnYvuAPOgYbU6Flw16nyCW6CNf5vsYFobg/qwgxqjgQn4zd9fCF+2up61tw7fUy8hrVDjurcVINsBzwMQIFlB1prnct6iXkie3h8wSsR+Nk8Na4o9bySEiCyonXosWZS7nZitH6f13yo8QTpmk4bUJ55xGkLT9G3hhDQzJAenfuCDQbFsEMhn7QgOAeFj3Ju82CxzYzc=;5:xby9ofzbQV3eBF7eTPeegPnsLSpvbWkUZBs+rNhiC1xTRjK7TPNNidGKxbU6I757uEnO+hinPAyeEp6OAJZyYaUwtvSooXZV8jgHEHVEmabwTaWcmjHcTUIpK+7F224A43Fg/x8WP4eLxro4GeFu/QM2Q8C7wj4/5+EfVR7kFp8=;24:V+NlA4DLuTFXmZLtUzmcpeLV6qsH56SJDyIL67kn3NoW/y51cdh0S6LwZJreORY81efCgGw9BPgppHzQpXeWqre9JJFDDfXFS4RNAw413sE=;7:eAXE2eOcJB0SW4E0ueGnvfBw1Fyl2Q3uAIERYXJw7DkVAeqEobpMxPodcNSCWmcHY1H1V/0WmD/L/mTM7TjxZjKpWJdg+l0zWCTjykiAHG9cz4qU7rBoE00KmIGi42X6naFMliNMWVE7E+nt9gfVrCKjOzBLT2uh5Wqm00CvdP2GOKyKoyZSMdOLN9nIJebMJqoaXOI0artl1G+EXPiUKHPYA1r8iyIW1rgmAJmZ9RLZGAskd+nHGy7sPQuuvc2B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:nQl7c3a7FlLIvzNuP1waqO7eUEWmuAuknQKcBVLaLSgtcfDfGwRtXaluyI9m0YYSSWuN0OM+Svwd59N7gaafHTGwOloNUeJsMEW/hbR7WuVb5moG7rZj+LPXM7IRmyAhAxA7GjrjhjQoN9EzLh2g/HE7B6um3V5gIALnaAErB1muDCQ8rAFCwMYtZ2U6SCB43dC3RLsJc1ExboAzUloinSaJ5gE2qzTET/Rk6rlgDjsX47ycGZnYcZh/y9upoNvu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:54.7879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13dfab1-3e2a-4601-b63b-08d58b7dcc9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch brings some of the code from vmx to x86.h header file. Now, we
can share this code between vmx and svm. Modified couple functions to make
it common.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/vmx.c | 48 +++++++++---------------------------------------
 arch/x86/kvm/x86.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b992d81..ba826b6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -156,25 +156,18 @@
  * Time is measured based on a counter that runs at the same rate as the TSC,
  * refer SDM volume 3b section 21.6.13 & 22.1.3.
  */
-#define KVM_VMX_DEFAULT_PLE_GAP           128
-#define KVM_VMX_DEFAULT_PLE_WINDOW        4096
-#define KVM_VMX_DEFAULT_PLE_WINDOW_GROW   2
-#define KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK 0
-#define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
-		INT_MAX / KVM_VMX_DEFAULT_PLE_WINDOW_GROW
-
-static uint ple_gap = KVM_VMX_DEFAULT_PLE_GAP;
+static uint ple_gap = KVM_DEFAULT_PLE_GAP;
 module_param(ple_gap, uint, 0444);
 
 static uint ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
 module_param(ple_window, uint, 0444);
 
 /* Default doubles per-vcpu window every exit. */
-static uint ple_window_grow = KVM_VMX_DEFAULT_PLE_WINDOW_GROW;
+static uint ple_window_grow = KVM_DEFAULT_PLE_WINDOW_GROW;
 module_param(ple_window_grow, uint, 0444);
 
 /* Default resets per-vcpu window every exit to ple_window. */
-static uint ple_window_shrink = KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK;
+static uint ple_window_shrink = KVM_DEFAULT_PLE_WINDOW_SHRINK;
 module_param(ple_window_shrink, uint, 0444);
 
 /* Default is to compute the maximum so we can never overflow. */
@@ -6639,38 +6632,14 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static uint __grow_ple_window(uint val)
-{
-	if (ple_window_grow < 1)
-		return ple_window;
-
-	if (ple_window_grow < ple_window)
-		val *= ple_window_grow;
-	else
-		val += ple_window_grow;
-
-	return min(val, ple_window_max);
-}
-
-static uint __shrink_ple_window(uint val, uint modifier, uint minimum)
-{
-	if (modifier < 1)
-		return ple_window;
-
-	if (modifier < ple_window)
-		val /= modifier;
-	else
-		val -= modifier;
-
-	return max(val, minimum);
-}
-
 static void grow_ple_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int old = vmx->ple_window;
 
-	vmx->ple_window = __grow_ple_window(old);
+	vmx->ple_window = __grow_ple_window(old, ple_window,
+					    ple_window_grow,
+					    ple_window_max);
 
 	if (vmx->ple_window != old)
 		vmx->ple_window_dirty = true;
@@ -6683,8 +6652,9 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int old = vmx->ple_window;
 
-	vmx->ple_window = __shrink_ple_window(old,
-	                                      ple_window_shrink, ple_window);
+	vmx->ple_window = __shrink_ple_window(old, ple_window,
+					      ple_window_shrink,
+					      0);
 
 	if (vmx->ple_window != old)
 		vmx->ple_window_dirty = true;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d0b95b7..ca051a2 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,41 @@
 #include <asm/pvclock.h>
 #include "kvm_cache_regs.h"
 
+#define KVM_DEFAULT_PLE_GAP		128
+#define KVM_VMX_DEFAULT_PLE_WINDOW	4096
+#define KVM_DEFAULT_PLE_WINDOW_GROW	2
+#define KVM_DEFAULT_PLE_WINDOW_SHRINK	0
+#define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
+		(INT_MAX / KVM_DEFAULT_PLE_WINDOW_GROW)
+
+static inline uint __grow_ple_window(uint val, uint base,
+				     uint modifier, uint max)
+{
+	if (modifier < 1)
+		return base;
+
+	if (modifier < base)
+		val *= modifier;
+	else
+		val += modifier;
+
+	return min(val, max);
+}
+
+static inline uint __shrink_ple_window(uint val, uint base,
+				       uint modifier, uint min)
+{
+	if (modifier < 1)
+		return base;
+
+	if (modifier < base)
+		val /= modifier;
+	else
+		val -= modifier;
+
+	return max(val, min);
+}
+
 #define MSR_IA32_CR_PAT_DEFAULT  0x0007040600070406ULL
 
 static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
-- 
1.8.3.1
