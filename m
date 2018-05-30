Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeE3MD5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:03:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53005 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeE3MDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:03:53 -0400
X-Google-Smtp-Source: ADUXVKLNZDJnJQh1r/Dbi32F1jF7MDsg8PkU86L08bX5Yd6Cl+wn0hj33yHEMRDlzBDy46RI6nq5bQ==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v4 0/5] Reintroduce i.MX EPIT Timer
Date: Wed, 30 May 2018 14:03:22 +0200
Message-Id: <20180530120327.27681-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

As suggested in the commit message we have added the device tree support,
proper bindings and we moved the driver into the correct folder.

Moreover we made some changes like use of relaxed IO accesor,
implement sched_clock, delay_timer and reduce the clockevents min_delta.

Changes since v3:
- Clean Kconfig
- Rename imx6q-epit to imx31-epit
- Update doc and bindings
- Indent and fix

Changes since v2 (Thanks Fabio Estevam):
- Removed unused ckil clock
- Add out_iounmap
- Check and handle if clk_prepare_enable failed
- Fix comment typo

Changes since v1 (Thanks Vladimir Zapolskiy):
- Add OF dependency in Kconfig
- Sort header
- Use BIT macro
- Remove useless comments
- Fix incorrect indent
- Fix memory leak
- Add check and handle possible returned error

Clément Peron (2):
  ARM: imx: remove inexistant EPIT timer init
  Documentation: DT: add i.MX EPIT timer binding

Colin Didier (3):
  clk: imx6: add EPIT clock support
  clocksource: add driver for i.MX EPIT timer
  ARM: dts: imx6qdl: add missing compatible and clock properties for
    EPIT

 .../devicetree/bindings/timer/fsl,imxepit.txt |  24 ++
 arch/arm/boot/dts/imx6qdl.dtsi                |  10 +
 arch/arm/mach-imx/common.h                    |   1 -
 drivers/clk/imx/clk-imx6q.c                   |   2 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-imx-epit.c          | 281 ++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
 8 files changed, 332 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
 create mode 100644 drivers/clocksource/timer-imx-epit.c

-- 
2.17.0
