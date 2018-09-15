Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB2ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDE7208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIOPYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:24:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:24:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0543FAF3;
        Sat, 15 Sep 2018 10:06:17 +0000 (UTC)
Date:   Sat, 15 Sep 2018 12:06:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.8
Message-ID: <20180915100615.GA31275@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.8 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 arch/arm/mach-rockchip/Kconfig                              |    1=20
 arch/arm64/Kconfig.platforms                                |    1=20
 arch/powerpc/include/asm/topology.h                         |    5=20
 arch/powerpc/include/asm/uaccess.h                          |   13 -
 arch/powerpc/kernel/exceptions-64s.S                        |    6=20
 arch/powerpc/kernel/smp.c                                   |    5=20
 arch/powerpc/mm/numa.c                                      |   20 -
 arch/powerpc/platforms/85xx/t1042rdb_diu.c                  |    4=20
 arch/powerpc/platforms/pseries/ras.c                        |    2=20
 arch/powerpc/sysdev/mpic_msgr.c                             |    2=20
 arch/riscv/kernel/vdso/Makefile                             |    4=20
 arch/s390/kernel/crash_dump.c                               |   17 +
 arch/um/Makefile                                            |    3=20
 arch/x86/include/asm/mce.h                                  |    1=20
 arch/x86/include/asm/pgtable-3level.h                       |    7=20
 arch/x86/kernel/tsc.c                                       |    4=20
 arch/x86/kvm/mmu.c                                          |   43 +++
 arch/x86/kvm/vmx.c                                          |   26 +-
 arch/x86/kvm/x86.c                                          |   12 -
 arch/x86/xen/mmu_pv.c                                       |    7=20
 block/bio.c                                                 |    2=20
 block/blk-core.c                                            |    4=20
 block/blk-mq-tag.c                                          |    3=20
 block/blk-mq.c                                              |    8=20
 block/cfq-iosched.c                                         |   22 +
 drivers/acpi/acpica/hwregs.c                                |    9=20
 drivers/acpi/scan.c                                         |    5=20
 drivers/clk/rockchip/clk-rk3399.c                           |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                         |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                      |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                     |   23 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                  |   38 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c                      |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                     |    5=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                   |   21 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                     |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                   |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                     |   17 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                |   20 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    2=20
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c                      |    3=20
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                       |    3=20
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                       |   40 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   10=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c       |   10=20
 drivers/gpu/drm/amd/display/dc/bios/command_table.c         |   18 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c               |   11=20
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           |   68 ++++--
 drivers/gpu/drm/amd/display/dc/dc.h                         |    1=20
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c       |    4=20
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c     |    2=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c   |    2=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c |    4=20
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c       |    3=20
 drivers/gpu/drm/amd/display/dc/inc/resource.h               |    5=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c        |   43 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c            |    5=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c          |    2=20
 drivers/gpu/drm/drm_edid.c                                  |    6=20
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                       |    1=20
 drivers/gpu/drm/i915/i915_drv.c                             |   10=20
 drivers/gpu/drm/i915/i915_drv.h                             |    8=20
 drivers/gpu/drm/i915/i915_reg.h                             |    1=20
 drivers/gpu/drm/i915/intel_ddi.c                            |    4=20
 drivers/gpu/drm/i915/intel_dp.c                             |   33 +-
 drivers/gpu/drm/i915/intel_hdmi.c                           |    8=20
 drivers/gpu/drm/i915/intel_lpe_audio.c                      |    4=20
 drivers/gpu/drm/i915/intel_lspcon.c                         |    2=20
 drivers/gpu/drm/i915/intel_lvds.c                           |  136 -------=
