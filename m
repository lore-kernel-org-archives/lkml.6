Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0C214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0C214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIZPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:12:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeIZPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:12:58 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA73110A3;
        Wed, 26 Sep 2018 09:00:57 +0000 (UTC)
Date:   Wed, 26 Sep 2018 11:00:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.10
Message-ID: <20180926090055.GA12288@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.10 kernel.

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

 Makefile                                                      |   29 +-
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts      |    2=20
 arch/arm/mach-exynos/suspend.c                                |    1=20
 arch/arm/mach-hisi/hotplug.c                                  |   41 ++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                      |    2=20
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi                     |    2=20
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi              |    2=20
 arch/arm64/kernel/perf_event.c                                |   50 ++--
 arch/arm64/kernel/ptrace.c                                    |   19 +
 arch/mips/ath79/setup.c                                       |    1=20
 arch/mips/include/asm/mach-ath79/ath79.h                      |    1=20
 arch/mips/jz4740/Platform                                     |    2=20
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c              |    2=20
 arch/powerpc/kvm/book3s_64_vio.c                              |    5=20
 arch/powerpc/kvm/book3s_hv.c                                  |    2=20
 arch/powerpc/platforms/powernv/opal.c                         |    2=20
 arch/s390/crypto/paes_s390.c                                  |    2=20
 arch/x86/kernel/eisa.c                                        |   10=20
 arch/x86/mm/pti.c                                             |   25 +-
 arch/xtensa/platforms/iss/setup.c                             |   25 +-
 block/blk-core.c                                              |    8=20
 block/blk-mq-sched.c                                          |    3=20
 block/blk-settings.c                                          |    2=20
 crypto/api.c                                                  |    2=20
 drivers/base/core.c                                           |    3=20
 drivers/block/DAC960.c                                        |    9=20
 drivers/char/ipmi/ipmi_bt_sm.c                                |   92 ++++-=
