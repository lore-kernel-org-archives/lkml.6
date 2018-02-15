Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708232-3-4259143134857517313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708231; b=rKUqrQDo4wmA/x93zMx7+MIR2IUqE+1FIcCDzoXcmNVniUv
    eoTTz85wBnWpdbJF0sMaIKS9tQgUoqY+5hVkHUuJsC0MlBJZfwIqTbH/b7geaW6y
    VHDVQIkj/2TkAaqT5Ku90q5ZpLK7igYgdd9nDh01NMcIcktBORCYtjhyW4jDqRfi
    kL3whY1pnJcMyb1dZ/yVoDsRaT4Rx/TRoJfuiutTHLuulmcUnMjBf/Jr5dPmIXAo
    wn5qtjWwmrRRWwOlZgMzicAgtoyNG29v29tQAtPOW5+2TkeGKT1NQlM14ZXPKhYG
    kdyuOzbxayVZlPCZ2j5eOhwAbQIF5LwK+ohFU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708231; bh=Ce65ZQ7KSD9iENQh1X5DYM4YKt
    5Pd+NNYUCxAR5ePxk=; b=CX77Yrf4bDdYRosPC1SarumNGDEzUKKDdA8HxUpa+Y
    v0oNWIKQB7ow/N4m/FoPakU8POETLZvvBKHfiyazBAThhhysJBxwYm/nT/+CwiAQ
    M9WO+NrI2266lapf7OX9M0Q8Nvr1hEFd/6GJLzdh25Pj5Om1/BYlTeSOlOgZ8mvv
    sQbmeLBLXc75y6JN6yCJwWZ9I40mmgyFiftGOLHkn9mFXjkxmZNfTuGyPo3IMYqP
    zJ+T5vCe9ZQKpUyKOoutDbzwhYvMTa1Yi0qJ9MEaWBfA3lQX1eJnaMyRkoVrRY6I
    NJm6bdRCeZDtbjrHtkGE9KJ05s4xr4E8ufo9TNwHrcqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162750AbeBOPXs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162739AbeBOPXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4.4 070/108] nsfs: mark dentry with DCACHE_RCUACCESS
Date: Thu, 15 Feb 2018 16:17:07 +0100
Message-Id: <20180215151232.115260005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 073c516ff73557a8f7315066856c04b50383ac34 upstream.

Andrey reported a use-after-free in __ns_get_path():

  spin_lock include/linux/spinlock.h:299 [inline]
  lockref_get_not_dead+0x19/0x80 lib/lockref.c:179
  __ns_get_path+0x197/0x860 fs/nsfs.c:66
  open_related_ns+0xda/0x200 fs/nsfs.c:143
  sock_ioctl+0x39d/0x440 net/socket.c:1001
  vfs_ioctl fs/ioctl.c:45 [inline]
  do_vfs_ioctl+0x1bf/0x1780 fs/ioctl.c:685
  SYSC_ioctl fs/ioctl.c:700 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691

We are under rcu read lock protection at that point:

        rcu_read_lock();
        d = atomic_long_read(&ns->stashed);
        if (!d)
                goto slow;
        dentry = (struct dentry *)d;
        if (!lockref_get_not_dead(&dentry->d_lockref))
                goto slow;
        rcu_read_unlock();

but don't use a proper RCU API on the free path, therefore a parallel
__d_free() could free it at the same time.  We need to mark the stashed
dentry with DCACHE_RCUACCESS so that __d_free() will be called after all
readers leave RCU.

Fixes: e149ed2b805f ("take the targets of /proc/*/ns/* symlinks to separate fs")
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nsfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -95,6 +95,7 @@ slow:
 		return ERR_PTR(-ENOMEM);
 	}
 	d_instantiate(dentry, inode);
+	dentry->d_flags |= DCACHE_RCUACCESS;
 	dentry->d_fsdata = (void *)ns_ops;
 	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
 	if (d) {
