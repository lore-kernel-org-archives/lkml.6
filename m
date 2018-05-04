Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-155233-1525440540-2-2184436807778123968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='pl',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525440540; b=V1BSrnk0Hw95csBncfaGFaJny5ETgdMYyyKw+4M5ymq3EcpNCd
    C99KGC8ZL/dwyhc0gSumm3t1Lmen2ScIdqGzyxKWI/sxKDlUYXCy+JbnR1hoJ8jr
    uQC7s5iv8LufTs87evn8k7LhJlg8p7JG/duZW0GiHZGVM6RVIt6LvY6Li5bkUpwg
    ocjW/LWRkzRX3eejNhGZCGURjIPtQmOiuL5nPrtVE0IX7zSOaEsiCePEz69l8dg7
    goHIdjaJB9vUpyMEiseUo2B0GjrQQQONHWS86x59CGyqHb1nTK3cMwYi02zw06JT
    TCs/yatU3hCzCy+eLbC88uYOGolmWWg87VYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525440540; bh=
    /qVMKJ3LjKSbwJPES2HdbadyFNvcP1tqY046hVNpAoY=; b=FQfIEZKqnYu0AHrl
    qnVoF/rreg891IOSPDNPmG471/lwDbU1UVL//ADxZDPjHv9yrtvpO7EHa4TJS/0M
    7v/MQmlubPgHqIF0XFOfcSL/vGp+kFY7MnGqBP2Yj+mxtXXsQI6jAaZSEwoIStag
    gSbzcswbH/WVEl0yheC2YVZY9YIXhL3gRHjKsneLPfw6wFgX6yb77kI7utzU3gdi
    z+cnvwqQhyRuGFlUpiOZx7LWowXBNOf3IgfnTPcOvygW7IIVVrroS5SBTQtgVa35
    j9x5hCf92ArCmmVUaUcdT0eFGOnNp4YZQkNO59Jyc/fEWyhkgg62TFzgUOwEOjV/
    zHd0dQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=bgdev-pl.20150623.gappssmtp.com
    header.i=@bgdev-pl.20150623.gappssmtp.com header.b=uHeKmurf
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=msFJ+ali;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=bgdev-pl.20150623.gappssmtp.com
      header.i=@bgdev-pl.20150623.gappssmtp.com header.b=uHeKmurf
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=msFJ+ali;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUofj0kAC+cufV0BopeJfid2N39bLK9B5VQi5NPGI6qJZHwWtejtt8sFk1e5Afy3h7failjf7vdCCowoA+zW+kQSeajKp0sCbwQvx3oydGQKNDW30lW
    EATTwOcKKfY5m0UBUmm7mds5H8Ou1ZlCiIwtcN7ld++7fFbjsHeOFPzMSganQC4y9DIsSCq9P5ldTC8GXkVscjYLVdJDkoHHAGCLV2roTTKAufjBSCpqt2Rc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEDN2n (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 09:28:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39180 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEDN1q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 09:27:46 -0400
X-Google-Smtp-Source: AB8JxZqIn3WtxkdlNv9yNLQPBpeMlBY6CwRCWd4gN2/0eRCE12tf8waQGXV0tJ+nCrZXVul229zw0w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Date: Fri,  4 May 2018 15:27:29 +0200
Message-Id: <20180504132731.14574-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504132731.14574-1-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..595124074821 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -991,7 +991,6 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-early_platform_init("earlytimer", &omap_dm_timer_driver);
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-- 
2.17.0