---
 drivers/char/ipmi/ipmi_msghandler.c                           |   53 ++--
 drivers/char/ipmi/ipmi_si_intf.c                              |   17 -
 drivers/char/ipmi/ipmi_ssif.c                                 |   30 --
 drivers/clk/clk-fixed-factor.c                                |    9=20
 drivers/clk/clk.c                                             |    3=20
 drivers/clk/imx/clk-imx6sll.c                                 |    1=20
 drivers/clk/imx/clk-imx6ul.c                                  |    1=20
 drivers/clk/mvebu/armada-37xx-periph.c                        |    3=20
 drivers/clk/tegra/clk-bpmp.c                                  |   12 -
 drivers/crypto/ccp/psp-dev.c                                  |   46 +++-
 drivers/crypto/sahara.c                                       |    4=20
 drivers/devfreq/devfreq.c                                     |    4=20
 drivers/dma/mv_xor_v2.c                                       |    2=20
 drivers/dma/pl330.c                                           |    5=20
 drivers/dma/sh/rcar-dmac.c                                    |    5=20
 drivers/firmware/efi/arm-init.c                               |    1=20
 drivers/firmware/efi/arm-runtime.c                            |    4=20
 drivers/firmware/efi/esrt.c                                   |    3=20
 drivers/gpio/gpio-pxa.c                                       |    2=20
 drivers/gpio/gpiolib.h                                        |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                     |    9=20
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                      |    2=20
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                 |    4=20
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c                 |    9=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c              |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c              |    6=20
 drivers/gpu/drm/nouveau/nouveau_debugfs.c                     |    4=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                         |    6=20
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c            |   13 +
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c                 |    2=20
 drivers/gpu/ipu-v3/ipu-csi.c                                  |   20 +
 drivers/hv/vmbus_drv.c                                        |    3=20
 drivers/hwtracing/coresight/coresight-etm4x.c                 |   31 +-
 drivers/hwtracing/coresight/coresight-tpiu.c                  |    7=20
 drivers/hwtracing/coresight/coresight.c                       |    7=20
 drivers/i2c/busses/i2c-aspeed.c                               |    4=20
 drivers/infiniband/core/cma.c                                 |   12 -
 drivers/infiniband/hw/mlx5/cong.c                             |    9=20
 drivers/infiniband/hw/mlx5/mr.c                               |   32 --
 drivers/infiniband/sw/rxe/rxe_recv.c                          |    9=20
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                       |    2=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                     |    3=20
 drivers/input/joystick/pxrc.c                                 |   66 ++----
 drivers/input/touchscreen/rohm_bu21023.c                      |    4=20
 drivers/iommu/arm-smmu-v3.c                                   |    1=20
 drivers/iommu/io-pgtable-arm-v7s.c                            |    7=20
 drivers/iommu/io-pgtable-arm.c                                |    3=20
 drivers/iommu/ipmmu-vmsa.c                                    |    8=20
 drivers/lightnvm/pblk-init.c                                  |    5=20
 drivers/lightnvm/pblk-recovery.c                              |    5=20
 drivers/md/dm-verity-target.c                                 |   24 +-
 drivers/media/common/videobuf2/videobuf2-core.c               |    5=20
 drivers/media/i2c/ov5645.c                                    |   13 -
 drivers/media/pci/tw686x/tw686x-video.c                       |   11 -
 drivers/mfd/88pm860x-i2c.c                                    |    8=20
 drivers/misc/hmc6352.c                                        |    2=20
 drivers/misc/ibmvmc.c                                         |    2=20
 drivers/misc/mei/bus-fixup.c                                  |    2=20
 drivers/misc/mei/bus.c                                        |   12 -
 drivers/misc/mei/hbm.c                                        |    9=20
 drivers/mmc/host/meson-mx-sdio.c                              |    8=20
 drivers/mmc/host/omap_hsmmc.c                                 |    1=20
 drivers/mmc/host/sdhci-of-esdhc.c                             |    6=20
 drivers/mmc/host/sdhci-tegra.c                                |    3=20
 drivers/mmc/host/sdhci.c                                      |    9=20
 drivers/mtd/maps/solutionengine.c                             |    6=20
 drivers/mtd/mtdchar.c                                         |   10=20
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                     |    7=20
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c       |    3=20
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c       |    3=20
 drivers/net/ethernet/cortina/gemini.c                         |    5=20
 drivers/net/ethernet/emulex/benet/be_cmds.c                   |    2=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c               |    8=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c       |    5=20
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c               |    6=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                 |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/dev.c                 |   15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |   76 +++---
 drivers/net/ethernet/mellanox/mlx5/core/health.c              |   10=20
 drivers/net/ethernet/mellanox/mlx5/core/main.c                |   12 -
 drivers/net/ethernet/mellanox/mlx5/core/wq.c                  |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/wq.h                  |    2=20
 drivers/net/ethernet/netronome/nfp/nfp_main.c                 |   20 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c           |   13 -
 drivers/net/ethernet/qualcomm/qca_7k.c                        |   76 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c                       |  110 +++++=
