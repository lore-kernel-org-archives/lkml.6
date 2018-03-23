Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803786-2-14509828592657130413
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
    t=1521803786; b=nBfeS3dgXQgUaWfmCf8aHPVAWRCA3fy4D/9bJFoNtswLnnt
    tIoa3IZo1qU+krjltFNBWKW+suKRTCTZtNF+1cYg75zIFXFZb5IpEc47ffjzKiPd
    prRziicf0yu17j+94RS5CDDSwlHj1FYrQKkLnLV3n8r3QA5sW0nZQFUkpqrUwDpy
    0iRYVcr9UsZd4x6gI3l/D9qpN2Jlwxyd3Pf//WeSdVN1GqsN3Vhix2zNl+fvcg0y
    ZxpUICQO6xVKIDJMDIBJAzUqhjw7Q2BWtfWqYl2AFHqWAXh+ruJIJKMwW74w/QP0
    LL6kG2Yi3FckuGmct49alLU9bhaqdm03TkaGhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803786; bh=cFY0cC94q/bdegjxcK0XAVp+uT
    X049naUN/KozEBRQE=; b=Fs87sOvGnDRnLrpICSohZchsRycQvk6mjim2Ozd9Xt
    OKISMRRtkINdp77/L/heA9llBjzg3lD6bCq0K5Q4DUhtMz7+6hgUgus844WEHlWv
    Y6dAVMqlh9OJE3iPV1xxNzPBxUEn4eF4z5M1Wi+ssuXih+PL09LqzT0pm3bi5FOo
    3U4v+QWyFiid5Cphe/an/flBu0E4c15BDGTqbOcQC8oR4RqXilYNGqrkQWcF0d3/
    Wpcfi2ayToTz8nH8IIDBNOOvEbkQw5I2KUHUUdJWxN6wGwQoUX3H+JxbDh4N9SzN
    Msl48sVNCJ7XiPIJ+ygXIDZFGEKweJYJQHPk3Ele+nXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932530AbeCWKJl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeCWKJk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 107/177] Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
Date: Fri, 23 Mar 2018 10:53:55 +0100
Message-Id: <20180323094209.999581866@linuxfoundation.org>
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


[ Upstream commit 2d6f1da168e1d62c47f7d50135ac4cbd8411dcb1 ]

Before attempting to schedule a work-item onto hu->write_work in
hci_uart_tx_wakeup(), check that the Data Link protocol layer is
still bound to the HCI UART driver.

Failure to perform this protocol check causes a race condition between
the work queue hu->write_work running hci_uart_write_work() and the
Data Link protocol layer being unbound (closed) in hci_uart_tty_close().

Note hci_uart_tty_close() does have a "cancel_work_sync(&hu->write_work)"
but it is ineffective because it cannot prevent work-items being added
to hu->write_work after cancel_work_sync() has run.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_tx_wakeup()
which prevents scheduling of the work queue when HCI_UART_PROTO_READY
is in the clear state. However, note a small race condition remains
because the hci_uart_tx_wakeup() thread can run in parallel with the
hci_uart_tty_close() thread so it is possible that a schedule of
hu->write_work can occur when HCI_UART_PROTO_READY is cleared. A complete
solution needs locking of the threads which is implemented in a future
commit.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_ldisc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -125,6 +125,9 @@ static inline struct sk_buff *hci_uart_d
 
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		return 0;
+
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
 		return 0;
