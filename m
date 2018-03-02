Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936270AbeCBLsD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:48:03 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43041 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936210AbeCBLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:47:59 -0500
X-Google-Smtp-Source: AG47ELvv9uQ5OUKSjNp/7sG9I5ZOLn2t8BzAEibj228+WfcKe+TzHWayhieSopJ2RJbpaU0LkzdFng==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.16-rc4
Date: Fri,  2 Mar 2018 12:47:55 +0100
Message-Id: <1519991275-31436-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with some MMC fixes intended for v4.16-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16-rc3

for you to fetch changes up to 3a574919f0cc15a46ec14c3e5e08300908991915:

  mmc: core: Avoid hanging to claim host for mmc via some nested calls (2018-02-27 15:12:37 +0100)

----------------------------------------------------------------
MMC core:
 - mmc: core: Avoid hang when claiming host

MMC host:
 - dw_mmc: Avoid hang when accessing registers
 - dw_mmc: Fix out-of-bounds access for slot's caps
 - dw_mmc-k3: Fix out-of-bounds access through DT alias
 - sdhci-pci: Fix S0i3 for Intel BYT-based controllers

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers

Geert Uytterhoeven (1):
      mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias

Shawn Lin (3):
      mmc: dw_mmc: Factor out dw_mci_init_slot_caps
      mmc: dw_mmc: Fix out-of-bounds access for slot's caps
      mmc: dw_mmc: Avoid accessing registers in runtime suspended state

Ulf Hansson (1):
      mmc: core: Avoid hanging to claim host for mmc via some nested calls

 drivers/mmc/core/mmc_ops.c         |  4 --
 drivers/mmc/host/dw_mmc-exynos.c   |  1 +
 drivers/mmc/host/dw_mmc-k3.c       |  4 ++
 drivers/mmc/host/dw_mmc-rockchip.c |  1 +
 drivers/mmc/host/dw_mmc-zx.c       |  1 +
 drivers/mmc/host/dw_mmc.c          | 84 ++++++++++++++++++++++++--------------
 drivers/mmc/host/dw_mmc.h          |  2 +
 drivers/mmc/host/sdhci-pci-core.c  | 35 ++++++++++++++--
 8 files changed, 94 insertions(+), 38 deletions(-)
