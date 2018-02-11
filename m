Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324156-2-13856731505584452709
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
    t=1518324155; b=Pm+eGoxiGmdbzJxpS010hEv6uz59c+pRz7C9skxF8RFmvNy
    l0laE+XevNg9toxYzyyyN3mmDwjwX+VdgCoQ8sPSxdfJoq9K3ioHZA30o+lyKCi+
    RFBkmbFqwQe4l58R0U7tsvxWPrMVFpZUKy+zD/WWAEpijzIsceUQ/SlfzBqzr+Ks
    0zqYE+KcuwyoamSp2TPbuOcU+O5bemJUVG17TWshF4pfOKOXkWIeijMwb6gYM9lQ
    uaPbyuXZAOz4yILKsTJaQQDXs0XqGd2kbuFw1eGeGhcAEpts4WfGWBHhWBTYbr79
    HFeDNJA4oxyHkKRfFholtz7ltXb9vfweQIDpCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324155; bh=2fkNSAh+GmveCv8xM7R
    CBYuysxt+jXRQZT38ArCPjuI=; b=b9sdJQrDVz6sQs/xk/I51Wy+s+5xrWFyQQr
    0XpPw9lnQoWRp9RxnnNzDFgQbWB3a/259ALzUmWAh55eOte3LCq2f6LRaxhpV9m5
    OStbQMQ+Kaa2ebAUARb84StGm/MQBS2O8j8Qj5VsRMIIyHxtqd/zYhrqWfSJSqIV
    +wLMMk3jUIUupB40cwBgKCNgRPurE91W7Q+x8OZz2PHr3+Cmz7pBtlqD7qhA+yji
    qyUQ7WHtB2QgB01G8sC5iAd3vS9Qz5dF7xtU2U1UYAjoHnewhx276YEx66jBpBTW
    9+2PMbXTw2CIvbWJhPvfkX8bKf4UH8KK8cQyKLPRnHROyNVmwPA==
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
        id S1752938AbeBKEk4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41658 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752920AbeBKEeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:05 -0500
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
Message-ID: <lsq.1518323471.144179839@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 033/136] l2tp: don't register sessions in
 l2tp_session_create()
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

commit 3953ae7b218df4d1e544b98a393666f9ae58a78c upstream.

Sessions created by l2tp_session_create() aren't fully initialised:
some pseudo-wire specific operations need to be done before making the
session usable. Therefore the PPP and Ethernet pseudo-wires continue
working on the returned l2tp session while it's already been exposed to
the rest of the system.
This can lead to various issues. In particular, the session may enter
the deletion process before having been fully initialised, which will
confuse the session removal code.

This patch moves session registration out of l2tp_session_create(), so
that callers can control when the session is exposed to the rest of the
system. This is done by the new l2tp_session_register() function.

Only pppol2tp_session_create() can be easily converted to avoid
modifying its session after registration (the debug message is dropped
in order to avoid the need for holding a reference on the session).

For pppol2tp_connect() and l2tp_eth_create()), more work is needed.
That'll be done in followup patches. For now, let's just register the
session right after its creation, like it was done before. The only
difference is that we can easily take a reference on the session before
registering it, so, at least, we're sure it's not going to be freed
while we're working on it.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 21 +++++++--------------
 net/l2tp/l2tp_core.h |  3 +++
 net/l2tp/l2tp_eth.c  |  9 +++++++++
 net/l2tp/l2tp_ppp.c  | 23 +++++++++++++++++------
 4 files changed, 36 insertions(+), 20 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -370,8 +370,8 @@ struct l2tp_session *l2tp_session_get_by
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get_by_ifname);
 
