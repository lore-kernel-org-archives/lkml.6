Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B611ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DE5206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DE5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeITC7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:59:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbeITC7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:59:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56BD31055;
        Wed, 19 Sep 2018 21:19:54 +0000 (UTC)
Date:   Wed, 19 Sep 2018 23:19:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.157
Message-ID: <20180919211951.GA9733@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.157 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                  |    2 -
 arch/arc/configs/axs101_defconfig         |    1=20
 arch/arc/configs/axs103_defconfig         |    1=20
 arch/arc/configs/axs103_smp_defconfig     |    1=20
 arch/mips/cavium-octeon/octeon-platform.c |    2 +
 arch/mips/include/asm/io.h                |    8 ++---
 arch/mips/kernel/process.c                |    1=20
 arch/mips/mm/c-r4k.c                      |    6 ++-
 arch/openrisc/kernel/process.c            |    2 -
 arch/x86/include/asm/processor.h          |    4 +-
 arch/x86/kernel/cpu/bugs.c                |   47 +++++++++++++++++++++++++=
+----
 arch/x86/kernel/cpu/common.c              |    2 +
 arch/x86/mm/fault.c                       |    2 -
 block/blk-cgroup.c                        |    9 +++--
 block/cfq-iosched.c                       |    6 ++-
 block/partitions/aix.c                    |   13 +++++---
 drivers/ata/libahci.c                     |    2 +
 drivers/bluetooth/Kconfig                 |    1=20
 drivers/crypto/vmx/aes_cbc.c              |   30 ++++++++-----------
 drivers/gpio/gpio-ml-ioh.c                |    3 +
 drivers/gpio/gpio-tegra.c                 |    2 -
 drivers/i2c/busses/i2c-i801.c             |    7 +++-
 drivers/i2c/busses/i2c-xiic.c             |    4 ++
 drivers/infiniband/core/cma.c             |   13 ++++++--
 drivers/input/touchscreen/atmel_mxt_ts.c  |    7 ++--
 drivers/iommu/ipmmu-vmsa.c                |    9 ++---
 drivers/macintosh/via-pmu.c               |    9 +++--
 drivers/md/raid5.c                        |    6 +++
 drivers/mfd/ti_am335x_tscadc.c            |    3 -
 drivers/misc/mic/scif/scif_api.c          |   20 +++++-------
 drivers/misc/ti-st/st_kim.c               |    4 +-
 drivers/misc/vmw_balloon.c                |    1=20
 drivers/mtd/ubi/wl.c                      |    8 +++--
 drivers/net/ethernet/marvell/mvneta.c     |    1=20
 drivers/net/ethernet/ti/cpsw.c            |   14 ++++----
 drivers/net/ethernet/ti/cpsw.h            |    1=20
 drivers/net/ethernet/ti/davinci_emac.c    |    1=20
 drivers/net/wireless/ath/ath10k/mac.c     |    7 ++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    5 +++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |    5 +++
 drivers/scsi/3w-9xxx.c                    |    6 +++
 drivers/scsi/3w-sas.c                     |    3 +
 drivers/scsi/3w-xxxx.c                    |    2 +
 drivers/staging/rts5208/rtsx_scsi.c       |    2 -
 drivers/staging/rts5208/xd.c              |    2 -
 drivers/target/target_core_transport.c    |    5 +--
 drivers/tty/rocket.c                      |    2 -
 drivers/uio/uio.c                         |    3 -
 drivers/usb/host/xhci.c                   |    3 +
 fs/autofs4/autofs_i.h                     |    4 +-
 fs/autofs4/inode.c                        |    1=20
 fs/f2fs/segment.h                         |    3 +
 fs/f2fs/super.c                           |   21 ++++++++++++-
 fs/nfs/callback_xdr.c                     |   11 +++++--
 include/linux/mm_types.h                  |    2 -
 include/linux/sched.h                     |    2 -
 include/linux/vm_event_item.h             |    1=20
 include/linux/vmacache.h                  |    5 ---
 include/uapi/linux/ethtool.h              |    4 +-
 kernel/fork.c                             |   17 +++++++---
 kernel/locking/osq_lock.c                 |   13 ++++++++
 kernel/locking/rwsem-xadd.c               |   27 +++++++++++++++++
 mm/debug.c                                |    4 +-
 mm/vmacache.c                             |   38 ------------------------
 net/bluetooth/hidp/core.c                 |    2 -
 net/dcb/dcbnl.c                           |   11 ++++---
 net/netfilter/x_tables.c                  |    4 +-
 security/selinux/avc.c                    |   14 +++-----
 sound/pci/hda/hda_codec.c                 |    3 +
 tools/perf/perf.h                         |    2 +
 70 files changed, 311 insertions(+), 176 deletions(-)

Alexey Brodkin (1):
      ARC: [plat-axs*]: Enable SWAP

Andi Kleen (1):
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Anton Vasilyev (4):
      misc: ti-st: Fix memory leak in the error path of probe()
      tty: rocket: Fix possible buffer overwrite on register_PCI
      scsi: 3ware: fix return 0 on the error path of probe
      gpio: ml-ioh: Fix buffer underwrite on probe error path

BingJing Chang (1):
      md/raid5: fix data corruption of replacements after originals dropped

Chao Yu (1):
      f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Christophe Leroy (1):
      perf tools: Allow overriding MAX_NR_CPUS at compile time

Dan Carpenter (2):
      misc: mic: SCIF Fix scif_get_new_port() error handling
      uio: potential double frees if __uio_register_device() fails

