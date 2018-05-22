Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2845700-1527008687-2-5807555016124663982
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
    1527008686; b=Cfse65aXwALEyEjEVY8YWYAfo9Gxd0r4lVcF0BQXfJnHJOQcu6
    HfmRr5E1sgQaiBIHwI4BvXWY0ArqCGZcPa3LFIi7G+8WwpEEO/VUBOetmseenjyr
    snXKEU+0wJemT2Ut/AraaRnbvvY/u/O+ca/Eyh3uQt7J//ehSIFP61mv2aV6CDpZ
    Wm63nndfnoJG30yovT2eFvS/JH1SzdZkyRW0RDce+QMMZA7sqLygwtk8hgVP5eW3
    PzIx1yi44udiMKHh5BM3jIJs7v6Jc4cNbNLbHwNYVMiWMPi3QyDZK5Xm0HZUamPU
    2WO/Y/N4c7GXUQAIfZHEVyBLj4eprEarxDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527008686; bh=
    7XzPA7omcpmu+ZCAsiCu93E5ElZY/FIWNCPF7opyVRU=; b=SlqKR1t1Aw+e9GkU
    tAfR3x7MbQyGjvgwP/Ol0/EklNCaBrvX/EdHgcSJZH/5Ie4qPUFWNcwtZNt2sGU2
    PGkTr+Yp0rCucLSzbuDUAsnKqR8BcM0AcEBEKpU0k4qd0AWnXiTVRmURp+o3noRM
    b5yH0SVSCI5NnzOVsE8bokha72I3EuO6+bALV+Wy/gymtq56UJTCiuQa6p0AZgGp
    1pLUo7qWr1ndpwL+6qFWanWMejUZmmrXL/5ckgpq6ToHCc6yrLVifdECHOK882QF
    dIcVgwRF2q3EQSuqe3MOHIP38Y6FLUgMsJlm0r+GVEoDhg56PkpNN9iWnt6t7oqx
    YSe8Zg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCRAtDTH6MciU3G5Zrlnv6inbefPlscRv6d9ibtfSw5furi1P9efKLZVMf+pDGW0Wjie59bAmIYDZpTPJUVF4IgqCX71200eZ9w0l1/OtnAMQWlOaj5n
    K4AVyIl5L8U6Ovbao6a6K0qk1e8KmN2wW00CsHODa7dtl8ei7EwLqZaHIPdrT9CBbshtxPCX8+IlVz+o42O9R5t/1X6pfoWfgHae8nSL17zB9tVdpz2SFnbf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=g51DcS0AerCmfvVyjR4A:9 a=c6hvBiaQiiEVXZeC:21
    a=BGgi9CoWSUkGdByD:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEVREn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:04:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38911 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeEVREm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 13:04:42 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: shuah@kernel.org, linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2] usbip: dynamically allocate idev by nports found in sysfs
Date: Tue, 22 May 2018 19:04:07 +0200
Message-Id: <20180522170407.10102-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <05a0fd16-cd54-1bb8-7566-0d88e1bd73cf@kernel.org>
References: <05a0fd16-cd54-1bb8-7566-0d88e1bd73cf@kernel.org>
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
v1 -> v2: - reworked memory allocation into one calloc call
          - added error path on allocation failure

 tools/usb/usbip/libsrc/vhci_driver.c | 14 +++++++++-----
 tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index c9c81614a66ad..6e2a9edfd1f0d 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -242,13 +242,20 @@ static int read_record(int rhport, char *host, unsigned long host_len,
 
 int usbip_vhci_driver_open(void)
 {
+	int nports = get_nports();
+
 	udev_context = udev_new();
 	if (!udev_context) {
 		err("udev_new failed");
 		return -1;
 	}
 
-	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver));
+	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver) +
+			nports * sizeof(struct usbip_imported_device));
+	if (!vhci_driver) {
+		err("vhci_driver allocation failed");
+		return -1;
+	}
 
 	/* will be freed in usbip_driver_close() */
 	vhci_driver->hc_device =
@@ -260,15 +267,12 @@ int usbip_vhci_driver_open(void)
 		goto err;
 	}
 
-	vhci_driver->nports = get_nports();
+	vhci_driver->nports = nports;
 	dbg("available ports: %d", vhci_driver->nports);
 
 	if (vhci_driver->nports <= 0) {
 		err("no available ports");
 		goto err;
-	} else if (vhci_driver->nports > MAXNPORT) {
-		err("port number exceeds %d", MAXNPORT);
-		goto err;
 	}
 
 	vhci_driver->ncontrollers = get_ncontrollers();
diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
index 418b404d51210..6c9aca2167051 100644
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
+	struct usbip_imported_device idev[];
 };
 
 
-- 
2.17.0

