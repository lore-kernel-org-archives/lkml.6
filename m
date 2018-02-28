Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833043-2-16100183300900733415
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
    t=1519833042; b=AwmcxHMWS5T6usbVPnnZxJXEMnHgzMdyVQ4BOBSbIfBulYJ
    voK8gYS3HTib6Dstuxzpn0TuhrYupvV65aci1FqtZnZvryNnBWRhukhR1Hb9OpD+
    /tbLwpC8EPMR9XWHY9Hl5aN5DFR89ONRUO7jd6OiX/IhWsou+/ZSyeE7jUiMnaT9
    m4zRJ+z2o3E3xWahQONP5Ek28yVt3rtRFiIoaBKtrsZHbDt2RzwuYcv7Lr4xM6av
    IGbspFFUO3PJBbzepgq3IJLNXhbYzeTOOUNTis8Uqmbcw6yse1Jgn2suIngrew+Z
    qXCi247rRBB3HAmH7v3tnMPrcmxqZwb8dtjQRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833042; bh=0Xu/0JAuEF2jrR7XNmT
    Tbe8QxYXQuicId2r7QFErKaI=; b=mjWLa60emsVPLz9qY/i27ZHebML+Y22svmy
    qH5Apghqlk0CKB3mWsztB7crlZJnmOJwI9/w7XGVIN+MIb7HSULJ0GuDy3B9K6m5
    oMgRPu3Ti7LosebEJw9D12pQYaHlKUdE6G3taFPDP6p7QultSuRNipKVrN1TCYRT
    yIbm0ds/z6AX6ii6c43C774Oulspn2bJI33Ojplr/EP411NIlbuUTUz4HY6UR6LQ
    siIkupq2RRb9Yf9wO5cTt86Jk6XIF5JBths5OLEaUqITjTkWQh3D9b9+XmEtSqvQ
    kq2QZbGoKzH9okHXVDJMcBW9/wutSgbHauiOyYhEv3TDWmEZe5w==
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
        id S1752920AbeB1Pu0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:50:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34323 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933668AbeB1PuY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        syzbot+ac6ea7baa4432811eb50@syzkaller.appspotmail.com,
        "Xin Long" <lucien.xin@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.483853923@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 210/254] sctp: return error if the asoc has been
 peeled off in sctp_wait_for_sndbuf
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

commit a0ff660058b88d12625a783ce9e5c1371c87951f upstream.

After commit cea0cc80a677 ("sctp: use the right sk after waking up from
wait_buf sleep"), it may change to lock another sk if the asoc has been
peeled off in sctp_wait_for_sndbuf.

However, the asoc's new sk could be already closed elsewhere, as it's in
the sendmsg context of the old sk that can't avoid the new sk's closing.
If the sk's last one refcnt is held by this asoc, later on after putting
this asoc, the new sk will be freed, while under it's own lock.

This patch is to revert that commit, but fix the old issue by returning
error under the old sk's lock.

Fixes: cea0cc80a677 ("sctp: use the right sk after waking up from wait_buf sleep")
Reported-by: syzbot+ac6ea7baa4432811eb50@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/socket.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -83,7 +83,7 @@
 static int sctp_writeable(struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len, struct sock **orig_sk);
+				size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1906,7 +1906,7 @@ static int sctp_sendmsg(struct kiocb *io
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	if (!sctp_wspace(asoc)) {
 		/* sk can be changed by peel off when waiting for buf. */
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len, &sk);
+		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
 		if (err)
 			goto out_free;
 	}
@@ -6732,12 +6732,12 @@ void sctp_sock_rfree(struct sk_buff *skb
 
 /* Helper function to wait for space in the sndbuf.  */
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len, struct sock **orig_sk)
+				size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
-	int err = 0;
 	long current_timeo = *timeo_p;
 	DEFINE_WAIT(wait);
+	int err = 0;
 
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
@@ -6765,17 +6765,13 @@ static int sctp_wait_for_sndbuf(struct s
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
-		if (sk != asoc->base.sk) {
-			release_sock(sk);
-			sk = asoc->base.sk;
-			lock_sock(sk);
-		}
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
 
 out:
-	*orig_sk = sk;
 	finish_wait(&asoc->wait, &wait);
 
 	/* Release the association's refcnt.  */
