Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834372-2-8794873373412868708
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
    t=1519834372; b=oT5SIASUgYqbVC5HW0d246RVWJDSCUOd0B2Un/8gHnBICKX
    Gs2RYdz9J56sCPwRkNAHMUb9hd74Nf8aXMdJIWG0IS4IAGsfaVgZ0urdU1agdUtm
    to7VkX5XKrmMjU/E3kHwCa9H9Tv1kx8hBtbztURzy3SxkYEztHmg/W53GJjLp9ut
    /OY/CFBhZFLV9mVmmyn+fOkOSdJp3w8mfQKuClUuZleXg284X0N5iruuRbHEcktl
    TR7s3VPw25NJ89t6/NAw2HuBVmipZPV3ChI1hKWM64zkCOgRfIm49ZCPbW7lS0qH
    QWiaU17xt8zUhyQN8yv3MRwzflvQjsKfZujs//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834372; bh=Zxo4dEvrBrRpCN0Q0DK
    a3KvVJCcZtlU4N//TIJhKLWs=; b=goD03qfFUYC+etNxNe80fFMhYTSCody9LD6
    2rT5ioQ5FgMlxeitnY+8es2rPkUGX5pwiTbrry5Vd0IshwCJ+pKOPcO12u0N0RwJ
    YqTRTcJZ2d2Zk5Q0ijptoIgZSCyEhPd0ksxIGv+XSGpEPlCkeOYEiUOzRsaNf8WD
    Aj3CwYlb0mmVnmT+lhmSF22WyRd81zZCowb0+BIXIIAHbJqrsYoK2Hk+veHLVZJh
    U7uVjdweNPUrK+R6Qr4hc/Wl7TFVDBZRShiXAs39RLeDd98bWxAGqjRGEa/250Bs
    POvtW1QGbIKGvQINNSh60rsxR5lCCfz2jypXPSUz+esfZqT05ag==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeB1QMe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:12:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35048 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934523AbeB1QMb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:12:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.729701105@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 209/254] sctp: use the right sk after waking up from
 wait_buf sleep
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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/socket.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -82,8 +82,8 @@
 /* Forward declarations for internal helper functions. */
 static int sctp_writeable(struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
+				size_t msg_len, struct sock **orig_sk);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1905,7 +1905,8 @@ static int sctp_sendmsg(struct kiocb *io
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	if (!sctp_wspace(asoc)) {
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		/* sk can be changed by peel off when waiting for buf. */
+		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len, &sk);
 		if (err)
 			goto out_free;
 	}
@@ -4335,12 +4336,6 @@ int sctp_do_peeloff(struct sock *sk, sct
 	if (!asoc)
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
@@ -6737,7 +6732,7 @@ void sctp_sock_rfree(struct sk_buff *skb
 
 /* Helper function to wait for space in the sndbuf.  */
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+				size_t msg_len, struct sock **orig_sk)
 {
 	struct sock *sk = asoc->base.sk;
 	int err = 0;
@@ -6770,11 +6765,17 @@ static int sctp_wait_for_sndbuf(struct s
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
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
