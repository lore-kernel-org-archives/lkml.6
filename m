Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325510-2-9643202551722428035
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325509; b=Z1mtR6Q0PL/s/QBZWgSji3HL3h9JtPfbI+D6C99dPbicK0R
    cNDeaKhLHpV00bVt+nGGboVuU1kBQO1SWKDhXBD8EfaWxDoXi7xuz/SDY/sdy2Ul
    8epqSUZ6j8S6DW6P898Faa/Iw0LNuPWquHC3HNT+JVGgc1sYMx9XkBYd51o0Q7vg
    8l97ukwtBLDqTBlAlDvAX3ZTr7okRmvpI8dBNs+W6Iy34RUWdss7UN57ENhuqU1B
    YmE4Bo4AJO6OWt9iK0KqPOF6AIIIy9hUJyQ+R9tUQ2kNLayd6X8QLLAuI5Lnd5e8
    DwaPTvvK8XL959efJNzwhAeJqnWc2qR6tDI0IJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325509; bh=YiFVuAFdwVCVE2IOTJy
    mcoaLX5m1oeo77dwPxro7zWA=; b=pqz8IVOUMPxUyvG9DlKhOhIDqMgyAiOZuTR
    p+su9UmSDp3U14QaW1kBvTs7L+U+3gFxqqjO6YYkRYC2rHShcEpXEcpDtJ01ZrEl
    J5JapKy7NMTTzDQpzyVxiPn6TlrEyml0a0V5+nFpRpSkdGpRVf2kveJimiRpbt0Q
    H0GjtWzpDfjCaP7nGUVxSWS//+N/Y3e/wFYJc1HNuYIIYJbagmstN7YX2lH4sO94
    JrWkEWLGIobDLtSl2aZnYhjVCpOPakLlkWXsDiNMiq5HNFfcSVPSjVmEnfHwboLH
    PlkG59otqMjtVMwFHnrfvGZjQt+sJAgVum0ihDOrE25FAeJ0dCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbeBKFEk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:04:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41505 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752684AbeBKEdn (ORCPT
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
Message-ID: <lsq.1518322806.555451143@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 19/79] l2tp: initialise l2tp_eth sessions before
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

commit ee28de6bbd78c2e18111a0aef43ea746f28d2073 upstream.

Sessions must be initialised before being made externally visible by
l2tp_session_register(). Otherwise the session may be concurrently
deleted before being initialised, which can confuse the deletion path
and eventually lead to kernel oops.

Therefore, we need to move l2tp_session_register() down in
l2tp_eth_create(), but also handle the intermediate step where only the
session or the netdevice has been registered.

We can't just call l2tp_session_register() in ->ndo_init() because
we'd have no way to properly undo this operation in ->ndo_uninit().
Instead, let's register the session and the netdevice in two different
steps and protect the session's device pointer with RCU.

And now that we allow the session's .dev field to be NULL, we don't
need to prevent the netdevice from being removed anymore. So we can
drop the dev_hold() and dev_put() calls in l2tp_eth_create() and
l2tp_eth_dev_uninit().

