Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839087-2-12269556402947202087
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
    t=1519839086; b=OEPZo9jLsb/ScllAkcD6qbcxnzAG8HFufn97Yyrf2dBgyo7
    N8UXsG+wEVLDXqghIlPXnA1vceiw7ZIVs7CqVbJZ/ufFpm8XqoOdAYp2Edl2V4M/
    YVW9BsPebKLmtnXmhyy/dRgbLLP+GMqhW4plg5bJmcu83OAVTtZOuYtOuWLUeNf5
    4QDf53dQGt02QmFqrjlVfofn38JIvjVnmLP0yYiY2Kj4a3LN0JK2i7y0J1ho1Ef3
    ebxiV3w6BDXYuGNXxgxiMfu1pEghurwJYJ7mBRiZM362y5qFMKYhDs9qS3YVkh4F
    iipUcShvmUQo6jTJAjROr2sX7G811gNEb8ROi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839086; bh=4puIHcE39YS212ESGh4
    dYD/As2lDFUzvO3qlNqHPOtI=; b=uK3N9nt/ubMWzEYfLNofjiy2Ut2pbS1/XEY
    t9rQg1nl4yTXF2EGFJCP2CtEmLmY5sM8dIETwBhtZI+jMPCznQMHqVhx+3S7wRAo
    8kPe3D+yVfdpHO+q/KBQ3rUoz6lEco6bqKbSeeyY7vJ/bWSMibs3TieB57NsnXk4
    HgogxyTqNO6vPsIHScIjezVzq5nKGFcYQrdBbeDh9hFlkx+cUvFJqqJ3Mz/dW2Lh
    cpB66iRnO18R/J/uy6besmkzMNhDvxas4merSYzZjM0zdgRM4GaGtX/eXX8XHw9q
    SAS1DC9aQAQjDnagRofTBTHBx0A8RLZkzrMpYWOW0bc7MFxnUEQ==
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
        id S932342AbeB1RbZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:31:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33229 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932580AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        "Xin Long" <lucien.xin@gmail.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.541085420@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 100/140] sctp: use the right sk after waking up from
 wait_buf sleep
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

From: Xin Long <lucien.xin@gmail.com>

commit cea0cc80a6777beb6eb643d4ad53690e1ad1d4ff upstream.

Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
sleeping on it") fixed the race between peeloff and wait sndbuf by
checking waitqueue_active(&asoc->wait) in sctp_do_peeloff().

But it actually doesn't work, as even if waitqueue_active returns false
the waiting sndbuf thread may still not yet hold sk lock. After asoc is
peeled off, sk is not asoc->base.sk any more, then to hold the old sk
lock couldn't make assoc safe to access.

This patch is to fix this by changing to hold the new sk lock if sk is
not asoc->base.sk, meanwhile, also set the sk in sctp_sendmsg with the
new sk.

With this fix, there is no more race between peeloff and waitbuf, the
check 'waitqueue_active' in sctp_do_peeloff can be removed.

Thanks Marcelo and Neil for making this clear.

v1->v2:
  fix it by changing to lock the new sock instead of adding a flag in asoc.

Suggested-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/socket.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -93,8 +93,8 @@
 /* Forward declarations for internal helper functions. */
 static int sctp_writeable(struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
+				size_t msg_len, struct sock **orig_sk);
 static int sctp_wait_for_packet(struct sock * sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1911,7 +1911,8 @@ SCTP_STATIC int sctp_sendmsg(struct kioc
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	if (!sctp_wspace(asoc)) {
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		/* sk can be changed by peel off when waiting for buf. */
+		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len, &sk);
 		if (err)
 			goto out_free;
 	}
@@ -4247,12 +4248,6 @@ SCTP_STATIC int sctp_do_peeloff(struct s
 	if (!net_eq(current->nsproxy->net_ns, sock_net(sk)))
 		return -EINVAL;
 
-	/* If there is a thread waiting on more sndbuf space for
-	 * sending on this asoc, it cannot be peeled.
-	 */
-	if (waitqueue_active(&asoc->wait))
-		return -EBUSY;
-
 	/* An association cannot be branched off from an already peeled-off
 	 * socket, nor is this supported for tcp style sockets.
 	 */
@@ -6470,7 +6465,7 @@ void sctp_sock_rfree(struct sk_buff *skb
 
 /* Helper function to wait for space in the sndbuf.  */
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+				size_t msg_len, struct sock **orig_sk)
 {
 	struct sock *sk = asoc->base.sk;
 	int err = 0;
@@ -6503,11 +6498,17 @@ static int sctp_wait_for_sndbuf(struct s
 		sctp_release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		sctp_lock_sock(sk);
+		if (sk != asoc->base.sk) {
+			release_sock(sk);
+			sk = asoc->base.sk;
+			lock_sock(sk);
+		}
 
 		*timeo_p = current_timeo;
 	}
 
 out:
+	*orig_sk = sk;
 	finish_wait(&asoc->wait, &wait);
 
 	/* Release the association's refcnt.  */
