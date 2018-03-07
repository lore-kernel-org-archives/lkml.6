Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451636-5-18351993106135874599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451635; b=q31wUSixrnx0Zrbb7KaeSqOVCvOATsFPXPHdXJTLrtRC8xL
    aLnuxJ23Gp3l1cKCIBkIq366Gy68NcEJ8qdYfQGV/XLtU+LShcxKYOyZffhRj0pR
    AjIbqfEHbHa96uph4kKO6WraTGVB/tJS82ihx91boFwZRSUOhb1TKTr4m9ArmEga
    toZuCLs1UbiDzP3b1iPaByi6K5ttNko7QxI2MYSXA+teXMAupzIKMNzt9LFQl6py
    oF0G3B7HCjk2hUZ6lrBq5LFQm7Gc0PEoLgw08O+LXz+mP5Jk8maEaGvhVeQh3Jtn
    LyrvNpu1TqUEOf2wLzF7Fv6/pJY1SIAjV4QNnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451635; bh=Y5yydlpZymSBRcJEXYWs8zdw9E
    OlHB5PR0W5gK0AUKQ=; b=N1TXNjPTMfKQlh/13tNYID9s3DVY9SEi4NkJ/Rn83+
    m8uvedE/tTbSS+n9R/NTFlkBguPZwTL79HOvg+8/Is/4mbr2VbXH3koF3YDLWzIG
    /2g/Sl80UIY9Bs40bVsQSOcZkW3ktXVpg380RVE03pyFbGnQUO+BRQVNV3aywnJE
    3MLGUKJacHbxooO6j/Ixr4QNWcnma7QnU1TETbwaW6gCYtreAP9Rrv2koMXIoDtX
    clN4G/UF9oayGSMGs8I3oxpszUQyysLEwCJRx2xRYie8lG8fn2+iQachFdbWo9/s
    IXN4bzVSu0q9733Iq4BPD5DMax6a542VqHXctAyHXv+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbeCGTkc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:40:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934350AbeCGTka (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:40:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 028/122] btrfs: use proper endianness accessors for super_copy
Date: Wed,  7 Mar 2018 11:37:20 -0800
Message-Id: <20180307191733.334818208@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.

The fs_info::super_copy is a byte copy of the on-disk structure and all
members must use the accessor macros/functions to obtain the right
value.  This was missing in update_super_roots and in sysfs readers.

Moving between opposite endianness hosts will report bogus numbers in
sysfs, and mount may fail as the root will not be restored correctly. If
the filesystem is always used on a same endian host, this will not be a
problem.

Fix this by using the btrfs_set_super...() functions to set
fs_info::super_copy values, and for the sysfs, use the cached
fs_info::nodesize/sectorsize values.

CC: stable@vger.kernel.org
Fixes: df93589a17378 ("btrfs: export more from FS_INFO to sysfs")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/sysfs.c       |    8 +++-----
 fs/btrfs/transaction.c |   20 ++++++++++++--------
 2 files changed, 15 insertions(+), 13 deletions(-)

--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -423,7 +423,7 @@ static ssize_t btrfs_nodesize_show(struc
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -433,8 +433,7 @@ static ssize_t btrfs_sectorsize_show(str
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -444,8 +443,7 @@ static ssize_t btrfs_clone_alignment_sho
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1723,19 +1723,23 @@ static void update_super_roots(struct bt
 
 	super = fs_info->super_copy;
 
+	/* update latest btrfs_super_block::chunk_root refs */
 	root_item = &fs_info->chunk_root->root_item;
-	super->chunk_root = root_item->bytenr;
-	super->chunk_root_generation = root_item->generation;
-	super->chunk_root_level = root_item->level;
+	btrfs_set_super_chunk_root(super, root_item->bytenr);
+	btrfs_set_super_chunk_root_generation(super, root_item->generation);
+	btrfs_set_super_chunk_root_level(super, root_item->level);
 
+	/* update latest btrfs_super_block::root refs */
 	root_item = &fs_info->tree_root->root_item;
-	super->root = root_item->bytenr;
-	super->generation = root_item->generation;
-	super->root_level = root_item->level;
+	btrfs_set_super_root(super, root_item->bytenr);
+	btrfs_set_super_generation(super, root_item->generation);
+	btrfs_set_super_root_level(super, root_item->level);
+
 	if (btrfs_test_opt(fs_info, SPACE_CACHE))
-		super->cache_generation = root_item->generation;
+		btrfs_set_super_cache_generation(super, root_item->generation);
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
-		super->uuid_tree_generation = root_item->generation;
+		btrfs_set_super_uuid_tree_generation(super,
+						     root_item->generation);
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
