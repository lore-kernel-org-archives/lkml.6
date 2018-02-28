Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839950-2-9429053345123324283
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
    t=1519839949; b=fZxgIMf+dsMGr2KmBwd1LS3gg7u05xtXi3NAzcRZ3YWRV99
    8k9KCMlQam9iveY/KoidFReN8TL92STOfTVIrbjgdv4FFUVQYgQyeoe0osYxtDQW
    5QU0B9GynoHqX6NCJqC1TInz6KQRS32CjiUsxJGRD/Zyt+xhpTKnV877j5IXVaBG
    CMEDh3Gwcs40jy9LCANR5oQ+RAtkiPfWFF7oVC4cg4RJ1rqx+yGRtOsc8em8BBpN
    wKTmYxG5zp4O8PUUBIR7eJQW35dAlmIDAgvLiuxielRcR/7pGNoAo9NoF7kNZVBu
    N8Ixbh0B8SNDAOVTxYF4/QZI/9kKr3n5umRiDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839949; bh=HVaJ+axtu/STYdkBWbr
    kGG7+FR6py6NkY2B2oEsejvQ=; b=afPs06N/IwCVYWX7WO5G2ElSBe479Aw00eM
    +peU0RZu1H1Ee3V40j8W24auGnjkUoyzAd6PK5eLfjtCevNBzHwz8p2dxEgaegMJ
    FxolCLYHIK5goaK13QuS6D+aLNihqJbEnSrbPb5IbZdWFNhAm2a7AeKhVPkk7H4I
    NqxPpI9LHdIZIRZeFZb/Kj+PfBfbj6yRmS/NP6koDxZmxQRUzJby/FAnyJ3o/Wbn
    Syl46VZtFr3OZ6Q36Ys5cw/QLdWAA9bPGAODip5SibP2bnfxeGLSNOXRFRjJDmWt
    j/a8R5LXTw2KT/8Hzz9z2QmYwdg26DNorOZyzO6H95kN0XQsTlw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbeB1Rpp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:45:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33093 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932457AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Josef Bacik" <jbacik@fb.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.449916705@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 005/140] btrfs: clear space cache inode generation always
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
@@ -2759,13 +2759,6 @@ again:
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
@@ -2775,6 +2768,13 @@ again:
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
 		ret = btrfs_truncate_free_space_cache(root, trans, path,
 						      inode);
