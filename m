Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE3C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54C4206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54C4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeIIOTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 10:19:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeIIOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 10:19:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1310FAA6;
        Sun,  9 Sep 2018 09:30:25 +0000 (UTC)
Date:   Sun, 9 Sep 2018 11:30:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.7
Message-ID: <20180909093023.GA8116@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.7 kernel.

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

 Makefile                                        |    2=20
 arch/alpha/kernel/osf_sys.c                     |   51 ++++-----
 arch/arm/boot/dts/am571x-idk.dts                |    4=20
 arch/arm/boot/dts/am572x-idk-common.dtsi        |    4=20
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |    7 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    1=20
 arch/arm64/Kconfig                              |    1=20
 arch/arm64/crypto/sm4-ce-glue.c                 |    2=20
 arch/powerpc/include/asm/fadump.h               |    3=20
 arch/powerpc/include/asm/nohash/pgtable.h       |    9 -
 arch/powerpc/include/asm/pkeys.h                |   11 -
 arch/powerpc/kernel/fadump.c                    |   91 +++++++++++++---
 arch/powerpc/kernel/process.c                   |    1=20
 arch/powerpc/kvm/book3s_hv.c                    |    1=20
 arch/powerpc/mm/mmu_context_book3s64.c          |    8 -
 arch/powerpc/mm/mmu_context_iommu.c             |   17 +--
 arch/powerpc/mm/pgtable-book3s64.c              |   17 +--
 arch/powerpc/mm/pkeys.c                         |  134 +++++++------------=
