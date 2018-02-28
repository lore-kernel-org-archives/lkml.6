Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836646-2-17478007683567890417
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836645; b=XRkSW5mHJedCYyDZIXovIDSwOoWoDIlhRZcZXh+AJyRutzC
    mHsKoL+dB8Ay61CLwdhfWPgl/lhPVdbwWQNMs1DdMyMjZl7TB2CE2TkgLaqAhiCG
    tBj/EhAhfiELSGXSsO7BEZ0UZTgXoCIXuTVY2RqJsEzLwgBUrh24nUUINebZC+D2
    KUxd2N2FnLH+IOphOnEZdITNrLDC/gUuNhZ8mMkmIzrndV1OxjhcECPk1kvzhEpq
    pikVFU/IVJ9DgvBjmuI2UhgkiTB9TglxBlA4Sn6TPz/RVLGxiofZjPaYlvgGmxXg
    tIy7H7tT/xtdfy834tZob69g75q2O01/ZiGP09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836645; bh=Wgp2u5iB38VSyyZz7Fl
    MuInq6aTvQva/5qzJGbJbQKc=; b=B1Eo2M2XUX0CPSJ34Gs29ZFfWHa6sMRU6qW
    4zZCaYUZ3EptR2A+0jES+ksw8fao/RlUBxeI7qpiLj1Ye1p+wsxdvKL5fQLPOAWJ
    lWhy6BXRQifKUPo5IZ70PVKXEEag1p9Qi0wPhC+QWEKhgWMPJDIFGpgSTMShbqyb
    EBzqJNx1Zx0PkjOj8nVoegGch40xDNNJJKgaAi1rZJErDd/IckQQmFMQ3kEby1EA
    ss6pKYlXEWt+6B5/4wkq1PUtZGYYZvQJh6CEns1N74Vyp9MTx8U+jV34784rg6ps
    R1ZtEd+Ia+xdrAeAhqTRQOb21SACsI0tKcRb2dnBF0XPmuX2giQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933605AbeB1P60 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34559 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934242AbeB1P6Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Eryu Guan" <eguan@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.755776828@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 048/254] ext4: fix fdatasync(2) after fallocate(2)
 operation
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <eguan@redhat.com>

commit c894aa97577e47d3066b27b32499ecf899bfa8b0 upstream.

Currently, fallocate(2) with KEEP_SIZE followed by a fdatasync(2)
then crash, we'll see wrong allocated block number (stat -c %b), the
blocks allocated beyond EOF are all lost. fstests generic/468
exposes this bug.

Commit 67a7d5f561f4 ("ext4: fix fdatasync(2) after extent
manipulation operations") fixed all the other extent manipulation
operation paths such as hole punch, zero range, collapse range etc.,
but forgot the fallocate case.

So similarly, fix it by recording the correct journal tid in ext4
inode in fallocate(2) path, so that ext4_sync_file() will wait for
the right tid to be committed on fdatasync(2).

This addresses the test failure in xfstests test generic/468.

Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/extents.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4726,6 +4726,7 @@ retry:
 						    EXT4_INODE_EOFBLOCKS);
 		}
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_update_inode_fsync_trans(handle, inode, 1);
 		ret2 = ext4_journal_stop(handle);
 		if (ret2)
 			break;
