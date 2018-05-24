Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163014-2-9375911936153714342
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
    1527163013; b=I6ceFOK89sAJhVkSYvqj9NgV8h5umGZ9K75MD1jU4s/GEY0acg
    DUY+0u+OuyoYsgLIkDrlVpFImfc7SExFR33mU3iSwAXb4G74cR3grzFsMLhunCm4
    Bc+mOUTuSf4M5BXPb/klvBoj9M93QHOqbmKNgWppkG+p203mbWe+rOZPCd4Bo316
    MAmzXdZJs1n0uvKK6FBZF+buWWFBiqOYPtwlL4ql5bL4NjwXeeCbc6i6gTt5tF7V
    s46xMFORtabObylnn/o2PjB9KGF/+lIt5C8eqbonm7w1Uqstpi8KMB0idKWvVcnc
    s+NG+J0jPbLjbfCdRWZSMmNpNHT7Rva/YcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163013; bh=Wk+Jhwg//dMHFIzN6I397rHbq2eqow
    oXbK6SwFrD5FE=; b=iatiuYoY9kc/JzW9yrwbvjkoQpJXRFyXxZpVjC1z0HuZCo
    GjRt22y6+wxL6Rfx7l9+7lFbMK944p+2/TDVUCSkxu5DFAkccHDulDxpoXjGFkzT
    ge8AWskrRRhOVwZog0/KxIUm9C4pCqam9Obc5wCr6RvV5eUNiYPyWh22DQda/Tf0
    mLQOzj2axBQNZ8B6yOugbIRuI+Oc4xG7CnyU7ZTonK/wVhF75myxMggk/Bou05Gf
    PrtTfZWf+KgmIf0WLXlzdgwLnnFgkl7x/ON1YrmYoWKtSTjvIuvT/OgHy6EFLr2n
    wXjLXkuOZztSDL66Gs2sHHPuCKcwvHsAw/EUgdig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=01Lfoi5H x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=01Lfoi5H x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGji0O9xWUlsu3EMbAQRnzh8Lsw3WbrwAX80XCyqI1auCarEJvUlBcZhSWOGlXpndsy+j5fkIgFm80B3nEhJ2It554U8Ozx1167BwGYGJC6ggUGM/3Pj
    HQSy/ay6OVRQRTXpIB1JD56JtWEoRxSuCLWZ4et3uWGXifIKQ6u/+1rfGLPQqqqcDwdmHtU9yf7tVpiYcFsLk/884O3I7m3/aQ56VF5bzFME5qppcDXrgUkc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
    a=TU_DJ3MC0Tpo-rwQ4GkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966541AbeEXJpr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966818AbeEXJpn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4.4 70/92] btrfs: fix reading stale metadata blocks after degraded raid1 mounts
Date: Thu, 24 May 2018 11:38:47 +0200
Message-Id: <20180524093206.062830692@linuxfoundation.org>
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

From: Liu Bo <bo.liu@linux.alibaba.com>

commit 02a3307aa9c20b4f6626255b028f07f6cfa16feb upstream.

If a btree block, aka. extent buffer, is not available in the extent
buffer cache, it'll be read out from the disk instead, i.e.

btrfs_search_slot()
  read_block_for_search()  # hold parent and its lock, go to read child
    btrfs_release_path()
    read_tree_block()  # read child

Unfortunately, the parent lock got released before reading child, so
commit 5bdd3536cbbe ("Btrfs: Fix block generation verification race") had
used 0 as parent transid to read the child block.  It forces
read_tree_block() not to check if parent transid is different with the
generation id of the child that it reads out from disk.

A simple PoC is included in btrfs/124,

0. A two-disk raid1 btrfs,

1. Right after mkfs.btrfs, block A is allocated to be device tree's root.

2. Mount this filesystem and put it in use, after a while, device tree's
   root got COW but block A hasn't been allocated/overwritten yet.

3. Umount it and reload the btrfs module to remove both disks from the
   global @fs_devices list.

4. mount -odegraded dev1 and write some data, so now block A is allocated
   to be a leaf in checksum tree.  Note that only dev1 has the latest
   metadata of this filesystem.

5. Umount it and mount it again normally (with both disks), since raid1
   can pick up one disk by the writer task's pid, if btrfs_search_slot()
   needs to read block A, dev2 which does NOT have the latest metadata
   might be read for block A, then we got a stale block A.

6. As parent transid is not checked, block A is marked as uptodate and
   put into the extent buffer cache, so the future search won't bother
   to read disk again, which means it'll make changes on this stale
   one and make it dirty and flush it onto disk.

To avoid the problem, parent transid needs to be passed to
read_tree_block().

In order to get a valid parent transid, we need to hold the parent's
lock until finishing reading child.

This patch needs to be slightly adapted for stable kernels, the
&first_key parameter added to read_tree_block() is from 4.16+
(581c1760415c4). The fix is to replace 0 by 'gen'.

Fixes: 5bdd3536cbbe ("Btrfs: Fix block generation verification race")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2497,10 +2497,8 @@ read_block_for_search(struct btrfs_trans
 	if (p->reada)
 		reada_for_search(root, p, level, slot, key->objectid);
 
-	btrfs_release_path(p);
-
 	ret = -EAGAIN;
-	tmp = read_tree_block(root, blocknr, 0);
+	tmp = read_tree_block(root, blocknr, gen);
 	if (!IS_ERR(tmp)) {
 		/*
 		 * If the read above didn't mark this buffer up to date,
@@ -2512,6 +2510,8 @@ read_block_for_search(struct btrfs_trans
 			ret = -EIO;
 		free_extent_buffer(tmp);
 	}
+
+	btrfs_release_path(p);
 	return ret;
 }
 
