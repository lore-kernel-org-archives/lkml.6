Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF240C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC8924A3A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC8924A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeGCLcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:32:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCLcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:32:17 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9CF4BCD9;
        Tue,  3 Jul 2018 11:32:05 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:31:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.111
Message-ID: <20180703113139.GA18494@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.111 kernel.

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

 Documentation/printk-formats.txt                        |    3=20
 Makefile                                                |    2=20
 arch/arm/include/asm/kgdb.h                             |    2=20
 arch/arm64/kernel/cpufeature.c                          |    2=20
 arch/arm64/mm/proc.S                                    |    5=20
 arch/m68k/mm/kmap.c                                     |    3=20
 arch/mips/bcm47xx/setup.c                               |    6=20
 arch/mips/include/asm/io.h                              |    2=20
 arch/mips/include/asm/mipsregs.h                        |    3=20
 arch/mips/kernel/mcount.S                               |   27 +--
 arch/powerpc/kernel/entry_64.S                          |    1=20
 arch/powerpc/kernel/fadump.c                            |    3=20
 arch/powerpc/kernel/hw_breakpoint.c                     |    4=20
 arch/powerpc/kernel/ptrace.c                            |    1=20
 arch/powerpc/platforms/powernv/pci-ioda.c               |    1=20
 arch/x86/include/asm/barrier.h                          |    2=20
 arch/x86/kernel/cpu/mcheck/mce-severity.c               |    5=20
 arch/x86/kernel/cpu/mcheck/mce.c                        |   44 +++--
 arch/x86/kernel/quirks.c                                |   11 +
 arch/x86/kernel/traps.c                                 |   14 +
 arch/x86/mm/init.c                                      |    4=20
 arch/xtensa/kernel/traps.c                              |    2=20
 crypto/asymmetric_keys/x509_cert_parser.c               |    9 +
 drivers/block/rbd.c                                     |    2=20
 drivers/bluetooth/hci_qca.c                             |    6=20
 drivers/char/ipmi/ipmi_bt_sm.c                          |    3=20
 drivers/clk/at91/clk-pll.c                              |   13 -
 drivers/clk/renesas/renesas-cpg-mssr.c                  |    9 -
 drivers/cpuidle/cpuidle-powernv.c                       |   32 +++-
 drivers/iio/buffer/kfifo_buf.c                          |    4=20
 drivers/infiniband/hw/hfi1/hfi.h                        |    1=20
 drivers/infiniband/hw/hfi1/init.c                       |   13 +
 drivers/infiniband/hw/mlx4/mad.c                        |    1=20
 drivers/infiniband/hw/mlx5/cq.c                         |   15 +
 drivers/infiniband/hw/qib/qib.h                         |    4=20
 drivers/infiniband/hw/qib/qib_file_ops.c                |   10 -
 drivers/infiniband/hw/qib/qib_init.c                    |   13 +
 drivers/infiniband/hw/qib/qib_user_pages.c              |   20 +-
 drivers/infiniband/ulp/isert/ib_isert.c                 |   28 ++-
 drivers/input/mouse/elan_i2c.h                          |    2=20
 drivers/input/mouse/elan_i2c_core.c                     |    3=20
 drivers/input/mouse/elan_i2c_smbus.c                    |   10 +
 drivers/input/mouse/elantech.c                          |   11 +
 drivers/md/dm-thin.c                                    |   11 +
 drivers/md/md.c                                         |    4=20
 drivers/media/dvb-core/dvb_frontend.c                   |   23 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c               |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c           |    2=20
 drivers/mfd/intel-lpss.c                                |    4=20
 drivers/mtd/chips/cfi_cmdset_0002.c                     |   21 +-
 drivers/mtd/ubi/build.c                                 |    3=20
 drivers/mtd/ubi/eba.c                                   |   90 +++++++++++
 drivers/mtd/ubi/wl.c                                    |    4=20
 drivers/net/usb/cdc_ncm.c                               |    4=20
 drivers/nvdimm/bus.c                                    |   14 +
 drivers/of/unittest.c                                   |    8 -
 drivers/pci/hotplug/pciehp.h                            |    2=20
 drivers/pci/hotplug/pciehp_core.c                       |    2=20
 drivers/pci/hotplug/pciehp_hpc.c                        |   13 +
 drivers/pci/quirks.c                                    |   20 ++
 drivers/pwm/pwm-lpss-platform.c                         |    5=20
 drivers/pwm/pwm-lpss.c                                  |   30 +++
 drivers/pwm/pwm-lpss.h                                  |    2=20
 drivers/rpmsg/qcom_smd.c                                |   18 +-
 drivers/s390/scsi/zfcp_dbf.c                            |   40 +++++
 drivers/s390/scsi/zfcp_erp.c                            |  123 +++++++++++=
