Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324544-2-17938656164195780947
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
    t=1518324544; b=jCxlLqYtCM/RoVxlh/PJ1a3xfM6PsvhAb5eYYdLWLv5J9lw
    idRResNCAT2VzPyjDOqXg46ms825s+owA+A6wFOmoXUpvLDKeh9RR683zUmT+yip
    rUgSfD4NeFTwhB0mhXzLhOM22VWI7LuO591drSPUKP8EOTN3Yu3jKnUmG1nc2PMF
    nZiusizIjFI7iaJjVk1353oWDpwcpEhvOBaTTbjj8Tv29ghUhLVLlSBL1UOD/Q0i
    wZnvsCM/IXpteyPt/dvu4+CNeHmJCeBF+Y3XpJnscNPGxDWMlTx8/56ttHRUYWAo
    g29KLONAT8nt4+4FzRmu3vOX2pC8O45u9gbwWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324544; bh=FOBQyTlAlt+Z/0++2Xf
    4+CpcQMdGlpNzpxU8WM7srYM=; b=MMgh9/ZPeA+ZHoozbXTTxbMQ1Wm0OAJ98K4
    wF3VWlyjE+1thpbpFplRCjPIEqEKJW0APPPkw6hB5KHPSOnEcM4hiAgLlO0+U+hK
    P83LH28XhRo92Nzlp6ZdG43MAPcQPHDz7YeoeEwVR6ZlqzX3UsCqQ7qtFmu0iOov
    bpTjXeekeLRIl2z9U8KFUhXr/nZzfbrOWyCw9rm2rT8drzVtoKlBT5TuXHc6Lt9X
    QzJQOmvkU1F/rPVbpT+f62AZLZ8kJ4byknxkE0v3K6PeexGmdVWKBO577fiDW+UG
    h5G7AAB7obu2+H4OySBeZa2Z08Y9hHUKyfFvI2CY3rJnfzCF68g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeBKErw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41811 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752836AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        "Jianlin Shi" <jishi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.458088158@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/136] route: update fnhe_expires for redirect when
 the fnhe exists
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

commit e39d5246111399dbc6e11cd39fd8580191b86c47 upstream.

Now when creating fnhe for redirect, it sets fnhe_expires for this
new route cache. But when updating the exist one, it doesn't do it.
It will cause this fnhe never to be expired.

Paolo already noticed it before, in Jianlin's test case, it became
even worse:

When ip route flush cache, the old fnhe is not to be removed, but
only clean it's members. When redirect comes again, this fnhe will
be found and updated, but never be expired due to fnhe_expires not
being set.

So fix it by simply updating fnhe_expires even it's for redirect.

Fixes: aee06da6726d ("ipv4: use seqlock for nh_exceptions")
Reported-by: Jianlin Shi <jishi@redhat.com>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -650,10 +650,9 @@ static void update_or_create_fnhe(struct
 	if (fnhe) {
 		if (gw)
 			fnhe->fnhe_gw = gw;
-		if (pmtu) {
+		if (pmtu)
 			fnhe->fnhe_pmtu = pmtu;
-			fnhe->fnhe_expires = max(1UL, expires);
-		}
+		fnhe->fnhe_expires = max(1UL, expires);
 		/* Update all cached dsts too */
 		rt = rcu_dereference(fnhe->fnhe_rth_input);
 		if (rt)
