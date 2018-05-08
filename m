Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2554686-1525773960-2-9233422537594793108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-asciida,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773959; b=J7SomD56EiC+6AOr92oGtQ2HCaLxeaKFBe06hV3BYIx6EvWLR0
    ociTDceP4HJnhF59tq8CXxUQfm3L4/QOSjofIQBdlICOiKxO7h6VyyYwkvc/66PU
    1Tugb9yWM3bb/WYZ5XQpQbcGwg0uGz87tlV0etfqz1RO55JfNDn5RJcbEsnLC/Tt
    UtBfDw8yoeFhWuHuj4u76+qCzric6W7ws9iQNWDQcJycR+osN3re6qntzOpQQbWM
    ymzRSSTszJ+OWAJatFwhnPnOUwZ7VKe8Hdjzjsoj2P3cuJMRiBGlKOkOcDO2R0bM
    Opr5GAOwy4NnSMB1ijiiAwoZLs3UgQvst78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525773959;
    bh=EP3EQtox5Bkqxm82jwpftWvokr07soC1x6YalZUJ+2I=; b=mBvBExfh2EjZ
    ULAqVGSbmHIo3CDfHhXmTUZTvRIDZxngDfI1kq6umwjShANDC0VfNBJL/tmL65+u
    GA7scv6TOFHnFFPtW9FHDqx4m9po97PAQtJ8Rn1WHpBB2hrI4XbeOPh6kdx/1X3v
    PNmMx1qSicDdbkdsIkBnz1We2uhoCoqZDlPh0ymEsfkuTR1+cfTR7Yda+tCyeEwL
    B0A8rlYhCVSV7hOGD453kZ2mJB+6CvAHqwgvevVYqw4JE7sk3Kr6cuQQWyUdiceu
    gvOPhYO6TUmOt+WDOsUJWMiYY2MTNQNJMGaiDbsBavRPcAJFmm9Gt4KZlQUBSGlt
    X2eMy/jJRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFjJ3nKEEdIm6Ec5Ff0jnH5KhcueZAo6w+Bm3j8O7SSw6gGsakvNmPjaroaLa+w+92/QeZAuEiSAjtJp7TmpguVkIqzc31ChQ50btlvmioK0cB3NmJt+
    bKVJQTweGaLmQhBOS2y1V51+zPlhCe0BTDO07OhahNhNKiulL7XGl/lQg1Bo5D0qaEHv7ANMVeeiejtKJRzQtSvsrbpxSyO2N1i1R8/lxeD80VFi2mDgmevJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=jTel2pDyvxz6uUn_02AA:9
    a=83QJKS7hInHHxT-w:21 a=jpAP5axQ0yUGcHHK:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeEHKF5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:05:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36745 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbeEHKFz (ORCPT
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
Subject: [PATCH v3 2/3] can: simplify LED trigger handling
Date: Tue,  8 May 2018 12:05:42 +0200
Message-Id: <20180508100543.12559-3-u.kleine-koenig@pengutronix.de>
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

The new function led_trigger_register_format allows one to simplify LED
trigger handling considerably.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/led.c   | 30 +++++++-----------------------
 include/linux/can/dev.h |  3 ---
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index 2d7d1b0d20f9..111f9769e9da 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -81,19 +81,9 @@ void devm_can_led_init(struct net_device *netdev)
 		return;
 	}
 
-	snprintf(priv->tx_led_trig_name, sizeof(priv->tx_led_trig_name),
-		 "%s-tx", netdev->name);
-	snprintf(priv->rx_led_trig_name, sizeof(priv->rx_led_trig_name),
-		 "%s-rx", netdev->name);
-	snprintf(priv->rxtx_led_trig_name, sizeof(priv->rxtx_led_trig_name),
-		 "%s-rxtx", netdev->name);
-
-	led_trigger_register_simple(priv->tx_led_trig_name,
-				    &priv->tx_led_trig);
-	led_trigger_register_simple(priv->rx_led_trig_name,
-				    &priv->rx_led_trig);
-	led_trigger_register_simple(priv->rxtx_led_trig_name,
-				    &priv->rxtx_led_trig);
+	led_trigger_register_format(&priv->tx_led_trig, "%s-tx", netdev->name);
+	led_trigger_register_format(&priv->rx_led_trig, "%s-rx", netdev->name);
+	led_trigger_register_format(&priv->rxtx_led_trig, "%s-rxtx", netdev->name);
 
 	devres_add(&netdev->dev, res);
 }
@@ -105,23 +95,17 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct can_priv *priv = safe_candev_priv(netdev);
-	char name[CAN_LED_NAME_SZ];
 
 	if (!priv)
 		return NOTIFY_DONE;
 
-	if (!priv->tx_led_trig || !priv->rx_led_trig || !priv->rxtx_led_trig)
-		return NOTIFY_DONE;
-
 	if (msg == NETDEV_CHANGENAME) {
-		snprintf(name, sizeof(name), "%s-tx", netdev->name);
-		led_trigger_rename(priv->tx_led_trig, name);
+		led_trigger_rename(priv->tx_led_trig, "%s-tx", netdev->name);
 
-		snprintf(name, sizeof(name), "%s-rx", netdev->name);
-		led_trigger_rename(priv->rx_led_trig, name);
+		led_trigger_rename(priv->rx_led_trig, "%s-rx", netdev->name);
 
-		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
-		led_trigger_rename(priv->rxtx_led_trig, name);
+		led_trigger_rename(priv->rxtx_led_trig,
+				   "%s-rxtx", netdev->name);
 	}
 
 	return NOTIFY_DONE;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 055aaf5ed9af..ff358269aa9c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -73,11 +73,8 @@ struct can_priv {
 
 #ifdef CONFIG_CAN_LEDS
 	struct led_trigger *tx_led_trig;
-	char tx_led_trig_name[CAN_LED_NAME_SZ];
 	struct led_trigger *rx_led_trig;
-	char rx_led_trig_name[CAN_LED_NAME_SZ];
 	struct led_trigger *rxtx_led_trig;
-	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
 #endif
 };
 
-- 
2.17.0

