Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E4C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5620873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373358;
	bh=PkfT6WQoW6ihzziJsYRTNH69fholrfvqnqyAxyxep54=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tCmy2uw1eyc9HxIRhjy4O+XZ8j0nq/HM09q0clgsOR3D+P68g8Gq+fhu+eE/kUvwl
	 AVMbe0iRWbryBSsIaavIUgUVJ6h22ftvvHy5eq32qFZa68wPQ1UDe9tGVafrOQp5uB
	 UZGcaER0TLos1vbaHu4QA14oIl19MFe9/2hQB0fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfAMJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfAMJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:55:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F9520873;
        Sun, 13 Jan 2019 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373354;
        bh=PkfT6WQoW6ihzziJsYRTNH69fholrfvqnqyAxyxep54=;
        h=Date:From:To:Cc:Subject:From;
        b=FCu3zs4iz4KBjwLntu+oouzl9xUeHlKx26g6TQFEwnyGVCsDbGrM0AaDvb2b3kFhk
         HMG8V4XDgUzYB7xk1lVQD5C47PVNz918jNiOCrHLhOE9EBPPAscWLW6BT38/Ylz8vp
         PQNe/BktNBEZwGnpLGFtw4XrRRaRKFZqi8bn4tNw=
Date:   Sun, 13 Jan 2019 10:55:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.15
Message-ID: <20190113095552.GA23611@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.15 kernel.

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

 Makefile                                             |   29 -
 arch/arm/boot/dts/imx7d-nitrogen7.dts                |    9=20
 arch/arm/boot/dts/imx7d-pico.dtsi                    |   22=20
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |    4=20
 arch/arm/mach-imx/cpuidle-imx6sx.c                   |    2=20
 arch/arm64/Makefile                                  |    2=20
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts         |    7=20
 arch/arm64/kernel/image.h                            |   46 -
 arch/arm64/kernel/vmlinux.lds.S                      |    9=20
 arch/m68k/kernel/setup_mm.c                          |    2=20
 arch/m68k/mm/motorola.c                              |    2=20
 arch/powerpc/Makefile                                |   47 -
 arch/powerpc/boot/Makefile                           |    5=20
 arch/powerpc/boot/crt0.S                             |    4=20
 arch/powerpc/kernel/Makefile                         |   11=20
 arch/powerpc/kernel/signal_32.c                      |   38 -
 arch/powerpc/kernel/signal_64.c                      |   64 +-
 arch/powerpc/kernel/trace/Makefile                   |    2=20
 arch/powerpc/mm/dump_linuxpagetables.c               |    1=20
 arch/powerpc/mm/init_64.c                            |   19=20
 arch/powerpc/platforms/powermac/Makefile             |    2=20
 arch/powerpc/xmon/Makefile                           |    7=20
 arch/x86/include/asm/pgtable_64_types.h              |    5=20
 arch/x86/mm/dump_pagetables.c                        |   15=20
 arch/x86/xen/mmu_pv.c                                |   11=20
 block/blk-mq-sched.c                                 |    3=20
 block/blk-mq-sched.h                                 |    1=20
 block/blk-stat.h                                     |    5=20
 block/blk-wbt.c                                      |    4=20
 block/mq-deadline.c                                  |   12=20
 drivers/auxdisplay/charlcd.c                         |    3=20
 drivers/base/dd.c                                    |    4=20
 drivers/block/zram/zram_drv.c                        |    4=20
 drivers/dax/pmem.c                                   |   14=20
 drivers/gpio/gpio-mvebu.c                            |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c               |    4=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |    2=20
 drivers/gpu/drm/nouveau/dispnv50/disp.c              |   12=20
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c          |    4=20
 drivers/gpu/drm/vc4/vc4_plane.c                      |    1=20
 drivers/hid/hid-ids.h                                |    3=20
 drivers/hid/hid-ite.c                                |    1=20
 drivers/hv/Kconfig                                   |    2=20
 drivers/hwtracing/intel_th/msu.c                     |    3=20
 drivers/iio/dac/ad5686.c                             |    3=20
 drivers/infiniband/core/roce_gid_mgmt.c              |    3=20
 drivers/infiniband/hw/mlx5/devx.c                    |    4=20
 drivers/infiniband/sw/rxe/rxe_resp.c                 |   13=20
 drivers/infiniband/ulp/srpt/ib_srpt.c                |   18=20
 drivers/input/keyboard/omap4-keypad.c                |   16=20
 drivers/input/mouse/synaptics.c                      |    2=20
 drivers/iommu/intel-iommu.c                          |    4=20
 drivers/leds/leds-pwm.c                              |    5=20
 drivers/media/pci/cx23885/cx23885-core.c             |   55 ++
 drivers/media/pci/cx23885/cx23885.h                  |    2=20
 drivers/misc/genwqe/card_utils.c                     |    2=20
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c     |    3=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h          |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |   54 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h       |    4=20
 drivers/net/ethernet/cadence/macb_main.c             |   27 -
 drivers/net/ethernet/cadence/macb_ptp.c              |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c    |    3=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c   |   14=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c    |   15=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c   |  503 ++++++++++++--=
