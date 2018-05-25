Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965889AbeEYPWK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965618AbeEYPWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:22:02 -0400
Date: Fri, 25 May 2018 17:21:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.12
Message-ID: <20180525152144.GA6744@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.12 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    2=20
 arch/powerpc/include/asm/exception-64s.h              |   29 +
 arch/powerpc/include/asm/feature-fixups.h             |   19 +
 arch/powerpc/include/asm/hvcall.h                     |    3=20
 arch/powerpc/include/asm/security_features.h          |   85 +++++
 arch/powerpc/kernel/Makefile                          |    2=20
 arch/powerpc/kernel/exceptions-64s.S                  |   19 +
 arch/powerpc/kernel/security.c                        |  237 +++++++++++++=
++
 arch/powerpc/kernel/setup_64.c                        |    8=20
 arch/powerpc/kernel/vmlinux.lds.S                     |   14=20
 arch/powerpc/lib/feature-fixups.c                     |  115 +++++++
 arch/powerpc/platforms/powernv/setup.c                |   96 ++++--
 arch/powerpc/platforms/pseries/setup.c                |   71 +++-
 arch/s390/Kconfig                                     |    3=20
 arch/s390/Makefile                                    |    2=20
 arch/s390/crypto/crc32be-vx.S                         |    5=20
 arch/s390/crypto/crc32le-vx.S                         |    4=20
 arch/s390/include/asm/alternative-asm.h               |  108 ++++++
 arch/s390/include/asm/nospec-branch.h                 |    7=20
 arch/s390/include/asm/nospec-insn.h                   |  196 ++++++++++++
 arch/s390/kernel/Makefile                             |    5=20
 arch/s390/kernel/alternative.c                        |   24 -
 arch/s390/kernel/asm-offsets.c                        |    1=20
 arch/s390/kernel/base.S                               |   24 -
 arch/s390/kernel/entry.S                              |  105 +-----
 arch/s390/kernel/mcount.S                             |   14=20
 arch/s390/kernel/module.c                             |   15=20
 arch/s390/kernel/nospec-branch.c                      |  123 ++++++-
 arch/s390/kernel/nospec-sysfs.c                       |   21 +
 arch/s390/kernel/reipl.S                              |    7=20
 arch/s390/kernel/setup.c                              |    3=20
 arch/s390/kernel/swsusp.S                             |   10=20
 arch/s390/lib/mem.S                                   |   19 -
 arch/s390/net/bpf_jit.S                               |   16 -
 arch/s390/net/bpf_jit_comp.c                          |   63 +++-
 arch/sparc/kernel/vio.c                               |    2=20
 arch/x86/kernel/machine_kexec_32.c                    |    6=20
 arch/x86/kernel/machine_kexec_64.c                    |    5=20
 drivers/block/loop.c                                  |   71 ++--
 drivers/bluetooth/btusb.c                             |   13=20
 drivers/clk/clk.c                                     |    3=20
 drivers/clk/hisilicon/crg-hi3516cv300.c               |    2=20
 drivers/clk/meson/axg.c                               |    7=20
 drivers/clk/rockchip/clk-mmc-phase.c                  |   23 +
 drivers/clk/rockchip/clk-rk3228.c                     |    2=20
 drivers/clk/samsung/clk-exynos3250.c                  |    4=20
 drivers/clk/samsung/clk-exynos5250.c                  |    8=20
 drivers/clk/samsung/clk-exynos5260.c                  |    2=20
 drivers/clk/samsung/clk-exynos5433.c                  |   12=20
 drivers/clk/samsung/clk-exynos7.c                     |    2=20
 drivers/clk/samsung/clk-s3c2410.c                     |   16 -
 drivers/clk/tegra/clk-pll.c                           |    2=20
 drivers/crypto/atmel-aes.c                            |    2=20
 drivers/crypto/ccp/ccp-debugfs.c                      |    7=20
 drivers/crypto/inside-secure/safexcel.c               |   12=20
 drivers/crypto/inside-secure/safexcel_cipher.c        |    2=20
 drivers/crypto/inside-secure/safexcel_hash.c          |   38 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c               |    1=20
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    |    2=20
 drivers/media/dvb-frontends/lgdt3306a.c               |   10=20
 drivers/media/i2c/adv748x/adv748x-hdmi.c              |    3=20
 drivers/media/i2c/ov5645.c                            |    5=20
 drivers/media/pci/cx23885/cx23885-cards.c             |    4=20
 drivers/media/pci/cx23885/cx23885-core.c              |   10=20
 drivers/media/pci/cx25821/cx25821-core.c              |    7=20
 drivers/media/platform/s3c-camif/camif-capture.c      |    7=20
 drivers/media/platform/vivid/vivid-ctrls.c            |    2=20
 drivers/media/platform/vsp1/vsp1_drm.c                |    9=20
 drivers/media/usb/em28xx/em28xx-cards.c               |   22 +
 drivers/media/usb/em28xx/em28xx.h                     |    2=20
 drivers/net/dsa/bcm_sf2_cfp.c                         |   36 +-
 drivers/net/ethernet/3com/3c59x.c                     |  104 +++---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h     |   28 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c     |   88 +----
 drivers/net/ethernet/mellanox/mlx4/main.c             |    4=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c             |   61 +++
 drivers/net/tun.c                                     |   27 -
 drivers/net/vmxnet3/vmxnet3_drv.c                     |   72 +++-
 drivers/net/vmxnet3/vmxnet3_int.h                     |    8=20
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
 drivers/scsi/aacraid/linit.c                          |    1=20
 drivers/scsi/lpfc/lpfc_attr.c                         |    5=20
 drivers/scsi/lpfc/lpfc_hbadisc.c                      |    5=20
 drivers/scsi/lpfc/lpfc_nportdisc.c                    |   15=20
 drivers/scsi/lpfc/lpfc_nvme.c                         |   28 -
 drivers/scsi/lpfc/lpfc_nvme.h                         |    2=20
 drivers/scsi/lpfc/lpfc_sli.c                          |    2=20
 drivers/scsi/mvsas/mv_94xx.c                          |   23 -
 drivers/scsi/scsi_devinfo.c                           |    1=20
 drivers/scsi/scsi_lib.c                               |   11=20
 drivers/scsi/sg.c                                     |    2=20
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c        |   16 -
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
 drivers/tty/serial/mvebu-uart.c                       |    2=20
 drivers/tty/serial/mxs-auart.c                        |    4=20
 drivers/tty/serial/samsung.c                          |    4=20
 drivers/tty/serial/sh-sci.c                           |    4=20
 drivers/tty/serial/xilinx_uartps.c                    |    2=20
 drivers/usb/dwc2/core.h                               |    2=20
 drivers/usb/dwc2/hcd.c                                |   32 +-
 drivers/usb/dwc3/Makefile                             |    2=20
 drivers/usb/dwc3/core.c                               |   13=20
 drivers/usb/dwc3/core.h                               |    2=20
 drivers/usb/gadget/composite.c                        |   40 +-
 drivers/usb/gadget/function/f_fs.c                    |    6=20
 drivers/usb/gadget/udc/goku_udc.h                     |    2=20
 drivers/usb/host/xhci-mem.c                           |    2=20
 drivers/usb/host/xhci.c                               |   14=20
 drivers/usb/usbip/Kconfig                             |    2=20
 fs/ext2/inode.c                                       |   10=20
 fs/hfsplus/super.c                                    |    1=20
 include/linux/mlx5/driver.h                           |   12=20
 include/linux/usb/composite.h                         |    3=20
 include/scsi/scsi.h                                   |    2=20
 include/uapi/linux/nl80211.h                          |    2=20
 net/core/dev.c                                        |    2=20
 net/core/sock.c                                       |    2=20
 net/dsa/dsa2.c                                        |    9=20
 net/ipv4/ip_output.c                                  |    3=20
 net/ipv4/tcp_output.c                                 |    7=20
 net/ipv6/ip6_gre.c                                    |  281 +++++++++++++=
