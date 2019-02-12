Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B1C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5FF21B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550002351;
	bh=PUaROUyQftusGgzRu9DMRrt4flkD4POLrAQhSSs+WWg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kUXSWlvRCKnx5voRv5Q2u5m6TV2ACuKywzof7AH4UusEa/Gatw+lg8wDgamnR3wJc
	 j0PQkOpW7aDND+WQ4kaFqwoOwiJ0v+09+R8XYk+mVqay47FqNdxMfTyUtKOThPZ5qM
	 FeqodhU3chV1yhYQ4dn78K7pMuth1+uB6gO0D/K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfBLUM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfBLUM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:12:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E50222C4;
        Tue, 12 Feb 2019 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550002347;
        bh=PUaROUyQftusGgzRu9DMRrt4flkD4POLrAQhSSs+WWg=;
        h=Date:From:To:Cc:Subject:From;
        b=MjjNm2Wwz+a061MWEshYPbzp9WD96WTLLQ8OqOU0lwOiw0Gsm2wOiUzKA7U6tUofn
         2g4ZAvGidgIcoHpLivHPAnDVJV+iC89NBXKmXyTFkSgq2nIYw03QmMatH7qLed6An/
         04EEPn05C6KKu20247l2a6SGnrRLpm89ZmMzs8So=
Date:   Tue, 12 Feb 2019 21:12:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.99
Message-ID: <20190212201223.GA10440@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.99 kernel.

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
 arch/arm/boot/dts/gemini-dlink-dir-685.dts               |   16 --
 arch/arm/boot/dts/mmp2.dtsi                              |    9 -
 arch/arm/boot/dts/omap4-sdp.dts                          |    1=20
 arch/arm/kernel/smp.c                                    |   15 ++
 arch/arm/mach-omap2/omap_hwmod.c                         |    6=20
 arch/arm/mach-pxa/cm-x300.c                              |    2=20
 arch/arm/mach-pxa/littleton.c                            |    2=20
 arch/arm/mach-pxa/zeus.c                                 |    2=20
 arch/arm64/include/asm/io.h                              |   32 +++-
 arch/arm64/kernel/entry-ftrace.S                         |    1=20
 arch/mips/boot/dts/img/boston.dts                        |    6=20
 arch/mips/include/uapi/asm/inst.h                        |    2=20
 arch/mips/ralink/Kconfig                                 |    1=20
 arch/powerpc/include/asm/fadump.h                        |    2=20
 arch/powerpc/include/asm/uaccess.h                       |    2=20
 arch/powerpc/kernel/fadump.c                             |   10 +
 arch/powerpc/kvm/powerpc.c                               |    5=20
 arch/powerpc/mm/fault.c                                  |    4=20
 arch/powerpc/perf/isa207-common.c                        |    7 -
 arch/powerpc/platforms/pseries/dlpar.c                   |    2=20
 arch/powerpc/platforms/pseries/hotplug-memory.c          |    7 -
 arch/s390/include/uapi/asm/zcrypt.h                      |    4=20
 arch/um/include/asm/pgtable.h                            |    9 +
 arch/x86/events/intel/core.c                             |   10 +
 arch/x86/events/intel/uncore_snbep.c                     |    4=20
 arch/x86/include/asm/fpu/internal.h                      |    3=20
 arch/x86/kernel/cpu/bugs.c                               |    2=20
 arch/x86/kernel/cpu/mcheck/mce.c                         |    1=20
 arch/x86/kvm/svm.c                                       |    7 +
 arch/x86/kvm/vmx.c                                       |    4=20
 arch/x86/kvm/x86.c                                       |    7 +
 arch/x86/pci/broadcom_bus.c                              |    4=20
 crypto/Kconfig                                           |    3=20
 crypto/aes_ti.c                                          |   18 ++
 drivers/acpi/apei/ghes.c                                 |    2=20
 drivers/acpi/spcr.c                                      |   11 +
 drivers/ata/sata_rcar.c                                  |    4=20
 drivers/base/bus.c                                       |   12 +
 drivers/base/core.c                                      |    8 +
 drivers/base/dd.c                                        |    6=20
 drivers/base/power/opp/core.c                            |   11 +
 drivers/block/drbd/drbd_nl.c                             |   15 +-
 drivers/block/drbd/drbd_receiver.c                       |   13 +
 drivers/block/sunvdc.c                                   |    5=20
 drivers/block/swim3.c                                    |    6=20
 drivers/cdrom/gdrom.c                                    |    1=20
 drivers/clk/imgtec/clk-boston.c                          |   11 +
 drivers/clk/imx/clk-imx6sl.c                             |    6=20
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c                     |    6=20
 drivers/cpuidle/cpuidle-big_little.c                     |    7 -
 drivers/crypto/ux500/cryp/cryp_core.c                    |    4=20
 drivers/crypto/ux500/hash/hash_core.c                    |    2=20
 drivers/dma/bcm2835-dma.c                                |   70 +++-------
 drivers/dma/imx-dma.c                                    |    8 -
 drivers/dma/xilinx/zynqmp_dma.c                          |    2=20
 drivers/firmware/efi/vars.c                              |   99 ++++++++++=
