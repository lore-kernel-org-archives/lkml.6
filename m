Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832886-2-14414452741390628565
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
    t=1519832886; b=vMgJYMjtWlMypl7JXSFd7y1PnJAwMNvEbmZ3st7g9wo4zrp
    RxkkkIuTN/mf9m04pJ7cHOfOGgQ5zRVHXLJ9+ttLjNoO0XXJknCxIIQOSY7ooM6b
    VFr7zNcmdoUWpbGfchCdkoqNPV0sWoqpS9nTBpZ8TyjDUVjdZZG8PNaohOliUp1E
    6qZsgibYhOhXB9P6Spt4SJIqG4/jm6fkrePUsgPTHshmBwnWr1Wudq5I+WJr9Mmq
    ANS4xd+N8q+ygvV1D7Z9B6qnsS6aO3wgPVz0KBz2QWk8kohKMGA2vyTmUmCKlANK
    IR+J6xjOCw+qshiHCfVhWlHIKc1p6eHGmHt3h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832886; bh=8uHDYMBatQT0G2pId4n
    LXxq9dVt6udFke7nwy+5x/q0=; b=ablFPeFa+3FXiIP3LhDPCndelP76IkpvDP2
    h38vqqkSlwLb3PEOQAVSYk/3LyPDe7SvGVZl2IW0hKVhD8gQw9+Brl5PbbzKHyoQ
    gn9bCJjh2bCc2uu7Ne/8068QeNUD/B9BdxZH8l1SgHm24uI49JS/2XId+ImjVR6W
    TC6xQdB63Ebex7/R3rrCFL/kkovBle/GEY0xvOz0DgMFkgZRHRypUaRFutW2kjDx
    7uHspH3eyFIHAvB7sDIi0QyXhtY9F2/mh59k7njwEoFIZkz1Ee90Ss59l+RVlySE
    xUJP/w/bP/l5tchseOc6fybX1aw7ecwNfPJgLHkdeWc1BqdVvQw==
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
        id S933292AbeB1PsB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:48:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34226 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933490AbeB1Pr7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:47:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        syzbot+e3b775f40babeff6e68b@syzkaller.appspotmail.com,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Oliver Hartkopp" <socketcan@hartkopp.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.206733726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 220/254] can: af_can: canfd_rcv(): replace WARN_ONCE
 by pr_warn_once
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

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit d4689846881d160a4d12a514e991a740bcb5d65a upstream.

If an invalid CANFD frame is received, from a driver or from a tun
interface, a Kernel warning is generated.

This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
kernel, bootet with panic_on_warn, does not panic. A printk seems to be
more appropriate here.

Reported-by: syzbot+e3b775f40babeff6e68b@syzkaller.appspotmail.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[bwh: Backported to 3.16:
 - Keep using the 'drop' label, as it has another user
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -742,13 +742,12 @@ static int canfd_rcv(struct sk_buff *skb
 	if (unlikely(!net_eq(dev_net(dev), &init_net)))
 		goto drop;
 
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != CANFD_MTU ||
-		      cfd->len > CANFD_MAX_DLEN,
-		      "PF_CAN: dropped non conform CAN FD skbuf: "
-		      "dev type %d, len %d, datalen %d\n",
-		      dev->type, skb->len, cfd->len))
+	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CANFD_MTU ||
+		     cfd->len > CANFD_MAX_DLEN)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuf: dev type %d, len %d, datalen %d\n",
+			     dev->type, skb->len, cfd->len);
 		goto drop;
+	}
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