-----
 arch/powerpc/platforms/powernv/pci-ioda.c       |   37 ++++++
 arch/powerpc/platforms/pseries/ras.c            |    2=20
 arch/sparc/kernel/sys_sparc_32.c                |   22 ++-
 arch/sparc/kernel/sys_sparc_64.c                |   20 ++-
 arch/x86/crypto/aesni-intel_asm.S               |   66 +++++------
 arch/x86/kernel/kexec-bzimage64.c               |    2=20
 arch/x86/kvm/vmx.c                              |   26 ++--
 arch/xtensa/include/asm/cacheasm.h              |   69 +++++++-----
 block/bfq-cgroup.c                              |    3=20
 block/blk-core.c                                |   61 ++++++----
 block/blk-lib.c                                 |   10 +
 block/blk-sysfs.c                               |   15 ++
 block/blk.h                                     |    1=20
 certs/system_keyring.c                          |    3=20
 crypto/asymmetric_keys/pkcs7_key_type.c         |    2=20
 drivers/acpi/acpica/hwsleep.c                   |   11 -
 drivers/acpi/acpica/psloop.c                    |   17 +--
 drivers/block/zram/zram_drv.c                   |    7 +
 drivers/cpufreq/cpufreq_governor.c              |   12 +-
 drivers/cpuidle/governors/menu.c                |   47 ++++++--
 drivers/crypto/caam/caamalg_qi.c                |    6 -
 drivers/crypto/caam/caampkc.c                   |   20 +--
 drivers/crypto/caam/jr.c                        |    3=20
 drivers/crypto/vmx/aes_cbc.c                    |   30 ++---
 drivers/crypto/vmx/aes_xts.c                    |   21 ++-
 drivers/dma-buf/reservation.c                   |    6 -
 drivers/extcon/extcon.c                         |    3=20
 drivers/hv/channel.c                            |   40 ++++---
 drivers/hv/channel_mgmt.c                       |   10 +
 drivers/i2c/busses/i2c-designware-master.c      |    1=20
 drivers/i2c/busses/i2c-designware-platdrv.c     |    7 +
 drivers/iio/accel/sca3000.c                     |    1=20
 drivers/iio/frequency/ad9523.c                  |    4=20
 drivers/infiniband/hw/mlx5/main.c               |    2=20
 drivers/infiniband/hw/mlx5/qp.c                 |    6 -
 drivers/infiniband/sw/rxe/rxe_comp.c            |    1=20
 drivers/infiniband/ulp/srpt/ib_srpt.c           |   34 ++++--
 drivers/infiniband/ulp/srpt/ib_srpt.h           |    4=20
 drivers/iommu/dmar.c                            |    6 -
 drivers/iommu/intel-iommu.c                     |   18 +++
 drivers/iommu/ipmmu-vmsa.c                      |    7 +
 drivers/mailbox/mailbox-xgene-slimpro.c         |    6 -
 drivers/md/bcache/writeback.c                   |    4=20
 drivers/md/dm-cache-metadata.c                  |   13 +-
 drivers/md/dm-crypt.c                           |   10 -
 drivers/md/dm-integrity.c                       |    6 -
 drivers/md/dm-thin.c                            |    2=20
 drivers/md/dm-writecache.c                      |    2=20
 drivers/media/i2c/tvp5150.c                     |    2=20
 drivers/mfd/hi655x-pmic.c                       |    2=20
 drivers/misc/cxl/main.c                         |    2=20
 drivers/misc/ocxl/link.c                        |   24 ++--
 drivers/misc/vmw_balloon.c                      |   67 +++++++-----
 drivers/mmc/core/queue.c                        |   12 +-
 drivers/mmc/core/queue.h                        |    1=20
 drivers/mmc/host/renesas_sdhi_internal_dmac.c   |   10 +
 drivers/net/wireless/marvell/libertas/dev.h     |    1=20
 drivers/net/wireless/marvell/libertas/if_sdio.c |   30 ++++-
 drivers/nvdimm/bus.c                            |    4=20
 drivers/nvdimm/dimm_devs.c                      |   31 +++++
 drivers/nvdimm/namespace_devs.c                 |    6 -
 drivers/nvdimm/nd-core.h                        |    8 +
 drivers/nvdimm/region_devs.c                    |   24 ++++
 drivers/pwm/pwm-omap-dmtimer.c                  |    5=20
 drivers/pwm/pwm-tiehrpwm.c                      |   14 --
 drivers/rtc/rtc-omap.c                          |   18 +--
 drivers/spi/spi-cadence.c                       |    2=20
 drivers/spi/spi-davinci.c                       |    2=20
 drivers/spi/spi-fsl-dspi.c                      |   24 ++--
 drivers/spi/spi-pxa2xx.c                        |    4=20
 drivers/tty/serial/serial_core.c                |   17 ++-
 drivers/video/fbdev/core/fbmem.c                |   38 +++++-
 drivers/video/fbdev/udlfb.c                     |  105 ++++++++++--------
 fs/9p/xattr.c                                   |    6 -
 fs/lockd/clntlock.c                             |    2=20
 fs/lockd/clntproc.c                             |    2=20
 fs/lockd/svclock.c                              |   16 +-
 fs/lockd/svcsubs.c                              |    4=20
 fs/nfs/blocklayout/dev.c                        |    2=20
 fs/nfs/callback_proc.c                          |   14 +-
 fs/nfs/nfs4proc.c                               |    9 +
 fs/nfs/pnfs_nfs.c                               |   16 +-
 fs/nfsd/nfs4state.c                             |    2=20
 fs/overlayfs/readdir.c                          |   19 +++
 fs/quota/quota.c                                |    2=20
 fs/ubifs/dir.c                                  |    5=20
 fs/ubifs/journal.c                              |   21 +++
 fs/ubifs/lprops.c                               |    8 -
 fs/ubifs/xattr.c                                |   24 ++++
 fs/udf/super.c                                  |   31 +++--
 fs/xattr.c                                      |    2=20
 include/linux/blk-cgroup.h                      |   18 +++
 include/linux/hyperv.h                          |    2=20
 include/linux/intel-iommu.h                     |    8 -
 include/linux/lockd/lockd.h                     |    4=20
 include/linux/mm_types.h                        |    5=20
 include/linux/overflow.h                        |   31 +++++
 include/linux/sunrpc/clnt.h                     |    1=20
 include/linux/verification.h                    |    6 +
 include/uapi/linux/eventpoll.h                  |    8 -
 include/video/udlfb.h                           |    5=20
 kernel/livepatch/core.c                         |    6 +
 kernel/memremap.c                               |    1=20
 kernel/power/Kconfig                            |    1=20
 kernel/printk/printk_safe.c                     |    4=20
 kernel/rcu/tree_exp.h                           |    9 +
 kernel/sched/idle.c                             |    2=20
 kernel/sys.c                                    |   95 ++++++++---------
 kernel/trace/blktrace.c                         |    4=20
 kernel/trace/trace.c                            |    4=20
 kernel/trace/trace_uprobe.c                     |    2=20
 kernel/user_namespace.c                         |   24 +---
 kernel/utsname_sysctl.c                         |   41 ++++---
 mm/hmm.c                                        |    2=20
 mm/memory.c                                     |    9 -
 mm/readahead.c                                  |   12 +-
 net/9p/client.c                                 |    2=20
 net/9p/trans_fd.c                               |    7 +
 net/9p/trans_rdma.c                             |    3=20
 net/9p/trans_virtio.c                           |   13 ++
 net/9p/trans_xen.c                              |    3=20
 net/ieee802154/6lowpan/tx.c                     |   21 +++
 net/mac802154/tx.c                              |   15 ++
 net/sunrpc/clnt.c                               |   28 +++--
 scripts/kconfig/Makefile                        |    5=20
 security/apparmor/secid.c                       |    1=20
 security/commoncap.c                            |    2=20
 sound/ac97/bus.c                                |    4=20
 sound/ac97/snd_ac97_compat.c                    |   19 +++
 tools/perf/util/auxtrace.c                      |    3=20
 148 files changed, 1373 insertions(+), 765 deletions(-)