+----
 net/ipv6/ip6_output.c                                 |    3=20
 net/packet/af_packet.c                                |    4=20
 net/sched/act_vlan.c                                  |    2=20
 net/sched/sch_red.c                                   |    5=20
 net/sched/sch_tbf.c                                   |    5=20
 net/smc/smc_pnet.c                                    |   71 ++--
 net/wireless/core.c                                   |    3=20
 sound/soc/rockchip/Kconfig                            |    3=20
 sound/soc/samsung/i2s.c                               |   13=20
 sound/soc/samsung/odroid.c                            |   11=20
 sound/soc/soc-topology.c                              |    3=20
 sound/usb/quirks.c                                    |   29 +
 154 files changed, 2355 insertions(+), 845 deletions(-)

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

Andrzej Hajda (6):
      clk: samsung: s3c2410: Fix PLL rates
      clk: samsung: exynos7: Fix PLL rates
      clk: samsung: exynos5260: Fix PLL rates
      clk: samsung: exynos5433: Fix PLL rates
      clk: samsung: exynos5250: Fix PLL rates
      clk: samsung: exynos3250: Fix PLL rates

Antoine Tenart (8):
      crypto: inside-secure - move the digest to the request context
      crypto: inside-secure - wait for the request to complete if in the ba=
cklog
      crypto: atmel-aes - fix the keys zeroing on errors
      crypto: inside-secure - do not process request if no command was issu=
