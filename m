Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835640-2-17983541999528219851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835639; b=QvZVLuE16VRRMjNP7/DssE7fE6lgLaAZzYi2WAFbB5/SUgz
    270OewA+Ip41kznXwRd6AZwMhQUijWhwPjHDZxyy5Vk6WqRCzqrCb/rR+Jn0Z7fq
    /Q9aGUaw/gUgQORUx55wN164Zfgflcf7fGOJCzXkA9dOmDjzRc41TgvX0ywwyQMp
    GjKgxsVuLy7bCpzin9ZXd6letpjWA1FiRID9bM1C/5kv/k9rcRhWeat2fn7Cc8le
    1//fvJ61tc0Sc42E9H8St2/nOceXx/XZh9GQNWH0y4PYwdnUH2NgABQOInwg2rEs
    pIiVkukzL9rEBm4jeQ2B8vVoLsNVmaY1s4tzqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835639; bh=Nq/LI5zjvDsr8F0qoiJ
    +LzJSXIPvuGejrMmKiVSmuog=; b=lMiSP42TmuJvDGbLMdOHiRU/gk7MfeSLTu1
    UjRqK1OH14iNi1RIY/QdkHSRE96j4nQwzZaN1Soep+IYiYAVUHs6GJt00dfiDeMU
    uueJWmVpUUieV7moXZx5G0dRTuLDOR1jF+bJejZf3VpFAopA+yz8CVNF+K5nhk/B
    CTG2X/VwR77YjQOzpXOMDgGOklQi+kmDhGRJUIKrMIC8oYh/R9uHgunemuumvc0T
    VO6MK414EAEpInaQex63N+Ux4QAaY6Y7dwBIIUPmn6w2bk5BIaK7Fq7RED4whonk
    Yg2n7oWeOSoNs6C4Nbcn/vs1td1LEY0I7f+iSrkjTPqZk/xm1sQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934681AbeB1QOG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35088 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932383AbeB1QOE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "monty_pavel@sina.com" <monty_pavel@sina.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.833916816@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 029/140] dm: fix various targets to dm_register_target
 after module __init resources created
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "monty_pavel@sina.com" <monty_pavel@sina.com>

commit 7e6358d244e4706fe612a77b9c36519a33600ac0 upstream.

A NULL pointer is seen if two concurrent "vgchange -ay -K <vg name>"
processes race to load the dm-thin-pool module:

 PID: 25992 TASK: ffff883cd7d23500 CPU: 4 COMMAND: "vgchange"
  #0 [ffff883cd743d600] machine_kexec at ffffffff81038fa9
  0000001 [ffff883cd743d660] crash_kexec at ffffffff810c5992
  0000002 [ffff883cd743d730] oops_end at ffffffff81515c90
  0000003 [ffff883cd743d760] no_context at ffffffff81049f1b
  0000004 [ffff883cd743d7b0] __bad_area_nosemaphore at ffffffff8104a1a5
  0000005 [ffff883cd743d800] bad_area at ffffffff8104a2ce
  0000006 [ffff883cd743d830] __do_page_fault at ffffffff8104aa6f
  0000007 [ffff883cd743d950] do_page_fault at ffffffff81517bae
  0000008 [ffff883cd743d980] page_fault at ffffffff81514f95
     [exception RIP: kmem_cache_alloc+108]
     RIP: ffffffff8116ef3c RSP: ffff883cd743da38 RFLAGS: 00010046
     RAX: 0000000000000004 RBX: ffffffff81121b90 RCX: ffff881bf1e78cc0
     RDX: 0000000000000000 RSI: 00000000000000d0 RDI: 0000000000000000
     RBP: ffff883cd743da68 R8: ffff881bf1a4eb00 R9: 0000000080042000
     R10: 0000000000002000 R11: 0000000000000000 R12: 00000000000000d0
     R13: 0000000000000000 R14: 00000000000000d0 R15: 0000000000000246
     ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
  0000009 [ffff883cd743da70] mempool_alloc_slab at ffffffff81121ba5
 0000010 [ffff883cd743da80] mempool_create_node at ffffffff81122083
 0000011 [ffff883cd743dad0] mempool_create at ffffffff811220f4
 0000012 [ffff883cd743dae0] pool_ctr at ffffffffa08de049 [dm_thin_pool]
 0000013 [ffff883cd743dbd0] dm_table_add_target at ffffffffa0005f2f [dm_mod]
 0000014 [ffff883cd743dc30] table_load at ffffffffa0008ba9 [dm_mod]
 0000015 [ffff883cd743dc90] ctl_ioctl at ffffffffa0009dc4 [dm_mod]

The race results in a NULL pointer because:

