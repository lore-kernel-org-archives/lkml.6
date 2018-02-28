Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838524-2-9370161262522457683
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
    t=1519838523; b=PmtwdfRgiYmBKY4iaEiGi7P0lKScenOXPP2XaRvAFo6dH77
    VoSt4YmIMWxoN003t9U2dJDvoaFEpf4X64EjzoFYzJJcqaXciljJBVW5R9NOsUvP
    PaJlXMeChPikD6B4t68jleDUzBF1RXIGX0ysX9mr56uQuqmeMkMpz+Zpty9vUk8o
    DHi52cwl/TwdncKLmHuoeGCTjGDzw5CWJRMHE4KUHiU7IVW1ub1G26580f+eV2Ho
    0/C/4cSVAMVgLcUVEHPiqUkt8DpdwBWp//GAq+MvchFDAciRQ6BbQsFJM6BYg9/O
    VSzoMpMul67l8mUGXA+BD5RofqYNwH8nVkn75Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838523; bh=hQHRbEolDCENQr5A7IY
    zWDw5rydTO6lRouWcap5IqN4=; b=UfHtBVmuEiM2ecz21/5/7HBI2xMcTSCdo2M
    ER+jFvTWaGSZKP9j0SBN85BrGQlm0WdCBqe9uSCwOjM1UinebVJi57UPtx6nZ2fg
    Ud3vu63jSmkqofv4ogTE3Oy5nOAvECY2I/NqHaq7k1V/u+clF5HKbkoYh3vkSY6V
    aWfCXrfZy8xtAlhcYNBH7DeI2mUjQUVjnD8hPXpqUNI0Ex5kLO6nfnD/a9IEVJ4z
    pWaXlr3iybTM3QXilwdB6h/sQnOKjL/FeYsSdOWxYbYMzQtKFLYjwbZFprJjUp5z
    CHXKyjSa721z1+uKa2rv+U2QfpU7+q+gG+1d9/jpuL3XShTQDhQ==
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
        id S932663AbeB1Prk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:47:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33337 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932633AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.194131703@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 084/140] xfrm: Use __skb_queue_tail in xfrm_trans_queue
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit d16b46e4fd8bc6063624605f25b8c0835bb1fbe3 upstream.

We do not need locking in xfrm_trans_queue because it is designed
to use per-CPU buffers.  However, the original code incorrectly
used skb_queue_tail which takes the lock.  This patch switches
it to __skb_queue_tail instead.

Reported-and-tested-by: Artem Savkov <asavkov@redhat.com>
Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -324,7 +324,7 @@ int xfrm_trans_queue(struct sk_buff *skb
 		return -ENOBUFS;
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	skb_queue_tail(&trans->queue, skb);
+	__skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;
 }
