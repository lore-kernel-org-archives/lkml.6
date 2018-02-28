Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838129-2-2460776492651970856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838129; b=p7eXrnAkxb7cu5v2m2nglvTzWHhNWv9ifaSdhh0MPZt25Q7
    DC0D4oYztzHdWTtn8O0ONgC9sqPm13guhVM7978ClTHG4XKbvXsosY2nN8DrkAFo
    Ie7PajGrKSs4bbgfk0S8nZhlTwfZTQXtrn4QBkSj+U4dJnr7vhfgjq7Xuizy98uO
    B1Rj04Uy1Hu5+GHRgRy9Ddz4w70VnqpfdA2mBKcfi388TBk5N2zVjGMzQUVJHW5F
    Opb/lSsU+iHMPA7O3FMq1XtHbHZGth0KEj2MRnXC3yCHWXasBy+GwR+izGjW864t
    z8vWwc4h3ZQEyd5rARDN3tQfnM8ivgqITM/UCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838129; bh=hm6lXzSUoOJrUpw2/K1
    BPPplzi0tdDYod9qNhd8eOZw=; b=gN/Hrfjjy+nT4fExw252JTyk+Z3NsTRbgAr
    mKlW8V+iem+WJr5sWRmgeHi4Xy3Av4QM2tszWMuZNCM1cv4SfcY5AD9NHsJo7l2W
    tgWriMKhdQPRrY9SRYW2Vl3T3vbEOX2yvU/4hUAv0BkpHLI9S0Wm33mlm6p4gNa/
    GteS9OCS4rXtKI7YmwgwAvRbdk533Inh4jreM3hPq/Y316K3Bu7GDOkwoxwsWiDC
    EduOrHsm1623ed2DeBUzx6n6yrpkVWgrPDyQcINOKC1vh61UR8aVpCr5XJp6UXIP
    tS4mbovGabo8bp0JGmdJWAeC5SP6GX41r+HXrsoElRjuPApMjYg==
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
        id S932362AbeB1RPP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:15:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34253 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933531AbeB1PsU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:48:20 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Oliver=20St=C3=A4bler?=" <oliver.staebler@bytesatwork.ch>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.912622406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 023/140] can: ti_hecc: Fix napi poll return value for
 repoll
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

From: Oliver Stäbler <oliver.staebler@bytesatwork.ch>

commit f6c23b174c3c96616514827407769cbcfc8005cf upstream.

After commit d75b1ade567f ("net: less interrupt masking in NAPI") napi
repoll is done only when work_done == budget.
So we need to return budget if there are still packets to receive.

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/ti_hecc.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -651,6 +651,9 @@ static int ti_hecc_rx_poll(struct napi_s
 		mbx_mask = hecc_read(priv, HECC_CANMIM);
 		mbx_mask |= HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+	} else {
+		/* repoll is done only if whole budget is used */
+		num_pkts = quota;
 	}
 
 	return num_pkts;
