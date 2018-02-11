Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326598-2-10096827235730608541
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
    t=1518326598; b=cIC+IMsX4I1bwkYtnR+NZbwbAMthZ2alpvT8fI4eJwvrRXi
    mNJ2PUMhNEwc2ed/UU2ey3+MXl1x9WkZKgY+N+CZFcgxuLtn9FnBSuMDnprnRoma
    Vev5109cX/t/jayGAWMja5vQzPsmO7Imc3GD+d0LZ5Kb7r+BYfhdrLbzy4soLxAL
    Su6tTLkv92fHXkkVtzIE0uR4fSy6C/4C9nfLyFhYKAeR35UXd3ybnlcJFUMY7y9v
    7txHQPLMf4dnpCc3yIUToZJSxjW9bBh5ivtIXVrTL4Om2Oe7e4U5qeG3JWL7hheG
    ikghSFZvXFBa2Og2NLPnRjTg+IhQpr6GYCNE0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326598; bh=AP0gGeBMyCupWjjxk16
    DTVvOq25YXd9hDLw+SjvDS5g=; b=MutHld29dU27jh9L9QIokygoWpPHUf80paR
    JH0BVdeFcEJOE0ujCUkyW2cSmOAZK5b+0sHuA8JukrMrgg/qYZdkGJ2cTGJJkKkA
    P1nbpOYsZ2zsFwmRlXxpuSaFDBRebCwT9cS5adkEggqK8CtHC3dIIK9aYLSRUClK
    5i78Fo8RpImoLBaN8kakzYKsSdrGCKJyjyT3X1Qg+521ZEH0GdJklTQjomA1Zqaf
    dCOdbemV2Jh/bywmsz6D5ywprlxeTEiUhmP9NOMqdxPYgYbKzhTiYeLfp8Lzno3n
    QfMQZQbXwlrIr/uQL6QUpD9cblrZ7zAdw22/xKd4BCcTMFPfi1Q==
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
        id S1753976AbeBKFRg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:17:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41356 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752562AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tom Parkin" <tparkin@katalix.com>,
        "James Chapman" <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.699914069@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 14/79] l2tp: add session reorder queue purge function
 to core
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Parkin <tparkin@katalix.com>

commit 48f72f92b31431c40279b0fba6c5588e07e67d95 upstream.

If an l2tp session is deleted, it is necessary to delete skbs in-flight
on the session's reorder queue before taking it down.

Rather than having each pseudowire implementation reaching into the
l2tp_session struct to handle this itself, provide a function in l2tp_core to
purge the session queue.

Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: use non-atomic increment on rx_errors]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 17 +++++++++++++++++
 net/l2tp/l2tp_core.h |  1 +
 2 files changed, 18 insertions(+)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -830,6 +830,23 @@ discard:
 }
 EXPORT_SYMBOL(l2tp_recv_common);
 
+/* Drop skbs from the session's reorder_q
+ */
+int l2tp_session_queue_purge(struct l2tp_session *session)
+{
+	struct sk_buff *skb = NULL;
+	BUG_ON(!session);
+	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
+	while ((skb = skb_dequeue(&session->reorder_q))) {
+		session->stats.rx_errors++;
+		kfree_skb(skb);
+		if (session->deref)
+			(*session->deref)(session);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(l2tp_session_queue_purge);
+
 /* Internal UDP receive frame. Do the real work of receiving an L2TP data frame
  * here. The skb is not on a list when we get here.
  * Returns 0 if the packet was a data packet and was successfully passed on.
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -249,6 +249,7 @@ extern struct l2tp_session *l2tp_session
 extern int l2tp_session_delete(struct l2tp_session *session);
 extern void l2tp_session_free(struct l2tp_session *session);
 extern void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb, unsigned char *ptr, unsigned char *optr, u16 hdrflags, int length, int (*payload_hook)(struct sk_buff *skb));
+extern int l2tp_session_queue_purge(struct l2tp_session *session);
 extern int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb);
 
 extern int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb, int hdr_len);
