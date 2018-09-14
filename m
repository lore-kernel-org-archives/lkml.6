Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869BDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AAE20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFUKLViH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AAE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeINMVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:21:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34045 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeINMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:21:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so6610038eds.1;
        Fri, 14 Sep 2018 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDMzW0owNfyQlN8zdH+gJ6i0JsuBrOsnv6NBr8vU6wE=;
        b=pFUKLViHzQt9HN8pp0QnWvq94ytCVEXgmhmpLqIZQBdTnAqvROQJzt36KxJhPWMl9o
         YTFLL/UzWTAHz7NjfQPBK+qJf3M+fgj350tFZ8DkCTMLnAPMpkAZj7Asg1Cs1yJeItbb
         0Xur86WHUeNZnrSVViBtKIb28dAAecF7PGiJ7/Tf02ZznsSTpbSQVCWDOqJh5VCSo+jz
         pcNy5evffFYIEI2copQmcxdAv8TqdZKV/WOhPMvZZxSF5J4RdLMr3udjBLbgG/5MCDRy
         LE9AGA8WzWGhJSTc04rwcv0JVRC0IO1pePVZaqAOlhCMFEjJphTgRP4PJroIfYFfhuAU
         AZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDMzW0owNfyQlN8zdH+gJ6i0JsuBrOsnv6NBr8vU6wE=;
        b=H1Mzqn8cmRJtCbVFg8/WnNVj5HWehPtPvkSrIoPhHSflxJHjm1jPXftcmbuNcsth8D
         vL+s8gFJGuUC0tukNCMNaceV4QZHzAwwwUUDPKTcS9oU0Wuaix17/n89doz6UQ6zRcdy
         AOgtwt9HP+zRsPN4W0qB2q0GP//PNdTAg5xx4S4dLoHFt4iFmKOP0IgIq1eHi4iQtQUr
         fgrNZ0x6kQyS6kiL8pFVFBAiwunxQKjFimFd4kyiKGgyZOgQqZwRQAX+AuVqPKq/WPsj
         uf8XcEaQVBUh6eud6bO2FWFkuRn2WxxpFRnDa/N6XHaB4h6YkUsY6inGG05I+ziZUdAs
         fc3w==
X-Gm-Message-State: APzg51CPMUusggZJXhMVkhVy0gOvWA5meVjdIS07zKCrmph32dKn9oSB
        b7CTUW/aYsbSQvuggpkK6Tw=
X-Google-Smtp-Source: ANB0VdbMLwMTecYgdp4reI5jpq3zdUGOq7BMoF+t+uHLCcSoKJEBuv6xqzBs8RTPLNmVBNfdVuj4OQ==
X-Received: by 2002:aa7:ca51:: with SMTP id j17-v6mr18345226edt.45.1536908924624;
        Fri, 14 Sep 2018 00:08:44 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id x48-v6sm4186111edm.18.2018.09.14.00.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 00:08:43 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] gpiolib: Show correct direction from the beginning
Date:   Fri, 14 Sep 2018 09:08:39 +0200
Message-Id: <20180914070839.4667-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that the direction is input if direction_input
function is set.
This might not be the case on GPIOs with programmable direction.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a57300c1d649..af853749e0bb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1352,7 +1352,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 		 * it does, and in case chip->get_direction is not set, we may
 		 * expose the wrong direction in sysfs.
 		 */
-		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
+		if (chip->get_direction)
+			desc->flags = !chip->get_direction(chip, i) ?
+					(1 << FLAG_IS_OUT) : 0;
+		else
+			desc->flags = !chip->direction_input ?
+					(1 << FLAG_IS_OUT) : 0;
 	}
 
 #ifdef CONFIG_PINCTRL
-- 
2.18.0