-----
 drivers/net/ethernet/qualcomm/qca_spi.h                       |    5=20
 drivers/net/wan/fsl_ucc_hdlc.c                                |    6=20
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h            |   12 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c                  |   11 -
 drivers/net/xen-netfront.c                                    |   30 +-
 drivers/nvme/host/rdma.c                                      |    2=20
 drivers/nvme/target/io-cmd-file.c                             |   18 -
 drivers/of/base.c                                             |   28 ++
 drivers/parport/parport_sunbpp.c                              |    8=20
 drivers/pci/pcie/aer.c                                        |    6=20
 drivers/pinctrl/mediatek/pinctrl-mt7622.c                     |    4=20
 drivers/pinctrl/pinctrl-rza1.c                                |   24 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                            |   14 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      |   32 ++
 drivers/platform/x86/toshiba_acpi.c                           |    3=20
 drivers/regulator/qcom_spmi-regulator.c                       |   34 +--
 drivers/remoteproc/qcom_q6v5_pil.c                            |    1=20
 drivers/reset/reset-imx7.c                                    |    2=20
 drivers/rtc/rtc-bq4802.c                                      |    4=20
 drivers/s390/net/qeth_core_main.c                             |    3=20
 drivers/s390/net/qeth_core_sys.c                              |    1=20
 drivers/scsi/libfc/fc_disc.c                                  |    7=20
 drivers/scsi/lpfc/lpfc_nvme.c                                 |    5=20
 drivers/scsi/lpfc/lpfc_nvmet.c                                |   12 +
 drivers/soc/qcom/smem.c                                       |   10=20
 drivers/spi/spi-dw.c                                          |    3=20
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c                |    2=20
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c   |   16 -
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c |    7=20
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c     |   11 -
 drivers/tty/serial/8250/8250_of.c                             |    2=20
 drivers/tty/tty_baudrate.c                                    |   13 -
 drivers/usb/class/cdc-acm.c                                   |   73 ------
 drivers/usb/class/cdc-acm.h                                   |    1=20
 drivers/usb/class/cdc-wdm.c                                   |    2=20
 drivers/usb/core/hcd-pci.c                                    |    2=20
 drivers/usb/core/message.c                                    |   11 +
 drivers/usb/core/quirks.c                                     |    7=20
 drivers/usb/dwc3/gadget.h                                     |    2=20
 drivers/usb/gadget/udc/net2280.c                              |   16 +
 drivers/usb/gadget/udc/renesas_usb3.c                         |    5=20
 drivers/usb/host/u132-hcd.c                                   |    2=20
 drivers/usb/host/xhci-mem.c                                   |    4=20
 drivers/usb/host/xhci.c                                       |   30 ++
 drivers/usb/misc/uss720.c                                     |    4=20
 drivers/usb/misc/yurex.c                                      |    5=20
 drivers/usb/mtu3/mtu3_core.c                                  |    6=20
 drivers/usb/mtu3/mtu3_hw_regs.h                               |    1=20
 drivers/usb/serial/io_ti.h                                    |    2=20
 drivers/usb/serial/ti_usb_3410_5052.c                         |    2=20
 drivers/usb/storage/scsiglue.c                                |    9=20
 drivers/usb/storage/uas.c                                     |   21 +
 drivers/usb/storage/unusual_devs.h                            |    7=20
 drivers/video/fbdev/core/modedb.c                             |   41 ++-
 drivers/video/fbdev/goldfishfb.c                              |    1=20
 drivers/video/fbdev/omap/omapfb_main.c                        |    2=20
 drivers/video/fbdev/omap2/omapfb/Makefile                     |    4=20
 drivers/video/fbdev/pxafb.c                                   |    4=20
 drivers/video/fbdev/via/viafbdev.c                            |    3=20
 fs/binfmt_elf.c                                               |    2=20
 fs/cifs/readdir.c                                             |   11 -
 fs/cifs/smb2pdu.c                                             |   29 +-
 fs/configfs/dir.c                                             |   11 +
 fs/f2fs/super.c                                               |   16 +
 fs/gfs2/bmap.c                                                |    2=20
 fs/gfs2/rgrp.c                                                |    3=20
 fs/namespace.c                                                |    7=20
 fs/nfs/nfs4proc.c                                             |   10=20
 fs/nfs/nfs4state.c                                            |    2=20
 fs/nfs/nfs4trace.h                                            |    2=20
 fs/overlayfs/super.c                                          |   26 +-
 fs/pstore/ram_core.c                                          |   17 +
 include/linux/crypto.h                                        |    5=20
 include/linux/mlx5/driver.h                                   |    4=20
 include/linux/of.h                                            |    8=20
 kernel/audit_watch.c                                          |   12 +
 kernel/bpf/cgroup.c                                           |    7=20
 kernel/events/core.c                                          |    4=20
 kernel/rcu/rcutorture.c                                       |    5=20
 kernel/sched/fair.c                                           |   10=20
 kernel/sched/wait.c                                           |   47 +---
 net/bluetooth/af_bluetooth.c                                  |    2=20
 net/core/skbuff.c                                             |    3=20
 net/ipv4/ip_gre.c                                             |    5=20
 net/ipv4/tcp.c                                                |    2=20
 net/mac80211/cfg.c                                            |    2=20
 net/mac80211/key.c                                            |   24 +-
 net/rds/bind.c                                                |    5=20
 net/tipc/socket.c                                             |    1=20
 net/tls/tls_sw.c                                              |   14 +
 net/xfrm/xfrm_policy.c                                        |    5=20
 scripts/Kbuild.include                                        |    3=20
 security/integrity/evm/evm_crypto.c                           |    3=20
 security/security.c                                           |    2=20
 security/smack/smack_lsm.c                                    |   14 -
 sound/core/pcm_lib.c                                          |   14 -
 sound/isa/msnd/msnd_pinnacle.c                                |    4=20
 sound/soc/codecs/hdmi-codec.c                                 |   21 +
 sound/soc/codecs/rt5514.c                                     |    8=20
 sound/soc/codecs/rt5651.c                                     |   22 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                              |    2=20
 sound/usb/quirks-table.h                                      |    3=20
 sound/usb/quirks.c                                            |    2=20
 tools/hv/hv_kvp_daemon.c                                      |    2=20
 tools/perf/arch/powerpc/util/skip-callchain-idx.c             |   10=20
 tools/perf/tests/builtin-test.c                               |    2=20
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh         |   36 ++-
 tools/perf/util/comm.c                                        |   16 +
 tools/perf/util/header.c                                      |    2=20
 tools/perf/util/machine.c                                     |    9=20
 tools/perf/util/map.c                                         |   11 +
 tools/perf/util/unwind-libdw.c                                |    2=20
 tools/perf/util/unwind-libunwind-local.c                      |    2=20
 tools/testing/nvdimm/test/nfit.c                              |    3=20
 tools/testing/selftests/android/ion/ionapp_export.c           |    1=20
 tools/testing/selftests/timers/raw_skew.c                     |    5=20
 tools/testing/selftests/vDSO/vdso_test.c                      |    7=20
 virt/kvm/arm/vgic/vgic-init.c                                 |    4=20
 virt/kvm/arm/vgic/vgic-mmio-v2.c                              |    3=20
 233 files changed, 1562 insertions(+), 919 deletions(-)

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Adrian Hunter (1):
      perf tools: Fix maps__find_symbol_by_name()

