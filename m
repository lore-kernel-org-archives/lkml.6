Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519838816-2-10427573943743252490
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
    t=1519838815; b=GZbRN/hBFDVc3d4XTNDCqOCx8/d6cTrS87iKLfD4RBkNxl/
    58pKAe3pzy8qDossa92vwrCtEWOu4OhdhOYCdQpyVlVIpnp0fg5Gy50yznhn1pBs
    /Y6l1olhy5TRLhOG2y6IKdrnY7ua4T2H64HM1JUYAgmzv5tvaO8x5yIQF+I+ciWN
    aIq5RJtGxtf7K3jN9KTJ5IjKq0GYIF44HQqIOBfDzuwosOWLQuMbs3G0opOsTWtI
    54KgG/0Wxxi9ZXprdr3ZFd2+1SfQn9Z4jW+pvbVrcozx+Ox7fuzuuQdeOh5N/q66
    9l/I3Sn1E1+ZhQ9r1QYA0jzo4DK52FHfhLjeveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838815; bh=RKNfpSKHI+Jzd7eC+QU
    ZMRu/iv5IzAbDcHAHtkN+FkI=; b=wbRyNqPHbNOfxib4bzhEV/rfzVnSyg+q+uD
    mgZWDCwbMI3KOdSOnZWBQYLGgo3ViasAzCPZ5LZ6Sq+m7p7u4wjWvi1w0fSA0J/i
    o3qH9hQ3jFePir44iFesSQ5TC6pZDgeEaqY3GWm5eGV7jrsQOCmQThaZQSCEi06M
    RRwqHyvKgp5f9Sd1zl2DDiXjDVtWlVBPN3fzuuedi95s4ZVwD7L7V6qkL6P+CrZM
    u+EGZoJskY1C0KfMKe8qLzxb3gE7Ufa3TTvw2HAXwNadyiCc3T2vZffKZv6Lm0zi
    IPH0Hndzf77h2LCc8RvdJtbZdlUpwUjQu3Hy5ST3tDcqERcnpiQ==
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
        id S933361AbeB1RZL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33268 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932606AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sebastian Gottschall" <s.gottschall@dd-wrt.com>,
        "Felix Fietkau" <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        "Kevin Cernekee" <cernekee@chromium.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.816157827@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 114/140] net: igmp: fix source address check for
 IGMPv3 reports
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
@@ -310,7 +310,7 @@ static __be32 igmpv3_get_srcaddr(struct
 		return htonl(INADDR_ANY);
 
 	for_ifa(in_dev) {
-		if (inet_ifa_match(fl4->saddr, ifa))
+		if (fl4->saddr == ifa->ifa_local)
 			return fl4->saddr;
 	} endfor_ifa(in_dev);
 