-----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                 |   69 ++++--
 drivers/gpu/drm/rockchip/rockchip_lvds.c                    |    4=20
 drivers/hid/hid-redragon.c                                  |   26 --
 drivers/i2c/i2c-core-acpi.c                                 |    8=20
 drivers/infiniband/hw/hfi1/affinity.c                       |   24 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c                     |    2=20
 drivers/infiniband/hw/hns/hns_roce_qp.c                     |    5=20
 drivers/input/input.c                                       |   16 +
 drivers/iommu/omap-iommu.c                                  |    4=20
 drivers/iommu/rockchip-iommu.c                              |   45 ++-
 drivers/irqchip/irq-bcm7038-l1.c                            |    4=20
 drivers/irqchip/irq-stm32-exti.c                            |   25 +-
 drivers/md/dm-kcopyd.c                                      |    2=20
 drivers/mfd/sm501.c                                         |    1=20
 drivers/mtd/ubi/vtbl.c                                      |   20 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                   |    9=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                   |    3=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c             |    7=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c               |   20 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h               |    1=20
 drivers/net/ethernet/broadcom/genet/bcmgenet.h              |    3=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c                |   10=20
 drivers/net/ethernet/cadence/macb_main.c                    |   36 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c     |    2=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c     |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/wq.c                |    5=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h              |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c       |   11=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c    |   20 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c         |   48 ++--
 drivers/net/ethernet/qlogic/qlge/qlge_main.c                |   23 --
 drivers/net/ethernet/realtek/r8169.c                        |    7=20
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                |    1=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |    5=20
 drivers/net/hyperv/netvsc_drv.c                             |   16 +
 drivers/net/usb/r8152.c                                     |    4=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    8=20
 drivers/pci/controller/pci-mvebu.c                          |    2=20
 drivers/pci/probe.c                                         |   12 -
 drivers/pinctrl/pinctrl-axp209.c                            |   26 +-
 drivers/platform/x86/asus-nb-wmi.c                          |    1=20
 drivers/platform/x86/intel_punit_ipc.c                      |    1=20
 drivers/pwm/pwm-meson.c                                     |    3=20
 drivers/s390/block/dasd_eckd.c                              |   10=20
 drivers/scsi/aic94xx/aic94xx_init.c                         |    4=20
 drivers/staging/comedi/drivers/ni_mio_common.c              |    3=20
 drivers/vhost/vhost.c                                       |    2=20
 drivers/virtio/virtio_pci_legacy.c                          |   14 +
 drivers/xen/xen-balloon.c                                   |    2=20
 fs/btrfs/check-integrity.c                                  |    7=20
 fs/btrfs/dev-replace.c                                      |    6=20
 fs/btrfs/extent-tree.c                                      |    2=20
 fs/btrfs/relocation.c                                       |   23 +-
 fs/btrfs/super.c                                            |   44 ++-
 fs/btrfs/tree-checker.c                                     |   15 +
 fs/btrfs/volumes.c                                          |   94 +++++---
 fs/cifs/cifs_debug.c                                        |    8=20
 fs/cifs/connect.c                                           |    8=20
 fs/cifs/smb2misc.c                                          |    7=20
 fs/cifs/smb2pdu.c                                           |  103 ++++---=
--
 fs/dcache.c                                                 |    3=20
 fs/f2fs/data.c                                              |    8=20
 fs/f2fs/file.c                                              |   48 ++--
 fs/fat/cache.c                                              |   19 +
 fs/fat/fat.h                                                |    5=20
 fs/fat/fatent.c                                             |    6=20
 fs/hfs/brec.c                                               |    7=20
 fs/hfsplus/dir.c                                            |    4=20
 fs/hfsplus/super.c                                          |    4=20
 fs/nfs/nfs4proc.c                                           |    2=20
 fs/proc/kcore.c                                             |    4=20
 fs/proc/vmcore.c                                            |    2=20
 fs/reiserfs/reiserfs.h                                      |    2=20
 include/linux/pci_ids.h                                     |    2=20
 include/net/tcp.h                                           |    4=20
 include/uapi/linux/keyctl.h                                 |    2=20
 kernel/bpf/inode.c                                          |    8=20
 kernel/bpf/sockmap.c                                        |  120 ++++++-=
