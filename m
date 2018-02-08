Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHOw6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:52:58 -0500
Received: from 8bytes.org ([81.169.241.247]:53302 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBHOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:52:57 -0500
Date: Thu, 8 Feb 2018 15:52:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v4.16
Message-ID: <20180208145249.fje5zfvjtz7qb3mi@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="su7vmtkdwepeqdvh"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--su7vmtkdwepeqdvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This time there are not a lot of changes coming from the IOMMU side.
That is partly because I returned from my parental leave late in the
development process and probably partly because everyone was busy with
Spectre and Meltdown mitigation work and didn't find the time for IOMMU
work. So here are the few changes that queued up for this merge window:

The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.16

for you to fetch changes up to fedbd940d1c2e37e6b11cf84f67b30dfcbf6fba5:

  Merge branches 'arm/renesas', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next (2018-01-17 15:29:14 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v4.16

Including:

	- 5-level page-table support for the Intel IOMMU.

	- Error reporting improvements for the AMD IOMMU driver

	- Additional DT bindings for ipmmu-vmsa (Renesas)

	- Smaller fixes and cleanups

----------------------------------------------------------------
Gary R Hook (2):
      iommu/amd - Record more information about unknown events
      iommu/amd: Set the device table entry PPR bit for IOMMU V2 devices

Geert Uytterhoeven (1):
      iommu/omap: Fix debugfs_create_*() usage

Jerry Snitselaar (1):
      iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Joerg Roedel (1):
      Merge branches 'arm/renesas', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next

Jordan Crouse (1):
      iommu: Check the result of iommu_group_get() for NULL

Magnus Damm (1):
      iommu/ipmmu-vmsa: Add r8a7796 DT binding

Peter Xu (1):
      iommu/vt-d: Use domain instead of cache fetching

Robin Murphy (4):
      iommu/exynos: Don't unconditionally steal bus ops
      iommu/msm: Claim bus ops on probe
      iommu/ipmmu-vmsa: Remove redundant of_iommu_init_fn hook
      iommu: Clean up of_iommu_init_fn

Simon Horman (1):
      iommu/ipmmu-vmsa: Add r8a779(70|95) DT bindings

Sohil Mehta (4):
      iommu/vt-d: Enable upto 57 bits of domain address width
      iommu/vt-d: Add a check for 1GB page support
      iommu/vt-d: Add a check for 5-level paging support
      iommu/vt-d: Enable 5-level paging mode in the PASID entry

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  3 ++
 drivers/iommu/amd_iommu.c                          | 24 ++++++++++++----
 drivers/iommu/amd_iommu_types.h                    |  2 ++
 drivers/iommu/arm-smmu-v3.c                        |  2 +-
 drivers/iommu/arm-smmu.c                           | 12 ++++----
 drivers/iommu/exynos-iommu.c                       |  9 +++++-
 drivers/iommu/intel-iommu.c                        |  5 ++--
 drivers/iommu/intel-svm.c                          | 32 ++++++++++++++++++----
 drivers/iommu/iommu.c                              |  5 ++++
 drivers/iommu/ipmmu-vmsa.c                         | 14 ++--------
 drivers/iommu/msm_iommu.c                          | 16 ++---------
 drivers/iommu/of_iommu.c                           | 16 -----------
 drivers/iommu/omap-iommu-debug.c                   |  4 +--
 drivers/iommu/qcom_iommu.c                         |  2 +-
 include/linux/intel-iommu.h                        |  2 ++
 include/linux/of_iommu.h                           |  5 +---
 16 files changed, 83 insertions(+), 70 deletions(-)

Please pull.

Thanks,

	Joerg

--su7vmtkdwepeqdvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJafGRBAAoJECvwRC2XARrjGoUP/jgNo29ZHAdP3zm3e0iKhH7g
xX8zIRbJP3pTxm91AJQq4P5oKS9L9/HPKszEmtr7eblpniLKKxc38AuWrH93vgmP
xs47jygThfmk+O2cVbY7564wgfyI9xJIhkdv72OxqDjaaP6NBZy6F82J31aYd4/k
TlDxwCWLF0aCet/qQZ5jOQ1GpzFQIe3e9z9mpDxE4n3CmIQonI1Vb5Jfpl2WU0xT
3K3+1dgOPq4osaPpUBgI044QcjTZgmSwAnP62dcyPdneBWXyIhYtDiHYUkCEz+/c
LYSUVDUgLrBSWyqp6zYgFgHCs+8Ue1GgJnqFE7P4SUUSf5g6F81JLKAaSJ4FXChD
7yNi1cp4ZGJfTiL3/f6SQcHLlrJTlcEaV6CkirWaZYGtsheLWhmycBTtbWzPAj4x
SjmPYvEnxY+sKkQOQD1N4hhOXCePQzD2nGa368ZHoI5+enkFvsZr81jxaFBg65tc
ry5tbj0jxWrnHwTKhTYOLqyxPe/goyrGO+DcCPvIaFMySgIDyban1l+TIKrxS83e
uBYCAja4lyMGebFPsKqtvknyxZcbelprK/QxRcIesIuLOO4tw5t7EZf+9DKgdnDy
v+hJ9Ix57FPhMU5G5c5Hb2OX0BVwnt3Xwo3WA5dgRyfR08mHvtDKMsvKnnILaeiH
qv2Bl/PqzGjnC3StcQ4s
=l3xU
-----END PGP SIGNATURE-----

--su7vmtkdwepeqdvh--
