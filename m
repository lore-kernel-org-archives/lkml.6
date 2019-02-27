Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D821C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551266291;
	bh=WmFgpnOSOSf80p/9JM3A7wXbWcBtSmqus0QeK2hClUc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=t0vTnsrmzv4K83yLrIDYP+9DlDroLV/8JfngIbWUp1lUfOEEMe5FycbC/fjDyDekS
	 AkytUrii6FKFgEZjAOPy4YfT92+BbhFZ5tcK1d4/CKRffVdr4s0gsb3bf43A617y5W
	 sUNpB9eMySnu2iRElfbbuBSaCc3P3aFOPakbsQug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfB0LSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfB0LSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:18:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8687C2147C;
        Wed, 27 Feb 2019 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551266287;
        bh=WmFgpnOSOSf80p/9JM3A7wXbWcBtSmqus0QeK2hClUc=;
        h=Date:From:To:Cc:Subject:From;
        b=2cpA8gnoGOzo0IEGDujNsQVdZIktLS0T0J8u3AbdabA5GZn/2/Kxpj1S3/GyMiJlF
         z/5RhAK7LcYrEdbvpBCDx4WT95SSbWzLLvdFiJABjxb9bZUX3Cu4ymPABQw+vplpsL
         jsMcDew8syObBVCiJ8F9/cqIG/dyjrovZdlFeaTM=
Date:   Wed, 27 Feb 2019 12:18:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.104
Message-ID: <20190227111804.GA5233@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.104 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |    2=20
 arch/arc/include/asm/cache.h                             |   11 +
 arch/arc/kernel/head.S                                   |   14 ++
 arch/arc/kernel/setup.c                                  |   87 ++++++++++=
-----
 arch/arm/probes/kprobes/opt-arm.c                        |    2=20
 arch/mips/configs/ath79_defconfig                        |    1=20
 arch/mips/jazz/jazzdma.c                                 |    5=20
 arch/mips/net/ebpf_jit.c                                 |    9 +
 arch/parisc/kernel/ptrace.c                              |   29 +++--
 arch/x86/xen/enlighten_pv.c                              |    5=20
 drivers/atm/he.c                                         |    2=20
 drivers/gpu/drm/i915/intel_fbdev.c                       |   12 +-
 drivers/gpu/drm/meson/meson_drv.c                        |    9 +
 drivers/hwmon/tmp421.c                                   |    2=20
 drivers/infiniband/ulp/srp/ib_srp.c                      |   10 -
 drivers/isdn/hardware/avm/b1.c                           |    2=20
 drivers/isdn/i4l/isdn_tty.c                              |    6 -
 drivers/leds/leds-lp5523.c                               |    4=20
 drivers/mfd/ab8500-core.c                                |    2=20
 drivers/mfd/bd9571mwv.c                                  |    1=20
 drivers/mfd/db8500-prcmu.c                               |    4=20
 drivers/mfd/mc13xxx-core.c                               |    4=20
 drivers/mfd/mt6397-core.c                                |    3=20
 drivers/mfd/qcom_rpm.c                                   |    4=20
 drivers/mfd/ti_am335x_tscadc.c                           |    5=20
 drivers/mfd/tps65218.c                                   |   24 ----
 drivers/mfd/twl-core.c                                   |    4=20
 drivers/mfd/wm5110-tables.c                              |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c        |    6 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c               |   23 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          |   25 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   12 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c         |   10 +
 drivers/net/phy/phylink.c                                |   19 ++-
 drivers/net/phy/sfp-bus.c                                |    2=20
 drivers/net/phy/sfp.c                                    |   30 +++--
 drivers/net/phy/sfp.h                                    |    2=20
 drivers/net/team/team.c                                  |   27 ----
 drivers/phy/tegra/xusb.c                                 |    2=20
 drivers/pinctrl/pinctrl-max77620.c                       |   14 +-
 drivers/scsi/isci/init.c                                 |   14 +-
 drivers/scsi/qedi/qedi_iscsi.c                           |    3=20
 drivers/scsi/qedi/qedi_iscsi.h                           |    1=20
 drivers/scsi/qla4xxx/ql4_os.c                            |    2=20
 drivers/scsi/ufs/ufshcd.c                                |    2=20
 drivers/xen/pvcalls-back.c                               |    9 -
 fs/ceph/snap.c                                           |    3=20
 fs/proc/base.c                                           |    4=20
 include/keys/user-type.h                                 |    2=20
 include/linux/qed/qed_chain.h                            |   31 +++++
 include/linux/sched/sysctl.h                             |    6 -
 include/linux/skbuff.h                                   |    2=20
 include/linux/virtio_net.h                               |   19 +++
 include/uapi/linux/inet_diag.h                           |   16 +-
 kernel/trace/trace.c                                     |    2=20
 mm/mempolicy.c                                           |    6 -
 net/batman-adv/soft-interface.c                          |    2=20
 net/bridge/br_multicast.c                                |    9 -
 net/ceph/messenger.c                                     |   15 +-
 net/core/filter.c                                        |    7 -
 net/ipv4/inet_diag.c                                     |   10 +
 net/ipv6/netfilter.c                                     |    4=20
 net/ipv6/seg6.c                                          |    4=20
 net/ipv6/sit.c                                           |    3=20
 net/mac80211/cfg.c                                       |    6 -
 net/mac80211/mesh_pathtbl.c                              |   17 +-
 net/netfilter/nf_tables_api.c                            |    5=20
 net/netfilter/nft_compat.c                               |    3=20
 net/packet/af_packet.c                                   |    2=20
 net/sctp/offload.c                                       |    1=20
 net/sctp/sctp_diag.c                                     |    1=20
 security/keys/key.c                                      |    4=20
 security/keys/keyring.c                                  |    4=20
 security/keys/proc.c                                     |    3=20
 security/keys/request_key.c                              |    1=20
 security/keys/request_key_auth.c                         |    2=20
 78 files changed, 429 insertions(+), 238 deletions(-)

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alexey Brodkin (1):
      ARC: define ARCH_SLAB_MINALIGN =3D 8

