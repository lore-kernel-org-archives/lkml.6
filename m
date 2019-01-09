Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F36C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68B020665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058596;
	bh=N8kfAzADkqNoHHlzSwfIH1Va4V2fW2drsu5/I5RJIj0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qOiR3HlpLkBtF3Ik0Y5wz0MHSpjF17Yg6buQkF3cMlA2dvqBfWllLw4gc0G1ANKjx
	 XGAJA9E6inxMR9SAtSCV30cpr63TfxcaD797Elm7IT/uoyyoZYamUELX4s2YYFwWku
	 snVxbGOJPyPPPHfFiPhnuX0q1Fk+0xsMXwS+33xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfAIS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:29:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfAIS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:29:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14D820665;
        Wed,  9 Jan 2019 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058592;
        bh=N8kfAzADkqNoHHlzSwfIH1Va4V2fW2drsu5/I5RJIj0=;
        h=Date:From:To:Cc:Subject:From;
        b=qpfgD85C/zRqT41a3JntS7hNjejqga762SwEIbCZAB9UqqAqu7rGG6pxnWFKmsav7
         YPUjZGM+uKC/kGoVvZOgD7lp9kaDRtG2Yw0DyTI+ho/IswnoP7MgGKvcbUQ1xAKDtJ
         4eO3+sCYE20rFccZucP+7qlyP36/FJ53l2R3VUqc=
