Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Sj6nERcMqOJOtFDcKggW+5yzAOcfKpejq0cHs4MKX319mxhdCYkhjHbO1qG9YH4yjAXEg
ARC-Seal: i=1; a=rsa-sha256; t=1524405895; cv=none;
        d=google.com; s=arc-20160816;
        b=syXkTkcWGPdR760oWWR3aTJ5do2LYBQo6HK1iprzOcKe5pMY9i2pjEwBugWktsLB+F
         WmlNgkot5ogHoMJ8+d7wA/lMiFE1d6uOFESBdnlFlV8AapbDe1UyOZwDwqKQXzSvxUVp
         rZFOhnMP48OEA5mBQEFehUcT3gvEaGsLoQkkqhn+iv7dF12X13rtlR7PjrW/cv0Fm3mJ
         +amhQ+rVd2K9sxw+9Xcdgauzo+XF5HjqNoTpL1PFpVFgqZGlN7C7mqKr5tf3u5+6PjNf
         PWMI/eB+h3ytOkz+OtSKntoLOcLGXvE7QGeCoNBgaaaTh5y9fBxgbWIjD4ZG+mLH6xp4
         kttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5fS6qlvkhvX7BlRSqwPlRI4s1uPZ6xhEEmVq5eAiKyg=;
        b=LGY6u/oqXrljJp3JAUBEcLuUSZ38strYAb+e0fF14cDXQ6fUszR1Gq9EKOQTV7QRiB
         RGahFRtkPuF+T7NHwnup/ljfpKepcNHIaR5OOxnFIr8fFOQPCdCF6fbbM2nM/DVHxi4p
         EXBA8QshqOY/ov1LfvaFdwQ74zvKcvhZMrM7zXQ+snPP9KNseOYMntU/nQSw0UL/xpty
         LF+F43rhmyyxMQmJYEWpobNkdVjwtxELcdd6mhqpKkqTuZ3ItSqC6dS1hCIjQcHNnCPv
         +R7NDQo7jkUu7YeS+xY5KQPeGiUIkpXt6PHePb/VrYBDZfhrDa9jwkSxlV3eBrEXER+c
         RUvQ==
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
Subject: [PATCH 4.14 000/164] 4.14.36-stable review
Date: Sun, 22 Apr 2018 15:51:07 +0200
Message-Id: <20180422135135.400265110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.36-rc1
X-KernelTest-Deadline: 2018-04-24T13:51+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455435628222896?=
X-GMAIL-MSGID: =?utf-8?q?1598455435628222896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.36 release.
There are 164 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.36-rc1

Greg Thelen <gthelen@google.com>
    writeback: safer lock nesting

Sean Young <sean@mess.org>
    media: staging: lirc_zilog: incorrect reference counting

Sean Young <sean@mess.org>
    Revert "media: lirc_zilog: driver only sends LIRCCODE"

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: add a bunch of new 9000 PCI IDs

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: add shared clock PHY config flag for some devices

Andrew Lunn <andrew@lunn.ch>
    net: dsa: Discard frames from unused ports

Matthew Wilcox <mawilcox@microsoft.com>
    mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Ian Kent <raven@themaw.net>
    autofs: mount point create should honour passed in mode

Al Viro <viro@zeniv.linux.org.uk>
    Don't leak MNT_INTERNAL away from internal mounts

Al Viro <viro@zeniv.linux.org.uk>
    rpc_pipefs: fix double-dput()

Al Viro <viro@zeniv.linux.org.uk>
    orangefs_kill_sb(): deal with allocation failures

Al Viro <viro@zeniv.linux.org.uk>
    hypfs_kill_super(): deal with failed allocations

Al Viro <viro@zeniv.linux.org.uk>
    jffs2_kill_sb(): deal with failed allocations

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Correctly handle limited range YCbCr data on VLV/CHV

Daniel Kurtz <djkurtz@chromium.org>
    mmc: sdhci-pci: Only do AMD tuning for HS200

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix logic of events on child

