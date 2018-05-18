Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4043076-1526654405-2-2861103374354728275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526654405; b=kGIJCMYO9LjVyug+aZS6kY5UloWzP6w9wevLHPbVBjR4FQEmEK
    kPQ45AEVHLpPi1Wah/YGyQMDNhEiwo7SeGJtVs8Kvg1o5iqZuQLnRyv2ts/Nc6cG
    PV3h3OpOIJXijheFASylLL+aznustVHej9EgKqU5qi4Kox2zJYDwjyG0a81QaEMx
    AD8t1DUCwxZymUaqDNByYDJpdMwn/EuzBSBDN6fy23/VLNO4u+rye+Z5cA3K40IK
    1fY0SM0EUQzM2nI7h4MG6MRrpSWsI6iLr+oUb4cWoyoYwRKceUcSX0PTG1qlTs7u
    v+Vt0OCb4MKulLfv9dgPpVRx0RTio+xrqyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526654405; bh=cevUjDe9AoYERfJZqd6iP3Y7ihFcBw
    HUbqp2wW5FWoA=; b=BrxE6eRRFnhwdMKxyIwr9dU86ribgn5j7uoH2M5e9LKcAv
    Au1STPvhjAGpTWvGwx7Uskx1JtYhePplBZo1yv84sSSfwtvKjocHxlUCtC8ICC/p
    bD0jQ/St+ZjXfsXLVCe8Osvtt67suNXoRTrebZMfRawcZao8xZT9Q/iMz0p+34Er
    AhADiOfFujC4azXIskNJxrjrC1U0wtOj2bfM0M7et81qj2d12Koi5kf3CefoJ9Zx
    j4vGWDn6QmOlhlUpP3ev03E8Q5NoW6brLoIrDUbUorsHbHfRsF6xseL5leLybsRH
    Bu8V/XkDqgBAbcj2UoxdbOYy9JK5+ef1ztUmFiZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1sTTIK40yiFkLYr263T9wEpfc02BxmgdnZoKG3SZ1A8PER+GJGOYr3USxm0cZWBRlr54Re/zqL4YtiFKMP0ICpo0Uu1gGHehCKgrPUNd9V4xiAGusx
    67yKKkClusVoZWgVtcpZ92Mgj0TFCZh+hm2Rbny0b2JVnxRAlMUOOB6+s56KV0HR5rPbzKmxWcQyB/NiljkqvEcXDmtSAaXxHlCdwdIsOKzE2OOnFh2fxkA5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=zXbXmIYIJ9qrXssQYkUA:9 a=wvqD8I6suE4SRPV7:21
    a=Ca_qimNc0m0JJ-xh:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeEROkD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 10:40:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeEROkA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 10:40:00 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] usbip: dynamically allocate idev by nports found in sysfs
Date: Fri, 18 May 2018 16:39:47 +0200
Message-Id: <20180518143947.27963-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.17.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the amount of available ports varies by the kernels build
configuration. To remove the limitation of the fixed 128 ports
we allocate the amount of idevs by using the number we get
from the kernel.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 11 ++++++++---
 tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index c9c81614a66ad..9a8acfc7697fa 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -266,11 +266,11 @@ int usbip_vhci_driver_open(void)
 	if (vhci_driver->nports <= 0) {
 		err("no available ports");
 		goto err;
-	} else if (vhci_driver->nports > MAXNPORT) {
-		err("port number exceeds %d", MAXNPORT);
-		goto err;
 	}
 
+	vhci_driver->idev = calloc(vhci_driver->nports,
+			sizeof(struct usbip_imported_device));
+
 	vhci_driver->ncontrollers = get_ncontrollers();
 	dbg("available controllers: %d", vhci_driver->ncontrollers);
 
@@ -287,6 +287,9 @@ int usbip_vhci_driver_open(void)
 err:
 	udev_device_unref(vhci_driver->hc_device);
 
+	if (vhci_driver->idev)
+		free(vhci_driver->idev);
+
 	if (vhci_driver)
 		free(vhci_driver);
 
@@ -305,6 +308,8 @@ void usbip_vhci_driver_close(void)
 
 	udev_device_unref(vhci_driver->hc_device);
 
+	free(vhci_driver->idev);
+
 	free(vhci_driver);
 
 	vhci_driver = NULL;
diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
index 418b404d51210..67dbd1551e159 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.h
+++ b/tools/usb/usbip/libsrc/vhci_driver.h
@@ -13,7 +13,6 @@
 
 #define USBIP_VHCI_BUS_TYPE "platform"
 #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
-#define MAXNPORT 128
 
 enum hub_speed {
 	HUB_SPEED_HIGH = 0,
@@ -41,7 +40,7 @@ struct usbip_vhci_driver {
 
 	int ncontrollers;
 	int nports;
-	struct usbip_imported_device idev[MAXNPORT];
+	struct usbip_imported_device *idev;
 };
 
 
-- 
2.17.0

