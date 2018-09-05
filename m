Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1752C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIESy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:54:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIESy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:54:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80E141178;
        Wed,  5 Sep 2018 14:24:31 +0000 (UTC)
Date:   Wed, 5 Sep 2018 16:24:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.6
Message-ID: <20180905142428.GA9234@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.6 kernel.

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

 Makefile                                       |    6 -
 arch/Kconfig                                   |    3=20
 arch/arm/net/bpf_jit_32.c                      |    2=20
 arch/arm/probes/kprobes/core.c                 |    4=20
 arch/arm/probes/kprobes/test-core.c            |    1=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       |    2=20
 arch/arm64/include/asm/cache.h                 |    4=20
 arch/arm64/include/asm/cpucaps.h               |    3=20
 arch/arm64/kernel/cpu_errata.c                 |   23 +++
 arch/arm64/kernel/cpufeature.c                 |    2=20
 arch/arm64/kernel/probes/kprobes.c             |    2=20
 arch/arm64/mm/init.c                           |    6 -
 arch/mips/Makefile                             |   12 --
 arch/mips/include/asm/processor.h              |   15 ++
 arch/mips/kernel/ptrace.c                      |    2=20
 arch/mips/kernel/ptrace32.c                    |    2=20
 arch/mips/lib/memset.S                         |    3=20
 arch/mips/lib/multi3.c                         |    6 -
 arch/s390/include/asm/qdio.h                   |    1=20
 arch/s390/lib/mem.S                            |   16 +-
 arch/s390/mm/fault.c                           |    2=20
 arch/s390/mm/page-states.c                     |    2=20
 arch/s390/net/bpf_jit_comp.c                   |    2=20
 arch/s390/numa/numa.c                          |   16 --
 arch/s390/pci/pci.c                            |    2=20
 arch/s390/purgatory/Makefile                   |    7 -
 arch/x86/Kconfig                               |    1=20
 arch/x86/Makefile                              |   11 +
 arch/x86/entry/vdso/Makefile                   |    6 -
 arch/x86/events/core.c                         |    2=20
 arch/x86/include/asm/irqflags.h                |    3=20
 arch/x86/include/asm/processor.h               |    6 -
 arch/x86/include/asm/stacktrace.h              |    2=20
 arch/x86/include/asm/tlbflush.h                |   40 ++++++
 arch/x86/include/asm/vgtod.h                   |    2=20
 arch/x86/kernel/cpu/bugs.c                     |   50 +++++++-
 arch/x86/kernel/cpu/common.c                   |    1=20
 arch/x86/kernel/cpu/intel.c                    |    3=20
 arch/x86/kernel/dumpstack.c                    |   25 +++-
 arch/x86/kernel/early-quirks.c                 |   18 +++
 arch/x86/kernel/process_64.c                   |    1=20
 arch/x86/kvm/hyperv.c                          |   27 +++-
 arch/x86/kvm/hyperv.h                          |    2=20
 arch/x86/kvm/svm.c                             |    8 -
 arch/x86/kvm/x86.c                             |   15 +-
 arch/x86/lib/usercopy.c                        |    5=20
 arch/x86/mm/fault.c                            |    2=20
 arch/x86/mm/init.c                             |    4=20
 arch/x86/mm/mmap.c                             |    2=20
 arch/x86/mm/tlb.c                              |    7 +
 drivers/ata/libata-core.c                      |    3=20
 drivers/ata/libata.h                           |    2=20
 drivers/base/power/clock_ops.c                 |    2=20
 drivers/cdrom/cdrom.c                          |    2=20
 drivers/char/tpm/tpm-interface.c               |   53 +++++++--
 drivers/char/tpm/tpm.h                         |   12 +-
 drivers/char/tpm/tpm2-space.c                  |   16 +-
 drivers/char/tpm/tpm_crb.c                     |  101 ++++-------------
 drivers/clk/clk-npcm7xx.c                      |    4=20
 drivers/clk/rockchip/clk-rk3399.c              |    2=20
 drivers/gpu/drm/udl/udl_drv.h                  |    2=20
 drivers/gpu/drm/udl/udl_fb.c                   |   17 +-
 drivers/gpu/drm/udl/udl_main.c                 |   35 +++--
 drivers/gpu/drm/udl/udl_transfer.c             |   39 +++---
 drivers/hwmon/k10temp.c                        |    2=20
 drivers/hwmon/nct6775.c                        |    2=20
 drivers/iommu/arm-smmu.c                       |   16 +-
 drivers/misc/mei/main.c                        |    1=20
 drivers/mtd/nand/raw/fsmc_nand.c               |    2=20
 drivers/mtd/nand/raw/marvell_nand.c            |   73 ++++++++++--
 drivers/mtd/nand/raw/nand_hynix.c              |   10 +
 drivers/mtd/nand/raw/qcom_nandc.c              |   53 ++++++++-
 drivers/net/wireless/broadcom/b43/leds.c       |    2=20
 drivers/net/wireless/broadcom/b43legacy/leds.c |    2=20
 drivers/nvme/host/pci.c                        |    8 +
 drivers/pinctrl/freescale/pinctrl-imx1-core.c  |    2=20
 drivers/platform/x86/ideapad-laptop.c          |    4=20
 drivers/platform/x86/wmi.c                     |    9 -
 drivers/power/supply/generic-adc-battery.c     |   25 ++--
 drivers/regulator/arizona-ldo1.c               |   27 ++++
 drivers/s390/cio/qdio_main.c                   |    5=20
 drivers/scsi/libsas/sas_ata.c                  |   40 ++++--
 drivers/scsi/libsas/sas_discover.c             |    2=20
 drivers/scsi/mpt3sas/mpt3sas_base.c            |    1=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c           |    2=20
 drivers/scsi/mpt3sas/mpt3sas_transport.c       |    5=20
 drivers/scsi/qla2xxx/qla_init.c                |    2=20
 drivers/scsi/qla2xxx/qla_iocb.c                |    1=20
 drivers/scsi/scsi_sysfs.c                      |   20 +++
 drivers/soc/qcom/rmtfs_mem.c                   |    3=20
 drivers/target/iscsi/iscsi_target_login.c      |   35 +++--
 fs/btrfs/disk-io.c                             |   10 +
 fs/btrfs/extent-tree.c                         |    2=20
 fs/btrfs/inode.c                               |   26 ----
 fs/btrfs/send.c                                |  146 ++++++++++++++++++++=
