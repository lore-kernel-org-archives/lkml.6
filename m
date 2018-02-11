Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325615-2-6654850714243841541
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
    t=1518325614; b=n7RmVrpEbYABGd+sPemZFXmi7OSbJ9UAELS9k7mh86vrqNx
    vK3IBVZZfHQJaBmsP1mKkIvFq/UQ1aKA4VJIJddqlFk5Oj3NiHq47uoK+bNIDcKu
    6n+uS0ALHfP9g3heDJWapjGEYWF1XZgHaAunaoiGX8eMxp96tgzTyCZr3G6QoPZ6
    Gwr2QBxhx94RuZrnR5PRUrJFNRU4yWN79hNWfnbT0kBCkbQ8PtJFxnqUgauZnVfJ
    gDcGEAF9BFB4Eb9eLLHp9xuFhCu3W5wMG9TRQeVAs35QBLzMKG0UAK7Wy7WkRod0
    Z9F45aFs3gl9P0JdGd4M5dSM7ySasM8YmT2IOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325614; bh=BpqF4iDS2BVyK2y3xoY
    KolrMYxM+6MZhgGGET1xzlYQ=; b=vR0WPO3oPzOPINYQsVlKjc0oweyZDSr9ruQ
    Q5D6XraTOGz16vI2e9jjS2139ATzkSKyROsVLCSnHKGT7SY6VjDaadh+XZ2eZPbL
    c6J6J1buLtP1m3Mu3a3G8f4dBTKJRlkn7W4G8OxfepXlty1w4TPmhFO4LhsiWt/F
    nd9hKcs1zZULrsQUfkAe4HVkz4MVMnfUjFchOJrPqHzE8MzuQlfHCfy2fyeUICKP
    EsZsV8QhfTJ1ToihEgfkU4lsykz49SBaLIeMB4+cRU0KoECiZtZ36WrOedGj3orq
    PrxFyoFRJjGDXPcQ9qdp8ImdprY3vo6vqLkhG/P1BJRdb7+zndw==
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
        id S1753586AbeBKFFl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:05:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41502 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752678AbeBKEdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.472433265@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 21/79] l2tp: initialise PPP sessions before
 registering them
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit f98be6c6359e7e4a61aaefb9964c1db31cb9ec0c upstream.

pppol2tp_connect() initialises L2TP sessions after they've been exposed
to the rest of the system by l2tp_session_register(). This puts
sessions into transient states that are the source of several races, in
particular with session's deletion path.

This patch centralises the initialisation code into
pppol2tp_session_init(), which is called before the registration phase.
The only field that can't be set before session registration is the
pppol2tp socket pointer, which has already been converted to RCU. So
pppol2tp_connect() should now be race-free.

The session's .session_close() callback is now set before registration.
Therefore, it's always called when l2tp_core deletes the session, even
if it was created by pppol2tp_session_create() and hasn't been plugged
to a pppol2tp socket yet. That'd prevent session free because the extra
reference taken by pppol2tp_session_close() wouldn't be dropped by the
socket's ->sk_destruct() callback (pppol2tp_session_destruct()).
We could set .session_close() only while connecting a session to its
pppol2tp socket, or teach pppol2tp_session_close() to avoid grabbing a
reference when the session isn't connected, but that'd require adding
some form of synchronisation to be race free.

Instead of that, we can just let the pppol2tp socket hold a reference
on the session as soon as it starts depending on it (that is, in
pppol2tp_connect()). Then we don't need to utilise
pppol2tp_session_close() to hold a reference at the last moment to
prevent l2tp_core from dropping it.

When releasing the socket, pppol2tp_release() now deletes the session
using the standard l2tp_session_delete() function, instead of merely
removing it from hash tables. l2tp_session_delete() drops the reference
the sessions holds on itself, but also makes sure it doesn't remove a
session twice. So it can safely be called, even if l2tp_core already
tried, or is concurrently trying, to remove the session.
Finally, pppol2tp_session_destruct() drops the reference held by the
socket.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 69 +++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -478,9 +478,6 @@ static void pppol2tp_session_close(struc
 			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
 		sock_put(sk);
 	}
-
-	/* Don't let the session go away before our socket does */
-	l2tp_session_inc_refcount(session);
 	return;
 }
 
