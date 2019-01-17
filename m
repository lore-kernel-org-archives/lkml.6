Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210AEC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D944320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725357;
	bh=H3zJ04axP9qaaTqQYWHJ6h/DeEnJAFlpOMI8F4tFujw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wDPHiIrYIqBiClqTOF/M9EeUJllowTGtWZnsDYp/9K06b7sYbUHJCfXujWNPjOq5X
	 CmYZryppwd2C/Au9NFYe90tzTE/yY4SoiT/LmJv8p3esfM4MgPlNHHUcSiwhgac1j2
	 bEvZJePxXhJnRv8E5WK+efr38ahMlL1pVPq71Iqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfAQLmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfAQLme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:42:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C098D20855;
        Thu, 17 Jan 2019 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725353;
        bh=H3zJ04axP9qaaTqQYWHJ6h/DeEnJAFlpOMI8F4tFujw=;
        h=Date:From:To:Cc:Subject:From;
        b=bhs4vYrCgIFa/CmpdIQO3AlaZX4CeGos5+ctDvdqWpMNhJeNU62Ccox5uPWBs5hOy
         3ihUooRwHQIQy3mL1nZ5MFaoYLN8sc1XWye6BSIJqNody133/axWPLWl5DK6c05j+s
         fBTzDkgjv1QCEHUYg3IlnmL33f//GpRnimJgnGrQ=
Date:   Thu, 17 Jan 2019 12:42:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.3
Message-ID: <20190117114231.GA2293@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.3 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arm/mach-davinci/board-da830-evm.c           |    4=20
 arch/arm/mach-davinci/board-da850-evm.c           |    4=20
 arch/arm/mach-davinci/board-dm355-evm.c           |    4=20
 arch/arm/mach-davinci/board-dm644x-evm.c          |    4=20
 arch/arm/mach-davinci/board-omapl138-hawk.c       |    4=20
 arch/powerpc/kernel/signal_32.c                   |   18 ++-
 arch/powerpc/kernel/signal_64.c                   |   20 ++-
 arch/x86/kernel/cpu/bugs.c                        |    2=20
 drivers/acpi/arm64/iort.c                         |    3=20
 drivers/acpi/pmic/intel_pmic_xpower.c             |   41 +++++--
 drivers/acpi/power.c                              |   22 +++
 drivers/block/rbd.c                               |    9 -
 drivers/cpufreq/scmi-cpufreq.c                    |    8 -
 drivers/cpufreq/scpi-cpufreq.c                    |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |    1=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   37 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     |    4=20
 drivers/gpu/drm/drm_fb_helper.c                   |  126 ++++++++++++-----=
-----
 drivers/gpu/drm/i915/i915_gem_gtt.c               |   15 ++
 drivers/i2c/i2c-dev.c                             |    6 +
 drivers/mtd/nand/raw/qcom_nandc.c                 |   20 +--
 drivers/opp/core.c                                |   63 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware-host.c |   37 ++++--
 drivers/staging/rtl8188eu/core/rtw_security.c     |    6 -
 drivers/usb/class/cdc-acm.c                       |    7 +
 drivers/usb/core/generic.c                        |    9 +
 drivers/usb/core/quirks.c                         |    3=20
 drivers/usb/storage/scsiglue.c                    |    8 +
 drivers/usb/storage/unusual_devs.h                |   12 ++
 drivers/vfio/vfio_iommu_type1.c                   |    2=20
 fs/btrfs/ctree.c                                  |   16 +-
 fs/btrfs/qgroup.c                                 |   14 +-
 fs/btrfs/volumes.c                                |   39 ++++--
 fs/btrfs/xattr.c                                  |    8 +
 fs/cifs/file.c                                    |    8 -
 fs/cifs/misc.c                                    |   34 +++--
 fs/cifs/smb2file.c                                |    4=20
 fs/cifs/smb2pdu.c                                 |    8 +
 fs/cifs/transport.c                               |   63 +++++++----
 fs/ext4/fsync.c                                   |   16 ++
 fs/ext4/inline.c                                  |    6 -
 fs/ext4/inode.c                                   |    5=20
 fs/ext4/super.c                                   |    2=20
 include/linux/compiler-gcc.h                      |    2=20
 include/linux/module.h                            |    2=20
 include/linux/pm_opp.h                            |    5=20
 include/linux/sunrpc/svc.h                        |    5=20
 include/trace/events/sunrpc.h                     |    6 -
 kernel/fork.c                                     |    1=20
 mm/memory.c                                       |   23 ++++
 mm/slab.c                                         |    6 -
 mm/usercopy.c                                     |    9 -
 mm/util.c                                         |    2=20
 net/sunrpc/svc.c                                  |   11 +
 net/sunrpc/svc_xprt.c                             |    5=20
 net/sunrpc/svcsock.c                              |    2=20
 scripts/mod/modpost.c                             |    2=20
 sound/pci/hda/patch_realtek.c                     |   18 ++-
 59 files changed, 577 insertions(+), 250 deletions(-)

Alex Deucher (1):
      drm/amdgpu: Add new VegaM pci id

Alex Williamson (1):
      vfio/type1: Fix unmap overflow off-by-one

