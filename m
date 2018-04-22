Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+q/1uMmRKIkorm0+ifdWlKU/+09ygaBVDcH0XWE26Vlr98gKQEpdWQTIqitqEXINsidvDp
ARC-Seal: i=1; a=rsa-sha256; t=1524406613; cv=none;
        d=google.com; s=arc-20160816;
        b=s1PVpJCRIRUQ5PeoqNlK9n/9O/DAIMT7GP4VhdB+BFxcM7VgQo7cqrMGEllQp7lOB+
         BSEXRQ0FCG+Avk3Qcip5z1lRjmhTa8+2AkG8sMkI+YZSq5G7cpZnk0toYA5mJyAC0Fyo
         jM0YKT5zwOohilrLtflQC71ecxBg6liJpXRcC6wh3Dj9QFAR0/wilGTChbUCVltnH/XI
         TNxjm0AUZKCYPgHjHqGbTR9tNovfiz6AGGztW9FKU1y4H7XXIgvL77gQBFc1cbzbFbF8
         1wCMaccFx3ES/9G8rcfRSAorf0k2nIyCq2OtuA7uCAyZbg0tGaONiRgZrGw/Ab8JczGF
         fWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xn03cDTi3rQsN8lHxubAcmNoBy4uFuF0qLUw78zfi0w=;
        b=k0J8X9dlg2Ihv81dYHXbflwmu9Slt4SaN3CXh+QkyEiH7h/CjVFwn3XBjtxiwWvvTj
         qQcS64f1asJRsQNfQZ/nQhmMxH+ODTiPkTUB8iMbbN3iNXoEBOOuu1smV98DfwfKBAxJ
         gmlXE2H4jeLJYvkPySih9BZmQ0RBmVTnDS13R8CDTwFCQjXRx440rP0bee0qWnSSGqei
         ouXF3UYaW6S1aq229ZDr9zvedbC9tXyqSQ9nnoVxckSpD09yZbMGcriqqyLJsRNK39Qu
         bjEC1r9z/IIJWSXtjx4J3wUbpXLqCuHqUyKLMBQejmBmKqB1F8yWTOBokr1Tu6IcWYPf
         78wQ==
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
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.4 00/97] 4.4.129-stable review
Date: Sun, 22 Apr 2018 15:52:38 +0200
Message-Id: <20180422135304.577223025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.129-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.129-rc1
X-KernelTest-Deadline: 2018-04-24T13:53+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456189119404560?=
X-GMAIL-MSGID: =?utf-8?q?1598456189119404560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.129 release.
There are 97 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.129-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.129-rc1

Greg Thelen <gthelen@google.com>
    writeback: safer lock nesting

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix logic of events on child

wangguang <wang.guang55@zte.com.cn>
    ext4: bugfix for mmaped pages in mpage_release_unused_pages()

Matthew Wilcox <mawilcox@microsoft.com>
    mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Michal Hocko <mhocko@suse.com>
    mm: allow GFP_{FS,IO} for page_cache_read page cache allocation

Ian Kent <raven@themaw.net>
    autofs: mount point create should honour passed in mode

Al Viro <viro@zeniv.linux.org.uk>
    Don't leak MNT_INTERNAL away from internal mounts

Al Viro <viro@zeniv.linux.org.uk>
    rpc_pipefs: fix double-dput()

Al Viro <viro@zeniv.linux.org.uk>
    hypfs_kill_super(): deal with failed allocations

Al Viro <viro@zeniv.linux.org.uk>
    jffs2_kill_sb(): deal with failed allocations

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling <mikey@neuling.org>
    powerpc/eeh: Fix enabling bridge MMIO windows

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix clobber of v1 in last_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: EVA & fault support for small_memset

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: uaccess: Add micromips clobbers to bzero invocation

Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
    HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

David Wang <davidwang@zhaoxin.com>
    ALSA: hda - New VIA controller suppor no-snoop path

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Fabián Inostroza <soulsonceonfire@gmail.com>
    ALSA: line6: Use correct endpoint type for midi output

Theodore Ts'o <tytso@mit.edu>
    ext4: fix deadlock between inline_data and ext4_expand_extra_isize_ea()

Jan Kara <jack@suse.cz>
    ext4: fix crashes in dioread_nolock mode

Paul Parsons <lost.distance@yahoo.com>
    drm/radeon: Fix PCIe lane width calculation

Theodore Ts'o <tytso@mit.edu>
    ext4: don't allow r/w mounts if metadata blocks overlap the superblock

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Virtualize Maximum Read Request Size

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Virtualize Maximum Payload Size

Alex Williamson <alex.williamson@redhat.com>
    vfio-pci: Virtualize PCIe & AF FLR

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Avoid potential races between OSS ioctls and read/write

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation

Nicholas Mc Guire <hofrat@osadl.org>
    ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix WD_EN register read

Mikhail Lappo <mikhail.lappo@esrlabs.com>
    thermal: imx: Fix race condition in imx_thermal_probe()

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Richard Genoud <richard.genoud@gmail.com>
    clk: mvebu: armada-38x: add support for missing clocks

