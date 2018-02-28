Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836445-2-9278665419922399658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836444; b=ENG3B324P4rswSnv/TE7fByW67bQbSYnZUTIRIADD5wokiR
    ZhBTfw8mkJe9jy3BvFyq/xgXarfRoM8eTkym9JpdL9mVx8tbcyfXHGK/UkASDIni
    dx5H9kdcKe/EPHjbqZbVuGw0JVpG9/rAqi90hj/ZTpwZL9sg9Bpo4Yf9qv4iW44K
    c0fxGJQeQ9lx7s8SF+LJIG4DfDY+6d6iKsV022IlZDN9qBNp8LWX0Q5/98rjfln/
    Zd9LPx7VKz+bh89q2z5YRO0by/RhCH82UKm1GeDXQ0FD8zdnbUwJ74HDSEKQR+zn
    zZmyA6waKNfr2tk9N4GB98tPv5vp0att3rDS/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836444; bh=rBrFZakFNaXQjFwRbN+
    sdDr8i9DUBVafgTjsmU6yd7o=; b=pd7r12q0bf8bNABDcto9VXx7KWKDPJ2yr0w
    Tv/6bLK9sWF0v4ELz8ZsWF4AC+LMw+9jIw7Fl9SEWtKePYqmz4iYLXdMZnAW3MUG
    GgQUoATOnbWUltj3T23FsGiO5Ox70FEFL2W0RqAvZf7kWAJk2cDUE6MCDfBR6P2c
    fer9lTf+8KG0+9YwM2Q+LT5G/GZtxXcN39k+J6pBZUV0ttSMUHal6b2qHFQqrIDw
    Mjn6Aa50bUUehuqOA/GkFsU+BmsnV+wAxCcZYFEXeejnpLxHb94MiwMnGdYkMiLh
    Lh6y5swIy/R13ikaddgizpwgskLzXiCup/19WD86FawpVuevWxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934345AbeB1P7B (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:59:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34597 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934321AbeB1P67 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Stefan Agner" <stefan@agner.ch>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.304488537@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 203/254] usb: misc: usb3503: make sure reset is low
 for at least 100us
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

From: Stefan Agner <stefan@agner.ch>

commit b8626f1dc29d3eee444bfaa92146ec7b291ef41c upstream.

When using a GPIO which is high by default, and initialize the
driver in USB Hub mode, initialization fails with:
  [  111.757794] usb3503 0-0008: SP_ILOCK failed (-5)

The reason seems to be that the chip is not properly reset.
Probe does initialize reset low, however some lines later the
code already set it back high, which is not long enouth.

Make sure reset is asserted for at least 100us by inserting a
delay after initializing the reset pin during probe.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/misc/usb3503.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -292,6 +292,8 @@ static int usb3503_probe(struct usb3503
 	if (gpio_is_valid(hub->gpio_reset)) {
 		err = devm_gpio_request_one(dev, hub->gpio_reset,
 				GPIOF_OUT_INIT_LOW, "usb3503 reset");
+		/* Datasheet defines a hardware reset to be at least 100us */
+		usleep_range(100, 10000);
 		if (err) {
 			dev_err(dev,
 				"unable to request GPIO %d as reset pin (%d)\n",
