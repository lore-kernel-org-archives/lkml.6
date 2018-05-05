Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeEEBzu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEEBzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:55:49 -0400
From: sboyd@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.17-rc3
Date: Fri,  4 May 2018 18:55:46 -0700
Message-Id: <20180505015546.133327-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to c964cfc612b59910593fa10ee1c2673db274c9c7:

  Merge tag 'meson-clk-fixes-4.17-1' of https://github.com/BayLibre/clk-meson into clk-fixes (2018-05-01 14:44:16 -0700)

----------------------------------------------------------------
A handful of fixes for the stm32mp1 clk driver came in during the merge
window for the driver that got merged in the merge window. Plus a
warning fix for unused PM ops and a couple fixes for the meson clk
driver clk names that went unnoticed with the regmap rework. There's
also another fix in here for the mux rounding flag which wasn't doing
what it said it did, but now it does.

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: cs2000: mark resume function as __maybe_unused

Gabriel Fernandez (6):
      clk: stm32mp1: add missing static
      clk: stm32mp1: remove unused dfsdm_src[] const
      clk: stm32mp1: fix SAI3 & SAI4 clocks
      clk: stm32mp1: add missing tzc2 clock
      clk: stm32mp1: set stgen_k clock as critical
      clk: stm32mp1: remove ck_apb_dbg clock

Jerome Brunet (2):
      clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
      clk: meson: honor CLK_MUX_ROUND_CLOSEST in clk_regmap

Martin Blumenstingl (2):
      clk: meson: meson8b: fix meson8b_fclk_div3_div clock name
      clk: meson: meson8b: fix meson8b_cpu_clk parent clock name

Stephen Boyd (2):
      Merge branch 'clk-stm32mp1' into clk-fixes
      Merge tag 'meson-clk-fixes-4.17-1' of https://github.com/BayLibre/clk-meson into clk-fixes

Yixun Lan (1):
      clk: meson: drop meson_aoclk_gate_regmap_ops

 drivers/clk/clk-cs2000-cp.c               |  2 +-
 drivers/clk/clk-mux.c                     | 10 +++++-
 drivers/clk/clk-stm32mp1.c                | 54 +++++++++++++------------------
 drivers/clk/clk.c                         |  7 ++--
 drivers/clk/meson/clk-regmap.c            | 11 ++++++-
 drivers/clk/meson/gxbb-aoclk.h            |  2 --
 drivers/clk/meson/meson8b.c               |  5 +--
 include/dt-bindings/clock/stm32mp1-clks.h |  4 +--
 include/linux/clk-provider.h              |  3 ++
 9 files changed, 55 insertions(+), 43 deletions(-)

-- 
Sent by a computer through tubes
