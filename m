Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3DA21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DA21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIOPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:23:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:23:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5058BACD;
        Sat, 15 Sep 2018 10:04:43 +0000 (UTC)
Date:   Sat, 15 Sep 2018 12:04:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.70
Message-ID: <20180915100440.GA31163@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.70 kernel.

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
 arch/arm/configs/imx_v6_v7_defconfig                     |    2=20
 arch/arm/mach-rockchip/Kconfig                           |    1=20
 arch/arm64/Kconfig.platforms                             |    1=20
 arch/arm64/include/asm/cache.h                           |    5=20
 arch/arm64/include/asm/cpucaps.h                         |    3=20
 arch/arm64/kernel/cpu_errata.c                           |   25 +++-
 arch/arm64/kernel/cpufeature.c                           |    4=20
 arch/powerpc/include/asm/uaccess.h                       |   13 +-
 arch/powerpc/kernel/exceptions-64s.S                     |    6 +
 arch/powerpc/platforms/85xx/t1042rdb_diu.c               |    4=20
 arch/powerpc/platforms/pseries/ras.c                     |    2=20
 arch/powerpc/sysdev/mpic_msgr.c                          |    2=20
 arch/s390/kernel/crash_dump.c                            |   17 ++-
 arch/s390/lib/mem.S                                      |   12 +-
 arch/x86/include/asm/mce.h                               |    1=20
 arch/x86/include/asm/pgtable-3level.h                    |    7 -
 arch/x86/kvm/mmu.c                                       |   43 +++++++-
 arch/x86/kvm/vmx.c                                       |   26 +++-
 arch/x86/kvm/x86.c                                       |   12 +-
 arch/x86/xen/mmu_pv.c                                    |    7 -
 block/bio.c                                              |    2=20
 block/cfq-iosched.c                                      |   22 ++--
 drivers/acpi/scan.c                                      |    5=20
 drivers/clk/rockchip/clk-rk3399.c                        |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                  |    5=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                  |   17 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                    |    2=20
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c                   |    3=20
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                    |   40 +++++--
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c     |   43 ++++++++
 drivers/gpu/drm/drm_edid.c                               |    3=20
 drivers/gpu/drm/i915/intel_lpe_audio.c                   |    4=20
 drivers/gpu/drm/i915/intel_lspcon.c                      |    2=20
 drivers/hid/hid-ids.h                                    |    1=20
 drivers/hid/usbhid/hid-quirks.c                          |    1=20
 drivers/infiniband/hw/hfi1/affinity.c                    |   24 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c                  |    2=20
 drivers/infiniband/hw/hns/hns_roce_qp.c                  |    5=20
 drivers/input/input.c                                    |   16 ++-
 drivers/iommu/omap-iommu.c                               |    4=20
 drivers/irqchip/irq-bcm7038-l1.c                         |    4=20
 drivers/lightnvm/pblk-core.c                             |    1=20
 drivers/lightnvm/pblk-write.c                            |    7 +
 drivers/md/dm-kcopyd.c                                   |    2=20
 drivers/mfd/sm501.c                                      |    1=20
 drivers/net/ethernet/broadcom/genet/bcmgenet.h           |    3=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c             |   10 +
 drivers/net/ethernet/cadence/macb_main.c                 |    9 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |    2=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c  |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |   11 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   20 +++
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c      |   48 ++++++---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c             |   23 +---
 drivers/net/ethernet/realtek/r8169.c                     |    1=20
 drivers/net/hyperv/netvsc_drv.c                          |   16 ++-
 drivers/pci/host/pci-mvebu.c                             |    2=20
 drivers/platform/x86/asus-nb-wmi.c                       |    1=20
 drivers/platform/x86/intel_punit_ipc.c                   |    1=20
 drivers/pwm/pwm-meson.c                                  |    3=20
 drivers/s390/block/dasd_eckd.c                           |   10 +
 drivers/scsi/aic94xx/aic94xx_init.c                      |    4=20
 drivers/staging/comedi/drivers/ni_mio_common.c           |    3=20
 drivers/staging/irda/net/af_irda.c                       |   13 ++
 drivers/usb/dwc3/core.c                                  |   47 ++++++--
 drivers/usb/dwc3/core.h                                  |    5=20
 drivers/vhost/vhost.c                                    |    2=20
 drivers/virtio/virtio_pci_legacy.c                       |   14 ++
 drivers/xen/xen-balloon.c                                |    2=20
 fs/btrfs/dev-replace.c                                   |    6 +
 fs/btrfs/extent-tree.c                                   |    2=20
 fs/btrfs/relocation.c                                    |   23 ++--
 fs/btrfs/volumes.c                                       |    8 +
 fs/cifs/cifs_debug.c                                     |    8 +
 fs/cifs/smb2misc.c                                       |    7 +
 fs/cifs/smb2pdu.c                                        |    2=20
 fs/dcache.c                                              |    3=20
 fs/f2fs/data.c                                           |    4=20
 fs/fat/cache.c                                           |   19 ++-
 fs/fat/fat.h                                             |    5=20
 fs/fat/fatent.c                                          |    6 -
 fs/hfs/brec.c                                            |    7 -
 fs/hfsplus/dir.c                                         |    4=20
 fs/hfsplus/super.c                                       |    4=20
 fs/nfs/nfs4proc.c                                        |    2=20
 fs/proc/kcore.c                                          |    4=20
 fs/reiserfs/reiserfs.h                                   |    2=20
 include/linux/pci_ids.h                                  |    2=20
 include/net/tcp.h                                        |    4=20
 include/uapi/linux/keyctl.h                              |    2=20
 kernel/fork.c                                            |    2=20
 kernel/memremap.c                                        |   11 +-
 kernel/sched/deadline.c                                  |   11 --
 lib/debugobjects.c                                       |    7 -
 mm/fadvise.c                                             |    8 +
 net/9p/trans_fd.c                                        |   10 -
 net/9p/trans_virtio.c                                    |    3=20
 net/ipv4/tcp_ipv4.c                                      |    6 +
 net/ipv4/tcp_minisocks.c                                 |    3=20
 net/ipv4/tcp_ulp.c                                       |    2=20
 net/ipv6/ip6_vti.c                                       |    2=20
 net/ipv6/netfilter/ip6t_rpfilter.c                       |   12 ++
 net/netfilter/ipvs/ip_vs_core.c                          |   15 ++
 net/netfilter/nf_conntrack_netlink.c                     |   26 +++-
 net/netfilter/nfnetlink_acct.c                           |   29 ++---
 net/rds/ib_frmr.c                                        |    1=20
 net/sched/act_ife.c                                      |   79 ++++++++--=