+----
 drivers/fpga/altera-cvp.c                                |    9 +
 drivers/gpu/drm/drm_atomic_helper.c                      |    8 -
 drivers/gpu/drm/drm_bufs.c                               |    3=20
 drivers/gpu/drm/rockchip/cdn-dp-reg.c                    |    2=20
 drivers/gpu/drm/vc4/vc4_plane.c                          |   12 +
 drivers/gpu/drm/vgem/vgem_drv.c                          |   16 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c                   |   10 +
 drivers/hid/hid-lenovo.c                                 |   10 +
 drivers/hwmon/lm80.c                                     |   26 ++-
 drivers/i2c/busses/i2c-axxia.c                           |   32 ++--
 drivers/i2c/busses/i2c-sh_mobile.c                       |    1=20
 drivers/iio/accel/kxcjk-1013.c                           |    1=20
 drivers/iio/adc/meson_saradc.c                           |   14 +-
 drivers/infiniband/hw/hfi1/rc.c                          |    2=20
 drivers/infiniband/hw/hfi1/ruc.c                         |    7 -
 drivers/infiniband/hw/qib/qib_ruc.c                      |    7 -
 drivers/iommu/amd_iommu.c                                |    9 +
 drivers/iommu/arm-smmu-v3.c                              |    8 +
 drivers/iommu/arm-smmu.c                                 |    3=20
 drivers/irqchip/irq-gic-v3-its.c                         |   32 ++++
 drivers/isdn/hisax/hfc_pci.c                             |    2=20
 drivers/md/raid10.c                                      |    4=20
 drivers/media/i2c/ad9389b.c                              |    2=20
 drivers/media/i2c/adv7511.c                              |    2=20
 drivers/media/i2c/adv7604.c                              |    4=20
 drivers/media/i2c/adv7842.c                              |    4=20
 drivers/media/i2c/tc358743.c                             |    2=20
 drivers/media/i2c/ths8200.c                              |    2=20
 drivers/media/platform/coda/coda-bit.c                   |   19 +-
 drivers/media/platform/coda/coda-common.c                |   15 +-
 drivers/media/platform/coda/coda.h                       |    6=20
 drivers/media/platform/coda/coda_regs.h                  |    2=20
 drivers/media/platform/davinci/vpbe.c                    |    7 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c    |   10 -
 drivers/memstick/core/memstick.c                         |    3=20
 drivers/mmc/host/bcm2835.c                               |   12 +
 drivers/mmc/host/sdhci-of-esdhc.c                        |   16 +-
 drivers/mmc/host/sdhci-xenon-phy.c                       |   10 +
 drivers/mmc/host/sdhci-xenon.c                           |   10 +
 drivers/net/ethernet/broadcom/bcmsysport.c               |   25 +--
 drivers/net/ethernet/broadcom/bcmsysport.h               |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c              |    3=20
 drivers/net/ethernet/freescale/fman/fman_memac.c         |    2=20
 drivers/net/ethernet/freescale/fman/fman_tgec.c          |    2=20
 drivers/net/ethernet/intel/i40e/i40e_main.c              |    3=20
 drivers/net/ethernet/intel/igb/igb_main.c                |    8 -
 drivers/net/ethernet/marvell/skge.c                      |    6=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |   14 ++
 drivers/net/ethernet/mellanox/mlx5/core/main.c           |   14 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c           |   23 +++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   27 ----
 drivers/net/ethernet/sun/niu.c                           |   10 +
 drivers/net/phy/dp83640.c                                |   13 +
 drivers/net/usb/smsc95xx.c                               |    1=20
 drivers/net/wireless/ath/ath9k/ath9k.h                   |    2=20
 drivers/net/wireless/ath/ath9k/dynack.c                  |   35 +++--
 drivers/net/wireless/ath/ath9k/dynack.h                  |    6=20
 drivers/net/wireless/ath/ath9k/xmit.c                    |    5=20
 drivers/net/wireless/st/cw1200/scan.c                    |   13 -
 drivers/pci/switch/switchtec.c                           |    3=20
 drivers/phy/allwinner/phy-sun4i-usb.c                    |    7 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                    |   16 +-
 drivers/pinctrl/meson/pinctrl-meson8.c                   |    3=20
 drivers/pinctrl/meson/pinctrl-meson8b.c                  |   13 +
 drivers/pinctrl/pinctrl-sx150x.c                         |   11 +
 drivers/platform/chrome/cros_ec_proto.c                  |   18 ++
 drivers/ptp/ptp_chardev.c                                |    5=20
 drivers/ptp/ptp_clock.c                                  |    5=20
 drivers/s390/crypto/zcrypt_error.h                       |    2=20
 drivers/scsi/aic94xx/aic94xx_init.c                      |    8 -
 drivers/scsi/cxlflash/main.c                             |    2=20
 drivers/scsi/lpfc/lpfc_els.c                             |   52 +++----
 drivers/scsi/lpfc/lpfc_nportdisc.c                       |    5=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                     |    2=20
 drivers/scsi/mpt3sas/mpt3sas_transport.c                 |    7 -
 drivers/scsi/smartpqi/smartpqi_init.c                    |    6=20
 drivers/scsi/smartpqi/smartpqi_sis.c                     |    2=20
 drivers/soc/bcm/brcmstb/common.c                         |    6=20
 drivers/soc/tegra/common.c                               |    6=20
 drivers/staging/iio/adc/ad7280a.c                        |   17 +-
 drivers/staging/iio/adc/ad7780.c                         |    6=20
 drivers/staging/iio/resolver/ad2s90.c                    |    7 -
 drivers/staging/pi433/pi433_if.c                         |    4=20
 drivers/staging/speakup/spk_ttyio.c                      |    6=20
 drivers/thermal/broadcom/bcm2835_thermal.c               |   11 +
 drivers/thermal/thermal-generic-adc.c                    |   12 +
 drivers/thermal/thermal_core.c                           |   12 +
 drivers/thermal/thermal_hwmon.h                          |    4=20
 drivers/tty/serial/8250/8250_pci.c                       |    9 -
 drivers/tty/serial/fsl_lpuart.c                          |    4=20
 drivers/tty/serial/samsung.c                             |    3=20
 drivers/tty/serial/serial_core.c                         |    6=20
 drivers/usb/core/hub.c                                   |   10 +
 drivers/usb/dwc3/gadget.c                                |   16 +-
 drivers/usb/dwc3/trace.h                                 |    2=20
 drivers/usb/gadget/udc/net2272.c                         |    2=20
 drivers/usb/mtu3/mtu3_core.c                             |    4=20
 drivers/usb/mtu3/mtu3_gadget_ep0.c                       |    8 -
 drivers/usb/musb/musb_dsps.c                             |    9 +
 drivers/usb/musb/musb_gadget.c                           |   13 -
 drivers/usb/musb/musbhsdma.c                             |   21 +--
 drivers/usb/phy/phy-am335x.c                             |    5=20
 drivers/video/fbdev/clps711x-fb.c                        |    5=20
 drivers/video/fbdev/core/fbcon.c                         |    2=20
 drivers/video/fbdev/core/fbmem.c                         |    8 -
 drivers/watchdog/renesas_wdt.c                           |    9 +
 fs/binfmt_script.c                                       |   10 +
 fs/cifs/readdir.c                                        |    9 +
 fs/dlm/ast.c                                             |   10 +
 fs/eventpoll.c                                           |    2=20
 fs/f2fs/acl.c                                            |   14 +-
 fs/f2fs/data.c                                           |   12 +
 fs/f2fs/f2fs.h                                           |   11 +
 fs/f2fs/file.c                                           |    3=20
 fs/f2fs/shrinker.c                                       |    2=20
 fs/fuse/dev.c                                            |    4=20
 fs/fuse/file.c                                           |    2=20
 fs/nfs/super.c                                           |    3=20
 fs/nfsd/nfs4state.c                                      |   57 +++++++-
 fs/nfsd/nfsctl.c                                         |    2=20
 fs/nfsd/state.h                                          |    2=20
 fs/nfsd/xdr4.h                                           |   13 +
 fs/ocfs2/Makefile                                        |    2=20
 fs/ocfs2/buffer_head_io.c                                |    2=20
 fs/ocfs2/dlm/Makefile                                    |    2=20
 fs/ocfs2/dlmfs/Makefile                                  |    2=20
 fs/udf/inode.c                                           |    6=20
 include/linux/cpu.h                                      |    2=20
 include/linux/genl_magic_struct.h                        |    5=20
 include/linux/kvm_host.h                                 |    3=20
 include/linux/mlx5/driver.h                              |    2=20
 include/sound/compress_driver.h                          |    6=20
 kernel/cgroup/cgroup.c                                   |    2=20
 kernel/cpu.c                                             |   33 -----
 kernel/debug/debug_core.c                                |    4=20
 kernel/debug/kdb/kdb_bt.c                                |   11 +
 kernel/debug/kdb/kdb_debugger.c                          |    7 -
 kernel/events/ring_buffer.c                              |    3=20
 kernel/futex.c                                           |   28 ++--
 kernel/hung_task.c                                       |   20 +--
 kernel/locking/rtmutex.c                                 |   37 ++++-
 kernel/module.c                                          |    6=20
 kernel/sched/fair.c                                      |    1=20
 kernel/smp.c                                             |    2=20
 kernel/sysctl.c                                          |    2=20
 kernel/time/timekeeping.c                                |    4=20
 lib/seq_buf.c                                            |    6=20
 mm/percpu-km.c                                           |    5=20
 net/bluetooth/hci_event.c                                |    6=20
 net/dccp/ccid.h                                          |    4=20
 net/dsa/slave.c                                          |   12 +
 net/ipv6/xfrm6_tunnel.c                                  |    3=20
 net/mac80211/rx.c                                        |    5=20
 net/rds/bind.c                                           |    6=20
 net/rxrpc/recvmsg.c                                      |    3=20
 scripts/decode_stacktrace.sh                             |    2=20
 scripts/gdb/linux/proc.py                                |    2=20
 scripts/mod/modpost.c                                    |   50 +++----
 security/smack/smack_lsm.c                               |   12 +
 sound/pci/hda/hda_bind.c                                 |    3=20
 sound/pci/hda/hda_codec.h                                |    1=20
 sound/pci/hda/hda_intel.c                                |    2=20
 sound/soc/fsl/Kconfig                                    |    2=20
 sound/soc/intel/atom/sst/sst_loader.c                    |    8 -
 tools/hv/hv_kvp_daemon.c                                 |   15 +-
 tools/perf/arch/x86/util/kvm-stat.c                      |    2=20
 tools/perf/tests/attr.py                                 |    2=20
 tools/perf/tests/evsel-tp-sched.c                        |    2=20
 tools/perf/util/header.c                                 |    2=20
 tools/perf/util/probe-file.c                             |    2=20
 tools/testing/selftests/bpf/test_progs.c                 |    8 -
 virt/kvm/arm/mmio.c                                      |   11 -
 virt/kvm/kvm_main.c                                      |    6=20
 231 files changed, 1359 insertions(+), 646 deletions(-)

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c-axxia: check for error conditions first

