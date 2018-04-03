Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDCOdC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:33:02 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34733 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDCOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:33:00 -0400
X-Google-Smtp-Source: AIpwx48JNgrsCrY63rdwqCbiVGX2J9TrPO949W0iV3bjU2wZUkrl2Bd/pBT4+GkWWmPhlqUln6btdA==
Date: Tue, 3 Apr 2018 07:32:57 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] libata changes for v4.17-rc1
Message-ID: <20180403143257.GN388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting.  The biggest change is refcnting fix for
ata_host - the bug is recent and can only be triggered on controller
hotplug, so very few are hitting it.  There also are a number of
trivial license / error message changes and some hardware specific
changes.

Thanks.

The following changes since commit 0a65e125150c227314dcd561a202a84228398449:

  libata: update documentation for sysfs interfaces (2018-02-13 06:41:02 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.17

for you to fetch changes up to 027fa4dee935d25cef5994af1b8864eb00dcffac:

  ahci: imx: add the imx8qm ahci sata support (2018-03-29 06:43:55 -0700)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (3):
      pata_falcon: clarify license version and use SPDX header
      pata_bk3710: clarify license version and use SPDX header
      ata: add Amiga Gayle PATA controller driver

Colin Ian King (1):
      libata: ensure host is free'd on error exit paths

Kunihiko Hayashi (1):
      ata: ahci-platform: add reset control support

Markus Elfring (7):
      pata_arasan_cf: Delete an error message for a failed memory allocation in arasan_cf_probe()
      pata_arasan_cf: Delete an unnecessary variable initialisation in arasan_cf_probe()
      pata_samsung_cf: Delete an error message for a failed memory allocation in pata_s3c_probe()
      sata_dwc_460ex: Delete an error message for a failed memory allocation in sata_dwc_port_start()
      pata_mpc52xx: Delete an error message for a failed memory allocation in mpc52xx_ata_probe()
      pata_macio: Delete an error message for a failed memory allocation in two functions
      pata_it821x: Delete an error message for a failed memory allocation in it821x_firmware_command()

Preetham Ramchandra (7):
      dt-bindings: Tegra210: add binding documentation
      ata: ahci_tegra: Update initialization sequence
      ata: ahci_tegra: initialize regulators from soc struct
      ata: ahci_tegra: disable devslp for Tegra124
      ata: ahci_tegra: disable DIPM
      ata: ahci_tegra: Add AHCI support for Tegra210
      ata: change Tegra124 to Tegra

Richard Zhu (3):
      ahci: imx: add the imx6qp ahci sata support
      ahci: imx: fix the build warning
      ahci: imx: add the imx8qm ahci sata support

Taras Kondratiuk (1):
      libata: add refcounting to ata_host

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 Documentation/devicetree/bindings/ata/imx-sata.txt |   1 +
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  36 +-
 drivers/ata/Kconfig                                |  16 +-
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/ahci_imx.c                             | 371 ++++++++++++++++++++-
 drivers/ata/ahci_tegra.c                           | 359 +++++++++++++++-----
 drivers/ata/libahci_platform.c                     |  24 +-
 drivers/ata/libata-core.c                          |  46 ++-
 drivers/ata/libata-transport.c                     |   4 +
 drivers/ata/libata.h                               |   2 +
 drivers/ata/pata_arasan_cf.c                       |   6 +-
 drivers/ata/pata_bk3710.c                          |   8 +-
 drivers/ata/pata_falcon.c                          |   8 +-
 drivers/ata/pata_gayle.c                           | 219 ++++++++++++
 drivers/ata/pata_it821x.c                          |   6 +-
 drivers/ata/pata_macio.c                           |  12 +-
 drivers/ata/pata_mpc52xx.c                         |   1 -
 drivers/ata/pata_samsung_cf.c                      |   4 +-
 drivers/ata/sata_dwc_460ex.c                       |   1 -
 include/linux/libata.h                             |   1 +
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   2 +
 23 files changed, 995 insertions(+), 135 deletions(-)
 create mode 100644 drivers/ata/pata_gayle.c

-- 
tejun
