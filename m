Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeBBWYr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:24:47 -0500
Received: from terminus.zytor.com ([65.50.211.136]:58505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBBWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:24:38 -0500
Date: Fri, 2 Feb 2018 14:19:18 -0800
From: tip-bot for Darren Kenny <tipbot@zytor.com>
Message-ID: <tip-af189c95a371b59f493dbe0f50c0a09724868881@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, arjan@linux.intel.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com, ak@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, bp@alien8.de, dwmw@amazon.co.uk,
        mhiramat@kernel.org
Reply-To: dwmw@amazon.co.uk, mhiramat@kernel.org, ak@linux.intel.com,
        thomas.lendacky@amd.com, darren.kenny@oracle.com, tglx@linutronix.de,
        bp@alien8.de, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, arjan@linux.intel.com
In-Reply-To: <20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com>
References: <20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Fix typo IBRS_ATT, which should be
 IBRS_ALL
Git-Commit-ID: af189c95a371b59f493dbe0f50c0a09724868881
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af189c95a371b59f493dbe0f50c0a09724868881
Gitweb:     https://git.kernel.org/tip/af189c95a371b59f493dbe0f50c0a09724868881
Author:     Darren Kenny <darren.kenny@oracle.com>
AuthorDate: Fri, 2 Feb 2018 19:12:20 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 23:13:57 +0100

x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

Fixes: 117cc7a908c83 ("x86/retpoline: Fill return stack buffer on vmexit")
Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com

---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d15d471..4d57894 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -150,7 +150,7 @@ extern char __indirect_thunk_end[];
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
  * retpoline and IBRS mitigations for Spectre v2 need this; only on future
- * CPUs with IBRS_ATT *might* it be avoided.
+ * CPUs with IBRS_ALL *might* it be avoided.
  */
 static inline void vmexit_fill_RSB(void)
 {
