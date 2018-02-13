Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965752AbeBMUM1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:12:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:57867 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965619AbeBMUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:12:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="174725001"
Date: Wed, 14 Feb 2018 04:12:14 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Martin Brandenburg <martin@omnibond.com>
Cc: kbuild-all@01.org, Mike Marshall <hubcap@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH martinbrandenburg] orangefs: orangefs_write_inode() can
 be static
Message-ID: <20180213201214.GA8637@lkp-wsm-ep2>
References: <201802140422.EQO7RreI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802140422.EQO7RreI%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 525e7273bc80 ("orangefs: let setattr write to cached inode")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 49bb1ce..c38310c 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -150,7 +150,7 @@ static void orangefs_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, orangefs_i_callback);
 }
 
-int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
+static int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct iattr iattr;
 	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
