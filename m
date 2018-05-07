Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682778-2-10104204563264519056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682777; b=E8lqPn1sKxVhwKyYHJN3eOTblFB7ZKezzhPWwLjuLkQ2URgZir
    fLxjy4zfa++qRHoB7jEqvU5/oAts9hd3VnhEIPrzkAR/do5F2Gdg5k3XxWcJNV0+
    gkA+hi9/YW3He7O36K/4ETC3tSmF0Pt0dVny2SRcD+0G9cmD5Wv23iMZySbeJ3/4
    uqtE5eKc+uWsUB31vFHeiIvyO1ysq5aeVCdBYIU76I4VJ2vhvrXqmHsTFf2rj93x
    UH5JsKBvP5QOq9UwWPH/3oZs0eZr+CvYjpB88O7lz6HfOia3tcMCMmcNIlDDbEwq
    sC9q/typJkuVnaSHP6baKk9/A/BYVP29EBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682777; bh=
    fG9h3LPDas+vGMu54qQY97pS6dLbeoATLqnmKlflYvU=; b=E2jVIOwl/dokt3JE
    C2iP5qa6IY6FnTt9F9frTu8u4xiJlds0E6QwYw+fXnTNTG/zEe8Qd4MjXGQHC+uY
    KfJ3nK/ti0h5mrPY1Vllen1U8zzXNQHtAovMqazwcDFgvmo26MlR8WxhrOookEPg
    ShWsBsW4DmXPFUbEgMMxNr/c4gumh+4KdWrKI3OTBBIDiNLEN4gYB50lSS8Bvl/H
    0x5OszHm2KBb0WdJAtl3XUfNvUSPUhNHU3L8yGXyYfSjpKTjY4WVWReV+w7lLOYM
    30DYwQxSvsec2wvP92J5zSfYn5iah0igT5Nn4V/Mmb98jhm04LEvGqQ/nlCu2R1V
    EQnYfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=QtNVw6I/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=QtNVw6I/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAnOG1bqzFogbPGkAfy8+aMrSL1+cpn7UgyKRPDFvG0hmCH7a0T3r7lV+4BuQRFnl112xUL7PWGTuGBM25rrdITIXrRJBaqak5qWq7aUbl8gjE1/WwRn
    Vk/zZChmZCKRWqgM3pPeT+cq1wPQBL0LjpAwCBQ2ZcEWDNtuQVXKfH2aOY2vVi6cdnAnx5H6ztEjWiC3ZjulsxI8oN5OErcZVDes7/g3vUM5/CPMF46OLTBB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=0W8Ja__6R4iCogxYFOgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEGIqL (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:46:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43950 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEGIif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:35 -0400
X-Google-Smtp-Source: AB8JxZrG4totPxBEEAWGMq3YdtcJUwTg+Cp4fvaxIOdLo8fX+QK+AsbHzQh7lz7HyD1P9QjUv4X5IA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/35] ovl: add ovl_fiemap()
Date: Mon,  7 May 2018 10:37:51 +0200
Message-Id: <20180507083807.28792-20-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked fiemap().

Need to split inode operations for regular file (which has fiemap) and
special file (which doesn't have fiemap).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index a228eda66ad8..7abcf96e94fc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -448,6 +448,23 @@ int ovl_update_time(struct inode *inode, struct timespec *ts, int flags)
 	return 0;
 }
 
+static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 len)
+{
+	int err;
+	struct inode *realinode = ovl_inode_real(inode);
+	const struct cred *old_cred;
+
+	if (!realinode->i_op->fiemap)
+		return -EOPNOTSUPP;
+
+	old_cred = ovl_override_creds(inode->i_sb);
+	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
+	revert_creds(old_cred);
+
+	return err;
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -455,6 +472,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+	.fiemap		= ovl_fiemap,
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
@@ -465,6 +483,15 @@ static const struct inode_operations ovl_symlink_inode_operations = {
 	.update_time	= ovl_update_time,
 };
 
+static const struct inode_operations ovl_special_inode_operations = {
+	.setattr	= ovl_setattr,
+	.permission	= ovl_permission,
+	.getattr	= ovl_getattr,
+	.listxattr	= ovl_listxattr,
+	.get_acl	= ovl_get_acl,
+	.update_time	= ovl_update_time,
+};
+
 /*
  * It is possible to stack overlayfs instance on top of another
  * overlayfs instance as lower layer. We need to annonate the
@@ -548,7 +575,7 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 		break;
 
 	default:
-		inode->i_op = &ovl_file_inode_operations;
+		inode->i_op = &ovl_special_inode_operations;
 		init_special_inode(inode, mode, rdev);
 		break;
 	}
-- 
2.14.3