+++--
 fs/btrfs/super.c                               |    1=20
 fs/btrfs/tree-log.c                            |   66 +++++++++++
 fs/cifs/cifs_debug.c                           |   30 +++--
 fs/cifs/cifsfs.c                               |   18 +--
 fs/cifs/cifsglob.h                             |    1=20
 fs/cifs/inode.c                                |    2=20
 fs/cifs/link.c                                 |    4=20
 fs/cifs/sess.c                                 |    6 +
 fs/cifs/smb2inode.c                            |    6 -
 fs/cifs/smb2ops.c                              |   72 ++++++++++--
 fs/cifs/smb2pdu.c                              |    8 +
 fs/cifs/smb2pdu.h                              |   11 +
 fs/cifs/smb2proto.h                            |    1=20
 fs/cifs/smb2transport.c                        |    5=20
 fs/ext4/balloc.c                               |    6 -
 fs/ext4/ialloc.c                               |    6 -
 fs/ext4/namei.c                                |    1=20
 fs/ext4/super.c                                |   22 +--
 fs/ext4/sysfs.c                                |   13 +-
 fs/ext4/xattr.c                                |    2=20
 fs/fuse/dev.c                                  |   39 +++++-
 fs/fuse/dir.c                                  |   10 +
 fs/fuse/file.c                                 |    1=20
 fs/fuse/fuse_i.h                               |    5=20
 fs/fuse/inode.c                                |   37 +++---
 fs/sysfs/file.c                                |   44 +++++++
 include/drm/i915_drm.h                         |    4=20
 include/linux/libata.h                         |    2=20
 include/linux/printk.h                         |    4=20
 include/linux/sysfs.h                          |   14 ++
 include/linux/tpm.h                            |    2=20
 include/scsi/libsas.h                          |    2=20
 kernel/kprobes.c                               |   38 +++---
 kernel/printk/internal.h                       |    9 +
 kernel/printk/printk.c                         |   57 +++++----
 kernel/printk/printk_safe.c                    |   58 ++++++---
 kernel/stop_machine.c                          |   43 ++++---
 kernel/trace/trace.c                           |    4=20
 kernel/watchdog.c                              |    4=20
 kernel/watchdog_hld.c                          |    2=20
 kernel/workqueue.c                             |    2=20
 lib/nmi_backtrace.c                            |    3=20
 lib/vsprintf.c                                 |    1=20
 mm/memory.c                                    |   24 +++-
 net/sunrpc/xprtrdma/verbs.c                    |    5=20
 scripts/kernel-doc                             |   20 +--
 sound/soc/codecs/wm_adsp.c                     |    8 +
 sound/soc/sirf/sirf-usp.c                      |    7 -
 sound/soc/soc-pcm.c                            |    8 +
 sound/soc/zte/zx-tdm.c                         |    4=20
 tools/perf/arch/s390/util/kvm-stat.c           |    2=20
 virt/kvm/arm/arch_timer.c                      |   15 +-
 virt/kvm/arm/mmu.c                             |   42 +++++--
 148 files changed, 1439 insertions(+), 579 deletions(-)

