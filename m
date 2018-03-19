Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030451AbeCSVM6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:12:58 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39174 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933644AbeCSVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:12:51 -0400
X-Google-Smtp-Source: AG47ELtE7udH2+KRWRwgoGOs1e+E/X2fc8c91ttmtmR2ymS1aYOlyTPvzKacYm2RALezea6FFGdcSg==
Date: Mon, 19 Mar 2018 14:12:48 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for v4.16-rc6
Message-ID: <20180319211248.GH519464@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

I sat on them too long and it's quite a few this late, but nothing has
a wide blast area.  The changes are...

* Fix corner cases in SG command handling.

* Recent introduction of default powersaving mode config option
  exposed several devices with broken powersaving behaviors.  A number
  of patches to update the blacklist accordingly.

* Fix a kernel panic on SAS hotplug.

* Other misc and device specific updates.

Thanks.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.16-fixes

for you to fetch changes up to d418ff56b8f2d2b296daafa8da151fe27689b757:

  libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version (2018-03-19 08:36:38 -0700)

----------------------------------------------------------------
Aishwarya Pant (2):
      libata: transport: cleanup documentation of sysfs interface
      libata: update documentation for sysfs interfaces

Baruch Siach (1):
      ata: libahci: fix comment indentation

Dong Bo (1):
      libata: Fix compile warning with ATA_DEBUG enabled

Eric Biggers (3):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data
      libata: don't try to pass through NCQ commands to non-NCQ devices

Geert Uytterhoeven (1):
      ata: sata_rcar: Remove unused variable in sata_rcar_init_controller()

Hans de Goede (6):
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
      PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version

Jason Yan (1):
      ata: do not schedule hot plug if it is a sas host

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng (1):
      libata: disable LPM for Crucial BX100 SSD 500GB drive

Khiem Nguyen (1):
      sata_rcar: Reset SATA PHY when Salvator-X board resumes

Stefan Roese (1):
      ahci: Add check for device presence (PCIe hot unplug) in ahci_stop_engine()

 Documentation/ABI/testing/sysfs-ata             | 171 ++++++++++++++----------
 Documentation/ABI/testing/sysfs-block-device    |  58 ++++++++
 Documentation/ABI/testing/sysfs-class-scsi_host |  89 ++++++++++++
 drivers/ata/ahci.c                              |   4 +-
 drivers/ata/libahci.c                           |  10 ++
 drivers/ata/libahci_platform.c                  |   2 +-
 drivers/ata/libata-core.c                       |  26 +++-
 drivers/ata/libata-eh.c                         |   3 +-
 drivers/ata/libata-scsi.c                       |  12 +-
 drivers/ata/sata_rcar.c                         |  62 +++++----
 drivers/pci/quirks.c                            |   2 +
 11 files changed, 337 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-block-device
