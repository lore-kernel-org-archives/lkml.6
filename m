Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708647-2-12101720412652060152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708646; b=LLircS+DgLCCbFt8IgBBzgKkgzQfD52in9b78B33uoIK3pP
    Um42HbCED/bQ7KHXQG+HNdRbOdWfWpimKnadh59g7xnDtMYrL3UTmdVE1RyuyLuk
    2um3EJvdW2mymyyT6QZnT0Z9n7tBsGQmd72f0LMptlvzRLjj3xEphUNWHWqGEK69
    U4sZ6bFXTEdAwcGphz0qlDg0nc14lDTq/LLf/A8l2TxUSKUAUflVy9qEIWySlu4B
    JW8h4aEMUDgoBX1nizkHCJE6b9EBtso88bhQksxeV3dgj5w7orWVqfvHK148rYEG
    OSkGW5l5Ixfv52usXsCVyL6sCwrTWVuF6E2eL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708646; bh=2ugTumJ+zDIDv+Re3kg8TKmFkK
    ujpEHmSabaYiV/1Uc=; b=iaf+X2/HzpX8BUaAeil+BaalBPRBdM9iiDatxBibX0
    Mtx1BE1HnZ3WU+IrIVH+kvqmxDriGVxaKheTtrsHL+mytRFsVsGJrfazWGId39P+
    dA6D6PfmEovkaVNEULDj3fXxsnZBrC5eT7pmwqqLkHEwO+TFN2UJa8IbQbV/cV2D
    rwKuDhEhSB34PBafLsi/LC2T6+RwQHNfGx4gYbF7PK56snClFzC1zDtjV7HthQ4B
    4iJqt6F1Yt5BKW9gxUnxmmMt4l+ahyLdwC7XWHKOKng+hyXi/F91hlUXg5V0UYzz
    rM1yUfc0K+jL4P0raHnHx3y3r1mHGEEiYfnZ7Z0Pa84w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164223AbeBOPan (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:30:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164255AbeBOPak (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:30:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.14 009/195] watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop
Date: Thu, 15 Feb 2018 16:15:00 +0100
Message-Id: <20180215151706.217608678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

commit bc137dfdbec27c0ec5731a89002daded4a4aa1ea upstream.

The first patch above (https://patchwork.kernel.org/patch/9970181/)
makes the oops go away, but it just papers over the problem. The real
problem is that the watchdog core clears WDOG_HW_RUNNING in
watchdog_stop, and the gpio driver fails to set it in its stop
function when it doesn't actually stop it. This means that the core
doesn't know that it now has responsibility for petting the device, in
turn causing the device to reset the system (I hadn't noticed this
because the board I'm working on has that reset logic disabled).

How about this (other drivers may of course have the same problem, I
haven't checked). One might say that ->stop should return an error
when the device can't be stopped, but OTOH this brings parity between
a device without a ->stop method and a GPIO wd that has always-running
set. IOW, I think ->stop should only return an error when an actual
attempt to stop the hardware failed.

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

The watchdog framework clears WDOG_HW_RUNNING before calling
->stop. If the driver is unable to stop the device, it is supposed to
set that bit again so that the watchdog core takes care of sending
heart-beats while the device is not open from user-space. Update the
gpio_wdt driver to honour that contract (and get rid of the redundant
clearing of WDOG_HW_RUNNING).

Fixes: 3c10bbde10 ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/gpio_wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -80,7 +80,8 @@ static int gpio_wdt_stop(struct watchdog
 
 	if (!priv->always_running) {
 		gpio_wdt_disable(priv);
-		clear_bit(WDOG_HW_RUNNING, &wdd->status);
+	} else {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
 	return 0;
