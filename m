Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A36DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADED1204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADED1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIZPDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:03:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:03:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9207108A;
        Wed, 26 Sep 2018 08:51:36 +0000 (UTC)
Date:   Wed, 26 Sep 2018 10:51:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.123
Message-ID: <20180926085134.GA11378@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.123 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2 -
 arch/arm/mach-hisi/hotplug.c                      |   33 +++++++++++------
 arch/mips/ath79/setup.c                           |    1=20
 arch/mips/include/asm/io.h                        |    8 ++--
 arch/mips/include/asm/mach-ath79/ath79.h          |    1=20
 arch/mips/kernel/process.c                        |    1=20
 arch/mips/loongson/common/cs5536/cs5536_ohci.c    |    2 -
 arch/mips/mm/c-r4k.c                              |    6 ++-
 arch/openrisc/kernel/process.c                    |    2 -
 arch/powerpc/platforms/powernv/opal.c             |    2 -
 arch/powerpc/platforms/pseries/ras.c              |    2 -
 arch/powerpc/sysdev/mpic_msgr.c                   |    2 -
 arch/x86/mm/fault.c                               |    2 -
 block/cfq-iosched.c                               |    3 +
 block/partitions/aix.c                            |   13 ++++--
 drivers/ata/libahci.c                             |    2 +
 drivers/bluetooth/Kconfig                         |    1=20
 drivers/gpio/gpio-ml-ioh.c                        |    3 +
 drivers/gpu/drm/panel/panel-s6e8aa0.c             |    2 -
 drivers/i2c/busses/i2c-xiic.c                     |    4 ++
 drivers/infiniband/core/cma.c                     |   12 +++---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c           |    2 +
 drivers/macintosh/via-pmu.c                       |    9 ++--
 drivers/md/dm-kcopyd.c                            |    2 +
 drivers/md/raid5.c                                |    6 +++
 drivers/mfd/sm501.c                               |    1=20
 drivers/mfd/ti_am335x_tscadc.c                    |    3 -
 drivers/mtd/maps/solutionengine.c                 |    6 +--
 drivers/mtd/mtdchar.c                             |   10 +++--
 drivers/net/ethernet/cisco/enic/enic_main.c       |    2 -
 drivers/net/ethernet/marvell/mvneta.c             |    1=20
 drivers/net/wireless/ath/ath10k/mac.c             |    7 +++
 drivers/net/xen-netfront.c                        |   24 +++++-------
 drivers/parport/parport_sunbpp.c                  |    8 +++-
 drivers/pci/host/pci-mvebu.c                      |    2 -
 drivers/platform/x86/asus-nb-wmi.c                |    1=20
 drivers/platform/x86/toshiba_acpi.c               |    3 +
 drivers/rtc/rtc-bq4802.c                          |    4 ++
 drivers/s390/block/dasd_eckd.c                    |    7 ++-
 drivers/s390/net/qeth_core_main.c                 |    3 +
 drivers/s390/net/qeth_core_sys.c                  |    1=20
 drivers/scsi/3w-9xxx.c                            |    6 ++-
 drivers/scsi/3w-sas.c                             |    3 +
 drivers/scsi/3w-xxxx.c                            |    2 +
 drivers/scsi/aic94xx/aic94xx_init.c               |    4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c    |    3 +
 drivers/staging/rts5208/rtsx_scsi.c               |    2 -
 drivers/staging/rts5208/xd.c                      |    2 -
 drivers/target/target_core_transport.c            |    5 +-
 drivers/tty/rocket.c                              |    2 -
 drivers/uio/uio.c                                 |    3 -
 drivers/usb/class/cdc-wdm.c                       |    2 -
 drivers/usb/core/hcd-pci.c                        |    2 -
 drivers/usb/core/message.c                        |   11 +++++
 drivers/usb/core/quirks.c                         |    3 +
 drivers/usb/host/u132-hcd.c                       |    2 -
 drivers/usb/host/xhci.c                           |    3 +
 drivers/usb/misc/uss720.c                         |    4 +-
 drivers/usb/misc/yurex.c                          |    5 +-
 drivers/usb/serial/io_ti.h                        |    2 -
 drivers/usb/serial/ti_usb_3410_5052.h             |    2 -
 drivers/usb/storage/scsiglue.c                    |    9 ++++
 drivers/usb/storage/unusual_devs.h                |    7 +++
 drivers/video/fbdev/core/modedb.c                 |   41 ++++++++++++++++-=
