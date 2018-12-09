Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A5C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6362082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vV8BDERd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6362082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeLITvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLITvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so8397731wru.12;
        Sun, 09 Dec 2018 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNuetO7o6p2z/PS/M/PqymLq8KTy/5E9grHzBPHloU4=;
        b=vV8BDERd+zfS708DoZc7iQzaGuZMaNqMiwh/Gx5nk0w/MreETlLUcucH7ZASrjrjE3
         ukuMJCmz43mUomVPmsv4rDQo81MSXoM4kSxy4ulxFfFnUQa40yjGscOK855GUiZzKlj9
         k3J0vlMf2rNqIRWd36cxGTu6nzrWYdOlncs7CThp0Z9DeoAEe5LXA0vREbk8XFGiV5+F
         QjSNgtowMlh0gIdJBjY59qq9Bs5f4pxQ0ZJj6WykgvQ6Fu140zH2VaGgzUjH4s7RWN2L
         5/K48vWl1xZvvFtRTS2yviobIcy4kj9LbUXR+YL2mRsPvBaaYMpYxedvVaeCSsjJy5G9
         DoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNuetO7o6p2z/PS/M/PqymLq8KTy/5E9grHzBPHloU4=;
        b=eH6G//9FsDAtldhRoYj3gezSQPp1Zk5FhayEfh20AyKRXvXrk0olrOQ1S3dAEbXgff
         b6y+o8JOkBtP1x/lO0coUSWd1KuOfrpumNXS1AA41G3laoM1y775Z1nZES7gwozX+TpC
         4snr9FhlHDL9b8W6X0l1RlrawvvbHSdbYSx1iaxBrOueTg3F3HLxNPKwpvcbbzgwAT8J
         rxLrrB1nRV8oWk6EcXsN+RrpAUOwvJPB+238Jc9dlJz5k9k9ndgp2XTksbSHjfxYToV0
         s0fo6jMQWtaZb7qE/flu4Rm0N5vLHh+cQ6cN69C8+u7hEwn3Fj2JtAlknqpXY7Wnw3Tu
         QtmA==
X-Gm-Message-State: AA+aEWZtArTO7fJYsSQFj0y4/tincNZVUavbvHZZgNI6clVmkGbotqF6
        dftPzF9hgCfcglwEJMRNp4c=
X-Google-Smtp-Source: AFSGD/U1KCYgZTtKIpkMT4NcDbUXMVhp2mp8fR5eDSRBzZ+pMl4j7G8EICcN4xTaxjKunk6dekpH9w==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr7640014wru.14.1544385064732;
        Sun, 09 Dec 2018 11:51:04 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:04 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/6] pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins
Date:   Sun,  9 Dec 2018 20:50:51 +0100
Message-Id: <20181209195055.26813-3-martin.blumenstingl@googlemail.com>
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
 drivers/pinctrl/meson/pinctrl-meson8b.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 647ad15d5c3c..91cffc051055 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -646,16 +646,18 @@ static const char * const gpio_groups[] = {
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
 
-	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
-	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
-	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
-	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N",
-
 	"DIF_0_P", "DIF_0_N", "DIF_1_P", "DIF_1_N",
 	"DIF_2_P", "DIF_2_N", "DIF_3_P", "DIF_3_N",
 	"DIF_4_P", "DIF_4_N"
 };
 
+static const char * const gpio_aobus_groups[] = {
+	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
+	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
+	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
+	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N"
+};
+
 static const char * const sd_a_groups[] = {
 	"sd_d0_a", "sd_d1_a", "sd_d2_a", "sd_d3_a", "sd_clk_a",
 	"sd_cmd_a"
@@ -871,6 +873,7 @@ static struct meson_pmx_func meson8b_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8b_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.2

