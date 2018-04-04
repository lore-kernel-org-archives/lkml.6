Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDDHm4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:42:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:31150 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeDDHmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:42:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="43876053"
Date: Wed, 4 Apr 2018 15:42:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>, aarcange@redhat.com,
        luto@kernel.org, torvalds@linux-foundation.org, keescook@google.com,
        hughd@google.com, jgross@suse.com, x86@kernel.org, namit@vmware.com
Subject: [RFC PATCH] x86/pti: pti_clone_pmds can be static
Message-ID: <20180404074227.GA20188@lkp-sb04>
References: <20180404011011.82027E0C@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404011011.82027E0C@viggo.jf.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: a7e2701bf2b2 ("x86/pti: leave kernel text global for !PCID")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 3ee9ceb..057c8ff 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -282,7 +282,7 @@ static void __init pti_setup_vsyscall(void)
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
-void
+static void
 pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 {
 	unsigned long addr;
