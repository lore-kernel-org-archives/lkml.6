Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2043643-1521571395-2-8446975050939728762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521571395; b=ThyNyKC4CeFZFi3JMURvdfVG1QnBlHv+7mIU3x9F/rhXdvp
    OqptrWoaFM6ZUdB3uJhxj5hBgWcUX06cHNbyXZopO3EZiP9DQa3BTIhta142f2KT
    CBdw0XTaWI8jxRO/t9QwfhtYDmzgnWgDGEUflbW4K4lTcq84t2B46oDY++p3Vbaj
    5br9V7TOiA09wYboVKNR41clCPXtS1s10BjwD/wXal9dnOTi/3PaeGI7FBXQUReL
    5jH0Djkfw3pkBORhQbQGNH6iGh5SxJY8HUqFWTaqzrvFZ3MDl2tXw3uwBbjIkmI9
    Dkx0CbEDD2lb+wCAObLxMZahhgBZ//wm8LLPGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521571395; bh=8MJOS80RPz4hZg/Tt1Z9UNh55t
    ki0/A+Lsxu43nKXPg=; b=XUKfxMuFkLfbEzMmiz8CjYVhR8cnmy51dC044H+/j0
    lpZnaFNy0xbFCEvgeEuI0leeUrBMZmrIUc8v1DCHQ59njnOOtMtRjDx7Gxm3Vi39
    9xJxUbjeabsMXaRbwFBB+GVma0WoHZ4CtTOT4UAX8FhvfdQRknqs7ZxUVTtVx2+Q
    rLjjh5hmDRAeHa49lHeZijelDzDlxuVd2m/52uuW12lAxFKMreGV/7794pQ4hgQ6
    EuVskV+RgodVraGy7NUIMExoaKaZbMnsnYZmxSQ+rD5a1/1kKLTngjZ8GRhZugcd
    Q2DPth7P5bAaAkbF7oWiqresCGR2wFlJNqXx5IEFkeyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeCTSm7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 14:42:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:36259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSm6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Mar 2018 14:42:58 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Bin Liu <b-liu@ti.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/1] usb: musb: gadget: misplaced out of bounds check
Date: Tue, 20 Mar 2018 19:42:48 +0100
Message-Id: <20180320184248.11962-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:9XnyvMPYe6JMFnuduDFCnqECQzOZDYyw674KDKmco0sNszRhSSV
 DGLTH3AHsurNAR/HVVM+RlqfFV3YvJLtsWZMAFYRvAkWce6FsQrn9qANM0QuSt19FNhOEbO
 V6iwZX8KJsrb2DHwjMmQ6ENbDM/pQaSPgVLUJ+ssbjlkNT1Xv5ZtXQG7Oy3kj8WbsVGsC8L
 IYWhnd6qGQ8IwX524TAhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OXE0OytPgfk=:YDw4iMeQfQxicEF4K35Als
 zqGm+XCqZw2hoz5gPObRNYkpSq+pAs4yetepnRgedsSZX9QioJRbnu9rsFc55k8rCVRgcF8pc
 fc+r6GZGTEYcfErqc3BY7hpnqvoeu4whhZ/UCvAqHOdu9Xl9z55c+ESZUVyWfcmSVVEWRAtHm
 jc19c1p5NGqDJCxwPP7IjzbzJEYi5ziJPDA32+Ii3XYR4JH8UNG7PLAF2pPHWK74eWJfLExuu
 yLW/CS8kZim5N9JKKtGoLukpv1E3B2lF8lWyM6t6KnDm+dsGyb+UL7Vu31IK64qasj43OvuWd
 AjJ75aydp/CNohJBgmof/4ofjMDXi/VrG1Qhw3BUf43QIMuqNYBEBO8ejguniO8mqC1blpelh
 1hLT+91lsQ1ElxoNCj7CqOtTjkO5M5h8ZbutAEnktoC+/ISJjG/08Lx9QwYneX8E2sGoJdgGw
 G2kP659A3kywW5s4ojG+UT6IvrcFfPMTts180geSJJZZK7CXVZVXE8qUQUzy0QfssGqv7pAxU
 8galQKZvmwDLvkWx43TJ3nNo1FZPOXIFGNXJ9IIesR6UdVnrMsag0lA4UNs5VwS/TOvaTD29l
 Esz04uMfZxLrFZ/2C2pm9Uj7Wga/VjZUYaEZFl8OVqhxetco+RX0OABBn+L0gVDGvDx+gBHxZ
 a0/KfOOkUe04uaRZb1hKfz1BfVZeuK88JgbVvNEEb8cap7HfYHtgGj5OF2U99h61OghGuZYvs
 jHgpum4Qq7vQ1n/rPxRbaLiI2BN3RwOd/5a99ZBSy/STUlhqpG1NERQUYnJzQiEWQXymd0vQV
 Z/UcUs/eCYGqxDrTfo4b8Gl9fWVdg==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
v3
	Remove superfluous braces.
v2
	Only the 4 low bits of epnum are relevant for indexing.
---
 drivers/usb/musb/musb_gadget_ep0.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 18da4873e52e..91a5027b5c1f 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -89,15 +89,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
-- 
2.16.2

