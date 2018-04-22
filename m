Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406521-2-157277918410629848
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
    1524406520; b=sHrdNaPaJyUoNqiJwdCBRJwdZaxyRW3tkRbOPu9psD/8a5vjp6
    m7TeeIdHnUmW3Ud7Ae9aai2KF5iR6ymmBTwllv3m3QQ8X7ouJHfD1c/H9ma3R2OW
    CGKs8KnBfA8CalGny6cjk7IrZDTACZ0C3BedZsnsZI4N6UKbilWxb4oBzwl/y4jK
    keLcVL7QCElcSmI6jtZbHtgZ9lhKbMtcPCzh85Te6UrMf6HjxuCKzoivZN3iYxvF
    QGB3j5if5BJpkKuTq5nCRCygf1uPeO3uKhI43/BRMvGZgv3HQrkrsl87pP+KT9EU
    l/+m1spjY6bU/ksodabDkDx/7P7bsENF1Z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406520; bh=eoSEkcdEJJONseMU/zKWy19e7iRC6l
    9LjJINUJhaWO0=; b=sfIkscjmUrP9S0i0E6NW6kB5k0PMFzC+9OrKJF69eh+JDB
    uhFVyfgwx6LYT4uUSN0FUeEGTcIMo6LDNC6cN5M1Gk3fLni2CcnN4D4O3RClUIs0
    ZlQsT2cGydWb8JV6RQNNM1YIUhX6f6QinxKTmUGTFfuMI6JQm26myXkN+B9GnpGC
    BelWAtyyQL5pTon7xWllkXKkXsvlUq5wtMT2YSWMlXi4VgP7IK5Hk9MzBGphVJ3U
    fYnUCVX0C3RQzKb7e5P1zY5MKX4xXTH4X3hfGQtZKzIucD4hD60Mjv3ykcHrCN/A
    z/JtgX5zqnkKr7E5AC6oUf1Qh0+VR9Gfz/ytgzzQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfMYhY0Nwfgyr3k1Sbw/JXpNTo/9zuJzPssfKVWsOQ6EJtbjICnXIaTukck68WAbW1GNNV38YOxhn8XZr5UK7KkRpLZaaYNu/oiOMDkR/MJxoVy2STWI4
    O6GZ8ke49nu4TEAJJWDnYFgxKUcqIhkV/BYn45IgnMFqkm4/8ltNH0RoEY83z9N8shXWS96i5RKPjk6KN+g2pF15JCg6xJspVUXcFVj7IvzieD/ejVQ5HotB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=kAG1-qF7eOe9gh-2ky8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeDVOPQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeDVOPO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 4.9 65/95] ext4: dont allow r/w mounts if metadata blocks overlap the superblock
Date: Sun, 22 Apr 2018 15:53:34 +0200
Message-Id: <20180422135213.085862274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 18db4b4e6fc31eda838dd1c1296d67dbcb3dc957 upstream.

If some metadata block, such as an allocation bitmap, overlaps the
superblock, it's very likely that if the file system is mounted
read/write, the results will not be pretty.  So disallow r/w mounts
for file systems corrupted in this particular way.

Backport notes:
3.18.y is missing bc98a42c1f7d ("VFS: Convert sb->s_flags & MS_RDONLY to sb_rdonly(sb)")
and e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
so we simply use the sb MS_RDONLY check from pre bc98a42c1f7d in place of the sb_rdonly
function used in the upstream variant of the patch.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2260,6 +2260,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2272,6 +2274,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2284,6 +2288,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
