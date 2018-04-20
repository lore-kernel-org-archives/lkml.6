Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524248308-2-7486813177624618457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248308; b=TGVufy93kGQsu100/4iL/HGW2gxZTUtBM+3L8zJWfHNfIdOK6P
    Z7Yu0hLR7nCK4B63WlZZTPH4IRyRyYpoHMXHHkbiPaa5/wmFEssp+c9I8L2qVy62
    083zLglTxN6SzRIouqF1qN5i8pH6uJY7Q1lM8W+SgBYq6CcxbLTQOtCCxTbTPiLm
    8WvmbP4RCsJ9oZwQEog3rkivGbVqdH91DpJpqAPJ0aFZSKNig+tIE1fTcdeTO7oW
    whGTd+mZi2n3nYPFAdPGH5CVKCwBtMWknQ5TXuKD6aPGL2eQ/6pylgvbG85w81SO
    CHazVWHlBZuYr+HC5+uNGh7G9/RN0UZQy2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524248308; bh=FLUkdZVh7gFWYW247XCVS+eQEx055Z
    baghoy6MYFS6U=; b=Rz3BEFwdmJiu/SakSx23cZX3UB5nmu2b7/faYJui2cR7lX
    6EbwEkhxrriAY5kq9gmBxZf6gvnRCI8ieiPDtZDCLc33A0y16VDCdm8Xdt3nJ8US
    UKmkgGjrFiuw3y/ZwzgPpJQzg82N9jVuMfvbYwTtxaHgbVCg9eTEK732PhZqq52U
    ReNuwEu7fXrag98NJj9+0/nlJqjds5I5CiXje2IQksfwKQOlfXll5f5Mph+cMPYl
    Fyhf5sy0n390TrZcE0pVl1DVMLMs+HHcSrS72GIecsCLAclmdaSzqcU605BpBSsm
    q5QTSSCK442V9rilJuf7acbq1kNREX1friYrKT/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCRtTJFsvGeRYyqePiJ2fFdwa9cWu8sCv0ws4HYBl7CMMWb3dzbQrq/tvGB80A0bZgwiG/vpi/QSBKwuOh0l1mDYF22SeGlvAu9vluJnC78VS0NAOyzG
    x0hn8r9KKI8WxpYHbHzCyEQI3mE5HJiGQ8wnvX+LfCb6XwzbgA/uGjVYrxiQ9dkCyUfxYgNa6Z4cLkJWbw7QkT3z19SH9iFrKrKwpcdagB66rstJSeecDf6Z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Q-4c6UVMsrHsJDKVwNsA:9
    a=43IbhxzjDrTT3YjD:21 a=03wwk8rpr2arxOIm:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeDTSSL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:18:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753566AbeDTSSH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:07 -0400
Date: Fri, 20 Apr 2018 21:18:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6/6] virtio_console: reset on out of memory
Message-ID: <1524248223-393618-7-git-send-email-mst@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When out of memory and we can't add ctrl vq buffers,
probe fails. Unfortunately the error handling is
out of spec: it calls del_vqs without bothering
to reset the device first.

To fix, call the full cleanup function in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e8480fe..2108551 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2090,6 +2090,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
 
 	virtio_device_ready(portdev->vdev);
 
@@ -2107,8 +2108,15 @@ static int virtcons_probe(struct virtio_device *vdev)
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2139,11 +2147,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
-- 
MST