Alan Stern (1):
      USB: net2280: Fix erroneous synchronization change

Alexander Sverdlin (1):
      serial: 8250: of: Correct of_platform_serial_setup() error handling

Alexander Usyskin (1):
      mei: ignore not found client in the enumeration

Alexandre Belloni (1):
      spi: dw: fix possible race condition

Alexandru Gagniuc (1):
      PCI/AER: Honor "pcie_ports=3Dnative" even if HEST sets FIRMWARE_FIRST

Alexey Kardashevskiy (1):
      KVM: PPC: Book3S: Fix matching of hardware and emulated TCE tables

Andrea Parri (1):
      sched/core: Use smp_mb() in wake_woken_function()

Andreas Gruenbacher (1):
      gfs2: Special-case rindex for gfs2_grow

Andreas Kemnade (1):
      mmc: omap_hsmmc: fix wakeirq handling on removal

Andy Shevchenko (1):
      gpiolib: Mark gpio_suffixes array with __maybe_unused

Anton Vasilyev (1):
      video: goldfishfb: fix memory leak on driver remove

Ard Biesheuvel (2):
      efi/arm: preserve early mapping of UEFI memory map longer for BGRT
      efi/esrt: Only call efi_mem_reserve() for boot services memory

Arnd Bergmann (2):
      omapfb: rename omap2 module to omap2fb.ko
      rcutorture: Use monotonic timestamp for stall detection

Arvind Yadav (1):
      PM / devfreq: use put_device() instead of kfree()

Ben Hutchings (1):
      USB: yurex: Fix buffer over-read in yurex_write()

Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

Bjorn Andersson (1):
      soc: qcom: smem: Correct check for global partition

Bob Peterson (1):
      gfs2: Don't reject a supposedly full bitmap if we have blocks reserved

Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests

Boris Pismenny (1):
      tls: Fix zerocopy_from_iter iov handling

Brijesh Singh (1):
      crypto: ccp - add timeout support in the SEV command