Date:   Wed, 9 Jan 2019 19:29:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.1
Message-ID: <20190109182950.GA17585@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.1 kernel.

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

 Documentation/admin-guide/kernel-parameters.txt             |    3=20
 Documentation/admin-guide/l1tf.rst                          |    6=20
 Makefile                                                    |    2=20
 arch/arc/Kconfig                                            |    1=20
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi           |    9=20
 arch/arm/boot/dts/exynos5422-odroidxu4.dts                  |    9=20
 arch/arm64/include/asm/kvm_arm.h                            |    2=20
 arch/arm64/include/asm/unistd.h                             |    5=20
 arch/arm64/kernel/sys_compat.c                              |   11=20
 arch/arm64/kernel/syscall.c                                 |    9=20
 arch/arm64/kvm/hyp/tlb.c                                    |   35 -
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c          |    7=20
 arch/mips/cavium-octeon/executive/cvmx-helper.c             |    3=20
 arch/mips/include/asm/atomic.h                              |    2=20
 arch/mips/include/asm/cpu-info.h                            |    2=20
 arch/mips/include/asm/mach-loongson64/mmzone.h              |    1=20
 arch/mips/include/asm/mmu.h                                 |    2=20
 arch/mips/include/asm/mmu_context.h                         |   10=20
 arch/mips/include/asm/mmzone.h                              |   13=20
 arch/mips/include/asm/pgtable-64.h                          |    5=20
 arch/mips/include/asm/r4kcache.h                            |   22=20
 arch/mips/kernel/vdso.c                                     |    4=20
 arch/mips/math-emu/dsemul.c                                 |   38 -
 arch/mips/mm/c-r3k.c                                        |    2=20
 arch/mips/mm/c-r4k.c                                        |   44 +
 arch/parisc/mm/init.c                                       |    4=20
 arch/powerpc/kernel/security.c                              |    2=20
 arch/powerpc/kernel/signal_32.c                             |   18=20
 arch/powerpc/kernel/signal_64.c                             |   20=20
 arch/powerpc/kvm/book3s_64_mmu_hv.c                         |    3=20
 arch/powerpc/kvm/book3s_hv.c                                |   17=20
 arch/s390/pci/pci_clp.c                                     |    2=20
 arch/x86/include/asm/kvm_host.h                             |    2=20
 arch/x86/kernel/cpu/bugs.c                                  |    3=20
 arch/x86/kvm/vmx.c                                          |    7=20
 arch/x86/mm/init.c                                          |    2=20
 arch/x86/mm/init_64.c                                       |    6=20
 crypto/cfb.c                                                |    2=20
 crypto/tcrypt.c                                             |    5=20
 crypto/testmgr.c                                            |    7=20
 crypto/testmgr.h                                            |   76 ++
 drivers/android/binder.c                                    |   63 ++
 drivers/base/platform-msi.c                                 |    6=20
 drivers/char/tpm/tpm-interface.c                            |   15=20
 drivers/char/tpm/tpm_i2c_nuvoton.c                          |   11=20
 drivers/clk/rockchip/clk-rk3188.c                           |    2=20
 drivers/clk/sunxi-ng/ccu_nm.c                               |   18=20
 drivers/clocksource/Kconfig                                 |    1=20
 drivers/clocksource/arc_timer.c                             |   22=20
 drivers/crypto/cavium/nitrox/nitrox_algs.c                  |   12=20
 drivers/crypto/cavium/nitrox/nitrox_lib.c                   |   22=20
 drivers/crypto/cavium/nitrox/nitrox_req.h                   |    7=20
 drivers/crypto/chelsio/chcr_ipsec.c                         |    5=20
 drivers/gpu/drm/i915/i915_gem_execbuffer.c                  |    1=20
 drivers/gpu/drm/udl/udl_main.c                              |    7=20
 drivers/gpu/drm/v3d/v3d_debugfs.c                           |   11=20
 drivers/infiniband/hw/hfi1/verbs.c                          |    2=20
 drivers/input/mouse/elan_i2c_core.c                         |    1=20
 drivers/input/touchscreen/atmel_mxt_ts.c                    |    4=20
 drivers/iommu/arm-smmu-v3.c                                 |    8=20
 drivers/isdn/capi/kcapi.c                                   |    4=20
 drivers/media/cec/cec-adap.c                                |   27 -
 drivers/media/cec/cec-pin.c                                 |    5=20
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c               |    2=20
 drivers/media/common/videobuf2/videobuf2-core.c             |    3=20
 drivers/media/i2c/imx274.c                                  |    7=20
 drivers/media/i2c/ov5640.c                                  |   17=20
 drivers/media/platform/vim2m.c                              |    3=20
 drivers/media/platform/vivid/vivid-vid-cap.c                |    2=20
 drivers/media/rc/rc-main.c                                  |    6=20
 drivers/media/usb/dvb-usb-v2/usb_urb.c                      |    5=20
 drivers/media/v4l2-core/v4l2-fwnode.c                       |    4=20
 drivers/misc/ocxl/config.c                                  |    2=20
 drivers/misc/ocxl/link.c                                    |    2=20
 drivers/mtd/nand/raw/marvell_nand.c                         |   17=20
 drivers/mtd/nand/raw/nand_jedec.c                           |    2=20
 drivers/mtd/nand/raw/omap2.c                                |    2=20
 drivers/mtd/spi-nor/Kconfig                                 |    2=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c            |   14=20
 drivers/net/ethernet/ibm/ibmveth.c                          |    6=20
 drivers/net/hamradio/6pack.c                                |   16=20
 drivers/net/tap.c                                           |    3=20
 drivers/net/wan/x25_asy.c                                   |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   11=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c |    8=20
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c               |   50 +
 drivers/rtc/rtc-m41t80.c                                    |    2=20
 drivers/spi/spi-bcm2835.c                                   |   16=20
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c |    1=20
 drivers/staging/wilc1000/wilc_sdio.c                        |    1=20
 drivers/tty/serial/xilinx_uartps.c                          |    4=20
 drivers/usb/Kconfig                                         |    4=20
 drivers/usb/class/cdc-acm.c                                 |   10=20
 drivers/usb/class/cdc-acm.h                                 |    1=20
 drivers/usb/common/Makefile                                 |    1=20
 drivers/usb/common/roles.c                                  |  314 -------=
-----
 drivers/usb/dwc2/hcd.h                                      |    2=20
 drivers/usb/dwc2/hcd_queue.c                                |   19=20
 drivers/usb/dwc2/params.c                                   |    1=20
 drivers/usb/dwc3/dwc3-pci.c                                 |    8=20
 drivers/usb/host/r8a66597-hcd.c                             |    5=20
 drivers/usb/roles/Kconfig                                   |   13=20
 drivers/usb/roles/Makefile                                  |    4=20
 drivers/usb/roles/class.c                                   |  314 +++++++=
