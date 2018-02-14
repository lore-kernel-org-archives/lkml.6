Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031706AbeBNPnV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:43:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:57779 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031597AbeBNPnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:43:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="27847107"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] x86/platform/atom: Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date: Wed, 14 Feb 2018 17:43:16 +0200
Message-Id: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

While here, replace permissions by explicit octal value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/platform/atom/punit_atom_debug.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index d49d3be81953..156b445bcf4d 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -109,18 +109,7 @@ static int punit_dev_state_show(struct seq_file *seq_file, void *unused)
 
 	return 0;
 }
-
-static int punit_dev_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, punit_dev_state_show, inode->i_private);
-}
-
-static const struct file_operations punit_dev_state_ops = {
-	.open		= punit_dev_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(punit_dev_state);
 
 static struct dentry *punit_dbg_file;
 
-- 
2.15.1
