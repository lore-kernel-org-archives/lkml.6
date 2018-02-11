Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324568-2-2848782460833373098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324567; b=K6NHU+iFXJS33/3jmPguzmfxi+nkK4NqnBzBvRvG08qw74R
    N0/HvVePN7DpfpBD4G0RJIWrRtnm1zbzfP0/XpP1CeEz0jdEQq83grjF/5MaQKaV
    xKgR3GlWIz68gLxnlDcKOtmTyJQM83UDSzPlCZ6QZiDe1DznkOEyHc4qG5ZPW4nD
    3pBp50k5CYKpUKJXUi+BrGVUBRpp+4suvkVlzpsZj3U2+yBbD8LCcp60V13k+CgR
    KnUXu/CH4M9PDoOPkAXWmYNIxlT8kAQRiVXsmm6gVJdi0kjFpKlWxpL00wE7vOAq
    Eg9TiWn35P6G170x1jJPFwCUjImciotEgKj78RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324567; bh=r1zTZHfuocpRONEjzNf
    cj6B1MX30i4fBt7aGMQrpDrk=; b=uSJNObgUJPjP2jfVL9QwfChJy/CmBvZTO0p
    Ad8pBmiXTZ1CvOjwyaKsWr1tr/0zRcHAwI7PnSWWMDBt8irRBu3Ved1PTqmcURh+
    WWjLRUds1YVfT5Kz/qPTxucg54SVugtMVcTzb4/BFNeGi2dn7LmKESmahLoZNTel
    yA/vaR3W4qTNaUfewal82F7m6s0eV5czawoHQpHjtGyK+tlonAaLcRwfxiyqi+Im
    pnvv6ua0HnfjF3Y43WTsBBNKqpFb+iFVajhUP5UF9/lkz0fG9gHxo7yACeJDSLU8
    XSzGMSLcgtoI0wSbxH3KPBU6HIZ9uZRDqOOv/EI6/PLutUAQySw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeBKEru (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752845AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ryusuke Konishi" <konishi.ryusuke@lab.ntt.co.jp>,
        "Andreas Rohner" <andreas.rohner@gmx.net>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.957940409@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 097/136] nilfs2: fix race condition that causes file
 system corruption
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Rohner <andreas.rohner@gmx.net>

commit 31ccb1f7ba3cfe29631587d451cf5bb8ab593550 upstream.

There is a race condition between nilfs_dirty_inode() and
nilfs_set_file_dirty().

When a file is opened, nilfs_dirty_inode() is called to update the
access timestamp in the inode.  It calls __nilfs_mark_inode_dirty() in a
separate transaction.  __nilfs_mark_inode_dirty() caches the ifile
buffer_head in the i_bh field of the inode info structure and marks it
as dirty.

After some data was written to the file in another transaction, the
function nilfs_set_file_dirty() is called, which adds the inode to the
ns_dirty_files list.

Then the segment construction calls nilfs_segctor_collect_dirty_files(),
which goes through the ns_dirty_files list and checks the i_bh field.
If there is a cached buffer_head in i_bh it is not marked as dirty
again.

Since nilfs_dirty_inode() and nilfs_set_file_dirty() use separate
transactions, it is possible that a segment construction that writes out
the ifile occurs in-between the two.  If this happens the inode is not
on the ns_dirty_files list, but its ifile block is still marked as dirty
and written out.

In the next segment construction, the data for the file is written out
and nilfs_bmap_propagate() updates the b-tree.  Eventually the bmap root
is written into the i_bh block, which is not dirty, because it was
written out in another segment construction.

As a result the bmap update can be lost, which leads to file system
corruption.  Either the virtual block address points to an unallocated
DAT block, or the DAT entry will be reused for something different.

The error can remain undetected for a long time.  A typical error
message would be one of the "bad btree" errors or a warning that a DAT
entry could not be found.

This bug can be reproduced reliably by a simple benchmark that creates
and overwrites millions of 4k files.

Link: http://lkml.kernel.org/r/1509367935-3086-2-git-send-email-konishi.ryusuke@lab.ntt.co.jp
Signed-off-by: Andreas Rohner <andreas.rohner@gmx.net>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Tested-by: Andreas Rohner <andreas.rohner@gmx.net>
Tested-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nilfs2/segment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1883,8 +1883,6 @@ static int nilfs_segctor_collect_dirty_f
 					      "failed to get inode block.\n");
 				return err;
 			}
-			mark_buffer_dirty(ibh);
-			nilfs_mdt_mark_dirty(ifile);
 			spin_lock(&nilfs->ns_inode_lock);
 			if (likely(!ii->i_bh))
 				ii->i_bh = ibh;
@@ -1893,6 +1891,10 @@ static int nilfs_segctor_collect_dirty_f
 			goto retry;
 		}
 
+		// Always redirty the buffer to avoid race condition
+		mark_buffer_dirty(ii->i_bh);
+		nilfs_mdt_mark_dirty(ifile);
+
 		clear_bit(NILFS_I_QUEUED, &ii->i_state);
 		set_bit(NILFS_I_BUSY, &ii->i_state);
 		list_move_tail(&ii->i_dirty, &sci->sc_dirty_files);
