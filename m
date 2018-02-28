Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836166-2-13894737598002323848
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
    t=1519836165; b=JQEhqf3qaIx+mO5S+JHfiWSMU4Xm1ZqF+NjcTMlEAEsZd9W
    WZi18wBgpYfDJw8Akopo/rcZJLAggPMsOrRw9wjksh8VkGxP/NdWxPAO27B7Cp5K
    OrLMWA/me16+SbOqvwvZnOeL63fLFtsaVljaWLdnLGIKPRUySvsy1M7H7esSi5uB
    FWys221XQ08xs34y5YOV28FiMAIkQTNEjWN8JqG5840uU9P6FEIYVOvCjM7RnExT
    zk+RIBIQ0FmC4cD/RoW5G7UYKAGuKflJcyvp19bcGG6JygaYEv76WouC9eqq1LDr
    0gmU3iONwtx1pGyQdtM0x6s7Ji6YKDhq5hpHJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836165; bh=6E0zGBdpyIny4BbpB4J
    ksrfZVgzVzL2Bks9WUn0QjEk=; b=J8OCBGdt/VP3Wy6AI7b+BM1X3/XEiEZVnGs
    MzHhCoOuASVtcVrycZ7/9anXj5kuBYgL9YI4vnUzjnFJBDC16szba0iGM0PJrtQm
    CaK/dyBIL+j6DNor0fa2M+0aB5Q9Zeapxua141k7/kkmUK6bKjluDoZeAhAnVtJl
    o0vUcNLt+vuAbhEixeXFvgKFe1CkCRWurGt0Ud3iwbEeo1IvrEROMTs1oFiFwBhn
    sCrM64r3wuqnMJK+p4MxZ4NiwF+dqGG5SExhCE9O7IemYl4Pctk+vw3/BCAnmVXu
    S+pAPPf+QdXktZwtnI0l8r4s8lMIyxAJnDC+ueiYSq87qVm9QPQ==
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
        id S932852AbeB1QDV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34756 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932699AbeB1QDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.973317156@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 172/254] xfrm: Use __skb_queue_tail in xfrm_trans_queue
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
@@ -414,7 +414,7 @@ int xfrm_trans_queue(struct sk_buff *skb
 		return -ENOBUFS;
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	skb_queue_tail(&trans->queue, skb);
+	__skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;
 }