-----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h    |   13=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        |   43 +
 drivers/net/ethernet/ibm/ibmvnic.c                   |   18=20
 drivers/net/ethernet/ibm/ibmvnic.h                   |    2=20
 drivers/net/ethernet/intel/i40e/i40e_main.c          |   14=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c       |   11=20
 drivers/net/ethernet/microchip/lan743x_main.c        |   11=20
 drivers/net/ethernet/neterion/vxge/vxge-config.c     |    2=20
 drivers/net/ethernet/nuvoton/w90p910_ether.c         |    2=20
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c |    3=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c            |    1=20
 drivers/net/ieee802154/ca8210.c                      |    4=20
 drivers/net/ieee802154/mac802154_hwsim.c             |    4=20
 drivers/net/usb/lan78xx.c                            |    4=20
 drivers/net/usb/qmi_wwan.c                           |   15=20
 drivers/net/wireless/broadcom/b43/phy_common.c       |    2=20
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c     |    1=20
 drivers/net/wireless/mediatek/mt76/tx.c              |    7=20
 drivers/nvdimm/pmem.c                                |   13=20
 drivers/of/base.c                                    |  101 ++-
 drivers/of/dynamic.c                                 |    3=20
 drivers/of/of_private.h                              |    4=20
 drivers/pci/pci-driver.c                             |   27 -
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c        |    4=20
 drivers/pinctrl/meson/pinctrl-meson.c                |    3=20
 drivers/power/supply/olpc_battery.c                  |    4=20
 drivers/s390/scsi/zfcp_aux.c                         |    6=20
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                    |    2=20
 drivers/scsi/lpfc/lpfc_sli.c                         |    3=20
 drivers/scsi/qla2xxx/qla_os.c                        |    4=20
 drivers/target/iscsi/cxgbit/cxgbit_cm.c              |    5=20
 drivers/target/iscsi/cxgbit/cxgbit_main.c            |    1=20
 drivers/tty/serial/sunsu.c                           |   31 -
 drivers/video/fbdev/pxafb.c                          |    4=20
 fs/ceph/caps.c                                       |    1=20
 fs/dlm/lock.c                                        |   17=20
 fs/dlm/lockspace.c                                   |    2=20
 fs/gfs2/inode.c                                      |   18=20
 fs/gfs2/rgrp.c                                       |    2=20
 fs/lockd/clntproc.c                                  |    2=20
 fs/lockd/xdr.c                                       |    4=20
 fs/lockd/xdr4.c                                      |    4=20
 fs/nfsd/nfs4proc.c                                   |    2=20
 include/linux/hmm.h                                  |    4=20
 include/linux/memremap.h                             |    2=20
 include/linux/netfilter/nfnetlink.h                  |   12=20
 include/uapi/linux/input-event-codes.h               |    9=20
 kernel/dma/direct.c                                  |   13=20
 kernel/fork.c                                        |   13=20
 kernel/memremap.c                                    |   95 ++-
 kernel/pid.c                                         |    6=20
 kernel/rcu/srcutree.c                                |    2=20
 kernel/sched/fair.c                                  |   43 -
 lib/raid6/Makefile                                   |   15=20
 lib/test_debug_virtual.c                             |    1=20
 mm/hmm.c                                             |  131 ----
 mm/memcontrol.c                                      |   20=20
 mm/memory_hotplug.c                                  |   16=20
 mm/swapfile.c                                        |    3=20
 net/9p/client.c                                      |   21=20
 net/mac80211/iface.c                                 |    3=20
 net/mac80211/main.c                                  |    2=20
 net/mac80211/status.c                                |    5=20
 net/netfilter/ipset/ip_set_list_set.c                |    2=20
 net/netfilter/nf_conncount.c                         |    2=20
 net/netfilter/nf_conntrack_seqadj.c                  |    7=20
 net/netfilter/nf_nat_core.c                          |    3=20
 net/netfilter/nf_tables_api.c                        |   21=20
 net/netfilter/nf_tables_core.c                       |    2=20
 net/sunrpc/auth_gss/svcauth_gss.c                    |    8=20
 net/sunrpc/cache.c                                   |   10=20
 net/sunrpc/xprtsock.c                                |    4=20
 net/tls/tls_main.c                                   |    6=20
 net/wireless/nl80211.c                               |    4=20
 net/xfrm/xfrm_input.c                                |    7=20
 net/xfrm/xfrm_output.c                               |    1=20
 net/xfrm/xfrm_state.c                                |    2=20
 scripts/checkstack.pl                                |    4=20
 security/selinux/ss/policydb.c                       |   51 +
 sound/pci/cs46xx/dsp_spos.c                          |    3=20
 sound/usb/card.c                                     |    2=20
 sound/usb/mixer.c                                    |   29 -
 sound/usb/quirks-table.h                             |    6=20
 sound/usb/stream.c                                   |   36 -
 tools/testing/nvdimm/test/iomap.c                    |   17=20
 tools/virtio/linux/kernel.h                          |    4=20
 152 files changed, 1463 insertions(+), 814 deletions(-)

