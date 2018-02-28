Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832479-2-14922650102637877438
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
    t=1519832478; b=degRnPUzjomQyOvC5rbvX3CEYbTrMTz8rZwrX5u/pM8BdDh
    MbrMZSKQBGFc3qZ1RlUBCbuOzc0+534n4mU7JGOG2kDSJ1O6v/YxuWfP5SrTkKjQ
    xtOIqFUlM1qJ+O4Gs0WxgS4lcapzD67OqUYVHQeBPnFa+aTMDfuiNPWpHjLA7h5N
    o7JciRpq4MkMfwr+FQRplpgvXhUOqgtpYoy4eZfa2wd9MC1yA5IvzCAdfi6UvFF1
    GarzdvYyCmJ77A5/J2ek2xkOJr0LT5aZ5lydjjUcppvF7gIRUwhsyJzJfxvyUR3F
    Rmk2HeTNXGFLuedXmWKnWCAuhn8qqJaIXItdjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832478; bh=EnJ65idMdTdl6aNiUVs
    +DRLv1f2znBJVcMnmMajmu/A=; b=dDQK8EX4r9F7YQ95KjiaMhjN3JiYe2npKWc
    x1AgHpWajS+lRfmoNhshi6bicXwY42moo73Oo7AG23f98s/D7dct4smsnRyj8Dkz
    hr+SacYq+WS4QmSPo8IbKOSaVSY0tw2uyTcpdupzvWljb6cljzeMeCY5xYgHl2Gk
    D9POveui2XO1FgXA8wDuwiczHlS4t3TJtSBiIacBkLPXC2mcMLg5EmcyOpaIFK4E
    cGJ12vyJBAv+gNm7Z6UOae0Xg4dEz++5H6bJj6ggYUyOkELTRrgritc65TX8UvRg
    GXaOl5NK6e19061GA9rQurOXnmbY2z8iUnOa/R1Cj3xsHnLLUBw==
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
        id S933153AbeB1PjB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:39:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33199 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932358AbeB1PW2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:28 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jeff Mahoney" <jeffm@suse.com>,
        "David Sterba" <dsterba@suse.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.868956616@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 063/254] btrfs: fix missing error return in
 btrfs_drop_snapshot
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

From: Jeff Mahoney <jeffm@suse.com>

commit e19182c0fff451e3744c1107d98f072e7ca377a0 upstream.

If btrfs_del_root fails in btrfs_drop_snapshot, we'll pick up the
error but then return 0 anyway due to mixing err and ret.

Fixes: 79787eaab4612 ("btrfs: replace many BUG_ONs with proper error handling")
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8071,6 +8071,7 @@ int btrfs_drop_snapshot(struct btrfs_roo
 	ret = btrfs_del_root(trans, tree_root, &root->root_key);
 	if (ret) {
 		btrfs_abort_transaction(trans, tree_root, ret);
+		err = ret;
 		goto out_end_trans;
 	}
 