Abhishek Sahu (1):
      mtd: rawnand: qcom: wait for desc completion in all BAM channels

Ajit Pandey (1):
      ASoC: wm_adsp: Correct DSP pointer for preloader control

Alberto Panizzo (1):
      clk: rockchip: fix clk_i2sout parent selection bits on rk3399

Alexander Usyskin (1):
      mei: don't update offset in write

Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()

Andy Lutomirski (2):
      x86/vdso: Fix vDSO build if a retpoline is emitted
      x86/nmi: Fix NMI uaccess race against CR3 switching

Arnd Bergmann (1):
      ext4: sysfs: print ext4_super_block fields as little-endian

Aurelien Aptel (1):
      CIFS: fix uninitialized ptr deref in smb2 signing

Bart Van Assche (4):
      lib/vsprintf: Do not handle %pO[^F] as %px
      scsi: mpt3sas: Fix _transport_smp_handler() error path
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
      scsi: core: Avoid that SCSI device removal through sysfs triggers a d=
eadlock

Ben Hutchings (2):
      scripts/kernel-doc: Escape all literal braces in regexes
      x86: Allow generating user-space headers without a compiler

Boris Brezillon (2):
      mtd: rawnand: hynix: Use ->exec_op() in hynix_nand_reg_write_op()
      mtd: rawnand: fsmc: Stop using chip->read_buf()

Charles Keepax (1):
      regulator: arizona-ldo1: Use correct device to get enable GPIO

Christoffer Dall (2):
      KVM: arm/arm64: Fix potential loss of ptimer interrupts
      KVM: arm/arm64: Fix lost IRQs from emulated physcial timer when block=
ed

Chuck Lever (1):
      xprtrdma: Fix disconnect regression

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Dan Carpenter (2):
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()
      PM / clk: signedness bug in of_pm_clk_add_clks()

Daniel Borkmann (1):
      bpf, arm32: fix stack var offset in jit

Daniel Mack (1):
      mtd: rawnand: marvell: add suspend and resume hooks

Eric Sandeen (1):
      ext4: reset error code in ext4_find_entry in fallback

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes

Filipe Manana (3):
      Btrfs: fix mount failure after fsync due to hard link recreation
      Btrfs: fix send failure when root has deleted files still open
      Btrfs: send, fix incorrect file layout after hole punching beyond eof

