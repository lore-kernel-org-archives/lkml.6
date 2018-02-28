Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833231-2-6739950347365203421
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
    t=1519833231; b=rV7Ui3M5fBFrcd2iogvAIXIdDS6Hffh2l5YFNw9Z77Hom0z
    La3o605mCdhMBVZZQIJHgzGlbFylvLt9zLKmPOYisWJZRh+T1wrom7El9tXRyZEG
    BoqZcZFxJOtSbq6+x3mWBlXn0Atdc7z0vPjz+8bKSwbbromm/DkUQ9PkScxPtkuq
    sfIwUX334WlzT2MCHFiIGSlzKsdUrvn6T6YawJ6dj33qS2ZRgnEebmI+JhzlgLq4
    /FA4Wf2Rnrt4yuKi+PX8Qd7MNVJmSEXw2Zpmz+0DKQoZCDMcZ/ShAQh8M8PGXxwx
    r/JK87Fm02lC8jYYtXA5f4EJDMb8HBI36AsQc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833231; bh=MOFL4Nj8ENYUMR9+0g2
    RqeVMuBCkucSJ7D+Ys4SNTao=; b=sSHOd78f0I7mpYuKSqhf+gB1jgw7GU5xLKC
    GDWVT72bxS9+paLbRYJqkqMTdpTUTbQgqklBAdRIVjX4h+vimoy+VxtU2ZQZd8WO
    Wc9WrFtQ4/vlXKKj2pZg5Hd0iMXgpGSQ7Adb+dgX+kb7SB/NKX0nRd+NrR87vv/e
    mN4p9XoXrD9jgDeDKA/ZVu94p2whVgCrDqyrY6wqS0pjEhz2cCE/j2lgafuV/H5f
    lYXf29mOGhSptbGbLf2/MSdCcqvkR6woVgfY6RBZPd6/LWXCnREZTiAG76RPr/r7
    8jYaQt3jEo7FRP1E8lJfAdT69nUkQhoihGzWasSZk59NWg5+LzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeB1Pxh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:53:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34461 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934041AbeB1Pxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Peter Chen" <peter.chen@nxp.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Fengguang Wu" <fengguang.wu@intel.com>,
        "Alan Stern" <stern@rowland.harvard.edu>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.377637808@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 193/254] USB: UDC core: fix double-free in
 usb_add_gadget_udc_release
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

commit 7ae2c3c280db183ca9ada2675c34ec2f7378abfa upstream.

The error-handling pathways in usb_add_gadget_udc_release() are messed
up.  Aside from the uninformative statement labels, they can deallocate
the udc structure after calling put_device(), which is a double-free.
This was observed by KASAN in automatic testing.

This patch cleans up the routine.  It preserves the requirement that
when any failure occurs, we call put_device(&gadget->dev).

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - The err5 path is not presnet
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -219,11 +219,7 @@ int usb_add_gadget_udc_release(struct de
 
 	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
 	if (!udc)
-		goto err1;
-
-	ret = device_add(&gadget->dev);
-	if (ret)
-		goto err2;
+		goto err_put_gadget;
 
 	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
@@ -232,7 +228,11 @@ int usb_add_gadget_udc_release(struct de
 	udc->dev.parent = parent;
 	ret = dev_set_name(&udc->dev, "%s", kobject_name(&parent->kobj));
 	if (ret)
-		goto err3;
+		goto err_put_udc;
+
+	ret = device_add(&gadget->dev);
+	if (ret)
+		goto err_put_udc;
 
 	udc->gadget = gadget;
 
@@ -241,7 +241,7 @@ int usb_add_gadget_udc_release(struct de
 
 	ret = device_add(&udc->dev);
 	if (ret)
-		goto err4;
+		goto err_unlist_udc;
 
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
 
@@ -249,18 +249,16 @@ int usb_add_gadget_udc_release(struct de
 
 	return 0;
 
-err4:
+ err_unlist_udc:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
 
-err3:
-	put_device(&udc->dev);
 	device_del(&gadget->dev);
 
-err2:
-	kfree(udc);
+ err_put_udc:
+	put_device(&udc->dev);
 
-err1:
+ err_put_gadget:
 	put_device(&gadget->dev);
 	return ret;
 }