-----
 net/sched/act_pedit.c                                    |   18 ++-
 net/sched/cls_u32.c                                      |    8 +
 net/sctp/proc.c                                          |    4=20
 net/sctp/socket.c                                        |   22 ++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c                    |   12 +-
 net/tipc/socket.c                                        |    2=20
 net/tls/tls_main.c                                       |    1=20
 scripts/depmod.sh                                        |    4=20
 scripts/mod/modpost.c                                    |    8 -
 security/keys/dh.c                                       |    2=20
 sound/soc/codecs/rt5677.c                                |    2=20
 sound/soc/codecs/wm8994.c                                |    1=20
 tools/perf/arch/powerpc/util/sym-handling.c              |    4=20
 tools/perf/util/namespaces.c                             |    3=20
 tools/testing/selftests/powerpc/harness.c                |   18 ++-
 125 files changed, 811 insertions(+), 319 deletions(-)

Aleh Filipovich (1):
      platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX=
360

Alexey Kodanev (1):
      vti6: remove !skb->ignore_df check from vti6_xmit()

Andrey Ryabinin (1):
      mm/fadvise.c: fix signed overflow UBSAN complaint

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time

Anthony Wong (1):
      r8169: add support for NCube 8168 network card

Arnd Bergmann (4):
      reiserfs: change j_timestamp type to time64_t
      x86/mce: Add notifier_block forward declaration
      x86: kvm: avoid unused variable warning
      arm64: cpu_errata: include required headers

Bart Van Assche (1):
      cfq: Suppress compiler warnings about comparisons

Benno Evers (1):
      perf tools: Check for null when copying nsinfo.

Breno Leitao (1):
      selftests/powerpc: Kill child processes on SIGINT

Chao Yu (1):
      f2fs: fix to clear PG_checked flag in set_page_dirty()

Chris Wilson (1):
      drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"

Cong Wang (4):
      act_ife: fix a potential use-after-free
      tipc: fix a missing rhashtable_walk_exit()
      act_ife: move tcfa_lock down to where necessary
      act_ife: fix a potential deadlock

Dan Carpenter (2):
      powerpc: Fix size calculation using resource_size()
      scsi: aic94xx: fix an error code in aic94xx_init()

