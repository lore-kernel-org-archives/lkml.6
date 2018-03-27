Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-89073-1522170439-2-12458871257803737783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522170437; b=qbS8W6+FKz5Nik4Wnq4DSUC6DWWSsfpe5Rqx7nXDPaMBZQ6
    eM0umWBOhRsJkWQVX2jOH3jHqCXjf45fwB8Wz/hz6FBMP6wg6UHHhE5ofJ3CMFVS
    qqBfvERzERZFdyopHaOExN8PmwxurJfeGe3pqybsXKdQkTa4Es9rB/kYZRmOc6Xl
    aSNBidUmMZWU6kXrRnANgfUJDpYrraUQJ1iYb3h2RE+9Irj4PnXphEc+lh8V9J46
    WHIXyXUPx6L/fIJUWP84m7JnWBTphhxMSZKH4BeUS8p6oGqpUzTctKUT1WQ3YFQw
    I2dBcpyze2Uxs5DzQT9S4BzzY27H0TmVU1sVh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1522170437; bh=lJ7B4ZRdMtk/WbMypKUXiuB4G6
    CEpjXObEIA9xJB2jI=; b=AcjPN1tzzupZuSebbPtXSvI+PO9U0fAV/7Uameanr1
    EZc/SQ9ROx6sHCPQ1OOFtKsaCsHFVWo0KXhqbpQ2DeEnJKBUwMUAHaJF1lpw/hMs
    w27roZKuP9QPNOfQ4zbZayVT9t1nbQCG8eWz/XKoxMVqcuAlANck9/xx5qtZgx4/
    RK366rIXWsYiVktwlBNo4fNJfyaSD3mHStkXkWlR+2xGCxP0vouCVQT5DvR1Amuw
    jrO+RRYWBactvSTNIuHA2x7kb7jTKvvH+vyrwexnc3ldfU8AzN7hkbXtacZh8jP9
    A74CbXdAA8ARKQCufH+V3zmsVXPKCn93+hdyyEDP1FCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOF3L1g//AurUHYiAS03yA+E/OuOVnGvwkcyCcL5eJ4pBbirf5EocMW7dOUDAtdWD3Hoj60meVwJLURcuMC/dI6DH54N4F7y0J7yvErm+7jz6V8CtinN
    pe7l/qwEamv4yZa6eyDcweJvaQK4HqPAX0GH/7xg83BxaV22A9mkGuiuQwHnUYnc5NPu2cne404QYIuYLn5yU0rLkEkbQk0/oAnN79oprYv8z9ciJRP5gItd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=HpFSncBSp1MA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=hWMQpYRtAAAA:8
    a=1XWaLZrsAAAA:8 a=LpQP-O61AAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
    a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=JqEG_dyiAAAA:8
    a=_jlGtV7tAAAA:8 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=nTPwkA1SAAAA:8
    a=ruePrcMeAAAA:8 a=8AirrxEcAAAA:8 a=06TC-2EVAAAA:8 a=yQdBAQUQAAAA:8
    a=Q-fNiiVtAAAA:8 a=TYBLyS7eAAAA:8 a=QX4gbG5DAAAA:8 a=zd2uoN0lAAAA:8
    a=eh1Yez-EAAAA:8 a=MvuuwTCpAAAA:8 a=DfNHnWVPAAAA:8 a=UqCG9HQmAAAA:8
    a=CbDCq_QkAAAA:8 a=zu6OG0ZhAAAA:8 a=P-IC7800AAAA:8 a=jIQo8A4GAAAA:8
    a=hD80L64hAAAA:8 a=hVcwujEvAAAA:8 a=n9Sqmae0AAAA:8 a=A268-kvZAAAA:8
    a=qM59PFdBSNYimhTLgasA:9 a=TQfpyJ6iRDZBpU-H:21 a=-fvflMOrzH0Toymd:21
    a=QEXdDO2ut3YA:10 a=2t5KsnBapy4A:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=KCsI-UfzjElwHeZNREa_:22 a=pioyyrs4ZptJ924tMmac:22
    a=cvBusfyB2V15izCimMoJ:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=nlm17XC03S6CtCLSeiRr:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Her_73y7XSQQkpQYGz2D:22 a=QI2EG80Mmz_WNOzBKUk-:22
    a=ST-jHhOKWsTCqRlWije3:22 a=bPPcmhrZmmaHPY_0WkiZ:22 a=SzazLyfi1tnkUD6oumHU:22
    a=Fp8MccfUoT0GBdDC_Lng:22 a=zvYvwCWiE4KgVXXeO06c:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeC0QkS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:40:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755389AbeC0QkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:40:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 000/105] 4.15.14-stable review
