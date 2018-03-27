Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0retyxnmATt8GsdHNxpXLmmfJJi2wG+22OitwlHMUE5fxGb4z9YzU5k8CNCECnmUgKbNF
ARC-Seal: i=1; a=rsa-sha256; t=1522168484; cv=none;
        d=google.com; s=arc-20160816;
        b=wCbwcHaAFm0kee9KI3CFdTHGQePCh2S0a4cJ+SW+lUSAJHW/GOmb3IAmcZfMT9qxnT
         FjA7xKSq/msg0+9BzzD5PRio7IHlaanenv79PX/htVGEHlKxbx2yyhtTicHI2FLb+DBV
         l+LnCzEV4b6V96qA5ruviS619LfUAu1QobRSt4zFz8V5MLmtJsqRi9442zvP/P/pbN8R
         81FylLF0L/ONEqE5gqmQTsdAEh05L72Sg1otRuWntos1G//ASOsgqk1B+UWB/WFphiEM
         mdW/mJetnbZQELUHrz2YlCDn3NdRN2Y9x6Mc6ognExH8B8H/vkHtYTT2jRUSLzzRN7Th
         lhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tmtFU8gM1hNB7Ok6NvdrF64VLYeMMa4i42fbxOkBh6s=;
        b=c1st1Bm4xy2DJ+lE9MxvW1uBQ/yAAhwk8c9fTIqYLFxCsUmhM+Wz7YebZk/lqRtx2D
         QB93Vhs2OHrgs72QtM8itQZxejXdc+p3dIZMw2SLvqsArNixaau+yxzp2TloGPtTjh4s
         rXMQweqgYlSpPRbH2ZEu9quBxKkXpX59rUVj+z+0q0TloZcmD8Rz78Rfe+BtZwMTComc
         Sp+9DLltqYeu+WNKhMcedEn11DHJ4wQrOQqH1sP2J6GPHXl4KWjLLkF0sUiab76HEltZ
         A/KRPMZDAOk/tUZCoFRn+Ot5Z97v6Fd6pochRASlv3+HragufcZ8BdCEpRuEQyGeSWHj
         77tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 000/101] 4.14.31-stable review
Date: Tue, 27 Mar 2018 18:26:32 +0200
Message-Id: <20180327162749.993880276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.31-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.31-rc1
X-KernelTest-Deadline: 2018-03-29T16:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109340773797446?=
X-GMAIL-MSGID: =?utf-8?q?1596109340773797446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.31 release.
There are 101 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 29 16:27:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.31-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.31-rc1

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: increase number of passes

Chenbo Feng <fengc@google.com>
    bpf: skip unnecessary capability check

Daniel Borkmann <daniel@iogearbox.net>
    kbuild: disable clang's default use of -fmerge-all-constants

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Rename 'si_pkey' to 'siginfo_pkey'

Lu Baolu <baolu.lu@linux.intel.com>
    usb: xhci: Fix potential memory leak in xhci_disable_slot()

Lu Baolu <baolu.lu@linux.intel.com>
    usb: xhci: Disable slot even when virt-dev is null

Nadav Amit <namit@vmware.com>
    staging: lustre: ptlrpc: kfree used instead of kvfree

Liam Mark <lmark@codeaurora.org>
    staging: android: ion: Zero CMA allocated memory

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()

Linus Walleij <linus.walleij@linaro.org>
    iio: ABI: Fix name of timestamp sysfs file

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers

Dan Carpenter <dan.carpenter@oracle.com>
    perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

Song Liu <songliubraving@fb.com>
    perf/core: Fix ctx_event_type in ctx_resched()

Ilya Pronin <ipronin@twitter.com>
    perf stat: Fix CVS output format for non-supported counters

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix Skylake UPI event format

Chris Wilson <chris@chris-wilson.co.uk>
    drm/syncobj: Stop reusing the same struct file for all syncobj -> fd

H.J. Lu <hjl.tools@gmail.com>
    x86/boot/64: Verify alignment of the LOAD segment

H.J. Lu <hjl.tools@gmail.com>
    x86/build/64: Force the linker to use 2MB page size

Linus Torvalds <torvalds@linux-foundation.org>
    kvm/x86: fix icebp instruction handling

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Protect posix clock array access against speculation

Waiman Long <longman@redhat.com>
    x86/efi: Free efi_pgd with free_pages()

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    x86/vsyscall/64: Use proper accessor to update P4D entry

Andy Lutomirski <luto@kernel.org>
    selftests/x86/ptrace_syscall: Fix for yet more glibc interference

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Don't use IST entry for #BP stack

Linus Torvalds <torvalds@linux-foundation.org>
    tty: vt: fix up tabstops properly

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix use after free in cc770_tx_interrupt()

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix queue stall & dropped RTR reply

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack

Marek Vasut <marex@denx.de>
    can: ifi: Check core revision upon probe

Marek Vasut <marex@denx.de>
    can: ifi: Repair the error handling

Stephane Grosjean <s.grosjean@peak-system.com>
    can: peak/pcie_fd: remove useless code when interface starts

Stephane Grosjean <s.grosjean@peak-system.com>
    can: peak/pcie_fd: fix echo_skb is occupied! bug

