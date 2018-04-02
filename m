Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3868303-1522702407-2-11055583552365949121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522702406; b=V5BYz45Q+9Kx8rAms4ftHqO+IJBtXMb8vKp+jNDnKjLwgvVAvj
    t7oHve8fPUFnfkfWoYzAfzOZLhjBEkQX4+7J/aH9mDZYXC1Exrw4TNxqd8oH0XDP
    d42Mo6Jj0KkVBralI350q/CUIqe9gAaLEzbMrnzWrpIE0/5IZm1U5gf1dOQudNoM
    Z+8dI3rmmTYMQ/c9Qp6LqVpSCTtMI0zXMOPnM/SVJSCA6mY3C4GnxylUCAaQ+J7o
    Z2/r6HpyjwLynW9Aivq5+g/+d0D3A0UGExNLUScDm91vDVfD+XeJcyYECbWO4G0w
    zPmxVENzIuZRsFlC/WvveqRdO7td9GlhDIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522702406; bh=3sYIKjFsuB9riZcAzduam/4KOcRT9S
    jWkF6mSrKcLO8=; b=UDTRZGflhbNy/zsc23RIipOQWsKBff0SxYD2RmeKIAAtHP
    UcAzz239tOnfUG9eQ7YM/E5jBS+dxXE9wjUutjbxfH3N7Pfs4x3jxcKx0IPVGIta
    6kp4jaNZvanOTqTKH5WV0s0kdnloikym6jbZONWRwi5G44gIhmg9FaSpcEwl2Nl2
    GCeWmYSpOdG0VHfDcyOpG3Z6bcSK24ztM0CQZF0vqgIb4cmyUvSspxkZitMjocfs
    tjU8PY4YzWkKBZQpM8AjVBK6ZZ5As6OdZt8fB1RRRHc8mX89/teU+IswKp7wrX2j
    XLHTKUVWyVgeAkH/vcPDp551gMwfdKWpJm96GlmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGkKAywF7clzQPDVVeOroUipJPgm3ZBKu0uhVKcrneo4mVJmYMbn3l6L2J07sR3fPJtAFcaQx74L1/iV6mM/8UoanujTSgNhUUq/2IPHtxbQPA5Ffh6x
    tNhaH2dL8ikzrLgT3RahzgTn+kakzCvXN5ZML29mLjk312oGrXDzPy8lExqjIsbklkxDnHlJtD6x8CzUzCpyCPG59zlLoQHPBxL0yoUnuI5L4uqihkVAlFIR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=FFYhhLelPInG-3jlFf4A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeDBUw4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 16:52:56 -0400
Received: from osg.samsung.com ([64.30.133.232]:41937 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753109AbeDBUw4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 2 Apr 2018 16:52:56 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vhc_hcd: prevent module being removed while device are attached
Date: Mon,  2 Apr 2018 14:52:31 -0600
Message-Id: <20180402205232.21659-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vhci_hcd module can be removed even when devices are attached. Fix to
prevent module removal when devices are still attached.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/vhci_sysfs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 48808388ec33..6a54b9aa92be 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/net.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "usbip_common.h"
 #include "vhci.h"
@@ -252,6 +253,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return -EINVAL;
 
+	module_put(THIS_MODULE);
+
 	usbip_dbg_vhci_sysfs("Leave\n");
 
 	return count;
@@ -302,7 +305,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	struct vhci_hcd *vhci_hcd;
 	struct vhci_device *vdev;
 	struct vhci *vhci;
-	int err;
+	int err, ret;
 	unsigned long flags;
 
 	/*
@@ -339,10 +342,18 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	else
 		vdev = &vhci->vhci_hcd_hs->vdev[rhport];
 
+	/* get module ref to avoid being removed with active attached devs */
+	if (!try_module_get(THIS_MODULE)) {
+		ret = -EAGAIN;
+		goto module_get_err;
+	}
+
 	/* Extract socket from fd. */
 	socket = sockfd_lookup(sockfd, &err);
-	if (!socket)
-		return -EINVAL;
+	if (!socket) {
+		ret = -EINVAL;
+		goto error;
+	}
 
 	/* now need lock until setting vdev status as used */
 
@@ -362,7 +373,8 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 		 * Will be retried from userspace
 		 * if there's another free port.
 		 */
-		return -EBUSY;
+		ret = -EBUSY;
+		goto error;
 	}
 
 	dev_info(dev, "pdev(%u) rhport(%u) sockfd(%d)\n",
@@ -386,6 +398,11 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	rh_port_connect(vdev, speed);
 
 	return count;
+
+error:
+	module_put(THIS_MODULE);
+module_get_err:
+	return ret;
 }
 static DEVICE_ATTR_WO(attach);
 
-- 
2.14.1

