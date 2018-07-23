Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48F320852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjymxdgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48F320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeGWPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:03:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39324 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbeGWPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:03:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so836552wre.6;
        Mon, 23 Jul 2018 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RuY+J0ywTOfTfenYrSZTZk7BFYeQMS8+A6ZswvghFL4=;
        b=TjymxdgoZ5nMTTw0mPa9EKsZRi80OqE2Ba6VARETaidSn11rp/YQmcHbcPHRlw/E73
         F4xVPK3w+QMHZ7d3tjd0i3a4LYkrqfe/4ecQrw0w1w1S7NRZtrj5IxFGwto/ef62Q0Yl
         /tMDBxX9plo+/+1MCdWrv/7FwbYkLTMgZjMyTs7Y1krKPOTjgaHpv4Z5yaQfIq2TdYAA
         5dv38ijX/ubDSo7kqjNww5h2q++RSdQozU33iffO5TM/kfrt4LxnzlVXXyUCQo4LjMZW
         5ly1Hf0bE7x8fJDzhWnxVZqcB6o0alPhTX0JoinCdVltOMZ+X+KN6aFEYCdBmOoKrUSy
         58oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RuY+J0ywTOfTfenYrSZTZk7BFYeQMS8+A6ZswvghFL4=;
        b=SnfrxiK4Uek7IkTtVLuphqnZjqYZrUqDDXkGB3EC9/dnNn0etvHpL4OKTCmGn/wUl/
         qtrun2BeZiRhsSfiqNpSjPJm8zTQ8bzXnzWjk5c5jmxgpX78LidaX0wYfr06y3XYPXgE
         oWLa7ke2uQmTfDnExArG2xoY8j3Me+73kydm5ED5pabL0qqoDnZvWbtYhznjiwQgwZcX
         TQSLKyFL1MVdv5R/4haH+qXn6hde8lwkbV6blciwEF62Z4E3mf+Yfrayoywvtl7X89eI
         rXX8eDaHL0We8uEaDNKJfHGmpcjlxuz19ITjtQoUX1Lf+AWnJu5J3YS9jQ7ihj61xp6o
         qtzg==
X-Gm-Message-State: AOUpUlHitvkZHMhui/XXPe5UBcuY7ZR+svkGhaXfDBmNaznbC9+xp1zB
        NO9O4AG5SWif+QstNrh2W1I=
X-Google-Smtp-Source: AAOMgpet7cAEIhU0Skbr7sfNAjVjHtoXqYXKIwKNQM8jtDbR7RgiQp2KhmZWov9KViy/E8Gp2OlgYw==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr8400323wrh.235.1532354546887;
        Mon, 23 Jul 2018 07:02:26 -0700 (PDT)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id r16-v6sm4085961wru.59.2018.07.23.07.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:02:26 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] option: Do not try to bind to ADB interfaces
Date:   Mon, 23 Jul 2018 16:02:20 +0200
Message-Id: <20180723140220.7166-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some modems now use the Android Debug Bridge to provide a debugging
interface, and some phones can also export serial ports managed by the
"option" driver.

The ADB daemon running in userspace tries to use USB interfaces with
bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1

Prevent the option driver from binding to those interfaces, as they
will not be serial ports.

This can fix issues like:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 664e61f16b6a..f98943a57ff0 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1987,6 +1987,12 @@ static int option_probe(struct usb_serial *serial,
 	if (iface_desc->bInterfaceClass == USB_CLASS_MASS_STORAGE)
 		return -ENODEV;
 
+	/* Do not bind Android Debug Bridge interfaces */
+	if (iface_desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+		iface_desc->bInterfaceSubClass == 0x42 &&
+		iface_desc->bInterfaceProtocol == 1)
+		return -ENODEV;
+
 	/*
 	 * Don't bind reserved interfaces (like network ones) which often have
 	 * the same class/subclass/protocol as the serial interfaces.  Look at
-- 
2.17.1