+----
 drivers/s390/scsi/zfcp_ext.h                            |    5=20
 drivers/s390/scsi/zfcp_scsi.c                           |   18 +-
 drivers/scsi/qla2xxx/qla_init.c                         |    3=20
 drivers/tty/serial/sh-sci.c                             |    8 -
 drivers/usb/core/hub.c                                  |    4=20
 drivers/video/backlight/as3711_bl.c                     |   33 ++--
 drivers/video/backlight/max8925_bl.c                    |    4=20
 drivers/video/backlight/tps65217_bl.c                   |    4=20
 drivers/video/fbdev/uvesafb.c                           |    3=20
 drivers/w1/w1.c                                         |    2=20
 drivers/xen/events/events_base.c                        |    2=20
 fs/btrfs/inode.c                                        |   37 ++++
 fs/fuse/control.c                                       |   13 +
 fs/fuse/dir.c                                           |   13 +
 fs/fuse/inode.c                                         |    1=20
 fs/nfs/callback_proc.c                                  |    7=20
 fs/nfs/nfs4idmap.c                                      |    5=20
 fs/nfsd/nfs4xdr.c                                       |    5=20
 fs/ubifs/journal.c                                      |    2=20
 fs/udf/directory.c                                      |    3=20
 include/linux/blkdev.h                                  |    4=20
 include/linux/compiler.h                                |    2=20
 include/linux/iio/buffer.h                              |    6=20
 kernel/printk/nmi.c                                     |    5=20
 kernel/time/time.c                                      |    6=20
 lib/vsprintf.c                                          |    3=20
 sound/pci/hda/patch_realtek.c                           |   11 +
 sound/soc/cirrus/edb93xx.c                              |    2=20
 sound/soc/cirrus/ep93xx-i2s.c                           |   26 +--
 sound/soc/cirrus/snappercl15.c                          |    2=20
 sound/soc/soc-dapm.c                                    |    2=20
 tools/perf/util/dso.c                                   |    2=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c     |   23 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h     |    9 +
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c |    2=20
 tools/perf/util/intel-pt.c                              |    5=20
 102 files changed, 816 insertions(+), 268 deletions(-)

