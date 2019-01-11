Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZjcIYX6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfAKRWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39241 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfAKRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so3097423wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5d4Pl0ken6pXZX1p6S5lDG8psK/cN8ZLaLkv7xqp5gU=;
        b=ZjcIYX6z+7gmHH48U+8QqXnpq9exWw1Chs3QOusA6jXqa85nGYJ+rsv5dOKU1vNGCV
         N4ftQcJBzzie8M5aCMMuX6zgSSnI6ggk0Udd8EZFbSojt6fcJWySo99EfCj+14wsmg3A
         60ucsqxz/E0Ai6Hkomdk2vrbkOtKoSnob/RtsSgIrVyQxHDOsEot11iEk8xTvh3J9K1r
         9KfS3QQQkbq2ZocV5LVT0pAt/KbwFEbGUvE7eb0aqcncvwRsQ6CmNQnLWbQezxJygkMA
         Txu8keeDpH4IoE2oEKPUeBEENeTDIjsXKgfRNKoD4Fc0X5oQF1BZPZWm2bfud2RVNW1Z
         Dbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5d4Pl0ken6pXZX1p6S5lDG8psK/cN8ZLaLkv7xqp5gU=;
        b=GIISExzbbQrfcVITGLZMgFt6xEbnwxbs91tvbZq1F/VYApIacDJAR4+L9EAMrUjHMu
         5trQJJ4S7g+oWaqyVI9jgbZdatsyMutxvk3xwWst9Ig8O8rWpuz67z9WzpXtZV/ZPrOb
         5XVm8ZjpoHPsbOfmruyG7eqD2fz5ou7TbFSK+Y/Mavva24duVHZ56xHsIhAL1UjCKGlX
         l0F2gwTQlA9Z/dzC6x6zyvLzOw5s5DKhwZ+KyOHwsS56PvbBqCIPgylgaR7Y+55J1srF
         9iepSs9jQbxCxpOohzDxPl41L9+Z5P/piWwGapI8msd1NMLHn7cKjqdaYcnBQt72kSaJ
         ZrEQ==
X-Gm-Message-State: AJcUukc2g3KE2Ak9DhZyWKdGIGNsTiBilShNJCn0H2xAT5Nf4eQCwO2O
        vCnWhxIZHeCc/uMB9BGdcf7fuw==
X-Google-Smtp-Source: ALg8bN6kScczA65jwRPm8nMMtox2hVlUgH8vKdEggfvhVcOqMebYDC+oQ+YD0/pGrVRZKQH6CrEpQQ==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr2914717wmg.21.1547227321283;
        Fri, 11 Jan 2019 09:22:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/17] ARM: davinci: dm646x: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:26 +0100
Message-Id: <20190111172134.30147-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm646x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7dc54b2a610f..018315fa9aa9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -665,6 +665,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	dm646x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

