Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeFDOMP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42999 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753237AbeFDOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:12:12 -0400
Date: Mon, 4 Jun 2018 16:12:11 +0200
From: Borislav Petkov <bp@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 4.18
Message-ID: <20180604141210.GA18524@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the current pile of fixes to the EDAC tree.

There's a merge commit in there with an immutable branch from
the socfpga's tree as changes there are touching the same
socfpga_stratix10.dtsi file, patches in my tree are touching so I
thought this was the best way to avoid merge conflicts. Please let me
know if this way is wrong.

And that's why you see those unrelated changes in the list below. So
depending on the pull order, you'll either get them through my tree or
through the arm-soc tree.

Btw, I'm not aware of any order those merges are *required* to happen so
let me CC the relevant parties in case order is important after all.

Thanks!

---
The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.18

for you to fetch changes up to eaa3a1d46cfdbf1af50311e7a22f5d38c0418b56:

  EDAC, ghes: Make platform-based whitelisting x86-only (2018-05-21 12:18:57 +0200)

----------------------------------------------------------------
* Stratix10 SDRAM support to altera_edac (Thor Thayer)

* the usual misc fixes all over the place

----------------------------------------------------------------
Alan Tull (1):
      arm64: dts: stratix10: enable i2c, add i2c periperals

Alexandru Gagniuc (1):
      EDAC, ghes: Remove unused argument to ghes_edac_report_mem_error()

Bartosz Golaszewski (1):
      ARM: dts: consistently use 'atmel' as at24 manufacturer in cyclone5

Borislav Petkov (4):
      ghes, EDAC: Fix ghes_edac registration
      Merge tag 'socfpga_updates_for_v4.18_part2' into edac-for-4.18
      EDAC, ghes: Use BIT() macro
      EDAC, ghes: Make platform-based whitelisting x86-only

Colin Ian King (1):
      EDAC, i7core: Fix spelling mistake: "redundacy" -> "redundancy"

Dinh Nguyen (1):
      arm64: dts: stratix10: use clock bindings for the Stratix10 platform

Graham Moore (1):
      arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts

Ooi, Joyce (1):
      arm64: dts: stratix10: Change pad skew values for EMAC0 PHY driver

Randy Dunlap (1):
      EDAC, skx: Fix skx_edac build error when ACPI_NFIT=m

Sughosh Ganu (1):
      EDAC, ghes: Add a null pointer check in ghes_edac_unregister()

Thor Thayer (6):
      arm64: dts: stratix10: add sdram ecc
      Documentation: dt: socfpga: Add Stratix10 ECC Manager binding
      EDAC, altera: Add support for Stratix10 SDRAM EDAC
      Documentation: dt: edac: Move Altera SOCFPGA EDAC file
      EDAC, altera: Handle SDRAM Uncorrectable Errors on Stratix10
      EDAC, altera: Fix ARM64 build warning

Toshi Kani (1):
      EDAC, ghes: Add DDR4 and NVDIMM memory types

 .../{arm/altera => edac}/socfpga-eccmgr.txt        |  35 ++
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |   6 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  83 +++-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  44 +-
 drivers/acpi/apei/ghes.c                           |  16 +-
 drivers/edac/Kconfig                               |   3 +-
 drivers/edac/altera_edac.c                         | 504 ++++++++++++++++++++-
 drivers/edac/altera_edac.h                         | 132 +++++-
 drivers/edac/ghes_edac.c                           |  55 ++-
 drivers/edac/i7core_edac.c                         |   2 +-
 include/acpi/ghes.h                                |   7 +-
 11 files changed, 817 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/{arm/altera => edac}/socfpga-eccmgr.txt (87%)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