-----
 drivers/video/fbdev/goldfishfb.c                  |    1=20
 drivers/video/fbdev/omap/omapfb_main.c            |    2 -
 drivers/video/fbdev/via/viafbdev.c                |    3 +
 fs/binfmt_elf.c                                   |    2 -
 fs/btrfs/dev-replace.c                            |    6 +++
 fs/btrfs/extent-tree.c                            |    2 -
 fs/btrfs/relocation.c                             |   23 ++++++------
 fs/cifs/cifs_debug.c                              |    8 ++++
 fs/cifs/readdir.c                                 |   11 ++++-
 fs/cifs/smb2misc.c                                |    7 +++
 fs/cifs/smb2pdu.c                                 |   27 ++++++++------
 fs/f2fs/super.c                                   |   21 ++++++++++-
 fs/fat/cache.c                                    |   19 ++++++----
 fs/fat/fat.h                                      |    5 ++
 fs/fat/fatent.c                                   |    6 +--
 fs/gfs2/bmap.c                                    |    2 -
 fs/hfs/brec.c                                     |    7 ++-
 fs/hfsplus/super.c                                |    4 +-
 fs/pstore/ram_core.c                              |   17 +++++++--
 fs/reiserfs/reiserfs.h                            |    2 -
 include/linux/mm_types.h                          |    2 -
 include/linux/sched.h                             |    2 -
 include/linux/vmacache.h                          |    5 --
 kernel/audit_watch.c                              |   12 +++++-
 kernel/fork.c                                     |   19 +++++++---
 lib/debugobjects.c                                |    7 ++-
 mm/debug.c                                        |    4 +-
 mm/fadvise.c                                      |    8 +++-
 mm/huge_memory.c                                  |    2 -
 mm/vmacache.c                                     |   36 -----------------=
--
 net/9p/trans_virtio.c                             |    3 +
 net/bluetooth/hidp/core.c                         |    2 -
 net/dcb/dcbnl.c                                   |   11 +++--
 net/irda/af_irda.c                                |   13 ++++++
 net/mac80211/cfg.c                                |    2 -
 net/mac80211/key.c                                |   24 ++++++++----
 net/netfilter/ipvs/ip_vs_core.c                   |   15 +++++---
 net/netfilter/x_tables.c                          |    4 +-
 net/xfrm/xfrm_policy.c                            |    5 ++
 scripts/depmod.sh                                 |    4 +-
 scripts/mod/modpost.c                             |    8 ++--
 sound/core/pcm_lib.c                              |   14 +++++--
 sound/isa/msnd/msnd_pinnacle.c                    |    4 +-
 sound/soc/codecs/wm8994.c                         |    1=20
 sound/usb/quirks-table.h                          |    3 +
 tools/hv/hv_kvp_daemon.c                          |    2 -
 tools/perf/arch/powerpc/util/skip-callchain-idx.c |   10 +++--
 tools/testing/selftests/powerpc/harness.c         |   18 ++++++---
 112 files changed, 489 insertions(+), 257 deletions(-)

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Aleh Filipovich (1):
      platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX=
360

Andreas Gruenbacher (1):
      gfs2: Special-case rindex for gfs2_grow

Andrey Ryabinin (1):
      mm/fadvise.c: fix signed overflow UBSAN complaint

Anton Vasilyev (4):
      tty: rocket: Fix possible buffer overwrite on register_PCI
      scsi: 3ware: fix return 0 on the error path of probe
      gpio: ml-ioh: Fix buffer underwrite on probe error path
      video: goldfishfb: fix memory leak on driver remove

