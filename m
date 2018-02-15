Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720782-2-15328349537091679213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720781; b=m8cliUwzAy1+PirIR2McBTlW9MNlU3xb3JhJrJi/FCwEcNY
    bxgcqN49/HlpmxfxB70Y5RBAYnWD4nZ+hWcyYN1PbD+Ct0xsPNGRQLnHVqTAGiAE
    Zne+IdRmRtsmUu0Pwu4uKF4Vy3oMZmIzxmc9nKGkm+ojQmDZRgfrjV9Uct049GP3
    QKtmfY/H6gzXv/wP5uGGvMvyFBhR+IyPth6QUmeCHllYrO6mDS0B7NPEqzcB7bfI
    kwDK0E9NJE7Yxf1eWQGty7M+wteEQmmyOwlb1wuRbtrzGjthM0Cmm+iLedjZUaaD
    NtohW7PDCrKEoA52ShTmln5dEDkPzMNbCDVUuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720781; bh=O8NRPoK2FfQOkMVH66Z6O1qJRc
    /69y+st/dRBIjjYPo=; b=OQf1iicJD2aPAFvlji196dw91xyxchyTcSGyrt5xc9
    WbUr4MH0hByGH9aB3MlSXwR5xVa1vAij4w7akHlnEOR3DnpOuzoxBkI1VZJGl8LF
    bCB7XsbT5fmO8PX8vsGMjox9Br5wPxbXCXKT5JH7uelwU2b69UB/PUxPX+jexRNj
    62AfvjPJHZFGaxtJ/3EM5Hq9JvEAJyKVuIMwgebpG3Y5ElvOeBBMqISlz9t1xXSt
    DJPOguMMLMDPRZeNYlrzfl+HJhz/JjZ1E8P4wjrgj2I5KoDOXhcqsr8DsO43gnbF
    /VUXl9Y1CpkP3agmV/O4qaxgOFvk9JqsfXxl7+txXlQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162100AbeBOSwp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:52:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161956AbeBOPVP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mrkiko.rs@gmail.com, Matthias Hintzmann <matthias.dev@gmx.de>
Subject: [PATCH 4.4 020/108] net: cdc_ncm: initialize drvflags before usage
Date: Thu, 15 Feb 2018 16:16:17 +0100
Message-Id: <20180215151225.377489173@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Hintzmann <matthias.dev@gmx.de>

ctx->drvflags is checked in the if clause before beeing initialized.
Move initialization before first usage.

Note, that the if clause was backported with commit 75f82a703b30
("cdc_ncm: Set NTB format again after altsetting switch for Huawei
devices") from mainline (upstream commit 2b02c20ce0c2 ("cdc_ncm: Set NTB
format again after altsetting switch for Huawei devices").  In mainline,
the initialization is at the right place before the if clause.

[mrkiko.rs@gmail.com: commit message tweaks]

Fixes: 75f82a703b30 ("cdc_ncm: Set NTB format again after altsetting switch for Huawei devices")
Signed-off-by: Matthias Hintzmann <matthias.dev@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -825,6 +825,9 @@ int cdc_ncm_bind_common(struct usbnet *d
 		goto error2;
 	}
 
+	/* Device-specific flags */
+	ctx->drvflags = drvflags;
+
 	/*
 	 * Some Huawei devices have been observed to come out of reset in NDP32 mode.
 	 * Let's check if this is the case, and set the device to NDP16 mode again if
@@ -873,9 +876,6 @@ int cdc_ncm_bind_common(struct usbnet *d
 	/* finish setting up the device specific data */
 	cdc_ncm_setup(dev);
 
-	/* Device-specific flags */
-	ctx->drvflags = drvflags;
-
 	/* Allocate the delayed NDP if needed. */
 	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
 		ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
