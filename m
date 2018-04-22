Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeDVGbO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 02:31:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:64017 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeDVGbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 02:31:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,310,1520924400";
   d="scan'208";a="48896952"
Date: Sun, 22 Apr 2018 14:31:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Chao Yu <yuchao0@huawei.com>
Cc: kbuild-all@01.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [RFC PATCH] f2fs: load_nat_block() can be static
Message-ID: <20180422063109.GA10531@lkp-wsm-ep2>
References: <20180420015231.90679-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420015231.90679-1-yuchao0@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: c20dcf3ce26e ("f2fs: sepearte hot/cold in free nid")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fa09baa..ff9b682 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2031,7 +2031,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi, enum nid_state state)
 	up_read(&nm_i->nat_tree_lock);
 }
 
-void load_nat_block(struct f2fs_sb_info *sbi, enum nid_state state)
+static void load_nat_block(struct f2fs_sb_info *sbi, enum nid_state state)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs;
