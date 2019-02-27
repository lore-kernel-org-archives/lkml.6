Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551266259;
	bh=yBoOHe1YzCn9XZbek4M6u/ycLqCT4TowGbbGeXmQ9pU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IdGGVx07sqOTpARAJ2oa6dTNEU53W6TKSFvScClwepWrEzTp5jH6xMHYp3WovEs09
	 SssUmGVJe+dP5YgJ0FyCdLoIrDYhRefBtwtx6swE0pXwATScVAGq19dbVmRCOUAW2F
	 WzTZz4K6zZwjBM6MrKiEmf1LHJ6ZQuUAiGCAOsO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfB0LRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfB0LRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:17:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5212146F;
        Wed, 27 Feb 2019 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551266255;
        bh=yBoOHe1YzCn9XZbek4M6u/ycLqCT4TowGbbGeXmQ9pU=;
        h=Date:From:To:Cc:Subject:From;
        b=GXGtgkXUyu6hcfm0QQSQS9cWABv/1BDwHFveNZpC2wBQq2duLs0dxRt654+gxIzy1
         1HgQ1aghcIRihwS1qu703+hUviobfvB3bKYAVj0G2fTRtIsmitwdOlWrr3i3qmIC73
         ftEi6t3PkpqfildOgEg5VF2KqfKQFA/SOoHIU/lw=
Date:   Wed, 27 Feb 2019 12:17:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.161
Message-ID: <20190227111733.GA31556@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.161 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |   58 ++++------
 arch/arc/include/asm/cache.h                             |   11 +
 arch/arc/kernel/head.S                                   |   14 ++
 arch/arc/kernel/setup.c                                  |   87 ++++++++++=
-----
 arch/arm64/include/asm/arch_gicv3.h                      |   47 +++-----
 arch/mips/configs/ath79_defconfig                        |    1=20
 arch/mips/jazz/jazzdma.c                                 |    5=20
 arch/parisc/kernel/ptrace.c                              |   29 +++--
 arch/x86/boot/compressed/Makefile                        |    1=20
 drivers/atm/he.c                                         |    2=20
 drivers/char/hpet.c                                      |    2=20
 drivers/gpu/drm/i915/i915_irq.c                          |   10 -
 drivers/gpu/drm/i915/intel_display.c                     |   14 +-
 drivers/gpu/drm/i915/intel_drv.h                         |    4=20
 drivers/gpu/drm/i915/intel_fifo_underrun.c               |   24 ++--
 drivers/infiniband/ulp/srp/ib_srp.c                      |   10 -
 drivers/isdn/hardware/avm/b1.c                           |    2=20
 drivers/isdn/i4l/isdn_tty.c                              |    6 -
 drivers/leds/leds-lp5523.c                               |    4=20
 drivers/mfd/ab8500-core.c                                |    2=20
 drivers/mfd/db8500-prcmu.c                               |    4=20
 drivers/mfd/mc13xxx-core.c                               |    4=20
 drivers/mfd/mt6397-core.c                                |    3=20
 drivers/mfd/qcom_rpm.c                                   |    4=20
 drivers/mfd/ti_am335x_tscadc.c                           |    5=20
 drivers/mfd/twl-core.c                                   |    4=20
 drivers/mfd/wm5110-tables.c                              |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c        |    6 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c               |   23 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |    1=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   12 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                |    4=20
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c         |   55 +++++----
 drivers/net/ethernet/stmicro/stmmac/descs.h              |   20 +--
 drivers/net/ethernet/stmicro/stmmac/descs_com.h          |   48 ++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c       |   62 +++++-----
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c           |   55 ++++-----
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c          |   48 ++++----
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c          |   39 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c        |   51 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c         |   10 +
 drivers/net/team/team.c                                  |   27 ----
 drivers/phy/tegra/xusb.c                                 |    2=20
 drivers/pinctrl/pinctrl-max77620.c                       |   14 +-
 drivers/scsi/isci/init.c                                 |   14 +-
 drivers/scsi/qla4xxx/ql4_os.c                            |    2=20
 fs/ceph/snap.c                                           |    3=20
 fs/proc/base.c                                           |    4=20
 include/keys/user-type.h                                 |    2=20
 include/linux/clocksource.h                              |    2=20
 include/linux/sched/sysctl.h                             |    6 -
 kernel/trace/trace.c                                     |    5=20
 mm/mempolicy.c                                           |    6 -
 mm/zsmalloc.c                                            |   11 +
 net/batman-adv/soft-interface.c                          |    2=20
 net/bridge/br_multicast.c                                |    9 -
 net/ceph/messenger.c                                     |   15 +-
 net/core/netpoll.c                                       |    2=20
 net/ipv6/sit.c                                           |    3=20
 net/mac80211/mesh_pathtbl.c                              |   17 +-
 net/netfilter/nf_tables_api.c                            |    3=20
 net/packet/af_packet.c                                   |    2=20
 net/sctp/offload.c                                       |    1=20
 security/keys/key.c                                      |    4=20
 security/keys/keyring.c                                  |    4=20
 security/keys/proc.c                                     |    3=20
 security/keys/request_key.c                              |    1=20
 security/keys/request_key_auth.c                         |    2=20
 68 files changed, 527 insertions(+), 432 deletions(-)

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alexey Brodkin (1):
      ARC: define ARCH_SLAB_MINALIGN =3D 8

