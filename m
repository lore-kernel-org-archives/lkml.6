Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802646-2-3866200839829614768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802645; b=L1Ysi6m6IwgOgAwKwEdgl4zf3ejKy2iekK3dljm9aXuqY8U
    YM6mpQ0EdxlIPqHHJaynfeLFiUaG3cqYdepRc9jZNxgDRrJWMRe3hngFftnTovhR
    OwOzHDlPc3JebImIsAT5vwX+34rKdg+kwxla0AyHR1BxXi1lc7ha8GWtZmX5Is3g
    68oz+wLFgGho7S/mJbvhFKyN5wEr7OakZms7Uwgyfqugbiq0y0b4U3NXbVIm9Ugn
    TxjHq4k/RKLEAlNtoWYjHFedNctiTHs3hCSlqRJ7Go9M5Jd7uYZq2yGqh0Lzu/TY
    EL55aVCW4h2mPHzE1r7jsj2E5XInKm403fKls/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802645; bh=1oykN3+bx7Cxnr49IWr8qHUDir
    abb2G/wH9030MPomU=; b=Cjj/bMLw7bfkJFU8jVLAdOcR1Fwvi8Yt7rHkiF5ufv
    9r5HI7tRzMT+T1TNF2ROO5Ykbst6Q6dEqq26UbbZs0PhOBPBYKfQj871pjj9HvQd
    TxrG7hgDhCi/zBbc46DUCra6O7A+WCQmspHqjniyLqbkcRnTN3jKWG7Pw0BnWe+c
    GdiDppcWQtWbZuzHDtKdU0IGICYTM2PDkJJWROnlAWHu0UIJcJDRXF8EXZtjkFi6
    i0G2tmkudXgT5HG2FOIKiUywQKkdeoLwYud+F2NZ5Ae26JTO5Q9pRjuGb0vEkK7s
    trYTV9eptUHl1yCPu1CARHyIf+Qs8iw4vLd07g97Jx5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCWKMy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeCWKMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 177/177] usb: gadget: f_hid: fix: Move IN request allocation to set_alt()
Date: Fri, 23 Mar 2018 10:55:05 +0100
Message-Id: <20180323094212.941020542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Opasiak <kopasiak90@gmail.com>

commit 749494b6bdbbaf0899aa1c62a1ad74cd747bce47 upstream.

Since commit: ba1582f22231 ("usb: gadget: f_hid: use alloc_ep_req()")
we cannot allocate any requests in bind() as we check if we should
align request buffer based on endpoint descriptor which is assigned
in set_alt().

Allocating request in bind() function causes a NULL pointer
dereference.

This commit moves allocation of IN request from bind() to set_alt()
to prevent this issue.