Adrian Hunter (2):
      mmc: block: Fix unsupported parallel dispatch of requests
      perf auxtrace: Fix queue resize

Alexander Aring (2):
      net: 6lowpan: fix reserved space for single frames
      net: mac802154: tx: expand tailroom if necessary

Amir Goldstein (2):
      ovl: fix wrong use of impure dir cache in ovl_iterate()
      nfsd: fix leaked file lock with nfs exported overlayfs

Ard Biesheuvel (1):
      crypto: arm64/sm4-ce - check for the right CPU feature bit

Bart Van Assche (9):
      blkcg: Introduce blkg_root_lookup()
      block: Introduce blk_exit_queue()
      block: Ensure that a request queue is dissociated from the cgroup con=
troller
      IB/srpt: Fix srpt_cm_req_recv() error path (1/2)
      IB/srpt: Fix srpt_cm_req_recv() error path (2/2)
      IB/srpt: Support HCAs with more than two ports
      ib_srpt: Fix a use-after-free in srpt_close_ch()
      ib_srpt: Fix a use-after-free in __srpt_close_all_ch()
      RDMA/rxe: Set wqe->status correctly if an unexpected response is rece=
ived

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling

Bill Baker (1):
      NFSv4 client live hangs after live data migration recovery

Boqun Feng (1):
      rcu: Make expedited GPs handle CPU 0 being offline

Chanwoo Choi (1):
      extcon: Release locking when sending the notification of connector st=
ate

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Christian Brauner (1):
      getxattr: use correct xattr length

Christophe Leroy (1):
      powerpc/nohash: fix pte_access_permitted()

Dan Carpenter (1):
      pnfs/blocklayout: off by one in bl_map_stripe()

Dan Williams (1):
      mm, dev_pagemap: Do not clear ->mapping on final put

Daniel Mack (1):
      libertas: fix suspend and resume for SDIO connected cards

