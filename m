Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936320AbeEYPVe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936185AbeEYPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:21:32 -0400
Date: Fri, 25 May 2018 17:21:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.44
Message-ID: <20180525152114.GA6647@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.44 kernel.

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

 Makefile                                              |    2=20
 arch/arm/boot/dts/imx7d-sdb.dts                       |    2=20
 arch/s390/crypto/crc32be-vx.S                         |    5=20
 arch/s390/crypto/crc32le-vx.S                         |    4=20
 arch/s390/include/asm/alternative-asm.h               |  108 ++++++
 arch/s390/include/asm/nospec-insn.h                   |  195 +++++++++++
 arch/s390/kernel/Makefile                             |    1=20
 arch/s390/kernel/asm-offsets.c                        |    1=20
 arch/s390/kernel/base.S                               |   24 -
 arch/s390/kernel/entry.S                              |  105 +-----
 arch/s390/kernel/mcount.S                             |   14=20
 arch/s390/kernel/nospec-branch.c                      |   43 +-
 arch/s390/kernel/nospec-sysfs.c                       |   21 +
 arch/s390/kernel/reipl.S                              |    7=20
 arch/s390/kernel/swsusp.S                             |   10=20
 arch/s390/lib/mem.S                                   |   13=20
 arch/s390/net/bpf_jit.S                               |   16=20
 arch/s390/net/bpf_jit_comp.c                          |   63 +++
 arch/sparc/kernel/vio.c                               |    2=20
 arch/x86/kernel/machine_kexec_32.c                    |    6=20
 arch/x86/kernel/machine_kexec_64.c                    |    5=20
 drivers/block/loop.c                                  |   71 ++--
 drivers/bluetooth/btusb.c                             |    6=20
 drivers/clk/clk.c                                     |    3=20
 drivers/clk/hisilicon/crg-hi3516cv300.c               |    2=20
 drivers/clk/rockchip/clk-mmc-phase.c                  |   23 +
 drivers/clk/rockchip/clk-rk3228.c                     |    2=20
 drivers/clk/samsung/clk-exynos3250.c                  |    4=20
 drivers/clk/samsung/clk-exynos5250.c                  |    8=20
 drivers/clk/samsung/clk-exynos5260.c                  |    2=20
 drivers/clk/samsung/clk-exynos5433.c                  |   12=20
 drivers/clk/samsung/clk-exynos7.c                     |    2=20
 drivers/clk/samsung/clk-s3c2410.c                     |   16=20
 drivers/clk/tegra/clk-pll.c                           |    2=20
 drivers/crypto/atmel-aes.c                            |    2=20
 drivers/crypto/ccp/ccp-debugfs.c                      |    7=20
 drivers/crypto/inside-secure/safexcel.c               |    9=20
 drivers/crypto/inside-secure/safexcel_cipher.c        |    2=20
 drivers/crypto/inside-secure/safexcel_hash.c          |    8=20
 drivers/crypto/sunxi-ss/sun4i-ss-core.c               |    1=20
 drivers/media/dvb-core/dmxdev.c                       |    2=20
 drivers/media/dvb-frontends/lgdt3306a.c               |   10=20
 drivers/media/i2c/adv748x/adv748x-hdmi.c              |    3=20
 drivers/media/i2c/ov5645.c                            |    5=20
 drivers/media/i2c/tvp5150.c                           |   88 ++---
 drivers/media/pci/cx23885/cx23885-cards.c             |    4=20
 drivers/media/pci/cx23885/cx23885-core.c              |   10=20
 drivers/media/pci/cx25821/cx25821-core.c              |    7=20
 drivers/media/platform/s3c-camif/camif-capture.c      |    7=20
 drivers/media/platform/vivid/vivid-ctrls.c            |    2=20
 drivers/media/platform/vsp1/vsp1_drm.c                |    9=20
 drivers/media/usb/em28xx/em28xx-cards.c               |   22 -
 drivers/media/usb/em28xx/em28xx.h                     |    2=20
 drivers/media/v4l2-core/videobuf2-vmalloc.c           |    2=20
 drivers/message/fusion/mptctl.c                       |    2=20
 drivers/net/ethernet/mellanox/mlx4/main.c             |    4=20
 drivers/net/hyperv/hyperv_net.h                       |   11=20
 drivers/net/hyperv/netvsc.c                           |  203 ++++++-----
 drivers/net/hyperv/netvsc_drv.c                       |  310 ++++++++++---=
