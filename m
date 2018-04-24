Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDXPma (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:42:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:42737 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeDXPmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:42:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="40111098"
Date: Tue, 24 Apr 2018 23:41:16 +0800
From: kbuild test robot <lkp@intel.com>
To: jeffm@suse.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [RFC PATCH] procfs: proc_pid_files_link_dentry_operations can be
 static
Message-ID: <20180424154116.GA11745@lkp-ne02>
References: <20180424022106.16952-6-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424022106.16952-6-jeffm@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fc3babee0341 ("procfs: share fd/fdinfo with thread group leader when files are shared")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a847b..deb0950 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3565,7 +3565,7 @@ static int proc_pid_files_revalidate(struct dentry *dentry, unsigned int flags)
  * directory, there's no more work to do beyond pid_revalidate_inode, so
  * we just use the regular pid_dentry_operations.
  */
-const struct dentry_operations proc_pid_files_link_dentry_operations = {
+static const struct dentry_operations proc_pid_files_link_dentry_operations = {
 	.d_revalidate	= proc_pid_files_revalidate,
 	.d_delete	= pid_delete_dentry,
 };