Ralph Sennhauser <ralph.sennhauser@gmail.com>
    clk: mvebu: armada-38x: add support for 1866MHz variants

Alex Smith <alex.smith@imgtec.com>
    mmc: jz4740: Fix race condition in IRQ mask update

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix a potential memory leak

Krzysztof Mazur <krzysiek@podlesie.net>
    um: Use POSIX ucontext_t instead of struct ucontext

Maxime Jayat <maxime.jayat@mobile-devices.fr>
    dmaengine: at_xdmac: fix rare residue corruption

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix completion vector assignment algorithm

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix srp_abort()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF at PCM release via PCM timer access

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA device

Theodore Ts'o <tytso@mit.edu>
    ext4: fail ext4_iget for root directory if unallocated

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Theodore Ts'o <tytso@mit.edu>
    ext4: don't update checksum of new initialized bitmaps

Theodore Ts'o <tytso@mit.edu>
    jbd2: if the journal is aborted then don't allow update of the log tail

Theodore Ts'o <tytso@mit.edu>
    random: use a tighter cap in credit_entropy_bits_safe()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Resume control channel after hibernation image is created

James Kelly <jamespeterkelly@gmail.com>
    ASoC: ssm2602: Replace reg_default_raw with reg_default

Aaron Ma <aaron.ma@canonical.com>
    HID: core: Fix size as type u32

Aaron Ma <aaron.ma@canonical.com>
    HID: Fix hid_report_len usage

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()

Aaron Ma <aaron.ma@canonical.com>
    HID: i2c-hid: fix size check and type usage

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: pci: Properly cleanup resource

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E

Dan Carpenter <dan.carpenter@oracle.com>
    regmap: Fix reversed bounds check in regmap_raw_write()

Jason Andryuk <jandryuk@gmail.com>
    xen-netfront: Fix hang on device removal

Santiago Esteban <Santiago.Esteban@microchip.com>
    ARM: dts: at91: sama5d4: fix pinctrl compatible string

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Heinrich Schuchardt <xypron.glpk@gmx.de>
    usb: musb: gadget: misplaced out of bounds check

Vlastimil Babka <vbabka@suse.cz>
    mm, slab: reschedule cache_reap() on the same CPU

Eric Biggers <ebiggers@google.com>
    ipc/shm: fix use-after-free of shm file via remap_file_pages()

Takashi Iwai <tiwai@suse.de>
    resource: fix integer overflow at reallocation

Andrew Morton <akpm@linux-foundation.org>
    fs/reiserfs/journal.c: add missing resierfs_warning() arg

Richard Weinberger <richard@nod.at>
    ubi: Reject MLC NAND

Romain Izard <romain.izard.pro@gmail.com>
    ubi: Fix error for write access

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Don't flush fastmap work on detach

Richard Weinberger <richard@nod.at>
    ubifs: Check ubifs_wbuf_sync() return code

Tejun Heo <tj@kernel.org>
    tty: make n_tty_read() always abort if hangup is in progress

Ville Syrjälä <ville.syrjala@linux.intel.com>
    x86/hweight: Don't clobber %rdi

Borislav Petkov <bp@suse.de>
    x86/hweight: Get rid of the special calling convention

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Correctly indicate invalid OTP

Tejaswi Tanikella <tejaswit@codeaurora.org>
    slip: Check if rstate is initialized before uncompressing

Bassem Boubaker <bassem.boubaker@actia.fr>
    cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Marek Szyprowski <m.szyprowski@samsung.com>
    hwmon: (ina2xx) Fix access to uninitialized mutex

Sudhir Sreedharan <ssreedharan@mvista.com>
    rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Al Viro <viro@zeniv.linux.org.uk>
    getname_kernel() needs to make sure that ->name != ->iname in long case

Vasily Gorbik <gor@linux.ibm.com>
    s390/ipl: ensure loadparm valid flag is set

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't merge ERROR output buffers

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't retry EQBS after CCQ 96

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    block/loop: fix deadlock after loop_set_status

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "perf tests: Decompress kernel module before objdump"

Arnd Bergmann <arnd@arndb.de>
    radeon: hide pointless #warning when compile testing

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix timestamp following overflow

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error recovery from missing TIP packet

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix sync_switch

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap detection to identify consecutive buffers correctly