-----
 drivers/net/hyperv/rndis_filter.c                     |  210 ++++++------
 drivers/net/usb/qmi_wwan.c                            |    4=20
 drivers/net/usb/usbnet.c                              |   10=20
 drivers/net/vmxnet3/vmxnet3_drv.c                     |   72 ++--
 drivers/rtc/hctosys.c                                 |    5=20
 drivers/rtc/rtc-goldfish.c                            |    2=20
 drivers/rtc/rtc-m41t80.c                              |   18 -
 drivers/rtc/rtc-rk808.c                               |   14=20
 drivers/rtc/rtc-rp5c01.c                              |   12=20
 drivers/rtc/rtc-snvs.c                                |   15=20
 drivers/rtc/rtc-tx4939.c                              |    6=20
 drivers/s390/scsi/zfcp_dbf.c                          |   23 +
 drivers/s390/scsi/zfcp_ext.h                          |    5=20
 drivers/s390/scsi/zfcp_scsi.c                         |   14=20
 drivers/scsi/aacraid/commsup.c                        |    4=20
 drivers/scsi/aacraid/linit.c                          |    5=20
 drivers/scsi/bnx2fc/bnx2fc_io.c                       |    1=20
 drivers/scsi/iscsi_tcp.c                              |    8=20
 drivers/scsi/libsas/sas_scsi_host.c                   |   33 -
 drivers/scsi/lpfc/lpfc_attr.c                         |    5=20
 drivers/scsi/lpfc/lpfc_hbadisc.c                      |    5=20
 drivers/scsi/lpfc/lpfc_sli.c                          |    2=20
 drivers/scsi/mpt3sas/mpt3sas_base.c                   |    5=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                  |    2=20
 drivers/scsi/mvsas/mv_94xx.c                          |   23 -
 drivers/scsi/qedi/qedi_fw.c                           |    5=20
 drivers/scsi/qedi/qedi_main.c                         |   24 -
 drivers/scsi/qla2xxx/qla_isr.c                        |    6=20
 drivers/scsi/qla2xxx/qla_os.c                         |    2=20
 drivers/scsi/qla4xxx/ql4_def.h                        |    2=20
 drivers/scsi/qla4xxx/ql4_os.c                         |   46 ++
 drivers/scsi/scsi_lib.c                               |   11=20
 drivers/scsi/sd.c                                     |    3=20
 drivers/scsi/sg.c                                     |    2=20
 drivers/scsi/storvsc_drv.c                            |    2=20
 drivers/scsi/sym53c8xx_2/sym_hipd.c                   |    2=20
 drivers/scsi/ufs/ufshcd.c                             |    2=20
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c        |    6=20
 drivers/staging/ks7010/ks_hostif.c                    |   31 -
 drivers/staging/ks7010/ks_hostif.h                    |    1=20
 drivers/staging/lustre/lustre/include/obd.h           |    2=20
 drivers/staging/lustre/lustre/lmv/lmv_obd.c           |    2=20
 drivers/staging/lustre/lustre/osc/osc_cache.c         |    2=20
 drivers/staging/rtl8192u/r8192U_core.c                |    2=20
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c |   54 +--
 drivers/tty/serial/8250/8250_port.c                   |    3=20
 drivers/tty/serial/altera_uart.c                      |   12=20
 drivers/tty/serial/arc_uart.c                         |    5=20
 drivers/tty/serial/fsl_lpuart.c                       |    4=20
 drivers/tty/serial/imx.c                              |    6=20
 drivers/tty/serial/mxs-auart.c                        |    4=20
 drivers/tty/serial/samsung.c                          |    4=20
 drivers/tty/serial/sh-sci.c                           |    4=20
 drivers/tty/serial/xilinx_uartps.c                    |    2=20
 drivers/usb/class/cdc-acm.c                           |    9=20
 drivers/usb/dwc2/core.h                               |    2=20
 drivers/usb/dwc2/gadget.c                             |   12=20
 drivers/usb/dwc2/hcd.c                                |   32 +
 drivers/usb/dwc3/Makefile                             |    2=20
 drivers/usb/dwc3/core.c                               |   16=20
 drivers/usb/dwc3/core.h                               |    2=20
 drivers/usb/dwc3/dwc3-omap.c                          |   16=20
 drivers/usb/gadget/composite.c                        |   40 +-
 drivers/usb/gadget/function/f_fs.c                    |    6=20
 drivers/usb/gadget/function/f_uac2.c                  |    2=20
 drivers/usb/gadget/udc/core.c                         |    2=20
 drivers/usb/gadget/udc/fsl_udc_core.c                 |    4=20
 drivers/usb/gadget/udc/goku_udc.h                     |    2=20
 drivers/usb/host/ohci-hcd.c                           |    3=20
 drivers/usb/host/xhci-mem.c                           |    2=20
 drivers/usb/host/xhci-plat.c                          |   11=20
 drivers/usb/host/xhci.c                               |   14=20
 drivers/usb/usbip/Kconfig                             |    2=20
 fs/ext2/inode.c                                       |   10=20
 fs/hfsplus/super.c                                    |    1=20
 include/linux/u64_stats_sync.h                        |   22 +
 include/linux/usb/composite.h                         |    3=20
 include/scsi/scsi.h                                   |    2=20
 include/uapi/linux/nl80211.h                          |    2=20
 net/core/dev.c                                        |    2=20
 net/core/sock.c                                       |    2=20
 net/ipv4/ip_output.c                                  |    3=20
 net/ipv4/tcp_output.c                                 |    7=20
 net/ipv6/ip6_output.c                                 |    3=20
 net/packet/af_packet.c                                |    4=20
 net/sched/act_vlan.c                                  |    2=20
 net/sched/sch_red.c                                   |    5=20
 net/sched/sch_tbf.c                                   |    5=20
 net/smc/smc_pnet.c                                    |   71 ++--
 net/wireless/core.c                                   |    3=20
 sound/soc/codecs/hdmi-codec.c                         |    7=20
 sound/soc/rockchip/Kconfig                            |    3=20
 sound/soc/samsung/i2s.c                               |   13=20
 sound/soc/samsung/odroid.c                            |   11=20
 sound/soc/soc-topology.c                              |    3=20
 sound/usb/quirks.c                                    |   29 -
 155 files changed, 1784 insertions(+), 894 deletions(-)

