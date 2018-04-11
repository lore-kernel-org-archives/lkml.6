Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476310-2-12612165404416585210
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476309; b=rCNlkaF12lTBdLZXFstLfVgzrrSES9ctp3EpYtLZ1dvoPN8zG6
    eNFkoD0UYuUnZqGJB4FagCX9nri+58hQD2GFs/+8FtGX18ND7J7cTIvQi7dSuTgq
    N8iYStrA1tBhH5QWGdN+HYzKK7HxYXtmtSQ/zmrET5tHHdk4iL6FEa0+VGOQPqw5
    mcMHwbU4xjhkrxfFZiJQH2v83H6W1OsGUfzr78x+ozjdb9hcEqUDKZxhIip3twBq
    JN+tDxIYJ9cOAs0BUG3dueDsh/01vsML2oeBa95qPgJRmqT2PB0I16YXFTY64cUJ
    ltuxcctmtofJQbyrv4/a05REYN2AvyCh5urQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476309; bh=EMiGmM6gOYJkj+M7JYzH2qHwkhe7WJ
    Ra/XDe/Y+sk0E=; b=WZoaNZWjjdt2MPJIhsc6NibbLIifayIMU22a2gikA2Os9s
    dxdiA7bHY86wHGuPQQFfpWuca0wwc0/oltL46MH2s0MAFmRVHqU0hVMksNY8weQR
    IoBU/WcU1isEiWAaUuj3Mwi35JccNbiv5fcU2zjO7J22WjtfKvbHv9XiRn+/ZhVB
    UXpAnPsnAVkJCpWH8qj8+8ME9gtnOqP7dP7UHtxtxs3IS5xp9gZ7YwFKBqWAZiN+
    P7hm1UlZwl1qbyzTtgQVOAUHLxD5oQkTLlf7I+A5gJQ7Bt9rAT5NHVpCNSDWicru
    MxmveOZZe4QK9QLfWaRV/tHGMpesEblJJQo2TYxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFEoWlfJdXF7CPaSRMuIMGAY8HpManOgRBtiVq9iLPS/Wzh0tKklyxx8wWSA6G0TaZmkI9oiwO3jusEfx7noTa1D3o0oCClorGGyuMtx1H/qy/mS7mhp
    9s5yfpYjrYb8Fnmxbg/t8tcm9s3GzviIJaM0Pp0RhHxZy7Sc9Ora4VdVAW6qLyGVzliK33Y1mK3rlsfeA9zBYXwXc6RcczRj6NjpNCBTmGpAXkOUYlrJ6AdJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=NB6CG2mJGxnl6YEIGE4A:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbeDKS6U (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755480AbeDKS6R (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 128/310] VFS: close race between getcwd() and d_move()
Date: Wed, 11 Apr 2018 20:34:27 +0200
Message-Id: <20180411183627.974360341@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit 61647823aa920e395afcce4b57c32afb51456cab ]

d_move() will call __d_drop() and then __d_rehash()
on the dentry being moved.  This creates a small window
when the dentry appears to be unhashed.  Many tests
of d_unhashed() are made under ->d_lock and so are safe
from racing with this window, but some aren't.
In particular, getcwd() calls d_unlinked() (which calls
d_unhashed()) without d_lock protection, so it can race.

This races has been seen in practice with lustre, which uses d_move() as
part of name lookup.  See:
   https://jira.hpdd.intel.com/browse/LU-9735
It could race with a regular rename(), and result in ENOENT instead
of either the 'before' or 'after' name.

The race can be demonstrated with a simple program which
has two threads, one renaming a directory back and forth
while another calls getcwd() within that directory: it should never
fail, but does.  See:
  https://patchwork.kernel.org/patch/9455345/

We could fix this race by taking d_lock and rechecking when
d_unhashed() reports true.  Alternately when can remove the window,
which is the approach this patch takes.

___d_drop() is introduce which does *not* clear d_hash.pprev
so the dentry still appears to be hashed.  __d_drop() calls
___d_drop(), then clears d_hash.pprev.
__d_move() now uses ___d_drop() and only clears d_hash.pprev
when not rehashing.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dcache.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -461,9 +461,11 @@ static void dentry_lru_add(struct dentry
  * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
  * reason (NFS timeouts or autofs deletes).
  *
- * __d_drop requires dentry->d_lock.
+ * __d_drop requires dentry->d_lock
+ * ___d_drop doesn't mark dentry as "unhashed"
+ *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
  */
-void __d_drop(struct dentry *dentry)
+static void ___d_drop(struct dentry *dentry)
 {
 	if (!d_unhashed(dentry)) {
 		struct hlist_bl_head *b;
@@ -479,12 +481,17 @@ void __d_drop(struct dentry *dentry)
 
 		hlist_bl_lock(b);
 		__hlist_bl_del(&dentry->d_hash);
-		dentry->d_hash.pprev = NULL;
 		hlist_bl_unlock(b);
 		/* After this call, in-progress rcu-walk path lookup will fail. */
 		write_seqcount_invalidate(&dentry->d_seq);
 	}
 }
+
+void __d_drop(struct dentry *dentry)
+{
+	___d_drop(dentry);
+	dentry->d_hash.pprev = NULL;
+}
 EXPORT_SYMBOL(__d_drop);
 
 void d_drop(struct dentry *dentry)
@@ -2378,7 +2385,7 @@ EXPORT_SYMBOL(d_delete);
 static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
-	BUG_ON(!d_unhashed(entry));
+
 	hlist_bl_lock(b);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
 	hlist_bl_unlock(b);
@@ -2815,9 +2822,9 @@ static void __d_move(struct dentry *dent
 	write_seqcount_begin_nested(&target->d_seq, DENTRY_D_LOCK_NESTED);
 
 	/* unhash both */
-	/* __d_drop does write_seqcount_barrier, but they're OK to nest. */
-	__d_drop(dentry);
-	__d_drop(target);
+	/* ___d_drop does write_seqcount_barrier, but they're OK to nest. */
+	___d_drop(dentry);
+	___d_drop(target);
 
 	/* Switch the names.. */
 	if (exchange)
@@ -2829,6 +2836,8 @@ static void __d_move(struct dentry *dent
 	__d_rehash(dentry);
 	if (exchange)
 		__d_rehash(target);
+	else
+		target->d_hash.pprev = NULL;
 
 	/* ... and switch them in the tree */
 	if (IS_ROOT(dentry)) {
