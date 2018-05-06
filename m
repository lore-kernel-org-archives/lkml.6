Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646932-2-3959855791757120305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525646932; b=ZIzz3jah9UKPNCVTEy7nUqjOhzmxB4QCch/czIzl5eDd636Odt
    XF3UowpNodGsgCVR1cfMpk/wJKJZ5bVRobGAMHtbubVs9U/jut7/xND749wgp19i
    DZeZzFD/FykT9sQN+fXDoeR85W0nkHWZJxa95kzQiU5DXiY8UCYiU25ZIFho0SyR
    GuAiJ764HD8VIAxmPZo3FVZdoCBppfshit3NcvT2KnctKD+7m+WF0VVdNBE2wt/v
    1buKnYiGBSlydYXyuLJ7wycUtGbCK4MOC4qxjBullViffBEXEQhTcHusAjLiQ6OT
    tEclzky/zUy/RqHzCqcKfz2wVdiyQx0xP0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525646932; bh=
    7xsEfixuvCjDZhkfPWXWRM8G1bmpkIXBNfGkSHIbCd8=; b=ZzLr1Qdg3TdGy//q
    wDKWxN6dhQJtGRl87JaMNXH0EqOakGzZWGf0kkY+7EwVTC5c2lTU7ySkDBkdriEv
    HIxyMDoRToj/4nW0+o44IJlwr6MyIrwth8jaINzdNjOs9EbhDPq7Of1Aor52P1WY
    U80tIRw+OQJPWA+3EcRa4Cz0J7FIiJCALiv5kCGxKLmifwM3XdyERad2iNep0ujt
    Lfx//XKKuDGtIDz5bdIx6/MVw+2IM0abqYl4tw/wZ5fQvIecVKP9H7swd/gKcJRM
    v9DgUbafMrU1lch1NMaM7ibtBf95N0r17VYza5YImx0mCfT9A9I1njcCMyG+/6pD
    5ndRmQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gswxy+1f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gswxy+1f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKf/h7HEWVlKO5QIHcC7mmCFq000KVkRAOIl7AcD+4quRblpSoiGq+0bsJWCAfoSV7gUY/ASByU4o2ZX+8OodGfRpr0yjS+gmEzUoLGKJMO4Lbl68EQQ
    o8eoEk0V5enW4BSCLrEz+ji6Yiz0EZVwNVjINNuAWS1W8Y++BMONlwp0aPDCSaD7ISwnP8rn+Dq4iCAqk+FxBrtPlqBKY+EIofNvLK3tnQ/BXviK6AVsNm9p
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=FMiol41Xt7q6hRQp6E0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEFWsr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40284 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeEFWsO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:14 -0400
X-Google-Smtp-Source: AB8JxZoyNW47iLS9CTAmUTEDmjYYRPTvDauEUuNfm/efKgOqjallaNOLdgOSZRecSp4xOLX1wTKPXg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5/6 v1] statfs: add ST_SLAVE
Date: Mon,  7 May 2018 00:47:03 +0200
Message-Id: <20180506224704.14669-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently userspace can only determine whether a mountpoint is slave
by parsing /proc/<pid>/mountinfo. It would be convenient to simply retrieve
this property with a statvfs() call.
This let's userspace avoid costly parsing, supports cases where /proc is
not mounted, and supports usecases where file descriptors to mountpoints
are passed between processes that are inspected via fstatvfs().
This is especially helpful in all cases where userspace is not interested
in specific propagation properties our peer group layouts but rather just
wants to either turn on or turn off propagation for specific mountpoints.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 fs/statfs.c            | 10 +++++++++-
 include/linux/statfs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 2fc6f9c3793c..35ad0402c9a3 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include "internal.h"
+#include "pnode.h"
 
 static int flags_by_mnt(int mnt_flags)
 {
@@ -50,8 +51,15 @@ static int flags_by_sb(int s_flags)
 
 static int calculate_f_flags(struct vfsmount *mnt)
 {
-	return ST_VALID | flags_by_mnt(mnt->mnt_flags) |
+	int flags = 0;
+
+	flags = ST_VALID | flags_by_mnt(mnt->mnt_flags) |
 		flags_by_sb(mnt->mnt_sb->s_flags);
+
+	if (IS_MNT_SLAVE(real_mount(mnt)))
+		flags |= ST_SLAVE;
+
+	return flags;
 }
 
 static int statfs_by_dentry(struct dentry *dentry, struct kstatfs *buf)
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 5416b2936dd9..048127effaad 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,6 +41,7 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_SLAVE	(1<<19)	/* change to slave */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0

