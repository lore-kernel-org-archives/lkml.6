Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834694-2-15500705425686363431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834693; b=FOdIIfq7jbvN0Wr5nuepDa1ftUPPet6sUS94TcaWeYg8g3n
    6cndEQMY4/OKNkVzf06VF1MiwP4RaTiGT+icxysSPqf5yt8YwXY2WAPMXeELvP8C
    1cA9IT91O7E+2l1Qs4XsOlgQQPedg3uK/M2uBcrYwbxzlztvxRWwrl66VLTP6zqc
    vltPmESuGhEKmHzT6LLR1YaE+K3+l1RREAUjCPTLttaLHmm9no97CaWhMpflzroF
    cG3++DOq1gGBlCo8hCC+MqIzuWz8o1RGiI7VFW5Whe4jClRKpWyJOSkteg26PQSn
    kjHKSRUkAPTi5HSzwYzhA10WTGeB4W7q4kH26rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834693; bh=ADub11FcIHRWuduI8qk
    MlcM9upfj/qasiGZn5zj0jUo=; b=kKJkJu22t+55AzP11zfZwBGe2Zs9sLrNJT1
    +OrVRbD/NiLe3yHaZ1tPa2KKHkRhQY70V7/A1D9K7n9HZiN64CeajZqvjZwkSgrf
    fLKKgfBGV3whRD5o8XyzxVhcNQjBUVmoccgTpMv5ZXrC+Fj5V8gUVCS8kU+C/YLG
    8Ef32iRr19NQioDgy6/mrOxDkil6Lh6R9UagqWovfDtVW0tthbLdacy2T4YYSieA
    uEDQwnqf0aM9ILA3J2Xf0Xu+UxwN4lZlr+X671WaGBq46JQfwSNK1qUesXZaFldu
    hG3QEpyKiYr4Dt/VafDg6CuUJ7WuSiuwX9e5YnKzqAF8Me49Fbw==
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
        id S935065AbeB1QSM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:18:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35293 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935084AbeB1QSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:18:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.833267293@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 192/254] USB: Gadget core: fix inconsistency in the
 interface tousb_add_gadget_udc_release()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit afd7fd81f22bf90474216515dbd6088f9bd70343 upstream.

The usb_add_gadget_udc_release() routine in the USB gadget core will
sometimes but not always call the gadget's release function when an
error occurs.  More specifically, if the struct usb_udc allocation
fails then the release function is not called, and for other errors it
is.

As a result, users of this routine cannot know whether they need to
deallocate the memory containing the gadget structure following an
error.  This leads to unavoidable memory leaks or double frees.

This patch fixes the problem by splitting the existing
device_register() call into device_initialize() and device_add(), and
doing the udc allocation in between.  That way, even if the allocation
fails it is still possible to call device_del(), and so the release
function will be always called following an error.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/udc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -192,6 +192,7 @@ static void usb_udc_nop_release(struct d
  * @release: a gadget release function.
  *
  * Returns zero on success, negative errno otherwise.
+ * Calls the gadget release function in the latter case.
  */
 int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
@@ -199,10 +200,6 @@ int usb_add_gadget_udc_release(struct de
 	struct usb_udc		*udc;
 	int			ret = -ENOMEM;
 
-	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
-	if (!udc)
-		goto err1;
-
 	dev_set_name(&gadget->dev, "gadget");
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
@@ -218,7 +215,13 @@ int usb_add_gadget_udc_release(struct de
 	else
 		gadget->dev.release = usb_udc_nop_release;
 
-	ret = device_register(&gadget->dev);
+	device_initialize(&gadget->dev);
+
+	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
+	if (!udc)
+		goto err1;
+
+	ret = device_add(&gadget->dev);
 	if (ret)
 		goto err2;
 
@@ -255,10 +258,10 @@ err3:
 	device_del(&gadget->dev);
 
 err2:
-	put_device(&gadget->dev);
 	kfree(udc);
 
 err1:
+	put_device(&gadget->dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
