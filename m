Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837390-2-4729191050026888816
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
    t=1519837390; b=ROhkAO80dwIbJgBk3NCj/WiqrOQLhxq/VJTCd1LZ4NiBxir
    f+Qoi66oOufL4UcCwYwyJKAh6ITRPwXagOTgWTYlZFpC/5m0rmk2py0HqhQNzRVr
    DfQVUBlF7BCiaXhQCveyprxRQUxE7e5gxrKHFodnP4H2O3SMd00jU2zXG0Wv+TgG
    AWPTQjlph2b4fRsxH91aKUg5r7nJgIH09ztCnkJ31ePM4FE/aTe+OgD2EDV/1r38
    4bFjpfi2IerxmT2YnZdRFj04HIl6t78re05E94DhrLtzQfXhNEh/QfZk50F7JiAk
    MhHZ1gZgcBRguNYLwll/ZESYs7qUTFb7NZ4jDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837390; bh=PWTuOekSGyWEdGvpy4h
    M18/wNkwWFEZXxkaluuCXxxg=; b=ZdbcHarCBEzeAHWElk0w9Glj797cfNvimUl
    0LxIP95l921IbduGrcAWXcRbCwaNNcFYNkWJE+Mgo03BLLKApXmP2rKbF4EDUymT
    05vRV2qt5UJim9Z4vNBMDCHHaOjEnMhImeYs4gSm2KetdWVzjY3V+KXu0pBB8Eip
    qW+ac5bSHOnUXqLrefyT6T2oGBUiHUzvocsWUIiMvh4brutPO1tT4JjUglkS5Ol/
    mnhhMhBDyOigEBH/m9KDJa7cOLXEsLhF6Zd7N3fDZ4cIRLGjIuuZdceJDtI92Nmg
    U1/HGhuRhd1ENMCb8G36W92a2BHJcLIlwo/e7tlHSlllQdQs9Qg==
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
        id S933222AbeB1Pvu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34353 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933733AbeB1Pvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:48 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Kevin Cernekee" <cernekee@chromium.org>,
        "Sebastian Gottschall" <s.gottschall@dd-wrt.com>,
        "Felix Fietkau" <nbd@nbd.name>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.956153668@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 224/254] net: igmp: fix source address check for
 IGMPv3 reports
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

From: Felix Fietkau <nbd@nbd.name>

commit ad23b750933ea7bf962678972a286c78a8fa36aa upstream.

Commit "net: igmp: Use correct source address on IGMPv3 reports"
introduced a check to validate the source address of locally generated
IGMPv3 packets.
Instead of checking the local interface address directly, it uses
inet_ifa_match(fl4->saddr, ifa), which checks if the address is on the
local subnet (or equal to the point-to-point address if used).

This breaks for point-to-point interfaces, so check against
ifa->ifa_local directly.

Cc: Kevin Cernekee <cernekee@chromium.org>
Fixes: a46182b00290 ("net: igmp: Use correct source address on IGMPv3 reports")
Reported-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/igmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -334,7 +334,7 @@ static __be32 igmpv3_get_srcaddr(struct
 		return htonl(INADDR_ANY);
 
 	for_ifa(in_dev) {
-		if (inet_ifa_match(fl4->saddr, ifa))
+		if (fl4->saddr == ifa->ifa_local)
 			return fl4->saddr;
 	} endfor_ifa(in_dev);
 
