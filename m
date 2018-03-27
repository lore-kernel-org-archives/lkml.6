Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522169057-2-11671451393822844863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522169057; b=n40pVNYRQ7xRmBnnw+Auw9aeWsgE7dPN3dGcwAQozLweWS7
    Glfd0kwfm1sPfa5MLcOMmB7VdHC9XqHSJYAqQ3CjFWmNwuczPM+hlj21rOFG78dv
    mrEh9EG3iTXyGcA8BRgptLUScsNc1UDsP8DCKgZ4ccwvW1uV4vcYSjLPZs3gw1fu
    6x5NuSIwSZn1xMCXqKAj5/U7o/9N7i7UIdmHCoO7q6QeOXl+7esdQYha2kIaoBf8
    1Jk9d/0qKg5DytCOT7VAJnXeLFwChdbVcaNFE/+/TnlXjv7N5IfqywdHEXiqeJ8J
    ta/eRa2Cx+vzFXD5aOJkDARdjdpMEeiqfC5+a0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522169057; bh=nefeoKEqrP+I70631p/2m3u1+o
    Dt3X3053wk3CRwDDU=; b=Mm0/4xL2M4ltSYd5k9Xd2jd3zyOUJlJWoFVLDZaAJy
    EwRG4rqWV7bvgPs4aviawt+UhTFyXbiBHma7d7FBi/5jm4Nkv8S22c3quEnkYqhf
    SRkVq/z3yWWw4D8B5lvNM0sukRDMYYIgvnbcXddgnYqfeTd+VsiiFk9TOnIEG6z/
    o1eC8ap2V2uBsX0WDNZMuaod7wOu3soqyrnD9UtHk/3FuA6sWmiPMkSm/Qx7/F67
    Nmt5x9ImvrUakatyJGm0nDTuU2Jkm1Kxj/3ui8wUgt7aWc2buY8+dNC9esT0Sg4U
    IY7VKcnTg+Pj0IKB67M3R4SFsqI6Tdex+sFemKUjoQ9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKl9GyLCcnolfY4q5jRtoakKd5g13YyTh3NLOvHpzfoBYZjiQmehY7OBkGR3hosluV1U/zGc1aMDOfXWhwBN7wvWI6vUigGXMjvreQx2P3hFXFc3T2kN
    XoagEoPZZs2+yTdyy+57axEZY7CpGUbwtw6NWUpqufS87RfXYkboOWt6XlC+viGVtL1zlUYH+51AOwA7Kw7B1c2SdhCh/FnkyCaNNJJskRZyA7iPoh3hY3/E
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=nTPwkA1SAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=k70z3KJa6u0epaJ5EroA:9
    a=QEXdDO2ut3YA:10 a=HUqATDVKn4QA:10 a=Her_73y7XSQQkpQYGz2D:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755592AbeC0Qnk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:43:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeC0Qnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:43:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andri Yngvason <andri.yngvason@marel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.15 081/105] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Tue, 27 Mar 2018 18:28:01 +0200
Message-Id: <20180327162803.240044456@linuxfoundation.org>
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

From: Andri Yngvason <andri.yngvason@marel.com>

commit 9ffd7503944ec7c0ef41c3245d1306c221aef2be upstream.

This fixes use after free introduced by the last cc770 patch.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Fixes: 746201235b3f ("can: cc770: Fix queue stall & dropped RTR reply")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -706,13 +706,12 @@ static void cc770_tx_interrupt(struct ne
 		return;
 	}
 
-	can_put_echo_skb(priv->tx_skb, dev, 0);
-	can_get_echo_skb(dev, 0);
-
 	cf = (struct can_frame *)priv->tx_skb->data;
 	stats->tx_bytes += cf->can_dlc;
 	stats->tx_packets++;
 
+	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_get_echo_skb(dev, 0);
 	priv->tx_skb = NULL;
 
 	netif_wake_queue(dev);