ed
      crypto: inside-secure - fix the cache_len computation
      crypto: inside-secure - fix the extra cache computation
      crypto: inside-secure - do not overwrite the threshold value
      crypto: inside-secure - fix the invalidation step during cra_exit

Arnd Bergmann (2):
      clk: hisilicon: mark wdt_mux_p[] as const
      media: s3c-camif: fix out-of-bounds array access

Arvind Yadav (1):
      sparc: vio: use put_device() instead of kfree()

Ben Hutchings (1):
      usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS

Brad Love (6):
      media: lgdt3306a: Fix module count mismatch on usb unplug
      media: em28xx: USB bulk packet size fix
      media: cx23885: Override 888 ImpactVCBe crystal frequency
      media: cx23885: Set subdev host data to clk_freq pointer
      media: lgdt3306a: Fix a double kfree on i2c device remove
      media: em28xx: Add Hauppauge SoloHD/DualHD bulk models

Bryan O'Donoghue (1):
      rtc: snvs: Fix usage of snvs_rtc_enable

Chris Dickens (1):
      usb: gadget: composite: fix incorrect handling of OS desc requests

Christoph Hellwig (1):
      3c59x: convert to generic DMA API

Colin Ian King (3):
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldad=
dr
      media: cx25821: prevent out-of-bounds read on array card
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Dave Carroll (1):
      scsi: aacraid: Insure command thread is not recursively stopped

Davide Caratti (1):
      net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Douglas Gilbert (1):
      scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD

Eric Biggers (1):
      net/smc: check for missing nlattrs in SMC_PNETID messages

Eric Dumazet (2):
      sock_diag: fix use-after-free read in __sk_free
      tcp: purge write queue in tcp_connect_init()

Ezequiel Garcia (1):
      ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

Felipe Balbi (1):
      usb: dwc3: Makefile: fix link error on randconfig

Florian Fainelli (4):
      net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
      net: dsa: Do not register devlink for unused ports
      net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
      net: dsa: bcm_sf2: Fix IPv6 rule half deletion

Gabriel Matni (1):
      serial: mvebu-uart: fix tx lost characters

Geert Uytterhoeven (7):
      serial: xuartps: Fix out-of-bounds access through DT alias
      serial: sh-sci: Fix out-of-bounds access through DT alias
      serial: samsung: Fix out-of-bounds access through serial port index
      serial: mxs-auart: Fix out-of-bounds access through serial port index
      serial: imx: Fix out-of-bounds access through serial port index
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: arc_uart: Fix out-of-bounds access through DT alias

Greg Kroah-Hartman (1):
      Linux 4.16.12

