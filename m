Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835202-2-5669364531292901717
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
    t=1519835201; b=uFpWYWFdmEi1nVW2Axhrv/bol7grYAb4LQOynM1swWEJ9l1
    5ynTAS6JnsZGB02dqO4TeXAebXVDiQaliCqD0dNzdZhq2y5tVMwicC0CN/TQtOmw
    P/sld2JU3xNTgl7I8m+zAKJw0pb269LOExMtr7rDUzFIfgYgsNJfbWuHD2klrhmJ
    QUJeESfddgE2to7hEkKA/1sMkKlmDzAA1OWv8JEKFEwkBV7qslI7slht2n/90ln1
    scWpBXTvf37WfaPeKLhiW+qrY0kH8wWnlMk2wIK7EdSyR/+wRXnJbfHGk1cxaBoc
    ZqqBo223kGIiDQK+HMONztIsm8HSnAfGxLPrJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835201; bh=hJahpn7VZT+T/cjpJtr
    R7+AtCYs5aCrH/fP5s4gww18=; b=YaFfuB3+RdTN7bUrBtfm58dipjsirk1wyZq
    9Yry37LrU3G6UbmcLmUQRusOENdkNkia1oGRVBc8GjYBe/H4YoLPipoEaRwXUv7q
    WU391kYyIKXZOPbAZi61rkKaO2buE58IncV1NWWrnHmm30YjoJv/7uS9Pk3RDMcc
    L+NLZlSR/WdFr5JXAQIXk22uLuELQ1ugfdEelb7tWNTYCOhJU/IXYG7GjZ0bQuiv
    VFcfGq7uulbDPQitiO/YDm44D5KCNUUf7bmIToYHWX4yn3KBoQJMzUPJpi2OAgEI
    3fOMoo1zXmjnAz164qCvEhGujbrkyKC3JOkfhEcSZTWfCa/WxRQ==
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
        id S934856AbeB1QUB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35221 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932732AbeB1QQI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dmitry Vyukov" <dvyukov@google.com>,
        "Oliver Hartkopp" <socketcan@hartkopp.net>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.196344564@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 219/254] can: af_can: can_rcv(): replace WARN_ONCE by
 pr_warn_once
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

commit 8cb68751c115d176ec851ca56ecfbb411568c9e8 upstream.

If an invalid CAN frame is received, from a driver or from a tun
interface, a Kernel warning is generated.

This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
kernel, bootet with panic_on_warn, does not panic. A printk seems to be
more appropriate here.

Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
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
@@ -719,13 +719,12 @@ static int can_rcv(struct sk_buff *skb,
 	if (unlikely(!net_eq(dev_net(dev), &init_net)))
 		goto drop;
 
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != CAN_MTU ||
-		      cfd->len > CAN_MAX_DLEN,
-		      "PF_CAN: dropped non conform CAN skbuf: "
-		      "dev type %d, len %d, datalen %d\n",
-		      dev->type, skb->len, cfd->len))
+	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CAN_MTU ||
+		     cfd->len > CAN_MAX_DLEN)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN skbuf: dev type %d, len %d, datalen %d\n",
+			     dev->type, skb->len, cfd->len);
 		goto drop;
+	}
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
