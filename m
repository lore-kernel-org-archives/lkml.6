Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837253-2-14536934812883307014
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
    t=1519837253; b=JW7Tcu2pX68ZK+btAULQheSPMowBZoy/9aRRK2QPSSttw2Z
    a5ZiGeaIy4uQ4gCZJwyG341qPF846Kz0bsHr8TDOsWY91AXnhRoKfsISmNyEU0Cx
    WALeobIiOAHMfiOCqykuwMCjsI8mERuorfFXeaLqoxS7l7vBSQyovNhp0aw2uICI
    nx+B2ZZfMMY99llqWo6XSC4PAU8wb97oAIxlC2AJzjsVZGTZ92kvPH4GqtfrLBgp
    JWEooHt/urbTk+bxgRUcI+5/i5jMl+fwqXtD3lMuOLlmJcHNb0s8GyyHEX73vl7W
    uQZGZ4PEJg/7OIAqpTsr7JxeOx05YSy1GWILurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837253; bh=bB8Swa/7AagFBAa/BrI
    BjCUJiM/2jaAowX0Pi9VsWZc=; b=jLAYGuHktLTIFcVuwfkdyoKl6LNgjVLhLpD
    UdJ9HgZ/AKdg70FMz7hJ7bxG2sOvIHNtbdlL9YyZ7eiEOKKcT3xqpXfMe1EXxSDp
    4oK4QE/mzfRWWNd/43ObhSQypHyB41nQkDfQIFdk5VRju3SB8iL+n4uRso19H1Yb
    9KdeFY/AhJZ0tu7DNHdWIN5WXgegs2u6Dd18q0zMQ5nkfNeQBY9bLTisNO/fxJKO
    fRoUH64iv/XLtUMP+zd50kjFFqsVgjlYMzenCfzE2J+FXQcY21m9yI6gGGsfDUwj
    zbs1oJCF5C+3go8z48OV6pJhO4IMsHoYAdH97NDnhh5Wk1KtZOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeB1RAj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:00:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34381 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932848AbeB1PwL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.555357156@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 027/140] batman-adv: Fix lock for ogm cnt access in
 batadv_iv_ogm_calc_tq
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

From: Sven Eckelmann <sven@narfation.org>

commit 5ba7dcfe77037b67016263ea597a8b431692ecab upstream.

The originator node object orig_neigh_node is used to when accessing the
bcast_own(_sum) and real_packet_count information. The access to them has
to be protected with the spinlock in orig_neigh_node.

But the function uses the lock in orig_node instead. This is incorrect
because they could be two different originator node objects.

Fixes: 0ede9f41b217 ("batman-adv: protect bit operations to count OGMs with spinlock")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.2:
 - s/bat_iv\.ogm_cnt_lock/ogm_cnt_lock/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -760,10 +760,10 @@ static int bat_ogm_calc_tq(struct orig_n
 	orig_node->last_valid = jiffies;
 
 	/* find packet count of corresponding one hop neighbor */
-	spin_lock_bh(&orig_node->ogm_cnt_lock);
+	spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 	orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
 	neigh_rq_count = neigh_node->real_packet_count;
-	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+	spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
 	total_count = (orig_eq_count > neigh_rq_count ?
