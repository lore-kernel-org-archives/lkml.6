Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB8E20815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O417dTM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeLRV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:27:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44643 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:27:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so17391508wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=d633MXqq9B5mqhedKuSLaeu5bQtbQ4s+cZryrLeim68=;
        b=O417dTM6P1tJNiD5i5p/F0ysdVqCLvmoQhF9tQYL36bI+hFJWP/gJiNMSNBaauroyY
         k6sCWO6nvkgTGrPYdx9KIos2B1DDFTxlRG0Ouia33sJK8cwKtffnJlq+40/wmyHJllJk
         TZFcM1c12cbrxFcE6CPF7Wnpy77e8E72g77YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=d633MXqq9B5mqhedKuSLaeu5bQtbQ4s+cZryrLeim68=;
        b=JRbRbfjtF4HQ+DefEXEukJpiT88/athVd33ln/HYG9xYdYydhoZX1bCoS7T9N1WC+v
         eCgm8hVFWUFTw3LZRJG1PsIyc+vJDjHgByjCcpHuQ13bi9/mvuYSpnbC8G0A1+QP6dbu
         c2DE1sRWnqG2P72M/7t3wngMFmCGBEoINiFF48eSNl2zCZG3Aeah40FsQnpv73nY7y+D
         FD2Z1kNt7p9Lf1PKF4QWT9HWrQCNpITDsdRaqrrLs+52HQsndSt2KCBHD6VcgfOhcKJ9
         3zZzfHkYGa9k2hnUd099lRe6Ev6RZzIeqw7u0DyzN5Sj2TFOc3t0kj8txBElRUWiyanf
         J+GQ==
X-Gm-Message-State: AA+aEWbeKNdCi4CgbGyqOmqREAgMUWPRAzgwetvgliDJaciVbRDd9HmZ
        LMowpFgld6rPVDDqahFGKpXWtHcTMqs=
X-Google-Smtp-Source: AFSGD/WsuOpw7ps6y6zJAhNBvLjVWHoyxjlpmvcoH/pXti7EUQeQcbhBi2ogtVt8zGc7CF+jIMZMxg==
X-Received: by 2002:adf:c612:: with SMTP id n18mr15502012wrg.174.1545168458473;
        Tue, 18 Dec 2018 13:27:38 -0800 (PST)
