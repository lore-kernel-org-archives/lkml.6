Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F53C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E437A206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E437A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeIJMFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:05:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:05:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9456CA8;
        Mon, 10 Sep 2018 07:13:12 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:13:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.69
Message-ID: <20180910071310.GA21564@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.69 kernel.

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

 Makefile                                        |    2=20
 arch/alpha/kernel/osf_sys.c                     |   51 ++++++------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    1=20
 arch/arm64/Kconfig                              |    1=20
 arch/powerpc/include/asm/fadump.h               |    3=20
 arch/powerpc/kernel/fadump.c                    |   91 +++++++++++++++++++=
---
 arch/powerpc/mm/mmu_context_iommu.c             |   17 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c       |   37 +++++++++
 arch/powerpc/platforms/pseries/ras.c            |    2=20
 arch/sparc/kernel/sys_sparc_32.c                |   22 +++--
 arch/sparc/kernel/sys_sparc_64.c                |   20 +++--
 arch/x86/kernel/kexec-bzimage64.c               |    2=20
 arch/x86/kvm/vmx.c                              |   26 ++++--
 arch/xtensa/include/asm/cacheasm.h              |   69 ++++++++++-------
 block/bfq-cgroup.c                              |    3=20
 block/blk-core.c                                |    7 +
 certs/system_keyring.c                          |    3=20
 crypto/asymmetric_keys/pkcs7_key_type.c         |    2=20
 drivers/block/zram/zram_drv.c                   |    7 +
 drivers/cpufreq/cpufreq_governor.c              |   12 ++-
 drivers/crypto/caam/caamalg_qi.c                |    6 -
 drivers/crypto/caam/caampkc.c                   |   20 ++---
 drivers/crypto/caam/jr.c                        |    3=20
 drivers/crypto/vmx/aes_cbc.c                    |   30 +++----
 drivers/crypto/vmx/aes_xts.c                    |   21 +++--
 drivers/extcon/extcon.c                         |    3=20
 drivers/gpu/drm/i915/i915_gem_userptr.c         |    3=20
 drivers/hv/channel.c                            |   40 ++++++----
 drivers/hv/channel_mgmt.c                       |    6 +
 drivers/iio/accel/sca3000.c                     |    1=20
 drivers/iio/frequency/ad9523.c                  |    4 -
 drivers/infiniband/sw/rxe/rxe_comp.c            |    1=20
 drivers/infiniband/ulp/srpt/ib_srpt.c           |    3=20
 drivers/iommu/dmar.c                            |    6 -
 drivers/iommu/intel-iommu.c                     |   18 ++++
 drivers/mailbox/mailbox-xgene-slimpro.c         |    6 -
 drivers/md/bcache/writeback.c                   |    4 -
 drivers/md/dm-cache-metadata.c                  |   13 ++-
 drivers/md/dm-crypt.c                           |   10 +-
 drivers/md/dm-integrity.c                       |    6 -
 drivers/md/dm-thin.c                            |    2=20
 drivers/media/i2c/tvp5150.c                     |    2=20
 drivers/mfd/hi655x-pmic.c                       |    2=20
 drivers/misc/cxl/main.c                         |    2=20
 drivers/misc/vmw_balloon.c                      |   67 ++++++++++------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c   |    2=20
 drivers/net/wireless/marvell/libertas/dev.h     |    1=20
 drivers/net/wireless/marvell/libertas/if_sdio.c |   30 ++++++-
 drivers/nvdimm/bus.c                            |    4 -
 drivers/pwm/pwm-tiehrpwm.c                      |   14 ---
 drivers/rtc/rtc-omap.c                          |   14 +--
 drivers/spi/spi-cadence.c                       |    2=20
 drivers/spi/spi-davinci.c                       |    2=20
 drivers/spi/spi-fsl-dspi.c                      |   24 +++---
 drivers/spi/spi-pxa2xx.c                        |    4 +
 drivers/tty/serial/serial_core.c                |   17 +++-
 drivers/video/fbdev/core/fbmem.c                |   38 ++++++++-
 fs/9p/xattr.c                                   |    6 +
 fs/nfs/blocklayout/dev.c                        |    2=20
 fs/nfs/callback_proc.c                          |   14 ++-
 fs/nfs/nfs4proc.c                               |    9 ++
 fs/nfs/pnfs_nfs.c                               |   16 +---
 fs/overlayfs/readdir.c                          |   19 ++++
 fs/quota/quota.c                                |    2=20
 fs/ubifs/journal.c                              |   21 ++++-
 fs/ubifs/lprops.c                               |    8 +-
 fs/ubifs/xattr.c                                |   24 ++++++
 fs/xattr.c                                      |    2=20
 include/linux/hyperv.h                          |    2=20
 include/linux/intel-iommu.h                     |    8 +-
 include/linux/pci.h                             |   12 +++
 include/linux/sunrpc/clnt.h                     |    1=20
 include/linux/verification.h                    |    6 +
 include/video/udlfb.h                           |    2=20
 kernel/livepatch/core.c                         |    6 +
 kernel/power/Kconfig                            |    1=20
 kernel/printk/printk_safe.c                     |    4 -
 kernel/sys.c                                    |   95 +++++++++++--------=
