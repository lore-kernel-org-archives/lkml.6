Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641208-2-12413228521417004026
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
    t=1520641208; b=jeLqa9pxSXeJK5RTFNUs+e6KQ1/m1HGpgZZA7uhOsoPx2Ij
    U5K8xFmopNGV8rumLy6RA+ZatN5I7fmr3X0hBRGxHSiOABRm48Iu63yMytPQJk41
    6pFUywRClaiIwHWX60jEZgSjoWvaDNKOzjpTm8y/Gk8681VyLyoQ3LSf5QaL0CHR
    1w1vOxz2bbtyJQmi0tcmLyCPzpsdU3vLaBZdenZZnIvFQXooQSvNFYuf9Rl2qWT1
    TPmW5nB2ak0bJqRsdXaecPG0ehmuiE1xElkPHSQ3nSNi+8Hm+BcHBQSq83/507bn
    q/1lpJHXAO5QPHOZ5U90uhpCeT0zoqB87tsvoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641208; bh=XrWhxIZiP4uwxPpIhwsE2Xy4P6
    bgir0LU83zboo3GqY=; b=nN+Zg3r4JVitICZ/90jFRiq1aDbVzQEd/AxD95VPWN
    GZj0NPvQbytr26dAF3SSq3uWi9ooftJ0xDEs7S214ahFyiHNc03ky3sQ6VYz5SX/
    BPyPVFeqYsfHz/4yLBJ3dVdMSJNM13O15oUR24xb3U83aMFQod1encjFtSf6wNEG
    55AJF7XCudENfbg15UNejXMmMrN/eQaHIntaHjGJQxdcOR8d6uUg+Z0gOVBPZX/C
    s9lqXO+IJxpUG1XhGtZLtBnRftIzJjiiam51ZDbYP1kxEoIwXKfD9FdZq/mCZyu+
    JiFNSbbfo1l011wHVzhZUKT1a3/X3L7SYS7BZhC4/2Zw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S933265AbeCJAUF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:20:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933237AbeCJAUE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:20:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Du <dudenis2000@yahoo.ca>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 20/36] hdlc_ppp: carrier detect ok, dont turn off negotiation
Date: Fri,  9 Mar 2018 16:18:36 -0800
Message-Id: <20180310001808.462928150@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
