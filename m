Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3F20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UQW5XaDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C3F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLITvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLITvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so9093945wmd.4;
        Sun, 09 Dec 2018 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDqsZyP6j8JGDXWLyKC4bYcSMPWO8/JQO0c8SegjH6Q=;
        b=UQW5XaDSB1z/zM/+7M4jWdgmXjNhL6vYrLpFRo7nE8NDe9hqlyeWwetHJK4h52WYGz
         YkP4YtDnnq5JezkClHV+/TTYVaI51iUo/oBnsGbOrSKGWTEH3glTDyjpVoDj4gHpBPO+
         71u8fZLeN++bE1G7Y8Z4yysP21MuLtfrwfLWYg3D1fOS2ZcfXqiZ/kXFZ/OHFeme3w1t
         zgDwAqgOYWCSK+WEWa7kvo7EGQ8+0r5lQLXqEQLdtvnHr+avEOuYpCE2uVL3uX26C395
         G8AOH9GmGh1K+5OCtyXJqFJplAsoNpkKGS8Leigd8AkonInS+nO5E8ti0iouttZXdTAg
         o5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDqsZyP6j8JGDXWLyKC4bYcSMPWO8/JQO0c8SegjH6Q=;
        b=A1lluHAzZJplE9XkqyT5N+qkS2jM/XjSNr9BXHucYyyDeOqCkQPkNhJBcmeRjNprIo
         zUcUK/EMHpqAn/9YymePEvj6Od83acuc0b72aoF9vJ1h03hBKcIUDbTl4S07ud/E6GmT
         zHH4oq+orAR1QnuRRaec6zrnA09jGH3fGpzlX9mImB1AYi6DwAom7kWehTJL7Q2aH8eJ
         EB1rKEPkPORtQg6zbszaRNAgKshUbZPUO7IBavjS2z7hNgnJ5ZMcYdjk+wNcjcEkQz83
         07r6g0/dzUtmCdJGpA2+8TtFCvt5zBdpSGMMJ8yrjUPqUZVPIzf1/RvOaYxYs7FB/62o
         mE9w==
X-Gm-Message-State: AA+aEWbsY7CrIS0yKYi4lPoajzDXYGEteJaJHVQnfSWMVT76HXSrWqwL
        vbu4RdRN6vXeDSUF+957s/g=
X-Google-Smtp-Source: AFSGD/W236m2+8BHqCEGDXrqeWxw+vHplbkUfpeO4Y+NnSJsFn99FeYOeK3M6D06Ly6Bun/85yGn1A==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr598wmp.19.1544385063554;
        Sun, 09 Dec 2018 11:51:03 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:02 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/6] pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
Date:   Sun,  9 Dec 2018 20:50:50 +0100
Message-Id: <20181209195055.26813-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIOAO pins (as well as the two exotic GPIO_BSD_EN and GPIO_TEST_N)
only belong to the pin controller in the AO domain. With the current
definition these pins cannot be referred to in .dts files as group
(which is possible on GXBB and GXL for example).

Add a separate "gpio_aobus" function to fix the mapping between the pin
controller and the GPIO pins in the AO domain. This is similar to how
the GXBB and GXL drivers implement this functionality.

Fixes: 9dab1868ec0db4 ("pinctrl: amlogic: Make driver independent from two-domain configuration")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 86466173114d..e482672e833a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -807,7 +807,9 @@ static const char * const gpio_groups[] = {
 	"BOOT_5", "BOOT_6", "BOOT_7", "BOOT_8", "BOOT_9",
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
+};
 
+static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
 	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
 	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
@@ -1030,6 +1032,7 @@ static struct meson_pmx_func meson8_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(remote),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.2