Bart Van Assche (1):
      RDMA/srp: Rework SCSI device reset handling

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Colin Ian King (2):
      atm: he: fix sign-extension overflow on large shift
      phy: tegra: remove redundant self assignment of 'map'

Cong Wang (1):
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (1):
      mfd: ab8500-core: Return zero in get_register_interruptible()

David Lin (1):
      kbuild: clang: fix build failures with sparse check

Denis Bolotin (1):
      qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory =
barrier

Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Eric Biggers (3):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len

Eric Dumazet (1):
      batman-adv: fix uninit-value in batadv_interface_tx()

Eugeniy Paltsev (2):
      ARCv2: Enable unaligned access in early ASM code
      ARC: U-boot: check arguments paranoidly

Greg Kroah-Hartman (1):
      Linux 4.9.161

Hangbin Liu (2):
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
      Revert "bridge: do not add port to router list when receives query wi=
th source 0.0.0.0"

Herbert Xu (1):
      mac80211: Free mpath object when rhashtable insertion fails

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jonathan Marek (1):
      mfd: qcom_rpm: write fw_version to CTRL_REG

Jose Abreu (1):
      net: stmmac: Fix PCI module removal leak

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Kangjie Lu (2):
      mfd: mc13xxx: Fix a missing check of a register-read failure
      leds: lp5523: fix a missing check of return value of lp55xx_read

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()

Masahiro Yamada (3):
      kbuild: move cc-option and cc-disable-warning after incl. arch Makefi=
le
      kbuild: add -no-integrated-as Clang option unconditionally
      kbuild: consolidate Clang compiler flags

Matthias Kaehlcke (8):
      hpet: Make cmd parameter of hpet_ioctl_common() unsigned
      clocksource: Use GENMASK_ULL in definition of CLOCKSOURCE_MASK
      netpoll: Fix device name check in netpoll_setup()
      tracing: Use cpumask_available() to check if cpumask variable may be =
used
      x86/boot: Disable the address-of-packed-member compiler warning
      drm/i915: Consistently use enum pipe for PCH transcoders
      mm/zsmalloc.c: change stat type parameter to int
      sched/sysctl: Fix attributes of some extern declarations

Michael Weiser (1):
      net: ethernet: stmmac: change dma descriptors to __le32

Michal Hocko (1):
      proc, oom: do not report alien mms when setting oom_score_adj

Nathan Chancellor (4):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      isdn: avm: Fix string plus integer warning from Clang
      pinctrl: max77620: Use define directive for max77620_pinconf_param va=
lues

Nick Desaulniers (2):
      kbuild: clang: remove crufty HOSTCFLAGS
      mm/zsmalloc.c: fix -Wunneeded-internal-declaration warning

Nicolas Boichat (1):
      mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix flush after rule deletion in the same batch

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Saeed Mahameed (1):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Sodagudi Prasad (1):
      kbuild: clang: disable unused variable warnings only when constant

Stefan Agner (1):
      kbuild: set no-integrated-as before incl. arch Makefile

Tariq Toukan (1):
      net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Thomas Bogendoerfer (1):
      MIPS: jazz: fix 64bit build

Vignesh R (1):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd =
cells

Ville Syrj=E4l=E4 (1):
      drm/i915: Fix enum pipe vs. enum transcoder for the PCH transcoder

Will Deacon (1):
      irqchip/gic-v3: Convert arm64 GIC accessors to {read,write}_sysreg_s

Xin Long (1):
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_seg=
ment

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yonglong Liu (1):
      net: hns: Fix use after free identified by SLUB debug

YueHaibing (1):
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx2ccoACgkQONu9yGCS
aT6qiBAAttCm9U+tR2/AnwKitXDPOENaJlwGUoMljwAd0PTINQxeL56CypSRefVA
GCDOZLHhbLkPx9RGL6OLK92EOW/IQviyGNfyh94MDuoIce54PQcKcRFLrI5Sf+Tj
chUEtXQLjjZhyxmDwDEMHAVrC04ZayqWaxJB7kHN1Csu3CkXRf0hLj+f+Uxutxvb
VlVBzzoVBOEssKksK+uYb6ZzUDEL2R/7uvLhQA6WX6eqRS86R5QuW62Rjq2SBx6v
5MxImK5E3N1dGQlWqFZJx85+s702bJGGguS/oVzP3CE2q7DeCWe7GiXCkbpcQvHy
rAAtOYpIUObgH+JYbjkO6Ss5/b419W4UAUl5d7Mj7OfLlUYtNRkRhST/okNMhcT/
qQymhfljHhkgx3cnnpsWMFOnpT/3O4q+Ki1MFz7p4lTB5hkRnZc3a/1SK+gry1+R
IkVWGjcBaXVPzUKiuNSxleauzbsJ7t4j3MXKzzeqsTmQsdEuyWPx9C869STCd9HF
boN3dNaPzGNpYKfYVuUgPDKG9/fZkhpLqPbXg4/cFSHMykwpht9BfVq2qtkYUqsF
MGk2b0KuP/xw3DnSOnDj94GibfugvWjpoCN2H0ccwPjiR1KsbF/DpM7zXDs56CIe
wH/brMjxKThjezo5SUqgFRn0U3jVgEaVpQAqTk0s4pwPeGBK2yA=
=mDSa
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
