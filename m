Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324931-2-17348978158049212919
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
    t=1518324930; b=r14aeJJmjvMLglRIMrHFYVaWyJjSE3Wbl4zMt9B8Ugg9TaD
    G5eDQOQgRLtyQgquW5mL41fEeQl0ZUy+AXrGgyDTOwy9tvFnIMI6mdDbRwCWbvmx
    zPYIOr01CzpbNEuUGpk4O/SxLBrz+ENkNoW+6g8K/RG9yWWSoCXIFLNdAEFpNIyc
    3O2cJPhfb9N3Bpuy6Fq4akYPvRQk/TM31HA2dHWSqKX/LtgUF0Oz6Dly7/odk76F
    mmWwMKIXSMoDhHnm2c8A6KoN5KYTGjK0HjrIdf2sz/k+FxN2dApcPiqxLc5swhRf
    xbnW3aMF2qju2iS+Ac9bOOSAI/7Onl02U+qIvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324930; bh=k9UuK+s9DKNmLdPDLfc
    4eUvz/n648UG5pWklDUE6ZSo=; b=b5xWwtLzx5LTAs32Jrstu7okjCO2veQYCl4
    YQZqE8n2BKpAac6V47mwn5k0t0MxoyRaZS/B/O8IwwNugdymxASfukEjOw1tL58H
    pQ3aSNh2bFfmr43cP1M6MI+2Q931zfzMf1zblnGJmHxCKU7IWX4fF/mdM3QaboiF
    ZZO4t7Q6QGfQ0jHe3w4osOzGczgPooSU62rcos1YvFaWUtuydA5QkcoTqoBoxMS/
    z6GmnUNWOveoLouvDKY+Hk9EjJhl7diFeYlXc7g1qJ/LFlapOBVwp63ehQnj9j+/
    rgVs9TZE/09mX4G0zO81XFT9KBIAPUTIVrKZ/U/cmSQKYmXKdmg==
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
        id S1753436AbeBKEyR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:54:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41736 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752811AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Amir Goldstein" <amir73il@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.514559988@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 012/136] ext4: fix interaction between i_size,
 fallocate, and delalloc after a crash
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

From: Theodore Ts'o <tytso@mit.edu>

commit 51e3ae81ec58e95f10a98ef3dd6d7bce5d8e35a2 upstream.

If there are pending writes subject to delayed allocation, then i_size
will show size after the writes have completed, while i_disksize
contains the value of i_size on the disk (since the writes have not
been persisted to disk).

If fallocate(2) is called with the FALLOC_FL_KEEP_SIZE flag, either
with or without the FALLOC_FL_ZERO_RANGE flag set, and the new size
after the fallocate(2) is between i_size and i_disksize, then after a
crash, if a journal commit has resulted in the changes made by the
fallocate() call to be persisted after a crash, but the delayed
allocation write has not resolved itself, i_size would not be updated,
and this would cause the following e2fsck complaint:

Inode 12, end of extent exceeds allowed value
	(logical block 33, physical block 33441, len 7)

This can only take place on a sparse file, where the fallocate(2) call
is allocating blocks in a range which is before a pending delayed
allocation write which is extending i_size.  Since this situation is
quite rare, and the window in which the crash must take place is
typically < 30 seconds, in practice this condition will rarely happen.

Nevertheless, it can be triggered in testing, and in particular by
xfstests generic/456.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/extents.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4810,7 +4810,8 @@ static long ext4_zero_range(struct file
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	     offset + len > i_size_read(inode)) {
+	    (offset + len > i_size_read(inode) ||
+	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size = offset + len;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
@@ -4956,7 +4957,8 @@ long ext4_fallocate(struct file *file, i
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	     offset + len > i_size_read(inode)) {
+	    (offset + len > i_size_read(inode) ||
+	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size = offset + len;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
