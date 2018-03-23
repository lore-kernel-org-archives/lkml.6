Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803872-2-12281738770453622120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803871; b=tbFeeADuZUF8G+0TG9YxV/lmEZpDHb6vWWuTXQv/miis62E
    3DaSICxWJfuQwiLKvEVzKV2RxwyFQgqfc1F8zyCuO3wiOYkcnDVVkTxBj+uCrD2a
    l2/2sSn3CunEUG4gGWgpgXWWTf1WDII0fCHMgoo63yG2yJXQwHnB3dgBXCUIBdmo
    vq3/RfTSxqVvnYbyQIDCpvpf/qxqKxoRuY+pQh9M0tQQ6bQU3UN6ZCkNt3/MPTD6
    JRxkmVENeT3BdJNYGWt2SomjVtB7Pl9vwChJrOxcZ3D4tEY05hoIHPKfZbK99xLx
    u6BlILZPHbTglBsaD7UbzsHtfPDjZi85HwnpnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803871; bh=x55/kutd7WBaACcaSB9M4CnfHp
    JchcfxKq4gbqv/9So=; b=TPx7H7+AOPa4Aj/LBdqLdcAr86RUO25zAR2QSEYGrW
    c4OTSrvRqHqn/cO2Z91rKZjfZBOI9GeJHA0jMmGI2QVThVm2yU+fB3KVuMUB9YiP
    VOqkFJZfGnNPB/zcoE6PmTsNHSxE8AStvgHOfb+5Dk5vIupd2sSUhldYtus7PgqM
    P01d68BvYzUl2auBG16oHRvyPto76bSoIQwHcxL6hpTztqbDGDvOCSIPPeMm0GGn
    fHSs9lgkGE9z8rlQFBv8nnjoF6KAZACijIHvZdyzzXWdzDynC6ioTtftwOQSsHv2
    a/xHjmmbBtHYtakJfuwFqv2jOHnrkc1ibVXq3UcANg0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755745AbeCWKJT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755742AbeCWKJS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 106/177] Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
Date: Fri, 23 Mar 2018 10:53:54 +0100
Message-Id: <20180323094209.954357340@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dean Jenkins <Dean_Jenkins@mentor.com>


[ Upstream commit 048e1bd3a27fbeb84ccdff52e165370c1339a193 ]

Before attempting to dequeue a Data Link protocol encapsulated message,
check that the Data Link protocol is still bound to the HCI UART driver.
This makes the code consistent with the usage of the other proto
function pointers.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_dequeue()
and return NULL if the Data Link protocol is not bound.

This is needed for robustness as there is a scheduling race condition.
hci_uart_write_work() is scheduled to run via work queue hu->write_work
from hci_uart_tx_wakeup(). Therefore, there is a delay between
scheduling hci_uart_write_work() to run and hci_uart_dequeue() running
whereby the Data Link protocol layer could become unbound during the
scheduling delay. In this case, without the check, the call to the
unbound Data Link protocol layer dequeue function can crash.

It is noted that hci_uart_tty_close() has a
"cancel_work_sync(&hu->write_work)" statement but this only reduces
the window of the race condition because it is possible for a new
work-item to be added to work queue hu->write_work after the call to
cancel_work_sync(). For example, Data Link layer retransmissions can
be added to the work queue after the cancel_work_sync() has finished.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_ldisc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -113,10 +113,12 @@ static inline struct sk_buff *hci_uart_d
 {
 	struct sk_buff *skb = hu->tx_skb;
 
-	if (!skb)
-		skb = hu->proto->dequeue(hu);
-	else
+	if (!skb) {
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+			skb = hu->proto->dequeue(hu);
+	} else {
 		hu->tx_skb = NULL;
+	}
 
 	return skb;
 }
