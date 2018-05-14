Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281333-2-17122594119034488991
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281333; b=g4DSzcaraQD3bAZAHAXFvpep2N1NtXe4ElXiENQcuYdUm9I5sq
    oO1WjxBwmEK958moNr3F/duBGNo7KBzUXDj2L5P/DPUJ3M+8UNOwHxP1LAAWsnQZ
    Sz/TzqUHl4dHTdm+QuGb5iq79xHLvjNsWLNihBeDzYor3fH+lTPnrZPtj09c2nHi
    8a+aWZSN8FmsmXyz7rwN6u7iCfzWdY9dGjbcPe3Vc5hG7Q8keahSvCF4VvmolG4d
    w3BAJW0+DFWsLxVRRX/37IWGxgvcQ05PMsbBSjSFDYOJ/BuIdztRQG38l+pi3ExY
    DIUtf0lmA9L1qQ5xnm4AmAV+m2f2HsmDAUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281333; bh=tZceLMQQ8/OnsCCgplidyS7Zl+vKoI
    UEg+2g6kFbLs8=; b=nv9do1bHNS8ediYWCmKA+9kBaPeh2cdS9wNdy+Zh3I3DV9
    AfYfK+37MWZS/EHXEa5QdQwbbEXt+MiB9+Ksj5IDAKDRA393/TdVY4zCf/48QHe6
    JDUrLHskB5dtisdx6CpHJeMFAaZjwfOz0HZLSD2xiFUEfkE3fux1DClSyEivWDcG
    y4WMHKuXMkIbh60+TTR68x4EimJKX0bA/7pkUuvdFegvm2o31Mt0lEz22viQ6jsW
    6NqX9DpSwSFc5wl8mQVa/8fHEtEazF9pcgQuiHfCtDVZCcpJnohCl1F4VKx6OiYA
    7LJIPlGhYrSjoHF0h6PSWak2v1MY1VzW65qLBTkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1eWCfkEp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1eWCfkEp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLg6qVhDOhn/3GLzgSwAUb9ZKZcb6AA1JkBp4dxAXk0l0EUZrHc8q4B29bJ+rm0n6mRDog7Uay4KeNqqWJYvybRIjaKXBG6XTmjCByeY3R4r937koFaC
    Ken1Kyr8pMHYLyfMY3Vw6w4L7X7jq6qN8co+/bWAzNxW6hw2kj9USujaw2e5PuEmaB6V+/MIr4SAd87ur2UMByl0gAOMlXb4+Tht5Sy0XbhzOaJV9Tv/uBGm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QtX7IHQTAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DvgNF8sHIdjzDlHExykA:9
    a=QEXdDO2ut3YA:10 a=iAbFv2jvUoy42RkRxxYv:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeENHB5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754211AbeENHAs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>,
        Lukas Wunner <lukas@wunner.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.16 38/72] can: hi311x: Work around TX complete interrupt erratum
Date: Mon, 14 May 2018 08:48:55 +0200
Message-Id: <20180514064824.811806438@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 32bee8f48fa048a3198109de50e51c092507ff52 upstream.

When sending packets as fast as possible using "cangen -g 0 -i -x", the
HI-3110 occasionally latches the interrupt pin high on completion of a
packet, but doesn't set the TXCPLT bit in the INTF register.  The INTF
register contains 0x00 as if no interrupt has occurred.  Even waiting
for a few milliseconds after the interrupt doesn't help.

Work around this apparent erratum by instead checking the TXMTY bit in
the STATF register ("TX FIFO empty").  We know that we've queued up a
packet for transmission if priv->tx_len is nonzero.  If the TX FIFO is
empty, transmission of that packet must have completed.

Note that this is congruent with our handling of received packets, which
likewise gleans from the STATF register whether a packet is waiting in
the RX FIFO, instead of looking at the INTF register.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Akshay Bhat <akshay.bhat@timesys.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/spi/hi311x.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -91,6 +91,7 @@
 #define HI3110_STAT_BUSOFF BIT(2)
 #define HI3110_STAT_ERRP BIT(3)
 #define HI3110_STAT_ERRW BIT(4)
+#define HI3110_STAT_TXMTY BIT(7)
 
 #define HI3110_BTR0_SJW_SHIFT 6
 #define HI3110_BTR0_BRP_SHIFT 0
@@ -737,10 +738,7 @@ static irqreturn_t hi3110_can_ist(int ir
 			}
 		}
 
-		if (intf == 0)
-			break;
-
-		if (intf & HI3110_INT_TXCPLT) {
+		if (priv->tx_len && statf & HI3110_STAT_TXMTY) {
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += priv->tx_len - 1;
 			can_led_event(net, CAN_LED_EVENT_TX);
@@ -750,6 +748,9 @@ static irqreturn_t hi3110_can_ist(int ir
 			}
 			netif_wake_queue(net);
 		}
+
+		if (intf == 0)
+			break;
 	}
 	mutex_unlock(&priv->hi3110_lock);
 	return IRQ_HANDLED;
