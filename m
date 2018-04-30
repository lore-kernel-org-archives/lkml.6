Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr9Y0h5QmSm9WuSHkF/nEJneymOCYxIhWhrBdTlE4wVQayYXVjriCZGbrDhiu/vS/pYIgaG
ARC-Seal: i=1; a=rsa-sha256; t=1525116430; cv=none;
        d=google.com; s=arc-20160816;
        b=RAKt6JO1yuJwYH3ziLIZVhAsk4vsyzriBLplgAWKR/Bcghq0SNZxhZD04PCfs0rEuP
         xHsuhwgWpsma9wI+ezb4/deKfdbVy+JcOWUQS/td0rrIMKFrXsZetZTQ1Dxs4Qa9N+5T
         w3tQQUH8HGCGN1WfrMjW22Yq6rGijDo6Yn+EFOSP+XgbiZGMsplwe92Svka8Udu6lO4K
         NGxZjqZLr+nTMdgDhLZAOKF0F017jm52bsME883923+J35y8MVdj7UlOoT8iwR0Ma8U2
         FP7jqSDnaLGY2GxTk0oknOeAeCKmiJSoxM8H7aOVglc3a1mnfYAIy8ey1PUcBunBS26P
         FQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0A+YSqy38ezXv8zdI5WHbSQbn0w5IKohTkf32Bm42ew=;
        b=yFSMb6FdXaBmBW9M245j9FoQbxpXP9S5U7Rc2RaJD33dZ23AQSHNMuq0+2HyAwPpjk
         GRaZk4Fqv7I5ErZEKKp/3zew1a4VgtVCXSmRgi6DSgCeF5YPT3owuEBX1J+GSBMRTPNr
         prDLRdmAoeNv3EUjhEsMU/bom66Yyk2VMhNvD/DU5MnpJZp/rMH/H+u4yBej7vTXevuA
         1wgDgEhMHBSPHo1e9EDjUnbjaONjebjPV+9F8NJKi62mYAvYROQFUtG2GbjyVZyE6zYY
         wuWy2kqevRfVwIBVYXpm3y/bAYTPj7e6SVNb3CWVPjsppsDyhPHhn3yW0MzKChjeoHh2
         kkyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE0022DAC
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
Subject: [PATCH 4.14 00/91] 4.14.39-stable review
Date: Mon, 30 Apr 2018 12:23:42 -0700
Message-Id: <20180430184004.216234025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.39-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.39-rc1
X-KernelTest-Deadline: 2018-05-02T18:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200485951851677?=
X-GMAIL-MSGID: =?utf-8?q?1599200485951851677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.39 release.
There are 91 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May  2 18:39:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.39-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.39-rc1

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net: don't call update_pmtu unconditionally

Michael Neuling <mikey@neuling.org>
    powerpc/eeh: Fix race with driver un/bind

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Add PSCI version selection API

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

Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
    tools/lib/subcmd/pager.c: do not alias select() params

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool, perf: Fix GCC 8 -Wrestrict error

Imre Deak <imre.deak@intel.com>
    drm/i915: Enable display WA#1183 from its correct spot

Nicolai Hähnle <nicolai.haehnle@amd.com>
    drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nicholas Piggin <npiggin@gmail.com>
    rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
    cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer interrupt

Daniel Kurtz <djkurtz@chromium.org>
    earlycon: Use a pointer table to fix __earlycon_table stride

Anatolij Gustschin <agust@denx.de>
    fpga-manager: altera-ps-spi: preserve nCONFIG state

Ilya Dryomov <idryomov@gmail.com>
    libceph: validate con->state at the top of try_write()

Ilya Dryomov <idryomov@gmail.com>
    libceph: reschedule a tick in finish_hunting()

Ilya Dryomov <idryomov@gmail.com>
    libceph: un-backoff on tick when we have a authenticated session