Helge Deller <deller@gmx.de>
    parisc: Fix out of array access in match_pci_device()

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: don't oops on overlay


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/at91sam9g25.dtsi                 |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/mips/include/asm/uaccess.h                    |  11 +-
 arch/mips/lib/memset.S                             |  11 +-
 arch/parisc/kernel/drivers.c                       |   4 +
 arch/powerpc/include/asm/barrier.h                 |   3 +-
 arch/powerpc/include/asm/synch.h                   |   4 -
 arch/powerpc/kernel/eeh_pe.c                       |   3 +-
 arch/powerpc/lib/feature-fixups.c                  |   2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c        |  11 +-
 arch/s390/hypfs/inode.c                            |   2 +-
 arch/s390/kernel/ipl.c                             |   1 +
 arch/um/os-Linux/signal.c                          |   2 +-
 arch/x86/Kconfig                                   |   5 -
 arch/x86/include/asm/arch_hweight.h                |  24 ++-
 arch/x86/kernel/i386_ksyms_32.c                    |   2 +
 arch/x86/kernel/x8664_ksyms_64.c                   |   3 +
 arch/x86/lib/Makefile                              |   2 +-
 arch/x86/lib/hweight.S                             |  79 +++++++++
 arch/x86/um/stub_segv.c                            |   2 +-
 drivers/acpi/video_detect.c                        |   9 +
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/block/loop.c                               |  12 +-
 drivers/char/random.c                              |   2 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   8 +-
 drivers/clk/mvebu/armada-38x.c                     |  15 +-
 drivers/dma/at_xdmac.c                             |   4 +-
 drivers/gpu/drm/radeon/radeon_object.c             |   3 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   4 +-
 drivers/hid/hid-core.c                             |  10 +-
 drivers/hid/hid-input.c                            |   3 +-
 drivers/hid/hid-multitouch.c                       |   5 +-
 drivers/hid/hid-rmi.c                              |   4 +-
 drivers/hid/hidraw.c                               |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                      |  13 +-
 drivers/hwmon/ina2xx.c                             |   3 +-
 drivers/infiniband/core/ucma.c                     |   3 +
 drivers/infiniband/ulp/srp/ib_srp.c                |  18 +-
 drivers/iommu/intel-svm.c                          |   1 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   4 +-
 drivers/mmc/host/jz4740_mmc.c                      |   2 +-
 drivers/mtd/ubi/block.c                            |   2 +-
 drivers/mtd/ubi/build.c                            |  11 ++
 drivers/mtd/ubi/fastmap-wl.c                       |   1 -
 drivers/net/slip/slhc.c                            |   5 +
 drivers/net/usb/cdc_ether.c                        |   6 +
 drivers/net/usb/lan78xx.c                          |   3 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |   2 +-
 drivers/net/xen-netfront.c                         |   7 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  23 ++-
 drivers/s390/cio/qdio_main.c                       |  42 ++---
 drivers/thermal/imx_thermal.c                      |   6 +-
 drivers/thunderbolt/nhi.c                          |   1 +
 drivers/tty/n_tty.c                                |   6 +
 drivers/tty/tty_io.c                               |   9 +
 drivers/usb/core/generic.c                         |   9 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +-
 drivers/usb/musb/musb_gadget_ep0.c                 |  14 +-
 drivers/vfio/pci/vfio_pci_config.c                 | 107 +++++++++++-
 drivers/watchdog/f71808e_wdt.c                     |   2 +-
 fs/autofs4/root.c                                  |   2 +-
 fs/ext4/balloc.c                                   |  19 ++-
 fs/ext4/ialloc.c                                   |  54 ++----
 fs/ext4/inline.c                                   |  66 ++++---
 fs/ext4/inode.c                                    |  48 +++---
 fs/ext4/super.c                                    |   6 +
 fs/ext4/xattr.c                                    |  30 ++--
 fs/ext4/xattr.h                                    |  32 ++++
 fs/fs-writeback.c                                  |   7 +-
 fs/jbd2/journal.c                                  |   5 +-
 fs/jffs2/super.c                                   |   2 +-
 fs/namei.c                                         |   3 +-
 fs/namespace.c                                     |   3 +-
 fs/notify/fanotify/fanotify.c                      |  34 ++--
 fs/reiserfs/journal.c                              |   2 +-
 fs/ubifs/super.c                                   |  14 +-
 include/linux/backing-dev-defs.h                   |   5 +
 include/linux/backing-dev.h                        |  31 ++--
 include/linux/hid.h                                |   6 +-
 include/linux/mm.h                                 |   4 +
 include/linux/tty.h                                |   1 +
 include/net/slhc_vj.h                              |   1 +
 include/sound/pcm_oss.h                            |   1 +
 ipc/shm.c                                          |  23 ++-
 kernel/resource.c                                  |   3 +-
 lib/Makefile                                       |   2 -
 lib/hweight.c                                      |   4 +
 mm/filemap.c                                       |  16 +-
 mm/memory.c                                        |  17 ++
 mm/page-writeback.c                                |  18 +-
 mm/slab.c                                          |   3 +-
 net/sunrpc/rpc_pipe.c                              |   1 +
 sound/core/oss/pcm_oss.c                           | 189 ++++++++++++++++-----
 sound/core/pcm.c                                   |   8 +-
 sound/core/rawmidi_compat.c                        |  18 +-
 sound/pci/hda/hda_intel.c                          |   3 +-
 sound/soc/codecs/ssm2602.c                         |  19 ++-
 sound/usb/line6/midi.c                             |   2 +-
 tools/perf/tests/code-reading.c                    |  20 +--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 ++++---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
 tools/perf/util/intel-pt.c                         |  37 +++-
 103 files changed, 943 insertions(+), 449 deletions(-)
