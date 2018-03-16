Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeCPIQW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:16:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:1833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeCPIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:16:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="25006369"
Date: Fri, 16 Mar 2018 16:15:34 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Martin Brandenburg <martin@omnibond.com>
Cc: kbuild-all@01.org, Mike Marshall <hubcap@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH martinbrandenburg] orangefs: orangefs_write_end() can be
 static
Message-ID: <20180316081534.GA15547@lkp-wsm-ep2>
References: <201803161633.LJb0owl8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803161633.LJb0owl8%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 27dd09ddfeca ("orangefs: implement writepage")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b9b9d65..9999151 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -85,7 +85,7 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-int orangefs_write_end(struct file *file, struct address_space *mapping,
+static int orangefs_write_end(struct file *file, struct address_space *mapping,
     loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
 {
 	int r;