Grigor Tovmasyan (1):
      usb: dwc2: Fix interval type issue

Hans Verkuil (1):
      media: vivid: fix incorrect capabilities for radio

Ioana Radulescu (2):
      staging: fsl-dpaa2/eth: Fix incorrect kfree
      staging: fsl-dpaa2/eth: Fix incorrect casts

James Hogan (1):
      rtc: goldfish: Add missing MODULE_LICENSE

James Smart (6):
      scsi: lpfc: Fix NVME Initiator FirstBurst
      scsi: lpfc: Fix issue_lip if link is disabled
      scsi: lpfc: Fix nonrecovery of NVME controller after cable swap.
      scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
      scsi: lpfc: Fix IO failure during hba reset testing with nvme io.
      scsi: lpfc: Fix frequency of Release WQE CQEs

Jason Wang (2):
      tun: fix use after free for ptr_ring
      tuntap: fix use after free during release

Jens Remus (1):
      scsi: zfcp: fix infinite iteration on ERP ready list

Jerome Brunet (1):
      clk: meson: axg: add the fractional part of the fixed_pll

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

Kieran Bingham (1):
      media: i2c: adv748x: fix HDMI field heights

Kirill Marinushkin (1):
      staging: bcm2835-audio: Release resources on module_exit()

Kumar Sanghvi (1):
      cxgb4: Correct ntuple mask validation for hash filters

Larry Finger (1):
      Bluetooth: btusb: Add device ID for RTL8822BE

Lars-Peter Clausen (2):
      usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
      usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Laurent Pinchart (1):
      media: v4l: vsp1: Fix display stalls when requesting too many inputs

Marcel Ziswiler (1):
      clk: tegra: Fix pll_u rate configuration

Martin Schwidefsky (15):
      s390: move nobp parameter functions to nospec-branch.c
      s390: add automatic detection of the spectre defense
      s390: report spectre mitigation via syslog
      s390: add sysfs attributes for spectre
      s390: add assembler macros for CPU alternatives
      s390: correct nospec auto detection init order
      s390: correct module section names for expoline code revert
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

Mauricio Faria de Oliveira (2):
      powerpc/pseries: Fix clearing of security feature flags
      powerpc: Move default security feature flags

Michael Ellerman (11):
      powerpc/rfi-flush: Always enable fallback flush on pseries
      powerpc: Add security feature flags for Spectre/Meltdown
      powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
      powerpc/pseries: Set or clear security feature flags
      powerpc/powernv: Set or clear security feature flags
      powerpc/64s: Move cpu_show_meltdown()
      powerpc/64s: Enhance the information in cpu_show_meltdown()
      powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
      powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
      powerpc/64s: Wire up cpu_show_spectre_v1()
      powerpc/64s: Wire up cpu_show_spectre_v2()

Michal Kalderon (3):
      qed: LL2 flush isles when connection is closed
      qed: Fix possibility of list corruption during rmmod flows
      qed: Fix LL2 race during connection terminate

Minas Harutyunyan (2):
      usb: dwc2: hcd: Fix host channel halt flow
      usb: dwc2: host: Fix transaction errors in host mode

NeilBrown (2):
      staging: lustre: fix bug in osc_enter_cache_try
      staging: lustre: lmv: correctly iput lmo_root

Nicholas Piggin (1):
      powerpc/64s: Add support for a store forwarding barrier at kernel ent=
ry/exit

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for Luxman DA-06

Omar Sandoval (2):
      loop: don't call into filesystem while holding lo_ctl_mutex
      loop: fix LOOP_GET_STATUS lock imbalance

Paolo Abeni (1):
      net: sched: red: avoid hashing NULL child

Peter Robinson (1):
      crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Petr Machata (7):
      net: ip6_gre: Request headroom in __gre6_xmit()
      net: ip6_gre: Fix headroom request in ip6erspan_tunnel_xmit()
      net: ip6_gre: Split up ip6gre_tnl_link_config()
      net: ip6_gre: Split up ip6gre_tnl_change()
      net: ip6_gre: Split up ip6gre_newlink()
      net: ip6_gre: Split up ip6gre_changelink()
      net: ip6_gre: Fix ip6erspan hlen calculation

