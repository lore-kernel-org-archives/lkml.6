Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeDKPt5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:49:57 -0400
Received: from 8bytes.org ([81.169.241.247]:50236 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeDKPt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:49:56 -0400
Date: Wed, 11 Apr 2018 17:49:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v4.17
Message-ID: <20180411154945.44ywamihmo7yb6oe@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.17

for you to fetch changes up to d4f96fd5c249defda290299f9646287dd3df0803:

  Merge branches 'x86/amd', 'x86/vt-d', 'arm/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas', 'arm/smmu' and 'core' into next (2018-03-29 15:24:40 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.17

These updates come with:

	- OF_IOMMU support for the Rockchip iommu driver so that it can
	  use generic DT bindings

	- Rework of locking in the AMD IOMMU interrupt remapping code to
	  make it work better in RT kernels

	- Support for improved iotlb flushing in the AMD IOMMU driver

	- Support for 52-bit physical and virtual addressing in the
	  ARM-SMMU

	- Various other small fixes and cleanups

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: iommu: ipmmu-vmsa: Add device tree support for r8a774[35]

Dmitry Safonov (2):
      iommu/vt-d: Add __init for dmar_register_bus_notifier()
      iommu/vt-d: Clean/document fault status flags

Gary R Hook (1):
      iommu/amd: Use dev_err to send events to the system log

Jeffy Chen (10):
      iommu/omap: Increase group ref in .device_group()
      iommu/rockchip: Prohibit unbind and remove
      iommu/rockchip: Fix error handling in probe
      iommu/rockchip: Request irqs in rk_iommu_probe()
      dt-bindings: iommu/rockchip: Add clock property
      iommu/rockchip: Use IOMMU device for dma mapping operations
      iommu/rockchip: Use OF_IOMMU to attach devices automatically
      iommu/rockchip: Fix error handling in init
      iommu/rockchip: Add runtime PM support
      iommu/rockchip: Support sharing IOMMU between masters

Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'x86/amd', 'x86/vt-d', 'arm/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas', 'arm/smmu' and 'core' into next

Lu Baolu (2):
      iommu/vt-d: Fix a potential memory leak
      iommu/vt-d: Use real PASID for flush in caching mode

Marc Zyngier (1):
      iommu/rockchip: Perform a reset on shutdown

Nate Watterson (1):
      iommu/arm-smmu-v3: limit reporting of MSI allocation failures

Robin Murphy (10):
      iommu/exynos: Use generic group callback
      iommu/arm-smmu-v3: Warn about missing IRQs
      iommu/arm-smmu-v3: Clean up address masking
      iommu/arm-smmu-v3: Clean up register definitions
      iommu/arm-smmu-v3: Clean up table definitions
      iommu/arm-smmu-v3: Clean up queue definitions
      iommu/io-pgtable-arm: Support 52-bit physical address
      iommu/arm-smmu-v3: Support 52-bit physical address
      iommu/arm-smmu-v3: Support 52-bit virtual address
      iommu/io-pgtable-arm: Avoid warning with 32-bit phys_addr_t

Scott Wood (3):
      iommu/amd: Use raw locks on atomic context paths
      iommu/amd: Don't use dev_data in irte_ga_set_affinity()
      iommu/amd: Avoid locking get_irq_table() from atomic context

Sebastian Andrzej Siewior (10):
      iommu/amd: Take into account that alloc_dev_data() may return NULL
      iommu/amd: Turn dev_data_list into a lock less list
      iommu/amd: Split domain id out of amd_iommu_devtable_lock
      iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock
      iommu/amd: Remove the special case from alloc_irq_table()
      iommu/amd: Use `table' instead `irt' as variable name in amd_iommu_update_ga()
      iommu/amd: Factor out setting the remap table for a devid
      iommu/amd: Drop the lock while allocating new irq remap table
      iommu/amd: Make amd_iommu_devtable_lock a spin_lock
      iommu/amd: Return proper error code in irq_remapping_alloc()

Shameer Kolothum (2):
      ACPI/IORT: Add msi address regions reservation helper
      iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation

Shaokun Zhang (1):
      iommu/vt-d:Remove unused variable

Suravee Suthikulpanit (2):
      iommu: Do not return error code for APIs with size_t return type
      iommu/amd: Add support for fast IOTLB flushing

Tomasz Figa (4):
      iommu/rockchip: Fix error handling in attach
      iommu/rockchip: Use iopoll helpers to wait for hardware
      iommu/rockchip: Fix TLB flush of secondary IOMMUs
      iommu/rockchip: Control clocks needed to access the IOMMU

Vivek Gautam (1):
      iommu/io-pgtable: Use size_t return type for all foo_unmap

Yong Wu (2):
      iommu/mediatek: Move attach_device after iommu-group is ready for M4Uv1
      iommu/mediatek: Fix protect memory setting

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   5 +-
 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   7 +
 drivers/acpi/arm64/iort.c                          | 111 +++-
 drivers/iommu/amd_iommu.c                          | 320 ++++++-----
 drivers/iommu/amd_iommu_init.c                     |   2 +-
 drivers/iommu/amd_iommu_types.h                    |   6 +-
 drivers/iommu/arm-smmu-v3.c                        | 542 +++++++++----------
 drivers/iommu/dma-iommu.c                          |   8 +-
 drivers/iommu/dmar.c                               |   2 +-
 drivers/iommu/exynos-iommu.c                       |  13 +-
 drivers/iommu/intel-iommu.c                        |   6 +-
 drivers/iommu/intel-svm.c                          |  17 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  21 +-
 drivers/iommu/io-pgtable-arm.c                     |  91 ++--
 drivers/iommu/io-pgtable.h                         |   4 +-
 drivers/iommu/iommu.c                              |   6 +-
 drivers/iommu/mtk_iommu.c                          |  15 +-
 drivers/iommu/mtk_iommu.h                          |   1 +
 drivers/iommu/mtk_iommu_v1.c                       |  54 +-
 drivers/iommu/omap-iommu.c                         |   2 +-
 drivers/iommu/rockchip-iommu.c                     | 592 +++++++++++----------
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +-
 include/linux/acpi_iort.h                          |   7 +-
 include/linux/intel-iommu.h                        |  12 +-
 include/linux/iommu.h                              |  14 +-
 25 files changed, 1008 insertions(+), 853 deletions(-)

Please pull.

Thanks,

	Joerg
