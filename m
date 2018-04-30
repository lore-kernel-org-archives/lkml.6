Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1295708-1525092171-2-7222061482830414393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525092171; b=PXmG/9DcG+YY9sTzD4kirDT3ZAnkAZBwq9z5g5M4hmguqo/T86
    +aZnmq1vDF2KWHQtDweMny29PGRN6eribKwXfhjxv8xZyhYC2bb1K4KgXP4zosG+
    1BznSKnZO4rBPPx3CgW89D+7qiwrUwo37UjoXh8kEcVQiheWqlxAgGIXYi4x2KpY
    M9o/IquGyC3cXTn6tTOT+uW4+avU0Ayfnyf6OcJiTUyjntzkXdCZkSsiYpGXpmdw
    Ngw6uq/vGJ2ubnpEqRUAMCaqX3J9QVpRqyyDKiflk8Myuj7/AXd+/2HSbPo5IwHV
    AgXvzrrx/UmazYd/yeEwkkVIE1Wu1cbvLxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525092171; bh=
    91AzaGTGdPyeq0CfmoP0TAPA1BgEGDE6lNaOdOR4qsI=; b=hbT68bkr6XbAXnQi
    BT2fzqDbE8jhB/Y54puZnzwZD+cCitOa5QQdH3KdRXXg/OObOfgnoqmcdu33kccp
    srDFzlTvgdNQ5c9zjVDnzJyPt0rCHoEv0XDl56c19Tyb+p7mAp5bouHXX6/dWQqd
    o/fm0H8g4DJuUA0S3foId5xECE4gdmEjW70GUUMDIFPNqsrxiGzfaL5GKQU1MmzX
    uUgIhLfZBHHsQmHG4Iqc4j9f3Z1NHirI1EieqtFmbGd36dYpAZjSL2z3+l0IJhaE
    8fQAY9vvZYo3gIvibACRplZeBgVs76dILwKxWf+GLrPeosaiwN5yINCCPLwaZwNM
    Tq33vg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEAtSB7I9MiG8PpJ4bKnNquzTGmrh9SOALJa+Ih2++9YjFjEdwjKO3VVWLbVCoQjSE4CatCErtPImfJ3L4SXFkemyJJkVi+HMUdOpPEVzyh7vV57w+1n
    lrZy6wSzililG649JQzFNikmRV586fFBiPLxnczOnk6X4ShXOQlqjn/6C+kKeKEkDidh+vguC1JKNceFETMHKyMmEpivqoh3W1JhWpnl+6ewGhM22/uNSVAz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=dMCGVNs7E_557hWTc14A:9 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeD3MmG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 08:42:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:39224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753110AbeD3MmD (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 30 Apr 2018 08:42:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51126977"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH 1/4] platform: x86: intel_cht_int33fe: Fix dependencies
Date: Mon, 30 Apr 2018 15:41:55 +0300
Message-Id: <20180430124158.45269-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver will not probe unless bq24190 is loaded, so
making it a dependency.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/Kconfig   | 3 +--
 drivers/platform/x86/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8d21b9825d71..fce9f2ca0570 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -202,8 +202,7 @@ config I2C_CHT_WC
 
 	  Note this controller is hooked up to a TI bq24292i charger-IC,
 	  combined with a FUSB302 Type-C port-controller as such it is advised
-	  to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
-	  (the fusb302 driver currently is in drivers/staging).
+	  to also select CONFIG_TYPEC_FUSB302=m.
 
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 39d06dd1f63a..1dbd9d547e60 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -866,6 +866,7 @@ config ACPI_CMPC
 config INTEL_CHT_INT33FE
 	tristate "Intel Cherry Trail ACPI INT33FE Driver"
 	depends on X86 && ACPI && I2C && REGULATOR
+	depends on CHARGER_BQ24190
 	---help---
 	  This driver add support for the INT33FE ACPI device found on
 	  some Intel Cherry Trail devices.
@@ -877,8 +878,7 @@ config INTEL_CHT_INT33FE
 	  i2c drivers for these chips can bind to the them.
 
 	  If you enable this driver it is advised to also select
-	  CONFIG_TYPEC_FUSB302=m, CONFIG_CHARGER_BQ24190=m and
-	  CONFIG_BATTERY_MAX17042=m.
+	  CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m.
 
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
-- 
2.17.0

