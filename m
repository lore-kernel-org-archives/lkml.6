Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEDBNu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:13:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:32040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeEDBNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:13:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="53048690"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH v1] lib/string_helpers: Add missed declaration of struct task_struct
Date: Fri,  4 May 2018 04:13:45 +0300
Message-Id: <20180504011345.63937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the commit 0d0443288f22 the new function has been
introduced which takes struct task_struct as a parameter. Though,
compiler doesn't know where to get information about it at this stage.

Add missed declaration of struct task_struct to satisfy compiler.

Fixes: 0d0443288f22 ("string_helpers: add kstrdup_quotable_cmdline")
Cc: Kees Cook <keescook@chromium.org>
Cc: James Morris <james.l.morris@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4397c52ec4a4..d23c5030901a 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct file;
+struct task_struct;
 
 /* Descriptions of the types of units to
  * print in */
-- 
2.17.0