Process A (vgchange -ay -K):
 	a. send DM_LIST_VERSIONS_CMD ioctl;
 	b. pool_target not registered;
 	c. modprobe dm_thin_pool and wait until end.

Process B (vgchange -ay -K):
 	a. send DM_LIST_VERSIONS_CMD ioctl;
 	b. pool_target registered;
 	c. table_load->dm_table_add_target->pool_ctr;
 	d. _new_mapping_cache is NULL and panic.
Note:
 	1. process A and process B are two concurrent processes.
 	2. pool_target can be detected by process B but
 	_new_mapping_cache initialization has not ended.

To fix dm-thin-pool, and other targets (cache, multipath, and snapshot)
with the same problem, simply dm_register_target() after all resources
created during module init (as labelled with __init) are finished.

Signed-off-by: monty <monty_pavel@sina.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[bwh: Backported to 3.2:
 - Drop changes in dm-cache (non-existent) and dm-thin (doesn't have this bug)
 - In dm-snap, reorder cleanup of tracked_chunk_cache too
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1658,13 +1658,6 @@ static int __init dm_multipath_init(void
 	if (!_mpio_cache)
 		return -ENOMEM;
 
-	r = dm_register_target(&multipath_target);
-	if (r < 0) {
-		DMERR("register failed %d", r);
-		r = -EINVAL;
-		goto bad_register_target;
-	}
-
 	kmultipathd = alloc_workqueue("kmpathd", WQ_MEM_RECLAIM, 0);
 	if (!kmultipathd) {
 		DMERR("failed to create workqueue kmpathd");
@@ -1686,17 +1679,24 @@ static int __init dm_multipath_init(void
 		goto bad_alloc_kmpath_handlerd;
 	}
 
+	r = dm_register_target(&multipath_target);
+	if (r < 0) {
+		DMERR("register failed %d", r);
+		r = -EINVAL;
+		goto bad_register_target;
+	}
+
 	DMINFO("version %u.%u.%u loaded",
 	       multipath_target.version[0], multipath_target.version[1],
 	       multipath_target.version[2]);
 
 	return 0;
 
+bad_register_target:
+	destroy_workqueue(kmpath_handlerd);
 bad_alloc_kmpath_handlerd:
 	destroy_workqueue(kmultipathd);
 bad_alloc_kmultipathd:
-	dm_unregister_target(&multipath_target);
-bad_register_target:
 	kmem_cache_destroy(_mpio_cache);
 
 	return r;
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2293,24 +2293,6 @@ static int __init dm_snapshot_init(void)
 		return r;
 	}
 
-	r = dm_register_target(&snapshot_target);
-	if (r < 0) {
-		DMERR("snapshot target register failed %d", r);
-		goto bad_register_snapshot_target;
-	}
-
-	r = dm_register_target(&origin_target);
-	if (r < 0) {
-		DMERR("Origin target register failed %d", r);
-		goto bad_register_origin_target;
-	}
-
-	r = dm_register_target(&merge_target);
-	if (r < 0) {
-		DMERR("Merge target register failed %d", r);
-		goto bad_register_merge_target;
-	}
-
 	r = init_origin_hash();
 	if (r) {
 		DMERR("init_origin_hash failed.");
@@ -2338,8 +2320,32 @@ static int __init dm_snapshot_init(void)
 		goto bad_tracked_chunk_cache;
 	}
 
+	r = dm_register_target(&snapshot_target);
+	if (r < 0) {
+		DMERR("snapshot target register failed %d", r);
+		goto bad_register_snapshot_target;
+	}
+
+	r = dm_register_target(&origin_target);
+	if (r < 0) {
+		DMERR("Origin target register failed %d", r);
+		goto bad_register_origin_target;
+	}
+
+	r = dm_register_target(&merge_target);
+	if (r < 0) {
+		DMERR("Merge target register failed %d", r);
+		goto bad_register_merge_target;
+	}
+
 	return 0;
 
+bad_register_merge_target:
+	dm_unregister_target(&origin_target);
+bad_register_origin_target:
+	dm_unregister_target(&snapshot_target);
+bad_register_snapshot_target:
+	kmem_cache_destroy(tracked_chunk_cache);
 bad_tracked_chunk_cache:
 	kmem_cache_destroy(pending_cache);
 bad_pending_cache:
@@ -2347,12 +2353,6 @@ bad_pending_cache:
 bad_exception_cache:
 	exit_origin_hash();
 bad_origin_hash:
-	dm_unregister_target(&merge_target);
-bad_register_merge_target:
-	dm_unregister_target(&origin_target);
-bad_register_origin_target:
-	dm_unregister_target(&snapshot_target);
-bad_register_snapshot_target:
 	dm_exception_store_exit();
 
 	return r;
