Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832054-2-9000620431591573074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832054; b=bBMWEqYO2vMjn0qqlPvExAYYeJiiUwuEtPmhAGJfXygRq59
    2y5ekYwnZF2ae5GkfQUfgufBY3Bp+4AW/+VONAmd5p53VYx6d3z3Mc07TMCgXai1
    tBHu/scXmxRMcpjTr4WBSpxy5QpJw1wfbg0Z2KrXK5M1n3lRWACq8gvpnS7Qxsk9
    ObVHVOtewaFfBlZVvI5dWMlb+x2pjEWj0rl/WJssQh+XMytGQU9lIwbv2PpSqv1L
    /i219XcqwhnGtq/D6tOOimZdmZ5yKELKlFq8Bl7iTTug/JpynIrgllXk3bKGZZpX
    X3lgWYwQpCa9Htb0MNRoP2FSt8CDXM1NP//7+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832054; bh=RdnWbvP8LQwx1JsoW9I
    DcBfPWBUqypk1lxPyIkfiSPo=; b=geownhDVMsduvh8olGeUU0yOtx7VH0bwUIX
    4KeHjvTZM/y/OzM4ateP6U6S6KHjDA+dV1CPu4cLqktJUTEbr8B7IRpf0DT1KgCP
    w0tSfQRst95hIWJKhBXVQUqg5oCKZBKcJ2j/6lpFXnSYhEn/MJUo76ISAh/DaV2E
    tBnVGnan6hYY4ZAaNU7BW06Q0a8S+lMUEcfOMvzqnkjCLQEcCQiNiRaRu4Ye5k0F
    4uYmPTWnnBZbVglKd57SN1/rwpo8Y+eii9CU07Z99Fk5VXUHQpd+qYGKT6TxLPpg
    X665JHtSsVwKEif1q/LtL0BgNMPaFG/wXQ1cVjvodrjnzeRrKsQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeB1PcY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:32:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33257 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752790AbeB1PWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Josef Bacik" <jbacik@fb.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.627147734@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 007/254] btrfs: clear space cache inode generation always
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit 8e138e0d92c6c9d3d481674fb14e3439b495be37 upstream.

We discovered a box that had double allocations, and suspected the space
cache may be to blame.  While auditing the write out path I noticed that
if we've already setup the space cache we will just carry on.  This
means that any error we hit after cache_save_setup before we go to
actually write the cache out we won't reset the inode generation, so
whatever was already written will be considered correct, except it'll be
stale.  Fix this by _always_ resetting the generation on the block group
inode, this way we only ever have valid or invalid cache.

With this patch I was no longer able to reproduce cache corruption with
dm-log-writes and my bpf error injection tool.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/extent-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3236,13 +3236,6 @@ again:
 		goto again;
 	}
 
-	/* We've already setup this transaction, go ahead and exit */
-	if (block_group->cache_generation == trans->transid &&
-	    i_size_read(inode)) {
-		dcs = BTRFS_DC_SETUP;
-		goto out_put;
-	}
-
 	/*
 	 * We want to set the generation to 0, that way if anything goes wrong
 	 * from here on out we know not to trust this cache when we load up next
@@ -3252,6 +3245,13 @@ again:
 	ret = btrfs_update_inode(trans, root, inode);
 	WARN_ON(ret);
 
+	/* We've already setup this transaction, go ahead and exit */
+	if (block_group->cache_generation == trans->transid &&
+	    i_size_read(inode)) {
+		dcs = BTRFS_DC_SETUP;
+		goto out_put;
+	}
+
 	if (i_size_read(inode) > 0) {
 		ret = btrfs_check_trunc_cache_free_space(root,
 					&root->fs_info->global_block_rsv);
