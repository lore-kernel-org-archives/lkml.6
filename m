Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163978-2-10844424243704578230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163977; b=QiO75rOuud29hriYkflyFnEpl9ZJgZFuBvCaFf4s9kb25cno/6
    izuz0oFVULP1pzfN1Fd7jGNDel9GH5pbX/uNg2vW7D/2ps+MMjyN9m4+X2vk4tqv
    3JAUI4KLkiQzJ2Ywsk84uLPzDev65VUsJ/a8LB3jLf+IMibbpmYscHQLcAdTGrFg
    znzbESNj9GIYnhYNtCTnOTuMU3nKQmfCnh8KX8NBv8Gs6jcJFtZKCKSBfIRM5iQD
    fg+rFsK16lvvzY5ziIOE8066xkiax1EA402abQZfXoONeKK+H2yxBV6pd19v+wG0
    A7lXlrFwHnZqJ4oMfq9ObQSO7S1njfsc09SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163977; bh=kq7DSAL813vpB18SHm0L/zMCIfQZB7
    R7vnd5F/XDtAA=; b=W+Qx4ow/GyjERY5Jy7PRk5AtJRduuAoZYA7BT+st1Sz225
    fxqRqKMpM260gNIYOa4phQ8/YaGMJ94gRn01IMMcCfDke/0ncmrNNQ8twJoxU3JP
    Tip0lREPdd+8uw/p2cG9ZTpYD1hI+3JPw0tdHd2qDT1HAEEZQt9a6NSbXIYvjmKK
    vMkmJ9wbprXqzIMg5Ro+SyGWC3KBoZIvlXF+WYkTbaSwvw101r4OWEzXZxaP9f81
    PQRfnL814tiZuFXS6fnI3TaPota5X5msEOxDJY85bT2WleqZiG5fZP61jmwzZCqU
    pLsk1+S98JTOlAnCxbP82/smOV98AJpR57x54XuA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Y7QVgXnD x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Y7QVgXnD x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIaBhYl3G028wq6ySP59BF/2mwVK/C+vqB23W7ScyAnNiHomFIA8jbfcuQxVGdK+cwTDKKaFW1Lrhs8ntw/Xk2N2F9Y6+N9foplHi3FdGCHKTSj38gSv
    CvdYzY6OVZJWBRpASVDLIwdcFBsk0NPv7qD5HlUyBGyi0GT31ylRRFIyYjGZZdcGnHahSJJ94vW3vU1F563B8eHgWDPHtWZ6CEPB9A/yi1rQgEQgD0YHAb3Z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=HH5vDtPzAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=HDZgohCq0teiLl5bA54A:9 a=7yXiT-G5OU7Rgjv_:21 a=jKwdX-kLtlCO2ZG6:21
    a=QEXdDO2ut3YA:10 a=L4vkcYpMSA5nFlNZ2tk3:22 a=QM_-zKB-Ew0MsOlNKMB5:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeEXMMy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966387AbeEXJmr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Valentina Manea <valentina.manea.m@gmail.com>
Subject: [PATCH 3.18 26/45] usbip: fix error handling in stub_probe()
Date: Thu, 24 May 2018 11:38:34 +0200
Message-Id: <20180524093123.951287727@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit 3ff67445750a84de67faaf52c6e1895cb09f2c56 upstream.

If usb_hub_claim_port() fails, no resources are deallocated and
if stub_add_files() fails, port is not released.

The patch fixes these issues and rearranges error handling code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Valentina Manea <valentina.manea.m@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -313,7 +313,6 @@ static int stub_probe(struct usb_device
 {
 	struct stub_device *sdev = NULL;
 	const char *udev_busid = dev_name(&udev->dev);
-	int err = 0;
 	struct bus_id_priv *busid_priv;
 	int rc;
 
@@ -374,23 +373,28 @@ static int stub_probe(struct usb_device
 			(struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to claim port\n");
-		return rc;
+		goto err_port;
 	}
 
-	err = stub_add_files(&udev->dev);
-	if (err) {
+	rc = stub_add_files(&udev->dev);
+	if (rc) {
 		dev_err(&udev->dev, "stub_add_files for %s\n", udev_busid);
-		dev_set_drvdata(&udev->dev, NULL);
-		usb_put_dev(udev);
-		kthread_stop_put(sdev->ud.eh);
-
-		busid_priv->sdev = NULL;
-		stub_device_free(sdev);
-		return err;
+		goto err_files;
 	}
 	busid_priv->status = STUB_BUSID_ALLOC;
 
 	return 0;
+err_files:
+	usb_hub_release_port(udev->parent, udev->portnum,
+			     (struct usb_dev_state *) udev);
+err_port:
+	dev_set_drvdata(&udev->dev, NULL);
+	usb_put_dev(udev);
+	kthread_stop_put(sdev->ud.eh);
+
+	busid_priv->sdev = NULL;
+	stub_device_free(sdev);
+	return rc;
 }
 
 static void shutdown_busid(struct bus_id_priv *busid_priv)