Jan Kara <jack@suse.cz>
    udf: Fix leak of UTF-16 surrogates into encoded strings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/lib: Fix off-by-one in alternate feature patching

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc/xive: Fix trying to "push" an already active pool VP

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

Aaron Armstrong Skomra <skomra@gmail.com>
    HID: wacom: bluetooth: send exit report for recent Bluetooth devices

Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
    HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    HID: input: fix battery level reporting on BT mice

Theodore Ts'o <tytso@mit.edu>
    random: add new ioctl RNDRESEEDCRNG

Theodore Ts'o <tytso@mit.edu>
    random: crng_reseed() should lock the crng instance that it is modifying

Theodore Ts'o <tytso@mit.edu>
    random: set up the NUMA crng instances after the CRNG is fully initialized

Theodore Ts'o <tytso@mit.edu>
    random: use a different mixing algorithm for add_device_randomness()

Theodore Ts'o <tytso@mit.edu>
    random: fix crng_ready() test

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - adjust the location of one mic

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags

David Wang <davidwang@zhaoxin.com>
    ALSA: hda - New VIA controller suppor no-snoop path

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Fabián Inostroza <soulsonceonfire@gmail.com>
    ALSA: line6: Use correct endpoint type for midi output

Paul Parsons <lost.distance@yahoo.com>
    drm/radeon: Fix PCIe lane width calculation

Nico Sneck <nicosneck@hotmail.com>
    drm/radeon: add PX quirk for Asus K73TK

Marc Zyngier <marc.zyngier@arm.com>
    drm/rockchip: Clear all interrupts before requesting the IRQ

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/si: implement get/set pcie_lanes asic callback

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Fix PCIe lane width calculation

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma: fix mask in emit_pipeline_sync

Bas Nieuwenhuizen <basni@chromium.org>
    drm/amdgpu: Fix always_valid bos multiple LRU insertions.

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add an ATPX quirk for hybrid laptop

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

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Virtualize Maximum Read Request Size

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix WD_EN register read

Sean Wang <sean.wang@mediatek.com>
    dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4

Mikhail Lappo <mikhail.lappo@esrlabs.com>
    thermal: imx: Fix race condition in imx_thermal_probe()

Ryo Kodama <ryo.kodama.vz@renesas.com>
    pwm: rcar: Fix a condition to prevent mismatch value setting to duty

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Sean Wang <sean.wang@mediatek.com>
    clk: mediatek: fix PWM clock source by adding a fixed-factor clock

Arnd Bergmann <arnd@arndb.de>
    clk: fix false-positive Wmaybe-uninitialized warning

Richard Genoud <richard.genoud@gmail.com>
    clk: mvebu: armada-38x: add support for missing clocks

Sinan Kaya <okaya@codeaurora.org>
    PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken

Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
    mmc: tmio: Fix error handling when issuing CMD23

Alex Smith <alex.smith@imgtec.com>
    mmc: jz4740: Fix race condition in IRQ mask update

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix a potential memory leak

Krzysztof Mazur <krzysiek@podlesie.net>
    um: Use POSIX ucontext_t instead of struct ucontext

Jason A. Donenfeld <Jason@zx2c4.com>
    um: Compile with modern headers

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ring-buffer: Check if memory is available before allocation

Dan Williams <dan.j.williams@intel.com>
    nfit: skip region registration for incomplete control regions

Dan Williams <dan.j.williams@intel.com>
    nfit, address-range-scrub: fix scrub in-progress reporting

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, namespace: use a safe lookup for dimm device name

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, dimm: fix dpa reservation vs uninitialized label area

Chris Chiu <chiu@endlessm.com>
    tpm: self test failure should not cause suspend to fail

Frederic Barrat <fbarrat@linux.vnet.ibm.com>
    cxl: Fix possible deadlock when processing page faults from cxllib

Maxime Jayat <maxime.jayat@mobile-devices.fr>
    dmaengine: at_xdmac: fix rare residue corruption

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix completion vector assignment algorithm

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix srp_abort()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF at PCM release via PCM timer access

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix an out-of-bounds read

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from NULL pointer derefence

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA device

