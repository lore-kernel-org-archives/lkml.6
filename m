Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837430-2-3770174846087933614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837429; b=u88OsUOlCVgna7DoenfBxr+uq6zKlTdJ4Hmoa9l/J/r5WG6
    rhB7eDW5prjr9y2w6sz/k9jTFs842yOhEYNBOXYcQi4wHJgbMWLOMzfo+C2GGENO
    4HXrD+fT3pR35EHr4Z0hu4eGZg3hT+PjcvwVcY/KBdswh/1DEak/ZibfovQUqJPP
    LQKYNHVOKoop4LZUQHIrnCTdtQ66K2snyl9GYiZQGEEKfpAX6/97UaKzTSrSIFOq
    YXwGUTzh+Ajt3RIZFozSXKlJb42Tzawmmd3PM/NhjNqf/F3d5RS5YhV+u2gRGgXI
    BftFI3y5k/SQ2Pi7YugPilgKKJ/cH2dOl++GSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837429; bh=K27nGZp9kmuNrhZNS/c
    UqCwGFNI9EzhHAdXd1qkyi2I=; b=NwZah46xWeeIsHWpkJ2P9HCewQER4lshoCl
    BrwmJxIoZ5iH/YvtYmPjQbroAK4dDp0FAiPMjLhHnWd6a3JqTTpCVgmhvEvgULtv
    20VoNK/Oz+bTkdNiDnLzjhy/49mDDAmdF0lonCjPsGEvfAEHHw9x8ymD6Y+pDH2M
    kjJPLtDJPEm5t9cZOUDjTibH/5i84e7FMIxiOD+zUJeGsg+AcG2pwfFe22gDbFsW
    jt4f2XlprFwNhDyMT/BB6tQ3k+LmJjoFB7P/87jwe6HVSkmAq8w8y4B2LDpjxLqN
    vY5eBlKiFIZUW8wGktK9fxFx++pWYTA40sGLXVM+118PgZEEm4g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933709AbeB1Pvi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34343 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933693AbeB1Pvf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Max Schulze" <max.schulze@posteo.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.52258693@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 141/254] USB: serial: ftdi_sio: add id for Airbus DS P8GR
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

From: Max Schulze <max.schulze@posteo.de>

commit c6a36ad383559a60a249aa6016cebf3cb8b6c485 upstream.

Add AIRBUS_DS_P8GR device IDs to ftdi_sio driver.

Signed-off-by: Max Schulze <max.schulze@posteo.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1030,6 +1030,7 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
+	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -914,6 +914,12 @@
 #define ICPDAS_I7563U_PID		0x0105
 
 /*
+ * Airbus Defence and Space
+ */
+#define AIRBUS_DS_VID			0x1e8e  /* Vendor ID */
+#define AIRBUS_DS_P8GR			0x6001  /* Tetra P8GR */
+
+/*
  * RT Systems programming cables for various ham radios
  */
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
