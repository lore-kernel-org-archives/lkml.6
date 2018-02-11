Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324581-2-1610007760317276815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324581; b=G6l4/+sAYV1jb1Ue/lOxEUILdwSaSXsyayZjF7LjBHUS+tG
    2SewDEK5pO6zYr0iZMsS+8HvmGL3qYDHumwNbvB2P9uF2ryWySdKZ6QJ/ZmOY5se
    t0a9+vTKSf3v2H622MlXB2lujwXZX8YQiBG063sYSx/nCLy/03Gw/SJkvRKKlMux
    KoQPE45S5XkvrKTDcQ/2I9VTaz1XwJT9l4gLq3wJvLfOD2kdZ0z37vKQFrzagkgN
    i4HK9yk+M6NNUyG8wxTVANf/dAoYVnF80qEjHe0qmMGAWycN8e93KBNHtpZUQZLY
    FUYJCs6qce/5E6YI2Y47zLc44SYisc4WKXlJYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324581; bh=Se/yn2AbScEzSjqsWZB
    +aa6kLR1D5hTQmJs+B4RYQzI=; b=lWKKZh1bsAF154dwmZCalTEAedZi8QXtEP8
    Q7xMkxOEf7bk+LhVwy8jV8DKDycR3Nziy4u5S/cCKLYHlGmbAmPtVRfHFst1z6aY
    wcrBTD1Hx8jbfuY5N6fyJhmH9EpFkmqISuIsvunIHJZbKiG9KTyBcII5srjmIWwq
    2ldF8CJrEVc18EA/WcYG/WSzQVMLV6/31+qYpvg7AY5Al7kl/UCa+uMIDy7ra9EL
    Br/5XeVVJHHsBr3+N6clSBvKfHTkVfzbLF6pEgx5MtmbZT6WIjAs7b4EZpuQT+io
    W/T6MY/UhstuBpbQSZOQUuepgsgwLBTLgzklyHnjI5UDGvc4Tcw==
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
        id S1753036AbeBKErs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41824 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752848AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.956147802@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 099/136] route: also update fnhe_genid when updating
 a route cache
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit cebe84c6190d741045a322f5343f717139993c08 upstream.

Now when ip route flush cache and it turn out all fnhe_genid != genid.
If a redirect/pmtu icmp packet comes and the old fnhe is found and all
it's members but fnhe_genid will be updated.

Then next time when it looks up route and tries to rebind this fnhe to
the new dst, the fnhe will be flushed due to fnhe_genid != genid. It
causes this redirect/pmtu icmp packet acutally not to be applied.

This patch is to also reset fnhe_genid when updating a route cache.

Fixes: 5aad1de5ea2c ("ipv4: use separate genid for next hop exceptions")
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -623,9 +623,12 @@ static void update_or_create_fnhe(struct
 	struct fnhe_hash_bucket *hash;
 	struct fib_nh_exception *fnhe;
 	struct rtable *rt;
+	u32 genid, hval;
 	unsigned int i;
 	int depth;
-	u32 hval = fnhe_hashfun(daddr);
+
+	genid = fnhe_genid(dev_net(nh->nh_dev));
+	hval = fnhe_hashfun(daddr);
 
 	spin_lock_bh(&fnhe_lock);
 
@@ -648,6 +651,8 @@ static void update_or_create_fnhe(struct
 	}
 
 	if (fnhe) {
+		if (fnhe->fnhe_genid != genid)
+			fnhe->fnhe_genid = genid;
 		if (gw)
 			fnhe->fnhe_gw = gw;
 		if (pmtu)
@@ -671,7 +676,7 @@ static void update_or_create_fnhe(struct
 			fnhe->fnhe_next = hash->chain;
 			rcu_assign_pointer(hash->chain, fnhe);
 		}
-		fnhe->fnhe_genid = fnhe_genid(dev_net(nh->nh_dev));
+		fnhe->fnhe_genid = genid;
 		fnhe->fnhe_daddr = daddr;
 		fnhe->fnhe_gw = gw;
 		fnhe->fnhe_pmtu = pmtu;