Mikulas Patocka <mpatocka@redhat.com>
    dm crypt: limit the number of allocated pages

Theodore Ts'o <tytso@mit.edu>
    ext4: add extra checks to ext4_xattr_block_get()

Theodore Ts'o <tytso@mit.edu>
    ext4: add bounds checking to ext4_xattr_find_entry()

Theodore Ts'o <tytso@mit.edu>
    ext4: move call to ext4_error() into ext4_xattr_check_block()

Theodore Ts'o <tytso@mit.edu>
    ext4: don't allow r/w mounts if metadata blocks overlap the superblock

Theodore Ts'o <tytso@mit.edu>
    ext4: always initialize the crc32c checksum driver

Theodore Ts'o <tytso@mit.edu>
    ext4: fail ext4_iget for root directory if unallocated

Eric Biggers <ebiggers@google.com>
    ext4: limit xattr size to INT_MAX

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Eryu Guan <guaneryu@gmail.com>
    ext4: protect i_disksize update by i_data_sem in direct write path

Theodore Ts'o <tytso@mit.edu>
    ext4: don't update checksum of new initialized bitmaps

Theodore Ts'o <tytso@mit.edu>
    ext4: pass -ESHUTDOWN code to jbd2 layer

Theodore Ts'o <tytso@mit.edu>
    ext4: eliminate sleep from shutdown ioctl

Theodore Ts'o <tytso@mit.edu>
    ext4: shutdown should not prevent get_write_access

Theodore Ts'o <tytso@mit.edu>
    jbd2: if the journal is aborted then don't allow update of the log tail

Mikulas Patocka <mpatocka@redhat.com>
    block: use 32-bit blk_status_t on Alpha

Hans de Goede <hdegoede@redhat.com>
    extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO

Theodore Ts'o <tytso@mit.edu>
    random: use a tighter cap in credit_entropy_bits_safe()

Aniruddha Banerjee <aniruddhab@nvidia.com>
    irqchip/gic: Take lock when updating irq type

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Prevent crash when ICM firmware is not running

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Resume control channel after hibernation image is created

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Serialize PCIe tunnel creation with PCI rescan

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Wait a bit longer for ICM to authenticate the active NVM

Liam Girdwood <liam.r.girdwood@linux.intel.com>
    ASoC: topology: Fix kcontrol name string handling

James Kelly <jamespeterkelly@gmail.com>
    ASoC: ssm2602: Replace reg_default_raw with reg_default

Sean Wang <sean.wang@mediatek.com>
    soc: mediatek: fix the mistaken pointer accessed when subdomains are added

Aaron Ma <aaron.ma@canonical.com>
    HID: core: Fix size as type u32

Aaron Ma <aaron.ma@canonical.com>
    HID: Fix hid_report_len usage

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
    powerpc/kexec_file: Fix error code when trying to load kdump kernel

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc/kprobes: Fix call trace due to incorrect preempt count

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently

Paul Mackerras <paulus@ozlabs.org>
    powerpc/64: Call H_REGISTER_PROC_TBL when running as a HPT guest on POWER9

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted LPCR bits

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    CIFS: fix sha512 check in cifs_crypto_secmech_release

Aurelien Aptel <aaptel@suse.com>
    CIFS: add sha512 secmech

Aurelien Aptel <aaptel@suse.com>
    CIFS: refactor crypto shash/sdesc allocation&free

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Restore configuration at shutdown

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Save register SMBSLVCMD value only once

Aaron Ma <aaron.ma@canonical.com>
    HID: i2c-hid: fix size check and type usage

Steve French <stfrench@microsoft.com>
    smb3: Fix root directory when server returns inode number of zero

Ronnie Sahlberg <lsahlber@redhat.com>
    fix smb3-encryption breakage when CONFIG_DEBUG_SG=y

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix memory leak in SMB2_open()

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: dwc3: gadget: never call ->complete() from ->ep_queue()

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: pci: Properly cleanup resource

Roger Quadros <rogerq@ti.com>
    usb: dwc3: prevent setting PRTCAP to OTG from debugfs

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

