Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323694-2-9750910150772361404
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
    t=1518323694; b=aDlmqzo9UmrQA5wAk+RE8Yo1j32gcS56ssf/j3LGmicFhk/
    SCmzcwBJ5/DJg7zJpFe8lMKpw5wFBkbYcup1D174baEqkGDhHwUG9cUwuzZIRdQ3
    +nmueh1NXX2mjGomDiOj0SzeA1RE61Bp07doJP9Y8EgItO1VkL+356dS9xDDJR1P
    /Gj0XsJzvmXyQRksqvKA+M06mXwnwv+Z2J9/elrnIKU8X1zSNtqzIed5HEjPOqye
    y3qOGJLikoHTEPLyzR+mWp987flmVAA8c1p8jZretm7a61mWtdgKfsPBJYfa0kfJ
    0Psr4pxTPVRIR4MiMYowhhFvDS0aWOdvfndZ/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323694; bh=0cqEIWE5e92yl511yjk
    iho/2yctmaOfKfzmLackuJHU=; b=qVfnRpCcGYyNur+dyAAv6c8a0ObZsbesKGB
    AZsccna1tmZkG6QcS0wKe94horwd/1IH08nLFL5RcXIqVDo+63EZoAtEC9JZ3mWB
    DPt4hmxWg6wTtkMPSKGNW6mSC2UaHDSrSJIkJTJ6WMVlvcvN3PvmT39SQEkGXT9c
    c9T4z+QLcjH5qlmuj9qfFY+PdxmjQL1k/U0+T+l9285+rECgY52Cck9DfyAlTEDg
    Q//cBri2Be9VHS04p0rjkpWPepQLkZ8sthFHY9roAIWzpiX611SdCTtkxNKGRA4j
    4YvctaBQIy26RBASx1tgTxzY+OgwHTkcm+4G+i051PQpZ8Tulug==
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
        id S1753047AbeBKEeU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:34:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41671 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752929AbeBKEeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.896981370@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 032/136] l2tp: ensure sessions are freed after their
 PPPOL2TP socket
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit cdd10c9627496ad25c87ce6394e29752253c69d3 upstream.

If l2tp_tunnel_delete() or l2tp_tunnel_closeall() deletes a session
right after pppol2tp_release() orphaned its socket, then the 'sock'
variable of the pppol2tp_session_close() callback is NULL. Yet the
session is still used by pppol2tp_release().

Therefore we need to take an extra reference in any case, to prevent
l2tp_tunnel_delete() or l2tp_tunnel_closeall() from freeing the session.

Since the pppol2tp_session_close() callback is only set if the session
is associated to a PPPOL2TP socket and that both l2tp_tunnel_delete()
and l2tp_tunnel_closeall() hold the PPPOL2TP socket before calling
pppol2tp_session_close(), we're sure that pppol2tp_session_close() and
pppol2tp_session_destruct() are paired and called in the right order.
So the reference taken by the former will be released by the later.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -456,11 +456,11 @@ static void pppol2tp_session_close(struc
 
 	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
 
-	if (sock) {
+	if (sock)
 		inet_shutdown(sock, 2);
-		/* Don't let the session go away before our socket does */
-		l2tp_session_inc_refcount(session);
-	}
+
+	/* Don't let the session go away before our socket does */
+	l2tp_session_inc_refcount(session);
 }
 
 /* Really kill the session socket. (Called from sock_put() if