Bryant G. Ly (1):
      misc: ibmvsm: Fix wrong assignment of return code

Christoffer Dall (1):
      KVM: arm/arm64: Fix vgic init race

Chunfeng Yun (2):
      usb: xhci: fix interrupt transfer error happened on MTK platforms
      usb: mtu3: fix error of xhci port id when enable U3 dual role

Cong Wang (2):
      rds: fix two RCU related problems
      tipc: orphan sock in tipc_release()

Corey Minyard (3):
      ipmi: Rework SMI registration failure
      ipmi: Move BT capabilities detection to the detect call
      ipmi: Fix I2C client removal in the SSIF driver

Dan Carpenter (7):
      fbdev: omapfb: off by one in omapfb_register_client()
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      cifs: integer overflow in in SMB2_ioctl()
      ASoC: qdsp6: q6afe-dai: fix a range check in of_q6afe_parse_dai_data()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
      mei: bus: type promotion bug in mei_nfc_if_version()

Dan Williams (1):
      tools/testing/nvdimm: Fix support for emulating controller temperature

Daniel Mack (1):
      video: fbdev: pxafb: clear allocated memory for video modes

Dmitry Torokhov (1):
      Input: pxrc - fix freeing URB on device teardown

Douglas Anderson (2):
      pinctrl: msm: Fix msm_config_group_get() to be compliant
      pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Enrico Scholz (1):
      gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes

Eric Biggers (1):
      security: check for kstrdup() failure in lsm_append()

Eric Yang (1):
      drm/amd/display: support access ddc for mst branch

Erich E. Hoover (1):
      usb: dwc3: change stream event enable bit back to 13

Felix Fietkau (1):
      MIPS: ath79: fix system restart

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Golan Ben Ami (1):
      iwlwifi: cancel the injective function between hw pointers to tfd ent=
ry index

Greg Kroah-Hartman (1):
      Linux 4.18.10

Gregory CLEMENT (1):
      clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent

Gustavo A. R. Silva (1):
      misc: hmc6352: fix potential Spectre v1

Haishuang Yan (2):
      erspan: fix error handling for erspan tunnel
      erspan: return PACKET_REJECT when the appropriate tunnel is not found

Hanna Hawa (1):
      dmaengine: mv_xor_v2: kill the tasklets upon exit

Hannes Reinecke (1):
      scsi: libfc: fixup 'sleeping function called from invalid context'

Hans Holmberg (1):
      lightnvm: pblk: assume that chunks are closed on 1.2 devices

Hans Verkuil (1):
      media: videobuf2-core: check for q->error in vb2_core_qbuf()

Hans de Goede (1):
      ASoC: rt5651: Fix workqueue cancel vs irq free race on remove

Harry Wentland (1):
      drm/amd/pp: Send khz clock values to DC for smu7/8

Huazhong Tan (2):
      net: hns3: Reset net device with rtnl_lock
      net: hns3: Fix return value error in hns3_reset_notify_down_enet

Huy Nguyen (1):
      net/mlx5: Check for error in mlx5_attach_interface

Ingo Franzki (1):
      s390/crypto: Fix return code checking in cbc_paes_crypt()

Ioana Radulescu (1):
      staging: fsl-dpaa2/eth: Fix DMA mapping direction

Jack Morgenstein (2):
      net/mlx5: Fix use-after-free in self-healing flow
      net/mlx5: Fix debugfs cleanup in the device init/remove flow

Jae Hyun Yoo (1):
      i2c: aspeed: Fix initial values of master and slave state

Jaegeuk Kim (1):
      f2fs: do checkpoint in kill_sb

Jakub Kicinski (2):
      nfp: don't fail probe on pci_sriov_set_totalvfs() errors
      nfp: avoid buffer leak when FW communication fails

James Smart (2):
      scsi: lpfc: Fix NVME Target crash in defer rcv logic
      scsi: lpfc: Fix panic if driver unloaded when port is offline

Jann Horn (2):
      mtdchar: fix overflows in adjustment of `count`
      IB/mlx5: fix uaccess beyond "count" in debugfs read/write handlers

