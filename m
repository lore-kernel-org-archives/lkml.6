Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeBSLVx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:21:53 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53193 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBSLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:52 -0500
X-Google-Smtp-Source: AH8x226N3miZSPj6lIbZpP173YudU+vB2od8KZzSrww8uqXabCJw2O0FEI1S5iLfCDqWLQysjpyoqA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] clk: meson: second round of updates
Date: Mon, 19 Feb 2018 12:21:35 +0100
Message-Id: <20180219112146.21746-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset applies on top of the previous updates series
available here [0].

Most of the changes proposed here are related to the plls of meson
SoCs. Details can be found in each patches but, in nutshell, there
is :
* a bit of clean-up,
* improved pll capabilities using the frac parameter,
* several clocks added to model the tree more accurately.

Beware: patch #10 depends on this core clock framework fix: [1]
As explained in the description on the patch, if the gates are
added w/o this fix, the system will crash when
clk_disable_unused() is called.

[0]: https://lkml.kernel.org/r/20180212145846.19380-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180214134340.17242-5-jbrunet@baylibre.com

Jerome Brunet (11):
  clk: meson: add fractional part of meson8b fixed_pll
  clk: meson: poke pll CNTL last
  clk: meson: remove special gp0 lock loop
  clk: meson: improve pll driver results with frac
  clk: meson: add gp0 frac parameter for axg and gxl
  clk: meson: add ROUND_CLOSEST to the pll driver
  clk: meson: axg: add hifi clock bindings
  clk: meson: axg: add hifi pll clock
  clk: meson: add mpll pre-divider
  clk: meson: add fdiv clock gates
  clk: meson: clean-up clk81 clocks

 drivers/clk/meson/axg.c              | 184 +++++++++++++++++++++++++++++++----
 drivers/clk/meson/axg.h              |   8 +-
 drivers/clk/meson/clk-pll.c          | 154 ++++++++++++++++++-----------
 drivers/clk/meson/clkc.h             |  15 +--
 drivers/clk/meson/gxbb.c             | 141 +++++++++++++++++++++++----
 drivers/clk/meson/gxbb.h             |  10 +-
 drivers/clk/meson/meson8b.c          | 128 ++++++++++++++++++++----
 drivers/clk/meson/meson8b.h          |   8 +-
 include/dt-bindings/clock/axg-clkc.h |   1 +
 9 files changed, 521 insertions(+), 128 deletions(-)

-- 
2.14.3
