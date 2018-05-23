Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219543-1527086371-2-2671480988790670455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527086371; b=RfmP8wrA/aQYPIYe4chVkFx7C5mRgmM2t5I0Pg/CbAH9HuBTAf
    yCooUZtLfqeRgfKpxFxoNx0tE3ceFzi+kXq31ywnTQKFiDplscwEqGqNRPrBQkNo
    XnmW10tE0dn3LJI0jMIOfTmPliYvhdzOzRYKMRa6UtXnWG7RmubTPxh1r7MvkJxl
    8RVquCV7e7+rdi1ssWfbaR4eXcv74pAhuns7TnBGIJATxmfOuGDaDaJP1iQRo/zl
    FZnumT+yZu71kSbMEgIvMv1ucwI9RZZ+sXE6h0eBhr72emrZJttvlq4SY6EzODd8
    /JHwSbN/lewE9wy5pR4zehuHVBoUxQbC8S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527086371; bh=
    upuW049LXffRev3Q0kjmVHKLZteY7wMI0n4dmvj4QVc=; b=GLR5aqC1QwhMKqix
    wdxHqLgILn4yf4aY2+yt8AmLwEFzGv7zA1ZtlEt4/s5gdrKPsqDMDmzVO0s7SMEW
    gnSKRq01GtwuxB7GPIihSqkT1WdPwKmhF1xMUQCDP7/6jM/YWlVumjI//w3atP9j
    wxT+3ffCMtHYEZImae37PIokvz0/m1E/CYzGxKXlrBkoui/tp5I33hKhPQL6SVbR
    N4s83gWOpLoA52SzNnIwxF4Bie2iVkwKaLUNQq/f+Sliwgqs3Fqpeg0ruqTdyAL/
    Jsx6RDlpSk/WqQ+XwDNGYB2Mn3ex1rvpm0+uo6ypPfvYSqutL+G4xr0KgnJlDDrv
    IeP/yg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHGxz6Dy4AYyW41cra29wk7MOw0Mon34FpaFZHUMRKXhDWBYD5zNgSElB7FhGuTZT0iYIr5InXQmT/NwDw5ONHybgzITtVA5/QH7Ino2wiYk/7SVU/9r
    hilf62mF1J6f3sgFd5tuebuhuMcEZjHYGUcY/+t2/cpkY7CMl7bx7r4B4wGq82VFuRswzx0qrV/XI5WvoeLPrEcFyGuFGXK1KOvjR39ZI/7Hy8/pxfGr0b32
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=dMCGVNs7E_557hWTc14A:9 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeEWOjR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 10:39:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:29020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933268AbeEWOiH (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 10:38:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="57815019"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH v2 2/3] platform: x86: intel_cht_int33fe: Fix dependencies
Date: Wed, 23 May 2018 17:37:57 +0300
Message-Id: <20180523143758.66348-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
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
index 99edffae27f6..4f8df2ec87b1 100644
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
index 566644bb496a..f27cb186437d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -866,6 +866,7 @@ config ACPI_CMPC
 config INTEL_CHT_INT33FE
 	tristate "Intel Cherry Trail ACPI INT33FE Driver"
 	depends on X86 && ACPI && I2C && REGULATOR
+	depends on CHARGER_BQ24190=y || (CHARGER_BQ24190=m && m)
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