Akinobu Mita (1):
      media: ov5645: add missing of_node_put() in error path

Al Viro (1):
      ext2: fix a block leak

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Alexandre Belloni (4):
      rtc: hctosys: Ensure system time doesn't overflow time_t
      rtc: rk808: fix possible race condition
      rtc: m41t80: fix race conditions
      rtc: rp5c01: fix possible race condition

Amritha Nambiar (1):
      net: Fix a bug in removing queues from XPS map

Andrew Vasquez (1):
      scsi: qedi: Fix truncation of CHAP name and secret

Andrzej Hajda (6):
      clk: samsung: s3c2410: Fix PLL rates
      clk: samsung: exynos7: Fix PLL rates
      clk: samsung: exynos5260: Fix PLL rates
      clk: samsung: exynos5433: Fix PLL rates
      clk: samsung: exynos5250: Fix PLL rates
      clk: samsung: exynos3250: Fix PLL rates

Antoine Tenart (6):
      crypto: inside-secure - wait for the request to complete if in the ba=
cklog
      crypto: atmel-aes - fix the keys zeroing on errors
      crypto: inside-secure - do not process request if no command was issu=
ed
      crypto: inside-secure - fix the cache_len computation
      crypto: inside-secure - fix the extra cache computation
      crypto: inside-secure - fix the invalidation step during cra_exit