Alexander Aring (1):
      ieee802154: hwsim: fix off-by-one in parse nested

Alexander Shishkin (1):
      intel_th: msu: Fix an off-by-one in attribute store

Andreas Gruenbacher (2):
      gfs2: Get rid of potential double-freeing in gfs2_create_inode
      gfs2: Fix loop in gfs2_rbm_find

Andrey Grodzovsky (1):
      drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <=3D 0) in amdgpu_ctx.lock

Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Anssi Hannula (3):
      net: macb: fix random memory corruption on RX with 64-bit DMA
      net: macb: fix dropped RX frames due to a race
      net: macb: add missing barriers when reading descriptors

Ard Biesheuvel (2):
      arm64: drop linker script hack to hide __efistub_ symbols
      arm64: relocatable: fix inconsistencies in linker script and options

Arnd Bergmann (1):
      w90p910_ether: remove incorrect __init annotation

Atul Gupta (1):
      net/tls: Init routines in create_ctx

Bart Van Assche (1):
      RDMA/srpt: Fix a use-after-free in the channel release code

Benjamin Coddington (1):
      lockd: Show pid of lockd for remote locks

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Boris Brezillon (1):
      drm/vc4: Set ->is_yuv to false when num_planes =3D=3D 1

Brad Love (1):
      media: cx23885: only reset DMA on problematic CPUs

Breno Leitao (1):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint

Bryan Whitehead (2):
      lan743x: Expand phy search for LAN7431
      lan743x: Remove MAC Reset from initialization

Christian Borntraeger (1):
      genwqe: Fix size check

Christophe Leroy (1):
      lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Colin Ian King (1):
      vxge: ensure data0 is initialized in when fetching firmware version i=
nformation

Corentin Labbe (1):
      ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V

Damien Le Moal (1):
      block: mq-deadline: Fix write completion handling

Dan Carpenter (3):
      scsi: bnx2fc: Fix NULL dereference in error handling
      qed: Fix an error code qed_ll2_start_xmit()
      ALSA: cs46xx: Potential NULL dereference in probe

Dan Williams (6):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: kill mapping "System RAM" support
      mm, devm_memremap_pages: fix shutdown handling
      mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support
      mm, hmm: use devm semantics for hmm_devmem_{add, remove}
      mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

Daniele Palmas (1):
      qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup

David Herrmann (1):
      fork: record start_time late

Dennis Krein (1):
      srcu: Lock srcu_data structure in srcu_gp_start()

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Enric Balletbo i Serra (1):
      drm/rockchip: psr: do not dereference encoder before it is null check=
ed.

Ewan D. Milne (1):
      scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcn=
t is invalid

Fabio Estevam (2):
      ARM: dts: imx7d-pico: Describe the Wifi clock
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Florian Westphal (2):
      netfilter: seqadj: re-load tcp header pointer after possible head rea=