-----
 kernel/trace/blktrace.c                         |    4 +
 kernel/trace/trace.c                            |    4 -
 kernel/trace/trace_uprobe.c                     |    2=20
 kernel/user_namespace.c                         |   24 ++----
 kernel/utsname_sysctl.c                         |   41 ++++++----
 mm/memory.c                                     |    9 --
 mm/readahead.c                                  |   12 ++-
 net/9p/client.c                                 |    2=20
 net/9p/trans_fd.c                               |    7 +
 net/9p/trans_rdma.c                             |    3=20
 net/9p/trans_virtio.c                           |   13 +++
 net/9p/trans_xen.c                              |    3=20
 net/ieee802154/6lowpan/tx.c                     |   21 ++++-
 net/mac802154/tx.c                              |   15 +++
 net/sunrpc/clnt.c                               |   28 +++++--
 security/commoncap.c                            |    2=20
 tools/perf/util/auxtrace.c                      |    3=20
 95 files changed, 842 insertions(+), 420 deletions(-)

Adrian Hunter (1):
      perf auxtrace: Fix queue resize

Alexander Aring (2):
      net: 6lowpan: fix reserved space for single frames
      net: mac802154: tx: expand tailroom if necessary

Amir Goldstein (1):
      ovl: fix wrong use of impure dir cache in ovl_iterate()

Bart Van Assche (2):
      ib_srpt: Fix a use-after-free in srpt_close_ch()
      RDMA/rxe: Set wqe->status correctly if an unexpected response is rece=
ived

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling

Bill Baker (1):
      NFSv4 client live hangs after live data migration recovery

Chanwoo Choi (1):
      extcon: Release locking when sending the notification of connector st=
ate

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Christian Brauner (1):
      getxattr: use correct xattr length

Dan Carpenter (1):
      pnfs/blocklayout: off by one in bl_map_stripe()

Daniel Mack (1):
      libertas: fix suspend and resume for SDIO connected cards

Dexuan Cui (1):
      Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_resci=
nd()

Eddie.Horng (1):
      cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias=
()

Frederick Lawler (1):
      PCI: Add wrappers for dev_printk()

Greg Kroah-Hartman (1):
      Linux 4.14.69

Gustavo A. R. Silva (2):
      mailbox: xgene-slimpro: Fix potential NULL pointer dereference
      iio: sca3000: Fix missing return in switch

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow

Henry Willard (1):
      cpufreq: governor: Avoid accessing invalid governor_data

Horia Geant=C4=83 (3):
      crypto: caam - fix DMA mapping direction for RSA forms 2 & 3
      crypto: caam/jr - fix descriptor DMA unmapping
      crypto: caam/qi - fix error path in xts setkey

Hou Tao (1):
      dm thin: stop no_space_timeout worker when switching to write-mode

Ilya Dryomov (1):
      dm cache metadata: set dirty on all cache blocks after a crash

Jacob Pan (2):
      iommu/vt-d: Add definitions for PFSID
      iommu/vt-d: Fix dev iotlb pfsid use

James Morse (1):
      arm64: mm: always enable CONFIG_HOLES_IN_ZONE

Janek Kotas (1):
      spi: cadence: Change usleep_range() to udelay(), for atomic context

Jann Horn (2):
      sys: don't hold uts_sem while accessing userspace memory
      userns: move user access out of the mutex

Javier Martinez Canillas (1):
      media: Revert "[media] tvp5150: fix pad format frame height"

Jeremy Cline (1):
      fs/quota: Fix spectre gadget in do_quotactl

Johan Hovold (1):
      rtc: omap: fix potential crash on power off

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Kamalesh Babulal (1):
      livepatch: Validate module/old func name length

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Maciej S. Szmigiero (1):
      block, bfq: return nbytes and not zero from struct cftype .write() me=
thod

Mahesh Salgaonkar (1):
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Markus Stockhausen (1):
      readahead: stricter check for bdi io_pages

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size

Max Filippov (2):
      xtensa: limit offsets in __loop_cache_{all,page}
      xtensa: increase ranges in ___invalidate_{i,d}cache_all