Yavuz, Tuba <tuba@ece.ufl.edu>
    USB: gadget: f_midi: fixing a possible double-free in f_midi

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E

Dan Carpenter <dan.carpenter@oracle.com>
    regmap: Fix reversed bounds check in regmap_raw_write()

Jason Andryuk <jandryuk@gmail.com>
    xen-netfront: Fix hang on device removal

Jason Andryuk <jandryuk@gmail.com>
    x86/xen: Delay get_cpu_cap until stack canary is established

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: vsp1: Fix BRx conditional path in WPF

Hans Verkuil <hverkuil@xs4all.nl>
    media: vivid: check if the cec_adapter is valid

Hans Verkuil <hverkuil@xs4all.nl>
    media: atomisp_fops.c: disable atomisp_compat_ioctl32

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    spi: Fix unregistration of controller with fixed SPI bus number

Maxime Chevallier <maxime.chevallier@bootlin.com>
    spi: Fix scatterlist elements size in spi_map_buf

Eugen Hristev <eugen.hristev@microchip.com>
    spi: atmel: init FIFOs before spi enable

Santiago Esteban <Santiago.Esteban@microchip.com>
    ARM: dts: at91: sama5d4: fix pinctrl compatible string

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Sean Wang <sean.wang@mediatek.com>
    arm: dts: mt7623: fix USB initialization fails on bananapi-r2

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210

David Lechner <david@lechnology.com>
    ARM: dts: da850-lego-ev3: Fix battery voltage gpio

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list

Jerome Brunet <jbrunet@baylibre.com>
    ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: gadget: udc: core: update usb_ep_queue() documentation

Chen-Yu Tsai <wens@csie.org>
    phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving VBUS

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

Kees Cook <keescook@chromium.org>
    task_struct: only use anon struct under randstruct plugin

Jérôme Glisse <jglisse@redhat.com>
    mm/hmm: hmm_pfns_bad() was accessing wrong struct

Jérôme Glisse <jglisse@redhat.com>
    mm/hmm: fix header file if/else/endif maze

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    mm/ksm.c: fix inconsistent accounting of zero pages

Richard Weinberger <richard@nod.at>
    ubi: Reject MLC NAND

Romain Izard <romain.izard.pro@gmail.com>
    ubi: Fix error for write access

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Don't flush fastmap work on detach

Richard Weinberger <richard@nod.at>
    ubifs: Check ubifs_wbuf_sync() return code

George Cherian <george.cherian@cavium.com>
    cpufreq: CPPC: Use transition_delay_us depending transition_latency