---
 kernel/fork.c                                               |    5=20
 kernel/workqueue.c                                          |   45 ++-
 lib/debugobjects.c                                          |    7=20
 mm/Kconfig                                                  |    2=20
 mm/fadvise.c                                                |    8=20
 net/9p/trans_fd.c                                           |   10=20
 net/9p/trans_virtio.c                                       |    3=20
 net/core/xdp.c                                              |   14 -
 net/ipv4/ip_gre.c                                           |    3=20
 net/ipv4/tcp_ipv4.c                                         |    6=20
 net/ipv4/tcp_minisocks.c                                    |    3=20
 net/ipv4/tcp_ulp.c                                          |    4=20
 net/ipv6/ip6_fib.c                                          |    7=20
 net/ipv6/ip6_gre.c                                          |    1=20
 net/ipv6/ip6_vti.c                                          |    7=20
 net/ipv6/netfilter/ip6t_rpfilter.c                          |   12 -
 net/ipv6/route.c                                            |    3=20
 net/netfilter/ipvs/ip_vs_core.c                             |   15 -
 net/netfilter/nf_conntrack_netlink.c                        |   26 +-
 net/netfilter/nfnetlink_acct.c                              |   29 +-
 net/netfilter/x_tables.c                                    |    7=20
 net/rds/ib_frmr.c                                           |    1=20
 net/sched/act_ife.c                                         |   78 +++---
 net/sched/act_pedit.c                                       |   18 +
 net/sched/cls_u32.c                                         |   10=20
 net/sctp/proc.c                                             |    8=20
 net/sctp/socket.c                                           |   22 +
 net/sunrpc/auth_gss/gss_krb5_crypto.c                       |   12 -
 net/tipc/name_table.c                                       |   10=20
 net/tipc/name_table.h                                       |    9=20
 net/tipc/socket.c                                           |    2=20
 net/tls/tls_main.c                                          |    1=20
 samples/bpf/xdp_redirect_cpu_user.c                         |    3=20
 samples/bpf/xdp_rxq_info_user.c                             |    3=20
 scripts/coccicheck                                          |    5=20
 scripts/depmod.sh                                           |    4=20
 scripts/mod/modpost.c                                       |    8=20
 security/apparmor/policy_ns.c                               |    2=20
 security/keys/dh.c                                          |    2=20
 security/selinux/selinuxfs.c                                |   33 ++
 sound/soc/codecs/rt5677.c                                   |    2=20
 sound/soc/codecs/wm8994.c                                   |    1=20
 tools/perf/arch/arm64/util/arm-spe.c                        |    1=20
 tools/perf/arch/powerpc/util/sym-handling.c                 |    4=20
 tools/perf/util/namespaces.c                                |    3=20
 tools/testing/selftests/powerpc/harness.c                   |   18 +
 194 files changed, 1497 insertions(+), 953 deletions(-)

Ahmad Fatoum (1):
      net: macb: Fix regression breaking non-MDIO fixed-link PHYs

Aleh Filipovich (1):
      platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX=
360

Alex Deucher (1):
      drm/amdgpu: update uvd_v6_0_ring_vm_funcs to use new nop packet

Alexey Kodanev (2):
      vti6: remove !skb->ignore_df check from vti6_xmit()
      ipv6: don't get lwtstate twice in ip6_rt_copy_init()

Anand Jain (5):
      btrfs: fix in-memory value of total_devices after seed device deletion
      btrfs: do btrfs_free_stale_devices outside of device_list_add
      btrfs: extend locked section when adding a new device in device_list_=
add
      btrfs: rename local devices for fs_devices in btrfs_free_stale_device=
