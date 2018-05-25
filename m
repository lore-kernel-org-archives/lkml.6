Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936381AbeEYOwM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936259AbeEYOwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:52:03 -0400
Date: Fri, 25 May 2018 16:51:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.103
Message-ID: <20180525145145.GA4793@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.103 kernel.

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

 Makefile                                         |    2=20
 arch/s390/crypto/crc32be-vx.S                    |    5=20
 arch/s390/crypto/crc32le-vx.S                    |    4=20
 arch/s390/include/asm/alternative-asm.h          |  108 ++++++++++++
 arch/s390/include/asm/nospec-insn.h              |  195 ++++++++++++++++++=
+++++
 arch/s390/kernel/Makefile                        |    1=20
 arch/s390/kernel/asm-offsets.c                   |    1=20
 arch/s390/kernel/base.S                          |   24 +-
 arch/s390/kernel/entry.S                         |  105 ++----------
 arch/s390/kernel/mcount.S                        |   14 +
 arch/s390/kernel/nospec-branch.c                 |   43 ++---
 arch/s390/kernel/nospec-sysfs.c                  |   21 ++
 arch/s390/kernel/reipl.S                         |    7=20
 arch/s390/kernel/swsusp.S                        |    9 -
 arch/s390/lib/mem.S                              |    9 -
 arch/s390/net/bpf_jit.S                          |   16 +
 arch/s390/net/bpf_jit_comp.c                     |   63 +++++++
 arch/x86/kernel/machine_kexec_32.c               |    6=20
 arch/x86/kernel/machine_kexec_64.c               |    4=20
 drivers/bluetooth/btusb.c                        |    6=20
 drivers/clk/clk.c                                |    3=20
 drivers/clk/rockchip/clk-mmc-phase.c             |   23 ++
 drivers/clk/rockchip/clk-rk3228.c                |    2=20
 drivers/clk/samsung/clk-exynos3250.c             |    4=20
 drivers/clk/samsung/clk-exynos5250.c             |    8=20
 drivers/clk/samsung/clk-exynos5260.c             |    2=20
 drivers/clk/samsung/clk-exynos5433.c             |   12 -
 drivers/clk/samsung/clk-exynos7.c                |    2=20
 drivers/clk/samsung/clk-s3c2410.c                |   16 -
 drivers/clk/tegra/clk-pll.c                      |    2=20
 drivers/crypto/sunxi-ss/sun4i-ss-core.c          |    1=20
 drivers/media/dvb-core/dmxdev.c                  |    2=20
 drivers/media/pci/cx23885/cx23885-cards.c        |    4=20
 drivers/media/pci/cx23885/cx23885-core.c         |   10 +
 drivers/media/pci/cx25821/cx25821-core.c         |    7=20
 drivers/media/platform/s3c-camif/camif-capture.c |    7=20
 drivers/media/platform/vivid/vivid-ctrls.c       |    2=20
 drivers/media/usb/em28xx/em28xx.h                |    2=20
 drivers/media/v4l2-core/videobuf2-vmalloc.c      |    2=20
 drivers/message/fusion/mptctl.c                  |    2=20
 drivers/net/ethernet/mellanox/mlx4/main.c        |    4=20
 drivers/net/usb/qmi_wwan.c                       |    4=20
 drivers/net/vmxnet3/vmxnet3_drv.c                |   72 +++++---
 drivers/rtc/hctosys.c                            |    5=20
 drivers/rtc/rtc-snvs.c                           |   15 +
 drivers/rtc/rtc-tx4939.c                         |    6=20
 drivers/s390/scsi/zfcp_dbf.c                     |   23 ++
 drivers/s390/scsi/zfcp_ext.h                     |    5=20
 drivers/s390/scsi/zfcp_scsi.c                    |   14 -
 drivers/scsi/aacraid/commsup.c                   |    4=20
 drivers/scsi/aacraid/linit.c                     |    5=20
 drivers/scsi/arm/fas216.c                        |    2=20
 drivers/scsi/bnx2fc/bnx2fc_io.c                  |    1=20
 drivers/scsi/libsas/sas_scsi_host.c              |   33 +--
 drivers/scsi/lpfc/lpfc_attr.c                    |    5=20
 drivers/scsi/lpfc/lpfc_hbadisc.c                 |    5=20
 drivers/scsi/lpfc/lpfc_sli.c                     |    2=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c             |    2=20
 drivers/scsi/mvsas/mv_94xx.c                     |   23 +-
 drivers/scsi/qla2xxx/qla_isr.c                   |    6=20
 drivers/scsi/qla4xxx/ql4_def.h                   |    2=20
 drivers/scsi/qla4xxx/ql4_os.c                    |   46 +++++
 drivers/scsi/sd.c                                |    3=20
 drivers/scsi/sg.c                                |    2=20
 drivers/scsi/storvsc_drv.c                       |    2=20
 drivers/scsi/sym53c8xx_2/sym_hipd.c              |    2=20
 drivers/scsi/ufs/ufshcd.c                        |    2=20
 drivers/staging/lustre/lustre/include/obd.h      |    2=20
 drivers/staging/lustre/lustre/lmv/lmv_obd.c      |    2=20
 drivers/staging/lustre/lustre/osc/osc_cache.c    |    2=20
 drivers/staging/rtl8192u/r8192U_core.c           |    2=20
 drivers/tty/serial/8250/8250_port.c              |    3=20
 drivers/tty/serial/arc_uart.c                    |    5=20
 drivers/tty/serial/fsl_lpuart.c                  |    4=20
 drivers/tty/serial/imx.c                         |    6=20
 drivers/tty/serial/mxs-auart.c                   |    4=20
 drivers/tty/serial/samsung.c                     |    4=20
 drivers/tty/serial/xilinx_uartps.c               |    2=20
 drivers/usb/class/cdc-acm.c                      |    9 -
 drivers/usb/dwc2/core.h                          |    2=20
 drivers/usb/dwc2/gadget.c                        |   12 -
 drivers/usb/dwc2/hcd.c                           |   14 +
 drivers/usb/dwc3/core.c                          |   16 +
 drivers/usb/dwc3/core.h                          |    2=20
 drivers/usb/dwc3/dwc3-omap.c                     |   16 +
 drivers/usb/gadget/composite.c                   |   40 ++--
 drivers/usb/gadget/function/f_fs.c               |    6=20
 drivers/usb/gadget/function/f_uac2.c             |    2=20
 drivers/usb/gadget/udc/core.c                    |    2=20
 drivers/usb/gadget/udc/fsl_udc_core.c            |    4=20
 drivers/usb/gadget/udc/goku_udc.h                |    2=20
 drivers/usb/host/ohci-hcd.c                      |    3=20
 drivers/usb/host/xhci-mem.c                      |    2=20
 fs/ext2/inode.c                                  |   10 -
 fs/hfsplus/super.c                               |    1=20
 include/linux/usb/composite.h                    |    3=20
 include/uapi/linux/nl80211.h                     |    2=20
 net/core/sock.c                                  |    2=20
 net/ipv4/ip_output.c                             |    3=20
 net/ipv4/tcp_output.c                            |    7=20
 net/ipv6/ip6_output.c                            |    3=20
 net/packet/af_packet.c                           |    4=20
 net/wireless/core.c                              |    3=20
 sound/soc/au1x/ac97c.c                           |    6=20
 sound/soc/samsung/i2s.c                          |   13 +
 sound/soc/soc-topology.c                         |    3=20
 sound/usb/quirks.c                               |   29 +--
 107 files changed, 974 insertions(+), 334 deletions(-)