Aditya Pakki (1):
      HID: lenovo: Add checks to fix of_led_classdev_register

Adrian Hunter (3):
      mmc: sdhci-of-esdhc: Fix timeout checks
      mmc: sdhci-xenon: Fix timeout checks
      perf test: Fix perf_event_attr test failure

Alexander Duyck (1):
      driver core: Move async_synchronize_full call

Alexey Khoroshilov (3):
      media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()
      media: DaVinci-VPBE: fix error handling in vpbe_initialize()
      video: clps711x-fb: release disp device node in probe()

Andreas Puhm (1):
      fpga: altera-cvp: Fix registration for CvP incapable devices

Andy Duan (1):
      serial: fsl_lpuart: clear parity enable bit when disable parity

Andy Shevchenko (3):
      ACPI: SPCR: Consider baud rate 0 as preconfigured state
      usb: dwc3: trace: add missing break statement to make compiler happy
      serial: 8250_pci: Make PCI class test non fatal

Anson Huang (1):
      clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Anton Ivanov (1):
      um: Avoid marking pages with "changed protection"

Anurag Kumar Vulisha (1):
      usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_=
one_trb()

Arend van Spriel (1):
      firmware/efi: Add NULL pointer checks in efivars API functions

Arnaldo Carvalho de Melo (2):
      perf header: Fix unchecked usage of strncpy()
      perf probe: Fix unchecked usage of strncpy()

