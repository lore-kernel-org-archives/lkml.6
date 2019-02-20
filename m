Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC14C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCDD2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="fDEUd1Kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBTMUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:20:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36342 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBTMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:20:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id q11so17396067lfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSRWwTVoBrMl78Zf6MgLukE/51IJ1VvujWzWa2NPdSc=;
        b=fDEUd1Kbd4xOXUo32pDS6RZFh9/z99uqXUrrWCFvE5tCnP8faZpMQiu1QpldIGRr2w
         PVLaMMYxjlpgpKVMuBBMEuXyjirZg+KEZvFymFzl90msykZoE035PcZm68cvwzc3Mq4U
         +NQ+BsDl0TcO+GSnyw0909rlIRwfwHLpBakqxF32inxI2PPR4Q8c6NR6XHjWoSkfYs5h
         247kaP1lo8gkfO+BMjEnrHiR36ghO/jmmUVVW22vzxm5FvqAkr8bsGtoHRAJauNZgh4A
         LxLaCaUuJNy3RaESgvLU75qAXrPPS2Hi8inmux7+TqTav+HbXqjgc3R0OZF3mTQQceRd
         LIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSRWwTVoBrMl78Zf6MgLukE/51IJ1VvujWzWa2NPdSc=;
        b=RPqq6+irpeyYgzI/zqc9Z92N3ICblIYOov59OwhQLqHkOY0MBzd/9v4ACXwBYFIoZr
         3dco/zunesjZ4QOio4p6wDTEWFbmkzuvdDZKB9LUP5xYRy50nfmg1RbX+vejt59osKyf
         cHv9prk4P7L4hTX9rUxQZfkL5VXt6lsy8pGap3oOBaED8QlBdcs3lhltjtPTrtmuse45
         PF76Ux8eCAawgmBhemUwjvccydn4Arr8c05Xqupk3NPeKHF/JU8joZHfssWIfbNkDKYF
         D2wk9wZJnCK1J3QQfRg54fkMVfXdmHTHtzHRF8560kv0y92x+qV6tmy5X221y7DCXWhi
         qWMQ==
X-Gm-Message-State: AHQUAuaVMY07QaUvY25ksVxJQkcGQXbemIBH0hTTMhgU0oKi257sf3fm
        ce4kwoIH9b6Azems/4O7+6h7bklKC30=
X-Google-Smtp-Source: AHgI3IbbedkxmXWV3M9a5yKzldNsxhoImr4snDWLw4L5vmCzdVdnHciIz0cWhZJnqf2SSMtybemGeQ==
X-Received: by 2002:ac2:5288:: with SMTP id q8mr21278268lfm.157.1550665218561;
        Wed, 20 Feb 2019 04:20:18 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:20:17 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] usb: gadget: atmel: tie wake lock to running clock
Date:   Wed, 20 Feb 2019 13:20:01 +0100
Message-Id: <20190220122001.5713-4-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220122001.5713-1-jonas@norrbonn.se>
References: <20190220122001.5713-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the USB device is connected to a host, the CPU cannot be suspended or
else the USB device appears to be disconnected from the host's point of
view.  Only after a "USB suspend" state has been entered (as set by the
host) or the host is disconnected can the system safely be suspended: in
both these states, the clock is stopped.  As such, this patch associates
a "wake lock" with the running clock of the UDC to keep the system awake
as long as the host maintains the USB connection active.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Cristian Birsan <cristian.birsan@microchip.com>
CC: Felipe Balbi <balbi@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 740cb9308a86..864d03c3c9db 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1859,6 +1859,8 @@ static int start_clock(struct usba_udc *udc)
 	if (udc->clocked)
 		return 0;
 
+	pm_stay_awake(&udc->pdev->dev);
+
 	ret = clk_prepare_enable(udc->pclk);
 	if (ret)
 		return ret;
@@ -1881,6 +1883,8 @@ static void stop_clock(struct usba_udc *udc)
 	clk_disable_unprepare(udc->pclk);
 
 	udc->clocked = false;
+
+	pm_relax(&udc->pdev->dev);
 }
 
 static int usba_start(struct usba_udc *udc)
-- 
2.19.1