-static int l2tp_session_add_to_tunnel(struct l2tp_tunnel *tunnel,
-				      struct l2tp_session *session)
+int l2tp_session_register(struct l2tp_session *session,
+			  struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session_walk;
 	struct hlist_head *g_head;
@@ -419,6 +419,10 @@ static int l2tp_session_add_to_tunnel(st
 	hlist_add_head(&session->hlist, head);
 	write_unlock_bh(&tunnel->hlist_lock);
 
+	/* Ignore management session in session count value */
+	if (session->session_id != 0)
+		atomic_inc(&l2tp_session_count);
+
 	return 0;
 
 err_tlock_pnlock:
@@ -428,6 +432,7 @@ err_tlock:
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(l2tp_session_register);
 
 /* Lookup a tunnel by id
  */
@@ -1868,7 +1873,6 @@ EXPORT_SYMBOL_GPL(l2tp_session_set_heade
 struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunnel, u32 session_id, u32 peer_session_id, struct l2tp_session_cfg *cfg)
 {
 	struct l2tp_session *session;
-	int err;
 
 	session = kzalloc(sizeof(struct l2tp_session) + priv_size, GFP_KERNEL);
 	if (session != NULL) {
@@ -1926,17 +1930,6 @@ struct l2tp_session *l2tp_session_create
 
 		l2tp_session_inc_refcount(session);
 
-		err = l2tp_session_add_to_tunnel(tunnel, session);
-		if (err) {
-			kfree(session);
-
-			return ERR_PTR(err);
-		}
-
-		/* Ignore management session in session count value */
-		if (session->session_id != 0)
-			atomic_inc(&l2tp_session_count);
-
 		return session;
 	}
 
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -274,6 +274,9 @@ struct l2tp_session *l2tp_session_create
 					 struct l2tp_tunnel *tunnel,
 					 u32 session_id, u32 peer_session_id,
 					 struct l2tp_session_cfg *cfg);
+int l2tp_session_register(struct l2tp_session *session,
+			  struct l2tp_tunnel *tunnel);
+
 void __l2tp_session_unhash(struct l2tp_session *session);
 int l2tp_session_delete(struct l2tp_session *session);
 void l2tp_session_free(struct l2tp_session *session);
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -217,6 +217,13 @@ static int l2tp_eth_create(struct net *n
 		goto out;
 	}
 
+	l2tp_session_inc_refcount(session);
+	rc = l2tp_session_register(session, tunnel);
+	if (rc < 0) {
+		kfree(session);
+		goto out;
+	}
+
 	dev = alloc_netdev(sizeof(*priv), name, l2tp_eth_dev_setup);
 	if (!dev) {
 		rc = -ENOMEM;
@@ -250,6 +257,7 @@ static int l2tp_eth_create(struct net *n
 	__module_get(THIS_MODULE);
 	/* Must be done after register_netdev() */
 	strlcpy(session->ifname, dev->name, IFNAMSIZ);
+	l2tp_session_dec_refcount(session);
 
 	dev_hold(dev);
 
@@ -260,6 +268,7 @@ out_del_dev:
 	spriv->dev = NULL;
 out_del_session:
 	l2tp_session_delete(session);
+	l2tp_session_dec_refcount(session);
 out:
 	return rc;
 }
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -737,6 +737,14 @@ static int pppol2tp_connect(struct socke
 			error = PTR_ERR(session);
 			goto end;
 		}
+
+		l2tp_session_inc_refcount(session);
+		error = l2tp_session_register(session, tunnel);
+		if (error < 0) {
+			kfree(session);
+			goto end;
+		}
+		drop_refcnt = true;
 	}
 
 	/* Associate session with its PPPoL2TP socket */
@@ -824,7 +832,7 @@ static int pppol2tp_session_create(struc
 	/* Error if tunnel socket is not prepped */
 	if (!tunnel->sock) {
 		error = -ENOENT;
-		goto out;
+		goto err;
 	}
 
 	/* Default MTU values. */
@@ -839,18 +847,21 @@ static int pppol2tp_session_create(struc
 				      peer_session_id, cfg);
 	if (IS_ERR(session)) {
 		error = PTR_ERR(session);
-		goto out;
+		goto err;
 	}
 
 	ps = l2tp_session_priv(session);
 	ps->tunnel_sock = tunnel->sock;
 
-	l2tp_info(session, PPPOL2TP_MSG_CONTROL, "%s: created\n",
-		  session->name);
-
-	error = 0;
-
-out:
+	error = l2tp_session_register(session, tunnel);
+	if (error < 0)
+		goto err_sess;
+
+	return 0;
+
+err_sess:
+	kfree(session);
+err:
 	return error;
 }
 