s(
      btrfs: use device_list_mutex when removing stale devices

Andrey Ryabinin (1):
      mm/fadvise.c: fix signed overflow UBSAN complaint

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time

Anthony Wong (1):
      r8169: add support for NCube 8168 network card

Anton Vasilyev (1):
      pinctrl: axp209: Fix NULL pointer dereference after allocation

Arnd Bergmann (4):
      fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
      reiserfs: change j_timestamp type to time64_t
      x86/mce: Add notifier_block forward declaration
      x86: kvm: avoid unused variable warning

Aurelien Aptel (1):
      CIFS: fix memory leak and remove dead code

Azat Khuzhin (1):
      r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devic=
es

Bart Van Assche (2):
      cfq: Suppress compiler warnings about comparisons
      btrfs: Fix a C compliance issue

Benno Evers (1):
      perf tools: Check for null when copying nsinfo.

Breno Leitao (1):
      selftests/powerpc: Kill child processes on SIGINT

Chao Yu (3):
      f2fs: avoid race between zero_range and background GC
      f2fs: fix avoid race between truncate and background GC
      f2fs: fix to clear PG_checked flag in set_page_dirty()

Chris Wilson (1):
      drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"

Christian K=F6nig (2):
      drm/amdgpu: fix incorrect use of fcheck
      drm/amdgpu: fix incorrect use of drm_file->pid

Chuanhua Lei (1):
      x86/tsc: Prevent result truncation on 32bit

Cong Wang (4):
      act_ife: fix a potential use-after-free
      act_ife: move tcfa_lock down to where necessary
      act_ife: fix a potential deadlock
      tipc: fix a missing rhashtable_walk_exit()

Dan Carpenter (4):
      apparmor: fix an error code in __aa_create_ns()
      irqchip/stm32: Fix init error handling
      powerpc: Fix size calculation using resource_size()
      scsi: aic94xx: fix an error code in aic94xx_init()

Daniel Borkmann (5):
      bpf, sockmap: fix map elem deletion race with smap_stop_sock
      tcp, ulp: fix leftover icsk_ulp_ops preventing sock from reattach
      bpf, sockmap: fix sock_map_ctx_update_elem race with exist/noexist
      bpf, sockmap: fix leakage of smap_psock_map_entry
      tcp, ulp: add alias for all ulp modules

David Ahern (2):
      net/ipv6: Only update MTU metric if it set
      net/ipv6: Put lwtstate when destroying fib6_info

David Francis (1):
      drm/amd/display: Read back max backlight value at boot

David Sterba (5):
      btrfs: lift uuid_mutex to callers of btrfs_open_devices
      btrfs: lift uuid_mutex to callers of btrfs_scan_one_device
      btrfs: lift uuid_mutex to callers of btrfs_parse_early_options
      btrfs: reorder initialization before the mount locks uuid_mutex
      btrfs: fix mount and ioctl device scan ioctl race

Davide Caratti (1):
      net/sched: act_pedit: fix dump of extended layered op

Denis Efremov (1):
      coccicheck: return proper error code on fail

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

Erik Schmauss (1):
      ACPICA: ACPICA: add status check for acpi_hw_read before assigning re=
turn value

Ernesto A. Fern=E1ndez (2):
      hfs: prevent crash on exit from failed search
      hfsplus: fix NULL dereference in hfsplus_lookup()

Evan Quan (1):
      drm/amd/powerplay: fixed uninitialized value

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
      Linux 4.18.8

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Gustavo A. R. Silva (2):
      drm/amd/display: fix type of variable
      ASoC: wm8994: Fix missing break in switch

Haiqing Bai (1):
      tipc: fix the big/little endian issue in tipc_dest

Haishuang Yan (2):
      ip6_vti: fix creating fallback tunnel device for vti6
      ip6_vti: fix a null pointer deference when destroy vti6 tunnel

Hangbin Liu (1):
      net/ipv6: init ip6 anycast rt->dst.input as ip6_input

Hans de Goede (2):
      i2c: core: ACPI: Make acpi_gsb_i2c_read_bytes() check i2c_transfer re=
turn value
      ACPI / scan: Initialize status to ACPI_STA_DEFAULT

Harry Wentland (1):
      drm/amd/display: Report non-DP display as disconnected without EDID

Heiko Stuebner (1):
      drm/rockchip: vop: split out core clock enablement into separate func=
tions

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

Jan-Marek Glogowski (1):
      drm/i915: Re-apply "Perform link quality check, unconditionally durin=
g long pulse"

Jani Nikula (1):
      drm/i915: set DP Main Stream Attribute for color range on DDI platfor=
ms

Jann Horn (1):
      fork: don't copy inconsistent signal handler state to child

Jason Wang (1):
      vhost: correctly check the iova range when waking virtqueue

Jean-Philippe Brucker (1):
      net/9p: fix error path of p9_virtio_probe

Jens Axboe (1):
      block: don't warn for flush on read-only device

Jerome Brunet (2):
      Revert "net: stmmac: Do not keep rearming the coalesce timer in stmma=
c_xmit"
      pwm: meson: Fix mux clock names

Jesper Dangaard Brouer (1):
      samples/bpf: all XDP samples should unload xdp/bpf prog on SIGTERM

Jian Shen (1):
      net: hns3: Fix for phy link issue when using marvell phy driver

Jianchao Wang (1):
      blk-mq: count the hctx as active before allocating tag

Jim Mattson (1):
      kvm: nVMX: Fix fault vector for VMX operation at CPL > 0

Joel Fernandes (Google) (1):
      debugobjects: Make stack check warning more informative

Johannes Berg (2):
      workqueue: skip lockdep wq dependency in cancel_work_sync()
      workqueue: re-add lockdep dependencies for flushing

John Pittman (1):
      dm kcopyd: avoid softlockup in run_complete_job

Jonas Gorski (1):
      irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Juergen Gross (2):
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
      x86/xen: don't write ptes directly in 32-bit PV guests

Julia Lawall (1):
      drm/rockchip: lvds: add missing of_node_put

Junaid Shahid (1):
      kvm: x86: Set highest physical address bits in non-present/reserved S=
PTEs

Kai-Heng Feng (2):
      r8152: disable RX aggregation on new Dell TB16 dock
      drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Kees Cook (1):
      net: sched: Fix memory exposure from short TCA_U32_SEL

Kim Phillips (1):
      perf arm spe: Fix uninitialized record error variable

Laura Abbott (1):
      sunrpc: Don't use stack buffer with scatterlist

Leo (Sunpeng) Li (1):
      drm/amd/display: Use requested HDMI aspect ratio

Levin Du (1):
      clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Likun Gao (3):
      drm/amdgpu:add new firmware id for VCN
      drm/amdgpu:add VCN support in PSP driver
      drm/amdgpu:add VCN booting with firmware loaded by PSP

Lubosz Sarnecki (1):
      drm/edid: Quirk Vive Pro VR headset non-desktop.

Lucas Stach (1):
      drm/etnaviv: fix crash in GPU suspend when init failed due to buffer =
placement

Mahesh Salgaonkar (1):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Marc Zyngier (4):
      iommu/rockchip: Handle errors returned from PM framework
      iommu/rockchip: Move irq request past pm_runtime_enable
      arm64: rockchip: Force CONFIG_PM on Rockchip systems
      ARM: rockchip: Force CONFIG_PM on Rockchip systems

Masahiro Yamada (1):
      um: fix parallel building with O=3D option

Matthias Kaehlcke (1):
      ASoC: rt5677: Fix initialization of rt5677_of_match.data

Michael Chan (2):
      bnxt_en: Clean up unused functions.
      bnxt_en: Do not adjust max_cp_rings by the ones used by RDMA.

Michael Ellerman (2):
      powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
      powerpc/64s: Make rfi_flush_fallback a little more robust

Michael J. Ruhl (1):
      IB/hfi1: Invalid NUMA node information can cause a divide by zero

Michal Hocko (1):
      netfilter: x_tables: do not fail xt_alloc_table_info too easilly

Michel D=E4nzer (5):
      drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode
      drm/amdgpu: Keep track of amount of pinned CPU visible VRAM
      drm/amdgpu: Make pin_size values atomic
      drm/amdgpu: Warn and update pin_size values when destroying a pinned =
BO
      drm/amdgpu: Don't warn on destroying a pinned BO

Mike Rapoport (1):
      mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM

Mikita Lipski (4):
      drm/amd/display: Don't share clk source between DP and HDMI
      drm/amd/display: update clk for various HDMI color depths
      drm/amd/display: Pass connector id when executing VBIOS CT
      drm/amd/display: Check if clock source in use before disabling

Misono Tomohiro (1):
      btrfs: replace: Reset on-disk dev stats value after replace

Myron Stowe (1):
      PCI: Match Root Port's MPS to endpoint's MPSS as necessary

Nadav Amit (1):
      mm: respect arch_dup_mmap() return value

Nicholas Kazlauskas (1):
      drm/amd/display: Guard against null crtc in CRC IRQ

OGAWA Hirofumi (1):
      fat: validate ->i_start before using

Palmer Dabbelt (1):
      RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when building the vDSO

Philipp Rudo (1):
      s390/kdump: Fix memleak in nt_vmcoreinfo

Qu Wenruo (5):
      btrfs: Exit gracefully when chunk map cannot be inserted to the tree
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized
      btrfs: tree-checker: Detect invalid and empty essential trees
      btrfs: check-integrity: Fix NULL pointer dereference for degraded mou=
nt
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

Rex Zhu (3):
      drm/amdgpu: fix a reversed condition
      drm/amd/pp: Convert voltage unit in mV*4 to mV on CZ/ST
      drm/amd/pp/Polaris12: Fix a chunk of registers missed to program

Richard Weinberger (1):
      ubi: Initialize Fastmap checkmapping correctly

Robert Munteanu (1):
      HID: redragon: fix num lock and caps lock LEDs

Rodrigo Vivi (1):
      drm/i915: Free write_buf that we allocated with kzalloc.

Roger Pau Monne (1):
      xen/balloon: fix balloon initialization for PVH Dom0

Ronnie Sahlberg (1):
      cifs: check if SMB2 PDU size has been padded and suppress the warning

Sandipan Das (1):
      perf probe powerpc: Fix trace event post-processing

Sandy Huang (1):
      drm/rockchip: vop: fix irq disabled after vop driver probed

Sean Christopherson (1):
      KVM: vmx: track host_state.loaded using a loaded_vmcs pointer

Srikar Dronamraju (1):
      powerpc/topology: Get topology for shared processors at boot

Stefan Haberland (2):
      s390/dasd: fix hanging offline processing due to canceled worker
      s390/dasd: fix panic for failed online processing

Stephen Hemminger (1):
      hv_netvsc: ignore devices that are not PCI

Steve French (3):
      smb3: fix reset of bytes read and written stats
      SMB3: Number of requests sent should be displayed for SMB3 not just C=
IFS
      smb3: if server does not support posix do not allow posix mount option

Suzuki K Poulose (1):
      virtio: pci-legacy: Validate queue pfn

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tariq Toukan (2):
      net/mlx5: Fix SQ offset in QPs with small RQ
      net/xdp: Fix suspicious RCU usage warning

Tetsuo Handa (2):
      hfsplus: don't return 0 when fill_super() failed
      fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Thomas Petazzoni (1):
      PCI: mvebu: Fix I/O space end address calculation

Tomas Bortoli (1):
      net/9p/trans_fd.c: fix race by holding the lock

Ville Syrj=E4l=E4 (1):
      drm/i915: Nuke the LVDS lid notifier

Vlad Buslov (1):
      net: sched: action_ife: take reference to meta module

Wei Yongjun (1):
      NFSv4: Fix error handling in nfs4_sp4_select_mode()

Winnie Chang (1):
      brcmfmac: fix brcmf_wiphy_wowl_params() NULL pointer dereference

Xi Wang (1):
      net: hns3: Fix for command format parsing error in hclge_is_all_funct=
ion_id_zero

Xin Long (3):
      sctp: remove useless start_fail from sctp_ht_iter in proc
      erspan: set erspan_ver to 1 by default when adding an erspan dev
      sctp: hold transport before accessing its asoc in sctp_transport_get_=
next

Yonghong Song (1):
      bpf: fix bpffs non-array map seq_show issue

YueHaibing (1):
      RDS: IB: fix 'passing zero to ERR_PTR()' warning

nixiaoming (1):
      selinux: cleanup dentry and inodes on error in selinuxfs


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluc2ZcACgkQONu9yGCS
aT5Thg//WZipswfcyzq9l5MmzThGwPSfTnAoLgSiwzKTYHHr7DcILajRouBqT0nK
PupK6L0F7p78whthiuacxpyEMF/4rp4+5nXLh6RPi4ZnZDPr90zbo9gpXZAcxeFn
lXVrAljnDsp7cZHjLj86PVgsk3c9mkmnrfF/Q+DNSRS51uSFSe7WoNJ9JYx6jJD+
E7QMwBndXHVuaSVCPgjIKGAPkgUSD20+fj5c+B9hVYeo/bQydAISb85LbvCTG/zo
pFA1pmQ8I6lU0HU3PFPhUwhllMJcT6cjaE60Wgv8gEgd6pCOFwUybEYCEdiSyv/O
Pa1EfjE9dU4goRfwkWmE/6WC+iW4YUNX0AdqBRbvPe6ViqDbDBKqUXjziioDP1hL
DabAuTYQEj6WCseYro6vKpIy6LUieE+m1BTekYrv2zSLu77WBOkZ6sMrB+VzoaiV
yp1BDkdYoTR//rWb6zrqB4KG9L/VxaqQ8GpJgYkhqCC/vtUl7u14mRtxhldjYUp8
RubZq8togi2AM7A/H7FkVHZpS5+c5okc6bBdlKbcLuwhjucIra++PGXawwi5j0eL
yvQWD7hJZAfBYvWG4J1fa2CoTadM/WBes8b/gDBzRNoJxVK8ohSuPh7/lxHGHR/L
EL209Z4MvSQYO3WseSYxOZjDOMC3Hi2xVm/+X27k83Nwt+3k9ng=
=2gxY
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
