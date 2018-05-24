Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163039-2-9755757121889631535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163039; b=gr1maxK0pKT0YynB4b1fcZDAvEwfXUxRWAuXK2Kxqobq8qodwJ
    18exo+ArERoaD+KHS9FIkdIRTaUgMDFGao6u3F9JbCDLJzsY1KZFfrVQ8cgiW2QT
    AByXeDqs4pofAtsWhwkbgs5vQueia9Fge3Xk44P6CkWaxmfEp7uOq4RluiwbKC+v
    M38NuSB1BukXnLg0XLM4/tWcgHBtMwJJzftDGQ/QM9MJKdNXzk4xGG29T1Pict/+
    1/x8MXAUEkm78AXFeeqoCJ3xnoZ1iqVCzzGshkYmx2SZtGe6oSxt/o5WnWTwsQQR
    gg0Fkw/dJfe2yMbFipB0+0ClpmsqoeCnogIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163039; bh=yphp+Zr1qGMjNi/65X36Nz0UxP1G3z
    DKQvLoZ32YI0w=; b=Bs01Lpsg3+WbBSgL8x6ahWGtWaVrjssiK8BkfQct2PUWvN
    bRFteyGNMGmIO6N895xzKxmet2ObPNVwso4NmKtmrEX7bOjLu5/Su3he4SVRJJfB
    PV3DzFowi2ROS3k4aO+2LGT/wUgyYlhCaO/eVXFTBxFt/7A30Pw6+JFC09L/L3jG
    YwGjgLVTXx1f49Oi4AKZPKEat1gA+CdpXBZhTr1w84sE5b7gLWpi42B2gVD6QpB5
    kSel4sgPmB7cNsdrjrj0nMsp5pPeS8iFaA5mXyZ/cq8Zs+6W/o635+InDJgmQGuu
    9fMelRjVapKeHmz2XfcLpJhF6bDk9CmdVp/PZMog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=aTXACcrx x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=aTXACcrx x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE+6/8n/dCaVu8CpZ18UVqhc6/LOktIAKiODf43vN0z5BcP+3c+MraCMY4S9e7ig1eqPfO5kMIZdTFHSshxrzEFK/BDDTxUhM+9ywetGBmlXkGilJEXU
    wManiH6oegrdqQvs7blSyp3e9liEIYaVHBK437lIcTVGAwEXlXmKFyhfGH5mVIDQfMmQ3ELGUksgnkTlaBW6esG0bfpSTKcVAxXidwFLQEj4LWgdZ4y6ipSp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=OoizzLiirw8PgB2rMYsA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966816AbeEXJpm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966782AbeEXJph (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 68/92] Btrfs: fix xattr loss after power failure
Date: Thu, 24 May 2018 11:38:45 +0200
Message-Id: <20180524093205.854008094@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4568,6 +4568,7 @@ static int btrfs_log_inode(struct btrfs_
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	u64 logged_isize = 0;
 	bool need_log_inode_item = true;
+	bool xattrs_logged = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4808,6 +4809,7 @@ next_slot:
 	err = btrfs_log_all_xattrs(trans, root, inode, path, dst_path);
 	if (err)
 		goto out_unlock;
+	xattrs_logged = true;
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
@@ -4820,6 +4822,11 @@ log_extents:
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
