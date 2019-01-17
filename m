Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C997C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725331;
	bh=Pn4RCPHkmblDosC5DWTNa8DNO82On9F1TLQ7EqgZsWo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mosmRxkBUToDB7srS6QXIUeqHF737HhhV7GP5JU7hMbMol9edvQAXCF8rvKlbp6rx
	 /WOC7QP4Tjy/EboMIhxRov8Z9/HKLRBy/jx7AI1K1MdBWOwzM0mFxCL+Dj3BbA3Ov2
	 PqtApEP2yasxPRCTI39sFTYN143Ne39BfzKtDnoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfAQLmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfAQLmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:42:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA8020657;
        Thu, 17 Jan 2019 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725328;
        bh=Pn4RCPHkmblDosC5DWTNa8DNO82On9F1TLQ7EqgZsWo=;
        h=Date:From:To:Cc:Subject:From;
        b=hGp4h4uehCYOMqG8X/9Sj0jclrLiUC+duk4MWfdKRhVuftVDgHtzAonc7WfJxPkX8
         +Vlcazgs3beA0Kv05SmAbz5cCDdLQSCSRrwsS/s+oKdfMAH4opA1QApzN/f4GD7KIo
         taG0VHcDWCVjs9uO23heZ93Yqhr7hcLcToWqyFp8=
Date:   Thu, 17 Jan 2019 12:42:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.16
Message-ID: <20190117114206.GA2185@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.16 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arm64/kernel/sys_compat.c                    |    9 -
 arch/arm64/kernel/syscall.c                       |    9 -
 arch/x86/kernel/cpu/bugs.c                        |    2=20
 drivers/acpi/arm64/iort.c                         |    3=20
 drivers/acpi/pmic/intel_pmic_xpower.c             |   41 ++++-
 drivers/acpi/power.c                              |   22 +++
 drivers/block/rbd.c                               |    9 -
 drivers/cpufreq/scmi-cpufreq.c                    |    4=20
 drivers/gpu/drm/Kconfig                           |   20 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |    1=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   37 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     |    4=20
 drivers/gpu/drm/drm_fb_helper.c                   |  151 ++++++++++++++---=
-----
 drivers/gpu/drm/i915/i915_gem_gtt.c               |   15 +-
 drivers/i2c/i2c-dev.c                             |    6=20
 drivers/mtd/nand/raw/qcom_nandc.c                 |   20 +-
 drivers/pci/controller/dwc/pcie-designware-host.c |   37 +++--
 drivers/staging/rtl8188eu/core/rtw_security.c     |    6=20
 drivers/usb/class/cdc-acm.c                       |    7 +
 drivers/usb/core/quirks.c                         |    3=20
 drivers/usb/storage/scsiglue.c                    |    8 -
 drivers/usb/storage/unusual_devs.h                |   12 +
 drivers/vfio/vfio_iommu_type1.c                   |    2=20
 fs/btrfs/ctree.c                                  |   16 +-
 fs/btrfs/qgroup.c                                 |   14 +-
 fs/btrfs/volumes.c                                |   39 +++--
 fs/btrfs/xattr.c                                  |    8 +
 fs/cifs/file.c                                    |    8 -
 fs/cifs/smb2file.c                                |    4=20
 fs/cifs/smb2pdu.c                                 |    8 -
 fs/cifs/transport.c                               |   63 ++++++---
 fs/ext4/fsync.c                                   |   16 +-
 fs/ext4/inline.c                                  |    6=20
 fs/ext4/inode.c                                   |    5=20
 fs/ext4/super.c                                   |    2=20
 include/linux/compiler-gcc.h                      |    2=20
 include/linux/module.h                            |    2=20
 include/linux/sunrpc/svc.h                        |    5=20
 include/trace/events/sunrpc.h                     |    6=20
 mm/memory.c                                       |   23 +++
 mm/slab.c                                         |    6=20
 mm/usercopy.c                                     |    9 -
 mm/util.c                                         |    2=20
 net/sunrpc/svc.c                                  |   11 +
 net/sunrpc/svc_xprt.c                             |    5=20
 net/sunrpc/svcsock.c                              |    2=20
 scripts/mod/modpost.c                             |    2=20
 sound/pci/hda/patch_realtek.c                     |   18 ++
 virt/kvm/arm/arm.c                                |   23 +--
 50 files changed, 508 insertions(+), 227 deletions(-)

Alex Deucher (1):
      drm/amdgpu: Add new VegaM pci id

Alex Williamson (1):
      vfio/type1: Fix unmap overflow off-by-one

Chris Wilson (1):
      drm/i915: Unwind failure on pinning the gen7 ppgtt

Christian Lamparter (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Christoffer Dall (1):
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

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
      Linux 4.19.16

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

Neil Armstrong (1):
      drm/fb_helper: Allow leaking fbdev smem_start

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

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Will Deacon (1):
      arm64: compat: Don't pull syscall number from regs in arm_compat_sysc=
all

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxAag0ACgkQONu9yGCS
aT5N4hAAvpVpZ3D6prHq3HBrwGtvvWVtyjUYSWDFpd6FAEfqyILYAB8+QFdyBzoA
EId5rnjKofgTyGSq7acJqDoZ4b/wDok+WDYgKobW6popwuC+2qzIH/F7vUHBh7Gj
BowAUYklINLn8z4xC+eowWkOTCuHDUuv4Wp6+PZvAb6yCFyp3kIf54NegtJ1bgya
SEyLh+JUxYxrpaaxCz87du5Iqf4UXKaB97u1tQmBvAJbmnYZeV9EhLqvAhKDU/hx
0vusTWPWMizoQADKITz/vCbkTsyHRQnsbCJuHa7s0bznae3S/xbHTga/Zy6RDaaC
EovH5a9G2mGuNYrKBUBCP8Lv9A8J6sGjhpdwqnMul/0LYeDBZCxG7RG9xkOinrjC
H8W/8h1Lwjs4zOewX1UEREn9zD2Z9iOcQzD1M/xuNjS5erFzkIRPmqtFU6WO8uQS
btf5sKsun3oexIODrSkjVtnKyv2KL+j7Prd7yp/6eTInZqCVOOBeOC31B5sR6tNB
K1+oQaBEAnNimSjvjup4WgvN7CQa+W822NGUuk18TBitwpTEXDu7RavGCSqjI3MA
WZBheD1Ai2GXTZbVq0Wvvo4DscKuWb0UGKOFH556bMiG2VV3PTb/S7S5cGZdthPH
q5L1E3m4NxIah7Rfkk3G/vA0Y6N8KyiTqcmUgFQy/lzxRdepp5A=
=2Qar
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
