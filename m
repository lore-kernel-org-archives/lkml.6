Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842223-1518038577-2-13319862900331420084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038576; b=s7NJGlH1C8jGr4NzJhIF+TFQVhxGz+msntpSXV02TW76vFk
    bgS6dMQgwiAbQwwz1tv5k+3DuYJlNLRRDv5j0UESxldz1KDwn4Vp6Cphf9GKrtzL
    2vGPY4VDGehAYdkKWibk+/xsfxtEngT1RINSyfSYlhYZAn0YRZJJQx8wSbO7boHB
    36tuvxA1+S9McHPfel0nKcJ+cILLdyBsy00miA/FbpkkqdEWj7wcCX7WZuT6mZcj
    /J+pW7LWq608eUGFMu1ZS8nawbsgwalqL+YxfwamZJSOk0E7DbKQQ1nesgcdFm7o
    J2xblQZTW/qDgWYiK/TT89PkhpwMyfR8ZvyP3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038576; bh=7iLGNzkGJDQcRfX9U9jw6etbmJB0Jhd3Vds
    64uVb4b8=; b=hAtQeSYVuRliUy6vyP+brq3CKxTgp6oco9ofAgHmK9wTllI/Bjz
    UNO41EpPD41FFbQfaCD/Jzxob+yQRfYqH0AKenO6sdRibIzPWzukZBS71GfLe2QJ
    J6TQyJzonofv82pF5WZhQolS87ieVzwppjKFh1ZVLDPDKHLXkmPz8mLfnmdvfCbf
    efzUXaKnTxVf0y+OvZhpxk+A5dAaK3GbTfC79p6yhefZZitvbiyLeg3UmvzoFV6A
    OhB2dGI/Ei1HG8su5pd7fINUNpsNCTThFQe/suFjXrSgQlZJq2c9PnW4NXtz0Y2C
    VJwEFFb4a20sKGmuoN2f5oHPnPQhKuXN2qw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeBGVVE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:04 -0500
Received: from osg.samsung.com ([64.30.133.232]:44519 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932243AbeBGVVA (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:00 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 1/9] usbip: fix stub_rx: get_pipe() to validate endpoint number
Date: Wed,  7 Feb 2018 14:20:24 -0700
Message-Id: <a1d652ff56993bc179aa295894b32bb040a11ebc.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream commit 635f545a7e8b ("usbip: fix stub_rx: get_pipe() to
validate endpoint number")

get_pipe() routine doesn't validate the input endpoint number
and uses to reference ep_in and ep_out arrays. Invalid endpoint
number can trigger BUG(). Range check the epnum and returning
error instead of calling BUG().

Change caller stub_recv_cmd_submit() to handle the get_pipe()
error return.

Reported-by: Secunia Research <vuln@secunia.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/stub_rx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 00e475c51a12..2e07acda456e 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -347,15 +347,15 @@ static int get_pipe(struct stub_device *sdev, int epnum, int dir)
 	struct usb_host_endpoint *ep;
 	struct usb_endpoint_descriptor *epd = NULL;
 
+	if (epnum < 0 || epnum > 15)
+		goto err_ret;
+
 	if (dir == USBIP_DIR_IN)
 		ep = udev->ep_in[epnum & 0x7f];
 	else
 		ep = udev->ep_out[epnum & 0x7f];
-	if (!ep) {
-		dev_err(&sdev->interface->dev, "no such endpoint?, %d\n",
-			epnum);
-		BUG();
-	}
+	if (!ep)
+		goto err_ret;
 
 	epd = &ep->desc;
 	if (usb_endpoint_xfer_control(epd)) {
@@ -386,9 +386,10 @@ static int get_pipe(struct stub_device *sdev, int epnum, int dir)
 			return usb_rcvisocpipe(udev, epnum);
 	}
 
+err_ret:
 	/* NOT REACHED */
 	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
-	return 0;
+	return -1;
 }
 
 static void masking_bogus_flags(struct urb *urb)
@@ -454,6 +455,9 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	struct usb_device *udev = sdev->udev;
 	int pipe = get_pipe(sdev, pdu->base.ep, pdu->base.direction);
 
+	if (pipe == -1)
+		return;
+
 	priv = stub_priv_alloc(sdev, pdu);
 	if (!priv)
 		return;
-- 
2.14.1