Arnd Bergmann (2):
      ASoC: Intel: mrfld: fix uninitialized variable access
      ARM: pxa: avoid section mismatch warning

Bart Van Assche (1):
      timekeeping: Use proper seqcount initializer

Ben Dooks (1):
      usbnet: smsc95xx: fix rx packet alignment

Beomho Seo (1):
      tty: serial: samsung: Properly set flags in autoCTS mode

Bin Liu (2):
      usb: musb: dsps: fix otg state machine
      usb: phy: am335x: fix race condition in _probe

Bjorn Andersson (1):
      thermal: generic-adc: Fix adc to temp interpolation

Bob Peterson (1):
      dlm: Don't swamp the CPU with callbacks queued during recovery

Boris Brezillon (1):
      drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE

Brian Norris (1):
      platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup

Charles Keepax (1):
      ALSA: compress: Fix stop handling on compressed capture streams

Chen-Yu Tsai (1):
      clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module cloc=
ks

Cheng Lin (1):
      proc/sysctl: fix return error for proc_doulongvec_minmax()

Chris Perl (1):
      NFS: nfs_compare_mount_options always compare auth flavors.

Christophe Leroy (2):
      powerpc/uaccess: fix warning/error with access_ok()
      powerpc/mm: Fix reporting of kernel execute faults on the 8xx

