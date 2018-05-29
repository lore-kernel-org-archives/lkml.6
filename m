Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527605101-2-10069253186500047003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605101; b=fRtMKj+h/kQts58/LEN5/pqQBOpSmVYkpsU1pFLLU4ErVcPHnt
    IchUsRFj3dPLUGfuv+FEqOzpXABfB8sDGV3vFf23oGY4kffALEquK0FzYH6Kz0DF
    dLVkfRTxrGszNl4mPxhe0S7G4Wyvxl4htKCOSoZNS+7PnW+gk3u6endwW3iuegz2
    5t58JYJN63p7RBhnOMmxdqNHmCYep9H4kzgCTeyu+9UVsF8Qq64c6GRBnrfRH1mZ
    omcmI8pKmnobJcsdnrAMq1rbUTSOnx03aCSoeMzlL6MJ/IVG8dvKweWJ8wvbO0zr
    2cMKrV6oisnPJdgWnEBoUqnHca7Ftzf+Bgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605101; bh=
    V/1pIqtkWVkqTv4djh78D3dqKvql5BPCQRkLZlzk72o=; b=K6UKDnqWjgEsVECn
    eelASc7a+6DJVCr0dqT5zlUj61mPbIHqf2BfxyJnef+LrhyzaTdWuguZ/cG/3aHA
    uiE21GeIDrBfNi/M5nhEcE/nvjJWHBKx1vJZ5Rddg3VO7eIAT64NaCHo03wRfWOE
    5MuR87GFgjzajRcFptZWbELaDraUQzYBeGX6V+pYmqMOilgH3o3/PznMrnGCSJgW
    S4gYkLIUuy4EhVfsiusmhBKBmPv3hlvclDPSr1LXE53g4QWe2pOGgiOQhQb6w50J
    oHoqPZRRRVtYXjrMcQSygD9Tap0xz/Lf8wnwkqz65mdIGJTsp/0SClbh3b7kCbjl
    +hfBSw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=kVZtbNUw;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=kVZtbNUw;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFFIuMdp3+D3lAPJ+ePZe3FxQBFA5Gb0KHwh7d+aflXF51Z0LoEIdqALRzi8NBDMf/SFbTzLi8n1doij3ypfD3qvB3PShr7B4lvtJ2yLl3qNi0YdcKo
    E2fPSpyrF9G5XSmFNyFRa+VxgEa1Kawze2hcCrdqpowoaC3Bz40roq3BziHoQYXhHWR2iD48Xo68tTD8kQ3GfpKM038DOqYvD8xdfSPT9Vpe9dT10rxk+Kw8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=nW1f2riJtgJUCLueMDkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935764AbeE2Oo6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:44:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33265 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935760AbeE2OoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:14 -0400
X-Google-Smtp-Source: AB8JxZosEukNZvAWtYb29Kbt7hpbwre9cYNOH5TL4LpLr8imKa37dldqOAvfE1zzDB4v6sUcCKlLDw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/39] ovl: obsolete "check_copy_up" module option
Date: Tue, 29 May 2018 16:43:27 +0200
Message-Id: <20180529144339.16538-28-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was provided for debugging the ro/rw inconsistecy.  The inconsitency
is now gone so this option is obsolete.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ddaddb4ce4c3..e675e8349e71 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -25,35 +25,20 @@
 
 #define OVL_COPY_UP_CHUNK_SIZE (1 << 20)
 
-static bool __read_mostly ovl_check_copy_up;
-module_param_named(check_copy_up, ovl_check_copy_up, bool,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(ovl_check_copy_up,
-		 "Warn on copy-up when causing process also has a R/O fd open");
-
-static int ovl_check_fd(const void *data, struct file *f, unsigned int fd)
+static int ovl_ccup_set(const char *buf, const struct kernel_param *param)
 {
-	const struct dentry *dentry = data;
-
-	if (file_inode(f) == d_inode(dentry))
-		pr_warn_ratelimited("overlayfs: Warning: Copying up %pD, but open R/O on fd %u which will cease to be coherent [pid=%d %s]\n",
-				    f, fd, current->pid, current->comm);
+	WARN(1, "overlayfs: \"check_copy_up\" module option is obsolete\n");
 	return 0;
 }
 
-/*
- * Check the fds open by this process and warn if something like the following
- * scenario is about to occur:
- *
- *	fd1 = open("foo", O_RDONLY);
- *	fd2 = open("foo", O_RDWR);
- */
-static void ovl_do_check_copy_up(struct dentry *dentry)
+static int ovl_ccup_get(char *buf, const struct kernel_param *param)
 {
-	if (ovl_check_copy_up)
-		iterate_fd(current->files, 0, ovl_check_fd, dentry);
+	return sprintf(buf, "N\n");
 }
 
+module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
+MODULE_PARM_DESC(ovl_check_copy_up, "Obsolete; does nothing");
+
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 	ssize_t list_size, size, value_size = 0;
@@ -719,7 +704,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 		if (IS_ERR(ctx.link))
 			return PTR_ERR(ctx.link);
 	}
-	ovl_do_check_copy_up(ctx.lowerpath.dentry);
 
 	err = ovl_copy_up_start(dentry);
 	/* err < 0: interrupted, err > 0: raced with another copy-up */
-- 
2.14.3