Dave Watson (1):
      crypto: aesni - Use unaligned loads from gcm_context_data

David Rivshin (1):
      pwm: omap-dmtimer: Return -EPROBE_DEFER if no dmtimer platform data

Dexuan Cui (2):
      Drivers: hv: vmbus: Fix the offer_in_progress in vmbus_process_offer()
      Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_resci=
nd()

Dmitry Osipenko (1):
      iommu/ipmmu-vmsa: Don't register as BUS IOMMU if machine doesn't have=
 IPMMU-VMSA

Eddie.Horng (1):
      cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias=
()

Erik Schmauss (1):
      ACPICA: AML Parser: skip opcodes that open a scope upon parse failure

Frederic Barrat (1):
      ocxl: Fix page fault handler in case of fault on dying process

Greg Kroah-Hartman (2):
      eventpoll.h: wrap casts in () properly
      Linux 4.18.7

Gustavo A. R. Silva (2):
      mailbox: xgene-slimpro: Fix potential NULL pointer dereference
      iio: sca3000: Fix missing return in switch

Hans de Goede (1):
      i2c: designware: Re-init controllers with pm_disabled set on resume

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

Jan Kara (1):
      udf: Fix mounting of Win7 created UDF filesystems

Janek Kotas (1):
      spi: cadence: Change usleep_range() to udelay(), for atomic context

Jann Horn (2):
      sys: don't hold uts_sem while accessing userspace memory
      userns: move user access out of the mutex

Jason Gunthorpe (2):
      IB/mlx5: Fix leaking stack memory to userspace
      overflow.h: Add arithmetic shift helper

Javier Martinez Canillas (1):
      media: Revert "[media] tvp5150: fix pad format frame height"

Jeremy Cline (1):
      fs/quota: Fix spectre gadget in do_quotactl

Johan Hovold (2):
      rtc: omap: fix resource leak in registration error path
      rtc: omap: fix potential crash on power off

John Johansen (1):
      apparmor: fix bad debug check in apparmor_secid_to_secctx()

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Kamalesh Babulal (1):
      livepatch: Validate module/old func name length

Keith Busch (1):
      libnvdimm: Use max contiguous area for namespace size

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Leon Romanovsky (1):
      RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq

Lihua Yao (3):
      ALSA: ac97: fix device initialization in the compat layer
      ALSA: ac97: fix check of pm_runtime_get_sync failure
      ALSA: ac97: fix unbalanced pm_runtime_enable

Luke Dashjr (1):
      powerpc64/ftrace: Include ftrace.h needed for enable/disable calls

Maciej S. Szmigiero (1):
      block, bfq: return nbytes and not zero from struct cftype .write() me=
thod

Mahesh Salgaonkar (1):
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Markus Stockhausen (1):
      readahead: stricter check for bdi io_pages

Masahiro Yamada (1):
      kconfig: fix "Can't open ..." in parallel build

Max Filippov (2):
      xtensa: limit offsets in __loop_cache_{all,page}
      xtensa: increase ranges in ___invalidate_{i,d}cache_all

Michel D=C3=A4nzer (1):
      dma-buf: Move BUG_ON from _add_shared_fence to _add_shared_inplace

Mika Westerberg (1):
      spi: pxa2xx: Add support for Intel Ice Lake

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Mikulas Patocka (12):
      block: fix infinite loop if the device loses discard capability
      dm integrity: change 'suspending' variable from bool to int
      dm crypt: don't decrease device limits
      dm writecache: fix a crash due to reading past end of dirty_bitmap
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: fix semaphore value leak
      udlfb: fix display corruption of the last line
      udlfb: don't switch if we are switching to the same videomode
      udlfb: set optimal write delay
      udlfb: make a local copy of fb_ops
      udlfb: handle allocation failure
      udlfb: set line_length in dlfb_ops_set_par

Ming Lei (1):
      block: really disable runtime-pm for blk-mq

