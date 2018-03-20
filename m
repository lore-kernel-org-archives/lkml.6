Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCTXG0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeCTXGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:06:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB732177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
From: sboyd@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.16-rc6
Date: Tue, 20 Mar 2018 16:06:21 -0700
Message-Id: <20180320230621.49819-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 7997f3b2df751aab0b8e60149b226a32966c41ac:

  clk: bcm2835: Protect sections updating shared registers (2018-03-19 09:27:37 -0700)

----------------------------------------------------------------
A late collection of fixes for regressions seen this release cycle.
Normally I send this earlier than now but real life got in the way.
Things are back to normal now.

There's the normal set of SoC driver fixes: i.MX boot warning, TI
display clks, allwinner clk ops being wrong (fun), driver probe
badness on error paths, correctness fix for the new aspeed driver,
and even a fix for a race condition in the bcm2835 clk driver.

At the core framework level we also got some fixes for the clk
phase API caching at the wrong time, better handling of the enabled
state of orphan clks, and a fix for a newly introduced bug in how we
handle rate calculations for pass-through clks.

----------------------------------------------------------------
Boris Brezillon (2):
      clk: bcm2835: Fix ana->maskX definitions
      clk: bcm2835: Protect sections updating shared registers

Chen-Yu Tsai (1):
      clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Eddie James (2):
      clk: aspeed: Fix is_enabled for certain clocks
      clk: aspeed: Prevent reset if clock is enabled

Fabio Estevam (1):
      clk: imx51-imx53: Fix UART4/5 registration on i.MX50 and i.MX53

Jerome Brunet (2):
      clk: migrate the count of orphaned clocks at init
      clk: fix determine rate error with pass-through clock

Shawn Lin (1):
      clk: update cached phase to respect the fact when setting phase

Stephen Boyd (5):
      Merge tag 'sunxi-clk-fixes-for-4.16' of https://git.kernel.org/.../sunxi/linux into clk-fixes
      Merge tag 'clk-imx-fixes-4.16' of git://git.kernel.org/.../shawnguo/linux into clk-fixes
      Merge tag 'ti-clk-fixes-4.16' of https://github.com/t-kristo/linux-pm into clk-fixes
      Merge branch 'clk-phase' into clk-fixes
      Merge branch 'clk-helpers' (early part) into clk-fixes

Tero Kristo (3):
      clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag
      clk: ti: am33xx: add set-rate-parent support for display clkctrl clock
      clk: ti: am43xx: add set-rate-parent support for display clkctrl clock

Wei Yongjun (2):
      clk: hisilicon: hi3660：Fix potential NULL dereference in hi3660_stub_clk_probe()
      clk: qcom: msm8916: Fix return value check in qcom_apcs_msm8916_clk_probe()

 drivers/clk/bcm/clk-bcm2835.c           | 12 ++++++---
 drivers/clk/clk-aspeed.c                | 28 ++++++++++++--------
 drivers/clk/clk.c                       | 46 ++++++++++++++++++++-------------
 drivers/clk/hisilicon/clk-hi3660-stub.c |  2 ++
 drivers/clk/imx/clk-imx51-imx53.c       | 20 +++++++++++---
 drivers/clk/qcom/apcs-msm8916.c         |  5 ++--
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c    |  6 ++---
 drivers/clk/ti/clk-33xx.c               |  2 +-
 drivers/clk/ti/clk-43xx.c               |  2 +-
 drivers/clk/ti/clkctrl.c                |  2 ++
 10 files changed, 81 insertions(+), 44 deletions(-)

-- 