Bart Van Assche (1):
      RDMA/srp: Rework SCSI device reset handling

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Cheng-Min Ao (1):
      hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attr=
ibute in OF device ID table

Chris Wilson (1):
      drm/i915/fbdev: Actually configure untiled displays

Colin Ian King (2):
      atm: he: fix sign-extension overflow on large shift
      phy: tegra: remove redundant self assignment of 'map'

Cong Wang (1):
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (1):
      mfd: ab8500-core: Return zero in get_register_interruptible()

Denis Bolotin (2):
      qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page=
 count
      qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory =
barrier

Dien Pham (1):
      mfd: bd9571mwv: Add volatile register to make DVFS work

Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Eli Cooper (1):
      netfilter: ipv6: Don't preserve original oif for loopback address

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
      Linux 4.14.104

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

Julia Lawall (1):
      drm/meson: add missing of_node_put

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Kangjie Lu (2):
      mfd: mc13xxx: Fix a missing check of a register-read failure
      leds: lp5523: fix a missing check of return value of lp55xx_read

Keerthy (1):
      mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path i=
n probe()

Konstantin Khlebnikov (1):
      inet_diag: fix reporting cgroup classid and fallback to priority

Li RongQing (1):
      ipv6: propagate genlmsg_reply return code

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()

Manish Rangankar (1):
      scsi: qedi: Add ep_state for login completion on un-reachable targets

Mathieu Desnoyers (1):
      ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

Matthias Kaehlcke (1):
      sched/sysctl: Fix attributes of some extern declarations

Michal Hocko (1):
      proc, oom: do not report alien mms when setting oom_score_adj

Nathan Chancellor (4):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      isdn: avm: Fix string plus integer warning from Clang
      pinctrl: max77620: Use define directive for max77620_pinconf_param va=
lues

Nicolas Boichat (1):
      mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix flush after rule deletion in the same batch
      netfilter: nft_compat: use-after-free when deleting targets

Paul Burton (1):
      MIPS: eBPF: Always return sign extended 32b values

Peter Oskolkov (1):
      bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Quentin Perret (1):
      tracing: Fix number of entries in trace header

Rakesh Pillai (1):
      mac80211: Restore vif beacon interval if start ap fails

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Russell King (2):
      net: sfp: do not probe SFP module before we're attached
      net: phylink: avoid resolving link state too early

Saeed Mahameed (1):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Stanley Chu (1):
      scsi: ufs: Fix system suspend status

Stefano Stabellini (1):
      pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read

Taehee Yoo (1):
      netfilter: nf_tables: fix leaking object reference count

Talons Lee (1):
      always clear the X2APIC_ENABLE bit for PV guest

Tariq Toukan (1):
      net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Thomas Bogendoerfer (1):
      MIPS: jazz: fix 64bit build

Tonghao Zhang (1):
      net/mlx5e: Don't overwrite pedit action when multiple pedit used

Vignesh R (1):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd =
cells

Willem de Bruijn (2):
      net: validate untrusted gso packets without csum offload
      net: avoid false positives in untrusted gso validation

Xin Long (1):
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_seg=
ment

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yonglong Liu (1):
      net: hns: Fix use after free identified by SLUB debug

Yuchung Cheng (1):
      bpf: correctly set initial window on active Fast Open sender

YueHaibing (2):
      xen/pvcalls: remove set but not used variable 'intf'
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx2cewACgkQONu9yGCS
aT5A7A//S1L/cMbnM4X9VTbDa62hWgz3v7mYlLiY67cX/jeDHP8WpPDPasZypxTR
NPnZz9HAWbrC8F4dF8h35Z7smh2losyRqX8nyjwEV9NQCOVhaXQzvHISUFihBFP6
vpdMpI4iPhwYnO22zFedilf9EesUKYhMbQSJvKmXJbXMi61y1lAKbv06mcqLlWoC
W7OYsNcDBhh3dw2oxPOFlx/YjmLS3oQM38nTnNGS+uIHqPTjR0HJBkVAp3v3GIqY
kfPZ5/krC5MNTLTmHE+paX7xaArwZH37TE0VZYR1cwqBwRPLKOoQ8MjVZwmgQeZP
Qpx2NtaubT9FhuMC5+droMEZj5AqUvyM8RB4qxmgEVVbTBpdow7ySJZNMHoAEO/S
dnxDKB+OFXiuoFUcThIbWaY/kQjNDhqrT1u3ho7jPT/hB4FciPgl+iax+lebunzY
efUepu9h7kB3WfyveUGLCSVePL5BR+MxLNaaCjjAT00BaVTcb7bjAOTyayc7o3+h
VwJWT83Z2BHp4OOsNgmpX+kSZwAD8mYyU3drdnJinQcTP09pamrMkWcguiBf1YSy
OedVRd4oQSPs0X6Qdkgn5ymso6v635CyMvE0T6nhQ2jk+NAOmEUbXjSleJjqJPWM
qp38hWVnPYpFHL2qBgfpVclD2dPHrzaaOvPPnXNmPba2f0BN4Gc=
=b4Nc
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
