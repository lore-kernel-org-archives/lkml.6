Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754165AbeDMKVx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:21:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45183 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbeDMKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:21:51 -0400
X-Google-Smtp-Source: AIpwx4+C4wrGkvYv5XHUOORwzjWkec9Hg0Ez9X9DSChdvmbZAtPPY/ArfLHtWWHURqg4+8BM/Hljkg==
Date: Fri, 13 Apr 2018 03:21:48 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL V2] Thermal SoC management updates for v4.17-rc1
Message-ID: <20180413102146.GA22346@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

Please find thermal-soc changes for v4.17-rc1 as follows.

- New i.MX7 thermal sensor
- Mediatek driver now supports MT7622 SoC
- Removal of min max cpu cooling dt property

Differences in V2:
- Reordered the patches to drop exynos changes for now until we get
agreement on the fix on that driver for the compilation warns
caused by the confusing conversion functions.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 82709e9467829e4e0dbcc6a0dd6fb01901d3f45b:

  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties (2018-04-13 03:05:35 -0700)

----------------------------------------------------------------
Anson Huang (1):
      thermal: imx: add i.MX7 thermal sensor support

Bartlomiej Zolnierkiewicz (1):
      dt-bindings: thermal: remove no longer needed samsung thermal properties

Sean Wang (2):
      dt-bindings: thermal: add binding for MT7622 SoC
      thermal: mediatek: add support for MT7622 SoC

Viresh Kumar (1):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

 .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/thermal.txt        |  16 +-
 drivers/thermal/imx_thermal.c                      | 295 ++++++++++++++++-----
 drivers/thermal/mtk_thermal.c                      |  35 +++
 6 files changed, 281 insertions(+), 98 deletions(-)
