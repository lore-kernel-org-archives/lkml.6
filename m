Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3899735-1522967376-2-14117764907204740068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522967375; b=p3Q7QGXGQOzsSiksAUlkxcXwA8KgY6celzZlRUeevC9SiCgwcl
    yUU99E1G1MOuS4lf9rDjnsUFZWsVysur4olXNknEY3qTRpTZFhDJWYki1vf5uhej
    uVh/P58Bkx4ssKCEVd+uUxt/yNaQaLtgiM8W46nEINN6nWXNUSkiVFghed4Xr3o7
    TRBh0C1XYXUpENBX8UmdpfKI/D+bl7Hg4t27bxFP14sl3Ype2srxhcCb+fwYjscR
    fUbzZarwIZ4uYf/ctZUYE8vt5KJhv+5nD8uQDV/EVNrkSXWryo5VjLVI2uZUmmeE
    jMc6RN+yjOsFf+9EzsJF7Af15aDblVcMx5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522967375; bh=vDytTWr123XOLBZeicwnjcqZdHHvyu
    fEzTfNqEHrO2w=; b=eHRlHuILoHvDtekw321+ytnT2l1KCH7QAFZh87ZIxX9fpx
    0+M+yQwIeAW3cA2lnUSsm8MoYu6SQJEZFqMPIQP/KIV79e3ARDDx9e7y7ox78Bu/
    mGnYeeLwnzOumdPNtuIeZpVBx4ku9XghtTPQ6jOIjimYnhPChJ+rXAHZNybujQFP
    TJ6CwDknh/pXUHlAmnAEvaYNiYy4Y+/XJdnUaGevOb94Cte4k7AXXRyGQvfmc2ua
    XFnePybSI++xbBmGa2ux1HoO17TU1sFi6pv+dADKZW+ol5uD4kJTg4OBOiwogMJg
    vDgghGWenN5nX5YTWC4ds+HIfhkzvm4tYG5zbkNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNsiX7piUC2mhJ7jeLt7OLNK4kMK95BG+XLsMaUxdVaxaIEjx3AL+Fy8iMYaj1Rf+XNUp6NIxlty3k3klmLEziqzDgi5wIIQSvXMU6+EhdzqK+BWnqtc
    qWt7jomYhRUsnuBHJlklO5J+VWZjaWH6JoVCTBtUtpoH7QCweM2AIplnCVWk9qknJON/ZfB9cDYYj6gGFrK5VA571RHDdiQ/q4aHOHdseVNrucIc+hRzPVhB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=KVfWH9hK4CAa1KCswkwA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeDEW3a (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 18:29:30 -0400
Received: from osg.samsung.com ([64.30.133.232]:40965 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeDEW33 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 5 Apr 2018 18:29:29 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: [PATCH] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Thu,  5 Apr 2018 16:29:04 -0600
Message-Id: <20180405222904.24420-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

usbip_host calls device_attach() without holding dev->parent lock.
Fix it.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/usbip/stub_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index c31c8402a0c5..d41d0cdeec0f 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -186,7 +186,12 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	if (!bid)
 		return -ENODEV;
 
+	/* device_attach() callers should hold parent lock for USB */
+	if (bid->udev->dev.parent)
+		device_lock(bid->udev->dev.parent);
 	ret = device_attach(&bid->udev->dev);
+	if (bid->udev->dev.parent)
+		device_unlock(bid->udev->dev.parent);
 	if (ret < 0) {
 		dev_err(&bid->udev->dev, "rebind failed\n");
 		return ret;
-- 
2.14.1