Al Viro (1):
      ext2: fix a block leak

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Alexandre Belloni (1):
      rtc: hctosys: Ensure system time doesn't overflow time_t

Andrzej Hajda (6):
      clk: samsung: s3c2410: Fix PLL rates
      clk: samsung: exynos7: Fix PLL rates
      clk: samsung: exynos5260: Fix PLL rates
      clk: samsung: exynos5433: Fix PLL rates
      clk: samsung: exynos5250: Fix PLL rates
      clk: samsung: exynos3250: Fix PLL rates

Arnd Bergmann (2):
      scsi: fas216: fix sense buffer initialization
      media: s3c-camif: fix out-of-bounds array access

Bart Van Assche (1):
      scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_com=
pletion()

Brad Love (3):
      media: em28xx: USB bulk packet size fix
      media: cx23885: Set subdev host data to clk_freq pointer
      media: cx23885: Override 888 ImpactVCBe crystal frequency

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

Dan Carpenter (3):
      scsi: sym53c8xx_2: iterator underflow in sym_getsync()
      scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
      ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

Dave Carroll (1):
      scsi: aacraid: Insure command thread is not recursively stopped

Dominik Bozek (1):
      usb: cdc_acm: prevent race at write to acm while system resumes

Eric Dumazet (2):
      sock_diag: fix use-after-free read in __sk_free
      tcp: purge write queue in tcp_connect_init()

Fredrik Noring (1):
      USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Geert Uytterhoeven (6):
      serial: xuartps: Fix out-of-bounds access through DT alias
      serial: samsung: Fix out-of-bounds access through serial port index
      serial: mxs-auart: Fix out-of-bounds access through serial port index
      serial: imx: Fix out-of-bounds access through serial port index
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: arc_uart: Fix out-of-bounds access through DT alias

