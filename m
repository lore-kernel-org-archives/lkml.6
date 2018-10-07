Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A78C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258A92089D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="zfUhOYRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258A92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJHGg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36753 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJHGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id a85-v6so11101136qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WJ51dxv+psxts3n9n4dYDWv3yfTVCNwV6wMKD8V5fQ=;
        b=zfUhOYROVY8mQuZy4xg+kW8T4vvTTob1fwOEL0lBEpDnq5cE2ghriFb5FsXkwsAxIr
         rXA2P7Y4IGT0jr3kPWxy8/llSQcUS6ERkZ1c7U9eSM6uTbNcLJvMx4gPkCXyJguo8RA8
         lISO+2U2ECVyOX/YFQpuAH9342hqWH83gmsysHapPUR/ty/VZUAaTkmabbyWa59N44s2
         Jbvi9lff5+yVxO1Jz6AYzBNlQGwHlF/tCmq3b9njE3+rESUougHDkDELtCUvxbfc3faO
         4w+NedyQ/hE4QSrNQjFJMqkEoBbca/mgViSpQziw6JLbDNLxnx2ovtyWR3XGLfUD4egP
         xP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WJ51dxv+psxts3n9n4dYDWv3yfTVCNwV6wMKD8V5fQ=;
        b=d6Yx8rkZxIIKrElFdLAs6jT6dxl93cYvHxZrnXvCzqppahNWLahFU5PJT8Ol4THchH
         WzYEh4ON1w7FRkRAfGsu2zB67ytBRKfr21W9jQbAYVoLZ0qZmloBXzGwprai3Qw0jupq
         Y9m2/qhMXSJVw47mc6fFD3twDtRjV5RAhW2EQrM4/YpXQ3p8v3MHmmU+ru9Lw6b6jUF6
         Wd+n2wUn1lV0xSw6JVg6w+W4/gLok8hByzfjcMWCzGJ80xh+C/vUQ8jqsnATQi3YzXzI
         x6LHycXfMOryq65dWQwc0AJnYRlonTcuD9XKtSVn97pNVZlMg09goY4RLs8kmXvku+ei
         I4GQ==
X-Gm-Message-State: ABuFfohcsH2u87YFvnLdc49K5dIux5aI1dpFDRD6PXpWmbyxz3nKVsWO
        LAnn1QHUnt9DKI7NdTRvnxyKCQ==
X-Google-Smtp-Source: ACcGV63yuGXSr3P0nPQ6xUq+rGgdSBALBmU+o4xis1bFDv4eXhfqGT5jDRnNzSDGzdG7hc3ykzsCyw==
X-Received: by 2002:a37:c050:: with SMTP id o77-v6mr16771688qki.228.1538954883978;
        Sun, 07 Oct 2018 16:28:03 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:02 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 07/19] orangefs: let setattr write to cached inode
Date:   Sun,  7 Oct 2018 23:27:24 +0000
Message-Id: <20181007232736.3780-8-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fairly big change, but ultimately it's not a lot of code.

Implement write_inode and then avoid the call to orangefs_inode_setattr
within orangefs_setattr.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 11 +++--------
 fs/orangefs/super.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index ec3996a61f92..b16b11294573 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -207,8 +207,8 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
  */
 int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	int ret = -EINVAL;
 	struct inode *inode = dentry->d_inode;
+	int ret;
 
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		"%s: called on %pd\n",
@@ -228,16 +228,11 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 	mark_inode_dirty(inode);
 
-	ret = orangefs_inode_setattr(inode, iattr);
-	gossip_debug(GOSSIP_INODE_DEBUG,
-		"%s: orangefs_inode_setattr returned %d\n",
-		__func__,
-		ret);
-
-	if (!ret && (iattr->ia_valid & ATTR_MODE))
+	if (iattr->ia_valid & ATTR_MODE)
 		/* change mod on a file that has ACLs */
 		ret = posix_acl_chmod(inode, inode->i_mode);
 
+	ret = 0;
 out:
 	gossip_debug(GOSSIP_INODE_DEBUG, "%s: ret:%d:\n", __func__, ret);
 	return ret;
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 61bec955b285..788869c8233b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -151,6 +151,21 @@ static void orangefs_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, orangefs_i_callback);
 }
 
+int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	struct iattr iattr;
+	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
+	iattr.ia_valid = ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_ATIME |
+	    ATTR_ATIME_SET | ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME;
+	iattr.ia_mode = inode->i_mode;
+	iattr.ia_uid = inode->i_uid;
+	iattr.ia_gid = inode->i_gid;
+	iattr.ia_atime = inode->i_atime;
+	iattr.ia_mtime = inode->i_mtime;
+	iattr.ia_ctime = inode->i_ctime;
+	return orangefs_inode_setattr(inode, &iattr);
+}
+
 /*
  * NOTE: information filled in here is typically reflected in the
  * output of the system command 'df'
@@ -309,6 +324,7 @@ void fsid_key_table_finalize(void)
 static const struct super_operations orangefs_s_ops = {
 	.alloc_inode = orangefs_alloc_inode,
 	.destroy_inode = orangefs_destroy_inode,
+	.write_inode = orangefs_write_inode,
 	.drop_inode = generic_delete_inode,
 	.statfs = orangefs_statfs,
 	.remount_fs = orangefs_remount_fs,
-- 
2.19.0

