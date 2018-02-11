Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324166-2-406951410227592595
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
    t=1518324165; b=JP0IB969sV6RWBbSrkm3b0IiYxRbA5q+DtV/kfyIO0vhiFY
    RALDzxp3LVybnzE/rILkfVJ9kf+7gVWxGcHl+DPchjt4P0zaQKNP4eWZelF9scY5
    0glriDRW7eWPa3DBp8KP63zAQ0jTVFxC22653wjm03poMjpvf8Nn8Y4lpsVW43X6
    60UDrEM6UtGv5jtebMvfUQGyXeDDBsURBtEGnLeB46IrBzVdR1kTtMEQ87UGt+Sn
    bF9rED9l0qYxE244yBOddNTVqT1pg621+KEbMvcxhQGHoVbMtPWsUCdnk6KbhXev
    k03QNJRvOYPF57qUNKkDry5G25NVAfBh3eIZVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324165; bh=Yi7jgeW5xNMrs2K09t9
    RysNxjpdYw5IKGFJ+IpJQ0gI=; b=or28eIcX6IIsfqfqVgWmZuF+SALjh/oKUhb
    iCYfmsdI22KERYp2blhs+Nva/bPzEQMyWq4V1K+25Yn8U58vj1WfRCiheqbSwytm
    ZcIolLMUNds0Af4CsupM2ZvJIE1fnBtme6MPTxPuqJC/WLXNIguyIhnLGAv+35bo
    c4GSxdmrANyElOaZaDfzYDioKcagybY/8MbQdjw8qZ/3qP6WQC8loYEW9XChxHPJ
    m84PLlq72XrIRqkZXR+2ixR00O/SAspimHdSePKU85S+v7X3swrJsx8WVQLpEy8L
    9qnOfzVr1TM+Vo6f7/KQMLClqsdXkzUq8nPj+VLEV5sG9f91GuQ==
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
        id S1753093AbeBKEkz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41678 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752927AbeBKEeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.785641503@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 035/136] l2tp: protect sock pointer of struct
 pppol2tp_session with RCU
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

commit ee40fb2e1eb5bc0ddd3f2f83c6e39a454ef5a741 upstream.

pppol2tp_session_create() registers sessions that can't have their
corresponding socket initialised. This socket has to be created by
userspace, then connected to the session by pppol2tp_connect().
Therefore, we need to protect the pppol2tp socket pointer of L2TP
sessions, so that it can safely be updated when userspace is connecting
or closing the socket. This will eventually allow pppol2tp_connect()
to avoid generating transient states while initialising its parts of the
session.

To this end, this patch protects the pppol2tp socket pointer using RCU.

The pppol2tp socket pointer is still set in pppol2tp_connect(), but
only once we know the function isn't going to fail. It's eventually
reset by pppol2tp_release(), which now has to wait for a grace period
to elapse before it can drop the last reference on the socket. This
ensures that pppol2tp_session_get_sock() can safely grab a reference
on the socket, even after ps->sk is reset to NULL but before this
operation actually gets visible from pppol2tp_session_get_sock().

The rest is standard RCU conversion: pppol2tp_recv(), which already
runs in atomic context, is simply enclosed by rcu_read_lock() and
rcu_read_unlock(), while other functions are converted to use
pppol2tp_session_get_sock() followed by sock_put().
pppol2tp_session_setsockopt() is a special case. It used to retrieve
the pppol2tp socket from the L2TP session, which itself was retrieved
from the pppol2tp socket. Therefore we can just avoid dereferencing
ps->sk and directly use the original socket pointer instead.

With all users of ps->sk now handling NULL and concurrent updates, the
L2TP ->ref() and ->deref() callbacks aren't needed anymore. Therefore,
rather than converting pppol2tp_session_sock_hold() and
pppol2tp_session_sock_put(), we can just drop them.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 154 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 53 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -122,8 +122,11 @@
 struct pppol2tp_session {
 	int			owner;		/* pid that opened the socket */
 
-	struct sock		*sock;		/* Pointer to the session
+	struct mutex		sk_lock;	/* Protects .sk */
+	struct sock __rcu	*sk;		/* Pointer to the session
 						 * PPPoX socket */
+	struct sock		*__sk;		/* Copy of .sk, for cleanup */
+	struct rcu_head		rcu;		/* For asynchronous release */
 	struct sock		*tunnel_sock;	/* Pointer to the tunnel UDP
 						 * socket */
 	int			flags;		/* accessed by PPPIOCGFLAGS.
@@ -138,6 +141,24 @@ static const struct ppp_channel_ops pppo
 
 static const struct proto_ops pppol2tp_ops;
 
+/* Retrieves the pppol2tp socket associated to a session.
+ * A reference is held on the returned socket, so this function must be paired
+ * with sock_put().
+ */
+static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps = l2tp_session_priv(session);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = rcu_dereference(ps->sk);
+	if (sk)
+		sock_hold(sk);
+	rcu_read_unlock();
+
+	return sk;
+}
+
 /* Helpers to obtain tunnel/session contexts from sockets.
  */
 static inline struct l2tp_session *pppol2tp_sock_to_session(struct sock *sk)
