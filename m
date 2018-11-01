Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B45C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1160A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYVb5MLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1160A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeKBAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:05:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39526 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeKBAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:05:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so20399514wrv.6;
        Thu, 01 Nov 2018 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVLYTEuFoqpcrXktMWrcWMbHYKBIdrT+w4l3k60KHrg=;
        b=GYVb5MLlAwd3qaZi9jpiISVmnxZulvJkShjGJ9M0oAXXa9bM35WKcw+3SP8y5XGo/x
         guE7oOBqTpPB/CUdLuGCSG9amKWRVEWsuhCm58smQtiqwATrmy+1n01fsd8hUtcOYC1p
         iaiLOdr/Nkq8ZZtsWFOQZR3vAaD20wZwM4eomIvcFrfOQzuLmW16OXUSDHTOYbQvIpc7
         S/blhffhNPclaQOJBetswgd6R1zn40yF+KOIYGBgNUbYqeeE8aQgD6V1eKHBHCB8lnLv
         KQxAmiG+Jz9AKEjJ4W5B3hfh85993wZQrywpbZJGa1cGwPVqOLDDYqFkOpuc5Q9lIcKk
         ei1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVLYTEuFoqpcrXktMWrcWMbHYKBIdrT+w4l3k60KHrg=;
        b=WDzKnj+21m3PPV7L+5eLBAdA7j0s845s+nVVGG+W7m2drJ+jbxKgwuwehMZ6Vocy7b
         mIk5Bo7+QhuV5qk2QuSgOvGRG334XNQB9Dl6xA5tETXevFuIFpGNTmuIEmWCSY2moJoI
         MW6kV++7mC7oRo0uLWpYR/liYlFUW8niEKQjjP9Ob7HA4rh4qZdr+d+SRPRN6wsyH27Q
         QozgRKmH3qOni9j+aSUqHa2wzOcbhZFiahXJAVQ5/8b9UYZ7UPNjNkvWNSpJHkdhsHd1
         YaEydx6UR0Pd3yqoi+9X3qHCCJCxs1eBtwjUuant1pjfa4NsnWvnaUEpmiA95vBFIhCi
         bpag==
X-Gm-Message-State: AGRZ1gIEeCwqYD25EuK6mpjgiw3y32dE6JoUqT+jaRDUOiOMq/PaXiFB
        j75jBbd+JY4rmFReufYfwsM=
X-Google-Smtp-Source: AJdET5cmo54vankVbSSk0W6LSCL2ESOT1oqWdZ3flxHG/15XpOjj+OAcqEWM3mLv7MFYHH08s+gnQw==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr6450985wrd.273.1541084531214;
        Thu, 01 Nov 2018 08:02:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t14-v6sm22117924wra.63.2018.11.01.08.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:02:10 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] pinctrl: lpc18xx: Use define directive for PIN_CONFIG_GPIO_PIN_INT
Date:   Thu,  1 Nov 2018 08:00:08 -0700
Message-Id: <20181101150007.14145-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101005257.8778-1-natechancellor@gmail.com>
References: <20181101005257.8778-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
from enumeration type 'enum lpc18xx_pin_config_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
        ~                          ^~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
from enumeration type 'enum lpc18xx_pin_config_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
        ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
macro 'PCONFDUMP'
        .param = a, .display = b, .format = c, .has_arg = d     \
                 ^
2 warnings generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/140
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Improve comment so kernel-doc doesn't warn.

 drivers/pinctrl/pinctrl-lpc18xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index a14bc5e5fc24..06be55dab341 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -630,14 +630,8 @@ static const struct pinctrl_pin_desc lpc18xx_pins[] = {
 	LPC18XX_PIN(i2c0_sda, PIN_I2C0_SDA),
 };
 
-/**
- * enum lpc18xx_pin_config_param - possible pin configuration parameters
- * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt
- * 	controller.
- */
-enum lpc18xx_pin_config_param {
-	PIN_CONFIG_GPIO_PIN_INT = PIN_CONFIG_END + 1,
-};
+/* PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt controller */
+#define PIN_CONFIG_GPIO_PIN_INT		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params lpc18xx_params[] = {
 	{"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
-- 
2.19.1