Quytelda Kahja (1):
      staging: ks7010: Use constants from ieee80211_eid instead of literal =
ints.

Rahul Lakkireddy (1):
      cxgb4: fix offset in collecting TX rate limit info

Ranjani Sridharan (1):
      ASoC: topology: create TLV data for dapm widgets

Saeed Mahameed (1):
      net/mlx5: Fix build break when CONFIG_SMP=3Dn

Sebastian Andrzej Siewior (1):
      crypto: ccp - don't disable interrupts while setting up debugfs

Shawn Lin (3):
      clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
      clk: Don't show the incorrect clock phase
      clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Sylwester Nawrocki (2):
      ASoC: samsung: odroid: Fix 32000 sample rate handling
      ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.

Tedd Ho-Jeong An (1):
      Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:=
0026]

Tetsuo Handa (2):
      hfsplus: stop workqueue when fill_super() failed
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Thinh Nguyen (2):
      usb: dwc3: Add SoftReset PHY synchonization delay
      usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Uwe Kleine-K=F6nig (1):
      serial: altera: ensure port->regshift is honored consistently

Vicente Bergas (1):
      Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Vignesh R (1):
      serial: 8250: Don't service RX FIFO if interrupts are disabled

Wilfried Weissmann (1):
      scsi: mvsas: fix wrong endianness of sgpio api

Willem de Bruijn (2):
      net: test tailroom before appending to linear skb
      packet: in packet_snd start writing at link layer allocation

William Tu (1):
      net: ip6_gre: fix tunnel metadata device sharing.

Wolfram Sang (1):
      usb: gadget: udc: change comparison to bitshift when dealing with a m=
ask

Xose Vazquez Perez (1):
      scsi: devinfo: add HP DISK-SUBSYSTEM device, for HP XP arrays

Yixun Lan (1):
      clk: meson: axg: fix the od shift of the sys_pll

hpreg@vmware.com (2):
      vmxnet3: set the DMA mask before the first DMA map operation
      vmxnet3: use DMA memory barriers where required


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsIKgcACgkQONu9yGCS
aT6I/BAAtqGCYDySi4NOGmjz6n1bf8KkaiNO3L6hhibO3ToCaa0R0/8ZjAnwNb5S
oCDTYY3gXAZoR2NfISzHdiBwyVW0XTod2Z8uvzBaZ0fau+fz6fX/xwZyTeq9Ixks
SE5dTAIcvvT86IYr6WyuAeArOu8kd1xjR18gZIHgRIPB9fsFewoLM+zn0EtQtu2P
SypZNkeOM6S+ZZPdqtfZE89aRTjDMwcLf4e+UUHmw1t65mQPtwoDzBPVzZ7NKIiJ
lREhh1V3v9uXgne/x1NKY2avxlMQXiS+LZnr+52RUquQ+MM6v7AEelOWoFlSyIwY
5jM6rMgapLq9ojhxzYY7K9g4hdh3JljgtWAmU+1Z5vFCQ15VsaK5ZV9+IUFYsoH5
I9iJGRIMjVzquwQCMnt/x4/gGzzj/FXaxyqzLgOAC4JQxWe12sgMqNXwHBFL+3fs
vxMsMMQ4oDHBzdT/lLdcvm+XLJYtfu6KZt4kNBv4cpjh3yKqvvVlfDII7qtoBMLV
X3XCbj6eJckAZd+gMUNkhSiuOR4YPXBSDS9LRFiiFIqxaHpN4ELfxfp1xxriaGEz
Xz+g9rcwSaBqgY3rBWTjsjQ59t6uCbBjnb5HWt3eEtgXEDn2eQQLMPgvJL44gQUo
qXJiG3zUlwdh8gf52vJJFQad6bU2cVmYpt581dYcK8Z3zFX/r2k=
=8lNY
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