@@ -225,7 +246,8 @@ static void pppol2tp_recv(struct l2tp_se
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
-	sk = ps->sock;
+	rcu_read_lock();
+	sk = rcu_dereference(ps->sk);
 	if (sk == NULL)
 		goto no_sock;
 
@@ -263,30 +285,16 @@ static void pppol2tp_recv(struct l2tp_se
 			kfree_skb(skb);
 		}
 	}
+	rcu_read_unlock();
 
 	return;
 
 no_sock:
+	rcu_read_unlock();
 	l2tp_info(session, PPPOL2TP_MSG_DATA, "%s: no socket\n", session->name);
 	kfree_skb(skb);
 }
 
-static void pppol2tp_session_sock_hold(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-
-	if (ps->sock)
-		sock_hold(ps->sock);
-}
-
-static void pppol2tp_session_sock_put(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-
-	if (ps->sock)
-		sock_put(ps->sock);
-}
-
 /************************************************************************
  * Transmit handling
  ***********************************************************************/
@@ -450,14 +458,16 @@ abort:
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk = ps->sock;
-	struct socket *sock = sk->sk_socket;
+	struct sock *sk;
 
 	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
 
-	if (sock)
-		inet_shutdown(sock, 2);
+	sk = pppol2tp_session_get_sock(session);
+	if (sk) {
+		if (sk->sk_socket)
+			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
+		sock_put(sk);
+	}
 
 	/* Don't let the session go away before our socket does */
 	l2tp_session_inc_refcount(session);
@@ -480,6 +490,14 @@ static void pppol2tp_session_destruct(st
 	}
 }
 
+static void pppol2tp_put_sk(struct rcu_head *head)
+{
+	struct pppol2tp_session *ps;
+
+	ps = container_of(head, typeof(*ps), rcu);
+	sock_put(ps->__sk);
+}
+
 /* Called when the PPPoX socket (session) is closed.
  */
 static int pppol2tp_release(struct socket *sock)
