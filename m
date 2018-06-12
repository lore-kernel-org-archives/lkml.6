Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD63FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7374F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHGALHFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7374F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeFLEc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:32:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42436 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeFLEc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:32:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so5205202pgu.9;
        Mon, 11 Jun 2018 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4I4zmAFUSRdJmSlDOzsZuM9AZElhM4fEyOtUHKXe2yc=;
        b=QHGALHFx3iKq3tmsE9mjf54uF3Df6joiocXFgMS9BCiopqjFPWuR1uxb9gOH6Vz903
         HIQmuAw5fANSkl9uy0QPjzSArrXCZs7/vRGoEBHvYp04Kg0bKfBj+7cSKyTockY08RAy
         HVON+iDarSfRh5gB2V/lU4fytPSu4wXNwatwc6MfaUQTc3XLOHIUqbUcBzm7Lnn5nmET
         p/FbkMGHXkosk7oZbeOCO7W6/In6ES9LziJoObg6U6FdvWZQ1bXb09jKx9LKvkzDnnAC
         VhLSCcjhcSC2hexzzGtmd1E3Y9j/gaIPhFrQgEI6t6mScJwXqi6RXJWFjLTi/l8YVeNu
         oS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4I4zmAFUSRdJmSlDOzsZuM9AZElhM4fEyOtUHKXe2yc=;
        b=NZJNOvKj4BS3tbMYQkxWy0aPm5wLmyPdVzvkw3wVXzWUKLZO/cUPPJg8N9Z/tOFlw8
         empwLkqjESADQ1h6NoZYIJSy1iILlXv6hZHeMi8GRC4KTK4g7NjlJZM7zJivuXIVjXOw
         Yr78A6mnz+Gr04K5TBc236Lk5nkSB1gVHsdgF0AdHdrvS7GB9yinJJ4LD9fUAXbwqUO/
         AK33pzQACDrNKaA8UZYOCpsEeCfgyskWlWvHF3aFZZUbhHxrsmYg23rI889G0Ds0dIc5
         439f6tPJe7pC/+BjGtaWhHzWBBsE5vXs2KUYUPHrAmVF+WIXCMnVNlkUZ67Bz4hRjVfO
         1bKA==
X-Gm-Message-State: APt69E31OILQpcZlLGnUmWaPIHN+zw/1hkdDD0yOkf7qDc1gGGAArady
        CckX913jciZj4XxDs0WlNEM=
X-Google-Smtp-Source: ADUXVKIlM8F8qFbwGb1pQXaPl7Iv1QeoIUzBsKvNzhgH9MeC3c85FA+DY+znqyQP3ji8xOYo1ab7sA==
X-Received: by 2002:a65:60ce:: with SMTP id r14-v6mr1762584pgv.41.1528777947239;
        Mon, 11 Jun 2018 21:32:27 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id g78-v6sm54373727pfe.39.2018.06.11.21.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:32:26 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: add error handling for platform_get_resource_byname
Date:   Tue, 12 Jun 2018 12:32:19 +0800
Message-Id: <1528777942-40876-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When platform_get_resource_byname fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling platform_get_resource_byname.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index a3ecce6..a7bd5e7 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1830,6 +1830,11 @@ static int r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sudmac");
+	if (!res) {
+		dev_err(&pdev->dev, "could not allocate resource.\n");
+		return -ENODEV;
+	}
+
 	r8a66597->sudmac_reg = devm_ioremap_resource(&pdev->dev, res);
 	return PTR_ERR_OR_ZERO(r8a66597->sudmac_reg);
 }
-- 
2.7.4

