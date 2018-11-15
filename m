Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31582C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB17E22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvwlrzDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB17E22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeKOSIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46200 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOSIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so16461793ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FZo/WU/wfh2BElMjRxtfHFmffYHSyYmkaL3TP4/l1ww=;
        b=kvwlrzDC5KAz3lGZd2LJ9FzTIqRLOpHh/Hj0TVoFzBD4DOJIy5gviPng6FMe+zMz8l
         dBUc1lRwYQmIigY7gYEMziEHJx3LEEN6gewAax0iw5pvP7S68bc4yeoeB3HapcAijowY
         P45gSo/kOrwrtf9z6LeZsuQ0jd7RjPiirmJaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZo/WU/wfh2BElMjRxtfHFmffYHSyYmkaL3TP4/l1ww=;
        b=bb63TN8rPx4Y60QT3HxUTPgVDjF8xlpI5WSgj31vBSAF62uJ1lKE7L63dxYzgWfU5p
         aid7wyMJaJBBe3Ew6JAERlIjjgqBefjrqbwJbfxXzvWBZKuI8y9NmxM3MlP3Fhm6PE9Z
         nV1Qz2/BHlhsvGx+EfRJje963pDVWPcBT0LEPnijiOKiPRzv36rzyNY30C6LCM1VTqf5
         P3CpKvpLhCLsvSs6FVYZ0F+4KAQUpvnjVdxDiCilYYNlaHPVsSmnZCo79xNj9ChgtljG
         m8w2oljhbreiNsWSj8ydmS7ABoKdSiq8V+3+G/6Uq38w6KEP1eigt8s6RNJY6j9z8tAH
         ZeWw==
X-Gm-Message-State: AGRZ1gJB3ihp1xxD6oSNpfDQqzY7VaPnz2qZf6HmAdt5B0f1LmaclAbc
        Wdan4LndEZR/Hb5/ts959MYxSw==
X-Google-Smtp-Source: AJdET5cnrqThCTXIw+C8aBSGWXOg7liPemuXuMqmlN1xMApWGgBIOnv5W1C9Q0bpIv3zLbe6u02hfA==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr3309624ljj.18.1542268889398;
        Thu, 15 Nov 2018 00:01:29 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/8 v6] Finalize regulator descriptor work
Date:   Thu, 15 Nov 2018 09:01:16 +0100
Message-Id: <20181115080124.7789-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series finalizes the regulator descriptor work.

We do this by:

- Tidying up remaining drivers using .ena_gpio to pass
  descriptors.

- Converting the GPIO regulator to use descriptors and
  passing a descriptor for .ena_gpio.

- Pull in all inversion and open drain semantics into
  gpiolib.

- Deleting the legacy GPIO numberspace handling from
  the GPIO core.

The 0day build robot is happy with the series.

Linus Walleij (8):
  regulator: s2mps11: Pass descriptor instead of GPIO number
  regulator: wm8994: Pass descriptor instead of GPIO number
  regulator: max77686: Pass descriptor instead of GPIO number
  regulator: gpio: Convert to use descriptors
  regulator: fixed/gpio: Pull inversion/OD into gpiolib
  regulator: fixed/gpio: Update device tree bindings
  regulator: gpio: Simplify probe path
  regulator: core: Only support passing enable GPIO descriptors

 .../bindings/regulator/fixed-regulator.txt    |  13 +-
 .../bindings/regulator/gpio-regulator.txt     |   4 +
 arch/arm/mach-imx/mach-mx21ads.c              |   1 -
 arch/arm/mach-imx/mach-mx27ads.c              |   2 +-
 arch/arm/mach-mmp/brownstone.c                |   1 -
 arch/arm/mach-omap1/board-ams-delta.c         |   1 -
 arch/arm/mach-omap2/pdata-quirks.c            |   1 -
 arch/arm/mach-pxa/em-x270.c                   |   1 -
 arch/arm/mach-pxa/ezx.c                       |   3 +-
 arch/arm/mach-pxa/hx4700.c                    |  23 ++-
 arch/arm/mach-pxa/magician.c                  |  23 ++-
 arch/arm/mach-pxa/raumfeld.c                  |   1 -
 arch/arm/mach-pxa/zeus.c                      |   3 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |  17 +-
 arch/arm/mach-sa1100/assabet.c                |   1 -
 arch/sh/boards/mach-ecovec24/setup.c          |   2 -
 .../intel-mid/device_libs/platform_bcm43xx.c  |   1 -
 drivers/mfd/wm8994-core.c                     |   9 -
 drivers/regulator/core.c                      |  40 +---
 drivers/regulator/da9055-regulator.c          |   1 -
 drivers/regulator/fixed.c                     |  35 +---
 drivers/regulator/gpio-regulator.c            | 189 +++++++-----------
 drivers/regulator/max77686-regulator.c        |  19 +-
 drivers/regulator/s2mps11.c                   |  46 ++---
 drivers/regulator/wm8994-regulator.c          |  20 +-
 include/linux/mfd/wm8994/pdata.h              |   3 -
 include/linux/regulator/driver.h              |  12 +-
 include/linux/regulator/fixed.h               |  10 -
 include/linux/regulator/gpio-regulator.h      |  18 +-
 29 files changed, 205 insertions(+), 295 deletions(-)

-- 
2.17.2