Daniel Borkmann (1):
      tcp, ulp: add alias for all ulp modules

Dave Young (1):
      HID: add quirk for another PIXART OEM mouse used by HP

Davide Caratti (1):
      net/sched: act_pedit: fix dump of extended layered op

Dexuan Cui (1):
      hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_prob=
e()

Dmitry Torokhov (1):
      Input: do not use WARN() in input_alloc_absinfo()

Doug Berger (1):
      net: bcmgenet: use MAC link status for fixed phy

Eric Dumazet (1):
      ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-W=
AIT state

Ernesto A. Fern=E1ndez (2):
      hfs: prevent crash on exit from failed search
      hfsplus: fix NULL dereference in hfsplus_lookup()

Fabio Estevam (1):
      Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"

Florian Westphal (3):
      tcp: do not restart timewait timer on rst reception
      netfilter: ip6t_rpfilter: set F_IFACE for linklocal addresses
      netfilter: fix memory leaks on netlink_dump_start error

Fredrik Sch=F6n (1):
      drm/i915: Increase LSPCON timeout

Gal Pressman (1):
      RDMA/hns: Fix usage of bitmap allocation functions return values

Greg Edwards (1):
      block: bvec_nr_vecs() returns value for wrong slab

Greg Kroah-Hartman (1):
      Linux 4.14.70

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Gustavo A. R. Silva (1):
      ASoC: wm8994: Fix missing break in switch

Hans de Goede (1):
      ACPI / scan: Initialize status to ACPI_STA_DEFAULT

Ian Abbott (1):
      staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Do not leak RIFs when removing bridge

Jakub Kicinski (1):
      nfp: wait for posted reconfigs when disabling the device

James Morse (1):
      fs/proc/kcore.c: use __pa_symbol() for KCORE_TEXT list entries

James Zhu (2):
      drm/amdgpu: update tmr mc address
      drm/amdgpu:add tmr mc address into amdgpu_firmware_info

Jan H. Sch=F6nherr (1):
      mm: Fix devm_memremap_pages() collision handling

Jann Horn (1):
      fork: don't copy inconsistent signal handler state to child

Jason Wang (1):
      vhost: correctly check the iova range when waking virtqueue

Javier Gonz=E1lez (1):
      lightnvm: pblk: free padded entries in write buffer

Jean-Philippe Brucker (1):
      net/9p: fix error path of p9_virtio_probe

Jerome Brunet (1):
      pwm: meson: Fix mux clock names

Jian Shen (1):
      net: hns3: Fix for phy link issue when using marvell phy driver

Jim Mattson (1):
      kvm: nVMX: Fix fault vector for VMX operation at CPL > 0

Joel Fernandes (Google) (1):
      debugobjects: Make stack check warning more informative

John Pittman (1):
      dm kcopyd: avoid softlockup in run_complete_job

Jonas Gorski (1):
      irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Juergen Gross (2):
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
      x86/xen: don't write ptes directly in 32-bit PV guests

Junaid Shahid (1):
      kvm: x86: Set highest physical address bits in non-present/reserved S=
PTEs

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Kees Cook (1):
      net: sched: Fix memory exposure from short TCA_U32_SEL

Laura Abbott (1):
      sunrpc: Don't use stack buffer with scatterlist

Levin Du (1):
      clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Likun Gao (3):
      drm/amdgpu:add new firmware id for VCN
      drm/amdgpu:add VCN support in PSP driver
      drm/amdgpu:add VCN booting with firmware loaded by PSP

Luca Abeni (1):
      sched/deadline: Fix switching to -deadline

Mahesh Salgaonkar (1):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Marc Zyngier (2):
      arm64: rockchip: Force CONFIG_PM on Rockchip systems
      ARM: rockchip: Force CONFIG_PM on Rockchip systems

Martin Schwidefsky (1):
      s390/lib: use expoline for all bcr instructions

Matthias Kaehlcke (1):
      ASoC: rt5677: Fix initialization of rt5677_of_match.data

Michael Ellerman (2):
      powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
      powerpc/64s: Make rfi_flush_fallback a little more robust

Michael J. Ruhl (1):
      IB/hfi1: Invalid NUMA node information can cause a divide by zero

Michel D=E4nzer (1):
      drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode

Misono Tomohiro (1):
      btrfs: replace: Reset on-disk dev stats value after replace

OGAWA Hirofumi (1):
      fat: validate ->i_start before using

