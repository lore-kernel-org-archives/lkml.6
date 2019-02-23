Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF1C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149720850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0grG6tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfBWNFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:05:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42597 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfBWNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:05:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so5165156wrg.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L3dZRLQAQxqb84D/lIPChQCwb66Hmu9og6IzCAv5N5I=;
        b=d0grG6tju6p1uo2DqBrSALkZX4YKQTBDYcTXsVQwK/4pKlxaemGUzJe4n66tyFvdrP
         9HAUR+7VTB/Z5BHIN57xgwVuWvPuMQFy3oXeyaRnwYa0U0QlJKJ57+3wAyho3KH/8QAd
         8RHzfIdaGt4MNOyU8Zh+yqSLoF4FXGp7WTlb2iuJ3OKkhFHJehvimVRHzQ6XKwCe/yWq
         IsR53GynFr3W2UpFb4H0oLQO37rnrcUDbcFgGveX4mzYipK7Pme3ylWtcw3ZZceWOgXv
         eNsJ4+TifL2JFZJnuay4Mt89kOhqBE1GRdAGmMZ8NKgBFTnw1HySMGzBmAaBDoQzRIjK
         EVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L3dZRLQAQxqb84D/lIPChQCwb66Hmu9og6IzCAv5N5I=;
        b=TvAxWforesXvvzHpgAPg5FwrKlkoTXaIBO9irwDRdhI5rIobhNQ625XcLrq2lOSlqZ
         pohxrK3KZltstOxsyWVa4N1wtRXuVeT4kb/atPhEVHdAJZQMdiwgeDPdJ+tfSfUTzb+f
         RVjJloxKiPi1332SrporwUu3BSayIDbFMyx6JzkjoAsSp6I6nwNOWXsNfZxp5tTwvGF1
         gQdT9UrHzMVnxWIKh9T894fw4g9lgVVAxyBzZ2AP1uCIolyui6rYopys3qUN16MTjDru
         hn+wlgKTB5Aqkz6S5k3FjNOAiM3gjUoxIhOoDarfOQb8QxOHbMmBPdJURESwEbRarvuK
         aZyQ==
X-Gm-Message-State: AHQUAuaNA0t8PdvEwBA7ELxgAF++zT3wechDe43OrDErbLXjwd7k7/8O
        npTYTGENE3+LlV6JjrobBBqiLHbcxQI=
X-Google-Smtp-Source: AHgI3IaFasaFysAsUjmUewPPWk9N2SeTcTnC1GIXT1ecImBi+T0hvlB02A1LhCSYRSSl1tpikl7yMQ==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr6600600wrm.263.1550927141723;
        Sat, 23 Feb 2019 05:05:41 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w12sm2843118wrr.67.2019.02.23.05.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:05:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Atish Patra <atish.patra@wdc.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clockevents for 5.1
Message-ID: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
Date:   Sat, 23 Feb 2019 14:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

this is a late pull request for clockevents 5.1.

 - Update the binding documentation for the gpt timer (Anson Huang)

 - Improve checking and error handling at init time on risc timer (Atish
Patra)

 - Update the binding documentation for r8a774c0 cmt and tmu (Biju Das)

 - Fail gracefully when clock rate is unavailable on sun5i (Chen-Yu Tsai)

 - Rename the tango-xtal, pxa and cs5535 to timer-*.c for consistency
(Daniel Lezcano)

 - Add the support for the tegra210 timer and add the platform's Kconfig
selection (Joseph Lo)

 - Do a cleanup in the header inclusions and remove the unused ones for
the exynos_mct timer driver (Krzysztof Kozlowski)

 - Remove some non-of dead code and fix the error path when initializing
the resources in the exynos_mct timer driver (Marek Szyprowski)

 - Update the DT bindings for the MT7629 (Ryder Lee)

 - Provide a workaround for the arm arch timer for Allwinner A64 timers
(Samuel Holland)

 - Clear the timer interrupt at shutdown time on the exynos_mct timer
driver (Stuart Menefy)


Thanks!

  -- Daniel

-----------------------------------------------------------------

The following changes since commit 75b710af7139768fd4ba2d4e05335d2344796279:

  timers: Mark expected switch fall-throughs (2019-01-29 20:08:42 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/5.1

for you to fetch changes up to f40f4fc9506d6b2b786920059b320aac3a831574:

  soc/tegra: default select TEGRA_TIMER for Tegra210 (2019-02-23
12:13:45 +0100)

----------------------------------------------------------------
Anson Huang (1):
      dt-bindings: timer: gpt: update binding doc

Atish Patra (1):
      clocksource/drivers/riscv: Add required checks during clock source
init

Biju Das (2):
      dt-bindings: timer: renesas, cmt: Document r8a774c0 CMT support
      dt-bindings: timer: renesas: tmu: Document r8a774c0 bindings

Chen-Yu Tsai (1):
      clocksource/drivers/sun5i: Fail gracefully when clock rate is
unavailable

Daniel Lezcano (3):
      clocksource/drivers/tango-xtal: Rename the file for consistency
      clocksource/drivers/timer-pxa: Rename the file for consistency
      clocksource/drivers/timer-cs5535: Rename the file for consistency

Joseph Lo (3):
      dt-bindings: timer: add Tegra210 timer
      clocksource/drivers/tegra: Add Tegra210 timer support
      soc/tegra: default select TEGRA_TIMER for Tegra210

Krzysztof Kozlowski (1):
      clocksource/drivers/exynos_mct: Remove unused header includes

Marek Szyprowski (2):
      clocksource/drivers/exynos_mct: Remove dead code
      clocksource/drivers/exynos_mct: Fix error path in timer resources
initialization

Ryder Lee (1):
      dt-bindings: timer: mediatek: update bindings for MT7629 SoC

Samuel Holland (1):
      clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer
instability

Stuart Menefy (2):
      clocksource/drivers/exynos_mct: Move one-shot check from tick
clear to ISR
      clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

 Documentation/arm64/silicon-errata.txt                            |   2 +
 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt            |  39
+++++--
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt    |  11 +-
 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt |  36
+++++++
 Documentation/devicetree/bindings/timer/renesas,cmt.txt           |   2 +
 Documentation/devicetree/bindings/timer/renesas,tmu.txt           |   1 +
 drivers/clocksource/Kconfig                                       |  13 ++-
 drivers/clocksource/Makefile                                      |   6 +-
 drivers/clocksource/arm_arch_timer.c                              |  55
++++++++++
 drivers/clocksource/exynos_mct.c                                  |  48
+++++----
 drivers/clocksource/{cs5535-clockevt.c => timer-cs5535.c}         |   0
 drivers/clocksource/{pxa_timer.c => timer-pxa.c}                  |   0
 drivers/clocksource/timer-riscv.c                                 |  23
++++-
 drivers/clocksource/timer-sun5i.c                                 |  10 ++
 drivers/clocksource/{tango_xtal.c => timer-tango-xtal.c}          |   0
 drivers/clocksource/timer-tegra20.c                               | 370
++++++++++++++++++++++++++++++++++++++++++++++--------------------
 drivers/soc/tegra/Kconfig                                         |   1 +
 include/linux/cpuhotplug.h                                        |   1 +
 18 files changed, 470 insertions(+), 148 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 rename drivers/clocksource/{cs5535-clockevt.c => timer-cs5535.c} (100%)
 rename drivers/clocksource/{pxa_timer.c => timer-pxa.c} (100%)
 rename drivers/clocksource/{tango_xtal.c => timer-tango-xtal.c} (100%)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

