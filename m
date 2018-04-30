Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpfoGw+KMDxI6+g+GHu5kIlQnMFVq8a9605l1nlYFe9+hAcIt5tsx88yJ+R9lW4hN2aq0qN
ARC-Seal: i=1; a=rsa-sha256; t=1525116493; cv=none;
        d=google.com; s=arc-20160816;
        b=lpHBIRGK7wZzZwzzXXFc71NeoAh5+8yj2IZWIRgswyjj2PQsQzQi1HJy6b/34j+fXK
         hV5cADevqofYpJRnk0vvtS6OdFP3ecuRJGHwUGJ6B2IjYbAkhlrBsQNEE30MySG0+LdV
         nk3ck03pH3fZvV9J20sFO6xszOkfSCjXywoYN9zKvakL1DxNTzFtjk+8kGedI0Ywo7Pi
         2SKzcRbsMroiRXXWBLixUgv8SEU97rNzUCe3ZFfW2FdlblxJmPEQyixUZUgex0cR+ZnC
         EJvdxt8XoUJpATYPBfbiVKkppAVrPKHGOEp8M/tYqbp51jGt2itY4CoenqkEWJwrfQtC
         wsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=a+1GhsQgcmXtwQMPZTFcuRtZtSFtmWbcPZvPXLZSKHU=;
        b=ddZWToKERbHskk3Y1ZHQRMe8k1PaQGMUlO8I0M0vOzzKI2Ou22OW2J51OD9mo8R87C
         ugn+GwaKUF8lwf8lAi/yXSzAw3hYyRkVhtk7Yk2YiiOQscvnctCKIqq+fiB7S4ochukl
         R3fMH7uaLO6zY3HygVLW6Lr5Ysj1RwUPoca6r3w834NwTTp6MVa5qazu8h6/e0nmbtSM
         GXbHsQuY0B0/8MQEjM0OvJ+kKF+wQLGnhWN275zMawyFGsMzp9nj8vIcxblXWGbHNr/P
         1kWGNrOXZ8EF3MUr+SGqGrOFEsfSc1SggF0O8V4F8G3WP86cbm9V04sWqZEmzjgD0lQw
         WLlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE15022E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.16 000/113] 4.16.7-stable review
Date: Mon, 30 Apr 2018 12:23:31 -0700
Message-Id: <20180430184015.043892819@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.7-rc1
X-KernelTest-Deadline: 2018-05-02T18:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200552563125993?=
X-GMAIL-MSGID: =?utf-8?q?1599200552563125993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.7 release.
There are 113 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May  2 18:39:46 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.7-rc1

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Add PSCI version selection API

Brijesh Singh <brijesh.singh@amd.com>
    crypto: ccp - add check to get PSP master only when PSP is detected

Thomas Gleixner <tglx@linutronix.de>
    tick/sched: Do not mess with an enqueued hrtimer

Borislav Petkov <bp@suse.de>
    x86/microcode: Do not exit early from __reload_late()

Borislav Petkov <bp@suse.de>
    x86/microcode/intel: Save microcode patch unconditionally

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/smpboot: Don't use mwait_play_dead() on AMD systems

Arnd Bergmann <arnd@arndb.de>
    x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool, perf: Fix GCC 8 -Wrestrict error

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Disallow enabling CRTC without primary plane with FB

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Don't read EDID in atomic_check

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Fix deadlock when flushing irq

Imre Deak <imre.deak@intel.com>
    drm/i915: Enable display WA#1183 from its correct spot

Abhay Kumar <abhay.kumar@intel.com>
    drm/i915/audio: set minimum CD clock to twice the BCLK

José Roberto de Souza <jose.souza@intel.com>
    drm/i915/fbdev: Enable late fbdev initial configuration

Nicolai Hähnle <nicolai.haehnle@amd.com>
    drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/edid: Reset more of the display info

Nicholas Piggin <npiggin@gmail.com>
    rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
    cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer interrupt

Daniel Kurtz <djkurtz@chromium.org>
    earlycon: Use a pointer table to fix __earlycon_table stride

Thomas Richter <tmricht@linux.ibm.com>
    module: Fix display of wrong module .text address

Anatolij Gustschin <agust@denx.de>
    fpga-manager: altera-ps-spi: preserve nCONFIG state

Hans de Goede <hdegoede@redhat.com>
    virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory

Hans de Goede <hdegoede@redhat.com>
    virt: vbox: Add vbg_req_free() helper function

