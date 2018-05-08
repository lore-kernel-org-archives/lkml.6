Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2554686-1525773964-2-12379272222456056510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773963; b=C/Z/0gnE2z3OxGil1Vh+pKPIEGDNdFLrnZ32AadjmLmOUShQHg
    2AMjHcVofiK4r2wgygUvZEd99b1+xAG6X8VXASV+LuhWqauPRRDwV6jbl/jn43mY
    YE0QD2Cao44g1i3k/o3SKrgOP2X1Q2ClwR1lpPjvjFgI1a1cq3wzKuMAqZVcXpun
    N0DUkKCbZ4w8fMiFftJ5bzlVqOm0wzRf37sBCzIrtZUH7qIF+qglpfhTb0BCtqUx
    6zA6gz2g8osdQ0FkjXF28RsVKFqlfNJrSJtN9duQxcuDjFYHw2BaPrKGFJ1LpRD7
    gJ40EZQwTFiKWKo4EMJaJR/DVfLpw3zzc3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525773963;
    bh=ntlyQ1srHKUoR+p07ywtPVhYc3zB6Ldv2t9XiuAiR3I=; b=WmaSmtxiXx8K
    bRV2xWOIrJfOZwhHpNhYfN3Jr+na56RlLabqbcN7vCjlEN+cdbbR2efZ2Mh6xzNJ
    ZrHPcM/lE9ca9vHWTk7ExvtvI7LR0lGl+s6zxTXtp2M3jEx76c914llo3ytRo/pX
    5q0KQELYVybjGhmAOpLV6xnnHIle14iqLN2a6+mRKMunOF6O/lbbk4mK9apNQ3of
    kfsSXc9g4e64Q1CzqSLP7WCZMWuQQqeVygd5ZrLd7/GOgfbOTe6ZdoGGM98SR8+e
    xbx67KPxpQVm4JgcVPStHxSuA8Rwb82Jzr4rRRJRIhMNO9TJXAfcsIUK2jWox9mt
    cNciX/Eh4g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIYf4cD3gY2Cy+FuYDciHXjbp7tGJ7MD7T1YrIQo/k9n5DRtQsRYfPhM7tcpVqhYm7ZGvb/Cd8Le/3lg9gk80tuR2hPD3YId0HC2GFSG2F4KXDzaGLry
    hBKE3MBWwhg7D8NC4KN+z/b71yV9NA1wqICNGsOltvbwzm0szvV5RE2wGNOZHkweOQxKWw2K0ynKFoNlh5xEhmn4F7lJC3mPGdkoBHsskVKpnleA5GGVaLqs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=V8_BtoOIRrhnP8fO0FUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeEHKGA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:06:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54651 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754925AbeEHKFz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 06:05:55 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] leds: triggers: provide led_trigger_register_format()