llocation
      netfilter: nat: can't use dst_hold on noref dst

Frank Rowand (2):
      of: of_node_get()/of_node_put() nodes held in phandle cache
      of: __of_detach_node() - remove node from phandle cache

Geert Uytterhoeven (1):
      m68k: Fix memblock-related crashes

Greg Kroah-Hartman (2):
      Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"
      Linux 4.19.15

Hans de Goede (1):
      HID: ite: Add USB id match for another ITE based keyboard rfkill key =
quirk

Himanshu Madhani (1):
      Revert "scsi: qla2xxx: Fix NVMe Target discovery"

Huang Ying (1):
      mm, swap: fix swapoff with KSM pages

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Ivan Mironov (1):
      bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some =
hw

J. Bruce Fields (1):
      nfsd4: zero-length WRITE should succeed

Jarkko Nikula (1):
      PCI / PM: Allow runtime PM without callback functions

Jason Martinsen (1):
      lan78xx: Resolve issue with changing MAC address

Jerome Brunet (2):
      pinctrl: meson: fix pull enable register calculation
      leds: pwm: silently error out on EPROBE_DEFER

Joel Stanley (4):
      powerpc: Disable -Wbuiltin-requires-header when setjmp is used
      Makefile: Export clang toolchain variables
      powerpc/boot: Set target when cross-compiling for clang
      raid6/ppc: Fix build for clang

Johannes Berg (1):
      nl80211: fix memory leak if validate_pae_over_nl80211() fails

Kangjie Lu (1):
      net: netxen: fix a missing check and an uninitialized use

Kirill A. Shutemov (2):
      x86/mm: Fix guard hole handling
      x86/dump_pagetables: Fix LDT remap address marker

Larry Finger (1):
      b43: Fix error in cordic routine

Lendacky, Thomas (1):
      dma-direct: do not include SME mask in the DMA supported check

Linus Torvalds (1):
      sched/fair: Fix infinite loop in update_blocked_averages() by reverti=
ng a9e7f6544b9c

Lorenzo Bianconi (2):
      mt76: fix potential NULL pointer dereference in mt76_stop_tx_queues
      mt76x0: init hw capabilities

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Check rc from drm_dp_mst_topology_mgr_resume=
()

Mans Rullgard (1):
      auxdisplay: charlcd: fix x/y command parsing

Mantas Mikul=C4=97nas (1):
      Input: synaptics - enable SMBus for HP EliteBook 840 G4

Mark Zhang (1):
      IB/core: Fix oops in netdev_next_upper_dev_rcu()

Masahiro Yamada (3):
      kbuild: fix false positive warning/error about missing libelf
      kbuild: add -no-integrated-as Clang option unconditionally
      kbuild: consolidate Clang compiler flags

Matthew Wilcox (1):
      Fix failure path in alloc_pid()

Michael Ellerman (1):
      powerpc/mm: Fix linux page tables build with some configs

Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

Michal Hocko (2):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
      memcg, oom: notify on oom killer invocation from the charge path

Minchan Kim (1):
      zram: fix double free backing device

Ming Lei (1):
      block: deactivate blk_stat timer in wbt_disable_default()

Mircea Caprioru (1):
      iio: dac: ad5686: fix bit shift read register

Nathan Chancellor (1):
      drivers: net: xgene: Remove unnecessary forward declarations

Nicholas Kazlauskas (1):
      drm/amd/display: Fix unintialized max_bpc state values

Nicholas Piggin (3):
      powerpc: remove old GCC version checks
      powerpc: consolidate -mno-sched-epilog into FTRACE flags
      powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer

Oliver O'Halloran (1):
      powerpc/mm: Fallback to RAM if the altmap is unusable

Ondrej Mosnacek (1):
      selinux: policydb - fix byte order and alignment issues

Pan Bian (1):
      netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

Qian Cai (1):
      checkstack.pl: fix for aarch64

Rafael J. Wysocki (1):
      driver core: Add missing dev->bus->need_parent_lock checks

Ross Lagerwall (1):
      ixgbe: Fix race when the VF driver does a reset

Ryder Lee (1):
      arm64: dts: mt7622: fix no more console output on rfb1

Sagi Grimberg (1):
      rxe: fix error completion wr_id and qp_num

Sara Sharon (2):
      mac80211: fix a kernel panic when TXing after TXQ teardown
      mac80211: free skb fraglist before freeing the skb