Hans de Goede <hdegoede@redhat.com>
    virt: vbox: Move declarations of vboxguest private functions to private header

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart suspend is set

Ilya Dryomov <idryomov@gmail.com>
    libceph: validate con->state at the top of try_write()

Ilya Dryomov <idryomov@gmail.com>
    libceph: reschedule a tick in finish_hunting()

Ilya Dryomov <idryomov@gmail.com>
    libceph: un-backoff on tick when we have a authenticated session

Nicolin Chen <nicoleotsuka@gmail.com>
    ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Tero Kristo <t-kristo@ti.com>
    ASoC: dmic: Fix clock parenting

Stephan Mueller <smueller@chronox.de>
    crypto: drbg - set freed buffers to NULL

Alistair Popple <alistair@popple.id.au>
    powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large address range

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/mce: Fix a bug where mce loops on memory UE.

Balbir Singh <bsingharora@gmail.com>
    powerpc/mm: Flush cache on memory hot(un)plug

Geert Uytterhoeven <geert@linux-m68k.org>
    slimbus: Fix out-of-bounds access in slim_slicesize()

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: Close VMID generation race

Thor Thayer <thor.thayer@linux.intel.com>
    ARM: socfpga_defconfig: Remove QSPI Sector 4K size force

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix NAS4220B pin config

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Don't read past the end of sysfs "driver_override" buffer

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Fix race condition with driver_override

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Make driver_override output consistent with other buses

Evan Wang <xswang@marvell.com>
    PCI: aardvark: Fix PCIe Max Read Request Size setting

Victor Gu <xigu@marvell.com>
    PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

Victor Gu <xigu@marvell.com>
    PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()

Victor Gu <xigu@marvell.com>
    PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()

Martijn Coenen <maco@android.com>
    ANDROID: binder: prevent transactions into own process.

Steve French <stfrench@microsoft.com>
    SMB311: Fix reconnect

Cornelia Huck <cohuck@redhat.com>
    vfio: ccw: process ssch with interrupts disabled

Alan Jenkins <alan.christopher.jenkins@gmail.com>
    block: do not use interruptible wait anywhere

Jens Axboe <axboe@kernel.dk>
    bfq-iosched: ensure to clear bic/bfqq pointers when preparing request

Jianchao Wang <jianchao.w.wang@oracle.com>
    blk-mq: start request gstate with gen 1

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: sd: Defer spinning up drive while SANITIZE is in progress

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sd_zbc: Avoid that resetting a zone fails sporadically

Dmitry Vyukov <dvyukov@google.com>
    kobject: don't use WARN for registration failures

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: fix the chip-select DT parsing logic

Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
    mtd: rawnand: tango: Fix struct clk memory leak

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Joakim Tjernlund <joakim.tjernlund@transmode.se>
    mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.

Joakim Tjernlund <joakim.tjernlund@transmode.se>
    mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.

Thor Thayer <thor.thayer@linux.intel.com>
    mtd: spi-nor: cadence-quadspi: Fix page fault kernel panic

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - change the location for one of two front mics

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Update ALC255 depop optimize

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add some fixes for ALC233

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device

David Henningsson <diwic@ubuntu.com>
    ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Jeffery Miller <jmiller@neverware.com>
    ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.

Takashi Iwai <tiwai@suse.de>
    ALSA: control: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: rme9652: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: hdspm: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: asihpi: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: opl3: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Skip jack and others for non-existing PCM streams

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: dice: fix error path to destroy initialized stream data

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: dice: fix OUI for TC group

Long Li <longli@microsoft.com>
    cifs: smbd: Don't use RDMA read/write when signing is used

Long Li <longli@microsoft.com>
    cifs: smbd: Avoid allocating iov on the stack

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Use __GFP_NOFAIL for tty_ldisc_get()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Avoid possible error pointer dereference at tty_ldisc_restore().

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix long delays with control frame timeouts in ADM mode

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Don't call panic() at tty_ldisc_init()

Gerd Hoffmann <kraxel@redhat.com>
    drm/virtio: fix vq wait_event condition

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: reset on out of memory

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: move removal code

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: drop custom control queue cleanup

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: free buffers after reset

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: don't tie bufs to a vq

Michael S. Tsirkin <mst@redhat.com>
    virtio: add ability to iterate over vqs

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Skip broken EU on Dell dock USB-audio

Ravi Chandra Sadineni <ravisadineni@chromium.org>
    USB: Increment wakeup count on remote wakeup.