Gerald Schaefer (1):
      s390/mm: fix addressing exception after suspend/resume

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Greg Kroah-Hartman (1):
      Linux 4.18.6

Gustavo A. R. Silva (3):
      ASoC: sirf: Fix potential NULL pointer dereference
      hwmon: (nct6775) Fix potential Spectre v1
      clk: npcm7xx: fix memory allocation

H. Nikolaus Schaller (2):
      power: generic-adc-battery: fix out-of-bounds write when copying chan=
nel properties
      power: generic-adc-battery: check for duplicate properties copied fro=
m iio channels

Himanshu Madhani (1):
      scsi: qla2xxx: Fix stalled relogin

Huacai Chen (1):
      MIPS: Change definition of cpu_relax() for Loongson-3

Huibin Hong (1):
      arm64: dts: rockchip: corrected uart1 clock-names for rk3328

Jann Horn (2):
      x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()
      x86/dumpstack: Don't dump kernel memory based on usermode RIP

Jason Yan (1):
      scsi: libsas: dynamically allocate and free ata host

Jerome Brunet (1):
      ASoC: dpcm: don't merge format from invalid codec dai

Johan Hovold (1):
      soc: qcom: rmtfs-mem: fix memleak in probe error paths

Josef Bacik (2):
      btrfs: don't leak ret from do_chunk_alloc
      Btrfs: fix btrfs_write_inode vs delayed iput deadlock

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Kees Cook (1):
      platform/x86: wmi: Do not mix pages and kmalloc

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Maciej W. Rozycki (1):
      MIPS: Correct the 64-bit DSP accumulator register size

Martin Schwidefsky (3):
      s390/lib: use expoline for all bcr instructions
      s390: fix br_r1_trampoline for machines without exrl
      s390/numa: move initial setup of node_to_cpumask_map

Masami Hiramatsu (5):
      kprobes/arm64: Fix %p uses in error messages
      kprobes: Show blacklist addresses as same as kallsyms does
      kprobes: Replace %p with other pointer types
      kprobes/arm: Fix %p uses in error messages
      kprobes: Make list and blacklist root user read only

Matt Redfearn (1):
      MIPS: memset.S: Fix byte_fixup for MIPSr6

Michael Buesch (2):
      b43legacy/leds: Ensure NUL-termination of LED name string
      b43/leds: Ensure NUL-termination of LED name string

Michael Larabel (1):
      hwmon: (k10temp) 27C Offset needed for Threadripper2

Michal Wnukowski (1):
      nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

Mike Christie (1):
      iscsi target: fix session creation failure handling

Miklos Szeredi (5):
      fuse: fix initial parallel dirops
      fuse: fix double request_end()
      fuse: fix unlocked access to processing queue
      fuse: umount should wait for all requests
      fuse: Fix oops at process_init_reply()

Mikulas Patocka (4):
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory
      udl-kms: avoid division

Nicholas Mc Guire (1):
      cifs: check kmalloc before use

Nicholas Piggin (1):
      mm: move tlb_table_flush to tlb_flush_mmu_free

Nick Desaulniers (1):
      x86/irqflags: Mark native_restore_fl extern inline

Paolo Bonzini (1):
      KVM: x86: ensure all MSRs can always be KVM_GET/SET_MSR'd

Paul Burton (2):
      MIPS: Always use -march=3D<arch>, not -<arch> shortcuts
      MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

Paulo Zanoni (1):
      x86/gpu: reserve ICL's graphics stolen memory

Peter Zijlstra (2):
      stop_machine: Reflow cpu_stop_queue_two_works()
      mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE

Petr Mladek (3):
      printk: Split the code for storing a message into the log buffer
      printk: Create helper function to queue deferred console handling
      printk/nmi: Prevent deadlock when accessing the main log buffer in NMI

Philipp Rudo (2):
      s390/purgatory: Fix crash with expoline enabled
      s390/purgatory: Add missing FORCE to Makefile targets