Date: Tue, 27 Mar 2018 18:26:40 +0200
Message-Id: <20180327162757.813009222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.14-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.14-rc1
X-KernelTest-Deadline: 2018-03-29T16:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.14 release.
There are 105 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.14-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.14-rc1

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: increase number of passes

Chenbo Feng <fengc@google.com>
    bpf: skip unnecessary capability check

Daniel Borkmann <daniel@iogearbox.net>
    kbuild: disable clang's default use of -fmerge-all-constants

Liam Mark <lmark@codeaurora.org>
    staging: android: ion: Zero CMA allocated memory

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    iio: imu: st_lsm6dsx: introduce conf_lock mutex

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()

Linus Walleij <linus.walleij@linaro.org>
    iio: ABI: Fix name of timestamp sysfs file

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers

Dan Carpenter <dan.carpenter@oracle.com>
    perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

Yonghong Song <yhs@fb.com>
    trace/bpf: remove helper bpf_perf_prog_read_value from tracepoint type programs

Song Liu <songliubraving@fb.com>
    perf/core: Fix ctx_event_type in ctx_resched()

Ilya Pronin <ipronin@twitter.com>
    perf stat: Fix CVS output format for non-supported counters

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix Skylake UPI event format

Guenter Roeck <linux@roeck-us.net>
    hwmon: (k10temp) Add temperature offset for Ryzen 1900X

Guenter Roeck <linux@roeck-us.net>
    hwmon: (k10temp) Only apply temperature offset if result is positive

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

Leon Yu <chianglungyu@gmail.com>
    module: propagate error in modules_open()

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/vmscan: wake up flushers for legacy cgroups too

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    drm: udl: Properly check framebuffer mmap offsets

Daniel Stone <daniels@collabora.com>
    drm: Reject getfb for multi-plane framebuffers

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Add one to EDID's audio channel count when passing to DC

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: We shouldn't set format_default on plane as atomic driver

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

Hans Verkuil <hverkuil@xs4all.nl>
    media: tegra-cec: reset rx_buf_cnt when start bit detected

Jeff Layton <jlayton@redhat.com>
    nfsd: remove blocked locks on client teardown

Tejun Heo <tj@kernel.org>
    cgroup: fix rule checking for threaded mode switching

Tejun Heo <tj@kernel.org>
    sched, cgroup: Don't reject lower cpu.max on ancestors

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   7 ++
 drivers/gpu/drm/radeon/radeon_connectors.c         |  31 +++----
 drivers/gpu/drm/udl/udl_fb.c                       |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  13 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  39 ++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  13 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   5 +-
 drivers/hv/ring_buffer.c                           |  52 +++++++----
 drivers/hwmon/k10temp.c                            |   6 +-
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/adc/meson_saradc.c                     |   4 +-
 drivers/iio/chemical/ccs811.c                      |   3 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  21 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   8 +-
 drivers/iio/pressure/st_pressure_core.c            |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  12 ++-
 drivers/media/platform/tegra-cec/tegra_cec.c       |  17 ++--
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
 drivers/tty/vt/vt.c                                |   8 +-
 drivers/watchdog/wdat_wdt.c                        |   2 +-
 fs/hugetlbfs/inode.c                               |  17 +++-
 fs/ncpfs/ncplib_kernel.c                           |   4 +
 fs/nfsd/nfs4state.c                                |  62 +++++++++----
 include/asm-generic/pgtable.h                      |  10 +++
 include/linux/fsl_ifc.h                            |   6 +-
 include/linux/memblock.h                           |   1 -
 include/trace/events/mmc.h                         |   4 +-
 include/uapi/linux/usb/audio.h                     |   4 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/cgroup/cgroup.c                             |  10 +++
 kernel/events/core.c                               |   4 +-
 kernel/module.c                                    |   2 +-
 kernel/sched/core.c                                |  15 ++--
 kernel/time/posix-timers.c                         |  11 ++-
 kernel/trace/bpf_trace.c                           |  68 ++++++++------
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
 tools/testing/selftests/x86/ptrace_syscall.c       |   8 +-
 108 files changed, 1014 insertions(+), 513 deletions(-)
