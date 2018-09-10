Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeIJTza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:55:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:32469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbeIJTza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:55:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 08:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="262237990"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2018 08:00:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzNgQ-0002n8-7G; Mon, 10 Sep 2018 23:00:58 +0800
Date:   Mon, 10 Sep 2018 23:00:29 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     kbuild-all@01.org, David Sterba <dsterba@suse.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <jbacik@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] btrfs: btrfs_run_delayed_refs_for_head() can
 be static
Message-ID: <20180910150029.GA11874@lkp-wsm-ep1.lkp.intel.com>
References: <201809102215.95hxOLVe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809102215.95hxOLVe%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: ac75a14eb672 ("btrfs: Factor out loop processing all refs of a head")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 extent-tree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b0882b6..719f1bb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2537,9 +2537,9 @@ struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
 }
 
 STATIC
-int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
-				    struct btrfs_delayed_ref_head *locked_ref,
-				    unsigned long *run_refs)
+static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
+					   struct btrfs_delayed_ref_head *locked_ref,
+					   unsigned long *run_refs)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
