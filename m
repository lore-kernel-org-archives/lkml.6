Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A7C46466
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oz32aOzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9619A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbeHALpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:45:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbeHALpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:45:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so19481316wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uW+eatmHxK9liMsreOsDXjGltRq9gJbcnas+7BZDc6o=;
        b=oz32aOznlxpzo6M5L34E9qUE1uNRcQjybrYQIVlFbPfku+aH8xDYNCW34LT/p8Rh12
         ykWgszxnU1sPFrUjH2eBViAivPT69vEZRns+7kBh/DAaLPWFd7yGrP9BwxaFnuImeNvg
         u0O67ECOy7tjVtS+HWKFpP/1opjNeGayORAn6DqD5TDb5sEPkthYSXPiKyP03JckS224
         YRSNbmYOFpPd+fhsmh7id0CJRIvia7Vscy8pnd/2AZvYp4qibX6MNGrrb9jD+oC5K0al
         8gNV/eYi6++m3I/00Gy/nVacLbpA1FtsabZ5fAmNAjXTV/8UgQNDrS1/nXK85OU+olWh
         zDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uW+eatmHxK9liMsreOsDXjGltRq9gJbcnas+7BZDc6o=;
        b=pyAFgXd4HX++K6RPHfbf7ZyHb2+fpch814w/7K1M0pJPu3CCbKyqFUtkyVtpVUbrZ/
         vIbtTG6g03Z0+xRoi0RQ+02aeqKTseE5hOf40Rxfc2ShGX5KkCFG6BIimLGDpMuhrr9L
         jP5ho8Wd9W/g21HExF3yYYSIsRR7PEK6ap7PGKTPeNpvTRSlqaiYepzpxlKieGF54MZY
         N3Blp2f9wP2gKJBK9fG3tIRXlJroTi6ump0LrdcjNrsJe435bxgFM35tYjahkfkkA11o
         +mDfEJK70e715U4KSFe7RihC0oJLNOtRbLZQxFTjgM4CAXR8Ma+oC2YN8oSoekp54zP5
         7tDQ==
X-Gm-Message-State: AOUpUlFAFv/N6GwT4wyNffUQV7Cs3NRUKbehkR+hL3+z+XdxynnF4/2D
        rkDwx9r97eN5zgzgXpSyJVeVtg==
X-Google-Smtp-Source: AAOMgpfqTZetwfJaZSTuSiGTAi0Xp4+g6Rjbk4aYHyGngl/H3Wm3td1j2iPSQI48TyJpI30S3Beg9g==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr24758551wrn.174.1533117634474;
        Wed, 01 Aug 2018 03:00:34 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6317067wmd.46.2018.08.01.03.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:00:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] meson: pinctrl-axg: add support for TEST_N pin
Date:   Wed,  1 Aug 2018 12:00:23 +0200
Message-Id: <1533117623-27856-6-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson AXG SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 46a0918..12615d8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson-axg-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_axg_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -1006,6 +1007,9 @@ static struct meson_bank meson_axg_periphs_banks[] = {
 static struct meson_bank meson_axg_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pmx_bank meson_axg_periphs_pmx_banks[] = {
-- 
2.7.4