Arnd Bergmann (1):
      reiserfs: change j_timestamp type to time64_t

Ben Hutchings (1):
      USB: yurex: Fix buffer over-read in yurex_write()

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

BingJing Chang (1):
      md/raid5: fix data corruption of replacements after originals dropped

Breno Leitao (1):
      selftests/powerpc: Kill child processes on SIGINT

Chao Yu (1):
      f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Chas Williams (1):
      Fixes: Commit 86af955d02bb ("mm: numa: avoid waiting on freed migrate=
d pages")

Dan Carpenter (7):
      powerpc: Fix size calculation using resource_size()
      scsi: aic94xx: fix an error code in aic94xx_init()
      uio: potential double frees if __uio_register_device() fails
      fbdev: omapfb: off by one in omapfb_register_client()
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()

Daniel Micay (1):
      staging/rts5208: Fix read overflow in memcpy

Eric Dumazet (1):
      netfilter: x_tables: avoid stack-out-of-bounds read in xt_copy_counte=
rs_from_user

Ernesto A. Fern=E1ndez (1):
      hfs: prevent crash on exit from failed search

Felix Fietkau (1):
      MIPS: ath79: fix system restart

Finn Thain (1):
      macintosh/via-pmu: Add missing mmio accessors

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Govindarajulu Varadarajan (1):
      enic: do not call enic_change_mtu in enic_probe

Greg Kroah-Hartman (1):
      Linux 3.18.123

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Gustavo A. R. Silva (1):
      ASoC: wm8994: Fix missing break in switch

Ian Abbott (1):
      staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

Jann Horn (2):
      fork: don't copy inconsistent signal handler state to child
      mtdchar: fix overflows in adjustment of `count`

Jean-Philippe Brucker (1):
      net/9p: fix error path of p9_virtio_probe

Jia-Ju Bai (4):
      staging: rt5208: Fix a sleep-in-atomic bug in xd_copy_page
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstandin=
g_interrupt()

Joel Fernandes (Google) (1):
      debugobjects: Make stack check warning more informative

Joerg Roedel (1):
      x86/mm: Remove in_nmi() warning from vmalloc_fault()

Johan Hedberg (1):
      Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Johan Hovold (2):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler

John Pittman (1):
      dm kcopyd: avoid softlockup in run_complete_job

Juergen Gross (1):
      xen/netfront: fix waiting for xenbus state change

Julia Lawall (1):
      parport: sunbpp: fix error return code

Julian Wiedmann (2):
      s390/qeth: fix race in used-buffer accounting
      s390/qeth: reset layer2 attribute on layer switch

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Linus Torvalds (1):
      mm: get rid of vmacache_flush_all() entirely

Maciej W. Rozycki (1):
      binfmt_elf: Respect error return from `regset->active'

Mahesh Salgaonkar (1):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Manikanta Pubbisetty (1):
      mac80211: restrict delayed tailroom needed decrement

Marcel Holtmann (1):
      Bluetooth: hidp: Fix handling of strncpy for hid->name information

Mathias Nyman (3):
      xhci: Fix use-after-free in xhci_free_virt_device
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_inte=
rface()

Mauricio Faria de Oliveira (2):
      partitions/aix: append null character to print data from disk
      partitions/aix: fix usage of uninitialized lv_info and lvname structu=
res

Mike Christie (1):
      scsi: target: fix __transport_register_session locking

Misono Tomohiro (1):
      btrfs: replace: Reset on-disk dev stats value after replace

Nicholas Mc Guire (2):
      ARM: hisi: handle of_iomap and fix missing of_node_put
      ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Piggin (1):
      powerpc/powernv: opal_put_chars partial write fix

OGAWA Hirofumi (1):
      fat: validate ->i_start before using

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock

Paul Burton (3):
      MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
      MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON
      MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Petr Machata (1):
      net: dcb: For wild-card lookups, use priority -1, not 0

Qu Wenruo (2):
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized
      btrfs: Don't remove block group that still has pinned down bytes

Randy Dunlap (5):
      scripts: modpost: check memory allocation results
      kbuild: make missing $DEPMOD a Warning instead of an Error
      mtd/maps: fix solutionengine.c printk format warnings
      fbdev/via: fix defined but not used warning
      platform/x86: toshiba_acpi: Fix defined but not used build warnings

Ritesh Harjani (1):
      cfq: Give a chance for arming slice idle timer in case of group_idle

Ronnie Sahlberg (1):
      cifs: check if SMB2 PDU size has been padded and suppress the warning

Ronny Chevalier (1):
      audit: fix use-after-free in audit_add_watch

Sandipan Das (2):
      perf powerpc: Fix callchain ip filtering when return address is in a =
register
      perf powerpc: Fix callchain ip filtering

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Srinivas Pandruvada (1):
      ata: libahci: Correct setting of DEVSLP register

Stefan Haberland (1):
      s390/dasd: fix hanging offline processing due to canceled worker

Steve French (2):
      smb3: fix reset of bytes read and written stats
      SMB3: Number of requests sent should be displayed for SMB3 not just C=
IFS

Sven Eckelmann (1):
      ath10k: prevent active scans on potential unusable channels

Takashi Iwai (2):
      ALSA: msnd: Fix the default sample sizes
      ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tetsuo Handa (1):
      hfsplus: don't return 0 when fill_super() failed

Thomas Petazzoni (1):
      PCI: mvebu: Fix I/O space end address calculation

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Timo Wischer (1):
      ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Tyler Hicks (2):
      irda: Fix memory leak caused by repeated binds of irda socket
      irda: Only insert new objects into the global database via setsockopt

Vegard Nossum (2):
      kthread: Fix use-after-free if kthread fork fails
      kthread: fix boot hang (regression) on MIPS/OpenRISC

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link

YueHaibing (1):
      xfrm: fix 'passing zero to ERR_PTR()' warning

Zhouyang Jia (1):
      rtc: bq4802: add error handling for devm_ioremap

Zumeng Chen (1):
      mfd: ti_am335x_tscadc: Fix struct clk memory leak


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlurSJMACgkQONu9yGCS
aT6FyRAAy0Pc5mzkNkE+rW2UGmgXvz4H/o7LfyCWSq0QaI0wl2gimDtyr/F5aVPG
Fd/IXBxbHzgxkbTZ4zrE2b0xsKT1HxkBvngNdbFn+TdPElbGjQU84fM9gCL7w3yY
HyuGQpV/LDRE0YujTzIRDao2PjZcORcMc+BYSnyonEpQXNATwXqUN7BeYmBPr2Vv
l/XYUARGQuCVmBLrILO/ACuTw2xU0jFP4Tdu36V7IOBZkuZBEZ8luYhf6ETG80ey
5lWVWG+f7cHeg+vCxI7XD2nWVAzGkYzoBcCG0T78gEhIrZalishjLj8StP+D+DHA
CaXw0EuKhgfIOua8jYESV922mO534DtucM1OWA3xQkm8TWs5rzTe4qy4txA0bR7/
KCX2bQfhK+Wxk2yvucrbigUb+wybQnEZDuaNVNcJVDz8nMyxgvoXVe6rSbxS4ZFX
p90S9frC1haek0LlvD5arzZrZMqqj/JpOciqtlOphXETtTjNtI9roeLAz9uGHSMV
PBarWSCqOQdf0JM2IYU8cNKoyugvM9fdUjLsN1mtWooIRat3Ui5Co94ES/NY9RXV
nNcOztqtGePpdEXJmXs3soW2+Q2ElQRW5cBfNcxLG7va8xVRsT8s6uUeDiUAYAk3
DA7y5I7YHWJgQ8qJD2FdzfcXCj/qOChkXlTyl/7inRHE4vMSA1I=
=CZji
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