Bartosz Golaszewski (5):
      ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
      ARM: davinci: da850-evm: fix label names in GPIO lookup entries
      ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries
      ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
      ARM: davinci: da830-evm: fix label names in GPIO lookup entries

Breno Leitao (1):
      powerpc/tm: Unset MSR[TS] if not recheckpointing

Chris Wilson (1):
      drm/i915: Unwind failure on pinning the gen7 ppgtt

Christian Lamparter (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of the a=
lien cache failed

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

Filipe Manana (4):
      Btrfs: fix deadlock when using free space tree due to block group cre=
ation
      Btrfs: fix access to available allocation bits when starting balance
      Btrfs: fix deadlock when enabling quotas due to concurrent snapshot c=
reation
      Btrfs: use nofs context when initializing security xattrs to avoid de=
adlock

Greg Kroah-Hartman (1):
      Linux 4.20.3

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
      ACPI / PMIC: xpower: Fix TS-pin current-source handling

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specif=
ied
      USB: storage: add quirk for SMI SM3350

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Ivan Mironov (1):
      drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Jan Stancek (1):
      mm: page_mapped: don't assume compound page is huge or THP

Jean-Philippe Brucker (1):
      ACPI/IORT: Fix rc_dma_get_range()

Jerry (Fangzhi) Zuo (1):
      drm/amd/display: Fix MST dp_blank REG_WAIT timeout

Joe Perches (1):
      cifs: check kzalloc return

Kailang Yang (3):
      ALSA: hda/realtek - Support Dell headset mode for New AIO platform
      ALSA: hda/realtek - Add unplug function into unplug state of Headset =
Mode for ALC225
      ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC2=
25

Larry Finger (2):
      staging: rtl8188eu: Fix module loading from tasklet for CCMP encrypti=
on
      staging: rtl8188eu: Fix module loading from tasklet for WEP encryption

Lyude Paul (2):
      drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
      drm/amdgpu: Don't fail resume process if resuming atomic state fails

Marc Zyngier (3):
      PCI: dwc: Use interrupt masking instead of disabling
      PCI: dwc: Take lock when ACKing an interrupt
      PCI: dwc: Move interrupt acking into the proper callback

Michal Hocko (1):
      mm, memcg: fix reclaim deadlock with writeback

Pavel Shilovsky (4):
      CIFS: Fix adjustment of credits for MTU requests
      CIFS: Do not set credits to 1 if the server didn't grant anything
      CIFS: Do not hide EINTR after sending network packets
      CIFS: Fix credit computation for compounded requests

Qian Cai (1):
      mm/usercopy.c: no check page span for stack objects

Quentin Perret (1):
      cpufreq: scmi: Fix frequency invariance in slow path

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array

Saranya Gopal (1):
      usbcore: Select only first configuration for non-UAC3 compliant devic=
es

Shakeel Butt (1):
      fork, memcg: fix cached_stacks case

Theodore Ts'o (6):
      ext4: make sure enough credits are reserved for dioread_nolock writes
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
      ext4: avoid kernel warning when writing the superblock to a dead devi=
ce
      ext4: use ext4_write_inode() when fsyncing w/o a journal
      ext4: track writeback errors using the generic tracking infrastructure
      ext4: fix special inode number checks in __ext4_iget()

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

Viresh Kumar (1):
      cpufreq: scpi/scmi: Fix freeing of dynamic OPPs

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxAaiYACgkQONu9yGCS
aT58Fw/9H7EAQCfdueHUSy8R8cIqhXas3+GFDxc73oHkdZPGbwUVt+eiUpj0Uwcy
+fNqKJNlY/sNQnTFEkJmWftXWZ8oh3oxqXPKYGoQKHrzmFtwpOWCqB13PXJ78UFl
Y0upj+SZo61YUxj7AojhjFZoFnYv2g8WsiXQZ+kBKZdGvbAyYvP+yVGOPJX1r9By
klAL2Wesu228uRwNkGgvKJWHce45FwEUxlAR16AKF6vwquDgExmpWl47tZPwNxYj
VMAJg2+qMNhupd9jihroMqo6HhYv8ZCsqmUvPlW8cJ2saBKucUslAKQUzyXdygDR
yPSFLDS3Mdz6j79RdYqb3OXiWjV8PdgDb0nOurfztAk54hy9MyOsOb2d/kn7RYa6
cE4BxYW+kgzF9O7U04Ls6XEQKX7peEt6RtUTtP8i64SsgHTq8lyNYhtyUQ8m/hqR
e8beMMtY2440F7orj9dyPNLCaxXYu/BV1aNpE8KsUZ/BoL2XeEmASk0f/9mez8mT
zlOD4HKmmWF0VJ1aHxBOJODA4PABL2+pVb98bIKZjEpFt62koMzwqmSZkAk8rzuA
y7Vvo3JRgmesqDu4igdh0FkXadmUbd9TbIgq17/8xKilPzRpG2su7qBtzmW189ae
a700Y4o1qbEJiM8Zx5YBJelEF8kqsEOMbfg1yvjrzigrjrrrQPg=
=5Eaz
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
