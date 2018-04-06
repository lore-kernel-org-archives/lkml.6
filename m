Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021218-2-371634450240923227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021218; b=wsfrS9rgY+90ckpeSh+nYv4VqyuwmYUX8GTfRoj8XhRWYZXv4d
    rLJiYJd8jhts7hA8+Z54+EuXjA05OltqWargBTdX9sWIQ7morwonzamwY3ka1Fbx
    wpk40a0shWLp6CwIKiiF4JseqLULtdXq2L8NnWP8ddokpUGVEFXXAyIX4fEDbcym
    FT3iGmviQuhw65ZX2W4vapmtb75tn1KhpqP3HiZdc4GtDOOnlMrnvg6qYBD8opm6
    KPmZym5NLO3QrgabdTOL0B+ljd3E2THccylzgxYX+VgMkBd8hjkhxa4Iu8FVJlds
    Y3T3tNGfo6EFgj2fYhd0C7FirkGfY+cWU5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021218; bh=1Eeh4qHBHf7vSFoBm4dmUoszf2UQzF
    LFZsF/sPyAvoA=; b=vbZJOw1cfa0DQUyOAVfXcPU6oXc0YfCEOvEozfsQSWZkir
    QzymKKwIvBEJNAM579cL8afm6rclDlfzPvszTVhrUENJEYkhK/jdfbbI2/LUu5IK
    PovZGI5qt8vg3vWH+riAwetsFHn2mU/H/ptoE1tmcYAZiKmSFMkWzrLJ26oI8D/+
    jTW49vvNHnoyPzK+rPt2H+3Bq3k29dpNr3N0++0x0EanNhzf56tpc/o/TdoLtlSG
    ZF1hcqszZQ+KdoGxqZ4il01P1ltbNdSjrq+nhIOe4Of/UO6JKH45igKP2m0BwKFD
    hh7tL3PEBMNz2+vYLPrF5dD0yQwlJDgHBMhjiRzQ==
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
X-CM-Envelope: MS4wfGzqY5xlAnOp1lNOgimpvcbRrMTtJT8hSACAluFUGRDSTnkjcgXSCUhAQ/YJ6OFsn6bIXx+mEoLe2n2fj9tX2Nsqz0/BW9SA6sZKll2cuDy+bmgRCJav
    FXPhZCnBPHL9A7FoR6tmUp34Zls3zb58IINpY3b8Qv4BWD7A7/QXj+v/w0lwrVYudoRpZXklgSYQPfjvyT1cRWYZSFcUzAo+TLtXCyaxsxNALaasF7G+eFmS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=nTPwkA1SAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=vLpVfuLr67vpf4bYrjsA:9
    a=QEXdDO2ut3YA:10 a=Her_73y7XSQQkpQYGz2D:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDFN0w (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:26:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDFN0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:26:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Andri Yngvason <andri.yngvason@marel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3.18 16/93] can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
Date: Fri,  6 Apr 2018 15:22:45 +0200
Message-Id: <20180406084225.679371059@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit f4353daf4905c0099fd25fa742e2ffd4a4bab26a upstream.

This has been reported to cause stalls on rt-linux.

Suggested-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(stru
 
 	stats->tx_bytes += dlc;
 
-
-	/*
-	 * HM: We had some cases of repeated IRQs so make sure the
-	 * INT is acknowledged I know it's already further up, but
-	 * doing again fixed the issue
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
-
 	return NETDEV_TX_OK;
 }
 
@@ -683,12 +674,6 @@ static void cc770_tx_interrupt(struct ne
 	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
-	/*
-	 * We had some cases of repeated IRQ so make sure the
-	 * INT is acknowledged
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
 
 	stats->tx_packets++;
 	can_get_echo_skb(dev, 0);
