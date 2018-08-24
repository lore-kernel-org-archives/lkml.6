Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DAFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC8921564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nSxKO7nB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC8921564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHXQgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:36:09 -0400
Received: from 8bytes.org ([81.169.241.247]:43670 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeHXQgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:36:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8669821D; Fri, 24 Aug 2018 15:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1535115688; bh=kRYZWksUcXKY0uouggrVSmD4bUfH0tdsLrLLjjPw3BA=;
        h=Date:From:To:Cc:Subject:From;
        b=nSxKO7nBthC4sJYdfXoIjrFGDBuAxLUvG34xIprNcixwgUWES3I7BLKCDqo78pB6Z
         UWAXsYyT0bmfcqEnQiSfFvTqR2S0QrNkCmQyv3knZbv8tlElm1yNwNY89BpZvJJ8dS
         CH2lqziJBeYsyq+ibfGCeKcmImM3hGZX3lk/XsDKeWE0YgoLWhfsrnhdqe0wZ1grnY
         cFej2PtUp2IlZHkyWnkyMWcS5RIZguRaOHg5d9T5nxBBfhZBCA10Rx1sxYRpjlh+17
         8c7lnEJxX20BEhBuLxuPurIaw6NrIVo3aWVqFkEpRTs/v72EF1owtfrTy7Umvpv5KK
         jzsHQQ0keTzBQ==
Date:   Fri, 24 Aug 2018 15:01:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v4.19
Message-ID: <20180824130120.lwv5bklvv64hjsde@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tm5tmd3nudf255xg"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tm5tmd3nudf255xg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

note that this time there is a trivial conflict when merging this into
your tree. The conflict is in drivers/iommu/ipmmu-vmsa.c, apparently
some other tree also added DT matching entries there. With that in mind:

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.19

for you to fetch changes up to 6488a7f35eeab463f6c9c2ea34d30ca856f0bc8e:

  Merge branches 'arm/shmobile', 'arm/renesas', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' into next (2018-08-08 12:02:27 +0200)

----------------------------------------------------------------
IOMMU Update for Linux v4.19

Including:

	- PASID table handling updates for the Intel VT-d driver. It
	  implements a global PASID space now so that applications
	  usings multiple devices will just have one PASID.

	- A new config option to make iommu passthroug mode the default.

	- New sysfs attribute for iommu groups to export the type of the
	  default domain.

	- A debugfs interface (for debug only) usable by IOMMU drivers
	  to export internals to user-space.

	- R-Car Gen3 SoCs support for the ipmmu-vmsa driver

	- The ARM-SMMU now aborts transactions from unknown devices and
	  devices not attached to any domain.

	- Various cleanups and smaller fixes all over the place.

----------------------------------------------------------------
Anna-Maria Gleixner (1):
      iommu/amd: Remove redundant WARN_ON()

Christoph Hellwig (1):
      iommu: Remove the ->map_sg indirection

Corentin Labbe (1):
      iommu/shmobile: Remove unused include/linux/platform_data/sh_ipmmu.h header

Dmitry Osipenko (1):
      iommu/ipmmu-vmsa: Don't register as BUS IOMMU if machine doesn't have IPMMU-VMSA

Gary R Hook (2):
      iommu: Enable debugfs exposure of IOMMU driver internals
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU

Geert Uytterhoeven (2):
      iommu/ipmmu-vmsa: Fix allocation in atomic context
      iommu/ipmmu-vmsa: Clarify supported platforms

Jacob Pan (2):
      iommu/vt-d: Add definitions for PFSID
      iommu/vt-d: Fix dev iotlb pfsid use

Jacopo Mondi (2):
      dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
      iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code

Jean-Philippe Brucker (2):
      iommu/io-pgtable-arm: Fix pgtable allocation in selftest
      iommu/io-pgtable-arm-v7s: Abort allocation when table address overflows the PTE

Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'arm/shmobile', 'arm/renesas', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' into next

Lu Baolu (10):
      iommu/vt-d: Remove unnecessary WARN_ON()
      iommu/vt-d: Global PASID name space
      iommu/vt-d: Avoid using idr_for_each_entry()
      iommu/vt-d: Apply global PASID in SVA
      iommu/vt-d: Move device_domain_info to header
      iommu/vt-d: Add for_each_device_domain() helper
      iommu/vt-d: Per PCI device pasid table interfaces
      iommu/vt-d: Allocate and free pasid table
      iommu/vt-d: Apply per pci device pasid table in SVA
      iommu/vt-d: Remove the obsolete per iommu pasid tables

Magnus Damm (3):
      iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
      iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
      iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings

Miao Zhong (1):
      iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Niklas Cassel (1):
      iommu/msm: Don't call iommu_device_{,un}link from atomic context

Olof Johansson (2):
      iommu: Add sysfs attribyte for domain type
      iommu: Add config option to set passthrough as default

Ralf Goebel (1):
      iommu/omap: Fix cache flushes on L2 table entries

Simon Horman (1):
      iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

Suravee Suthikulpanit (3):
      x86: irq_remapping: Move irq remapping mode enum
      iommu/amd: Add support for higher 64-bit IOMMU Control Register
      iommu/amd: Add support for IOMMU XT mode

Vivek Gautam (1):
      iommu/arm-smmu: Error out only if not enough context interrupts

Will Deacon (1):
      iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel

Yoshihiro Shimoda (1):
      iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a special usage on R-Car Gen3

Zhen Lei (2):
      iommu/amd: make sure TLB to be flushed before IOVA freed
      iommu/arm-smmu-v3: Prevent any devices access to memory without registration

yzhai003@ucr.edu (1):
      iommu/amd: Argument page_size could be uninitialized

 Documentation/admin-guide/kernel-parameters.txt    |   3 +-
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   3 +
 arch/x86/include/asm/irq_remapping.h               |   5 +
 arch/x86/kernel/pci-dma.c                          |   8 +
 drivers/iommu/Kconfig                              |  37 +++-
 drivers/iommu/Makefile                             |   4 +-
 drivers/iommu/amd_iommu.c                          |  38 ++--
 drivers/iommu/amd_iommu_debugfs.c                  |  33 +++
 drivers/iommu/amd_iommu_init.c                     |  57 +++--
 drivers/iommu/amd_iommu_proto.h                    |   6 +
 drivers/iommu/amd_iommu_types.h                    |  22 +-
 drivers/iommu/arm-smmu-v3.c                        |  26 ++-
 drivers/iommu/arm-smmu.c                           |  17 +-
 drivers/iommu/dmar.c                               |   6 +-
 drivers/iommu/exynos-iommu.c                       |   1 -
 drivers/iommu/intel-iommu.c                        | 160 +++++++-------
 drivers/iommu/intel-pasid.c                        | 239 +++++++++++++++++++++
 drivers/iommu/intel-pasid.h                        |  39 ++++
 drivers/iommu/intel-svm.c                          |  79 +++----
 drivers/iommu/io-pgtable-arm-v7s.c                 |   7 +-
 drivers/iommu/io-pgtable-arm.c                     |   3 +-
 drivers/iommu/iommu-debugfs.c                      |  66 ++++++
 drivers/iommu/iommu.c                              |  44 +++-
 drivers/iommu/ipmmu-vmsa.c                         |  63 ++++--
 drivers/iommu/msm_iommu.c                          |  17 +-
 drivers/iommu/mtk_iommu.c                          |   1 -
 drivers/iommu/mtk_iommu_v1.c                       |   1 -
 drivers/iommu/omap-iommu.c                         |   5 +-
 drivers/iommu/qcom_iommu.c                         |   1 -
 drivers/iommu/rockchip-iommu.c                     |   1 -
 drivers/iommu/tegra-gart.c                         |   1 -
 drivers/iommu/tegra-smmu.c                         |   1 -
 include/linux/dmar.h                               |   5 -
 include/linux/intel-iommu.h                        |  80 ++++++-
 include/linux/iommu.h                              |  23 +-
 include/linux/platform_data/sh_ipmmu.h             |  18 --
 36 files changed, 843 insertions(+), 277 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h
 create mode 100644 drivers/iommu/iommu-debugfs.c
 delete mode 100644 include/linux/platform_data/sh_ipmmu.h

Please pull.

Thanks,

	Joerg

--tm5tmd3nudf255xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbgAGgAAoJECvwRC2XARrjx68P/jkogU/qu+pb6LFRtJJwnEfL
JACbXZPpT9mQLGztf1n5iIn9mWG8HtMr8rAhbx8YM1vI2gSYFD10y0q3j8dIoxM6
zVnkNDSsOyFtCu9diineMCXeZvtaCJCjy/Y1nxDLSarv0vYyDXs4ECVyaCKhdPUu
iv/CruhL8jKtPAxweqyE/FrYfDWA3z+1gZ5Cr8K+pHkyuMlfNQvJmy3kK1fE7u8O
PG/jjg9E0MQBSseH0VPJak72t/47+ySlPBMEsoSKEllzJd4JgQIsQtuEQvYwz+l9
Lm764WI0R4t3EzDO/7vlO0j1hPn8qKmEpykUFhMIfK9bpSPmB/0lII4ebe/GRNaR
zg6XhOg2nuIthysahJOnNOUFssYbDkhDTlfFRIfm+eaRiVmzfVw4Pk1Jo36xpC/E
wjUtXN7Q+lCvLrI0e8Ch/F6yznRS/1nc4HdrZqnLDfS6jYo2YQkBrT6xHqHgP/tH
xMQvTjPQNTHwS0zNWWLR7df/50I0dhaRRW4vmwMSU06WMfyV9CH5LXfgC4mGQIRN
lnJMNziYM8GTwvzDNgtecio9+Uq5+q9M0tpvdzNm9nmbRQa0Tr1d7GznW/ME+m6Z
sB73W6F9CC75F3+dFR0KGGKKiEuIccQdBMEXSdva3DAMOZvL8jHUhivXevjMzUNc
yFzZ2oF/r3ndxOkGxuqd
=bwQ3
-----END PGP SIGNATURE-----

--tm5tmd3nudf255xg--
