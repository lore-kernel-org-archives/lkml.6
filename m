Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeDDPEA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:04:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:56383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbeDDPDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:03:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="40642549"
Date: Wed, 4 Apr 2018 23:03:39 +0800
From: kbuild test robot <lkp@intel.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, mhiramat@kernel.org, oleg@redhat.com,
        peterz@infradead.org, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, jolsa@redhat.com,
        kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH] trace_uprobe: trace_uprobe_mmap() can be static
Message-ID: <20180404150339.GA48831@ivb43>
References: <20180404083110.18647-7-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404083110.18647-7-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: d8d4d3603b92 ("trace_uprobe: Support SDT markers having reference count (semaphore)")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 trace_uprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2502bd7..49a8673 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -998,7 +998,7 @@ static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
 }
 
 /* Called with down_write(&vma->vm_mm->mmap_sem) */
-void trace_uprobe_mmap(struct vm_area_struct *vma)
+static void trace_uprobe_mmap(struct vm_area_struct *vma)
 {
 	struct trace_uprobe *tu;
 	unsigned long vaddr;