+++++
 drivers/usb/serial/option.c                                 |    4=20
 drivers/usb/serial/pl2303.c                                 |    5=20
 drivers/usb/serial/pl2303.h                                 |    5=20
 fs/btrfs/btrfs_inode.h                                      |    6=20
 fs/btrfs/ctree.c                                            |   29 -
 fs/btrfs/dev-replace.c                                      |    6=20
 fs/btrfs/extent-tree.c                                      |    4=20
 fs/btrfs/inode.c                                            |   20=20
 fs/btrfs/scrub.c                                            |   35 +
 fs/btrfs/tree-log.c                                         |   16=20
 fs/cifs/file.c                                              |   12=20
 fs/cifs/smb2maperror.c                                      |    4=20
 fs/cifs/smb2ops.c                                           |    4=20
 fs/ext4/ext4.h                                              |   17=20
 fs/ext4/ialloc.c                                            |    2=20
 fs/ext4/inline.c                                            |    5=20
 fs/ext4/inode.c                                             |   63 +-
 fs/ext4/ioctl.c                                             |    2=20
 fs/ext4/migrate.c                                           |   36 -
 fs/ext4/namei.c                                             |    4=20
 fs/ext4/resize.c                                            |   79 +--
 fs/ext4/super.c                                             |   55 +-
 fs/ext4/xattr.c                                             |   83 +--
 fs/f2fs/data.c                                              |    4=20
 fs/f2fs/node.c                                              |    4=20
 fs/f2fs/super.c                                             |   13=20
 fs/f2fs/xattr.c                                             |   18=20
 fs/file.c                                                   |   29 +
 include/linux/fdtable.h                                     |    1=20
 include/linux/msi.h                                         |    2=20
 include/linux/ptr_ring.h                                    |    2=20
 include/media/cec.h                                         |    1=20
 include/net/ip_tunnels.h                                    |   20=20
 include/net/sock.h                                          |   38 +
 include/trace/events/ext4.h                                 |   20=20
 kernel/cgroup/cgroup.c                                      |   29 -
 kernel/panic.c                                              |    6=20
 net/ax25/af_ax25.c                                          |   11=20
 net/ax25/ax25_dev.c                                         |    2=20
 net/compat.c                                                |   15=20
 net/core/sock.c                                             |   15=20
 net/ieee802154/6lowpan/tx.c                                 |    3=20
 net/ipv4/ip_gre.c                                           |    9=20
 net/ipv4/ip_tunnel.c                                        |    9=20
 net/ipv4/ip_vti.c                                           |   12=20
 net/ipv6/ip6_gre.c                                          |   10=20
 net/ipv6/ip6_tunnel.c                                       |   10=20
 net/ipv6/ip6_vti.c                                          |    8=20
 net/ipv6/ip6mr.c                                            |   17=20
 net/ipv6/sit.c                                              |    3=20
 net/netrom/af_netrom.c                                      |   15=20
 net/packet/af_packet.c                                      |    4=20
 net/sunrpc/svcsock.c                                        |    2=20
 net/tipc/bearer.c                                           |    1=20
 security/keys/keyctl_pkey.c                                 |    2=20
 sound/core/pcm.c                                            |    2=20
 sound/firewire/amdtp-stream-trace.h                         |    4=20
 sound/firewire/amdtp-stream.c                               |    4=20
 sound/firewire/fireface/ff-protocol-ff400.c                 |    2=20
 sound/pci/emu10k1/emufx.c                                   |    5=20
 sound/pci/hda/hda_tegra.c                                   |    2=20
 sound/pci/hda/patch_conexant.c                              |    1=20
 sound/pci/hda/patch_realtek.c                               |    3=20
 sound/pci/rme9652/hdsp.c                                    |   10=20
 sound/soc/intel/boards/cht_bsw_max98090_ti.c                |   14=20
 sound/synth/emux/emux_hwdep.c                               |    7=20
 tools/lib/traceevent/event-parse.c                          |    1=20
 tools/perf/arch/common.c                                    |   10=20
 tools/perf/arch/common.h                                    |    1=20
 tools/perf/builtin-script.c                                 |   12=20
 tools/perf/util/env.c                                       |    2=20
 tools/perf/util/event.c                                     |   29 +
 tools/perf/util/machine.c                                   |   27 +
 tools/perf/util/machine.h                                   |    3=20
 tools/perf/util/pmu.c                                       |    8=20
 tools/perf/util/scripting-engines/trace-event-python.c      |   16=20
 tools/perf/util/session.c                                   |    4=20
 tools/perf/util/thread.h                                    |    4=20
 virt/kvm/arm/arm.c                                          |   23=20
 virt/kvm/arm/vgic/vgic-mmio.c                               |   44 -
 virt/kvm/arm/vgic/vgic.c                                    |    6=20
 187 files changed, 1790 insertions(+), 872 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: mark RGMII interface disabled on OCTEON III

