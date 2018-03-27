Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522169010-2-1428404014051728542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522169010; b=j2z+YpzOijP2321SPQcl8wm+2mE8B4mupJZIVt+ff7K3FCx
    XruyGg4cbRifZRzG8ESNTxJogr1M0Z8w8ljjpAgmAAjIUsgvgcj1Dduqjmwq5Grb
    Xz5v6sMya/Er1tX/GSp6wzNyqRg9FPCyG4GTdZviMSs+tOOtpRjEid+YBSzkW2C2
    op1xSQFbYhj8xOTf5z1kqpuoLNnVP8ZDDJgq8Majg0QdbF64l3c1fF8Y0qNH7j/p
    ywRLH8ZGhgdpsyqxlB3s1RkIzRu2gCGV+HXOPhwzGhXz9orkhLB6QmfNu6Sf+BkI
    rFlLVM0lWiwwEfqZwkwr/qAemjifHBSjikPaWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522169010; bh=evAwpUDKQIGS+ArFi03vOCkAUS
    7lUicLVBoYEAd4ATY=; b=VCqnQv8Mx493B4YuYgaIScpTci5Rx6RqrEyHjOg4eR
    9PxMQmRb8bSe5hVmCPny8WmLctQ/XMdxCL0z8A57L8rtoMI1odI7zNGbvuwCAUbv
    7svjm1yyK6XnZOXPCkf7P1wZMF7zh9s18f/PedC2S0fHS+axLeFgSnVNNAb2+rGH
    +z3ZtGSAoTB4b85P4ufY4tDaIfiPkrbHjb8CKoYEJMp35cyXhASEgHncGFdZDu2e
    CzoZBwYTaquDmwH1r4ZG/qOUFBGWVsCBJJ9RbVc4CcGwryjuaz0XW/h7PF2XdOX4
    BysEntjR8VG+a4HFZUiId6TulpYXChGTPACPg0EmMK1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPwvd8ZkWVYL+aHbjBcabFK7lHa/xlZ1OxhhxmHBf3bVHeUw4zypprP3ZcDr+IpFWchlnowVAK4nal/PQ/DVVpwbcOLu90b93RufzLWoAEXjGuUQIcf+
    hWcPCtnIkRrd0sEThu9MGYg12wTZaJyPSRNWB6GPNm6K8MEOFT0RtQYhCNSmz+Rql51KRthThUsu2c2+kCWwmAaBYG0Gqr3rwkReo+UpbCAmOLwsmevUj0Vx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=ruePrcMeAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=1gNJWcyV3i22i8iW4wsA:9
    a=QEXdDO2ut3YA:10 a=QI2EG80Mmz_WNOzBKUk-:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeC0Qn0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:43:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeC0QnX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:43:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.15 076/105] can: peak/pcie_fd: remove useless code when interface starts
Date: Tue, 27 Mar 2018 18:27:56 +0200
Message-Id: <20180327162802.613560973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Grosjean <s.grosjean@peak-system.com>

commit ffd137f7043cb30067e1bff6fe62a073ae190b23 upstream.

When an interface starts, the echo_skb array is empty and the network
queue should be started only. This patch replaces useless code and locks
when the internal RX_BARRIER message is received from the IP core, telling
the driver that tx may start.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/peak_canfd/peak_canfd.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -333,7 +333,6 @@ static int pucan_handle_status(struct pe
 
 	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
 	if (pucan_status_is_rx_barrier(msg)) {
-		unsigned long flags;
 
 		if (priv->enable_tx_path) {
 			int err = priv->enable_tx_path(priv);
@@ -342,16 +341,8 @@ static int pucan_handle_status(struct pe
 				return err;
 		}
 
-		/* restart network queue only if echo skb array is free */
-		spin_lock_irqsave(&priv->echo_lock, flags);
-
-		if (!priv->can.echo_skb[priv->echo_idx]) {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-
-			netif_wake_queue(ndev);
-		} else {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-		}
+		/* start network queue (echo_skb array is empty) */
+		netif_start_queue(ndev);
 
 		return 0;
 	}
