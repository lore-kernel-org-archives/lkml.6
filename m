Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451938-2-5084880401842073536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451938; b=QqGgtHIybjREIhi85kEfcUlJXuU/gSfqyPIG0ggE2we1qB+
    GPcjkIAxfBk+Ai/ljqBoYN1hYFdEP0Gj3vbw4xh5MNf4NLz9iqhCen0vkYp0nmlv
    Iwk99azG315+ya6SzairiYajHS7WwC1RYmVwtuZ0oz9saNB8fowpIP5qrTZTI2xp
    BfX3slexT+WUwJrh3BrXKzBJ8MJ9wXhyGKYht1dGcKm8fOHcPsJTG6NTLez3z+h5
    PqVUw20FvLLa7MnTMEmO2+PRaKf2AvQ3L+IbZcswWXwKnjLDUN9znb+mgzEJl2pR
    1QHLo8H/JrkcCzemYLJwADe5wkt2sf8kvLFj3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451938; bh=l8RswgGd3XY+XuvnXvx2ZjLzTM
    WgjnHx75w1JAbQ4X0=; b=dp4VfYLM2IGGBVZSGMrfvWKH5zsi1QzSKWWMyAVtk7
    Q0KbCTEDmab+Ch/JXVJz5tH/Ngwn6jtpes0fekMldRm401ULE2oPWPoBXcv3V/O7
    HVJfE6IhV0yKeng9WhfaNuPk8HwYssSM4iemGtX/uZQFSLipgpyCyRDeFyUyRY8B
    4glyyrU+HFGkJ5cVtcQ0SMxbXFvfrGGFeliehXGXUM3W9MCPDfKwgw3a4KA4Dc4L
    oCamlnograJRYHgFw9fxPtMWnKHt8QCEj/jNqUk2Xzqqc/MflPjoLXV5hbQKSNLt
    PUlH0ZY4FYiP5ryBrdOrc5/q5VUv0is7/9+o2JHwZOoQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965345AbeCGTpf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965340AbeCGTpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:45:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Du <dudenis2000@yahoo.ca>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 036/110] hdlc_ppp: carrier detect ok, dont turn off negotiation
Date: Wed,  7 Mar 2018 11:38:19 -0800
Message-Id: <20180307191044.386489036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Du <dudenis2000@yahoo.ca>


[ Upstream commit b6c3bad1ba83af1062a7ff6986d9edc4f3d7fc8e ]

Sometimes when physical lines have a just good noise to make the protocol
handshaking fail, but the carrier detect still good. Then after remove of
the noise, nobody will trigger this protocol to be start again to cause
the link to never come back. The fix is when the carrier is still on, not
terminate the protocol handshaking.

Signed-off-by: Denis Du <dudenis2000@yahoo.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/hdlc_ppp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -574,7 +574,10 @@ static void ppp_timer(unsigned long arg)
 			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
 				     0, NULL);
 			proto->restart_counter--;
-		} else
+		} else if (netif_carrier_ok(proto->dev))
+			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
+				     0, NULL);
+		else
 			ppp_cp_event(proto->dev, proto->pid, TO_BAD, 0, 0,
 				     0, NULL);
 		break;