Date: Tue,  8 May 2018 12:05:41 +0200
Message-Id: <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows one to simplify drivers that provide a trigger with a
non-constant name (e.g. one trigger per device with the trigger name
depending on the device's name).

Internally the memory the name member of struct led_trigger points to
now always allocated dynamically instead of just taken from the caller.

The function led_trigger_rename_static() must be changed accordingly and
was renamed to led_trigger_rename() for consistency, with the only user
adapted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/led-triggers.c | 84 +++++++++++++++++++++++++++----------
 drivers/net/can/led.c       |  6 +--
 include/linux/leds.h        | 30 +++++++------
 3 files changed, 81 insertions(+), 39 deletions(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 431123b048a2..5d8bb504b07b 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -175,18 +175,34 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_trigger_set_default);
 
-void led_trigger_rename_static(const char *name, struct led_trigger *trig)
+int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
 {
-	/* new name must be on a temporary string to prevent races */
-	BUG_ON(name == trig->name);
+	const char *prevname;
+	const char *newname;
+	va_list args;
+
+	if (!trig)
+		return 0;
+
+	va_start(args, fmt);
+	newname = kvasprintf_const(GFP_KERNEL, fmt, args);
+	va_end(args);
+
+	if (!newname) {
+		pr_err("Failed to allocate new name for trigger %s\n", trig->name);
+		return -ENOMEM;
+	}
 
 	down_write(&triggers_list_lock);
-	/* this assumes that trig->name was originaly allocated to
-	 * non constant storage */
-	strcpy((char *)trig->name, name);
+	prevname = trig->name;
+	trig->name = newname;
 	up_write(&triggers_list_lock);
+
+	kfree_const(prevname);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(led_trigger_rename_static);
+EXPORT_SYMBOL_GPL(led_trigger_rename);
 
 /* LED Trigger Interface */
 
@@ -333,34 +349,56 @@ void led_trigger_blink_oneshot(struct led_trigger *trig,
 }
 EXPORT_SYMBOL_GPL(led_trigger_blink_oneshot);
 
-void led_trigger_register_simple(const char *name, struct led_trigger **tp)
+int led_trigger_register_format(struct led_trigger **tp, const char *fmt, ...)
 {
+	va_list args;
 	struct led_trigger *trig;
-	int err;
+	int err = -ENOMEM;
+	const char *name;
+
+	va_start(args, fmt);
+	name = kvasprintf_const(GFP_KERNEL, fmt, args);
+	va_end(args);
 
 	trig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
 
-	if (trig) {
-		trig->name = name;
-		err = led_trigger_register(trig);
-		if (err < 0) {
-			kfree(trig);
-			trig = NULL;
-			pr_warn("LED trigger %s failed to register (%d)\n",
-				name, err);
-		}
-	} else {
-		pr_warn("LED trigger %s failed to register (no memory)\n",
-			name);
-	}
+	if (!name || !trig)
+		goto err;
+
+	trig->name = name;
+
+	err = led_trigger_register(trig);
+	if (err < 0)
+		goto err;
+
 	*tp = trig;
+
+	return 0;
+
+err:
+	kfree(trig);
+	kfree_const(name);
+
+	*tp = NULL;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(led_trigger_register_format);
+
+void led_trigger_register_simple(const char *name, struct led_trigger **tp)
+{
+	int ret = led_trigger_register_format(tp, "%s", name);
+	if (ret < 0)
+		pr_warn("LED trigger %s failed to register (%d)\n", name, ret);
 }
 EXPORT_SYMBOL_GPL(led_trigger_register_simple);
 
 void led_trigger_unregister_simple(struct led_trigger *trig)
 {
-	if (trig)
+	if (trig) {
 		led_trigger_unregister(trig);
+		kfree_const(trig->name);
+	}
 	kfree(trig);
 }
 EXPORT_SYMBOL_GPL(led_trigger_unregister_simple);
diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index c1b667675fa1..2d7d1b0d20f9 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
 
 	if (msg == NETDEV_CHANGENAME) {
 		snprintf(name, sizeof(name), "%s-tx", netdev->name);
-		led_trigger_rename_static(name, priv->tx_led_trig);
+		led_trigger_rename(priv->tx_led_trig, name);
 
 		snprintf(name, sizeof(name), "%s-rx", netdev->name);
-		led_trigger_rename_static(name, priv->rx_led_trig);
+		led_trigger_rename(priv->rx_led_trig, name);
 
 		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
-		led_trigger_rename_static(name, priv->rxtx_led_trig);
+		led_trigger_rename(priv->rxtx_led_trig, name);
 	}
 
 	return NOTIFY_DONE;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b7e82550e655..e706c28bb35b 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -275,6 +275,8 @@ extern void led_trigger_unregister(struct led_trigger *trigger);
 extern int devm_led_trigger_register(struct device *dev,
 				     struct led_trigger *trigger);
 
+extern int led_trigger_register_format(struct led_trigger **trigger,
+				       const char *fmt, ...);
 extern void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
 extern void led_trigger_unregister_simple(struct led_trigger *trigger);
@@ -298,28 +300,25 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 }
 
 /**
- * led_trigger_rename_static - rename a trigger
- * @name: the new trigger name
+ * led_trigger_rename - rename a trigger
  * @trig: the LED trigger to rename
+ * @fmt: format string for new name
  *
- * Change a LED trigger name by copying the string passed in
- * name into current trigger name, which MUST be large
- * enough for the new string.
- *
- * Note that name must NOT point to the same string used
- * during LED registration, as that could lead to races.
- *
- * This is meant to be used on triggers with statically
- * allocated name.
+ * rebaptize the given trigger.
  */
-extern void led_trigger_rename_static(const char *name,
-				      struct led_trigger *trig);
+extern int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...);
 
 #else
 
 /* Trigger has no members */
 struct led_trigger {};
 
+static inline int led_trigger_register_format(struct led_trigger **trigger,
+					      const char *fmt, ...)
+{
+	return 0;
+}
+
 /* Trigger inline empty functions */
 static inline void led_trigger_register_simple(const char *name,
 					struct led_trigger **trigger) {}
@@ -342,6 +341,11 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return NULL;
 }
 
+static inline int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
+{
+	return 0;
+}
+
 #endif /* CONFIG_LEDS_TRIGGERS */
 
 /* Trigger specific functions */
-- 
2.17.0