??? (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Adrian Hunter (6):
      perf tools: Fix symbol and object code resolution for vdso32 and vdso=
x32
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and correspondi=
ng TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error
      perf intel-pt: Fix packet decoding of CYC packets

Alex Estrin (2):
      IB/{hfi1, qib}: Add handling of kernel restart
      IB/isert: Fix for lib/dma_debug check_sync warning

Alex Williamson (1):
      PCI: Add ACS quirk for Intel 7th & 8th Gen mobile

Alexander Sverdlin (2):
      ASoC: cirrus: i2s: Fix LRCLK configuration
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Remove redundant free of TCE pages

Amit Pundir (1):
      Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw =
loader

Andy Shevchenko (1):
      mfd: intel-lpss: Program REMAP register in PIO mode

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Bj=F8rn Mork (1):
      cdc_ncm: avoid padding beyond end of skb

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Borislav Petkov (1):
      x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Corey Minyard (1):
      ipmi:bt: Set the timeout before doing a capabilities check

Dan Williams (2):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_=
nospec()
      mm: fix devmem_is_allowed() for sub-page System RAM intersections

Daniel Wagner (1):
      serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding ver=
sion

Dave Wysochanski (1):
      NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verif=
y_message

David Rivshin (1):
      ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct =
size

Dongsheng Yang (1):
      rbd: flush rbd_dev->watch_dwork after watch is unregistered

Erez Shitrit (1):
      IB/mlx5: Fetch soft WQE's on fatal error state

Eric W. Biederman (1):
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Filipe Manana (1):
      Btrfs: fix return value on rename exchange failure

Gautham R. Shenoy (1):
      cpuidle: powernv: Fix promotion from snooze if next state disabled

Geert Uytterhoeven (3):
      clk: renesas: cpg-mssr: Stop using printk format %pCr
      lib/vsprintf: Remove atomic-unsafe support for %pCr
      time: Make sure jiffies_to_msecs() preserves non-zero time periods

Greg Kroah-Hartman (1):
      Linux 4.9.111

Hans de Goede (1):
      pwm: lpss: platform: Save/restore the ctrl register over a suspend/re=
sume

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Ingo Flaschberger (1):
      1wire: family module autoload fails because of upper/lower case misma=
tch.

Jan Kara (1):
      udf: Detect incorrect directory size

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Johan Hovold (3):
      backlight: as3711_bl: Fix Device Tree node lookup
      backlight: max8925_bl: Fix Device Tree node lookup
      backlight: tps65217_bl: Fix Device Tree node lookup

Kai-Heng Feng (1):
      media: cx231xx: Add support for AverMedia DVD EZMaker 7

Kees Cook (1):
      video: uvesafb: Fix integer overflow in allocation

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Leon Romanovsky (1):
      RDMA/mlx4: Discard unknown SQP work requests

Liu Bo (1):
      Btrfs: fix unexpected cow in run_delalloc_nocow

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

Mahesh Salgaonkar (1):
      powerpc/fadump: Unregister fadump on kexec down path.

Marcin Ziemianowicz (1):
      clk: at91: PLL recalc_rate() now using cached MUL and DIV values

Martin Kelly (1):
      iio:buffer: make length types match kfifo types

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Mauro Carvalho Chehab (2):
      media: v4l2-compat-ioctl32: prevent go past max size
      media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Max Gurtovoy (1):
      IB/isert: fix T10-pi check mask setting

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Michael Neuling (2):
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_=
DEBUGREG
      powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Mika Westerberg (2):
      PCI: Add ACS quirk for Intel 300 series
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed=
 on resume

Mike Marciniszyn (1):
      IB/qib: Fix DMA api warning with debug kernel

Mike Snitzer (1):
      dm thin: handle running out of data space vs concurrent discard

Miklos Szeredi (2):
      fuse: atomic_o_trunc should truncate pagecache
      fuse: fix control dir setup and teardown

Mikulas Patocka (1):
      branch-check: fix long->int truncation when profiling branches

NeilBrown (1):
      md: fix two problems with setting the "re-add" device state.

Richard Weinberger (2):
      ubi: fastmap: Cancel work upon detach
      ubi: fastmap: Correctly handle interrupted erasures in EBA

Robert Elliott (1):
      linvdimm, pmem: Preserve read-only setting for pmem devices

Scott Mayhew (1):
      nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Siarhei Liakh (1):
      x86: Call fixup_exception() before notify_die() in math_error()

Silvio Cesare (1):
      UBIFS: Fix potential integer overflow in allocation

Srinivas Kandagatla (2):
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it
      rpmsg: smd: do not use mananged resources for endpoints and channels

Stefan M Schaeckeler (1):
      of: unittest: for strings, account for trailing \0 in property length=
 field

Steffen Maier (7):
      scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler
      scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF
      scsi: zfcp: fix misleading REC trigger trace where erp_action setup f=
ailed
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early=
 return
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for E=
RP_FAILED
      scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAIL=
ED
      scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thre=
ad

Takashi Iwai (2):
      ALSA: hda/realtek - Fix pop noise on Lenovo P50 & co
      ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210

Tetsuo Handa (2):
      fuse: don't keep dead fuse_conn at fuse_fill_super().
      printk: fix possible reuse of va_list variable

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Tony Luck (3):
      x86/mce: Improve error message when kernel cannot recover
      x86/mce: Check for alternate indication of machine check recovery on =
Skylake
      x86/mce: Fix incorrect "Machine check from unknown source" message

Trond Myklebust (1):
      NFSv4: Revert commit 5f83d86cf531d ("NFSv4.x: Fix wraparound issues..=
")

Will Deacon (2):
      arm64: kpti: Use early_param for kpti=3D command-line option
      arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache =
maintenance


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAls7XpoACgkQONu9yGCS
aT6ryg/+Ium/HRXhjuY9evsbE6jWZcCGD7NQCSHpEG2wYlVDsRPGdNIVpMVy91PH
MjqNs4xdeSIxxZAiL0kw9cAQMLhq2QJ+bah2hOE0tC6uzSsjXUgbhgl7C5e3os81
6ORakhJKkm665vuAfQRrCsS3pL0I0jUVgezOdTUvyvYEuS1M/a0NqblN8BpOPwUH
SP5sJpaBzgKl6EYQjhddvbMLu2GyzMQPYwnHJTFyZWnR+5BdbCxj+h8GNkk1/TcJ
w1DazFBDLfktqLrMcPJYOA4nEbirYLrITOtYsjwCrbWHIzjp39aR+GnjyaGHqfWC
W0yE+Cnjhk2b6pVsKYzWOzLNDzHQOwD7me87Soo3OOfa2EV7BfSwQvhWtlk/qwYd
k1aXO5GftvgKT+9Lw3F47wWmZSuOoGM7vWYl/d8mjkQwEeiloX4+P/Yi+6pMQqjS
Jm+aT7oLx465Rl/9LITV4jU2/vL+q5RHrePrLYiu/nV5wh7KExcPWW0YfASzq4av
u2uGtHjZabrLBH0IuDb4ptY4IQkazfuTNDHDPm2JKJB6yKLESX1GIve2YqLpMG6R
w+uK/VS3J0fXf8mqYgS8IHqXP5Myou0v0dFeJGcWBBjRvk6BBIXdkKHmLHCcvj6r
yu4y6V9wvzI1SSp/AUQrMNLc5MyUV6ZmUsyvjoyIzre4WzGNQ1M=
=Nb8+
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
