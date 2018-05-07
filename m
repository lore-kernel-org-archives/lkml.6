Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682972-2-11828546721015855169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682972; b=X7uvpi/7fZNPf7xzgL1rhm41X0GPfRMKcnBf6j09FNyLorFqTr
    ifq3VZLRUT3NFEgIerxEv0blmini3Uj9FhUwCSlxyY877V7IrhDa+SbUvREAKy3P
    bMdK67kWzEeQd4K5WhXPDAf4JaydmAlJjM8SRmyafINXTiW4Mbot/gKqANP6hFi8
    tgPoHoUvmssZ5o9GRptDurapzWUbGFUiwmNBYc+qqg3uhD3cUQSDowek72Z9hYXk
    AzIVpcbqjQGWEBNj6qIc5HOEgPazVBKQk2VY7bPSGxbfnkbaKSJxfUZfdNXiI+6F
    iN0a6UniS2DNxVFpuyj+fNpFhAYrgYb+Xd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682972; bh=
    UV+lbiJDt+7MmXJssSV6faBdF8FoOZmezT0/TkPgcEo=; b=MdBqv0ytvnJ02DOo
    M68Y5fP5eYnQIk4VHEW25z6JUJuCAUPpOvT6VcjHndXdmR0b8Z/Yh+Atwkw/Xb/D
    6WJTa2UIxhlaM2/gqEhYvs2hHSKLSLswaYt/dUTp7PJ7YnpW66vFb3XwhGxT7P7g
    My8EWCnsyaWMKPCMFEcu0d+YDNg94Kj30d+GujdWejdJcu/rmb6md5yoaQMcp12Z
    kMso4jfF8GGfiv8HbfAYUURMCVsF7D+r6+fuHzqP66El1zWcyfs+qI/jU2pD5nG6
    fL9vqycpIdAM8Hb6vDRshI9/VkymSwCzIOzw0v7rk7qkuQMuVmVnwJwMwBWQC59A
    xwyfzQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Gvjbgrur;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
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
      header.i=@1e100.net header.b=Gvjbgrur;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJe7tCiIrAADgr+HiT9Wi2emJpCYSFMKBa3QMXoRakKPKzEbnpqgIyOtodmi/VDdYWEqDUk0KDJl7wFJndORkQMK5vE19RJuM8OOgw8tNKrLli7d7Nya
    Xavj5F9KHBli1DPuIAeYLug7OMUOY2uUTNE1+9NUDmwTHhKlE6EgFBEES9Exopi1xxng3MFOYc/dXhEayczdJZks8cBKFpl2UzdSbmkSCbSOjPAmWvQE3ilY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=IHdzveK79_4XGZwF3VoA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeEGIt2 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:49:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbeEGIiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:18 -0400
X-Google-Smtp-Source: AB8JxZprqDppCyZkJLUTX8x7F+lQPmsWzt2xbcXLipWXDYhrEFQvoOzRuz+G3UhoGyksjG3Pkh0CHQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 04/35] vfs: export vfs_ioctl() to modules
Date: Mon,  7 May 2018 10:37:36 +0200
Message-Id: <20180507083807.28792-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is needed by the stacked ioctl implementation in overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h      | 1 -
 fs/ioctl.c         | 1 +
 include/linux/fs.h | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index b82725ba3054..6821cf475fc6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -189,7 +189,6 @@ extern const struct dentry_operations ns_dentry_operations;
  */
 extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
 		    unsigned long arg);
-extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /*
  * iomap support:
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4823431d1c9d..41071915f411 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -49,6 +49,7 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
  out:
 	return error;
 }
+EXPORT_SYMBOL(vfs_ioctl);
 
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 898fb798a3ff..26685011c4bd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1623,6 +1623,8 @@ int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
 
+extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
 /*
  * VFS file helper functions.
  */
-- 
2.14.3
