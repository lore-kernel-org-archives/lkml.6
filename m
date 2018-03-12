Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520825225-2-2765522620397882213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825225; b=utzhD4a6GCmUD7rG6QUJv3zEDY7MXWtC9SbmI+Z5pcGdsm/
    0sWW43cYPuwkUUHLdpDEAaBsLF1BgkipZywNwZkvf8G4rjlXiuaqh6Mf6HL9risF
    qbw5k6X/eYqhkGOUsuTrHrLX4HjMe+b88Oilgh8zw2KMbl29Y32bv2BfQtz6x4Dr
    Jqt38V0Sh2m6KdIdmQ0JNuqvqmgnOuHBlYOt5O5T0qob91i+N88UvxlGE4jGZbFc
    WBT2PM16iJlBhMZuWZhSkvse3bQsGrcVP3rJu1pZYLLkhVoGdw61fBaSrjMJrPTM
    rxohSCvNN5+76DDoPg7IhtuUrGQlqqvIu8EfH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825225; bh=UFCQYtfB9U78kushcE1
    nWQnVZZrxrkf6sjoU86NI6pI=; b=RXGKTb8DtbxM4hNWRWmtc299N7FUvsfFkY3
    TvU0YAStkJzuZcEvlzsf+77nfL//t5xGyCgq+zTMufvfBsjYalUBiuB/E6eyES1j
    MfqJhupyM+h4io7jQf7OLyNzfBuZC1+Illxe/4sSuQXJE6aaCuGRiWN2C8ZCtQr1
    ANXdEMqwvPVqy5dZn9SJd6L8CY6DB6FLcRpzWTXgT9SVk58EWJ01OtTjzf6Bjw2S
    CkxwxfPlP7Cm//pXVcs5wj0RsYEGEU4GkVfyjnsBFC16nVuh3c1YsgvEvTvVdOui
    LhcgdIi0ctdWjOHC3h9gHLONySiV52SVTs7EWvql6WVADmhjCkg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeCLDZ1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:25:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41219 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932681AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Tim Gardner" <tim.gardner@canonical.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.945827679@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 022/104] fs: namespace: suppress 'may be used
 uninitialized' warnings
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Gardner <tim.gardner@canonical.com>

commit b8850d1fa8e2f6653e57daf6d08e58c5f5eb2c85 upstream.

The gcc version 4.9.1 compiler complains Even though it isn't possible for
these variables to not get initialized before they are used.

fs/namespace.c: In function ‘SyS_mount’:
fs/namespace.c:2720:8: warning: ‘kernel_dev’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  ret = do_mount(kernel_dev, kernel_dir->name, kernel_type, flags,
        ^
fs/namespace.c:2699:8: note: ‘kernel_dev’ was declared here
  char *kernel_dev;
        ^
fs/namespace.c:2720:8: warning: ‘kernel_type’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  ret = do_mount(kernel_dev, kernel_dir->name, kernel_type, flags,
        ^
fs/namespace.c:2697:8: note: ‘kernel_type’ was declared here
  char *kernel_type;
        ^

Fix the warnings by simplifying copy_mount_string() as suggested by Al Viro.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/compat.c    | 10 ++++++----
 fs/internal.h  |  2 +-
 fs/namespace.c | 26 ++++++++------------------
 3 files changed, 15 insertions(+), 23 deletions(-)

--- a/fs/compat.c
+++ b/fs/compat.c
@@ -797,8 +797,9 @@ asmlinkage long compat_sys_mount(const c
 	char *dir_page;
 	int retval;
 
-	retval = copy_mount_string(type, &kernel_type);
-	if (retval < 0)
+	kernel_type = copy_mount_string(type);
+	retval = PTR_ERR(kernel_type);
+	if (IS_ERR(kernel_type))
 		goto out;
 
 	dir_page = getname(dir_name);
@@ -806,8 +807,9 @@ asmlinkage long compat_sys_mount(const c
 	if (IS_ERR(dir_page))
 		goto out1;
 
-	retval = copy_mount_string(dev_name, &kernel_dev);
-	if (retval < 0)
+	kernel_dev = copy_mount_string(dev_name);
+	retval = PTR_ERR(kernel_dev);
+	if (IS_ERR(kernel_dev))
 		goto out2;
 
 	retval = copy_mount_options(data, &data_page);
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -60,7 +60,7 @@ extern int check_unsafe_exec(struct linu
  * namespace.c
  */
 extern int copy_mount_options(const void __user *, unsigned long *);
-extern int copy_mount_string(const void __user *, char **);
+extern char *copy_mount_string(const void __user *);
 
 extern unsigned int mnt_get_count(struct vfsmount *mnt);
 extern struct vfsmount *__lookup_mnt(struct vfsmount *, struct dentry *, int);
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2253,21 +2253,9 @@ int copy_mount_options(const void __user
 	return 0;
 }
 
-int copy_mount_string(const void __user *data, char **where)
+char *copy_mount_string(const void __user *data)
 {
-	char *tmp;
-
-	if (!data) {
-		*where = NULL;
-		return 0;
-	}
-
-	tmp = strndup_user(data, PAGE_SIZE);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
-
-	*where = tmp;
-	return 0;
+	return data ? strndup_user(data, PAGE_SIZE) : NULL;
 }
 
 /*
@@ -2535,8 +2523,9 @@ SYSCALL_DEFINE5(mount, char __user *, de
 	char *kernel_dev;
 	unsigned long data_page;
 
-	ret = copy_mount_string(type, &kernel_type);
-	if (ret < 0)
+	kernel_type = copy_mount_string(type);
+	ret = PTR_ERR(kernel_type);
+	if (IS_ERR(kernel_type))
 		goto out_type;
 
 	kernel_dir = getname(dir_name);
@@ -2545,8 +2534,9 @@ SYSCALL_DEFINE5(mount, char __user *, de
 		goto out_dir;
 	}
 
-	ret = copy_mount_string(dev_name, &kernel_dev);
-	if (ret < 0)
+	kernel_dev = copy_mount_string(dev_name);
+	ret = PTR_ERR(kernel_dev);
+	if (IS_ERR(kernel_dev))
 		goto out_dev;
 
 	ret = copy_mount_options(data, &data_page);
