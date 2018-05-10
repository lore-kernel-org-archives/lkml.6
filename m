Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994075-4-15600830173036788411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994075; b=Vqfyj4PJyucSlXRzbOiEN0e0RltCWPjZnMmsMWMmGxwy0rTas6
    60TakM+mgaHGU6yO1UdkWygxcIhgx2tHRL8wowwXiBqdsUtzVxJYZii8QTpJo3ed
    9CuTC7F48mZIGPh8b0n1tOtiTrG+BKdlBGdi9IFNil/wnTPsMWsqM6JGK+XvMB7d
    w6d1s8+HyPGi4KqstEkKFWX5KukMEjqtSJ75hDnkgBSM7/c6jdVVQrvQ54qMPH8B
    B+kmlCIPYZkQlElbtPODekgHIQB9I9NrCaHAXsVigB51Dd38xkSpnXHj/5Unnp08
    9QWlMF4gGduy4oLbgYM331iolbWHcQIMamhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525994075; bh=
    KVsypjE1BURWk0mAcJwqOWHfVRkkbgJBubHRqTJ/PZg=; b=CJFIqqXrmgv8rqe8
    x1i+eOKhq6HSrGP3t9qaVEdFEIPXY2QAYeBnjhnrYDHJoKMi9gJENR7iIWeWGQPo
    NlJy3uDpEPsMOl3E5z9TcYuHPiKeHYDOxJ7/rOszkCZWg+WJ5T/YYKDF2Tpk4SMr
    2VeB6kCZrGaabjrIPJEvDMHnl/ZrJSHSou99etWZMU/CVXj159aAO8AQtiPUIfe1
    tVnhFv5cNITPApP9BZapx+7qV4kPsEpNfxPsE2qvC2E45vyyJfLcJ4NZKT/dV1pk
    bIZcsaP3EmAQ233+Thrl9Go5Y1EvA9j2ca7LQBe9NuwnReuUQ8aMQm1BzSltfx+A
    oqCcLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=PCfX1BIz x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=PCfX1BIz x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIdIce4M8KY2AJ5L47FnN8B5iM+XQF6rn2+dUpvkB21UG1UDRtNJVMN7LcPiivZ7ZGJ5JyilKkj/eR9pe75ZtoFdYABklndc1Lzqtd5tRODAhH92XAbR
    V1t4jUehWx3+EtzOp9kCWcGNivi7ruSMZja9IR4nAUcfD9XfDZBAzRCOnwEr9xTrdpj6vVpV5GciczSxk7Qw04vjXnOdiBm8IFXohLWmcl0twxRJKYuXpof2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=fK3w93xwot9p6KY6xAkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeEJXOP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbeEJXOJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:14:09 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc: sandeen@sandeen.net, dhowells@redhat.com, fliu@suse.com,
        jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 4/4] btrfs: verify symlinks with append/immutable flags
Date: Thu, 10 May 2018 16:13:59 -0700
Message-Id: <20180510231359.16899-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510231359.16899-1-mcgrof@kernel.org>
References: <20180510231359.16899-1-mcgrof@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Linux VFS does not allow a way to set append/immuttable
attributes to symlinks, this is just not possible. If this is
detected inform the user as the filesystem must be corrupted.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/btrfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4bdb597b323..d9c786be408c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3933,6 +3933,15 @@ static int btrfs_read_locked_inode(struct inode *inode)
 		inode->i_op = &btrfs_dir_inode_operations;
 		break;
 	case S_IFLNK:
+		/* VFS does not allow setting these so must be corruption */
+		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
+			ret = -EUCLEAN;
+			btrfs_crit(fs_info,
+				  "corrupt symlink with append/immutable ino=%llu root=%llu\n",
+				  btrfs_ino(BTRFS_I(inode)),
+				  root->root_key.objectid);
+			goto make_bad;
+		}
 		inode->i_op = &btrfs_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &btrfs_symlink_aops;
-- 
2.17.0

