Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834217-2-6787404544051048539
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
    t=1519834217; b=gkJYBrW8xt7lkHHTjaRoRlrYEtGn0GXiLM/dVt63gB4ThEQ
    oIK1qc6P/XD1K3Bi6MR+b0l+lX/SEajz/LUJoLUV4BN2wUjoxt6TMqvrAUELJX0o
    Suloxh1tDybVh6EyzrtL4E+YkMnMjfFImXsWn9y/vlku87iWLkx5cjtcX4zYTnub
    F6wvNayD3niPuTyYccZpBNYXyponJru0Zhr7dqEXt8dD/yfpkCQQvEhs0SubGnIx
    GQPtJG1s1gyd2GeQQPgoHyl+aVTaQTSs2x+xM6Ci/beskGN11RGbjmyYL70fDWCj
    2YVp+0Uoed8jMppe0FGgfYWHGeNK/qHTA2qrZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834217; bh=bsQueb7udiP+DxKbIQJ
    6oiJC2Efdl2GthSTaDf3Hq6k=; b=B+YF0IEKVP8+ZDYeuFQ7NtnkOctG2SQHs69
    +LdsiHfuXKq9SaTZuAqPl7SAud0mOFko6BgXHvm1s9itRC+Ji7gnRPsIO7Y7lQCh
    C+NFr2lhKeBAizzhWyOtlE1sJ5sZI8wQGxftnpuf6yFZ8ee2aYEgt5UJCU7I379u
    rvRgpSGfcjBr3KE1iEp94RaHP5/0NRR2JtsGquPczsXgwuA2zY9/S1xuGAob6/0e
    aJkrTW5nYaSW/t+1fedN8pHPoqOaU2B42bJr/ZYYcge2qm+OOlXuUZHQubCO1OdR
    kVnR/DoB4kz+i9qv5rXVFHN1hfVb/v03HI/0jR+UI6daV8K2J9Q==
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
        id S1752891AbeB1QKD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:10:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933089AbeB1QI6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.512174733@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 086/254] ipv4: Use standard iovec primitive in
 raw_probe_proto_opt
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 32b5913a931fd753faf3d4e1124b2bc2edb364da upstream.

The function raw_probe_proto_opt tries to extract the first two
bytes from the user input in order to seed the IPsec lookup for
ICMP packets.  In doing so it's processing iovec by hand and
overcomplicating things.

This patch replaces the manual iovec processing with a call to
memcpy_fromiovecend.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/raw.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -417,48 +417,20 @@ error:
 
 static int raw_probe_proto_opt(struct flowi4 *fl4, struct msghdr *msg)
 {
-	struct iovec *iov;
-	u8 __user *type = NULL;
-	u8 __user *code = NULL;
-	int probed = 0;
-	unsigned int i;
+	struct icmphdr icmph;
+	int err;
 
-	if (!msg->msg_iov)
+	if (fl4->flowi4_proto != IPPROTO_ICMP)
 		return 0;
 
-	for (i = 0; i < msg->msg_iovlen; i++) {
-		iov = &msg->msg_iov[i];
-		if (!iov)
-			continue;
-
-		switch (fl4->flowi4_proto) {
-		case IPPROTO_ICMP:
-			/* check if one-byte field is readable or not. */
-			if (iov->iov_base && iov->iov_len < 1)
-				break;
-
-			if (!type) {
-				type = iov->iov_base;
-				/* check if code field is readable or not. */
-				if (iov->iov_len > 1)
-					code = type + 1;
-			} else if (!code)
-				code = iov->iov_base;
-
-			if (type && code) {
-				if (get_user(fl4->fl4_icmp_type, type) ||
-				    get_user(fl4->fl4_icmp_code, code))
-					return -EFAULT;
-				probed = 1;
-			}
-			break;
-		default:
-			probed = 1;
-			break;
-		}
-		if (probed)
-			break;
-	}
+	/* We only need the first two bytes. */
+	err = memcpy_fromiovecend((void *)&icmph, msg->msg_iov, 0, 2);
+	if (err)
+		return err;
+
+	fl4->fl4_icmp_type = icmph.type;
+	fl4->fl4_icmp_code = icmph.code;
+
 	return 0;
 }
 
