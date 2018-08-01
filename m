Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BC6C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4266920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nV0JEEPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4266920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbeHALpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:45:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38330 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389028AbeHALpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:45:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so6318208wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtEVeGwd13XDLfsq1I81oTqBKNMFTLo0eMseg8KFGsA=;
        b=nV0JEEPL0DykgqL5mZKCigt2AH0nDlpFfGxu8LW7JRiL0f56JMPncRsNrxvKYkndvi
         uTex8VE6OFRZFrMqvH6pdT5Hyo1CUoxAIzjRRlBjndTnCblEBgSTnIE1CL/l3vEGrtb6
         gSTnjowhQoArdcaW5CvZKbCnJkg3G01DJaYn6kjKvUmV6smm8oiQ+q7SWpFpyCiVGVvZ
         a1PHy0zYBTGchz/rqOoQw84RGyMKZHkej1HbReU4Q0bq7O17oIN+3E3jq9bu2CCUzmZ8
         Oev4CVcwR0UA0IZP+0EjVv4g6jViU3tbOVrvUT3u/dofUJZHbOEl9A785XzysmjIZCnM
         l2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtEVeGwd13XDLfsq1I81oTqBKNMFTLo0eMseg8KFGsA=;
        b=b9VSFvxAlhxa+s+VAN5qjRHLfviFjLsZ9LnQ1MnKtqbymufPhbXAX8ZWRnIS/J+pr+
         0qc1wJ4qq5Obh/79QOawYQKqT9OWCJsTTPofgXklDU2Qd7LZ6TUlP3Jh32F1b/Ussn35
         PCh06oZzz+WSPjEFN+fqpDiZbxj5i0Ro97DxTsWTE/CIItWHLRdyjfwF/B89kAvVFFob
         gSqyCn5lWd3/yo7/v0NVNkpvWNmR56PBImaB9NkOmvx4jNBSmeK60I8eu9JYtkcxWov3
         1RqqbowILI8E9TFg6TupbE0nSu4Bb88DmWRgJjBK+sIow19KwxVZK+OjNujJ8YjnnGzG
         fUSg==
X-Gm-Message-State: AOUpUlGGbImi+pE26vwTliVpOWzUtUpv8/iC4bvv6wrb6vb9KnJ1aL0s
        mahy/w5ULStLBdw+jkqHL2bmcQ==
X-Google-Smtp-Source: AAOMgpfcReKjTlre5Fx11+Cndx1iOJwvn0XUrTVjW5px2JE0a3rl0iMM3iGLunsF0hrv12t+BVh+uA==
X-Received: by 2002:a1c:30c3:: with SMTP id w186-v6mr2111943wmw.153.1533117633292;
        Wed, 01 Aug 2018 03:00:33 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6317067wmd.46.2018.08.01.03.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:00:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] meson: pinctrl-gxl: add support for TEST_N pin
Date:   Wed,  1 Aug 2018 12:00:22 +0200
Message-Id: <1533117623-27856-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GXL & GXM SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 7dae1d7..d4dc42f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson8-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_gxl_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -808,6 +809,9 @@ static struct meson_bank meson_gxl_periphs_banks[] = {
 static struct meson_bank meson_gxl_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 9, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
-- 
2.7.4