Philipp Rudo (1):
      s390/kdump: Fix memleak in nt_vmcoreinfo

Qu Wenruo (3):
      btrfs: Exit gracefully when chunk map cannot be inserted to the tree
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized
      btrfs: Don't remove block group that still has pinned down bytes

Ralf Goebel (1):
      iommu/omap: Fix cache flushes on L2 table entries

Randy Dunlap (5):
      scripts: modpost: check memory allocation results
      platform/x86: intel_punit_ipc: fix build errors
      powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning
      uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct membe=
r name
      kbuild: make missing $DEPMOD a Warning instead of an Error

Rex Zhu (1):
      drm/amd/pp/Polaris12: Fix a chunk of registers missed to program

Roger Pau Monne (1):
      xen/balloon: fix balloon initialization for PVH Dom0

Roger Quadros (1):
      usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during s=
uspend/resume

Ronnie Sahlberg (1):
      cifs: check if SMB2 PDU size has been padded and suppress the warning

Sandipan Das (1):
      perf probe powerpc: Fix trace event post-processing

Sean Christopherson (1):
      KVM: vmx: track host_state.loaded using a loaded_vmcs pointer

Stefan Haberland (2):
      s390/dasd: fix hanging offline processing due to canceled worker
      s390/dasd: fix panic for failed online processing

Stephen Hemminger (1):
      hv_netvsc: ignore devices that are not PCI

Steve French (2):
      smb3: fix reset of bytes read and written stats
      SMB3: Number of requests sent should be displayed for SMB3 not just C=
IFS

Suzuki K Poulose (3):
      virtio: pci-legacy: Validate queue pfn
      arm64: Fix mismatched cache line size detection
      arm64: Handle mismatched cache type

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tetsuo Handa (2):
      hfsplus: don't return 0 when fill_super() failed
      fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Thomas Petazzoni (1):
      PCI: mvebu: Fix I/O space end address calculation

Tomas Bortoli (1):
      net/9p/trans_fd.c: fix race by holding the lock

Tyler Hicks (2):
      irda: Fix memory leak caused by repeated binds of irda socket
      irda: Only insert new objects into the global database via setsockopt

Vlad Buslov (1):
      net: sched: action_ife: take reference to meta module

Wei Yongjun (1):
      NFSv4: Fix error handling in nfs4_sp4_select_mode()

Xi Wang (1):
      net: hns3: Fix for command format parsing error in hclge_is_all_funct=
ion_id_zero

Xin Long (1):
      sctp: hold transport before accessing its asoc in sctp_transport_get_=
next

YueHaibing (1):
      RDS: IB: fix 'passing zero to ERR_PTR()' warning


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluc2TgACgkQONu9yGCS
aT4Mgw/9HUUw/L4k8VzhSxdtUJVD3VLw1DEehGYlkPhZiE+I+230O3zmm0PzSVhS
uM00kjtp+dbQmTCn/IDf9OwPH1nsBH+lutTnIgVQlxa5mvzy6gP902UvHw4OqeCE
VkhhcazrDSXEjJQgHFfEnbu/Y0XoO9fqBROfMj36uiILQEIW22Hgmzauk4fnzKlu
yEdnEKjnZZ26qSnPuIyJ2LYdyp37sspaJrV78aSkPcLlnuQQZy8otN5Uy6QBqShh
BLNiAKKESjUrc318fr5+29Kb22YGKel7guitN4T6gWfDZJ7wXWJTUcHhh4QeOjpO
eOCforBYo7EBXeLyDJrG6FTsWo0uHGplGzZDFiCruB9m1Yj19Pv15BlpTnKPkM8X
QMFfI3IfyC0w2cRZir70TAEy8+ORhYRz6D1vAGibfkHAqUD/kCswxj/i9cOlMdgI
sNfocpgx8R+AZm+89+BlbAHj1zC+sedv5CtUsTcATMbHw+HpUJKC81ZC4VdL6N3W
ENP7TgWXVq/A4k9vrrr1JkCjeUQkYNUTnSUxHS9xDOIyP2sd9R/3pdptKYUaRDBI
flfZMl1gtEu1lUX8sKaKvjoUGuDzuzPJzVSTZh6gvPghLpmJ/vumx08vyVRYgykb
VKVewUCRkvN90CSQ0cs2yvD24y1aBLv15Ga56VgMQzhDIVJyFNo=
=Z6lq
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