Arnd Bergmann (2):
      clk: hisilicon: mark wdt_mux_p[] as const
      media: s3c-camif: fix out-of-bounds array access

Arvind Yadav (1):
      sparc: vio: use put_device() instead of kfree()

Bart Van Assche (1):
      scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_com=
pletion()

Ben Hutchings (1):
      usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS

Brad Love (6):
      media: lgdt3306a: Fix module count mismatch on usb unplug
      media: em28xx: USB bulk packet size fix
      media: cx23885: Override 888 ImpactVCBe crystal frequency
      media: cx23885: Set subdev host data to clk_freq pointer
      media: lgdt3306a: Fix a double kfree on i2c device remove
      media: em28xx: Add Hauppauge SoloHD/DualHD bulk models

Brian Norris (1):
      usb: dwc3: Undo PHY init if soft reset fails

Bryan O'Donoghue (1):
      rtc: snvs: Fix usage of snvs_rtc_enable

Chad Dupuis (1):
      scsi: bnx2fc: Fix check in SCSI completion handler for timed out requ=
est

Chris Dickens (1):
      usb: gadget: composite: fix incorrect handling of OS desc requests

Colin Ian King (3):
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldad=
dr
      media: cx25821: prevent out-of-bounds read on array card
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Dan Carpenter (2):
      scsi: sym53c8xx_2: iterator underflow in sym_getsync()
      scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()

Dave Carroll (1):
      scsi: aacraid: Insure command thread is not recursively stopped

Davide Caratti (1):
      net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Dominik Bozek (1):
      usb: cdc_acm: prevent race at write to acm while system resumes

Douglas Gilbert (1):
      scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD

Eric Biggers (1):
      net/smc: check for missing nlattrs in SMC_PNETID messages

Eric Dumazet (3):
      sock_diag: fix use-after-free read in __sk_free
      tcp: purge write queue in tcp_connect_init()
      net: usbnet: fix potential deadlock on 32bit hosts

Ezequiel Garcia (1):
      ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

Felipe Balbi (1):
      usb: dwc3: Makefile: fix link error on randconfig

Fredrik Noring (1):
      USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Geert Uytterhoeven (7):
      serial: xuartps: Fix out-of-bounds access through DT alias
      serial: sh-sci: Fix out-of-bounds access through DT alias
      serial: samsung: Fix out-of-bounds access through serial port index
      serial: mxs-auart: Fix out-of-bounds access through serial port index
      serial: imx: Fix out-of-bounds access through serial port index
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: arc_uart: Fix out-of-bounds access through DT alias

Giuseppe Lippolis (1):
      net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Greg Kroah-Hartman (1):
      Linux 4.14.44

Grigor Tovmasyan (1):
      usb: dwc2: Fix interval type issue

Haiyang Zhang (6):
      hv_netvsc: Fix the real number of queues of non-vRSS cases
      hv_netvsc: Rename ind_table to rx_table
      hv_netvsc: Rename tx_send_table to tx_table
      hv_netvsc: Add initialization of tx_table in netvsc_device_add()
      hv_netvsc: Set tx_table to equal weight after subchannels open
      hv_netvsc: Use the num_online_cpus() for channel limit

Hannes Reinecke (1):
      scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Hans Verkuil (1):
      media: vivid: fix incorrect capabilities for radio

Ioana Radulescu (1):
      staging: fsl-dpaa2/eth: Fix incorrect casts

James Hogan (1):
      rtc: goldfish: Add missing MODULE_LICENSE

James Smart (3):
      scsi: lpfc: Fix issue_lip if link is disabled
      scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
      scsi: lpfc: Fix frequency of Release WQE CQEs