Nadav Amit (4):
      vmw_balloon: fix inflation of 64-bit GFNs
      vmw_balloon: do not use 2MB without batching
      vmw_balloon: VMCI_DOORBELL_SET does not check status
      vmw_balloon: fix VMCI use when balloon built into kernel

Nicholas Piggin (1):
      powerpc/64s: Fix page table fragment refcount race vs speculative ref=
erences

Ondrej Mosnacek (1):
      crypto: vmx - Fix sleep-in-atomic bugs

Paolo Bonzini (1):
      KVM: VMX: fixes for vmentry_l1d_flush module parameter

Parav Pandit (1):
      IB/mlx5: Honor cnt_set_id_valid flag instead of set_id

Paul Mackerras (1):
      KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pa=
ges

Peter Kalauskas (1):
      drivers/block/zram/zram_drv.c: fix bug storing backing_dev

Peter Zijlstra (1):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition

Rafael David Tinoco (1):
      mfd: hi655x: Fix regmap area declared size for hi655x

Rafael J. Wysocki (4):
      ACPICA: Clear status of all events when entering sleep states
      sched: idle: Avoid retaining the tick when it has been stopped
      cpuidle: menu: Handle stopped tick more aggressively
      cpuidle: menu: Retain tick when shallow state is selected

Ram Pai (6):
      powerpc/pkeys: Give all threads control of their key permissions
      powerpc/pkeys: Deny read/write/execute by default
      powerpc/pkeys: key allocation/deallocation must not change pkey regis=
ters
      powerpc/pkeys: Save the pkey registers before fork
      powerpc/pkeys: Fix calculation of total pkeys.
      powerpc/pkeys: Preallocate execute-only key

Richard Weinberger (6):
      ubifs: Fix memory leak in lprobs self-check
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Check data node size before truncate
      ubifs: xattr: Don't operate on deleted inodes
      ubifs: Fix directory size calculation for symlinks
      ubifs: Fix synced_i_size calculation for xattr inodes

Roger Quadros (1):
      ARM: dts: am57xx-idk: Enable dual role for USB2 port

Sergei Shtylyov (2):
      mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts
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


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluU6C8ACgkQONu9yGCS
aT7kaA/9EA+Tnq+tYLrogAPv1q0bn3nDx3Hy6k0C46jfgWZXdKb8Aq/17mIWrnPz
oHfEtRe/J52Nk9vvYHSIo8X456ABvd3pFzTpJ6oTzBy+0gqOIHWZ/XzHqxOQ3i5l
yZIXRYxFd5Zv3V3RZNwoo0CRjJ2ZT5Vs6NnAjdnYkmvWUBvhBaAy7rz9wG6Xltfe
Ou8+iNHshHP5wl41aTmLCFxDr+lnHzvk+L43qs20u3OGozkaNP+nECFoEmiPRiIe
RIy521WGY37poVzqpFcc82UqgeTjbvisn/eVAOXa6/OeV63rvw9A0zzKNSd5mgSi
/sgVRh2HtaI1aH2QR6+GRvD5PbyNm3Msk8swE7W8UmU305SoYhc5cJWYf5YxBYJl
s5+UXQnuugu2TjHc9rBvqU7oy9Kw2mFheXJjBnK3tmhcS1m6Yfx4ptN7xpYPmydM
tfi4XHMR+2ESTiVc9ilQVKT5jFqGY/2YlnF0Gl0BWTFRihCrg2DM8C8JNsjFHzTC
TCghL5m9g5pJLLmyoBMZ/eVfJbIDhthRlasdejNoIiVABqjCYEabmWz+UMYo4jQ9
xClKQ0iIgvwGvwMn5aP9NpsFX0qnUoDGetP+87wdL0AX/nYSonWN5IK8gC1h6AJS
xr0gFrRqJHTst7rFOf3YJsxHADsNlvARo56NM93KH2agxFqAERo=
=koxo
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