Mika Westerberg (1):
      spi: pxa2xx: Add support for Intel Ice Lake

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Mikulas Patocka (4):
      dm integrity: change 'suspending' variable from bool to int
      dm crypt: don't decrease device limits
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: set optimal write delay

Ming Lei (1):
      block: really disable runtime-pm for blk-mq

Nadav Amit (4):
      vmw_balloon: fix inflation of 64-bit GFNs
      vmw_balloon: do not use 2MB without batching
      vmw_balloon: VMCI_DOORBELL_SET does not check status
      vmw_balloon: fix VMCI use when balloon built into kernel

Ondrej Mosnacek (1):
      crypto: vmx - Fix sleep-in-atomic bugs

Paolo Bonzini (1):
      KVM: VMX: fixes for vmentry_l1d_flush module parameter

Paul Mackerras (1):
      KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pa=
ges

Peter Kalauskas (1):
      drivers/block/zram/zram_drv.c: fix bug storing backing_dev

Peter Zijlstra (1):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition

Rafael David Tinoco (1):
      mfd: hi655x: Fix regmap area declared size for hi655x

Richard Weinberger (5):
      ubifs: Fix memory leak in lprobs self-check
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Check data node size before truncate
      ubifs: xattr: Don't operate on deleted inodes
      ubifs: Fix synced_i_size calculation for xattr inodes

Sergei Shtylyov (1):
      mmc: renesas_sdhi_internal_dmac: fix #define RST_RESERVED_BITS

Shan Hai (1):
      bcache: release dc->writeback_lock properly in bch_writeback_thread()

Steven Rostedt (VMware) (4):
      tracing: Do not call start/stop() functions when tracing_on does not =
change
      tracing/blktrace: Fix to allow setting same value
      printk/tracing: Do not trace printk_nmi_enter()
      uprobes: Use synchronize_rcu() not synchronize_sched()

Tomas Bortoli (3):
      9p: fix multiple NULL-pointer-dereferences
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before th=
e kfree()

Trond Myklebust (2):
      NFSv4: Fix locking in pnfs_generic_recover_commit_reqs
      NFSv4: Fix a sleep in atomic context in nfs4_callback_sequence()

Tycho Andersen (1):
      uart: fix race between uart_put_char() and uart_shutdown()

Vaibhav Jain (1):
      cxl: Fix wrong comparison in cxl_adapter_context_get()

Vignesh R (2):
      pwm: tiehrpwm: Don't use emulation mode bits to control PWM output
      pwm: tiehrpwm: Fix disabling of output of PWMs

Vishal Verma (1):
      libnvdimm: fix ars_status output length calculation

Yannik Sembritzki (2):
      Replace magic for trusting the secondary keyring with #define
      Fix kexec forbidding kernels signed with keys in the secondary keyrin=
g to boot

jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check

piaojun (1):
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr =
failed

xiao jin (1):
      block: blk_init_allocated_queue() set q->fq as NULL in the fail case

zhangyi (F) (1):
      PM / sleep: wakeup: Fix build error caused by missing SRCU support


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluWGYUACgkQONu9yGCS
aT6Qbg/+KM5vx2a/LMyFtK83D63Zxd1oyKLQsJ5Gw2d8EOdXiDibh2MidfsTF4ke
ArsfbSUa8BZqsi/fPxoYHXrQ/7nIsoORp44yXCVKdddACRt9C4mv5hFRw0TiAaxu
lEFv9ryeFGGhANutKc/EogxGFsKtyzFWNfkjL7fA2fuAtvJU2AumPE8+s0aQZJHQ
pJFjuuhtgADTGFeJBmK6MQDvku6VyhSielv+V8XVOcUC/n888DzYCIokNGrd8eO5
KGowMUxuyJEgUigqJgA6D+ud7MRC8cf1H7Zo01FaF01h+hQZ9J0jBUjAP4T/x0bO
c+V5hLo8MMmF1jgh2I7ahQ6erioLcA0U7sPDoX/ZNt5Mo5RxAJTyph4VG2XBzFy1
5XudXFbI2p4/7ipZfq997Sd8/TetGu+bvNO7dYzcmDaSjRJzT+WWAAnTT0XfiU8G
8N0hOB83kSjs+RBYKmh3iEJPDIi3zwAA5+1+iKJo3mTN7Imdo44QISNi6sTGsLzG
8ir+1LoOBdHiPsNZpDYmzMzkYJDmTjg5Cbz8oIRl1dbOaY/Az/tupraWtA1egBu2
TWwDyOw/YeIKknr6MCLadGWdneEILHd0wKaadRujSQ0ZYLdCr3ubun880K+7IzPQ
Bj5FhzxqQPuovPu6NCxLd6S+13x5K40CpLPsYQvAvlKtelKd/Mc=
=/bbk
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