Jason Yan (1):
      scsi: libsas: defer ata device eh commands to libata

Jens Remus (1):
      scsi: zfcp: fix infinite iteration on ERP ready list

Jeremy Cline (1):
      scsi: sd: Keep disk read-only when re-reading partition

Jianchao Wang (1):
      scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

John Keeping (1):
      usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Kieran Bingham (1):
      media: i2c: adv748x: fix HDMI field heights

Kirill Marinushkin (1):
      staging: bcm2835-audio: Release resources on module_exit()

Larry Finger (1):
      Bluetooth: btusb: Add device ID for RTL8822BE

Lars-Peter Clausen (2):
      usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
      usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Laurent Pinchart (1):
      media: v4l: vsp1: Fix display stalls when requesting too many inputs

Leonard Crestez (1):
      ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name

Manish Rangankar (2):
      scsi: qla4xxx: skip error recovery in case of register disconnect.
      scsi: qedi: Fix kernel crash during port toggle

Manu Gautam (1):
      usb: gadget: core: Fix use-after-free of usb_request

Marcel Ziswiler (1):
      clk: tegra: Fix pll_u rate configuration

Martin Schwidefsky (9):
      s390: add assembler macros for CPU alternatives
      s390: move expoline assembler macros to a header
      s390/crc32-vx: use expoline for indirect branches
      s390/lib: use expoline for indirect branches
      s390/ftrace: use expoline for indirect branches
      s390/kernel: use expoline for indirect branches
      s390: move spectre sysfs attribute code
      s390: extend expoline to BC instructions
      s390: use expoline thunks in the BPF JIT

Masami Hiramatsu (1):
      media: vb2: Fix videobuf2 to map correct area

Mathias Nyman (2):
      xhci: zero usb device slot_id member when disabling and freeing a xhc=
i slot
      xhci: Show what USB release number the xHC supports from protocol cap=
ablity

Mauro Carvalho Chehab (2):
      media: dmxdev: fix error code for invalid ioctls
      media: Don't let tvp5150_get_vbi() go out of vbi_ram_default array

Meelis Roos (1):
      scsi: aacraid: fix shutdown crash when init fails

Michael Kelley (EOSG) (1):
      scsi: storvsc: Increase cmd_per_lun for higher speed devices

Minas Harutyunyan (2):
      usb: dwc2: hcd: Fix host channel halt flow
      usb: dwc2: host: Fix transaction errors in host mode

Mohammed Gamal (4):
      hv_netvsc: Use Windows version instead of NVSP version on GPAD teardo=
wn
      hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown_gpadl()
      hv_netvsc: Ensure correct teardown message sequence order
      hv_netvsc: Fix net device attach on older Windows hosts

NeilBrown (2):
      staging: lustre: fix bug in osc_enter_cache_try
      staging: lustre: lmv: correctly iput lmo_root

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for Luxman DA-06

Omar Sandoval (2):
      loop: don't call into filesystem while holding lo_ctl_mutex
      loop: fix LOOP_GET_STATUS lock imbalance

Paolo Abeni (1):
      net: sched: red: avoid hashing NULL child

Peter Robinson (1):
      crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Peter Ujfalusi (1):
      ASoC: hdmi-codec: Fix module unloading caused kernel crash

Quinn Tran (1):
      scsi: qla2xxx: Fix memory corruption during hba reset test

Quytelda Kahja (1):
      staging: ks7010: Use constants from ieee80211_eid instead of literal =
ints.

Ranjani Sridharan (1):
      ASoC: topology: create TLV data for dapm widgets

Roger Quadros (1):
      usb: dwc3: omap: don't miss events during suspend/resume

Sebastian Andrzej Siewior (1):
      crypto: ccp - don't disable interrupts while setting up debugfs

Shawn Lin (3):
      clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
      clk: Don't show the incorrect clock phase
      clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Stefan Agner (1):
      usb: gadget: fsl_udc_core: fix ep valid checks