Fixes: d9e31d17ceba ("l2tp: Add L2TP ethernet pseudowire support")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2:
 - Update another 'goto out' in l2tp_eth_create()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -43,7 +43,7 @@ struct l2tp_eth {
 
 /* via l2tp_session_priv() */
 struct l2tp_eth_sess {
-	struct net_device	*dev;
+	struct net_device __rcu *dev;
 };
 
 
@@ -60,7 +60,14 @@ static int l2tp_eth_dev_init(struct net_
 
 static void l2tp_eth_dev_uninit(struct net_device *dev)
 {
-	dev_put(dev);
+	struct l2tp_eth *priv = netdev_priv(dev);
+	struct l2tp_eth_sess *spriv;
+
+	spriv = l2tp_session_priv(priv->session);
+	RCU_INIT_POINTER(spriv->dev, NULL);
+	/* No need for synchronize_net() here. We're called by
+	 * unregister_netdev*(), which does the synchronisation for us.
+	 */
 }
 
 static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -93,7 +100,7 @@ static void l2tp_eth_dev_setup(struct ne
 static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
 	struct l2tp_eth_sess *spriv = l2tp_session_priv(session);
-	struct net_device *dev = spriv->dev;
+	struct net_device *dev;
 
 	if (session->debug & L2TP_MSG_DATA) {
 		unsigned int length;
@@ -125,14 +132,22 @@ static void l2tp_eth_dev_recv(struct l2t
 	skb_dst_drop(skb);
 	nf_reset(skb);
 
+	rcu_read_lock();
+	dev = rcu_dereference(spriv->dev);
+	if (!dev)
+		goto error_rcu;
+
 	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS) {
 		dev->stats.rx_packets++;
 		dev->stats.rx_bytes += data_len;
 	} else
 		dev->stats.rx_errors++;
+	rcu_read_unlock();
 
 	return;
 
+error_rcu:
+	rcu_read_unlock();
 error:
 	dev->stats.rx_errors++;
 	kfree_skb(skb);
@@ -145,11 +160,15 @@ static void l2tp_eth_delete(struct l2tp_
 
 	if (session) {
 		spriv = l2tp_session_priv(session);
-		dev = spriv->dev;
+
+		rtnl_lock();
+		dev = rtnl_dereference(spriv->dev);
 		if (dev) {
-			unregister_netdev(dev);
-			spriv->dev = NULL;
+			unregister_netdevice(dev);
+			rtnl_unlock();
 			module_put(THIS_MODULE);
+		} else {
+			rtnl_unlock();
 		}
 	}
 }
@@ -159,9 +178,20 @@ static void l2tp_eth_show(struct seq_fil
 {
 	struct l2tp_session *session = arg;
 	struct l2tp_eth_sess *spriv = l2tp_session_priv(session);
-	struct net_device *dev = spriv->dev;
+	struct net_device *dev;
+
+	rcu_read_lock();
+	dev = rcu_dereference(spriv->dev);
+	if (!dev) {
+		rcu_read_unlock();
+		return;
+	}
+	dev_hold(dev);
+	rcu_read_unlock();
 
 	seq_printf(m, "   interface %s\n", dev->name);
+
+	dev_put(dev);
 }
 #endif
 
@@ -181,7 +211,7 @@ static int l2tp_eth_create(struct net *n
 		if (dev) {
 			dev_put(dev);
 			rc = -EEXIST;
-			goto out;
+			goto err;
 		}
 		strlcpy(name, cfg->ifname, IFNAMSIZ);
 	} else
@@ -191,20 +221,13 @@ static int l2tp_eth_create(struct net *n
 				      peer_session_id, cfg);
 	if (IS_ERR(session)) {
 		rc = PTR_ERR(session);
-		goto out;
-	}
-
-	l2tp_session_inc_refcount(session);
-	rc = l2tp_session_register(session, tunnel);
-	if (rc < 0) {
-		kfree(session);
-		goto out;
+		goto err;
 	}
 
 	dev = alloc_netdev(sizeof(*priv), name, l2tp_eth_dev_setup);
 	if (!dev) {
 		rc = -ENOMEM;
-		goto out_del_session;
+		goto err_sess;
 	}
 
 	dev_net_set(dev, net);
@@ -225,28 +248,48 @@ static int l2tp_eth_create(struct net *n
 #endif
 
 	spriv = l2tp_session_priv(session);
-	spriv->dev = dev;
 
-	rc = register_netdev(dev);
-	if (rc < 0)
-		goto out_del_dev;
+	l2tp_session_inc_refcount(session);
+
+	rtnl_lock();
+
+	/* Register both device and session while holding the rtnl lock. This
+	 * ensures that l2tp_eth_delete() will see that there's a device to
+	 * unregister, even if it happened to run before we assign spriv->dev.
+	 */
+	rc = l2tp_session_register(session, tunnel);
+	if (rc < 0) {
+		rtnl_unlock();
+		goto err_sess_dev;
+	}
+
+	rc = register_netdevice(dev);
+	if (rc < 0) {
+		rtnl_unlock();
+		l2tp_session_delete(session);
+		l2tp_session_dec_refcount(session);
+		free_netdev(dev);
+
+		return rc;
+	}
 
-	__module_get(THIS_MODULE);
-	/* Must be done after register_netdev() */
 	strlcpy(session->ifname, dev->name, IFNAMSIZ);
+	rcu_assign_pointer(spriv->dev, dev);
+
+	rtnl_unlock();
+
 	l2tp_session_dec_refcount(session);
 
-	dev_hold(dev);
+	__module_get(THIS_MODULE);
 
 	return 0;
 
-out_del_dev:
-	free_netdev(dev);
-	spriv->dev = NULL;
-out_del_session:
-	l2tp_session_delete(session);
+err_sess_dev:
 	l2tp_session_dec_refcount(session);
-out:
+	free_netdev(dev);
+err_sess:
+	kfree(session);
+err:
 	return rc;
 }
 