Daniel Micay (1):
      staging/rts5208: Fix read overflow in memcpy

David Rivshin (1):
      drivers: net: cpsw: fix parsing of phy-handle DT property in dual_ema=
c config

Dmitry Osipenko (1):
      gpio: tegra: Move driver registration to subsys_init level

Eric Dumazet (1):
      netfilter: x_tables: avoid stack-out-of-bounds read in xt_copy_counte=
rs_from_user

Felipe Balbi (1):
      i2c: i801: fix DNV's SMBCTRL register offset

Finn Thain (1):
      macintosh/via-pmu: Add missing mmio accessors

Florian Fainelli (1):
      ethtool: Remove trailing semicolon for static inline

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix allocation in atomic context

Greg Kroah-Hartman (1):
      Linux 4.4.157

Ian Kent (1):
      autofs: fix autofs_sbi() does not check super block type

Jia-Ju Bai (1):
      staging: rt5208: Fix a sleep-in-atomic bug in xd_copy_page

Joerg Roedel (1):
      x86/mm: Remove in_nmi() warning from vmalloc_fault()

Johan Hedberg (1):
      Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Johan Hovold (1):
      net: ethernet: ti: cpsw: fix mdio device reference leak

Linus Torvalds (1):
      mm: get rid of vmacache_flush_all() entirely

Marcel Holtmann (1):
      Bluetooth: hidp: Fix handling of strncpy for hid->name information

Mathias Nyman (1):
      xhci: Fix use-after-free in xhci_free_virt_device

Mauricio Faria de Oliveira (2):
      partitions/aix: append null character to print data from disk
      partitions/aix: fix usage of uninitialized lv_info and lvname structu=
res

Michal Hocko (1):
      selinux: use GFP_NOWAIT in the AVC kmem_caches

Mike Christie (1):
      scsi: target: fix __transport_register_session locking

Nadav Amit (1):
      vmw_balloon: include asm/io.h

Nicholas Mc Guire (1):
      MIPS: Octeon: add missing of_node_put()

Nick Dyer (1):
      Input: atmel_mxt_ts - only use first T9 instance

Olga Kornievskaia (1):
      NFSv4.0 fix client reference leak in callback

Ondrej Mosnacek (1):
      crypto: vmx - Fix sleep-in-atomic bugs

Parav Pandit (1):
      RDMA/cma: Do not ignore net namespace for unbound cm_id

Paul Burton (2):
      MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
      MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Peter Chen (1):
      ethernet: ti: davinci_emac: add missing of_node_put after calling of_=
parse_phandle

Petr Machata (1):
      net: dcb: For wild-card lookups, use priority -1, not 0

Prateek Sood (2):
      locking/rwsem-xadd: Fix missed wakeup due to reordering of load
      locking/osq_lock: Fix osq_lock queue corruption

Ritesh Harjani (1):
      cfq: Give a chance for arming slice idle timer in case of group_idle

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Srinivas Pandruvada (1):
      ata: libahci: Correct setting of DEVSLP register

Surabhi Vishnoi (1):
      ath10k: disable bundle mgmt tx completion event support

Sven Eckelmann (1):
      ath10k: prevent active scans on potential unusable channels

Takashi Iwai (1):
      ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Tejun Heo (1):
      block,blkcg: use __GFP_NOWARN for best-effort allocations in blkcg

Vegard Nossum (2):
      kthread: Fix use-after-free if kthread fork fails
      kthread: fix boot hang (regression) on MIPS/OpenRISC

Wei Yongjun (1):
      mtd: ubi: wl: Fix error return code in ubi_wl_init()

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link

Yunlong Song (1):
      f2fs: do not set free of current section

Zumeng Chen (1):
      mfd: ti_am335x_tscadc: Fix struct clk memory leak


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluivXcACgkQONu9yGCS
aT4CShAAg8sEqe+2ioByvE4VJK1bU1Xkw/Xjt16ya2s4fFO60cwyVCngbtoU3lXV
S+/xOuAbd3fyqzyyISmKKnrYcc5lWY1K2lMNUIiih3c8c92ubPMeXFkuGArLOfYV
vbu29toaTb9ItyvqVDsMTt0p7mRdBSKKuFWtmjUwpLJlYPH5b1xqNNEbAJeGc/jB
oUoQKP94vg833euKx97RO1wkIXcDTgV/ehONGqnicVXON5FsTaIBrEcQlF7ioRE8
RQonXyUIXUT7sikZTckvnTwUNfqXd7V5p12MRa2H1qb5JhjgqHqVw2Y18rOzARWa
/7Kp5j7NS1XYoULbA2aGIAqst8IjjAMhjHN0P3TOXGYpvXAo//OC3SkBFvgjglhf
9/6xm1VLAMkExJyuHb8p2447yFTTBrCGWGhwxCJkdE4mRq1AWrRlfDrg2EJSgSRw
z+avAMAg7W6cBdTceOqFlSrMjEqUE7dXdybZjgFzpuEjJ/6gatRUgD8JH0alADbZ
r6BDa1oI9WjEYGSkddEm6/r8hCATfabTEmkpMJPIFViV3Odmns99JwlcLoNbaiPe
skuotLxzzwCegqK9yHyVOGT8J4PJTC0mnmLrzaksX90cGjXWzW8nfnRwxPNmyAYX
nZpzYYYLbKdhM8bg/6wAO7IE1h58PUflr517SOV1W98gj4JB1DQ=
=xSME
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
