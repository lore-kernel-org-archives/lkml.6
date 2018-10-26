Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF5C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B262064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B262064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJZUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:04:02 -0400
Received: from 8bytes.org ([81.169.241.247]:33488 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbeJZUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:04:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EDF452C6; Fri, 26 Oct 2018 13:27:16 +0200 (CEST)
Date:   Fri, 26 Oct 2018 13:27:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v4.20
Message-ID: <20181026112710.iot2ti47chcf6w5f@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6skzxuasedco4yjk"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6skzxuasedco4yjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.20

for you to fetch changes up to 2f2fbfb71ecc221352d84ae6430b42031ae5b654:

  Merge branches 'arm/renesas', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' into next (2018-10-10 18:09:37 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.20

These updates bring:

	- Debugfs support for the Intel VT-d driver. When enabled, it
	  now also exposes some of its internal data structures to
	  user-space for debugging purposes.

	- ARM-SMMU driver now uses the generic deferred flushing
	  and fast-path iova allocation code. This is expected to be a
	  major performance improvement, as this allocation path scales
	  a lot better.

	- Support for r8a7744 in the Renesas iommu driver

	- Couple of minor fixes and improvements all over the place

----------------------------------------------------------------
Andrew Murray (2):
      iommu/arm-smmu-v3: Add SPDX header
      iommu/arm-smmu-v3: Remove unnecessary wrapper function

Biju Das (1):
      dt-bindings: iommu: ipmmu-vmsa: Add r8a7744 support

Colin Ian King (1):
      iommu/fsl: Fix spelling mistake pci_endpt_partioning -> pci_endpt_partitioning

Ganapatrao Kulkarni (1):
      iommu/iova: Optimise attempts to allocate iova from 32bit address range

Gayatri Kammela (1):
      iommu/vt-d: Add debugfs support to show register contents

Joerg Roedel (3):
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/amd: Move iommu_init_pci() to .init section
      Merge branches 'arm/renesas', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' into next

John Garry (1):
      iommu/arm-smmu-v3: Fix a couple of minor comment typos

Kuninori Morimoto (1):
      iommu/ipmmu-vmsa: Convert to SPDX identifiers

Lu Baolu (1):
      iommu/amd: Add default branch in amd_iommu_capable()

Nipun Gupta (7):
      Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc bus
      iommu/of: make of_pci_map_rid() available for other devices too
      iommu/of: support iommu configuration for fsl-mc devices
      iommu/arm-smmu: Add support for the fsl-mc bus
      bus/fsl-mc: support dma configure for devices on fsl-mc bus
      bus/fsl-mc: set coherent dma mask for devices on fsl-mc bus
      arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Rami Rosen (1):
      iommu: Fix a typo

Robin Murphy (8):
      iommu: Add fast hook for getting DMA domains
      iommu/dma: Use fast DMA domain lookup
      arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops
      iommu: Tidy up window attributes
      iommu: Remove .domain_{get,set}_windows
      iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()
      iommu/io-pgtable-arm-v7s: Add support for non-strict mode
      iommu/arm-smmu: Support non-strict mode

Sohil Mehta (5):
      iommu/vt-d: Relocate struct/function declarations to its header files
      iommu/vt-d: Update register definitions to VT-d 3.0 specification
      iommu/vt-d: Enable base Intel IOMMU debugfs support
      iommu/vt-d: Add debugfs support for Interrupt remapping
      iommu/vt-d: Add debugfs support to show context internals

Will Deacon (1):
      iommu/arm-smmu: Ensure that page-table updates are visible before TLBI

Zhen Lei (7):
      iommu/arm-smmu-v3: Fix unexpected CMD_SYNC timeout
      iommu/arm-smmu-v3: Avoid back-to-back CMD_SYNC operations
      iommu/arm-smmu-v3: Implement flush_iotlb_all hook
      iommu/dma: Add support for non-strict mode
      iommu: Add "iommu.strict" command line option
      iommu/io-pgtable-arm: Add support for non-strict mode
      iommu/arm-smmu-v3: Add support for non-strict mode

 Documentation/admin-guide/kernel-parameters.txt    |  12 +
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   1 +
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   7 +-
 arch/arm64/mm/dma-mapping.c                        |  10 +-
 arch/x86/include/asm/irq_remapping.h               |   2 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +-
 drivers/iommu/Kconfig                              |  13 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd_iommu.c                          |   2 +
 drivers/iommu/amd_iommu_init.c                     |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 140 +++++----
 drivers/iommu/arm-smmu.c                           | 106 +++++--
 drivers/iommu/dma-iommu.c                          |  55 +++-
 drivers/iommu/fsl_pamu_domain.c                    | 119 ++++----
 drivers/iommu/intel-iommu-debugfs.c                | 314 +++++++++++++++++++++
 drivers/iommu/intel-iommu.c                        |  32 +--
 drivers/iommu/intel_irq_remapping.c                |   2 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  11 +-
 drivers/iommu/io-pgtable-arm.c                     |  23 +-
 drivers/iommu/io-pgtable.h                         |   5 +
 drivers/iommu/iommu.c                              |  58 ++--
 drivers/iommu/iova.c                               |  22 +-
 drivers/iommu/ipmmu-vmsa.c                         |   5 +-
 drivers/iommu/of_iommu.c                           |  25 +-
 drivers/of/base.c                                  | 102 +++++++
 drivers/of/irq.c                                   |   5 +-
 drivers/pci/of.c                                   | 101 -------
 include/linux/fsl/mc.h                             |   8 +
 include/linux/intel-iommu.h                        |  72 +++++
 include/linux/iommu.h                              |  10 +-
 include/linux/iova.h                               |   1 +
 include/linux/of.h                                 |  11 +
 include/linux/of_pci.h                             |  10 -
 34 files changed, 986 insertions(+), 356 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debugfs.c

Please pull.

Thanks,

	Joerg

--6skzxuasedco4yjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJb0voOAAoJECvwRC2XARrjJ78QALz/U3srKR6wKPMO8Gk1EXaG
J2eMTvrN6em/YsnsYMOWoPpMWnlOUYJC2rorau2PPBK5VpugFJAmsk4mFTaDVaZP
nEMIGYBq89zI6PQ3UikJ+GO3IuREexkfBXUK2CmZRCepawH4FUhc6T2gCGR/JTRM
LN+ZRTaPBwnyHeThn3LMp+0cJ/7dw2nPNTJ6zlscrImXNo0UTVlDgjiyMIEDobYu
WawS+7A6YCJxcOWY+CspQfJy8tlnMo0Ums52OYMANkumOiC7lgYxu6jdy4nLKYWW
3kKnfWRNT+jXwhsvPni2NZI8eLjDFPnUneyW+q96/CNZ4/7wYMfCXAzcWLmYdWpc
C7CbjEcrtHFiaM5kCgWRkaB+6WUwuIoYuvmExdVdMS79ZczjQcZ7KSO+dah5VsAh
o0S3jUdH6LL4R8+PH4YkBzy5PLIVJ8laELE2mp2hIM4+xnFOTOAqmVp2ZLIFHV7j
Xbfi2vv5tEAv5gEbg/k7mPfsvw2/LToYwl5CmC7fPNL2od9jZ1dx9ZlnVRH+h3S2
OcjRFgt54tVjry8XyOnaj1HExcbP7aIeeiflVmGjY9PnGJrgyJgqizm67BT8Kdc6
yjAsMgTIxzP45U5DqxYz99fMB6MCpUPKjeEZbbrqvmHp3ZNyB+jkvjp7zhhYrHCk
N6gWQfIVOFP2I++a0c9y
=kQ3Q
-----END PGP SIGNATURE-----

--6skzxuasedco4yjk--
