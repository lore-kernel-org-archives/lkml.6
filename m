Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A0C46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A08220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C6xmq3Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A08220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbeHALpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:45:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37789 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbeHALpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:45:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so1161890wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dKCpiYXulo0kPH2043KgLwLQAz9rpNhmMFF0a3/0vxA=;
        b=C6xmq3WhHQdiM/pb6xQSID6lTPHX49MMpGMFrg4OaglwO5EzDG6ysLwG0cmRZfu/NO
         jq4GQkI7+WTGJcX2agiumEB7Z1pR2tqZCvARViS/0HHBTYlHv56Za+ROi/VOU6JO8pwN
         B/xGTSv+ap5dPD4nntdoT1QxX9U+T7eZWKfJZZFLerhGrRZxx/Z9jnO32CLTfr9NyAQo
         +TY9TX+McmbXgHeOGAsk10QG7CUybhhBuMJrhoU88gQ8Jmc3HgKMEMiH7o6dfxeEPHcm
         gTF5N0iv1citaSHVSGDArxGtNmWMxCHMt7apd322pcsEN5tq5QB8aeB/KydeH8qdEKCW
         z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dKCpiYXulo0kPH2043KgLwLQAz9rpNhmMFF0a3/0vxA=;
        b=uDOKEYtryKxU2qS0NqkIBagM6eXIQG7UE17j14lFWcGgYzSPogTHp7izOhF4R/bkmi
         X/sh/rsmImRHyyLe/Qs8NOTSF1ZockMQPaDn8fhIrMF8Qqu9I12lmpaf5UlYewIGH/yn
         JbbrKRUnQEamMwUdnwOW3jsXXnT7+SCi19ygDukMvIZye1R2DygmGamBiqMtyV3e+prJ
         kV7Z9+fKh6wtbK5ZwDVNc7w2RTsZLtxVcTSoBkeb1fbrpq0qzLOvhcSdx7BFj4OWvcbg
         ALDurnBW3ntSiaaYcKNRuyoy2hnccAThWtgX20MbHrEsfwiGD3M77mwnH8zEnWmgHHUM
         vkoQ==
X-Gm-Message-State: AOUpUlFZAkB6Qk532nWbVA63VhQ19xuNyZIqh2Xu5F1tY0JjYpe4QZy4
        8zv8lptqhqhE92+bzRBkf2is6w==
X-Google-Smtp-Source: AAOMgpf8GNNIsy7ZBIII7Bo1J50fNFQZ/k96scoDbLX5JXxKv+nrrSNmD7msG9HtB1ISiLFuMlLr/A==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr23008055wrs.257.1533117632093;
        Wed, 01 Aug 2018 03:00:32 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6317067wmd.46.2018.08.01.03.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:00:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] meson: pinctrl-gxbb: add support for TEST_N pin
Date:   Wed,  1 Aug 2018 12:00:21 +0200
Message-Id: <1533117623-27856-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GXBB SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 2c97a2e0..c0954be 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson8-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -823,6 +824,9 @@ static struct meson_bank meson_gxbb_periphs_banks[] = {
 static struct meson_bank meson_gxbb_aobus_banks[] = {
 	/*   name    first      last       irq    pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
-- 
2.7.4