Chunfeng Yun (1):
      usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)

Colin Ian King (1):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Cong Wang (1):
      net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Damian Kos (1):
      drm/rockchip: fix for mailbox read size

Dan Carpenter (1):
      skge: potential memory corruption in skge_get_regs()

Dave Carroll (1):
      scsi: smartpqi: correct volume status

Davidlohr Bueso (1):
      fs/epoll: drop ovflist branch prediction

Deepak Sharma (1):
      drm/vgem: Fix vgem_init to get drm device available.

Dennis Zhou (1):
      percpu: convert spin_lock_irq to spin_lock_irqsave.

Dexuan Cui (1):
      Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1

Douglas Anderson (1):
      kdb: Don't back trace on a cpu that didn't round up

Du Changbin (1):
      scripts/gdb: fix lx-version string output

Eduardo Valentin (1):
      thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Eric Biggers (1):
      crypto: aes_ti - disable interrupts while accessing S-box

Eric Dumazet (3):
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      rxrpc: bad unlock balance in rxrpc_recvmsg
      rds: fix refcount bug in rds_sock_addref

Fabio Estevam (1):
      ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Finn Thain (1):
      block/swim3: Fix -EBUSY error when re-opening device after unmount

Florian Fainelli (1):
      net: systemport: Fix WoL with password after deep sleep