Adrian Hunter (4):
      perf machine: Record if a arch has a single user/kernel address space
      perf thread: Add fallback functions for cases where cpumode is insuff=
icient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf script: Use fallbacks for branch stacks

Alexey Brodkin (1):
      clocksource/drivers/arc_timer: Utilize generic sched_clock

Anand Jain (2):
      btrfs: dev-replace: go back to suspended state if target device is mi=
ssing
      btrfs: dev-replace: go back to suspend state if another EXCL_OP is ru=
nning

Arnaldo Carvalho de Melo (1):
      perf env: Also consider env->arch =3D=3D NULL as local operation

Arnd Bergmann (1):
      mtd: atmel-quadspi: disallow building on ebsa110

Atul Gupta (1):
      crypto: chcr - small packet Tx stalls the queue

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Boris Brezillon (2):
      mtd: rawnand: Fix JEDEC detection
      mtd: rawnand: omap2: Pass the parent of pdev to dma_request_chan()

Breno Leitao (1):
      powerpc/tm: Unset MSR[TS] if not recheckpointing

Christoffer Dall (2):
      KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

Colin Ian King (1):
      staging: wilc1000: fix missing read_write setting when reading data

Cong Wang (5):
      ax25: fix a use-after-free in ax25_fillin_cb()
      netrom: fix locking in nr_find_socket()
      net/wan: fix a double free in x25_asy_open_tty()
      ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()
      tipc: fix a double free in tipc_enable_bearer()

Dan Carpenter (1):
      staging: bcm2835-audio: double free in init error path

Dan Williams (1):
      x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_in=
it()

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Diana Craciun (1):
      powerpc/fsl: Fix spectre_v2 mitigations reporting

Dmitry Eremin-Solenikov (2):
      crypto: testmgr - add AES-CFB tests
      crypto: cfb - fix decryption

Eric Anholt (1):
      drm/v3d: Skip debugfs dumping GCA on platforms without GCA.

Eric Biggers (1):
      KEYS: fix parsing invalid pkey info string

Eric Dumazet (2):
      net/hamradio/6pack: use mod_timer() to rearm timers
      isdn: fix kernel-infoleak in capi_unlocked_ioctl

Eugeniy Paltsev (1):
      DRM: UDL: get rid of useless vblank initialization

Filipe Manana (3):
      Btrfs: fix deadlock with memory reclaim during scrub
      Btrfs: fix fsync of files with multiple hard links in new directories
      Btrfs: send, fix race with transaction commits that create snapshots

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 4.20.1

Greg Kurz (2):
      ocxl: Fix endiannes bug in ocxl_link_update_pe()
      ocxl: Fix endiannes bug in read_afu_name()

Gustavo A. R. Silva (5):
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: emux: Fix potential Spectre v1 vulnerabilities
      KVM: arm/arm64: vgic: Fix off-by-one bug in vgic_get_irq()

Hans Verkuil (6):
      media: cec: keep track of outstanding transmits
      media: cec-pin: fix broken tx_ignore_nack_until_eom error injection
      media: vivid: free bitmap_cap when updating std/timings/etc.
      media: vim2m: use cancel_delayed_work_sync instead of flush_schedule_=
work
      media: vb2: check memory model for VIDIOC_CREATE_BUFS
      media: v4l2-tpg: array index could become negative