Jean-Philippe Brucker (2):
      iommu/io-pgtable-arm-v7s: Abort allocation when table address overflo=
ws the PTE
      iommu/io-pgtable-arm: Fix pgtable allocation in selftest

Jeff Crukley (1):
      ALSA: usb-audio: Add support for Encore mDSD USB DAC

Jia-Ju Bai (3):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstandin=
g_interrupt()

Jiang Biao (2):
      x86/pti: Check the return value of pti_user_pagetable_walk_p4d()
      x86/pti: Check the return value of pti_user_pagetable_walk_pmd()

Jiri Olsa (2):
      perf tools: Synthesize GROUP_DESC feature in pipe mode
      perf tools: Fix struct comm_str removal crash

Joerg Roedel (1):
      x86/mm/pti: Add an overflow check to pti_clone_pmds()

Johan Hovold (6):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler
      of: add helper to lookup compatible child node
      mmc: meson-mx-sdio: fix OF child-node lookup
      tty: fix termios input-speed encoding when using BOTHER
      tty: fix termios input-speed encoding

John Keeping (1):
      dmaengine: pl330: fix irq race with terminate_all

John Stultz (1):
      selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock =
adjustments are in progress

Juergen Gross (1):
      xen/netfront: fix waiting for xenbus state change

Julia Lawall (1):
      parport: sunbpp: fix error return code

Julian Wiedmann (2):
      s390/qeth: fix race in used-buffer accounting
      s390/qeth: reset layer2 attribute on layer switch

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Karol Herbst (1):
      drm/nouveau/debugfs: Wake up GPU before doing any reclocking

Krzysztof Ha?asa (1):
      media: tw686x: Fix oops on buffer alloc failure

Krzysztof Kozlowski (1):
      ARM: exynos: Clear global variable on init error path

Laurentiu Tudor (1):
      mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips

Leonard Crestez (1):
      reset: imx7: Fix always writing bits as 0

Li Zhijian (1):
      selftests/android: initialize heap_type to avoid compiling warning

Linus Walleij (1):
      net: gemini: Allow multiple ports to instantiate

Loic Poulain (1):
      arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Lyude Paul (1):
      drm/nouveau: Fix runtime PM leak in drm_open()

