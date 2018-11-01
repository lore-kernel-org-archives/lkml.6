Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CEECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3C20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxE7w3ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A3C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeKAJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:55:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53725 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:55:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id v24-v6so7567wmh.3;
        Wed, 31 Oct 2018 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCCaHXvijIiAzo5CiyBcFqYv52WTzp8fRwRJ9sFKKL8=;
        b=HxE7w3ZWR0soQMvtPZztLmguJxyhhttqpcv7oOqmAyqNhTTArD6UQ3h6/pZWPjIW3k
         VfBMT7FV5VCt1boXW9zdJdXxUdyrEBxn+HeqYvMWSdqaXGsaxd6toOqDyq8NyCyRQWpn
         Joat5XPSq2O1iJlOSXKEGfR90ZI1r0yXO3XoCjWGPwA283Q71F6z+PWX2LmmJqB2yVwC
         b9JU/wbsOMa+5wl17KcDlkaQN/fiYC34hr05WOWCmSrddDAvCtanqlpmg31B4Wj6sZ/E
         R2mXAOq//ndKHUHyGLNmGdOWME4v583BB7yWmW8cquQkzeoZe/K1ODUW6RqFQVrxGEnD
         4kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCCaHXvijIiAzo5CiyBcFqYv52WTzp8fRwRJ9sFKKL8=;
        b=RRgAkyHy4THVRAL694MwhVuIrNaRuN+dg2yy7M+h51RaG2t/ZqowqFEVejjeuFLqeo
         CTbo9tmJX5feWPk2kSRpMD0IzNemCOv8RA/ErR3Ad9ItmCmwpiAIM/jc2g6MzMgGgXhk
         KLjv00Md/thw7UGHc8ezwBug5DU/20QtHcC2NMf4vF3r3ss1z7Vgbcs+Bs/9ROEybgRn
         KaaXUdTGPPMGEDuqymGurnwiejDFIWI9v7nHTWz6mwiUMxnkaisOmxvng77KtZN5AQNb
         9kO2nh9/wdHANII5RQRArLHAIMHpET/f4HIwPg7sjy+A/5hVzLO83b+yKuy+W4KmDYg7
         Niog==
X-Gm-Message-State: AGRZ1gL+WxAaorrdOUYVW/0CeYKR2KKuRI05mWFmKYLJmkr34OlxTT0p
        avW0uO+EOLnPUAR33EQ/afc=
X-Google-Smtp-Source: AJdET5cwEuI/1MnoFqinQOe2yvlt3YupcRa9GDze3bOGiG9QuAiE91qVVQ92d+xxRJx5WJl1SOSO4g==
X-Received: by 2002:a1c:cf02:: with SMTP id f2-v6mr4338280wmg.34.1541033711844;
        Wed, 31 Oct 2018 17:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d11sm3232986wrx.78.2018.10.31.17.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:55:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rtc: omap: Use define directive for PIN_CONFIG_ACTIVE_HIGH
Date:   Wed, 31 Oct 2018 17:55:02 -0700
Message-Id: <20181101005502.9171-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/rtc/rtc-omap.c:574:21: warning: implicit conversion from
enumeration type 'enum rtc_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        {"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
        ~                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/rtc/rtc-omap.c:579:12: warning: implicit conversion from
enumeration type 'enum rtc_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        PCONFDUMP(PIN_CONFIG_ACTIVE_HIGH, "input active high", NULL, false),
        ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

Link: https://github.com/ClangBuiltLinux/linux/issues/144
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/rtc/rtc-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 320b4a520eb3..bbff0e2deb84 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -566,9 +566,7 @@ static const struct pinctrl_ops rtc_pinctrl_ops = {
 	.dt_free_map = pinconf_generic_dt_free_map,
 };
 
-enum rtc_pin_config_param {
-	PIN_CONFIG_ACTIVE_HIGH = PIN_CONFIG_END + 1,
-};
+#define PIN_CONFIG_ACTIVE_HIGH		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params rtc_params[] = {
 	{"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
-- 
2.19.1

