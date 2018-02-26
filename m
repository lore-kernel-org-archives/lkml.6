Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519677334-5-968724528891294629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677333; b=gHuUQ26Zlcnuo3VBYnXC1uiLQ8joaZbqPcJQWISH52bkYX2
    KmP+2Js5rqrCYz81npXeBIRTocq7h7/GllaN5wblREH5Oli5Af8CwHEc/uaFPqI0
    PtYbk6mhx9+Wef/9zdfsWFmFf92qxb1tj7Gg99LZ7Rl9Fz6EJhznlXtbvOQ45oYO
    nQqajs0tBNdig8eKEINscUY51KKW3xEzm4OJ2Wl8lk1goQQa3pV7RwWZxnb1759E
    vMjjhKPMT8BmDr1+/2JmWRN8y0UAoK9u81AUBhZspcYDJhx/+Gjz0/G6CBRCm+1A
    UZkBY1NvA6KrxTfqlUPtW5lEEEAbQBRaX5eD84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677333; bh=ZxXXAMoW2XJspUke3o6VSHZgFT
    HsINB1IDna2by9Erc=; b=VLsGaBjer1pjqmfPFAkd3PUJ1ijgp6kxilfSjC8WcN
    OO4fgS+88rYJrgM7hSYGmNMu1fnk0JQLkfZFWKfK46CHHthqFnedaOvWbCo51T4Q
    rsQd2+/xg8nSe1WsnORKXm99wkK0nfPLQuilEJB5HvTx+GOv7hPcvTWiOBndi5ej
    QnHiDr+j5KoIMWdrMdkLKFhbB03GzuD3r8vzEwjuaiuJALnKWAes0rVWWGVsGQKM
    yB5IfqIa/y3rfuopWnrolVoLjCcTzi8QIW8yAv7UYcuY1hzsAtMTE+lusWGfTPGm
    A3JF/yZH4FZPwegrG4S+ZpLXnb8BJqcSKyI4DoOv+DCg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeBZU1v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeBZU1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Stocker <jackstocker.93@gmail.com>
Subject: [PATCH 4.15 42/64] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Mon, 26 Feb 2018 21:22:19 +0100
Message-Id: <20180226202155.243976010@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
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

From: Jack Stocker <jackstocker.93@gmail.com>

commit 7a1646d922577b5b48c0d222e03831141664bb59 upstream.

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Device ids found here:
usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-3: Product: Corsair K70 RGB Gaming Keyboard

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -226,6 +226,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
