Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834492-2-13843496589456396121
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
    t=1519834491; b=JvJqBOvo2l0eAjxqNClOtVVx6e7ksQn005dbBY+OCe72yzA
    XZMqmuizAMsjuv3WYbgf09b2gq/HWt6sCvAhbCPPQC9Tsq/ps+GtAFujVcE4nq1F
    AF3//vqVggjuUID93vAx+y6uAh1qmJKdKk1bhiC4eIOy5co5jKRD66mxRicgkMs6
    VaF8Tcv1VPrpNpTgc6rUpYHVasG6YebKQHXawG4a6zSHmXF8Hg3NPlzA4puOk0OG
    rp1ltAdpvtAMrdcIhy4ErD9GgJ3WZIe78T3e6+XjZiQssNPLns3+qKdBY9hE7qGx
    O39Q/HCS9IrdZY1E7WFqNpwR1CFWOrUbq+kqHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834491; bh=WBhEStVelZYrWIXS5wK
    caOGrWH7wtSmPATXBK/exQig=; b=mTme3ncwsvSMoEH5SbUMJ6Z41wWXAQbiQ6L
    gQboGhZ2bC0RIY7tXsTo8ykD+zZEvMMotQjSOZyVSEp2x0iR4tS4tPtBazCNctGX
    vL6Vwx+DjcPVYHNvVGRGMp2yl/5OVDScs08qPBGSSNm69jTMKVSivS6lg0+QGpa7
    16X5G9YmdzCadqwbU4eYh+P9fc3tqkJ7c1VmfK9PFJ276J6b0tLKdOKk1L87BFRe
    bwpdiR2+vP504BCqIenj+cUGy3Dd/FOE3EVYe9U6mBOs07Jv3zHneNWlYhbi9DnS
    tZfNi7botUKXeyKFH20PtI7fetJj2ObEsb1UdthTr2LA7xdP9uA==
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
        id S934584AbeB1QOr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35124 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934447AbeB1QOo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Monty Pavel" <monty_pavel@sina.com>,
        "Joe Thornber" <thornber@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.300271342@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 215/254] dm btree: fix serious bug in btree_split_beneath()
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

From: Joe Thornber <thornber@redhat.com>

commit bc68d0a43560e950850fc69b58f0f8254b28f6d6 upstream.

When inserting a new key/value pair into a btree we walk down the spine of
btree nodes performing the following 2 operations:

  i) space for a new entry
  ii) adjusting the first key entry if the new key is lower than any in the node.

If the _root_ node is full, the function btree_split_beneath() allocates 2 new
nodes, and redistibutes the root nodes entries between them.  The root node is
left with 2 entries corresponding to the 2 new nodes.

btree_split_beneath() then adjusts the spine to point to one of the two new
children.  This means the first key is never adjusted if the new key was lower,
ie. operation (ii) gets missed out.  This can result in the new key being
'lost' for a period; until another low valued key is inserted that will uncover
it.

This is a serious bug, and quite hard to make trigger in normal use.  A
reproducing test case ("thin create devices-in-reverse-order") is
available as part of the thin-provision-tools project:
  https://github.com/jthornber/thin-provisioning-tools/blob/master/functional-tests/device-mapper/dm-tests.scm#L593

Fix the issue by changing btree_split_beneath() so it no longer adjusts
the spine.  Instead it unlocks both the new nodes, and lets the main
loop in btree_insert_raw() relock the appropriate one and make any
neccessary adjustments.

Reported-by: Monty Pavel <monty_pavel@sina.com>
Signed-off-by: Joe Thornber <thornber@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/persistent-data/dm-btree.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -588,23 +588,8 @@ static int btree_split_beneath(struct sh
 	pn->keys[1] = rn->keys[0];
 	memcpy_disk(value_ptr(pn, 1), &val, sizeof(__le64));
 
-	/*
-	 * rejig the spine.  This is ugly, since it knows too
-	 * much about the spine
-	 */
-	if (s->nodes[0] != new_parent) {
-		unlock_block(s->info, s->nodes[0]);
-		s->nodes[0] = new_parent;
-	}
-	if (key < le64_to_cpu(rn->keys[0])) {
-		unlock_block(s->info, right);
-		s->nodes[1] = left;
-	} else {
-		unlock_block(s->info, left);
-		s->nodes[1] = right;
-	}
-	s->count = 2;
-
+	unlock_block(s->info, left);
+	unlock_block(s->info, right);
 	return 0;
 }
 