Tejun Heo <tj@kernel.org>
    tty: make n_tty_read() always abort if hangup is in progress


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/at91sam9g25.dtsi                 |   2 +-
 arch/arm/boot/dts/da850-lego-ev3.dts               |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   8 +-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |  24 ++-
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/arm/mach-exynos/pm.c                          |   6 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   2 +-
 arch/mips/include/asm/uaccess.h                    |  11 +-
 arch/mips/lib/memset.S                             |  11 +-
 arch/powerpc/include/asm/barrier.h                 |   3 +-
 arch/powerpc/include/asm/synch.h                   |   4 -
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |  12 +-
 arch/powerpc/kernel/eeh_pe.c                       |   3 +-
 arch/powerpc/kernel/kprobes.c                      |  30 ++--
 arch/powerpc/kernel/machine_kexec_file_64.c        |   2 +-
 arch/powerpc/lib/feature-fixups.c                  |   2 +-
 arch/powerpc/mm/hash_utils_64.c                    |   6 +
 arch/powerpc/platforms/powernv/opal-nvram.c        |  11 +-
 arch/powerpc/platforms/pseries/lpar.c              |   8 +-
 arch/powerpc/sysdev/xive/native.c                  |   4 +
 arch/s390/hypfs/inode.c                            |   2 +-
 arch/um/os-Linux/file.c                            |   1 +
 arch/um/os-Linux/signal.c                          |   3 +-
 arch/x86/um/stub_segv.c                            |   3 +-
 arch/x86/xen/enlighten_pv.c                        |   8 +-
 drivers/acpi/nfit/core.c                           |  18 +-
 drivers/acpi/video_detect.c                        |   9 +
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/char/random.c                              | 130 ++++++++++----
 drivers/char/tpm/tpm-interface.c                   |   4 +
 drivers/clk/bcm/clk-bcm2835.c                      |   8 +-
 drivers/clk/mediatek/clk-mt2701.c                  |  15 +-
 drivers/clk/mvebu/armada-38x.c                     |  14 +-
 drivers/clk/renesas/clk-sh73a0.c                   |   6 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   3 +
 drivers/dma/at_xdmac.c                             |   4 +-
 drivers/extcon/extcon-intel-cht-wc.c               |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  67 +++++++
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   4 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  10 ++
 drivers/gpu/drm/i915/intel_sprite.c                |  81 +++++++--
 drivers/gpu/drm/radeon/radeon_device.c             |   4 +
 drivers/gpu/drm/radeon/si_dpm.c                    |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  23 +--
 drivers/hid/hid-core.c                             |  10 +-
 drivers/hid/hid-input.c                            |  27 ++-
 drivers/hid/hid-multitouch.c                       |   5 +-
 drivers/hid/hid-rmi.c                              |   4 +-
 drivers/hid/hidraw.c                               |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                      |  13 +-
 drivers/hid/wacom_sys.c                            |   4 +-
 drivers/hid/wacom_wac.c                            |  76 ++++----
 drivers/i2c/busses/i2c-i801.c                      |  16 +-
 drivers/infiniband/core/ucma.c                     |   3 +
 drivers/infiniband/hw/mlx5/mr.c                    |   2 +
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   5 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  18 +-
 drivers/iommu/intel-svm.c                          |   1 +
 drivers/irqchip/irq-gic-common.c                   |   9 +-
 drivers/md/dm-crypt.c                              |  66 ++++++-
 drivers/media/platform/vivid/vivid-vid-common.c    |   3 +-
 drivers/media/platform/vsp1/vsp1_wpf.c             |   2 +-
 drivers/misc/cxl/cxllib.c                          |  85 +++++----
 drivers/mmc/host/jz4740_mmc.c                      |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  25 ++-
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +-
 drivers/mtd/ubi/block.c                            |   2 +-
 drivers/mtd/ubi/build.c                            |  11 ++
 drivers/mtd/ubi/fastmap-wl.c                       |   1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |  62 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 195 ++++++++++++++++++---
 drivers/net/xen-netfront.c                         |   7 +-
 drivers/nvdimm/dimm.c                              |   8 +-
 drivers/nvdimm/namespace_devs.c                    |   4 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  23 ++-
 drivers/pci/quirks.c                               |   4 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |  10 +-
 drivers/pwm/pwm-rcar.c                             |   8 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |   2 +-
 drivers/spi/spi-atmel.c                            |   8 +-
 drivers/spi/spi.c                                  |  19 +-
 .../media/atomisp/pci/atomisp2/atomisp_fops.c      |   6 +
 drivers/staging/media/lirc/lirc_zilog.c            |   9 +-
 drivers/thermal/imx_thermal.c                      |   6 +-
 drivers/thunderbolt/icm.c                          |  10 +-
 drivers/thunderbolt/nhi.c                          |   1 +
 drivers/thunderbolt/switch.c                       |   9 +
 drivers/tty/n_tty.c                                |   6 +
 drivers/tty/tty_io.c                               |   9 +
 drivers/usb/core/generic.c                         |   9 +-
 drivers/usb/dwc3/core.c                            |   3 +
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +-
 drivers/usb/dwc3/gadget.c                          |  43 +++--
 drivers/usb/gadget/function/f_midi.c               |   3 +-
 drivers/usb/gadget/u_f.h                           |   2 +
 drivers/usb/gadget/udc/core.c                      |   3 +
 drivers/usb/musb/musb_gadget_ep0.c                 |  14 +-
 drivers/vfio/pci/vfio_pci_config.c                 |  29 ++-
 drivers/watchdog/f71808e_wdt.c                     |   2 +-
 fs/autofs4/root.c                                  |   2 +-
 fs/cifs/Kconfig                                    |   1 +
 fs/cifs/cifsencrypt.c                              |  85 ++-------
 fs/cifs/cifsfs.c                                   |   1 +
 fs/cifs/cifsglob.h                                 |   3 +
 fs/cifs/cifsproto.h                                |   5 +
 fs/cifs/inode.c                                    |  33 ++++
 fs/cifs/link.c                                     |  27 +--
 fs/cifs/misc.c                                     |  54 ++++++
 fs/cifs/smb2ops.c                                  |  15 +-
 fs/cifs/smb2pdu.c                                  |   8 +-
 fs/cifs/smb2proto.h                                |   3 +
 fs/cifs/smb2transport.c                            |  97 +++++-----
 fs/cifs/smbencrypt.c                               |  27 +--
 fs/ext4/balloc.c                                   |  19 +-
 fs/ext4/ext4_jbd2.c                                |   7 -
 fs/ext4/ialloc.c                                   |  54 ++----
 fs/ext4/inode.c                                    |  11 +-
 fs/ext4/ioctl.c                                    |   8 +-
 fs/ext4/super.c                                    |  21 ++-
 fs/ext4/xattr.c                                    | 121 +++++++------
 fs/ext4/xattr.h                                    |  11 ++
 fs/fs-writeback.c                                  |   7 +-
 fs/jbd2/journal.c                                  |  30 +++-
 fs/jffs2/super.c                                   |   2 +-
 fs/namespace.c                                     |   3 +-
 fs/notify/fanotify/fanotify.c                      |  34 ++--
 fs/orangefs/super.c                                |   5 +
 fs/reiserfs/journal.c                              |   2 +-
 fs/ubifs/super.c                                   |  14 +-
 fs/udf/unicode.c                                   |   6 +
 include/dt-bindings/clock/mt2701-clk.h             |   3 +-
 include/linux/backing-dev-defs.h                   |   5 +
 include/linux/backing-dev.h                        |  30 ++--
 include/linux/blk_types.h                          |   5 +
 include/linux/compiler-clang.h                     |   3 -
 include/linux/compiler-gcc.h                       |  12 +-
 include/linux/hid.h                                |  15 +-
 include/linux/hmm.h                                |   9 +-
 include/linux/tty.h                                |   1 +
 include/sound/pcm_oss.h                            |   1 +
 include/uapi/linux/random.h                        |   3 +
 ipc/shm.c                                          |  23 ++-
 kernel/resource.c                                  |   3 +-
 kernel/trace/ring_buffer.c                         |   5 +
 mm/filemap.c                                       |   9 +-
 mm/hmm.c                                           |   3 +-
 mm/ksm.c                                           |   7 +
 mm/page-writeback.c                                |  18 +-
 mm/slab.c                                          |   3 +-
 net/dsa/tag_brcm.c                                 |   3 +
 net/dsa/tag_dsa.c                                  |   3 +
 net/dsa/tag_edsa.c                                 |   3 +
 net/dsa/tag_ksz.c                                  |   3 +
 net/dsa/tag_lan9303.c                              |   3 +
 net/dsa/tag_mtk.c                                  |   3 +
 net/dsa/tag_qca.c                                  |   3 +
 net/dsa/tag_trailer.c                              |   3 +
 net/sunrpc/rpc_pipe.c                              |   1 +
 sound/core/oss/pcm_oss.c                           | 186 ++++++++++++++++----
 sound/core/pcm.c                                   |   8 +-
 sound/core/rawmidi_compat.c                        |  18 +-
 sound/pci/hda/hda_intel.c                          |   3 +-
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/soc/codecs/ssm2602.c                         |  19 +-
 sound/soc/soc-topology.c                           |  23 ++-
 sound/usb/line6/midi.c                             |   2 +-
 virt/kvm/arm/vgic/vgic-its.c                       |  15 +-
 178 files changed, 1886 insertions(+), 823 deletions(-)