Frank Rowand (1):
      powerpc/pseries: add of_node_put() in dlpar_detach_node()

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (2):
      serial: fix race between flush_to_ldisc and tty_open
      Linux 4.14.99

Guoqing Jiang (1):
      md: fix raid10 hang issue caused by barrier

Gustavo A. R. Silva (3):
      drm/bufs: Fix Spectre v1 vulnerability
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
      perf tests evsel-tp-sched: Fix bitwise operator

Hans Verkuil (1):
      media: adv*/tc358743/ths8200: fill in min width/height/pixelclock

Hans de Goede (1):
      iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Harald Freudenberger (1):
      s390/zcrypt: improve special ap message cmd handling

Icenowy Zheng (1):
      phy: sun4i-usb: add support for missing USB PHY index

Ido Schimmel (1):
      mlxsw: spectrum: Properly cleanup LAG uppers when removing port from =
LAG

J. Bruce Fields (3):
      nfsd4: fix crash on writing v4_end_grace before nfsd startup
      nfsd4: fix cached replies to solo SEQUENCE compounds
      nfsd4: catch some false session retries

James Bottomley (1):
      scsi: aic94xx: fix module loading

James Smart (2):
      scsi: lpfc: Correct LCB RJT handling
      scsi: lpfc: Fix LOGO/PLOGI handling when triggerd by ABTS Timeout eve=
nt

Jan Kara (1):
      udf: Fix BUG on corrupted inode

Jann Horn (2):
      fuse: call pipe_buf_release() under pipe lock
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Jia-Ju Bai (2):
      cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()
      isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug i=
n HFCPCI_l1hw()

Jim Mattson (1):
      kvm: Change offset in kvm_write_guest_offset_cached to unsigned

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op

Joey Zhang (1):
      switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite

Johan Hedberg (1):
      Bluetooth: Fix unnecessary error message for HCI request completion

Johan Hovold (1):
      staging: speakup: fix tty-operation NULL derefs

Johannes Berg (1):
      mac80211: fix radiotap vendor presence bitmap handling

Josh Poimboeuf (1):
      cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

Junxiao Bi (1):
      ocfs2: don't clear bh uptodate for block read

Kai-Heng Feng (2):
      memstick: Prevent memstick host from getting runtime suspended during=
 card detection
      igb: Fix an issue that PME is not enabled during runtime suspend

Kaike Wan (1):
      IB/hfi1: Unreserve a reserved request when it is completed

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask

Kangjie Lu (3):
      hwmon: (lm80) fix a missing check of the status of SMBus read
      hwmon: (lm80) fix a missing check of bus read in lm80 probe
      niu: fix missing checks of niu_pci_eeprom_read

Konstantin Khorenko (1):
      i40e: define proper net_device::neigh_priv_len

Larry Chen (1):
      ocfs2: improve ocfs2 Makefile

Lars Ellenberg (2):
      drbd: disconnect, if the wrong UUIDs are attached on a connected peer
      drbd: skip spurious timeout (ping-timeo) when failing promote

Lenny Szubowicz (1):
      ACPI/APEI: Clear GHES block_status before panic()

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Linus Walleij (1):
      ARM: dts: Fix up the D-Link DIR-685 MTD partition info

Liu, Chuansheng (1):
      kernel/hung_task.c: force console verbose before panic

Lorenzo Bianconi (3):
      ath9k: dynack: use authentication messages for 'late' ack
      ath9k: dynack: make ewma estimation faster
      ath9k: dynack: check da->enabled first in sampling routines