Hans de Goede (2):
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Clapper
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Gnawty

Heikki Krogerus (1):
      usb: roles: Add a description for the class to Kconfig

Helge Deller (1):
      parisc: Remap hugepage-aligned pages in set_kernel_text_rw()

Huacai Chen (4):
      MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB
      MIPS: Fix a R10000_LLSC_WAR logic in atomic.h

Ihab Zhaika (1):
      iwlwifi: add new cards for 9560, 9462, 9461 and killer series

Ivan Mironov (1):
      bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some =
hw

Jacopo Mondi (1):
      media: ov5640: Fix set format regression

Jaegeuk Kim (2):
      f2fs: fix missing unlock(sbi->gc_mutex)
      f2fs: sanity check of xattr entry size

Jernej Skrabec (1):
      clk: sunxi-ng: Use u64 for calculation of NM rate

Jia Zhu (1):
      f2fs: fix to update new block address correctly for OPU

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable the headset mic auto detection for ASUS lap=
tops

Johan Jonker (1):
      clk: rockchip: fix typo in rk3188 spdif_frac parent

Josef Bacik (1):
      btrfs: run delayed items before dropping the snapshot

Julien Thierry (1):
      KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled

J=C3=B6rgen Storvist (1):
      USB: serial: option: add Fibocom NL678 series

Linus Torvalds (1):
      i915: fix missing user_access_end() in page fault exception case

Long Li (2):
      CIFS: return correct errors when pinning memory failed for direct I/O
      CIFS: use the correct length when pinning memory for direct I/O for w=
rite

Lu Fengqi (1):
      btrfs: skip file_extent generation check for free_space_inode in run_=
delalloc_nocow

Luca Ceresoli (1):
      media: imx274: fix stack corruption in imx274_read_reg

Lukas Wunner (4):
      spi: bcm2835: Fix race on DMA termination
      spi: bcm2835: Fix book-keeping of DMA termination
      spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
      spi: bcm2835: Unbreak the build of esoteric configs

Lyude Paul (1):
      brcmfmac: Fix out of bounds memory access during fw load

Maciej W. Rozycki (1):
      rtc: m41t80: Correct alarm month range with RTC reads

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Malcolm Priestley (1):
      media: dvb-usb-v2: Fix incorrect use of transfer_flags URB_FREE_BUFFER

Mantas Mikul=C4=97nas (1):
      ALSA: hda: add mute LED support for HP EliteBook 840 G4

Marc Zyngier (3):
      arm64: KVM: Make VHE Stage-2 TLB invalidation operations non-interrup=
tible
      arm/arm64: KVM: vgic: Force VM halt when changing the active state of=
 GICv3 PPIs/SGIs
      KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum

Martin Blumenstingl (2):
      usb: dwc2: disable power_down on Amlogic devices
      f2fs: fix validation of the block count in sanity_check_raw_super

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michael J. Ruhl (1):
      IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Michal Hocko (1):
      x86/speculation/l1tf: Drop the swap storage limit restriction when l1=
tf=3Doff

Miquel Raynal (2):
      mtd: rawnand: marvell: prevent timeouts on a loaded machine
      platform-msi: Free descriptors in platform_msi_domain_free()

Nava kishore Manne (1):
      serial: uartps: Fix interrupt mask issue to handle the RX interrupts =
properly

Ondrej Jirman (1):
      media: v4l2-fwnode: Fix setting V4L2_MBUS_DATA_ACTIVE_HIGH/LOW flag

Pan Bian (2):
      ext4: fix possible use after free in ext4_quota_enable
      f2fs: read page index before freeing

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Paul Aurich (1):
      smb3: fix large reads on encrypted connections

Paul Burton (3):
      MIPS: math-emu: Write-protect delay slot emulation pages
      MIPS: Expand MIPS32 ASIDs to 64 bits
      MIPS: Only include mmzone.h when CONFIG_NEED_MULTIPLE_NODES=3Dy

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix race between kvm_unmap_hva_range and MMU mod=
e switch

Robin Murphy (1):
      iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Sanjeev Chugh (1):
      Input: atmel_mxt_ts - don't try to free unallocated kernel memory

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (2):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
      KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails

Sean Young (1):
      media: rc: cec devices do not have a lirc chardev

Sebastian Ott (1):
      s390/pci: fix sleeping in atomic during hotplug

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Stephan Gerhold (1):
      Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"

Steven Rostedt (VMware) (1):
      tools lib traceevent: Fix processing of dereferenced args in bprintk =
events

Stijn Tintel (1):
      brcmfmac: fix roamoff=3D1 modparam

Sylwester Nawrocki (1):
      ARM: dts: exynos: Specify I2S assigned clocks in proper node

Takashi Sakamoto (4):
      ALSA: fireface: fix for state to fetch PCM frames
      ALSA: firewire-lib: fix wrong handling payload_length as payload_quad=
let
      ALSA: firewire-lib: fix wrong assignment for 'out_packet_without_head=
er' tracepoint
      ALSA: firewire-lib: use the same print format for 'without_header' tr=
acepoints

Tejun Heo (1):
      cgroup: fix CSS_TASK_ITER_PROCS

Terin Stock (1):
      usb: dwc2: host: use hrtimer for NAK retries

Theodore Ts'o (5):
      ext4: add ext4_sb_bread() to disambiguate ENOMEM cases
      ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
      ext4: avoid declaring fs inconsistent due to invalid file handles
      ext4: force inode writes when nfsd calls commit_metadata()
      ext4: check for shutdown and r/o file system in ext4_write_inode()

Todd Kjos (1):
      binder: fix use-after-free due to ksys_close() during fdget()

Tomas Winkler (2):
      tpm: tpm_try_transmit() refactor error flow.
      tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Wandrille RONCE (1):
      ALSA: hda/realtek: Enable audio jacks of ASUS UX391UA with ALC294

Wenwen Wang (1):
      crypto: cavium/nitrox - fix a DMA pool free failure

Will Deacon (3):
      arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1
      arm64: compat: Avoid sending SIGILL for unallocated syscall numbers
      arm64: compat: Don't pull syscall number from regs in arm_compat_sysc=
all

Willem de Bruijn (4):
      tap: call skb_probe_transport_header after setting skb->dev
      ieee802154: lowpan_header_create check must check daddr
      ip: validate header length on virtual device xmit
      packet: validate address length if non-zero

ruippan (=E6=BD=98=E7=9D=BF) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw2PZ0ACgkQONu9yGCS
aT4fqhAAo4IAlMeO0Mwq1wCXq+5r2Pde6pSJ4FhUIZAoYhY+u67fV9EHbD0VNmwJ
bJKWn2eOA6WIgrwqclZDYZdEGDElP+SLdNVNx1fOFpPCBmDMnD7+vpEJ3tiZ3H5l
vt5oDpg9kMk1L86Lx8wBlToScXHREL29Yn42bU5zBysDyZCMKLxnbC3/Lbr5C+oA
gN1HbF6jfTWDcfNWFqxTe+G8PH2j4ZH6NYym+m8S+nu2AC6gPzKh+i4VAXMeVA4U
Po8t885wYiY1Hhb72FImLABafx1vs5hv24xEvEHQZ2b/sBwHM6oW9mkxy9jzEJC7
MNUcsPiCNoFb07tvKXJnb+UBloQUnjAOcz2TXNEWNclnzBytJL8zgPkimxTwaYTE
OG2TGjd3xoMiK9VtSVwDAfuNNQjeMMx8jKBpBgcVeb4id6RnN5tPJD6t0fktz0dl
YYl20xJLHJO2/eo9dyCBtGduhKIRuXM5Wfjnt/AztKwlI8MjRrrbmhX4rIsB8hX0
GJSimqR+vcUEt6G9mWObajiOqfcvl8I792im4yz+XJL5uTqMA/E9mSaFh0X7tVWK
C0cmd4l13yA5iFD/JpVd78iPhSjd9I/IwVcowRUQhewl+/7T28l5/0QXCPcPGNYR
mEIqiir4brgC1QF/p7qw1Zxe1xqNC6HYBcmyWLA5Sp6F9Iesw3c=
=kiv6
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
