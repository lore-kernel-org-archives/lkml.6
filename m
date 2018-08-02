Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173121526
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="tNKkUUbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0173121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbeHBRUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:20:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40121 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbeHBRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:20:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so1184037plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tL9cVlVW86zqJNLrfSyHdjtdKwbs6bHXKOSYi+RNpcU=;
        b=tNKkUUbr4p95ipbcpwN0sxZdVwtNuleudP29UKlkItre6pKx9pFXRyHtGdoJepo2Ua
         fsm2ciWLnELLHXPlz+u32clp0ivymNZiahRTzLKQqgNvNDhFUYgffkCE9rzqSmnV8a76
         0tFoHmU5ogOWKzvHfPL5706h32TljCMGmSujHK1838VqiKGCI3Cz32ux/yly1sNOl+QQ
         9mmHCpTtf0vR6crNIMdGKyLFf+uP71gxsqMv0w8VHg/ZcXB6PUgpFYmj8vAE6dmAMJHm
         3k99ZOhbt95yG0uTx0BPU7YYZbMsJ4PBmhYE5gMlEl7fOpjC7xhAMl/uXUn0cvHXhHuK
         6U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tL9cVlVW86zqJNLrfSyHdjtdKwbs6bHXKOSYi+RNpcU=;
        b=VaLtYGr7TfEp7b9KsN/f5MxfqhQMTDIq687vmQpnJND5V9CtxxMpBB4Y0OSexpSsdK
         fiQG8o/GjMuk2eGoFC1NtL5M214gFF1MLdOMzZRjzuD6F1zSXoHmNMIJlp14BzMhYREW
         c1uHjoAjl6zhgylop/VZ+3noLFUTJebFkE0CRPPG7UKh9NO3a1Nv1uvHnfB2Vqp4KD1k
         R7QxJzoMz/jgyAW7duIOyMREDdM8jOqj1lJUUeuaSREzUeu81/HDkvMphR5xhNw8ieBB
         j9cv1ETp1C5oVgkSAuc6g1Vj/VLe/V0d1vVU6nUTYgj5ERuYgDbVQhfHvJYBmM7cSq3c
         1qRw==
X-Gm-Message-State: AOUpUlExPMvp3mOPOF2NxLfB5hawis6JVj8KznPpJ4co8QszNhwyOZKO
        QZNCk4JpvB4gVSaQM3cHMEUPCg==
X-Google-Smtp-Source: AAOMgpdctmtIrVnA2e5QtA/1EScRa15F8gsqBB2uzHQ0RHgw0S9+1cpEGoz+/XYpIVuI89fXBeT8gw==
X-Received: by 2002:a17:902:5856:: with SMTP id f22-v6mr2868237plj.266.1533223743487;
        Thu, 02 Aug 2018 08:29:03 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:8fc3:703d:7635:5997])
        by smtp.googlemail.com with ESMTPSA id l79-v6sm6761879pfj.179.2018.08.02.08.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:29:03 -0700 (PDT)
Subject: Re: ovl: hash non-dir by lower inode for fsnotify
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
References: <2630a5c0-ef57-a4cf-a6f4-b4996c64043b@android.com>
 <20180802060549.GB3272@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <8c38c2fc-36e6-9aa7-5924-51d7bc2c3d73@android.com>
Date:   Thu, 2 Aug 2018 08:29:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180802060549.GB3272@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 11:05 PM, Greg KH wrote:
> On Wed, Aug 01, 2018 at 02:29:01PM -0700, Mark Salyzyn wrote:
>> 764baba80168ad3adafb521d2ab483ccbc49e344 ovl: hash non-dir by lower inode
>> for fsnotify is not part of 4.14 stable and yet it was marked for 4.13
>> stable merge when committed.
>>
>> Please evaluate.
> Why not try applying it yourself to 4.14.y and note that it does not
> apply at all and then provide a working backport so that we can skip at
> least one email cycle here?  :)
>
> thanks,
>
> greg k-h

Because I am embarrassed by the backport (!) perhaps? :-)

+linux-kernel list and authors/approvers for clearance.

I took some liberty with sb = dentry_d_sb and then sprinkled it in, 
upstream passes sb to the function and the conflicts assumed so.

--------------------------> snip <-------------------------

 From 764baba80168ad3adafb521d2ab483ccbc49e344 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 4 Feb 2018 15:35:09 +0200
Subject: ovl: hash non-dir by lower inode for fsnotify

(cherry pick from commit 764baba80168ad3adafb521d2ab483ccbc49e344)

Commit 31747eda41ef ("ovl: hash directory inodes for fsnotify")
fixed an issue of inotify watch on directory that stops getting
events after dropping dentry caches.

A similar issue exists for non-dir non-upper files, for example:

$ mkdir -p lower upper work merged
$ touch lower/foo
$ mount -t overlay -o
lowerdir=lower,workdir=work,upperdir=upper none merged
$ inotifywait merged/foo &
$ echo 2 > /proc/sys/vm/drop_caches
$ cat merged/foo

inotifywait doesn't get the OPEN event, because ovl_lookup() called
from 'cat' allocates a new overlay inode and does not reuse the
watched inode.

Fix this by hashing non-dir overlay inodes by lower real inode in
the following cases that were not hashed before this change:
  - A non-upper overlay mount
  - A lower non-hardlink when index=off

A helper ovl_hash_bylower() was added to put all the logic and
documentation about which real inode an overlay inode is hashed by
into one place.

The issue dates back to initial version of overlayfs, but this
patch depends on ovl_inode code that was introduced in kernel v4.13.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org> #v4.13
Signed-off-by: Mark Salyzyn <salyzyn@android.com> #v4.14
---
  fs/overlayfs/inode.c | 62 +++++++++++++++++++++++++++++++-------------
  1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 28a320464609a..7cfef4152e9a4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,6 +14,7 @@
  #include <linux/posix_acl.h>
  #include <linux/ratelimit.h>
  #include "overlayfs.h"
+#include "ovl_entry.h"

  int ovl_setattr(struct dentry *dentry, struct iattr *attr)
  {
@@ -608,39 +609,63 @@ static bool ovl_verify_inode(struct inode *inode, 
struct dentry *lowerdentry,
      return true;
  }

+/*
+ * Does overlay inode need to be hashed by lower inode?
+ */
+static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
+                 struct dentry *lower, struct dentry *index)
+{
+    struct ovl_fs *ofs = sb->s_fs_info;
+
+    /* No, if pure upper */
+    if (!lower)
+        return false;
+
+    /* Yes, if already indexed */
+    if (index)
+        return true;
+
+    /* Yes, if won't be copied up */
+    if (!ofs->upper_mnt)
+        return true;
+
+    /* No, if lower hardlink is or will be broken on copy up */
+    if ((upper || !ovl_indexdir(sb)) &&
+        !d_is_dir(lower) && d_inode(lower)->i_nlink > 1)
+        return false;
+
+    /* No, if non-indexed upper with NFS export */
+    if (sb->s_export_op && upper)
+        return false;
+
+    /* Otherwise, hash by lower inode for fsnotify */
+    return true;
+}
+
  struct inode *ovl_get_inode(struct dentry *dentry, struct dentry 
*upperdentry,
                  struct dentry *index)
  {
+    struct super_block *sb = dentry->d_sb;
      struct dentry *lowerdentry = ovl_dentry_lower(dentry);
      struct inode *realinode = upperdentry ? d_inode(upperdentry) : NULL;
      struct inode *inode;
-    /* Already indexed or could be indexed on copy up? */
-    bool indexed = (index || (ovl_indexdir(dentry->d_sb) && !upperdentry));
-    struct dentry *origin = indexed ? lowerdentry : NULL;
+    bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry, index);
      bool is_dir;

-    if (WARN_ON(upperdentry && indexed && !lowerdentry))
-        return ERR_PTR(-EIO);
-
      if (!realinode)
          realinode = d_inode(lowerdentry);

      /*
-     * Copy up origin (lower) may exist for non-indexed non-dir upper, but
-     * we must not use lower as hash key in that case.
-     * Hash non-dir that is or could be indexed by origin inode.
-     * Hash dir that is or could be merged by origin inode.
-     * Hash pure upper and non-indexed non-dir by upper inode.
+     * Copy up origin (lower) may exist for non-indexed upper, but we must
+     * not use lower as hash key if this is a broken hardlink.
       */
      is_dir = S_ISDIR(realinode->i_mode);
-    if (is_dir)
-        origin = lowerdentry;
-
-    if (upperdentry || origin) {
-        struct inode *key = d_inode(origin ?: upperdentry);
+    if (upperdentry || bylower) {
+        struct inode *key = d_inode(bylower ? lowerdentry :
+                              upperdentry);
          unsigned int nlink = is_dir ? 1 : realinode->i_nlink;

-        inode = iget5_locked(dentry->d_sb, (unsigned long) key,
+        inode = iget5_locked(sb, (unsigned long) key,
                       ovl_inode_test, ovl_inode_set, key);
          if (!inode)
              goto out_nomem;
@@ -664,7 +689,8 @@ struct inode *ovl_get_inode(struct dentry *dentry, 
struct dentry *upperdentry,
              nlink = ovl_get_nlink(lowerdentry, upperdentry, nlink);
          set_nlink(inode, nlink);
      } else {
-        inode = new_inode(dentry->d_sb);
+        /* Lower hardlink that will be broken on copy up */
+        inode = new_inode(sb);
          if (!inode)
              goto out_nomem;
      }
-- 
2.18.0.597.ga71716f1ad-goog