Dan Carpenter <dan.carpenter@oracle.com>
    staging: ncpfs: memory corruption in ncp_read_kernel()

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Fix nand waitfunc return value

OuYang ZhiZhong <ouyzz@yealink.com>
    mtdchar: fix usage of mtd_ooblayout_ecc()

Masami Hiramatsu <mhiramat@kernel.org>
    tracing: probeevent: Fix to support minus offset from symbol

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8723be: Fix loss of signal

Arend Van Spriel <arend.vanspriel@broadcom.com>
    brcmfmac: fix P2P_DEVICE ethernet address generation

Vishal Verma <vishal.l.verma@intel.com>
    libnvdimm, {btt, blk}: do integrity setup before add_disk()

Takashi Iwai <tiwai@suse.de>
    ACPI / watchdog: Fix off-by-one error at resource assignment

Dan Williams <dan.j.williams@intel.com>
    acpi, numa: fix pxm to online numa node associations

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/vmscan: wake up flushers for legacy cgroups too

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    drm: udl: Properly check framebuffer mmap offsets

Daniel Stone <daniels@collabora.com>
    drm: Reject getfb for multi-plane framebuffers

Michel Dänzer <michel.daenzer@amd.com>
    drm/radeon: Don't turn off DP sink when disconnected

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a destoy-while-held mutex problem.

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix black screen and device errors when running without fbdev

Daniel Vacek <neelx@redhat.com>
    Revert "mm: page_alloc: skip over regions of invalid pfns where possible"

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/thp: do not wait for lock_page() in deferred_split_scan()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/khugepaged.c: convert VM_BUG_ON() to collapse fail

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: implement free pmd/pte page interfaces

Toshi Kani <toshi.kani@hpe.com>
    mm/vmalloc: add interfaces to free unmapped page table

Arnd Bergmann <arnd@arndb.de>
    h8300: remove extraneous __BIG_ENDIAN definition

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: check for pgoff value overflow

Jeff Layton <jlayton@redhat.com>
    nfsd: remove blocked locks on client teardown

Tejun Heo <tj@kernel.org>
    cgroup: fix rule checking for threaded mode switching

Hans de Goede <hdegoede@redhat.com>
    libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version

Hans de Goede <hdegoede@redhat.com>
    libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs

Ju Hyung Park <qkrwngud825@gmail.com>
    libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng <kai.heng.feng@canonical.com>
    libata: disable LPM for Crucial BX100 SSD 500GB drive

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs

Eric Biggers <ebiggers@google.com>
    libata: don't try to pass through NCQ commands to non-NCQ devices

Eric Biggers <ebiggers@google.com>
    libata: remove WARN() for DMA or PIO command without data

Eric Biggers <ebiggers@google.com>
    libata: fix length validation of ATAPI-relayed SCSI commands

Takashi Iwai <tiwai@suse.de>
    Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table

Krzysztof Kozlowski <krzk@kernel.org>
    pinctrl: samsung: Validate alias coming from DT

Michael Kelley <mhkelley@outlook.com>
    Drivers: hv: vmbus: Fix ring buffer signaling

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: Protect sections updating shared registers

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: Fix ana->maskX definitions

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    lockdep: fix fs_reclaim warning

Hans de Goede <hdegoede@redhat.com>
    ahci: Add PCI-id for the Highpoint Rocketraid 644L card

Hans de Goede <hdegoede@redhat.com>
    PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L

Evgeniy Didin <Evgeniy.Didin@synopsys.com>
    mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Jaehoon Chung <jh80.chung@samsung.com>
    mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433

Evgeniy Didin <Evgeniy.Didin@synopsys.com>
    mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems

Bastian Stender <bst@pengutronix.de>
    mmc: block: fix updating ext_csd caches on ioctl call

Dirk Behme <dirk.behme@de.bosch.com>
    mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards

Adrian Hunter <adrian.hunter@intel.com>
    mmc: core: Fix tracepoint print of blk_addr and blksz

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Always immediately update mute LED with pin VREF

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix Dell headset Mic can't record

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix speaker no sound after system resume

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Force polling mode on CFL for fixing codec communication

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Fix access to not-yet-ready substream via cable

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Sync stale timer before release

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Dan Carpenter <dan.carpenter@oracle.com>
    iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()

Michael Nosthoff <committed@heine.so>
    iio: st_pressure: st_accel: pass correct platform data to init

Richard Lai <richard@richardman.com>
    iio: chemical: ccs811: Corrected firmware boot/application mode transition

Mathias Kresin <dev@kresin.me>
    MIPS: lantiq: ase: Enable MFD_SYSCON

Mathias Kresin <dev@kresin.me>
    MIPS: lantiq: Enable AHB Bus for USB

Mathias Kresin <dev@kresin.me>
    MIPS: lantiq: Fix Danube USB clock

NeilBrown <neil@brown.name>
    MIPS: ralink: Fix booting on MT7621