Lubomir Rintel (1):
      ARM: dts: mmp2: fix TWSI2

Lukas Wunner (3):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions

Madhavan Srinivasan (1):
      powerpc/perf: Fix thresholding counter data for unknown type

Mahesh Rajashekhara (2):
      scsi: smartpqi: correct host serial num for ssa
      scsi: smartpqi: increase fw status register read timeout

Mahesh Salgaonkar (1):
      powerpc/fadump: Do not allow hot-remove memory from fadump reserved a=
rea.

Marc Zyngier (2):
      scripts/decode_stacktrace: only strip base path when a prefix of the =
path
      irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID

Mark Rutland (3):
      arm64: ftrace: don't adjust the LR value
      arm64: KVM: Skip MMIO insn after emulation
      perf/core: Don't WARN() for impossible ring-buffer sizes

Martin Blumenstingl (3):
      iio: adc: meson-saradc: fix internal clock names
      pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
      pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Matheus Tavares (1):
      staging:iio:ad2s90: Make probe handle spi_setup failure

Mathias Nyman (1):
      usb: hub: delay hub autosuspend if USB3 port is still link training

Matthias Brugger (1):
      thermal: bcm2835: enable hwmon explicitly

Michael Ellerman (1):
      seq_buf: Make seq_buf_puts() null-terminate the buffer

Michael Straube (1):
      staging: pi433: fix potential null dereference

Michal Suchanek (1):
      mmc: bcm2835: reset host on timeout

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Miklos Szeredi (2):
      fuse: decrement NR_WRITEBACK_TEMP on the right page
      fuse: handle zero sized retrieve correctly

Miroslav Lichvar (1):
      ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl

Nathan Chancellor (5):
      ARM: OMAP2+: hwmod: Fix some section annotations
      dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_=
ll
      drbd: Avoid Clang warning about pointless switch statment
      crypto: ux500 - Use proper enum in cryp_set_dma_transfer
      crypto: ux500 - Use proper enum in hash_set_dma_transfer

Nicholas Mc Guire (2):
      iio: adc: meson-saradc: check for devm_kasprintf failure
      pinctrl: sx150x: handle failure case of devm_kstrdup

Noralf Tr=F8nnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Oleg Nesterov (1):
      exec: load_script: don't blindly truncate shebang string

Ondrej Mosnacek (1):
      cgroup: fix parsing empty mount option string

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-=
7222)

Paul Burton (1):
      MIPS: Boston: Disable EG20T prefetch

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma

Peter Rajnoha (1):
      kobject: return error code if writing /sys/.../uevent fails

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CV=
E-2019-7221)

Peter Zijlstra (1):
      perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

Phil Elwell (1):
      mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Philipp Zabel (1):
      media: coda: fix H.264 deblocking filter controls

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Renato Lui Geh (1):
      staging: iio: ad7780: update voltage on read

Roland Kammerer (1):
      drbd: narrow rcu_read_lock in drbd_sync_handshake

Ronnie Sahlberg (1):
      cifs: check ntwrk_buf_start for NULL before dereferencing it

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Saeed Mahameed (1):
      net/mlx5: EQ, Use the right place to store/read IRQ affinity hint

Sahitya Tummala (1):
      f2fs: fix sbi->extent_list corruption issue

Sami Tolvanen (1):
      modpost: validate symbol names also in find_elf_symbol

Scott Wood (1):
      fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Sean Paul (1):
      drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit=
_duplicated_state()

Sebastian Andrzej Siewior (2):
      x86/fpu: Add might_fault() to user_insn()
      net: dp83640: expire old TX-skb

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

Sheng Yong (1):
      f2fs: fix race between write_checkpoint and write_begin

Simon Horman (1):
      i2c: sh_mobile: add support for r8a77990 (R-Car E3)

Slawomir Stepien (1):
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Stanislav Fomichev (1):
      selftests/bpf: use __bpf_constant_htons in test_prog.c

