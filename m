Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeE1ReZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:34:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40533 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeE1ReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:34:20 -0400
X-Google-Smtp-Source: AB8JxZo1bBsoxTbn3L0Zkw8AMP7u3u0DqXjZjcpIp4AQY7Cc0cu3uMHLQxM3iEiH32NUvRacpwmG+A==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.dider@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH 0/5] Reintroduce i.MX EPIT Timer
Date: Mon, 28 May 2018 19:34:07 +0200
Message-Id: <20180528173412.10000-1-peron.clem@gmail.com>
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

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---

Clément Peron (2):
  ARM: imx: remove inexistant EPIT timer init
  Documentation: DT: add i.MX EPIT timer binding

Colin Didier (3):
  ARM: clk-imx6q: add EPIT clock support
  clocksource: add driver for i.MX EPIT timer
  ARM: dts: imx6qdl: add missing compatible and clock properties for
    EPIT

 .../devicetree/bindings/clock/imx6q,epit.txt  |  25 ++
 arch/arm/boot/dts/imx6qdl.dtsi                |  12 +
 arch/arm/mach-imx/common.h                    |   1 -
 drivers/clk/imx/clk-imx6q.c                   |   2 +
 drivers/clocksource/Kconfig                   |  12 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-imx-epit.c          | 254 ++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
 8 files changed, 309 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt
 create mode 100644 drivers/clocksource/timer-imx-epit.c

-- 
2.17.0