Received: from [192.168.0.40] (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.googlemail.com with ESMTPSA id o16sm4169564wrn.11.2018.12.18.13.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:27:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timers for 4.21
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tao Ren <taoren@fb.com>, Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
Date:   Tue, 18 Dec 2018 22:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

these are the changes for the timers for 4.21:

 - Add the sched_clock for the arc timer (Alexey Brodkin)

 - Change the file timer names for riscv, rockchip, tegra20, sun4i and
meson6 (Daniel Lezcano)

 - Add the DT bindings for r8a7796, r8a77470 and r8a774a1 (Biju Das)

 - Remove the early platform driver registration for timer-ti-dm
(Bartosz Golaszewski)

 - Provide the sched_clock for the riscv timer (Anup Patel)

 - Add support for ARM64 for the imx-gpt and convert the imx-tpm to the
timer-of API (Anson Huang)

 - Remove useless irq protection for the imx-gpt (Clément Péron)

 - Remove a duplicate function name for the vt8500 (Dan Carpenter)

 - Remove obsolete inclusion of <asm/smp_twd.h> for the tegra20 (Geert
Uytterhoeven)

 - Demote the prcmu and the custom sched_clock for the dbx500 and the
ux500 (Linus Walleij)

 - Add a new timer clock for the RDA8810PL (Manivannan Sadhasivam)

 - Rename the macro to stick to the register name and add the delay
timer (Martin Blumenstingl)

 - Switch the bcm2835 to the SPDX identifier (Stefan Wahren)

 - Fix the interrupt register access on the fttmr010 (Tao Ren)

 - Add missing of_node_put in the initialization path on the
integrator-ap (Yangtao Li)


Enjoy your vacations and have a nice end-of-year celebration

  -- Daniel


The following changes since commit 7d9df98be66fec64349f9f1c9d3e896293fe7b45:

  clockevents: Remove unnecessary unlikely() (2018-11-05 14:22:54 +0100)

are available in the Git repository at:

  http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.21

for you to fetch changes up to 7f83a1327962b9b3712866db8cbafbdee239cce4:

  clocksource/drivers/rda: Add clock driver for RDA8810PL SoC
(2018-12-18 22:22:23 +0100)

----------------------------------------------------------------
Alexey Brodkin (1):
      clocksource/drivers/arc_timer: Utilize generic sched_clock

Anson Huang (3):
      clocksource/drivers/imx-gpt: Add support for ARM64
      clocksource/drivers/timer-imx-tpm: Convert the driver to timer-of
      clocksource/drivers/timer-imx-tpm: Specify clock name for timer-of

Anup Patel (1):
      clocksource/drivers/riscv_timer: Provide the sched_clock

Bartosz Golaszewski (1):
      clocksource/drivers/timer-ti-dm: Remove the early platform driver
registration

Biju Das (3):
      dt-bindings: timer: renesas, cmt: Document r8a7796 CMT support
      dt-bindings: timer: renesas, cmt: Document r8a77470 CMT support
      dt-bindings: timer: renesas, cmt: Document r8a774a1 CMT support

Clément Péron (1):
      clocksource/drivers/imx-gpt: Remove unnecessary irq protection

Dan Carpenter (1):
      clocksource/drivers/timer-vt8500: Remove duplicate function name

Daniel Lezcano (5):
      clocksource/drivers/riscv: Change name riscv_timer to timer-riscv
      clocksource/drivers/rockchip: Change name rockchip_timer to
timer-rockchip
      clocksource/drivers/tegra20: Change name tegra20_timer to
timer-tegra20
      clocksource/drivers/sun4i: Change name sun4i_timer to timer-sun4i
      clocksource/drivers/meson6: Change name meson6_timer timer-meson6

Geert Uytterhoeven (1):
      clockevents/drivers/tegra20: Remove obsolete inclusion of
<asm/smp_twd.h>

Linus Walleij (2):
      clocksource/drivers/dbx500: Demote dbx500 PRCMU clocksource
      clocksource/drivers/ux500: Drop Ux500 custom SCHED_CLOCK

Manivannan Sadhasivam (1):
      clocksource/drivers/rda: Add clock driver for RDA8810PL SoC

Martin Blumenstingl (2):
      clocksource/drivers/meson6_timer: Use register names from the
datasheet
      clocksource/drivers/meson6_timer: Implement the ARM delay timer

Stefan Wahren (1):
      clocksource/drivers/bcm2835: Switch to SPDX identifier

Tao Ren (1):
      clocksource/drivers/fttmr010: Fix invalid interrupt register access

Yangtao Li (1):
      clocksource/drivers/integrator-ap: Add missing of_node_put()

 .../devicetree/bindings/timer/renesas,cmt.txt      |  15 +-
 arch/arc/Kconfig                                   |   1 +
 drivers/clocksource/Kconfig                        |  26 ++-
 drivers/clocksource/Makefile                       |  11 +-
 drivers/clocksource/arc_timer.c                    |  22 +++
 drivers/clocksource/bcm2835_timer.c                |  15 +-
 drivers/clocksource/clksrc-dbx500-prcmu.c          |  22 +--
 drivers/clocksource/meson6_timer.c                 | 178 -----------------
 drivers/clocksource/nomadik-mtu.c                  |   4 -
 drivers/clocksource/timer-fttmr010.c               |  73 ++++---
 drivers/clocksource/timer-imx-gpt.c                |  21 +-
 drivers/clocksource/timer-imx-tpm.c                | 139 ++++++-------
 drivers/clocksource/timer-integrator-ap.c          |  25 ++-
 drivers/clocksource/timer-meson6.c                 | 220
+++++++++++++++++++++
 drivers/clocksource/timer-rda.c                    | 195 ++++++++++++++++++
 .../clocksource/{riscv_timer.c => timer-riscv.c}   |   9 +
 .../{rockchip_timer.c => timer-rockchip.c}         |   0
 .../clocksource/{sun4i_timer.c => timer-sun4i.c}   |   0
 .../{tegra20_timer.c => timer-tegra20.c}           |   1 -
 drivers/clocksource/timer-ti-dm.c                  |   1 -
 drivers/clocksource/timer-vt8500.c                 |   2 +-
 21 files changed, 600 insertions(+), 380 deletions(-)
 delete mode 100644 drivers/clocksource/meson6_timer.c
 create mode 100644 drivers/clocksource/timer-meson6.c
 create mode 100644 drivers/clocksource/timer-rda.c
 rename drivers/clocksource/{riscv_timer.c => timer-riscv.c} (94%)
 rename drivers/clocksource/{rockchip_timer.c => timer-rockchip.c} (100%)
 rename drivers/clocksource/{sun4i_timer.c => timer-sun4i.c} (100%)
 rename drivers/clocksource/{tegra20_timer.c => timer-tegra20.c} (99%)




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

