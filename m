Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937892-2-2555449062530058793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937892; b=O8huKmXq+Rf4VWEU8GVxBD4FnSfgZzgQl08Yfl4XecfBVDWRxT
    zgJvKsqr6IPh2WOgDNzitmisUd6RZpoAwV71WOLJgrMw5G/OC5XFwKDo5E/i2KjF
    cblrz+8PYet6eMD/C2i6IzWxmlTVvLtdys+YMEHoY2mLCkYkMVw4543tu1QorNei
    //6ItodMxWuRf8zIWAvMNXBB8Migk+JxfemvFHh2/9+ChGth3fnYJCEMJhwBjwqc
    Y+PkQIgMfICQ2R7e+P4MaRK1GVlcWknt+ei1xu4QkFFB0gGksoc4InFSyJujjH1z
    45xGaTrWvL7jlFmeicgIusqg5xcdfQaBqh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937892; bh=NLGuh4Ro59Is53ThI875DC1rN0eeuC
    wyAzt8h18zAgU=; b=kv8hH9JmLGI0c6thI919jHkJyL6IpUDPtj/0gSsbFS+Bn0
    Gj/+PYDE4oJ8tnSJxQjUfSNuZhRHFUWz7RdDLDoiv+u2zvA8E6BzWrb2WTkxEiyu
    iRsALU88YXIydRXFwPT+4IwRS7+dWDRIAQTEdK7MdYneawQ7UanN2sHbkgfnrRVm
    OWvIhmT18giVj5TLTg95wXECucoRhCcKswe9RJKWrnaLpsYfklauYOPHP3c8dFap
    ARJhvaCnytx3FyzMo+LUFtHmpF3ZK5BsPf0xEdtrzdoQj+c89bolIAJt5lea2nvO
    7QVE+Rme8Hf7hCqcBzfQP1Zt3T7/fAXJ+EJpJPZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BXoDhHZr x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=BXoDhHZr x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLZD1RIhchLbbUq0A/TfHBb2oUt/OIK6ETzijgUD/mufCOZkpU+pvW6jbEXnYzYWLc4tT8/XwCl36+pjleZK6Ju3xZKVpT5VkCQbP92oWV62U+hxwhyh
    T3osWjPiZ9IfPzaslSECZo6XS5Fl/grYknVEe/PibXKPhN9Me0jJC2+pprkSJ2iwjS4e2ftQMGFx2x3zYIYF4MfSx3tHQWWhHq4kAZqSqZHlGWavXVIWfZxG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=JkOS3zwmIFKoxc-HOjEA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbeEUVYr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932302AbeEUVYn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:24:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4.16 059/110] btrfs: Split btrfs_del_delalloc_inode into 2 functions
Date: Mon, 21 May 2018 23:11:56 +0200
Message-Id: <20180521210511.174373366@linuxfoundation.org>
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

From: Nikolay Borisov <nborisov@suse.com>

commit 2b8773313494ede83a26fb372466e634564002ed upstream.

This is in preparation of fixing delalloc inodes leakage on transaction
abort. Also export the new function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.h |    2 ++
 fs/btrfs/inode.c |   13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3153,6 +3153,8 @@ noinline int can_nocow_extent(struct ino
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes);
 
+void __btrfs_del_delalloc_inode(struct btrfs_root *root,
+				struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1762,12 +1762,12 @@ static void btrfs_add_delalloc_inodes(st
 	spin_unlock(&root->delalloc_lock);
 }
 
-static void btrfs_del_delalloc_inode(struct btrfs_root *root,
-				     struct btrfs_inode *inode)
+
+void __btrfs_del_delalloc_inode(struct btrfs_root *root,
+				struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
 
-	spin_lock(&root->delalloc_lock);
 	if (!list_empty(&inode->delalloc_inodes)) {
 		list_del_init(&inode->delalloc_inodes);
 		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
@@ -1780,6 +1780,13 @@ static void btrfs_del_delalloc_inode(str
 			spin_unlock(&fs_info->delalloc_root_lock);
 		}
 	}
+}
+
+static void btrfs_del_delalloc_inode(struct btrfs_root *root,
+				     struct btrfs_inode *inode)
+{
+	spin_lock(&root->delalloc_lock);
+	__btrfs_del_delalloc_inode(root, inode);
 	spin_unlock(&root->delalloc_lock);
 }
 
