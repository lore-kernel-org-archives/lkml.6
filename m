Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652576-2-4883710853579549408
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
    1524652575; b=F1WcENXmHXIAIHXmwKNTt/RTO3snYXnqp/F0rw4EQ9UEZ9HdjM
    yPsq70uA5/toEUv0jw2KTh7Hhq5PtmIAGCYjA1n2HjwWqAMa/ApMw7IHia38gfnj
    lO8EA+VCD6T2LwoNuRL8hwo25+JDg3HZKDegTOQu4PFjMdnDIK5Wa5tpqe5zSvbc
    LPK2eMbnohWDX2hJR3+UJOPVbTiubOl8pCvodDUQYRpbKr+ttA2ZAZWkyGvPgnCz
    2O40N/5WpC/zxjLydu917+w+068wNN94t54Ufp7nFTuGwNehrbGpHhg8EUlgoiIc
    10ZxjZmEx05I4TsmREcvT/bPJfGAhnggXeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652575; bh=zgYKQ2b1Vqw7zxEmO1IQ5v8vUBF8rl
    h/YpVDgQpVIkc=; b=KwBWQ31qzevo+3hVTYeEe6g9iiTrTw/1EQd++ci2nf+NIX
    fgDrGA4dYPEO4lpS1rA3GuCVgXO3kwLW33holMZu8UjfVDgEdexYFNIHUE0RrOXy
    EMxZasDevqSGeODTMSy2eqz4RgNn7eCWRKDLNpfdPF5jDh2ze/mrWnY2fpxVpwsb
    7AQIwE5ci/Yx5RNN5kbPGrwK9CJ+wX5I2ir+b9PDLLN29ugJGMYrZULIYKekmrEv
    r4+bH62xxSMurMC9kduJ2UEuILKVG+V03oeLgYrZdzzliBh8F3E0OywG2p1mKZyb
    +Ty/nRwxVEXsNQTRlExJQqKHsIxnPSJx4J+Fn+qA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDB/XxkiHON6qsKlkGP65T0RSeG8i+5q6KsNK0ffmjfc80NKefJQXdYTyPKXV17QEZf1Qvrnmxk3hfecoOF54bIUnT14ZcYJ+e5N/nd4SCfOcnlb34l+
    TeIQw8UF+qUP+NoB09i+jgdcebnmrLn3cKpSgv8psIJ3N5gBkFtMQG2fg5Cqb6icYu9YUX5i6FrT6ii6PA1R29eisx4SOfj0uOrR3/Y6VYdCb9Gr/y3P0y5I
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=-uoBkjAQAAAA:8 a=FOH2dFAWAAAA:8
    a=ag1SF4gXAAAA:8 a=MMgsj02gUX_uUUbY36EA:9 a=Hi0t2_k7PQ-ozyHs:21
    a=vx518QJo98g2kNFJ:21 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22 a=y0wLjPFBLyexm0soFTcm:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeDYKfz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:35:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeDYKeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 04/26] btrfs: Fix race condition between delayed refs and blockgroup removal
Date: Wed, 25 Apr 2018 12:33:13 +0200
Message-Id: <20180425103315.020409043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

commit 5e388e95815408c27f3612190d089afc0774b870 upstream.

When the delayed refs for a head are all run, eventually
cleanup_ref_head is called which (in case of deletion) obtains a
reference for the relevant btrfs_space_info struct by querying the bg
for the range. This is problematic because when the last extent of a
bg is deleted a race window emerges between removal of that bg and the
subsequent invocation of cleanup_ref_head. This can result in cache being null
and either a null pointer dereference or assertion failure.

	task: ffff8d04d31ed080 task.stack: ffff9e5dc10cc000
	RIP: 0010:assfail.constprop.78+0x18/0x1a [btrfs]
	RSP: 0018:ffff9e5dc10cfbe8 EFLAGS: 00010292
	RAX: 0000000000000044 RBX: 0000000000000000 RCX: 0000000000000000
	RDX: ffff8d04ffc1f868 RSI: ffff8d04ffc178c8 RDI: ffff8d04ffc178c8
	RBP: ffff8d04d29e5ea0 R08: 00000000000001f0 R09: 0000000000000001
	R10: ffff9e5dc0507d58 R11: 0000000000000001 R12: ffff8d04d29e5ea0
	R13: ffff8d04d29e5f08 R14: ffff8d04efe29b40 R15: ffff8d04efe203e0
	FS:  00007fbf58ead500(0000) GS:ffff8d04ffc00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007fe6c6975648 CR3: 0000000013b2a000 CR4: 00000000000006f0
	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	Call Trace:
	 __btrfs_run_delayed_refs+0x10e7/0x12c0 [btrfs]
	 btrfs_run_delayed_refs+0x68/0x250 [btrfs]
	 btrfs_should_end_transaction+0x42/0x60 [btrfs]
	 btrfs_truncate_inode_items+0xaac/0xfc0 [btrfs]
	 btrfs_evict_inode+0x4c6/0x5c0 [btrfs]
	 evict+0xc6/0x190
	 do_unlinkat+0x19c/0x300
	 do_syscall_64+0x74/0x140
	 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
	RIP: 0033:0x7fbf589c57a7

