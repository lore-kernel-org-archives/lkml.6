Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeDNSbE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 14:31:04 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41913 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeDNSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 14:31:02 -0400
X-Google-Smtp-Source: AIpwx4+HixsdkXe4nkjDJk7ah3QYQHky/5Ua5midTT3xkJl5eMsc2asrU8SHRAMBYImH9X4SjYYAPQ==
Date: Sat, 14 Apr 2018 11:30:53 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL V3] Thermal SoC management updates for v4.17-rc1
Message-ID: <20180414183051.GA27921@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please find thermal-soc changes for v4.17-rc1.
Rui asked me to send the pull request directly to you
as we are close to the end of the merge window.
Essentially this pull removes the series that caused
warning regression. I will work with the developer
to get that fixed later on, but I am still sending
the other few patches that are unrelated to that.
Let me know if this causes any issues and can still
be pulled.

Changelog:
- New i.MX7 thermal sensor
- Mediatek driver now supports MT7622 SoC
- Removal of min max cpu cooling DT property

Differences in V3:
- Rebased on top current linus/master, to avoid and merge issues
from previous pulled thermal code.

Differences in V2:
- Reordered the patches to drop exynos changes for now until we get
agreement on the fix on that driver for the compilation warns
caused by the confusing conversion functions.


The following changes since commit 48023102b7078a6674516b1fe0d639669336049d:

  Merge branch 'overlayfs-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs (2018-04-13 16:55:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 15a32df1918259be6c23fc36014fc26ee66c836c:

  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties (2018-04-14 09:37:55 -0700)

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