Stephen Hemminger (11):
      hv_netvsc: empty current transmit aggregation if flow blocked
      hv_netvsc: avoid retry on send during shutdown
      hv_netvsc: only wake transmit queue if link is up
      hv_netvsc: fix error unwind handling if vmbus_open fails
      hv_netvsc: cancel subchannel setup before halting device
      hv_netvsc: fix race in napi poll when rescheduling
      hv_netvsc: defer queue selection to VF
      hv_netvsc: disable NAPI before channel close
      hv_netvsc: use RCU to fix concurrent rx and queue changes
      hv_netvsc: change GPAD teardown order on older versions
      hv_netvsc: common detach logic

Sujit Reddy Thumma (1):
      scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Sylwester Nawrocki (2):
      ASoC: samsung: odroid: Fix 32000 sample rate handling
      ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.

Tetsuo Handa (2):
      hfsplus: stop workqueue when fill_super() failed
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Thinh Nguyen (2):
      usb: dwc3: Add SoftReset PHY synchonization delay
      usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Tomas Henzl (1):
      scsi: mpt3sas: fix an out of bound write

Torsten Hilbrich (1):
      net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Uwe Kleine-K=F6nig (1):
      serial: altera: ensure port->regshift is honored consistently

Vardan Mikayelyan (1):
      usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Vicente Bergas (1):
      Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Vignesh R (1):
      serial: 8250: Don't service RX FIFO if interrupts are disabled

Vitaly Kuznetsov (2):
      hv_netvsc: netvsc_teardown_gpadl() split
      hv_netvsc: preserve hw_features on mtu/channels/ringparam changes

Wilfried Weissmann (1):
      scsi: mvsas: fix wrong endianness of sgpio api

Willem de Bruijn (2):
      net: test tailroom before appending to linear skb
      packet: in packet_snd start writing at link layer allocation

Wolfram Sang (1):
      usb: gadget: udc: change comparison to bitshift when dealing with a m=
ask

Yoshihiro Shimoda (1):
      usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk in res=
ume timing"

hpreg@vmware.com (2):
      vmxnet3: set the DMA mask before the first DMA map operation
      vmxnet3: use DMA memory barriers where required


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsIKeUACgkQONu9yGCS
aT7v4w//WN+06spvkSOed5Hg7ZldayFs3w7TRlJaGYwGB1oY38ssyiA9LBSU1enZ
fJU9suShDSV6dAsAkd8zKzAyk7H12Esoh9v0jONkBSIjBydltARfAzfCv8qllW2+
cJUqjj80LTgF6AuuwKhxoDjasL5QTiqPVKuMSCPuKlAdHy2pkkgWcgJuZ6U5tRDS
oJ+allBzWxVzM5Rb8l5dQFoFKa2ex0a408zufjY0eEtrGwhgFAgiyImndMoJN6fJ
KW0iMO920qHyBQjW3SRoBn1jpsnMzcq9Iz68HPIFwRhTeSJ6lGWaUkE1ZHxwExHH
PiSVDomlwtxySLvh84urGeqbc8iveytxI1oC+MgTdAUuQPWkNHDZWUJqq3bm7oj2
vrHnOP9BkUgsSGbIhtlnk/P9ZBhbtCBfZPDjxfTcOl9veFcmlsZtUjNhhalF8iTa
tMo+Ho8qrWoFHF74Wg0l2yAlxj8y7HQKcJh9gvPfcEqRC7BsbA2eBG/ymieIxBRQ
wvKNfCWWoSN914bK4ZhFO8EBTVnudVV05lFc5bsxcdDty6o4Z3HyEpiKPa8f68PR
r5H3AgAxZZEbva+EiUAb3dMjyZyeo0KN8vxRSNNCbLjk4YY02VDXBTO+tF/EHHDV
Po0TOJdW2+pCot8F1j3KpHBjNMKnB6kZp43g1rqtoFV2qdwolag=
=qYBZ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
