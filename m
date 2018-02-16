Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeBPVaC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:30:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:56939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeBPV37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:29:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18318651"
Subject: [PATCH 3/3] nospec: Include asm/barrier.h dependency
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 13:20:54 -0800
Message-ID: <151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nospec.h header expects the per-architecture header file
asm/barrier.h to optionally define array_index_mask_nospec(). Include
that dependency to prevent inadvertent fallback to the default
array_index_mask_nospec() implementation. The default implementation may
not provide a full mitigation on architectures that perform data value
speculation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/nospec.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 172a19dc35ab..e791ebc65c9c 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
