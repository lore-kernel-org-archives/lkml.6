Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBFC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E239420660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E239420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937291AbeFSDCy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:02:54 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:50404
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937206AbeFSDCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:02:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AWEwBicShb/6c80XZcHgEGDINJgU8SK?=
 =?us-ascii?q?IN5lFZGAQEBAQEGgQ00kDiEKIF4HhgBhEACgl8hNhYBAgEBAQEBAQJtKIUpBiM?=
 =?us-ascii?q?EUhAYAQwCGA4CAkcQBhOFGAyqU4FpMxoCiC2BaIELh0mBDIEHgT+KUoJVAo0gi?=
 =?us-ascii?q?3YJjwmIGIUjK5JqByqBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IPAS-Result: =?us-ascii?q?A2AWEwBicShb/6c80XZcHgEGDINJgU8SKIN5lFZGAQEBAQE?=
 =?us-ascii?q?GgQ00kDiEKIF4HhgBhEACgl8hNhYBAgEBAQEBAQJtKIUpBiMEUhAYAQwCGA4CA?=
 =?us-ascii?q?kcQBhOFGAyqU4FpMxoCiC2BaIELh0mBDIEHgT+KUoJVAo0gi3YJjwmIGIUjK5J?=
 =?us-ascii?q?qByqBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90294693"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 11:02:15 +0800
Subject: [PATCH 4/6] autofs - make autofs_expire_indirect() static
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:02:15 +0800
Message-ID: <152937733512.21213.10509996499623738446.stgit@pluto.themaw.net>
In-Reply-To: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
References: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

autofs_expire_indirect() isn't used outside of fs/autofs/expire.c
so make it static.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    3 ---
 fs/autofs/expire.c   |    8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 4192f8002f89..b1f70bc45ca3 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -154,9 +154,6 @@ int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 			   struct autofs_sb_info *sbi, int when);
 int autofs_expire_multi(struct super_block *, struct vfsmount *,
 			struct autofs_sb_info *, int __user *);
-struct dentry *autofs_expire_indirect(struct super_block *sb,
-				      struct vfsmount *mnt,
-				      struct autofs_sb_info *sbi, int how);
 
 /* Device node initialization */
 
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 64e6eba2c628..5fb47a4ca48c 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -424,10 +424,10 @@ static struct dentry *should_expire(struct dentry *dentry,
  *  - it is unused by any user process
  *  - it has been unused for exp_timeout time
  */
-struct dentry *autofs_expire_indirect(struct super_block *sb,
-				      struct vfsmount *mnt,
-				      struct autofs_sb_info *sbi,
-				      int how)
+static struct dentry *autofs_expire_indirect(struct super_block *sb,
+					     struct vfsmount *mnt,
+					     struct autofs_sb_info *sbi,
+					     int how)
 {
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;

