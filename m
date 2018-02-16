Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-817742-1518807737-2-18081671059560423544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518807737; b=iqlT6uujfbG6shFX5FIauIfkpvA0kUt38iWlKEeHop/zuHi
    GrZhp5P++e8y/pnTxtgEl5L9B0Q3dpRnqxI08ncgjNfAc+NqnQQ+LKeb96Xl5xKH
    BwcYAMP4iXR0n03j7qra82ByfC1RA6qiq2gTeK//G0RsatzAC9POgt0ntogl43JM
    c/BxpFM5FdwNtcvwIDybKdPxDPVHxAznwXRIdkHl+JQ3InfpppYpjP/5Eav9/rDA
    WeEU8SuOt/gzFg66qQDWvEwIycMwO/GDp1+J0+iwdEnd+S5rdhYRCDmHdizrvtUL
    cbGehdmL0cXP11SmygQSRt+Ga9RROUzvJwqc1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518807737; bh=+rnonRjScOnova6YSyUbdCD2tt
    K8HEFFfQI18AG4dkc=; b=AY76P26akJaw7eku+YE6C6I/+/5Jku+FJ+zJ0NMVVE
    3Ay4kCvUkAHcACaw4sRNqzB0amF4UuUaLs7iAUYdqIW2Y7Zon+ZVIjIr9aUK8/w2
    DAa6ZdtaPyQedK6CD5lIAJdGe8VmoZX8vfhzE0TRxTR+nJHPklO5N4XSfWxu9+Dl
    J++oH7OVPPCwiAmKptTRfWXSqyXfL24qsAie/5jYtQeMCcT3R1ZUZYn3uCvTzRm0
    WuPXRFxKdgPhkeCz9l3GoaMIUJPd7Su8jIVnZtXPhtYfCT+iLrN1XkXgyNteZANq
    t+1O8xCGmaKOnMZ0TthnHFA6xIv228pYS2tKDZGwOjhg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MnLJ6ULT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jfV60LHZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MnLJ6ULT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jfV60LHZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeBPTCO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 14:02:14 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44073 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeBPTCM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 14:02:12 -0500
X-Google-Smtp-Source: AH8x226Q6FPug6Sj6Jp76H7xNg4r7bTDBGsM+EYOVFCRlUvMmfq/ZrC+E1BA3vjNXIOjhhKnI/Fv2Q==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Todd Kjos <tkjos@google.com>,
        Arve Hjonnevag <arve@android.com>,
        Greg Hackmann <ghackmann@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH v2] staging: android: ashmem: Fix lockdep issue during llseek
Date: Fri, 16 Feb 2018 11:02:01 -0800
Message-Id: <20180216190201.59572-1-joelaf@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ashmem_mutex create a chain of dependencies like so:

(1)
mmap syscall ->
  mmap_sem ->  (acquired)
  ashmem_mmap
  ashmem_mutex (try to acquire)
  (block)

(2)
llseek syscall ->
  ashmem_llseek ->
  ashmem_mutex ->  (acquired)
  inode_lock ->
  inode->i_rwsem (try to acquire)
  (block)

(3)
getdents ->
  iterate_dir ->
  inode_lock ->
  inode->i_rwsem   (acquired)
  copy_to_user ->
  mmap_sem         (try to acquire)

There is a lock ordering created between mmap_sem and inode->i_rwsem
causing a lockdep splat [2] during a syzcaller test, this patch fixes
the issue by unlocking the mutex earlier. Functionally that's Ok since
we don't need to protect vfs_llseek.

[1] https://patchwork.kernel.org/patch/10185031/
[2] https://lkml.org/lkml/2018/1/10/48

Acked-by: Todd Kjos <tkjos@google.com>
Cc: Arve Hjonnevag <arve@android.com>
Cc: stable@vger.kernel.org
Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
Signed-off-by: Joel Fernandes <joelaf@google.com>
Acked-by: Greg Hackmann <ghackmann@google.com>
---
Changes since first version:
Don't relock after vfs call since its not needed. Only reason we lock is
to protect races with asma->file.
https://patchwork.kernel.org/patch/10185031/

 drivers/staging/android/ashmem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index bbdc53b686dd..b330e86b3a49 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -326,24 +326,23 @@ static loff_t ashmem_llseek(struct file *file, loff_t offset, int origin)
 	mutex_lock(&ashmem_mutex);
 
 	if (asma->size == 0) {
-		ret = -EINVAL;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EINVAL;
 	}
 
 	if (!asma->file) {
-		ret = -EBADF;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EBADF;
 	}
 
+	mutex_unlock(&ashmem_mutex);
+
 	ret = vfs_llseek(asma->file, offset, origin);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/** Copy f_pos from backing file, since f_ops->llseek() sets it */
 	file->f_pos = asma->file->f_pos;
-
-out:
-	mutex_unlock(&ashmem_mutex);
 	return ret;
 }
 
-- 
2.16.1.291.g4437f3f132-goog