Maciej W. Rozycki (1):
      binfmt_elf: Respect error return from `regset->active'

Manikanta Pubbisetty (1):
      mac80211: restrict delayed tailroom needed decrement

Mark Rutland (2):
      KVM: arm/arm64: vgic: Fix possible spectre-v1 write in vgic_mmio_writ=
e_apr()
      arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()

Masahiro Yamada (2):
      kbuild: add .DELETE_ON_ERROR special target
      kbuild: do not update config when running install targets

Mathias Nyman (3):
      xhci: Fix use after free for URB cancellation on a reallocated endpoi=
nt
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_inte=
rface()

Matias Bj=F8rling (1):
      lightnvm: pblk: enable line minor version detection

Matthew Garrett (1):
      evm: Don't deadlock if a crypto algorithm is unavailable

Max Filippov (1):
      xtensa: ISS: don't allocate memory in platform_setup

Maxence Dupr=E8s (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB con=
troller

Maxime Chevallier (1):
      net: mvpp2: make sure we use single queue mode on PPv2.1

Miao Zhong (1):
      iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Michael M=FCller (1):
      crypto: sharah - Unregister correct algorithms for SAHARA 3

Mike Christie (1):
      configfs: fix registered group removal

Mike Snitzer (1):
      block: allow max_discard_segments to be stacked

Mikko Perttunen (2):
      clk: core: Potentially free connection id
      clk: tegra: bpmp: Don't crash when a clock fails to register

Miklos Szeredi (2):
      ovl: fix oopses in ovl_fill_super() failure paths
      vfs: fix freeze protection in mnt_want_write_file() for overlayfs

Mikulas Patocka (1):
      dm verity: fix crash on bufio buffer that was allocated with vmalloc

Ming Lei (2):
      blk-mq: only attempt to merge bio if there is rq in sw queue
      blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()

Nicholas Mc Guire (8):
      clk: imx6ul: fix missing of_node_put()
      clk: imx6sll: fix missing of_node_put()
      staging: bcm2835-camera: fix timeout handling in wait_for_completion_=
timeout
      staging: bcm2835-camera: handle wait_for_completion_timeout return pr=
operly
      KVM: PPC: Book3S HV: Add of_node_put() in success path
      ARM: hisi: handle of_iomap and fix missing of_node_put
      ARM: hisi: fix error handling and missing of_node_put
      ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Piggin (1):
      powerpc/powernv: opal_put_chars partial write fix

Niklas Cassel (2):
      regulator: qcom_spmi: Use correct regmap when checking for error
      regulator: qcom_spmi: Fix warning Bad of_node_put()

Noa Osherovich (1):
      net/mlx5: Add missing SET_DRIVER_VERSION command translation

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied

Oliver Neukum (2):
      usb: uas: add support for more quirk flags
      Revert "cdc-acm: implement put_char() and flush_chars()"

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock

Paul Burton (1):
      MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Paul Cercueil (1):
      MIPS: jz4740: Bump zload address

Peter Rosin (2):
      mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Petr Oros (1):
      be2net: Fix memory leak in be_cmd_get_profile_config()

Philipp Puschmann (1):
      Bluetooth: Use lock_sock_nested in bt_accept_enqueue

Pingfan Liu (1):
      drivers/base: stop new probing during shutdown

Piotr Sawicki (1):
      Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets

Quentin Perret (1):
      sched/fair: Fix util_avg of new tasks for asymmetric systems

Raed Salem (1):
      net/mlx5: E-Switch, Fix memory leak when creating switchdev mode FDB =
tables

Rajan Vaja (1):
      clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure

Randy Dunlap (4):
      mtd/maps: fix solutionengine.c printk format warnings
      fbdev/via: fix defined but not used warning
      platform/x86: toshiba_acpi: Fix defined but not used build warnings
      block/DAC960.c: fix defined but not used build warnings

Rex Zhu (1):
      drm/amd/pp: Set Max clock level to display by default

Rick Farrington (1):
      liquidio: fix hang when re-binding VF host drv after running DPDK VF =
driver

Rob Herring (1):
      of: fix phandle cache creation for DTs with no phandles

Robin Murphy (1):
      coresight: tpiu: Fix disabling timeouts

Roi Dayan (2):
      net/mlx5: Fix not releasing read lock when adding flow rules
      net/mlx5: Fix possible deadlock from lockdep when adding fte to fg

Roman Gushchin (1):
      bpf: fix rcu annotations in compute_effective_progs()

Ronny Chevalier (1):
      audit: fix use-after-free in audit_add_watch

Russell King (1):
      ASoC: hdmi-codec: fix routing

Ryder Lee (1):
      arm64: dts: mt7622: update a clock property for UART0

Sagi Grimberg (2):
      nvmet: fix file discard return status
      nvme-rdma: unquiesce queues when deleting the controller

Sandipan Das (6):
      perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
      perf tests: Fix record+probe_libc_inet_pton.sh when event exists
      perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
      perf powerpc: Fix callchain ip filtering when return address is in a =
register
      perf powerpc: Fix callchain ip filtering
      perf script: Show correct offsets for DWARF-based unwinding

Sean Wang (1):
      pinctrl: mt7622: Fix probe fail by misuse the selector

Shaoyun Liu (1):
      drm/amdkfd: Fix kernel queue 64 bit doorbell offset calculation

Shuah Khan (Samsung OSG) (1):
      selftests: vDSO - fix to return KSFT_SKIP when test couldn't be run

Sibi Sankar (1):
      remoteproc: qcom: q6v5-pil: fix modem hang on SDM845 after axis2 clk =
unvote

Stefan Agner (2):
      mmc: tegra: prevent HS200 on Tegra 3
      mmc: sdhci: do not try to use 3.3V signaling if not supported

Stefan Wahren (1):
      net: qca_spi: Fix race condition in spi transfers

Stephen Hemminger (1):
      vmbus: don't return values for uninitalized channels

Suzuki K Poulose (3):
      coresight: Handle errors in finding input/output ports
      coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
      arm64: perf: Disable PMU while processing counter overflows

Takashi Iwai (2):
      ALSA: msnd: Fix the default sample sizes
      ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Tariq Toukan (1):
      net/mlx5: Use u16 for Work Queue buffer fragment size

Thierry Reding (1):
      drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Thomas Richter (1):
      perf test: Fix subtest number when showing results

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Timo Wischer (1):
      ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Todor Tomov (1):
      media: ov5645: Supported external clock is 24MHz

Tomas Winkler (2):
      mei: bus: fix hw module get/put balance
      mei: bus: need to unlink client before freeing

Tony Lindgren (1):
      pinctrl: rza1: Fix selector use for groups and functions

Trond Myklebust (2):
      NFSv4: Fix a tracepoint Oops in initiate_file_draining()
      NFSv4.1 fix infinite loop on I/O.

Tuomas Tynkkynen (1):
      staging: bcm2835-audio: Don't leak workqueue if open fails

Vakul Garg (1):
      net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Vincent Whitchurch (1):
      tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Viresh Kumar (1):
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

Vitaly Kuznetsov (1):
      xen-netfront: fix queue name setting

Wei Lu (1):
      drm/amdkfd: Fix error codes in kfd_get_process

Wei Yongjun (2):
      IB/ipoib: Fix error return code in ipoib_dev_init()
      gpio: pxa: Fix potential NULL dereference

Xiao Liang (1):
      xen-netfront: fix warn message as irq device name has '/'

Yabin Cui (1):
      perf/core: Force USER_DS when recording user stack data

Yoshihiro Shimoda (3):
      iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a special usage on R-Car Gen3
      usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0
      dmaengine: sh: rcar-dmac: avoid to write CHCR.TE to 1 if TCR is set t=
o 0

Yue Wang (1):
      ALSA: usb-audio: Generic DSD detection for Thesycon-based implementat=
ions

YueHaibing (3):
      xfrm: fix 'passing zero to ERR_PTR()' warning
      amd-xgbe: use dma_mapping_error to check map errors
      wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check return value of qe_mura=
m_alloc

Yunsheng Lin (1):
      net: hns3: Fix for reset_level default assignment probelm

Zhouyang Jia (1):
      rtc: bq4802: add error handling for devm_ioremap

Zhu Yanjun (1):
      IB/rxe: Drop QP0 silently


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlurSscACgkQONu9yGCS
aT5t5A//bHipzeRkq0XFStWWGaOXZhqylXG2r6Y9XBXEusvtVS652ChfNR4nBio8
zNDYS1tKLWu9HiQJto1A/sNHfYrUMTu8E+qDgbaxORM89JemSBMTLmg/nbiJeVyu
LLbCcmfWgTUx83/v/svxhaV3atzeypgoBl4c8P4ymq4L7dxAa0AVgpFMly1D1Eyr
AwPFLjUR0r0KUi6owyXkvyq1TuyfA7zRUFqd36z7F8jVlCSJpkOOD/qnhqLQqzcF
sbdXxqVUYciqHyHBUQ8demkHkmGb85p4RoqOoMfxNAMLmYb/YoNeLY200Eaf2dQn
pSBoTNnIeTEAwJUEeW6q13TAnbi53eKZXHshaveU9hRA+J3u1gRasj9omGA5+EGK
OYCHjZIjxSh8JPNMN8yU5CRdRVCtnWeTPfznAAlE7rT2VQxjxKASCdinL0knLD5c
HOJSKCsZa3dD4P4326GcCyCXOiHecChL8uUTfUv/e60HK0SFjmmGMHeuOxg0xh91
DmzlogKUQgZL4eldGCBXwrLIYVjLCZ2iyaHWRzGOSSqrPDjb8G7PBfTPH9h+olDn
CqM1lGEWqWpRT7m/HfVF/6CriOkJtBAa6uurFU4s+tGfHpe+BCTX9ivCoybF2dw6
uTpe03DX90q7uq7fFmCK6LmRykxiRDEPHsZYmF2d1cMCFyL65cc=
=/yEY
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