Kamil Lulko <kamilx.lulko@intel.com>
    usb: core: Add quirk for HP v222w 16GB Mini

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: Increase command completion timeout value

Marc Zyngier <marc.zyngier@arm.com>
    serial: mvebu-uart: Fix local flags handling on termios update

Kyle Roeschley <kyle.roeschley@ni.com>
    USB: serial: cp210x: add ID for NI USB serial console

Vasyl Vavrychuk <vvavrychuk@gmail.com>
    USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Collin May <collin@collinswebsite.com>
    USB: serial: simple: add libtransistor console

Kai-Heng Feng <kai.heng.feng@canonical.com>
    xhci: Fix USB ports for Dell Inspiron 5775

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: Fix Kernel oops in xhci dbgtty

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "xhci: plat: Register shutdown for xhci_plat"

Shuah Khan <shuah@kernel.org>
    usbip: vhci_hcd: check rhport before using in vhci_hub_control()

Shuah Khan <shuah@kernel.org>
    usbip: vhci_hcd: Fix usb device and sockfd leaks

Shuah Khan <shuah@kernel.org>
    usbip: usbip_host: fix to hold parent lock for device_attach() calls

Shuah Khan <shuah@kernel.org>
    usbip: usbip_event: fix to not print kernel pointer address

Theodore Ts'o <tytso@mit.edu>
    random: rate limit unseeded randomness warnings

Theodore Ts'o <tytso@mit.edu>
    random: fix possible sleeping allocation from irq context

Theodore Ts'o <tytso@mit.edu>
    random: set up the NUMA crng instances after the CRNG is fully initialized

Lukas Czerner <lczerner@redhat.com>
    ext4: fix bitmap position validation

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Theodore Ts'o <tytso@mit.edu>
    ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs

Theodore Ts'o <tytso@mit.edu>
    ext4: set h_journal if there is a failure starting a reserved handle