Prasad Sodagudi (1):
      stop_machine: Atomically queue and wake stopper threads

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PMD entry if no change
      KVM: arm/arm64: Skip updating PTE entry if no change

Rian Hunter (1):
      x86/process: Re-export start_thread()

Ricardo Schwarzmeier (1):
      tpm: Return the actual size when receiving an unsupported command

Ronnie Sahlberg (2):
      cifs: add missing support for ACLs in SMB 3.11
      cifs: use a refcount to protect open/closing the cached file handle

Samuel Neves (1):
      x86/vdso: Fix lsl operand order

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix calltrace observed while running IO & reset

Steve French (5):
      cifs: add missing debug entries for kconfig options
      smb3: enumerating snapshots was leaving part of the data off end
      smb3: Do not send SMB3 SET_INFO if nothing changed
      smb3: don't request leases in symlink creation and query
      smb3: fill in statfs fsid and correct namelen

Suzuki K Poulose (2):
      arm64: Fix mismatched cache line size detection
      arm64: Handle mismatched cache type

Takashi Iwai (2):
      platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
      ASoC: zte: Fix incorrect PCM format bit usages

Theodore Ts'o (1):
      ext4: check for NUL characters in extended attribute's name

Thomas Gleixner (1):
      KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host() with interrupts di=
sabled

Thomas Richter (1):
      perf kvm: Fix subcommands on s390

Tomas Winkler (1):
      tpm: separate cmd_ready/go_idle from runtime_pm

Valdis Kletnieks (1):
      PATCH scripts/kernel-doc

Vincent Whitchurch (1):
      watchdog: Mark watchdog touch functions as notrace

Vivek Gautam (1):
      iommu/arm-smmu: Error out only if not enough context interrupts

Vlastimil Babka (3):
      x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
      x86/speculation/l1tf: Fix off-by-one error when warning that system h=
as too much RAM
      x86/speculation/l1tf: Suggest what to do on systems with too much RAM

Wang Shilong (2):
      ext4: use ext4_warning() for sb_getblk failure
      ext4: fix race when setting the bitmap corrupted flag


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluP5xwACgkQONu9yGCS
aT5F2BAAibwPrJkTPrZEKJEf0sY9TDFsu+xSqCleEn1Aq8luXdubl3Jl5L+KkKt4
aqM+wL6TlAlUHU4Ew9RT13EUkxPM7bPiz/Q4dd50Y6WFRNnOIFvhOmZfGd7c+o32
09nUZc7AFi2FNbVbAoDkklGtQ/D1wkxl31EfttViS7mnL0GKIyRfi6hF/oX9/Vol
nwkitrN/byXPHX2QOEtt9gQ7dDxSBNpRycvABsmOvlrI/f70DMVON/A2HRIrawt2
EcEY7Mtcg5tbEA2Oa3BMK5/R9PuoG1yKROHIg/UqsZcQkWgoPjJaq8N2q5GfU7IU
TRPptJrKvAXZ0/LbkeJLUaKwBpl5vtGsw2VyWn1qXmrWFhxH8ya4tMVQh5c8oKqJ
hMXh3iS07AjT+f4XRvuzoL9LH6YmXuh/rcV48Pf+Q09CEmg6kU1aybaak3Cn8Frl
zhQEJJa1WVpIwz/F4DRLW9YWzyW0fFBENghS1ItfauCoyWUqivUl3S9DFRu2emHA
E9oy2ePxVYlX47ZNwcU+7AAfoFYVuDQIEpimghMtAPuxDWOy1stqa4XH3kt1zMxC
uy7LJe7/hHFtY1KwARtWg6QYAKu31AFcrPp8V5fRPAQq4w8BInemo+CKTU6LycJm
Nap4pImWeJBMB+VJ4v/mBnJMPkV7nTyf0L2KyNmuqgM1IPq8i+Q=
=sRvQ
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
