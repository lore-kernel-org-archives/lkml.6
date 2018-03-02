Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936410AbeCBQSM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:18:12 -0500
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:42045
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934083AbeCBQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:18:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org
Cc: babu.moger@amd.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/3] arch/x86/kvm: VMX: Bring the common code to header file
Date: Fri,  2 Mar 2018 11:17:35 -0500
Message-Id: <1520007456-85293-3-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com (10.171.172.155) To
 BN6PR12MB1761.namprd12.prod.outlook.com (10.175.101.22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 080d59b5-3a33-4136-71d4-08d58059294a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1761;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;3:QIWvvBAsiWKKktUVA5AZDbNF0W/Z72HxrJOV67v0kVeVkl//1iYmduMycsHZPNIyjP1KDAKauu/lBZEHZkFvOMQFt2W5QAjNMAGStf3vT49OWhnbQ2KxYCWwcvqOskW3taJv8JIQODQYz9xVVVFakvHzpIKp5DWzd5TzTW+zhFwmoLk1NZmmI1nIlFNk2HbuSZG8KEwXGDL0S2wcEb+xYmIQVCtNdmvSc6LPiQ0Q5OeF9hCyjnLa0KCXnbdJNogT;25:N62J0YApbgcWJIRRZbBC8dwDODD2zZZfTo12zbglsN+Xkof2qQhLSPEsif4Wd3SULW52vm7VWwrE9V10cI4C0a4VC/Zy3ZoESBxGIqUPr8Nr6GUiUNu7rXBKCqIcK1Wvw7M9ovGuAKkoZqkPRL4EMgutekCIGjzv8q4/E/K681Ubqslxs7sg+AHGhFVBvtFDpgubgbbTkjJLqN8AiCboBjtKfCRxakou4ebi6DzU6TmRJvK6MkQDLHc+B6mV13kvRztp5AOFyOYGl2dsZB0whzQd2ZjnL2tYYE4/5WLtINndrvk5hmnUg5Hnz8wd21pXL4sV6wSZIHbXfJYmbS8S7g==;31:bqYw8AfbRJyMtZI4wWbQN3eauY7yR/525UYKHFVhtk8gcSgHkRXgKT9EDOqjC1MxDN230FbyrQ/NtP+jQunY34y8AqeKh6EtcEq5szFwU5ZZNQSyTpV95oZ6Jz9qoTy7NcBACjulrb6zA8aDrgIg7G0ELy4HIE6mNdyZ1g7ZNB9DvpOhzG3IO27ZvTLVfypDBoVD5wKtUcdtbEyJolr47qBx3WEo0tP/V6stMcCKjpg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:tQINrjxDYIfTCd/VYQ2G8JStG7Q9hH4XMtyNkB8XT4tQMbHOhkJiz2P/dy3wC0GamZJC6ml6iccI31UqRiNyR4sDyipHjWhfwKe6lGzJ8ZEuifBh+6vGFXk1x2ao7U5/xTcv9U/cyCco/4prBhQ2Q64hNZahgDAc6DsmVxiHrbjx9Ffavz1W5HPJEhQsDPvv/hPeAi8KIlZ2EuCoyE5tTBp8wE0SCqvo39Y75nPUKBfTUjl31OQreIjYhei8/RzQHD8Mu3qLCiXF00OF6Uks5VRNDwtGS2RDSsk071IDL2QvtDBXWdm2goLyrHontj5lF7wXTNjD8vwgHyKwx2cyK1wf+EEeKilGEtA68CnxZIPN0oqe6a/lLu32E1FaBFn2deGXAjloSGhgnjpKYtNnKRnSQsR1/2ps+fmfrsMJaH/JMz2iydFx/2pc2xim/9QLmbFeP4NF9p70SgIs824aZeAn7odytkY8VaB8BcI7xTulD8GoQh7iXdQ1/FNaxmWs;4:Vkv0cpmNou+qu8I0dXZMsAV/FL0Fn9Mvs2BWiqNiGjiC9wzvtheYHEgUVNli6Nj7niPYn6Xn+60aQ4jJCm8s1cuqq/5pWarKBmvKx3A1Uis6FtQWWRvZ1Law/FgOP/v3g04QQBLVNMl1ba5EFiEna+7LQaMQZk+XPCHX38dpVoitCwAZO2MZAiwYUN5Wo8dbn0uohjrykLaQrmgRbnZBULZIcSWGJOGpY3Cfz1p2nmo+SQv3QiqP75WVcPUsERRVDMPhVMvEV1tvrM7qwpt7tNB7l+plH0LzE7WbvHNOJBAJoadwvIWRDM7fSxRhne0P
X-Microsoft-Antispam-PRVS: <BN6PR12MB1761E7DD255F92087187E54D95C50@BN6PR12MB1761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1761;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1761;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(51416003)(2950100002)(386003)(53936002)(186003)(26005)(7696005)(6486002)(52116002)(16526019)(68736007)(6666003)(4720700003)(76176011)(106356001)(16586007)(59450400001)(316002)(8936002)(50226002)(4326008)(5660300001)(36756003)(81166006)(86362001)(48376002)(50466002)(575784001)(81156014)(2906002)(7736002)(3846002)(66066001)(105586002)(305945005)(8676002)(53416004)(47776003)(97736004)(6116002)(478600001)(72206003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1761;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1761;23:WU5l4TgvrJD5E/OZMJ4HTsXvltM0epbZc6sn/idxP?=
 =?us-ascii?Q?gaiMlg2WTzeO3wct9taz6QNY5fCM5b2nh5amAVYGKaI1dQ3v+X8PUz+7+0Nw?=
 =?us-ascii?Q?+L/tLFPlvm1MpWt9s6MYD/0glYHsJRJ7vhm71znaCPJyZezv03rBmU1cZHzL?=
 =?us-ascii?Q?Rd5MhgCuOZk8g+bQHXxXuhJiVWSc6OBC6gOnpg/nEiSy5DBrHl2PxCJm8Q6n?=
 =?us-ascii?Q?3DEP+OA/mliww03bOkPRc2NUgmfUzelsbjjWq6OU/SyHNYNyZXxVgzwlq9W7?=
 =?us-ascii?Q?5msznd4H8/t6GofL9YoYNpacqkI258fVUTT3KRe45rwzxYw5OWlDgYsF86JJ?=
 =?us-ascii?Q?tlPwwPBbwshs3Bec5ryuOayuuqBLMQBSokqGq8/8YbLpBO0on3VsDLcOg6nK?=
 =?us-ascii?Q?OuD7BMitiZkn1HRycb0If8K05EHn7ODmbzCEC8vKJDV78Ibp0RV2kais07JD?=
 =?us-ascii?Q?Fe0sMQriChXt61egwIzfdAzk6UScOGY4xbtSnuFsCRnp13x3nzyAAPqgB26a?=
 =?us-ascii?Q?devIZHwjePhJoOo9bt0hux6T5W05msrkvIHfGDDved2iq0jtls1wxyVP7WFy?=
 =?us-ascii?Q?cRDxqYMXUX0ibH/OJfiNpl7rtgdfyhkY3iGp9DY+pS/WhR9byhnYZyMMKKH3?=
 =?us-ascii?Q?cknh5rqddtDvX8aGkqIUsUnKAPjfqtljEFSWjn55Fpz0jKyIImwJM4k5W9j1?=
 =?us-ascii?Q?Y0agZx9tRd0Qa9bN1pJD3ljAK58xiT2AjoE7FkwHqlkRm0mpFex+94BwWxz7?=
 =?us-ascii?Q?5i3RPv+1ecwot17GgxW9nwLjtH2FfgiFnYJAM2a9ERPk5Gui6Jj5VIMk0nB7?=
 =?us-ascii?Q?vm2qKVbDtYFQrGT9aIbmLMm6UOFlPhdww88QB+LyuSkGPtFGUvSOdnicH5SM?=
 =?us-ascii?Q?BUhCk5NVVBXx1gyHPw8vLlBRJyr+HynORERR5p0axQyud6qAO/gPA+6Awj/u?=
 =?us-ascii?Q?IOBCn+5BNFy0Vrv39eIZQ6jJjnW+kDnnfhIphzVljjnBcvrkCvF8at+DYZIh?=
 =?us-ascii?Q?gynhQTBYxPMHM1YaQj3NR6EwqUtWDkROyIHt7QQmLjGzTq0Mno8e7zUcFh5j?=
 =?us-ascii?Q?C4haNBFUi366TOkAjjUHQXBnK4MIC5Q8jXJVsuVhmwaUY5UgKSesQ1/cg0F4?=
 =?us-ascii?Q?n9Ytf/qs7ujKc37LbQKMyRg6sDc2y+ykH6Js8955MW9us1ja5rt9bE4PeyKm?=
 =?us-ascii?Q?vjtaQqA4pGjYSc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;6:mlx2NnL/vmCeO2vHE9QBp+PIsV1wB/udW9gjTFHEMev3yo5T+dMkso0SNhHEMSmcb91AV6tHj6noUS46+nOqvip4BmD+lhkebClRt2pEQIu/0z3Wj8HqL4BWJTEx+CkoBJ7yYo4Qh1WVJ0x2aPb3MfivVKvG7EgfHjpvyjWnViPpKFwkKTV++szf3v9g+eanLJEis7ARAhQsxj/j8+FWNLJmMInKVCQVd3pIJO88AvC+UYl9nHmLjYVdb5Hr+OpMQiHGP8odOL1YboRzleFS7I7589UFPIBfViTDeLSy82icStKOwIgS/NJwOt83jQsaRHeUVDfJ/UcbTXYt1hzT6H2mCWSkbjJM6COy2zvUj/Q=;5:BXgmhxF4BUTkxddCqnOw9vPCgfiBfhDX6PxGGps0J6RIGJ4sXuQxVwlKBBrVhNLzKg/0buCtIU+j9ov6G68af9cTNy/wNVVTZPzxGsgkq0e/9xDyiY0duGYYeksOPjTsO9Tb672BLt4qqa7CzQdnpswKWKoGpNYuEnbGuBHrr9g=;24:Ay15W1ns5Rb4C0NApkYG8WCRfDbcL7+wCp+i6uUig6HS5/kWcxuH38et2rZtblcVyrDTF7Ztno3c0RZuU0J5lJAP0NUgrWmETyy3nAEHFJU=;7:ZJgSR+E4vj32A/B5MZqENuC4egg9RlOLVS/ctktVdkmNEz5qFpZbFtPq65OEI2R4uHA4suMTK0ydad6s6oRpW0Fr5eB2m8/NRxhUFBDaH2dTcwmrGfGR5PjGcOxeOnBZH9wfIe4z4AG2S220rL2YLRz/Vu3PHHxkJWD/yakqYPDOZNisD0+1Mp+FrpdKM6M0vGaJ20ilFI+waGCyvPLytL2hwIA95pqKY1FjLdY9R7jJAK67wa7FDUKh0JFsAZRU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:pa17tYMAMoqP6wzAsbBvn7VqHwn6WFeWSYH3KxhZtfZNj4/gVH64JusWS+iBo+tjONCbBmSjUSvGmggmPQo8sw7XEDjQwE6qDoAbyg/qbyiXGoW5Y7gV5xF6GEI2hGRaPK3MBfc3qQGX+RpihvlooR9jdWPZ8IVCafqUNlpEroajAnw9xwxK/ECtaK/NmeqdPmcSHUolTAymxkFhA33GLjFiRroYsmFlhS6J5G9Dz3BXmP61vVbrMex/6bdWAXi1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 16:17:57.0828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080d59b5-3a33-4136-71d4-08d58059294a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is brings some of the code from vmx to x86.h. We can
share this code between vmx and svm. Modified couple of functions
to make it common. No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/vmx.c | 53 ++++++++++-------------------------------------------
 arch/x86/kvm/x86.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c829d89..6b9fa7e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -156,25 +156,19 @@
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
-static int ple_gap = KVM_VMX_DEFAULT_PLE_GAP;
+
+static int ple_gap = KVM_DEFAULT_PLE_GAP;
 module_param(ple_gap, int, S_IRUGO);
 
-static int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
+static int ple_window = KVM_DEFAULT_PLE_WINDOW;
 module_param(ple_window, int, S_IRUGO);
 
 /* Default doubles per-vcpu window every exit. */
-static int ple_window_grow = KVM_VMX_DEFAULT_PLE_WINDOW_GROW;
+static int ple_window_grow = KVM_DEFAULT_PLE_WINDOW_GROW;
 module_param(ple_window_grow, int, S_IRUGO);
 
 /* Default resets per-vcpu window every exit to ple_window. */
-static int ple_window_shrink = KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK;
+static int ple_window_shrink = KVM_DEFAULT_PLE_WINDOW_SHRINK;
 module_param(ple_window_shrink, int, S_IRUGO);
 
 /* Default is to compute the maximum so we can never overflow. */
@@ -6640,40 +6634,13 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static int __grow_ple_window(int val)
-{
-	if (ple_window_grow < 1)
-		return ple_window;
-
-	val = min(val, ple_window_actual_max);
-
-	if (ple_window_grow < ple_window)
-		val *= ple_window_grow;
-	else
-		val += ple_window_grow;
-
-	return val;
-}
-
-static int __shrink_ple_window(int val, int modifier, int minimum)
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
+	vmx->ple_window = __grow_ple_window(old, ple_window, ple_window_grow,
+					    ple_window_actual_max);
 
 	if (vmx->ple_window != old)
 		vmx->ple_window_dirty = true;
@@ -6686,7 +6653,7 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int old = vmx->ple_window;
 
-	vmx->ple_window = __shrink_ple_window(old,
+	vmx->ple_window = __shrink_ple_window(old, ple_window,
 	                                      ple_window_shrink, ple_window);
 
 	if (vmx->ple_window != old)
@@ -6706,8 +6673,8 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 static void update_ple_window_actual_max(void)
 {
 	ple_window_actual_max =
-			__shrink_ple_window(max(ple_window_max, ple_window),
-			                    ple_window_grow, INT_MIN);
+		__shrink_ple_window(max(ple_window_max, ple_window),
+				    ple_window, ple_window_grow, INT_MIN);
 }
 
 /*
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d0b95b7..d1fb7bb 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -9,7 +9,41 @@
 #include "kvm_cache_regs.h"
 
 #define MSR_IA32_CR_PAT_DEFAULT  0x0007040600070406ULL
+#define KVM_DEFAULT_PLE_GAP           128
+#define KVM_DEFAULT_PLE_WINDOW        4096
+#define KVM_DEFAULT_PLE_WINDOW_GROW   2
+#define KVM_DEFAULT_PLE_WINDOW_SHRINK 0
+#define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
+		(INT_MAX / KVM_DEFAULT_PLE_WINDOW_GROW)
+
+static inline int __grow_ple_window(int val, int base, int modifier, int max)
+{
+	if (modifier < 1)
+		return base;
+
+	val = min(val, max);
+
+	if (modifier < base)
+		val *= modifier;
+	else
+		val += modifier;
+
+	return val;
+}
 
+static inline int __shrink_ple_window(int val, int base, int modifier,
+				      int minimum)
+{
+	if (modifier < 1)
+		return base;
+
+	if (modifier < base)
+		val /= modifier;
+	else
+		val -= modifier;
+
+	return max(val, minimum);
+}
 static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.exception.injected = false;
-- 
1.8.3.1
