Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2061918-1521042692-2-16294335563054025338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042691; b=Yb6CO/f4AaZ2wnad8QxFIMzNhe67klLL4ZZ2EuBrPKdg9FY
    UOOnCvuOpZnHUVIMRgMNZt6+Mktg8ocM9VjBDhBDCz6iEr7FojfBDVnzF+U1HDWN
    mdpA5rOwFMENP83jWk24HHwaVYuE9BMmy7NB+nkjNxbVxM4p2Imbmb7xAph/xv3d
    gXZwlBjoeyYcbuJJqougO29+iW6RJxaVGX8ZvMNvl1n5N9EXGFosEqR49pcRK/hV
    n7hm9QOv7+cS/aeVk5X6ibRJrqE6GTX06VJwS9Hf836kjgg/miZ71M7CQpFYYVus
    iyMuB2hETBpdCFKYifZT3p679efMr1/dLmVuD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042691;
    bh=a8uwdnme3tEasHc/gaMziX/aDO+RIJ30pBgRCR0hrws=; b=elADm3rzdkNi
    PN/m7quLbSM3wfk1YxDYlxRsHAbKbCqG7LREzp5SsD8v0iXEcTZpw3WnDPLvCYgk
    dbTFW+Z1jwUM/fpeZpiEqoV8XyLiwPZvFAqkrFnYra0mHGV+5vBlbp6PEcjI8yJs
    zLX0Bfo1TvpBFlezjfUR9/mA22B9jQU+zeLzY607tIfGWeoLrszXWG8e8cnsjtw0
    fMysxcXxTrJjiQS8xdyN4VnJaEBEhC6XXFs6gJ0gtz/4vAhShnC8vIGawVTLuOoS
    keZxc6WPQq9ECuIpHc+jF6YWqQVGyTY8230ydfdt5azOuInBxO5LyIIe5vnzgNLw
    UauwJN1vWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeCNPvL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:51:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCNPvJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 11:51:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 37/47] usb: host: remove tilegx platform glue
Date: Wed, 14 Mar 2018 16:35:50 +0100
Message-Id: <20180314153603.3127932-38-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:sNkax9zC0DvKA08oxvcxQWxYSIkII+8IqCzAECGytTcTXCGqi10
 6djqTCwUyUmSztE4gM7Kit+aB/I400adV72KDYop4vOQ4f9pQtQoglpTAMSrE3OjdR0aRZ8
 uOf0wRftBtz8JpKa8EM92okA7MpVU0wygVn1gsEo6M0/xUsxj7TBl+SCsLYziTqs6W/QSRT
 EpYBXXFHDIzIbf9MNq5eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wYcj51V7Ick=:zSgacM6N7bKBjTy1GzhUbO
 YohRzpNcs30mNm18GgxeoQ5r/J8kq8ltsPjOf4mOe8bsvxQmTjnd47/V42zdbJDjW4oEjEhx5
 6DG1i1BnhLXTmVPYG9p2XLUM2LOLXjK3HOwgPlZh34lwTHlUXZsS+/5g6rPnPB893Fgb2+OgC
 mR2Eq4HKJIEnzQlNxvTGRXTBS5HtiM9ECBOcQ3QyCaCt3kqXwChbg8u785pc/kV+1ZN1+u50o
 GUZj+yPRIplhOtOv+tmmOPgP0wuePgITn4rStp7OouxUh1T/xVdIIeTajx1SCcM884VHD90md
 DSuBKYcq4Rjxl8zC96sgxRaLnXcpOXAJtA1zhVQ2M5yVnkulKLDmCXYMvsU0H0/eJhMQo4HZ+
 rel2qZur8YJRSANSOuv9VeRqvSnIqP5qcUwodg/6IVoBBqG3ho37w62F5lSag9dlxXXzvYBFw
 XudmpDogvZfhtcL8w3OKt9vLZlGuX5txGzqHTbdpCnbBYTTIGpaIxQCuqylQalRAFZK6GxgZK
 Obvt/svTWTWXFaheqIdYnaB0nbG+EOeJHVc45zs8igY9Sbr6f1C7PBY8mSqoNp8gBM2hWQKMA
 ANfM6/tOvf2z2d97a+ws5D8seuaOYrdi2Zm/6HeR0V+YYBQfsH5b9Kik5LfIQsvSaWZkYv2SY
 lkNPJsmED7mP+zzrNojsJxMeRv+9MFwpS6zPy0ypONkLd38OUJY21OcCSuJtrp5NvG5kmSbZs
 j6RP3rdVMKo7Z/0Byu4RLKNqz+6DzvwFgw7+2A==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tile architecture is getting removed, so the ehci and ohci platform
glue drivers are no longer needed. In case of ohci, this is the last
one to define a PLATFORM_DRIVER macro, so we can remove even more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-hcd.c    |   5 -
 drivers/usb/host/ehci-tilegx.c | 207 -----------------------------------------
 drivers/usb/host/ohci-hcd.c    |  18 ----
 drivers/usb/host/ohci-tilegx.c | 196 --------------------------------------
 include/linux/usb/tilegx.h     |  35 -------
 5 files changed, 461 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-tilegx.c
 delete mode 100644 drivers/usb/host/ohci-tilegx.c
 delete mode 100644 include/linux/usb/tilegx.h

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7f0737449df7..d927adf3afcd 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1275,11 +1275,6 @@ MODULE_LICENSE ("GPL");
 #define XILINX_OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
 #endif
 
-#ifdef CONFIG_TILE_USB
-#include "ehci-tilegx.c"
-#define	PLATFORM_DRIVER		ehci_hcd_tilegx_driver
-#endif
-
 #ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
 #include "ehci-pmcmsp.c"
 #define	PLATFORM_DRIVER		ehci_hcd_msp_driver
diff --git a/drivers/usb/host/ehci-tilegx.c b/drivers/usb/host/ehci-tilegx.c
deleted file mode 100644
index 610ed437ed2c..000000000000
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 84f88fa411cd..199f1b7a91a3 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1244,11 +1244,6 @@ MODULE_LICENSE ("GPL");
 #define TMIO_OHCI_DRIVER	ohci_hcd_tmio_driver
 #endif
 
-#ifdef CONFIG_TILE_USB
-#include "ohci-tilegx.c"
-#define PLATFORM_DRIVER		ohci_hcd_tilegx_driver
-#endif
-
 static int __init ohci_hcd_mod_init(void)
 {
 	int retval = 0;
@@ -1273,12 +1268,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_ps3;
 #endif
 
-#ifdef PLATFORM_DRIVER
-	retval = platform_driver_register(&PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_platform;
-#endif
-
 #ifdef OF_PLATFORM_DRIVER
 	retval = platform_driver_register(&OF_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1322,10 +1311,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
  error_of_platform:
 #endif
-#ifdef PLATFORM_DRIVER
-	platform_driver_unregister(&PLATFORM_DRIVER);
- error_platform:
-#endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
 	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
  error_ps3:
@@ -1353,9 +1338,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef OF_PLATFORM_DRIVER
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
 #endif
-#ifdef PLATFORM_DRIVER
-	platform_driver_unregister(&PLATFORM_DRIVER);
-#endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
 	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-tilegx.c b/drivers/usb/host/ohci-tilegx.c
deleted file mode 100644
index d21ca3ce9a30..000000000000
diff --git a/include/linux/usb/tilegx.h b/include/linux/usb/tilegx.h
deleted file mode 100644
index 817908573fe8..000000000000
-- 
2.9.0

