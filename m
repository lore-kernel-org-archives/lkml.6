Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937882-2-12960467792994491279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937881; b=a3J+3FKv2e5O4Cx7gt0HwqSMuk5ibuT09N2bKT1xfZSqXCJhp/
    zbcmEVV+zIoEEPxpU8a25HaowpNX57X9vJr2y6f6UzyKVj9+bfsh86Eq82PlWkeQ
    9tctNX9mr1/GzyH8cn0ZUB+emIwnMDwh1g/ijE/M/X9U8fY0jcBpS4PrpfC3TuPM
    hV/L1vI8jk8GOzIk/V+6CbXo5Sif2od306T4nqOG5w48mu0gfQltJYEjrfJ0pbbN
    BnGPx67zon+45W9EvrU9Lkio2hpbDRNpbSUSIOwBPUvAj1/YRQcBj21NljFVT/Vx
    +29wK3P6DZPhk/5Fz1qoU2CfrwZVfx95YsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937881; bh=lIlLzvu30TYUcyKmZKvcPvtZDzpxrd
    3hrNpFtNPMnSY=; b=TsgVD9C63gGhsEQ6N51nC0r0ZR5ddL6aEN5ljRE3A4iOXA
    dK9pd9Uz+mexPMsm/bFcqXMYP1gaGX3E8RokabElx+hqihtSJG6UWBf+rfH14WyF
    cMml521Yd18iHCLIUWIuzARbCcS44Oz7WTSiEOxkNJNwjcDq7x4NmuzplAkY1Qzk
    bYK4YUdSGB0XNszUEOHmajC1XnqYUic/XBaVBbBx4OgJjXnbKw4uMRxT9RPvWgX9
    8Vo4Qy+Zrfxo3dP9l2BjR5dS70q7A1c1fGq+LtAt04uPt17RULiKKfQ/rTBAr7eZ
    NY0Vm/6IlpgS3GhuILsSm+cRzHX9jjFcS7ECN1lw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FltxVvOe x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FltxVvOe x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1dAgMHn2XqNVRkucflPtid8aJX/nAKbW5kEZev6jomM1xU1T81Spg/5rr/Yxcd+fvKgQACAy3Xf1wYj/LWeFQW3FXe1xmqn2y+L7AhYdK3An4iIvBT
    9yavHymIplBQEmAQygVH3e4I2PpL9r1u4Z4WNM4q8mR7XaQ1UszW86o5s4weao00ltVNlGdf6IaJBWJWw4Bh0bfqXoFvwaBN0nFANr9RvllSKInK38keiO/R
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=OoizzLiirw8PgB2rMYsA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeEUVYd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932255AbeEUVYa (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:24:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 055/110] Btrfs: fix xattr loss after power failure
Date: Mon, 21 May 2018 23:11:52 +0200
Message-Id: <20180521210510.398647772@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 9a8fca62aacc1599fea8e813d01e1955513e4fad upstream.

If a file has xattrs, we fsync it, to ensure we clear the flags
BTRFS_INODE_NEEDS_FULL_SYNC and BTRFS_INODE_COPY_EVERYTHING from its
inode, the current transaction commits and then we fsync it (without
either of those bits being set in its inode), we end up not logging
all its xattrs. This results in deleting all xattrs when replying the
log after a power failure.

Trivial reproducer

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ touch /mnt/foobar
  $ setfattr -n user.xa -v qwerty /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar

  $ sync

  $ xfs_io -c "pwrite -S 0xab 0 64K" /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar
  <power failure>

  $ mount /dev/sdb /mnt
  $ getfattr --absolute-names --dump /mnt/foobar
  <empty output>
  $

So fix this by making sure all xattrs are logged if we log a file's inode
item and neither the flags BTRFS_INODE_NEEDS_FULL_SYNC nor
BTRFS_INODE_COPY_EVERYTHING were set in the inode.

Fixes: 36283bf777d9 ("Btrfs: fix fsync xattr loss in the fast fsync path")
Cc: <stable@vger.kernel.org> # 4.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4749,6 +4749,7 @@ static int btrfs_log_inode(struct btrfs_
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	u64 logged_isize = 0;
 	bool need_log_inode_item = true;
+	bool xattrs_logged = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5050,6 +5051,7 @@ next_key:
 	err = btrfs_log_all_xattrs(trans, root, inode, path, dst_path);
 	if (err)
 		goto out_unlock;
+	xattrs_logged = true;
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
@@ -5062,6 +5064,11 @@ log_extents:
 	btrfs_release_path(dst_path);
 	if (need_log_inode_item) {
 		err = log_inode_item(trans, log, dst_path, inode);
+		if (!err && !xattrs_logged) {
+			err = btrfs_log_all_xattrs(trans, root, inode, path,
+						   dst_path);
+			btrfs_release_path(path);
+		}
 		if (err)
 			goto out_unlock;
 	}