Nicolin Chen <nicoleotsuka@gmail.com>
    ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Stephan Mueller <smueller@chronox.de>
    crypto: drbg - set freed buffers to NULL

Alistair Popple <alistair@popple.id.au>
    powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large address range

Balbir Singh <bsingharora@gmail.com>
    powerpc/mm: Flush cache on memory hot(un)plug

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: Close VMID generation race

Thor Thayer <thor.thayer@linux.intel.com>
    ARM: socfpga_defconfig: Remove QSPI Sector 4K size force

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

Cornelia Huck <cohuck@redhat.com>
    vfio: ccw: process ssch with interrupts disabled

Jens Axboe <axboe@kernel.dk>
    bfq-iosched: ensure to clear bic/bfqq pointers when preparing request

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: sd: Defer spinning up drive while SANITIZE is in progress

Dmitry Vyukov <dvyukov@google.com>
    kobject: don't use WARN for registration failures

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

Kyle Roeschley <kyle.roeschley@ni.com>
    USB: serial: cp210x: add ID for NI USB serial console

Vasyl Vavrychuk <vvavrychuk@gmail.com>
    USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Collin May <collin@collinswebsite.com>
    USB: serial: simple: add libtransistor console

Kai-Heng Feng <kai.heng.feng@canonical.com>
    xhci: Fix USB ports for Dell Inspiron 5775

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

 Documentation/virtual/kvm/api.txt         |   9 +-
 Documentation/virtual/kvm/arm/psci.txt    |  30 ++++++
 Makefile                                  |   4 +-
 arch/arm/configs/socfpga_defconfig        |   1 +
 arch/arm/include/asm/kvm_host.h           |   3 +
 arch/arm/include/uapi/asm/kvm.h           |   6 ++
 arch/arm/kvm/guest.c                      |  13 +++
 arch/arm64/include/asm/kvm_host.h         |   3 +
 arch/arm64/include/uapi/asm/kvm.h         |   6 ++
 arch/arm64/kvm/guest.c                    |  14 ++-
 arch/powerpc/kernel/eeh_driver.c          |  61 +++++++-----
 arch/powerpc/mm/mem.c                     |   2 +
 arch/powerpc/platforms/powernv/npu-dma.c  |  23 ++++-
 arch/powerpc/platforms/powernv/opal-rtc.c |   8 +-
 arch/x86/include/uapi/asm/msgbuf.h        |  31 ++++++
 arch/x86/include/uapi/asm/shmbuf.h        |  42 ++++++++
 arch/x86/kernel/cpu/microcode/core.c      |   6 +-
 arch/x86/kernel/cpu/microcode/intel.c     |   2 -
 arch/x86/kernel/smpboot.c                 |   2 +
 block/bfq-iosched.c                       |  10 +-
 crypto/drbg.c                             |   2 +
 drivers/amba/bus.c                        |  17 ++--
 drivers/android/binder.c                  |   8 ++
 drivers/char/random.c                     |  90 ++++++++++++-----
 drivers/char/virtio_console.c             | 157 ++++++++++++++----------------
 drivers/cpufreq/powernv-cpufreq.c         |  14 ++-
 drivers/fpga/altera-ps-spi.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |   7 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c   |  11 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c       |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c   |   3 +-
 drivers/mtd/chips/cfi_cmdset_0001.c       |  33 ++++++-
 drivers/mtd/chips/cfi_cmdset_0002.c       |   9 +-
 drivers/mtd/nand/tango_nand.c             |   2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c     |  19 +++-
 drivers/net/vxlan.c                       |   6 +-
 drivers/of/fdt.c                          |   7 +-
 drivers/pci/host/pci-aardvark.c           |  53 +++++-----
 drivers/rtc/rtc-opal.c                    |  37 ++++---
 drivers/s390/cio/vfio_ccw_fsm.c           |  19 ++--
 drivers/scsi/sd.c                         |   2 +
 drivers/tty/n_gsm.c                       |  23 ++++-
 drivers/tty/serial/earlycon.c             |   6 +-
 drivers/tty/tty_io.c                      |   5 +-
 drivers/tty/tty_ldisc.c                   |  29 +++---
 drivers/usb/core/hcd.c                    |   1 +
 drivers/usb/core/hub.c                    |  10 +-
 drivers/usb/core/quirks.c                 |   3 +
 drivers/usb/host/xhci-pci.c               |   5 +-
 drivers/usb/host/xhci-plat.c              |   1 -
 drivers/usb/serial/Kconfig                |   1 +
 drivers/usb/serial/cp210x.c               |   1 +
 drivers/usb/serial/ftdi_sio.c             |   3 +-
 drivers/usb/serial/usb-serial-simple.c    |   7 ++
 drivers/usb/typec/ucsi/ucsi.c             |   2 +-
 drivers/usb/usbip/stub_main.c             |   5 +
 drivers/usb/usbip/usbip_common.h          |   2 +-
 drivers/usb/usbip/usbip_event.c           |   4 -
 drivers/usb/usbip/vhci_hcd.c              |  13 +++
 fs/ext4/balloc.c                          |  17 +++-
 fs/ext4/extents.c                         |  16 ++-
 fs/ext4/ialloc.c                          |   7 ++
 fs/ext4/super.c                           |   1 +
 fs/jbd2/transaction.c                     |   1 +
 include/asm-generic/vmlinux.lds.h         |   2 +-
 include/kvm/arm_psci.h                    |  16 ++-
 include/linux/mtd/flashchip.h             |   1 +
 include/linux/serial_core.h               |  21 ++--
 include/linux/tty.h                       |   2 +-
 include/linux/virtio.h                    |   3 +
 include/net/dst.h                         |   8 ++
 include/sound/control.h                   |   7 +-
 kernel/time/tick-sched.c                  |  11 ++-
 lib/kobject.c                             |  12 +--
 net/ceph/messenger.c                      |   7 ++
 net/ceph/mon_client.c                     |  14 ++-
 net/ipv4/ip_tunnel.c                      |   3 +-
 net/ipv4/ip_vti.c                         |   2 +-
 net/ipv6/ip6_tunnel.c                     |   5 +-
 net/ipv6/ip6_vti.c                        |   2 +-
 net/ipv6/sit.c                            |   4 +-
 sound/core/pcm_compat.c                   |   7 +-
 sound/core/pcm_native.c                   |  24 ++---
 sound/core/seq/oss/seq_oss_event.c        |  15 +--
 sound/core/seq/oss/seq_oss_midi.c         |   2 +
 sound/core/seq/oss/seq_oss_synth.c        |  85 +++++++++-------
 sound/core/seq/oss/seq_oss_synth.h        |   3 +-
 sound/drivers/opl3/opl3_synth.c           |   7 +-
 sound/firewire/dice/dice-stream.c         |   2 +-
 sound/firewire/dice/dice.c                |   2 +-
 sound/pci/asihpi/hpimsginit.c             |  13 ++-
 sound/pci/asihpi/hpioctl.c                |   4 +-
 sound/pci/hda/hda_hwdep.c                 |  12 ++-
 sound/pci/hda/patch_hdmi.c                |   9 +-
 sound/pci/hda/patch_realtek.c             |   5 +
 sound/pci/rme9652/hdspm.c                 |  24 +++--
 sound/pci/rme9652/rme9652.c               |   6 +-
 sound/soc/fsl/fsl_esai.c                  |   7 ++
 sound/usb/mixer_maps.c                    |   3 +
 tools/lib/str_error_r.c                   |   2 +-
 tools/lib/subcmd/pager.c                  |   5 +-
 virt/kvm/arm/arm.c                        |  15 ++-
 virt/kvm/arm/psci.c                       |  60 ++++++++++++
 103 files changed, 978 insertions(+), 395 deletions(-)