Shaokun Zhang (1):
      drivers/perf: hisi: Fixup one DDRC PMU register offset

Sinan Kaya (1):
      x86, hyperv: remove PCI dependency

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Stefan Assmann (1):
      i40e: fix mac filter delete when setting mac address

Steffen Klassert (1):
      xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force c=
lears the dst_entry.

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Sudarsana Reddy Kalluru (3):
      bnx2x: Clear fip MAC when fcoe offload support is disabled
      bnx2x: Remove configured vlans as part of unload sequence.
      bnx2x: Send update-svid ramrod with retry/poll flags enabled

Taehee Yoo (2):
      netfilter: nf_tables: fix suspicious RCU usage in nft_chain_stats_rep=
lace()
      netfilter: nf_conncount: use rb_link_node_rcu() instead of rb_link_no=
de()

Takashi Iwai (3):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()
      ALSA: usb-audio: Check mixer unit descriptors more strictly
      ALSA: usb-audio: Always check descriptor sizes in parser code

Thomas Falcon (2):
      ibmvnic: Convert reset work item mutex to spin lock
      ibmvnic: Fix non-atomic memory allocation in IRQ context

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle sta=
tes

Trond Myklebust (1):
      SUNRPC: Fix a race with XPRT_CONNECTING

Uwe Kleine-K=C3=B6nig (1):
      gpio: mvebu: only fail on missing clk if pwm is actually to be used

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix csk leak
      scsi: target: iscsi: cxgbit: add missing spin_lock_init()

Vasily Averin (6):
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()

Wei Yongjun (1):
      xfrm: Fix error return code in xfrm_output_one()

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export

Yangtao Li (1):
      serial/sunsu: fix refcount leak

Yishai Hadas (1):
      IB/mlx5: Block DEVX umem from the non applicable cases

Yonglong Liu (10):
      net: hns: Incorrect offset address used for some registers.
      net: hns: All ports can not work when insmod hns ko after rmmod.
      net: hns: Some registers use wrong address according to the datasheet.
      net: hns: Fixed bug that netdev was opened twice
      net: hns: Clean rx fbd when ae stopped.
      net: hns: Free irq when exit from abnormal branch
      net: hns: Avoid net reset caused by pause frames storm
      net: hns: Fix ntuple-filters status error.
      net: hns: Add mac pcs config when enable|disable mac
      net: hns: Fix ping failed when use net bridge and send multicast

YueHaibing (2):
      ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done
      video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated da=
ta"

Yussuf Khalil (1):
      Input: synaptics - enable RMI on ThinkPad T560


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7CycACgkQONu9yGCS
aT5tFQ//UizSMPP0axpLOXxn/Vxaz81UdfVG/t2FdVkOhtutLzN5O3LQVnHCzYsi
DS3z2Q6QQJxaOQcGfv6+wSNNsGRz8q3V93OjcGJ0Ufc1lEePmNYrLI44ZwNFRXVH
dL92jmrNJSLojOh1jx5UBv6UWEY13mFT1h8rl+WtLi5YOmJEGy+WulhOD8fjHND4
4aQqQqPHSXdG+CepFuNUkQzMP9hAWF9K+x33Yl4tSUq6XhFakSObztnsVynAcNwK
IRGToQ4efuirumLabR1wYj5NFSi1/2m1nJfl5egJJN4RC2euL2B3V1KsR+7oY5OP
a8k2Gklu/hj0pufGL6yls7B/sYkLRHG3CpGIUB3Qin7nDKV8vNbzodinlHbNxJZR
4oPOmnL6j9prhqUkSNCST4IFcPHnvMgo2jhxcktaG7sFHnBF6OhNrVF+d0Bcuv2H
1A23RawWH2FXKCpasMNh2W6XhDlJ0EXASh7GBULAMxWg7SVypCndwMoDUajw1PRR
Oa1HaGfVweyDX41l3zcZ+GgXqXEjt3b/Mj5KhTRgvzA9F1Pqkn3yLE+AnvxaaxSN
OM4XbzPPqQLtJGOLgj3o4XXy1mWevabJ6nylfL3y8CHzPhXIQfjvIh5hZLo0iNbc
8ybbkZCSdoF28Fqq4wIZeCh6ebziUXq1e1QfRylmF9BgHS6skm0=
=UR86
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