@@ -541,7 +538,7 @@ static int pppol2tp_release(struct socke
 	if (session != NULL) {
 		struct pppol2tp_session *ps;
 
-		l2tp_session_queue_purge(session);
+		l2tp_session_delete(session);
 
 		ps = l2tp_session_priv(session);
 		mutex_lock(&ps->sk_lock);
@@ -636,6 +633,35 @@ static void pppol2tp_show(struct seq_fil
 }
 #endif
 
+static void pppol2tp_session_init(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps;
+	struct dst_entry *dst;
+
+	session->recv_skb = pppol2tp_recv;
+	session->session_close = pppol2tp_session_close;
+#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
+	session->show = pppol2tp_show;
+#endif
+
+	ps = l2tp_session_priv(session);
+	mutex_init(&ps->sk_lock);
+	ps->tunnel_sock = session->tunnel->sock;
+	ps->owner = current->pid;
+
+	/* If PMTU discovery was enabled, use the MTU that was discovered */
+	dst = sk_dst_get(session->tunnel->sock);
+	if (dst) {
+		u32 pmtu = dst_mtu(dst);
+
+		if (pmtu) {
+			session->mtu = pmtu - PPPOL2TP_HEADER_OVERHEAD;
+			session->mru = pmtu - PPPOL2TP_HEADER_OVERHEAD;
+		}
+		dst_release(dst);
+	}
+}
+
 /* connect() handler. Attach a PPPoX socket to a tunnel UDP socket
  */
 static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
@@ -648,7 +674,6 @@ static int pppol2tp_connect(struct socke
 	struct l2tp_session *session = NULL;
 	struct l2tp_tunnel *tunnel;
 	struct pppol2tp_session *ps;
-	struct dst_entry *dst;
 	struct l2tp_session_cfg cfg = { 0, };
 	int error = 0;
 	u32 tunnel_id, peer_tunnel_id;
@@ -772,8 +797,8 @@ static int pppol2tp_connect(struct socke
 			goto end;
 		}
 
+		pppol2tp_session_init(session);
 		ps = l2tp_session_priv(session);
-		mutex_init(&ps->sk_lock);
 		l2tp_session_inc_refcount(session);
 
 		mutex_lock(&ps->sk_lock);
@@ -786,26 +811,6 @@ static int pppol2tp_connect(struct socke
 		drop_refcnt = true;
 	}
 
-	ps->owner	     = current->pid;
-	ps->tunnel_sock = tunnel->sock;
-
-	session->recv_skb	= pppol2tp_recv;
-	session->session_close	= pppol2tp_session_close;
-#if defined(CONFIG_L2TP_DEBUGFS) || defined(CONFIG_L2TP_DEBUGFS_MODULE)
-	session->show		= pppol2tp_show;
-#endif
-
-	/* If PMTU discovery was enabled, use the MTU that was discovered */
-	dst = sk_dst_get(tunnel->sock);
-	if (dst != NULL) {
-		u32 pmtu = dst_mtu(dst);
-
-		if (pmtu != 0)
-			session->mtu = session->mru = pmtu -
-				PPPOL2TP_HEADER_OVERHEAD;
-		dst_release(dst);
-	}
-
 	/* Special case: if source & dest session_id == 0x0000, this
 	 * socket is being created to manage the tunnel. Just set up
 	 * the internal context for use by ioctl() and sockopt()
@@ -839,6 +844,12 @@ out_no_ppp:
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
 
+	/* Keep the reference we've grabbed on the session: sk doesn't expect
+	 * the session to disappear. pppol2tp_session_destruct() is responsible
+	 * for dropping it.
+	 */
+	drop_refcnt = false;
+
 	sk->sk_state = PPPOX_CONNECTED;
 	PRINTK(session->debug, PPPOL2TP_MSG_CONTROL, KERN_INFO,
 	       "%s: created\n", session->name);
@@ -862,7 +873,6 @@ static int pppol2tp_session_create(struc
 {
 	int error;
 	struct l2tp_session *session;
-	struct pppol2tp_session *ps;
 
 	/* Error if tunnel socket is not prepped */
 	if (!tunnel->sock) {
@@ -885,9 +895,7 @@ static int pppol2tp_session_create(struc
 		goto err;
 	}
 
-	ps = l2tp_session_priv(session);
-	mutex_init(&ps->sk_lock);
-	ps->tunnel_sock = tunnel->sock;
+	pppol2tp_session_init(session);
 
 	error = l2tp_session_register(session, tunnel);
 	if (error < 0)
