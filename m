Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FE7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92BE20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAHrnddI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92BE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503687AbeKWWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:01:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39274 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKWWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so8467895lfh.6;
        Fri, 23 Nov 2018 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dnm9e3ZHO3/jCt83r6fUUrfYu0u62tujmgy9U8Ise4c=;
        b=cAHrnddIxS7rQNUHpTiCRPhDYfde/4HOBFvd7kv2DQ2NMbTVDc7aO05OHDHVemKUf+
         fkOKKB/DnGKRedjfvtM+5zH83JmMI34fC05aYPzZZNtXvRTbmgBZvio/gluvNBIXb6Kj
         bzJk8ZUunGObRWFKT5IkRnfvvsFatowzi8MGtYnKuEfpF+GOcX3RgTI9dTvjvMcIeWcB
         YNqhNSGSPjtUGR8/5Di23BVx+ulfBZpjDCldemDdOrqD51uNmx3yq39bYNrd9qXlqZki
         PMKHkEXzuWGkBjFDEnYs3xu7wHNJIH3s+ORR21r24oGqFAGP2vjuajwszsfYxxpOkPZl
         YpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dnm9e3ZHO3/jCt83r6fUUrfYu0u62tujmgy9U8Ise4c=;
        b=c+IuJuBYa5VASIPKqlrvt29HXmOzMRml2LnZcbRd9oat9k8H0RVkeWUHcTpGpaC2d1
         1huLDcLDSQQDVxIwsKdxROCbRqFR2zTkO9EEcDum/yjbx0KFzZVOKycAoKQydD2GlYBx
         bywSEBdNSXnP6ggCj0a6OlLLnpMlcZLGpH72ZVBZhfj4UGHRwd7L+I8/lVAcPALV96sA
         rgMhipKm2unH2HC7Hmt6ZRWY1PFdqccFyiBdYx2cAys2jIiNlanRn/ZIWNNu+UgmasFU
         5iYbCkaVRl/RcRUTDcV6g5qL1B1+ZwmiVrGLsRsRaVLDF9FO67w74lHUjYHtr+hrhr72
         hS6w==
X-Gm-Message-State: AGRZ1gI39kVpsTWrsRKI1gJvpS/44EHWzf3LakKrMH+XTRPrWIxIIoXH
        jkxsqFxjIwmQo3EKe4sJ0WU=
X-Google-Smtp-Source: AJdET5eZdgEHYR/TvnZc1+THnBimfAfkLO6coNSwntmoa2PAUhobToxyWcIRR4AaK5XgybKaId+llw==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr9358432lfa.32.1542971878521;
        Fri, 23 Nov 2018 03:17:58 -0800 (PST)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id x21sm4227994lfe.6.2018.11.23.03.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 03:17:57 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix audio permanently muted
Date:   Fri, 23 Nov 2018 12:19:45 +0100
Message-Id: <20181123111945.6016-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
pin "hookflash1", apparently set high regardless of the corresponding
bit of "latch2" port attempted to be set low during .init_machine(),
has been identified as the reason.

According to Amstrad E3 wiki, the purpose of the pin hasn't been
clearly identified.  Original Amstrad software used to produce a high
pulse on it when the phone was taken off hook or recall was pressed.
With the current finding, we can assume the pin provides a kind of
audio mute function.

Proper resolution of the issue should be done in two steps:
- resolution of an issue with the pin state not reflecting the value
  the corresponding bit of the port was attempted to be initialized
  with,
- extension of on-board audio driver with a new control.

For now, rename the pin to "audio_mute" to reflect its function and,
as a quick fix, hogg it as output low so on-board audio can produce
audible sound again.

Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 3d191fd52910..1d801f5e8308 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -247,8 +247,8 @@ static struct platform_device latch2_gpio_device = {
 #define LATCH2_PIN_SCARD_CMDVCC		11
 #define LATCH2_PIN_MODEM_NRESET		12
 #define LATCH2_PIN_MODEM_CODEC		13
-#define LATCH2_PIN_HOOKFLASH1		14
-#define LATCH2_PIN_HOOKFLASH2		15
+#define LATCH2_PIN_AUDIO_MUTE		14
+#define LATCH2_PIN_HOOKFLASH		15
 
 static struct regulator_consumer_supply modem_nreset_consumers[] = {
 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
@@ -588,6 +588,8 @@ static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
 static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
 		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_AUDIO_MUTE, "audio_mute",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
 	{},
 };
 
-- 
2.18.1

