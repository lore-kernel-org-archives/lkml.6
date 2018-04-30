Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619120-1525106258-2-4319502665467122613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='pl',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525106258; b=C4VeWC82xZVj+R0pYEQ/lyWeDi54KREaAyJzPIqbo6F3aq1qTT
    V3wVaxsMqRv5pkuGvTmYs3WEaoXa9OE/yb9z3PqD9dc+AwE/9WLsIGLaZRDgCPRL
    ojrN7S30C427lJx4D+is8Bda4z/FIVbPZRN7KHsnKNiSeTuMfPrVs0i3GpBAYLQd
    PznxVHCz15ETTqC81oDLaIasPmYfaFXF2LfQx+9wzPwSaSTXnRjmiFUhXStO/Xu9
    P4rpPmXtaPGvU//Ex7HTWO5h4qJDQXpeTnma/Esw/JM20r6VB3bn9rWEh6btmoSW
    rmYu/6eDVv3TnOkkjFbs9QIQYkukofPYP00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525106258; bh=
    /qVMKJ3LjKSbwJPES2HdbadyFNvcP1tqY046hVNpAoY=; b=kDYlfio6t1g4Y3rk
    b9LnSA1Bu5noiFDVtFcSJdxKYg183hPw6+2CKO1EC3N3w+JY+8e+sU838Nn4Jjkl
    5TY1HD18TZvsH//jOE26WiXEyUlp28GCZ/rPCoCX6yKByT4HT2frMfAyI3UGjug6
    /n3e5384PT4ubkVJw38gttYG3G0JfsnFSLKnLE2/hsyLN5iguXzodzAbh9Xl6KEO
    s1cjI+gwerOmGDrB+dBZ7rY11/Ss6lWdBv2wRndIlMue08NiQMwC4kJMAshCa1/R
    FGuwehXUxX2ezVm+qlkHM7w0uDqsWteVlU2QXMyWhOJKSiM2V5luFi6Ar0i7sd0N
    P0h0KQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b=f3ZIUwU5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X4dbABlU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b=f3ZIUwU5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X4dbABlU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHf0OMpgfLNR51a6rPuxvdS/+Qb2F+Av12CldkuCKFbhod5XOmOBa2O5Tbc3ujK/GzRekKNDBXHEzQiGEe4NYhb2Fz021JY8YY/+z6q3HRIhS0YmkaTW
    qj34QHd6Nw0kcH4k8SKgsqYNi2Pmk+qnemoJ9lOCm/WhW0llsJ9cnvaxvnlxyMp6sMiti4ck/yQccezfFFgXPvJCCOYQP6ZtzWYfCBjxokkm1iDypYkCAvK9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754949AbeD3Qhg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 12:37:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38160 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeD3Qg0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Apr 2018 12:36:26 -0400
X-Google-Smtp-Source: AB8JxZoF+b8kmjKQ8vUH5HnQCtMUC2v2iooIjDdVRh1iik/DcRd124+zAVAreZLALTHpk7vrfQk4jg==
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
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Date: Mon, 30 Apr 2018 18:35:54 +0200
Message-Id: <20180430163556.2560-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430163556.2560-1-brgl@bgdev.pl>
References: <20180430163556.2560-1-brgl@bgdev.pl>
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