Fixes: ba1582f22231 ("usb: gadget: f_hid: use alloc_ep_req()")
Cc: stable@vger.kernel.org
Tested-by: David Lechner <david@lechnology.com>
Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_hid.c |   89 +++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 22 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -284,6 +284,7 @@ static ssize_t f_hidg_write(struct file
 			    size_t count, loff_t *offp)
 {
 	struct f_hidg *hidg  = file->private_data;
+	struct usb_request *req;
 	unsigned long flags;
 	ssize_t status = -ENOMEM;
 
@@ -293,7 +294,7 @@ static ssize_t f_hidg_write(struct file
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 
 #define WRITE_COND (!hidg->write_pending)
-
+try_again:
 	/* write queue */
 	while (!WRITE_COND) {
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
@@ -308,6 +309,7 @@ static ssize_t f_hidg_write(struct file
 	}
 
 	hidg->write_pending = 1;
+	req = hidg->req;
 	count  = min_t(unsigned, count, hidg->report_length);
 
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
@@ -320,24 +322,38 @@ static ssize_t f_hidg_write(struct file
 		goto release_write_pending;
 	}
 
-	hidg->req->status   = 0;
-	hidg->req->zero     = 0;
-	hidg->req->length   = count;
-	hidg->req->complete = f_hidg_req_complete;
-	hidg->req->context  = hidg;
+	spin_lock_irqsave(&hidg->write_spinlock, flags);
+
+	/* we our function has been disabled by host */
+	if (!hidg->req) {
+		free_ep_req(hidg->in_ep, hidg->req);
+		/*
+		 * TODO
+		 * Should we fail with error here?
+		 */
+		goto try_again;
+	}
+
+	req->status   = 0;
+	req->zero     = 0;
+	req->length   = count;
+	req->complete = f_hidg_req_complete;
+	req->context  = hidg;
 
 	status = usb_ep_queue(hidg->in_ep, hidg->req, GFP_ATOMIC);
 	if (status < 0) {
 		ERROR(hidg->func.config->cdev,
 			"usb_ep_queue error on int endpoint %zd\n", status);
-		goto release_write_pending;
+		goto release_write_pending_unlocked;
 	} else {
 		status = count;
 	}
+	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 
 	return status;
 release_write_pending:
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
+release_write_pending_unlocked:
 	hidg->write_pending = 0;
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 
@@ -541,12 +557,23 @@ static void hidg_disable(struct usb_func
 		kfree(list);
 	}
 	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
+
+	spin_lock_irqsave(&hidg->write_spinlock, flags);
+	if (!hidg->write_pending) {
+		free_ep_req(hidg->in_ep, hidg->req);
+		hidg->write_pending = 1;
+	}
+
+	hidg->req = NULL;
+	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 }
 
 static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 {
 	struct usb_composite_dev		*cdev = f->config->cdev;
 	struct f_hidg				*hidg = func_to_hidg(f);
+	struct usb_request			*req_in = NULL;
+	unsigned long				flags;
 	int i, status = 0;
 
 	VDBG(cdev, "hidg_set_alt intf:%d alt:%d\n", intf, alt);
@@ -567,6 +594,12 @@ static int hidg_set_alt(struct usb_funct
 			goto fail;
 		}
 		hidg->in_ep->driver_data = hidg;
+
+		req_in = hidg_alloc_ep_req(hidg->in_ep, hidg->report_length);
+		if (!req_in) {
+			status = -ENOMEM;
+			goto disable_ep_in;
+		}
 	}
 
 
@@ -578,12 +611,12 @@ static int hidg_set_alt(struct usb_funct
 					    hidg->out_ep);
 		if (status) {
 			ERROR(cdev, "config_ep_by_speed FAILED!\n");
-			goto fail;
+			goto free_req_in;
 		}
 		status = usb_ep_enable(hidg->out_ep);
 		if (status < 0) {
 			ERROR(cdev, "Enable OUT endpoint FAILED!\n");
-			goto fail;
+			goto free_req_in;
 		}
 		hidg->out_ep->driver_data = hidg;
 
@@ -599,17 +632,37 @@ static int hidg_set_alt(struct usb_funct
 				req->context  = hidg;
 				status = usb_ep_queue(hidg->out_ep, req,
 						      GFP_ATOMIC);
-				if (status)
+				if (status) {
 					ERROR(cdev, "%s queue req --> %d\n",
 						hidg->out_ep->name, status);
+					free_ep_req(hidg->out_ep, req);
+				}
 			} else {
-				usb_ep_disable(hidg->out_ep);
 				status = -ENOMEM;
-				goto fail;
+				goto disable_out_ep;
 			}
 		}
 	}
 
+	if (hidg->in_ep != NULL) {
+		spin_lock_irqsave(&hidg->write_spinlock, flags);
+		hidg->req = req_in;
+		hidg->write_pending = 0;
+		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
+
+		wake_up(&hidg->write_queue);
+	}
+	return 0;
+disable_out_ep:
+	usb_ep_disable(hidg->out_ep);
+free_req_in:
+	if (req_in)
+		free_ep_req(hidg->in_ep, req_in);
+
+disable_ep_in:
+	if (hidg->in_ep)
+		usb_ep_disable(hidg->in_ep);
+
 fail:
 	return status;
 }
@@ -658,12 +711,6 @@ static int hidg_bind(struct usb_configur
 		goto fail;
 	hidg->out_ep = ep;
 
-	/* preallocate request and buffer */
-	status = -ENOMEM;
-	hidg->req = alloc_ep_req(hidg->in_ep, hidg->report_length);
-	if (!hidg->req)
-		goto fail;
-
 	/* set descriptor dynamic values */
 	hidg_interface_desc.bInterfaceSubClass = hidg->bInterfaceSubClass;
 	hidg_interface_desc.bInterfaceProtocol = hidg->bInterfaceProtocol;
@@ -690,6 +737,8 @@ static int hidg_bind(struct usb_configur
 		goto fail;
 
 	spin_lock_init(&hidg->write_spinlock);
+	hidg->write_pending = 1;
+	hidg->req = NULL;
 	spin_lock_init(&hidg->read_spinlock);
 	init_waitqueue_head(&hidg->write_queue);
 	init_waitqueue_head(&hidg->read_queue);
@@ -954,10 +1003,6 @@ static void hidg_unbind(struct usb_confi
 	device_destroy(hidg_class, MKDEV(major, hidg->minor));
 	cdev_del(&hidg->cdev);
 
-	/* disable/free request and end point */
-	usb_ep_disable(hidg->in_ep);
-	free_ep_req(hidg->in_ep, hidg->req);
-
 	usb_free_all_descriptors(f);
 }
 
