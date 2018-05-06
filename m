Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeEFJoL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 05:44:11 -0400
Received: from 8bytes.org ([81.169.241.247]:41144 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeEFJoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 05:44:10 -0400
Date: Sun, 6 May 2018 11:44:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v4.17-rc4
Message-ID: <20180506094358.ysb5lq7xbjejymxa@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="64yjnfe6iayobsid"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64yjnfe6iayobsid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.17-rc4

for you to fetch changes up to 40fa84e10134ef5c892b628e02382349b5db3e0c:

  iommu: rockchip: fix building without CONFIG_OF (2018-05-03 16:36:07 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.17-rc4

Fixes come with:

	* Fix for compile warning in AMD IOMMU driver with irq remapping
	  disabled

	* Fix for VT-d interrupt remapping and invalidation size (caused
	  a BUG_ON when trying to invalidate more than 4GB)

	* Build fix and a regression fix for broken graphics with old
	  DTS for the rockchip iommu driver

	* A revert in PCI window reservation code which fixes a
	  regression with VFIO.

----------------------------------------------------------------
Arnd Bergmann (2):
      iommu/amd: Hide unused iommu_table_lock
      iommu: rockchip: fix building without CONFIG_OF

Changbin Du (1):
      iommu/vt-d: fix shift-out-of-bounds in bug checking

Heiko Stuebner (1):
      iommu/rockchip: Make clock handling optional

Jagannathan Raman (1):
      iommu/vt-d: Fix usage of force parameter in intel_ir_reconfigure_irte()

Joerg Roedel (1):
      iommu/vt-d: Use WARN_ON_ONCE instead of BUG_ON in qi_flush_dev_iotlb()

Shameer Kolothum (1):
      iommu/dma: Move PCI window region reservation back into dma specific path.

 drivers/iommu/amd_iommu.c           |  2 +-
 drivers/iommu/dma-iommu.c           | 54 +++++++++++++++++--------------------
 drivers/iommu/dmar.c                |  2 +-
 drivers/iommu/intel_irq_remapping.c |  2 +-
 drivers/iommu/rockchip-iommu.c      | 11 ++++++--
 5 files changed, 37 insertions(+), 34 deletions(-)

Please pull.

Thanks,

	Joerg

--64yjnfe6iayobsid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJa7s5eAAoJECvwRC2XARrjnhAQAJAagB6m6DoQrbYywRK3b55+
8dl3rNEZ6v7daJIBZ9hlLQP+zMVLvvC9fcFqQIAs6PtZbag9misXp/EIvxotRCHQ
fHMbs9xC8PJclmaMgd9UG8mJ1b45hjRa0jGDm2eddaZq/s4toMHrBg8JktnlIfVI
FVc1nOFiJEXpIhwngJi8sxenhmzcO/MmA1noevqhnkXYnTa+0PXFzTUBQNPM1CnJ
xXLAYmnHwA7ZzOK7vXs/q3ZbeFZBQhSLkOe15qX+paqiXdPiYegOrp1rRDjh55Kt
NCMzxpaMtmzb/rjKM4WC81820iWv01HAUb4hPbp9W9bcAF1qxSD9DTr3DQiGqPMl
JvjzAOxosnlPKwPA8Xci/5aiP7sgCuqGdksAmBPTVIuOrch3NSfgezXvYZi+a1ro
V/z9unDE5/Vt19kVyX8OS1FxFYyPBcV2ovYvCd34agtbmGGPtNuJiN6/fNxIT/gu
56mOinTotQU6hQ3vYzlQ0TPNwfeSXUN3JVafVIWp1I8FpRmDU7GD08nv5DFFXdB3
uZMrmhbB91SOqO13g7dm6gyJqgIAeJW7M7WPG8eK62DaT5F0kbLJSsiyNqOkYfCu
GzFAt3q66NNm2u9Hu/NpKr5EEWq+9J0653fkv8TM20u4G1oAcxoWyi62hqBiLDQB
IzVfuCRuPKE0x/TtPOY1
=qw4c
-----END PGP SIGNATURE-----

--64yjnfe6iayobsid--