NeilBrown <neil@brown.name>
    MIPS: ralink: Remove ralink_halt()


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 Makefile                                           |  13 ++-
 arch/arm64/mm/mmu.c                                |  10 +++
 arch/h8300/include/asm/byteorder.h                 |   1 -
 arch/mips/lantiq/Kconfig                           |   2 +
 arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
 arch/mips/ralink/mt7621.c                          |  42 ++++-----
 arch/mips/ralink/reset.c                           |   7 --
 arch/x86/Makefile                                  |   9 ++
 arch/x86/boot/compressed/misc.c                    |   4 +
 arch/x86/entry/entry_64.S                          |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |   2 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/uncore_snbep.c               |  33 +++----
 arch/x86/include/asm/vmx.h                         |   1 +
 arch/x86/kernel/idt.c                              |   2 -
 arch/x86/kernel/traps.c                            |  15 ++--
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/mm/pgtable.c                              |  48 ++++++++++
 arch/x86/net/bpf_jit_comp.c                        |   3 +-
 arch/x86/platform/efi/efi_64.c                     |   2 +-
 drivers/acpi/acpi_watchdog.c                       |   4 +-
 drivers/acpi/numa.c                                |  10 ++-
 drivers/ata/ahci.c                                 |   4 +-
 drivers/ata/libata-core.c                          |  26 +++++-
 drivers/ata/libata-scsi.c                          |  10 ++-
 drivers/bluetooth/btusb.c                          |   8 +-
 drivers/clk/bcm/clk-bcm2835.c                      |  12 ++-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   6 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   7 ++
 drivers/gpu/drm/drm_syncobj.c                      |  81 +++++++----------
 drivers/gpu/drm/radeon/radeon_connectors.c         |  31 +++----
 drivers/gpu/drm/udl/udl_fb.c                       |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  13 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  39 ++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  13 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   5 +-
 drivers/hv/ring_buffer.c                           |  52 +++++++----
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/adc/meson_saradc.c                     |   4 +-
 drivers/iio/chemical/ccs811.c                      |   3 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   2 +-
 drivers/iio/pressure/st_pressure_core.c            |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  12 ++-
 drivers/mmc/core/block.c                           |  19 ++++
 drivers/mmc/core/card.h                            |   1 +
 drivers/mmc/core/quirks.h                          |   6 ++
 drivers/mmc/host/dw_mmc-exynos.c                   |   8 +-
 drivers/mmc/host/dw_mmc.c                          |  15 ++--
 drivers/mtd/mtdchar.c                              |   4 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |  32 +++----
 drivers/net/can/cc770/cc770.c                      | 100 +++++++++++++--------
 drivers/net/can/cc770/cc770.h                      |   2 +
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  75 ++++++++++------
 drivers/net/can/peak_canfd/peak_canfd.c            |  25 ++----
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |   8 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  24 +++--
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |   3 +-
 drivers/nvdimm/blk.c                               |   3 +-
 drivers/nvdimm/btt.c                               |   3 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |  56 ++++++++++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |  14 ++-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |  28 +++++-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |   7 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  61 ++++++++-----
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  40 +++++----
 drivers/staging/android/ion/ion_cma_heap.c         |  17 ++++
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   2 +-
 drivers/tty/vt/vt.c                                |   8 +-
 drivers/usb/host/xhci-hub.c                        |   5 +-
 drivers/usb/host/xhci.c                            |  34 ++-----
 drivers/usb/host/xhci.h                            |   3 +-
 drivers/watchdog/wdat_wdt.c                        |   2 +-
 fs/hugetlbfs/inode.c                               |  17 +++-
 fs/ncpfs/ncplib_kernel.c                           |   4 +
 fs/nfsd/nfs4state.c                                |  62 +++++++++----
 include/asm-generic/pgtable.h                      |  10 +++
 include/drm/drm_syncobj.h                          |   5 --
 include/linux/fsl_ifc.h                            |   6 +-
 include/linux/memblock.h                           |   1 -
 include/trace/events/mmc.h                         |   4 +-
 include/uapi/linux/usb/audio.h                     |   4 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/cgroup/cgroup.c                             |  10 +++
 kernel/events/core.c                               |   4 +-
 kernel/time/posix-timers.c                         |  11 ++-
 kernel/trace/trace_kprobe.c                        |   4 +-
 kernel/trace/trace_probe.c                         |   8 +-
 kernel/trace/trace_probe.h                         |   2 +-
 lib/ioremap.c                                      |   6 +-
 mm/huge_memory.c                                   |   4 +-
 mm/hugetlb.c                                       |   7 ++
 mm/khugepaged.c                                    |   7 +-
 mm/memblock.c                                      |  28 ------
 mm/page_alloc.c                                    |  13 +--
 mm/shmem.c                                         |  31 ++++---
 mm/vmscan.c                                        |  31 +++----
 sound/drivers/aloop.c                              |  17 +++-
 sound/pci/hda/hda_intel.c                          |   5 ++
 sound/pci/hda/patch_realtek.c                      |  20 ++++-
 tools/perf/builtin-stat.c                          |   2 +-
 tools/testing/selftests/x86/protection_keys.c      |  10 +--
 tools/testing/selftests/x86/ptrace_syscall.c       |   8 +-
 106 files changed, 979 insertions(+), 547 deletions(-)
