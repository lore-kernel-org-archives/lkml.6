Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324056-2-13802974933638385700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324055; b=M9pSefvDhX3R5fAhMf9g9NB65kqpG7PlLpmz9leL28o9SVZ
    lQvlb3I8JUVXx9ZuBE8BD5lVeKyVMw+anKAo1fYrYXmd4AZaipHQOW+zObuBcsOv
    2p8KorHTrFHhKjZ4FwepHj2EZ5OQCeVg14nouuwyAKI6IM0KfNtHgFPonSGTJPN4
    UAfjP6jBhFQgZD8YBBIGTJTVENXsEHUYxJ6FXH/S/NYfGMlx6g/ypbL5sTU9tz2X
    DQQWZ9+rH1KyX0LiagMXCCFniax9rtHu9CH4hYKztVuMKK/wB7o0cwvt1UiNXOSn
    XHIGDaVbTEWtAyZvyM15Kyf8NZR+gsiFN2fPe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324055; bh=o453g9QiRqobssoLmCJ
    oBI+PYRITJCWBsUSbhBM+Yuw=; b=stFcqEQfhtWgMk+Jgv92N4asbA0+UC81jpl
    Zrgk0ESjIpdFLt3er9HIjjzLm2yaXQ+ImC3W81a5TkeVb9IqejH5YmT/7iK/IHyk
    BAytkfT9R/coeLDy5aepAJ4I6Chd72JwAA0prWHcUux4VAq0CKYI2zePA4nQZBfd
    DqDah/u/pcHcAe3SNjL3OuFsmVFtNkTwzLfDa3uF+yI4q9l1l4HyC6aqnCQGrz/a
    9alubCTeiCAoGBR/C6L97Y+30pL93a/6u5Ww1i6C6F0CkQCZxhn0iqEEvzJu4SHm
    ZPpMSuQzZ+6LI9PZe2Lv+rA06clVJucNbkLnA2v/pwYC+OKV//A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeBKEeC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:34:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41555 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752708AbeBKEdo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Joel Becker" <jlbec@evilplan.org>,
        "Sunil Mushran" <sunil.mushran@gmail.com>,
        "Jie Liu" <jeff.liu@oracle.com>,
        "Younger Liu" <younger.liu@huawei.com>,
        "Jensen" <shencanquan@huawei.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mark Fasheh" <mfasheh@suse.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.690622623@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 38/79] ocfs2: fix issue that ocfs2_setattr() does not
 deal with new_i_size==i_size
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Younger Liu <younger.liu@huawei.com>

commit d62e74be1270c89fbaf7aada8218bfdf62d00a58 upstream.

The issue scenario is as following:

- Create a small file and fallocate a large disk space for a file with
  FALLOC_FL_KEEP_SIZE option.

- ftruncate the file back to the original size again.  but the disk free
  space is not changed back.  This is a real bug that be fixed in this
  patch.

In order to solve the issue above, we modified ocfs2_setattr(), if
attr->ia_size != i_size_read(inode), It calls ocfs2_truncate_file(), and
truncate disk space to attr->ia_size.

Signed-off-by: Younger Liu <younger.liu@huawei.com>
Reviewed-by: Jie Liu <jeff.liu@oracle.com>
Tested-by: Jie Liu <jeff.liu@oracle.com>
Cc: Joel Becker <jlbec@evilplan.org>
Reviewed-by: Mark Fasheh <mfasheh@suse.de>
Cc: Sunil Mushran <sunil.mushran@gmail.com>
Reviewed-by: Jensen <shencanquan@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ocfs2/alloc.c | 2 +-
 fs/ocfs2/file.c  | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7127,7 +7127,7 @@ int ocfs2_truncate_inline(struct inode *
 	if (end > i_size_read(inode))
 		end = i_size_read(inode);
 
-	BUG_ON(start >= end);
+	BUG_ON(start > end);
 
 	if (!(OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) ||
 	    !(le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) ||
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -474,11 +474,6 @@ static int ocfs2_truncate_file(struct in
 		goto bail;
 	}
 
-	/* lets handle the simple truncate cases before doing any more
-	 * cluster locking. */
-	if (new_i_size == le64_to_cpu(fe->i_size))
-		goto bail;
-
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
 
 	ocfs2_resv_discard(&osb->osb_la_resmap,
@@ -1149,14 +1144,14 @@ int ocfs2_setattr(struct dentry *dentry,
 		goto bail_unlock_rw;
 	}
 
-	if (size_change && attr->ia_size != i_size_read(inode)) {
+	if (size_change) {
 		status = inode_newsize_ok(inode, attr->ia_size);
 		if (status)
 			goto bail_unlock;
 
 		inode_dio_wait(inode);
 
-		if (i_size_read(inode) > attr->ia_size) {
+		if (i_size_read(inode) >= attr->ia_size) {
 			if (ocfs2_should_order_data(inode)) {
 				status = ocfs2_begin_ordered_truncate(inode,
 								      attr->ia_size);