To fix this, introduce a new flag "is_system" to head_ref structs,
which is populated at insertion time. This allows to decouple the
querying for the spaceinfo from querying the possibly deleted bg.

Fixes: d7eae3403f46 ("Btrfs: rework delayed ref total_bytes_pinned accounting")
CC: stable@vger.kernel.org # 4.14+
Suggested-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/delayed-ref.c |   19 ++++++++++++++-----
 fs/btrfs/delayed-ref.h |    1 +
 fs/btrfs/extent-tree.c |   16 +++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -553,8 +553,10 @@ add_delayed_ref_head(struct btrfs_fs_inf
 		     struct btrfs_delayed_ref_head *head_ref,
 		     struct btrfs_qgroup_extent_record *qrecord,
 		     u64 bytenr, u64 num_bytes, u64 ref_root, u64 reserved,
-		     int action, int is_data, int *qrecord_inserted_ret,
+		     int action, int is_data, int is_system,
+		     int *qrecord_inserted_ret,
 		     int *old_ref_mod, int *new_ref_mod)
+
 {
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -598,6 +600,7 @@ add_delayed_ref_head(struct btrfs_fs_inf
 	head_ref->ref_mod = count_mod;
 	head_ref->must_insert_reserved = must_insert_reserved;
 	head_ref->is_data = is_data;
+	head_ref->is_system = is_system;
 	head_ref->ref_tree = RB_ROOT;
 	INIT_LIST_HEAD(&head_ref->ref_add_list);
 	RB_CLEAR_NODE(&head_ref->href_node);
@@ -785,6 +788,7 @@ int btrfs_add_delayed_tree_ref(struct bt
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
 	int qrecord_inserted;
+	int is_system = (ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	BUG_ON(extent_op && extent_op->is_data);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
@@ -813,8 +817,8 @@ int btrfs_add_delayed_tree_ref(struct bt
 	 */
 	head_ref = add_delayed_ref_head(fs_info, trans, head_ref, record,
 					bytenr, num_bytes, 0, 0, action, 0,
-					&qrecord_inserted, old_ref_mod,
-					new_ref_mod);
+					is_system, &qrecord_inserted,
+					old_ref_mod, new_ref_mod);
 
 	add_delayed_tree_ref(fs_info, trans, head_ref, &ref->node, bytenr,
 			     num_bytes, parent, ref_root, level, action);
@@ -881,7 +885,7 @@ int btrfs_add_delayed_data_ref(struct bt
 	 */
 	head_ref = add_delayed_ref_head(fs_info, trans, head_ref, record,
 					bytenr, num_bytes, ref_root, reserved,
-					action, 1, &qrecord_inserted,
+					action, 1, 0, &qrecord_inserted,
 					old_ref_mod, new_ref_mod);
 
 	add_delayed_data_ref(fs_info, trans, head_ref, &ref->node, bytenr,
@@ -911,9 +915,14 @@ int btrfs_add_delayed_extent_op(struct b
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
+	/*
+	 * extent_ops just modify the flags of an extent and they don't result
+	 * in ref count changes, hence it's safe to pass false/0 for is_system
+	 * argument
+	 */
 	add_delayed_ref_head(fs_info, trans, head_ref, NULL, bytenr,
 			     num_bytes, 0, 0, BTRFS_UPDATE_DELAYED_HEAD,
-			     extent_op->is_data, NULL, NULL, NULL);
+			     extent_op->is_data, 0, NULL, NULL, NULL);
 
 	spin_unlock(&delayed_refs->lock);
 	return 0;
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -139,6 +139,7 @@ struct btrfs_delayed_ref_head {
 	 */
 	unsigned int must_insert_reserved:1;
 	unsigned int is_data:1;
+	unsigned int is_system:1;
 	unsigned int processing:1;
 };
 
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2615,13 +2615,19 @@ static int cleanup_ref_head(struct btrfs
 	trace_run_delayed_ref_head(fs_info, head, 0);
 
 	if (head->total_ref_mod < 0) {
-		struct btrfs_block_group_cache *cache;
+		struct btrfs_space_info *space_info;
+		u64 flags;
 
-		cache = btrfs_lookup_block_group(fs_info, head->bytenr);
-		ASSERT(cache);
-		percpu_counter_add(&cache->space_info->total_bytes_pinned,
+		if (head->is_data)
+			flags = BTRFS_BLOCK_GROUP_DATA;
+		else if (head->is_system)
+			flags = BTRFS_BLOCK_GROUP_SYSTEM;
+		else
+			flags = BTRFS_BLOCK_GROUP_METADATA;
+		space_info = __find_space_info(fs_info, flags);
+		ASSERT(space_info);
+		percpu_counter_add(&space_info->total_bytes_pinned,
 				   -head->num_bytes);
-		btrfs_put_block_group(cache);
 
 		if (head->is_data) {
 			spin_lock(&delayed_refs->lock);