Giuseppe Lippolis (1):
      net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Greg Kroah-Hartman (1):
      Linux 4.9.103

Grigor Tovmasyan (1):
      usb: dwc2: Fix interval type issue

Hannes Reinecke (1):
      scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Hans Verkuil (1):
      media: vivid: fix incorrect capabilities for radio

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

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

John Keeping (1):
      usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Larry Finger (1):
      Bluetooth: btusb: Add device ID for RTL8822BE

Lars-Peter Clausen (2):
      usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
      usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Manish Rangankar (1):
      scsi: qla4xxx: skip error recovery in case of register disconnect.

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

Mathias Nyman (1):
      xhci: zero usb device slot_id member when disabling and freeing a xhc=
i slot

Mauro Carvalho Chehab (1):
      media: dmxdev: fix error code for invalid ioctls

Meelis Roos (1):
      scsi: aacraid: fix shutdown crash when init fails

Michael Kelley (EOSG) (1):
      scsi: storvsc: Increase cmd_per_lun for higher speed devices

Minas Harutyunyan (1):
      usb: dwc2: host: Fix transaction errors in host mode

NeilBrown (2):
      staging: lustre: fix bug in osc_enter_cache_try
      staging: lustre: lmv: correctly iput lmo_root

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for Luxman DA-06

Peter Robinson (1):
      crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Ranjani Sridharan (1):
      ASoC: topology: create TLV data for dapm widgets

Roger Quadros (1):
      usb: dwc3: omap: don't miss events during suspend/resume

Shawn Lin (3):
      clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
      clk: Don't show the incorrect clock phase
      clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Stefan Agner (1):
      usb: gadget: fsl_udc_core: fix ep valid checks

Sujit Reddy Thumma (1):
      scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Sylwester Nawrocki (1):
      ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.

Tetsuo Handa (2):
      hfsplus: stop workqueue when fill_super() failed
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Thinh Nguyen (2):
      usb: dwc3: Add SoftReset PHY synchonization delay
      usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Torsten Hilbrich (1):
      net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Vardan Mikayelyan (1):
      usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Vicente Bergas (1):
      Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Vignesh R (1):
      serial: 8250: Don't service RX FIFO if interrupts are disabled

Wilfried Weissmann (1):
      scsi: mvsas: fix wrong endianness of sgpio api

Willem de Bruijn (2):
      net: test tailroom before appending to linear skb
      packet: in packet_snd start writing at link layer allocation

Wolfram Sang (1):
      usb: gadget: udc: change comparison to bitshift when dealing with a m=
ask

hpreg@vmware.com (2):
      vmxnet3: set the DMA mask before the first DMA map operation
      vmxnet3: use DMA memory barriers where required


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsIIwAACgkQONu9yGCS
aT55OhAAlGyKkR1/BYIZO2Bj/Tge9rHMkYLORpeo6rL4fZWRDq/QgTtlzQ2N6PkT
WStdRkGKlBL+NoWRx8TVqEUaXds5+MUCuEgmEULScXtdxWtColovQzdsZSS9MSLD
6XXLdKQ2MKjn8ax8RreHgdeccWUBFdf1Ccdwr1aiCEO1S9W28bpRYiJ6zf7Zvv3m
0Ktk9I0yCQr7wTKMhto1pQp8rWKhTZ35QBsLO2urIEFmOwEIazgV3A2lXfZHwxTJ
8eD+scVMMlsxaBTpTJKAxTdIViUgiPoNb2DzEEn//Hv1QtelZWUNUmIr+qyM1pee
qXARMZ6dOjT9Zzpv+RHuiWaghCCX/rMW9xG3Fk1SAT4BbqJkuNhOw4aIech5ZMFe
pN99xktX/mUz5oB/N9nO+QAUuksb9GO7w6jbDQ033ey7+BPQgcyiRPbSjK73IvfD
s/PSjZhT0IQtW7VUrhy7Lt6wSGrxgPwP1lpIuHyNgnelQXiZ1qhfAiGL+sD8ao7e
V74GepRMxXWXyvvGzEztDsrmPs8x4al2LkvUzyqUoKUda9Us9kgXkEKtO1YxB3Tj
CQeTFKDd5spigWNQ7cAzvjlfIL401zsH6AGqDQ3++9VNr/gYa6XRLdg9969xAW6V
YHgH9eWcjCCiJGnSNaaFnBTcQrkGSIyCxg7InVZVViY5QhsnmCE=
=8yTo
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
