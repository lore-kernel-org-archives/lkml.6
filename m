Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994113-2-8620841271461760187
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
    1525994112; b=Mof/XXY9sNq3FIEiSUeNcPHFg9M91UPw7Z2/tOvMzdBy77O1mm
    0DKeoX5SJlIjt3Pl9wdtLRL/C5QHlIB64rIjvHlGQ3oiwzS73wyhBpwMsgfybQjn
    SJsEJ0trV9+fExXgHixjHFLxXh+3LPcVuOw0hpxhnGbcA+ja/qk1npTXnjo+VenL
    tikgX5ki7Mw7RmXEEo0qKnoH/Wp6uVXhds9b1WoC5+BKRlislXfh/j90Saxzq8bx
    p0MZBUYEQNkKo/B7awkMUdPMXfORmqbhuBx+WR2bgbZ7oY6wnhhCjPUj29SFA4t/
    aLKeFx+LfBGLjtOS184awOvEyCLUf9obAOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525994112; bh=
    62OWX3tkv5ZHjTj2pEmfJ0x8wv/V+IE3zkVREwuKy2o=; b=OzOZGnp2OjvGQROM
    cp7JYUCsPxt5UfmHuRcBr9EBraVFz+jAk6y6E3K9C7OlgeXSclK/WVPrkP3/xyTp
    xoeL6KYGr3akXAti8/hSiZIZRxwcLmwBTJjF4BcSSNhubpwa7YHhNWTi5gc+Em4B
    SmZhtRxTcmhaVa/zrrS4JlqzSM/vvyVX5Ni2rIzLoF66grcwmhOOtNuuBUN0USH1
    M26K8RYnj/mWmTAYI7ahmTbCaXNQztbB/i44rFtHI/cpfY8hl+isrMK1uvJMeb1t
    D3ZcG6SIc6bcT386UV+NuanE4jXHRDBqUdNkjdx3jJhN3AlaBrF4pGRyg8Jd4k90
    OMtx+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=f0ErGCtY x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=f0ErGCtY x-bits=1024
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
X-CM-Envelope: MS4wfO5mENC/wizfOc8RP19wxh0sjgIjnjNeWdIUNGRv/UqTsPtF3cSbcrVk7ybjoRMOE0wWNX76n9NS0Ub9TfCTufHb5RPWqWYE292hvSLwDFHTEdmqSKRX
    +ZahqvnD1HTVRb7c++n89SUOQqsTc0xUk70gHISBpX3mR8nKlMrlLopV9rCE7KcQxSJH8Vp8vEpJVG54nb5RCzTU8NJcc8mj6Y9XRV3hbbxEbsSEAnHHINc2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=0jQyZ4-FzX624rPQNz0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeEJXOu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeEJXOI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:14:08 -0400
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
Subject: [RFC v2 3/4] ext4: add verifier check for symlink with append/immutable flags
Date: Thu, 10 May 2018 16:13:58 -0700
Message-Id: <20180510231359.16899-4-mcgrof@kernel.org>
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
 fs/ext4/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 37a2f7a2b66a..6acf0dd6b6e6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4947,6 +4947,13 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &ext4_dir_inode_operations;
 		inode->i_fop = &ext4_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
+		/* VFS does not allow setting these so must be corruption */
+		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
+			EXT4_ERROR_INODE(inode,
+			  "immutable or append flags not allowed on symlinks");
+			ret = -EFSCORRUPTED;
+			goto bad_inode;
+		}
 		if (ext4_encrypted_inode(inode)) {
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 			ext4_set_aops(inode);
-- 
2.17.0

