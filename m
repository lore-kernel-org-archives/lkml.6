Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755376AbeDYQdN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:33:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36987 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeDYQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:10 -0400
X-Google-Smtp-Source: AB8JxZrVtP1Y8t2fDHdzsRZLI3Fpvz4AanH0a3mmc3imeEUmcZYKb/XoZSaP4/5uV80ePca2j3/SWA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clk: meson: axg: add audio clock controller support
Date: Wed, 25 Apr 2018 18:32:57 +0200
Message-Id: <20180425163304.10852-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add support for the clock controller
dedicated to the audio subsystem found on A113 based SoCs

The series depends on the CLK_MUX_ROUND_CLOSEST fixes [0] and the duty
cycle support [1] making their way into CCF.

First patch is a clean-up of the meson clk Kconfig.
Then, there is 3 clock provider drivers for clocks found in the audio
The last 3 are for the clock controller itself.

[0]: https://lkml.kernel.org/r/152389589448.51482.15489333464741262913@swboyd.mtv.corp.google.com
[1]: https://lkml.kernel.org/r/20180420211141.28929-1-jbrunet@baylibre.com

Jerome Brunet (7):
  clk: meson: clean-up meson clock configuration
  clk: meson: add clk-phase clock driver
  clk: meson: add triple phase clock driver
  clk: meson: add axg audio sclk divider driver
  clk: meson: axg: export audio clock controller id bindings
  clk: meson: axg: document bindings for the audio clock controller
  clk: meson: axg: add the audio clock controller driver

 .../bindings/clock/amlogic,axg-audio-clkc.txt      |  56 ++
 drivers/clk/meson/Kconfig                          |  25 +-
 drivers/clk/meson/Makefile                         |   3 +
 drivers/clk/meson/axg-audio.c                      | 845 +++++++++++++++++++++
 drivers/clk/meson/axg-audio.h                      | 127 ++++
 drivers/clk/meson/clk-phase.c                      |  63 ++
 drivers/clk/meson/clk-triphase.c                   |  68 ++
 drivers/clk/meson/clkc-audio.h                     |  28 +
 drivers/clk/meson/clkc.h                           |   8 +
 drivers/clk/meson/sclk-div.c                       | 243 ++++++
 include/dt-bindings/clock/axg-audio-clkc.h         |  94 +++
 11 files changed, 1553 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 drivers/clk/meson/axg-audio.c
 create mode 100644 drivers/clk/meson/axg-audio.h
 create mode 100644 drivers/clk/meson/clk-phase.c
 create mode 100644 drivers/clk/meson/clk-triphase.c
 create mode 100644 drivers/clk/meson/clkc-audio.h
 create mode 100644 drivers/clk/meson/sclk-div.c
 create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h

-- 
2.14.3