@@ -505,11 +523,24 @@ static int pppol2tp_release(struct socke
 
 	session = pppol2tp_sock_to_session(sk);
 
-	/* Purge any queued data */
 	if (session != NULL) {
+		struct pppol2tp_session *ps;
+
 		__l2tp_session_unhash(session);
 		l2tp_session_queue_purge(session);
-		sock_put(sk);
+
+		ps = l2tp_session_priv(session);
+		mutex_lock(&ps->sk_lock);
+		ps->__sk = rcu_dereference_protected(ps->sk,
+						     lockdep_is_held(&ps->sk_lock));
+		RCU_INIT_POINTER(ps->sk, NULL);
+		mutex_unlock(&ps->sk_lock);
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+
+		/* Rely on the sock_put() call at the end of the function for
+		 * dropping the reference held by pppol2tp_sock_to_session().
+		 * The last reference will be dropped by pppol2tp_put_sk().
+		 */
 	}
 	release_sock(sk);
 
@@ -576,12 +607,14 @@ out:
 static void pppol2tp_show(struct seq_file *m, void *arg)
 {
 	struct l2tp_session *session = arg;
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
+	struct sock *sk;
+
+	sk = pppol2tp_session_get_sock(session);
+	if (sk) {
+		struct pppox_sock *po = pppox_sk(sk);
 
-	if (ps) {
-		struct pppox_sock *po = pppox_sk(ps->sock);
-		if (po)
-			seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
 	}
 }
 #endif
@@ -715,13 +748,17 @@ static int pppol2tp_connect(struct socke
 		/* Using a pre-existing session is fine as long as it hasn't
 		 * been connected yet.
 		 */
-		if (ps->sock) {
+		mutex_lock(&ps->sk_lock);
+		if (rcu_dereference_protected(ps->sk,
+					      lockdep_is_held(&ps->sk_lock))) {
+			mutex_unlock(&ps->sk_lock);
 			error = -EEXIST;
 			goto end;
 		}
 
 		/* consistency checks */
 		if (ps->tunnel_sock != tunnel->sock) {
+			mutex_unlock(&ps->sk_lock);
 			error = -EEXIST;
 			goto end;
 		}
@@ -738,19 +775,21 @@ static int pppol2tp_connect(struct socke
 			goto end;
 		}
 
+		ps = l2tp_session_priv(session);
+		mutex_init(&ps->sk_lock);
 		l2tp_session_inc_refcount(session);
+
+		mutex_lock(&ps->sk_lock);
 		error = l2tp_session_register(session, tunnel);
 		if (error < 0) {
+			mutex_unlock(&ps->sk_lock);
 			kfree(session);
 			goto end;
 		}
 		drop_refcnt = true;
 	}
 
-	/* Associate session with its PPPoL2TP socket */
-	ps = l2tp_session_priv(session);
 	ps->owner	     = current->pid;
-	ps->sock	     = sk;
 	ps->tunnel_sock = tunnel->sock;
 
 	session->recv_skb	= pppol2tp_recv;
@@ -759,12 +798,6 @@ static int pppol2tp_connect(struct socke
 	session->show		= pppol2tp_show;
 #endif
 
-	/* We need to know each time a skb is dropped from the reorder
-	 * queue.
-	 */
-	session->ref = pppol2tp_session_sock_hold;
-	session->deref = pppol2tp_session_sock_put;
-
 	/* If PMTU discovery was enabled, use the MTU that was discovered */
 	dst = sk_dst_get(tunnel->sock);
 	if (dst != NULL) {
@@ -798,12 +831,17 @@ static int pppol2tp_connect(struct socke
 	po->chan.mtu	 = session->mtu;
 
 	error = ppp_register_net_channel(sock_net(sk), &po->chan);
-	if (error)
+	if (error) {
+		mutex_unlock(&ps->sk_lock);
 		goto end;
+	}
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
 	sk->sk_user_data = session;
+	rcu_assign_pointer(ps->sk, sk);
+	mutex_unlock(&ps->sk_lock);
+
 	sk->sk_state = PPPOX_CONNECTED;
 	l2tp_info(session, PPPOL2TP_MSG_CONTROL, "%s: created\n",
 		  session->name);
@@ -851,6 +889,7 @@ static int pppol2tp_session_create(struc
 	}
 
 	ps = l2tp_session_priv(session);
+	mutex_init(&ps->sk_lock);
 	ps->tunnel_sock = tunnel->sock;
 
 	error = l2tp_session_register(session, tunnel);
@@ -1022,12 +1061,10 @@ static int pppol2tp_session_ioctl(struct
 		 "%s: pppol2tp_session_ioctl(cmd=%#x, arg=%#lx)\n",
 		 session->name, cmd, arg);
 
-	sk = ps->sock;
+	sk = pppol2tp_session_get_sock(session);
 	if (!sk)
 		return -EBADR;
 
-	sock_hold(sk);
-
 	switch (cmd) {
 	case SIOCGIFMTU:
 		err = -ENXIO;
@@ -1303,7 +1340,6 @@ static int pppol2tp_session_setsockopt(s
 				       int optname, int val)
 {
 	int err = 0;
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
 
 	switch (optname) {
 	case PPPOL2TP_SO_RECVSEQ:
@@ -1324,8 +1360,8 @@ static int pppol2tp_session_setsockopt(s
 		}
 		session->send_seq = val ? -1 : 0;
 		{
-			struct sock *ssk      = ps->sock;
-			struct pppox_sock *po = pppox_sk(ssk);
+			struct pppox_sock *po = pppox_sk(sk);
+
 			po->chan.hdrlen = val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
 				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
 		}
@@ -1664,8 +1700,9 @@ static void pppol2tp_seq_session_show(st
 {
 	struct l2tp_session *session = v;
 	struct l2tp_tunnel *tunnel = session->tunnel;
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct pppox_sock *po = pppox_sk(ps->sock);
+	unsigned char state;
+	char user_data_ok;
+	struct sock *sk;
 	u32 ip = 0;
 	u16 port = 0;
 
@@ -1675,6 +1712,15 @@ static void pppol2tp_seq_session_show(st
 		port = ntohs(inet->inet_sport);
 	}
 
+	sk = pppol2tp_session_get_sock(session);
+	if (sk) {
+		state = sk->sk_state;
+		user_data_ok = (session == sk->sk_user_data) ? 'Y' : 'N';
+	} else {
+		state = 0;
+		user_data_ok = 'N';
+	}
+
 	seq_printf(m, "  SESSION '%s' %08X/%d %04X/%04X -> "
 		   "%04X/%04X %d %c\n",
 		   session->name, ip, port,
@@ -1682,9 +1728,7 @@ static void pppol2tp_seq_session_show(st
 		   session->session_id,
 		   tunnel->peer_tunnel_id,
 		   session->peer_session_id,
-		   ps->sock->sk_state,
-		   (session == ps->sock->sk_user_data) ?
-		   'Y' : 'N');
+		   state, user_data_ok);
 	seq_printf(m, "   %d/%d/%c/%c/%s %08x %u\n",
 		   session->mtu, session->mru,
 		   session->recv_seq ? 'R' : '-',
@@ -1701,8 +1745,12 @@ static void pppol2tp_seq_session_show(st
 		   atomic_long_read(&session->stats.rx_bytes),
 		   atomic_long_read(&session->stats.rx_errors));
 
-	if (po)
+	if (sk) {
+		struct pppox_sock *po = pppox_sk(sk);
+
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
+	}
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
