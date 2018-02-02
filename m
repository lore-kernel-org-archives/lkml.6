Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeBBTNV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:13:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeBBTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:13:13 -0500
Date: Fri, 2 Feb 2018 19:12:20 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] Fix typo IBRS_ATT, which should be IBRS_ALL
Message-ID: <20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a typo in commit 117cc7a908c83697b0b737d15ae1eb5943afe35b
("x86/retpoline: Fill return stack buffer on vmexit")

Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4ad4108..5b778d2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -201,7 +201,7 @@ extern char __indirect_thunk_end[];
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
  * retpoline and IBRS mitigations for Spectre v2 need this; only on future
- * CPUs with IBRS_ATT *might* it be avoided.
+ * CPUs with IBRS_ALL *might* it be avoided.
  */
 static inline void vmexit_fill_RSB(void)
 {
-- 
2.9.5
