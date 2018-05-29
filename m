Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527605211-2-14264646410288547836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605210; b=mVz/ayROchRDCVB2l1xtehbzc1YoQUqDMy9ZlSeVt+muuJFEKa
    V18fWelZSnCsWhiKUP9EbAX1xemz/zMPxp/ANoXe2OnpGFGA4QGYJQAYx/Qlq5AK
    rVHf6ExMYZitQDFN3Eo8sCMfqmt0vmWiC11JYWmQmlZqsO0BE+y7/R7LCg5OIN3L
    oIzJGCWnawloC2XACd50ZH4i9BORF8qtFYxAMrOwI4csXLBw+v5cv3IjBojV7GW8
    8X81OXNNwFma2zTuucss8fz5vTmsEPtHvH9Yqc1fgRauvml5PT3ZbawOSlthxmae
    Ts2tZYw27jhV/wQJ9FQnFZtITLiPxB7j8znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605210; bh=
    012N5M0SWdtwBO8c5/j/puuB27evw5GYpoxUhgnV6XQ=; b=Rscj4euQ4E4FFUC4
    WNeLMLmt/9z0wpvdu0SZ5350KoHjanlX5Md9Pe8ZPDP3IMkxww9i5t3gOAHw1Lvh
    ITKwKX6yqZgUBlt4r21SN+jxJsXI44Wq+DpRMgs7aXxKUvLKSs9wjJ0iN5y/ivUd
    4EjzB34qXoNNVMvzsar1SmPMgROY2TmM8DGI8SYQ3KtkSV+fhvkHP6TW25W96uxI
    /0w5gKVXyHvrRxn5JWpcyejdE4hW9gQumkSssSldUqRsr0ozgm6XgIScP4CCvZKx
    ejLjzCfLlCAc6YtTdOn6yq8MeprXma7ezwIkfo9gNE9cKaPLbNC3kCjbo9k279z9
    DBQaUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=CyXjnKsM;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=CyXjnKsM;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZFlrIJpzo8AjVNsCrKVpYIdQklvQZBfdIkxMG5PsCdPNlVyA2FZBkuuIEwEAzhcpQHy6a+T4jByBd4vg3TbN/j6PpayKPsgcsYmv9gTqs0DwfgrWmh
    ApE5LRsE9yuSCYanqkA3v8PoIUC47V3N5372U3s6ftZ4eII5j/haDoaLJNfLHLgbmX2m/FGy2WEZ3YotHw9LC2NFo5E3+kBHosgRnYgkDqOqrNynErwwfCUi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=Rirm2FgOVFEvlLaguU4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936675AbeE2Oqq (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:46:46 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34811 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936574AbeE2Oq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:28 -0400
X-Google-Smtp-Source: AB8JxZpsq+dJ/WyzJG+FERFHc8MkoRlZpvEhBgviHxSV/T6WpBNQkduNR/XshHtNHidu6htT+oeLQg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/28] ovl: Copy up meta inode data from lowest data inode
Date: Tue, 29 May 2018 16:45:54 +0200
Message-Id: <20180529144612.16675-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

So far lower could not be a meta inode.  So whenever it was time to copy up
data of a meta inode, we could copy it up from top most lower dentry.

But now lower itself can be a metacopy inode.  That means data copy up
needs to take place from a data inode in metacopy inode chain.  Find lower
data inode in the chain and use that for data copy up.

Introduced a helper called ovl_path_lowerdata() to find the lower data
inode chain.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 13 +++++++++----
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 12 ++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7d01afd345e9..8c05e9ad9782 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -519,13 +519,14 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	}
 
 	if (S_ISREG(c->stat.mode) && !c->metacopy) {
-		struct path upperpath;
+		struct path upperpath, datapath;
 
 		ovl_path_upper(c->dentry, &upperpath);
 		BUG_ON(upperpath.dentry != NULL);
 		upperpath.dentry = temp;
 
-		err = ovl_copy_up_data(&c->lowerpath, &upperpath, c->stat.size);
+		ovl_path_lowerdata(c->dentry, &datapath);
+		err = ovl_copy_up_data(&datapath, &upperpath, c->stat.size);
 		if (err)
 			return err;
 	}
@@ -706,14 +707,18 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 /* Copy up data of an inode which was copied up metadata only in the past. */
 static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
-	struct path upperpath;
+	struct path upperpath, datapath;
 	int err;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
 		return -EIO;
 
-	err = ovl_copy_up_data(&c->lowerpath, &upperpath, c->stat.size);
+	ovl_path_lowerdata(c->dentry, &datapath);
+	if (WARN_ON(datapath.dentry == NULL))
+		return -EIO;
+
+	err = ovl_copy_up_data(&datapath, &upperpath, c->stat.size);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b1f6591b9af4..31795c041d61 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -217,6 +217,7 @@ bool ovl_dentry_weird(struct dentry *dentry);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
+void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
 struct dentry *ovl_dentry_lower(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index ab9a8fae0f99..32ff67fa0bfb 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -164,6 +164,18 @@ void ovl_path_lower(struct dentry *dentry, struct path *path)
 	}
 }
 
+void ovl_path_lowerdata(struct dentry *dentry, struct path *path)
+{
+	struct ovl_entry *oe = dentry->d_fsdata;
+
+	if (oe->numlower) {
+		path->mnt = oe->lowerstack[oe->numlower - 1].layer->mnt;
+		path->dentry = oe->lowerstack[oe->numlower - 1].dentry;
+	} else {
+		*path = (struct path) { };
+	}
+}
+
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path)
 {
 	enum ovl_path_type type = ovl_path_type(dentry);
-- 
2.14.3