Stefan Roese (1):
      MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8

Steve Longerbeam (1):
      gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Suganath Prabu (1):
      scsi: mpt3sas: Call sas_remove_host before removing the target devices

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machi=
nes

Takashi Iwai (1):
      ALSA: hda - Serialize codec registrations

Tejas Joglekar (2):
      usb: dwc3: gadget: Disable CSP for stream OUT ep
      usb: dwc3: gadget: Handle 0 xfer length for OUT EP

Tetsuo Handa (1):
      kernel/hung_task.c: break RCU locks based on jiffies

Thomas Gleixner (1):
      futex: Handle early deadlock return correctly

Tiezhu Yang (1):
      f2fs: fix wrong return value of f2fs_acl_create

Tony Luck (1):
      x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_w=
ay_out()

Vaibhav Jain (1):
      scsi: cxlflash: Prevent deadlock when adapter probe fails

Viresh Kumar (1):
      OPP: Use opp_table->regulators to verify no regulator case

Vitaly Kuznetsov (1):
      KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported

Vivek Gautam (1):
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Wei Wang (1):
      Thermal: do not clear passive state during system sleep

Wenwen Wang (1):
      gdrom: fix a memory leak bug

Will Deacon (3):
      arm64: io: Ensure calls to delay routines are ordered against prior r=
eadX()
      arm64: io: Ensure value passed to __iormb() is held in a 64-bit regis=
ter
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Wolfram Sang (1):
      watchdog: renesas_wdt: don't set divider while watchdog is running

Yangtao Li (3):
      soc/tegra: Don't leak device tree node reference
      soc: bcm: brcmstb: Don't leak device tree node reference
      cpuidle: big.LITTLE: fix refcount leak

Yi Wang (1):
      clk: boston: fix possible memory leak in clk_boston_setup()

Young Xiao (1):
      sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns E=
AGAIN

Yu Zhao (1):
      iommu/amd: Fix amd_iommu=3Dforce_isolation

YueHaibing (2):
      ptp: Fix pass zero to ERR_PTR() in ptp_clock_register
      xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Yufen Wang (1):
      ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

Yunlei He (1):
      f2fs: move dir data flush to write checkpoint process

Zoran Markovic (1):
      smack: fix access permissions for keyring


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxjKKcACgkQONu9yGCS
aT7twQ//T/tExXK64uZd5wXodRyZlszF0DDKyRoaYSdPocbakWmprr+Sy8vg/JJZ
+tAfrEN/D6nH6Q1juhVLGlmIb79Exj6qlEsHkoA/Hctr480sqavfQg8D4Wd7kvq9
bUI0avcNd5/L4BbKaogwAizgI8mHF90TToGFXnya9DVKf++zNgfgFNN6sHbUw/Ck
39isGZDF5udNWnVmnrHepr7GEajy3VIhcr+oYiHaV8fPCwtGwrYGqTxU021HMWi1
NE4sUlGyG5zRq2bfuyAD8/B7Mtadgkb+gPPb6rlKs2iJXDyTFL5BYZtnu2oNUSui
1wCTLsDvV2u/CRMOF4ZdWkFVlf3cBBuJRYsopHYBwYbCsjK8q1F0hvVBrl6H3rRm
1O8R8DBVQImaBSLqPRldxPicJHe+/VEkEBg09mAjn0cEU4tvpTb30AxVwddHQ8Ya
KjdH7EGFSF1mf6Lc6e8DlLKsuWMOWwGl+PljUiD3sukCNsXMrRxb5QUumrYVkHFq
gOHlkTr0Ur7kBDHjMp0Kil00B7h3ywEMk9noMAbTCazafEb+8kkptjI0IhUrQaQo
3jmHiCc8BYI0ChR6v9uKdU2U62TWz0oa7U+x5mY8OJdceh1YGbmztOTHKqfgCj+J
VFrORIlrrMPJYR9+xgVqsV8RInYz4iFJp/cMy3cj2wfbJLHws6w=
=Zqgx
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
