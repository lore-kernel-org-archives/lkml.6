Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeDCNAK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:00:10 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38904 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeDCNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:00:08 -0400
X-Google-Smtp-Source: AIpwx497AkC7iuZgcyZYlyfeUAPr/rk1LS+XSHXHEbI49XqKAnRKNdjkkvgNW1qaedFb4aXYMuZczw==
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Tomer Maimon <tmaimon77@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] clockevents for 4.17
Message-ID: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
Date: Tue, 3 Apr 2018 15:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

sorry for the late pull request.

It contains the following changes for 4.17:

 - Fix timer name and register flow for imx's timer tmp and handle
different counter width (Anson Huang)

 - Add the NPCM7xx timer support (Tomer Maimon)

Thanks

  -- Daniel




The following changes since commit bd03143007eb9b03a7f2316c677780561b68ba2a:

  alarmtimer: Init nanosleep alarm timer on stack (2018-03-29 16:10:07
+0200)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.17

for you to fetch changes up to 0136c741ff40e03323419feec05fcd594f36a463:

  clocksource/drivers/imx-tpm: Add different counter width support
(2018-03-30 22:44:11 +0200)

----------------------------------------------------------------
Anson Huang (4):
      dt-bindings: timer: tpm: fix typo of clock name
      clocksource/drivers/imx-tpm: Fix typo of clock name
      clocksource/drivers/imx-tpm: Correct some registers operation flow
      clocksource/drivers/imx-tpm: Add different counter width support

Tomer Maimon (2):
      dt-binding: timer: document NPCM7xx timer DT bindings
      clocksource/drivers/npcm: Add NPCM7xx timer driver

 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt |  21
++++++++++++++++++++
 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt         |   2 +-
 drivers/clocksource/Kconfig                                       |   8
++++++++
 drivers/clocksource/Makefile                                      |   1 +
 drivers/clocksource/timer-imx-tpm.c                               |  43
++++++++++++++++++++++++++++++----------
 drivers/clocksource/timer-npcm7xx.c                               | 215
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 279 insertions(+), 11 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
 create mode 100644 drivers/clocksource/timer-npcm7xx.c


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