Eric Biggers <ebiggers@google.com>
    ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                  |   9 +-
 Documentation/virtual/kvm/arm/psci.txt             |  30 ++++
 Makefile                                           |   4 +-
 arch/arm/boot/dts/gemini-nas4220b.dts              |  28 ++--
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm/include/asm/kvm_host.h                    |   3 +
 arch/arm/include/uapi/asm/kvm.h                    |   6 +
 arch/arm/kvm/guest.c                               |  13 ++
 arch/arm64/include/asm/kvm_host.h                  |   3 +
 arch/arm64/include/uapi/asm/kvm.h                  |   6 +
 arch/arm64/kvm/guest.c                             |  14 +-
 arch/powerpc/kernel/mce_power.c                    |   7 +-
 arch/powerpc/mm/mem.c                              |   2 +
 arch/powerpc/platforms/powernv/npu-dma.c           |  23 ++-
 arch/powerpc/platforms/powernv/opal-rtc.c          |   8 +-
 arch/x86/include/uapi/asm/msgbuf.h                 |  31 ++++
 arch/x86/include/uapi/asm/shmbuf.h                 |  42 ++++++
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   2 -
 arch/x86/kernel/smpboot.c                          |   2 +
 block/bfq-iosched.c                                |  10 +-
 block/blk-core.c                                   |  15 +-
 block/blk-mq.c                                     |   7 +
 crypto/drbg.c                                      |   2 +
 drivers/amba/bus.c                                 |  17 ++-
 drivers/android/binder.c                           |   8 ++
 drivers/char/random.c                              |  90 +++++++++---
 drivers/char/virtio_console.c                      | 157 ++++++++++-----------
 drivers/cpufreq/powernv-cpufreq.c                  |  14 +-
 drivers/crypto/ccp/sp-dev.c                        |   6 +-
 drivers/fpga/altera-ps-spi.c                       |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  32 ++---
 drivers/gpu/drm/drm_edid.c                         |  11 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |  16 ++-
 drivers/gpu/drm/i915/intel_fbdev.c                 |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  11 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   4 +-
 drivers/mtd/chips/cfi_cmdset_0001.c                |  33 ++++-
 drivers/mtd/chips/cfi_cmdset_0002.c                |   9 +-
 drivers/mtd/nand/marvell_nand.c                    |  25 ++--
 drivers/mtd/nand/tango_nand.c                      |   2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c              |  19 ++-
 drivers/of/fdt.c                                   |   7 +-
 drivers/pci/host/pci-aardvark.c                    |  53 ++++---
 drivers/pci/pci-driver.c                           |   5 +-
 drivers/rtc/rtc-opal.c                             |  37 +++--
 drivers/s390/cio/vfio_ccw_fsm.c                    |  19 ++-
 drivers/scsi/sd.c                                  |   2 +
 drivers/scsi/sd_zbc.c                              | 140 ++++++++++--------
 drivers/slimbus/messaging.c                        |   2 +-
 drivers/tty/n_gsm.c                                |  23 ++-
 drivers/tty/serial/earlycon.c                      |   6 +-
 drivers/tty/serial/mvebu-uart.c                    |   1 -
 drivers/tty/tty_io.c                               |   5 +-
 drivers/tty/tty_ldisc.c                            |  29 ++--
 drivers/usb/core/hcd.c                             |   1 +
 drivers/usb/core/hub.c                             |  10 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/host/xhci-dbgtty.c                     |   8 +-
 drivers/usb/host/xhci-pci.c                        |   5 +-
 drivers/usb/host/xhci-plat.c                       |   1 -
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +-
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/typec/ucsi/ucsi.c                      |   2 +-
 drivers/usb/usbip/stub_main.c                      |   5 +
 drivers/usb/usbip/usbip_common.h                   |   2 +-
 drivers/usb/usbip/usbip_event.c                    |   4 -
 drivers/usb/usbip/vhci_hcd.c                       |  13 ++
 drivers/virt/vboxguest/vboxguest_core.c            |  66 +++++----
 drivers/virt/vboxguest/vboxguest_core.h            |   9 ++
 drivers/virt/vboxguest/vboxguest_linux.c           |  19 ++-
 drivers/virt/vboxguest/vboxguest_utils.c           |  17 ++-
 fs/cifs/cifssmb.c                                  |   3 +
 fs/cifs/smb2ops.c                                  |  18 ++-
 fs/cifs/smb2pdu.c                                  |   4 +-
 fs/cifs/smbdirect.c                                |  36 ++---
 fs/cifs/transport.c                                |   4 +-
 fs/ext4/balloc.c                                   |  17 ++-
 fs/ext4/extents.c                                  |  16 ++-
 fs/ext4/ialloc.c                                   |   7 +
 fs/ext4/super.c                                    |   1 +
 fs/jbd2/transaction.c                              |   1 +
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 include/kvm/arm_psci.h                             |  16 ++-
 include/linux/blkdev.h                             |   5 +
 include/linux/mtd/flashchip.h                      |   1 +
 include/linux/serial_core.h                        |  21 ++-
 include/linux/tty.h                                |   2 +-
 include/linux/vbox_utils.h                         |  23 ---
 include/linux/virtio.h                             |   3 +
 include/sound/control.h                            |   7 +-
 kernel/module.c                                    |   3 +-
 kernel/time/tick-sched.c                           |  11 +-
 lib/kobject.c                                      |  12 +-
 net/ceph/messenger.c                               |   7 +
 net/ceph/mon_client.c                              |  14 +-
 sound/core/pcm_compat.c                            |   7 +-
 sound/core/pcm_native.c                            |  24 ++--
 sound/core/seq/oss/seq_oss_event.c                 |  15 +-
 sound/core/seq/oss/seq_oss_midi.c                  |   2 +
 sound/core/seq/oss/seq_oss_synth.c                 |  85 ++++++-----
 sound/core/seq/oss/seq_oss_synth.h                 |   3 +-
 sound/drivers/opl3/opl3_synth.c                    |   7 +-
 sound/firewire/dice/dice-stream.c                  |   2 +-
 sound/firewire/dice/dice.c                         |   2 +-
 sound/pci/asihpi/hpimsginit.c                      |  13 +-
 sound/pci/asihpi/hpioctl.c                         |   4 +-
 sound/pci/hda/hda_hwdep.c                          |  12 +-
 sound/pci/hda/patch_hdmi.c                         |   9 +-
 sound/pci/hda/patch_realtek.c                      |   5 +
 sound/pci/rme9652/hdspm.c                          |  24 ++--
 sound/pci/rme9652/rme9652.c                        |   6 +-
 sound/soc/fsl/fsl_esai.c                           |   7 +
 sound/soc/omap/omap-dmic.c                         |  14 +-
 sound/usb/mixer_maps.c                             |   3 +
 tools/lib/str_error_r.c                            |   2 +-
 virt/kvm/arm/arm.c                                 |  15 +-
 virt/kvm/arm/psci.c                                |  60 ++++++++
 123 files changed, 1215 insertions(+), 600 deletions(-)
