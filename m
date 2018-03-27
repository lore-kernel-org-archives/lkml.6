Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tNSCaqermeB6LSD2jPdhIk6qM7T5/vHgfo5DDEGNX2y9QztA9qBI3P/30lGctLljXudqK
ARC-Seal: i=1; a=rsa-sha256; t=1522168132; cv=none;
        d=google.com; s=arc-20160816;
        b=b2gd0nWkGH9D9KmMY2Q+21rHTOra9ZEGA8mxp9JvaZzYwBa1N+95VHkB57O7NzyYKl
         kn86tLeHSAdQ7IMsdHIhOU5sMyhKhTWD8YQ9Ev+gjVGhUCfcA1pRvKhCm8U0OA8k1xwa
         6oaAtufwlp+zePLOVRO+jfyE1eBU4m6Lm5VCcY11V/DeN6hdcQOO9xsgSCxrNGXI0PcD
         NlkkEbDU6E7+AWmr6zFi1H71jn5ZCnyFsLsuylWZNjmWHa9qz3OLV3cVVHaNdWRQbht8
         puZjkX6NVGPsStc/xWSmIgqiIkcEfTUR2sgmeHU4DrBXgtJK8o1NTVeO12WVetB6suHx
         qR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p2zbUKUw56cYz/ntEF8xP5mmk43f1xuvKQEND/1gzDc=;
        b=wF61rQwEnUoxzZtgcHAbmJ5e2eXrB/KDGVAUG33LKzZFRLr1m900RfBXdGEGIWxid1
         9fT4UVbIrFAz1bXVOXpv95wAgt5ZXuii+j8oxj2Dpf83ymBS2Jr6VcCqaW6Dsp4mr4/v
         TUlCYiaj4HvYd5+gbhmvxUBFi8PABNXVMAOIOW1fJTU6kH3csh9TqKfRCUchnHeV4Vi/
         A4dDKWsezlF1QLWn+nHPvbYwRCa1CaTiMYcL+N23SicGR61vdNUdSwAGhyCR5/OoDmIC
         +bx/5omNRv5U1nEZbSfq7F2ssMDIl6uvLzXi0zkMI0BB0Me3pfH211uoFWg2s2EJR5j1
         0S+g==
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
Subject: [PATCH 4.4 00/43] 4.4.125-stable review
Date: Tue, 27 Mar 2018 18:27:04 +0200
Message-Id: <20180327162716.407986916@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.125-rc1
X-KernelTest-Deadline: 2018-03-29T16:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108971471558440?=
X-GMAIL-MSGID: =?utf-8?q?1596108971471558440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.125 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.125-rc1

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: increase number of passes

Chenbo Feng <fengc@google.com>
    bpf: skip unnecessary capability check

Daniel Borkmann <daniel@iogearbox.net>
    kbuild: disable clang's default use of -fmerge-all-constants

Nadav Amit <namit@vmware.com>
    staging: lustre: ptlrpc: kfree used instead of kvfree

Dan Carpenter <dan.carpenter@oracle.com>
    perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Don't use IST entry for #BP stack

H.J. Lu <hjl.tools@gmail.com>
    x86/boot/64: Verify alignment of the LOAD segment

H.J. Lu <hjl.tools@gmail.com>
    x86/build/64: Force the linker to use 2MB page size

Linus Torvalds <torvalds@linux-foundation.org>
    kvm/x86: fix icebp instruction handling

Linus Torvalds <torvalds@linux-foundation.org>
    tty: vt: fix up tabstops properly

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix use after free in cc770_tx_interrupt()

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix queue stall & dropped RTR reply

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack

Dan Carpenter <dan.carpenter@oracle.com>
    staging: ncpfs: memory corruption in ncp_read_kernel()

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Fix nand waitfunc return value

Masami Hiramatsu <mhiramat@kernel.org>
    tracing: probeevent: Fix to support minus offset from symbol

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8723be: Fix loss of signal

Arend Van Spriel <arend.vanspriel@broadcom.com>
    brcmfmac: fix P2P_DEVICE ethernet address generation

Dan Williams <dan.j.williams@intel.com>
    acpi, numa: fix pxm to online numa node associations

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    drm: udl: Properly check framebuffer mmap offsets

Michel Dänzer <michel.daenzer@amd.com>
    drm/radeon: Don't turn off DP sink when disconnected

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a destoy-while-held mutex problem.

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: implement free pmd/pte page interfaces

Toshi Kani <toshi.kani@hpe.com>
    mm/vmalloc: add interfaces to free unmapped page table

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
    libata: remove WARN() for DMA or PIO command without data

Eric Biggers <ebiggers@google.com>
    libata: fix length validation of ATAPI-relayed SCSI commands

Takashi Iwai <tiwai@suse.de>
    Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: Protect sections updating shared registers

Hans de Goede <hdegoede@redhat.com>
    ahci: Add PCI-id for the Highpoint Rocketraid 644L card

Hans de Goede <hdegoede@redhat.com>
    PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L

Evgeniy Didin <Evgeniy.Didin@synopsys.com>
    mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Always immediately update mute LED with pin VREF

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Fix access to not-yet-ready substream via cable

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Sync stale timer before release

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Michael Nosthoff <committed@heine.so>
    iio: st_pressure: st_accel: pass correct platform data to init

NeilBrown <neil@brown.name>
    MIPS: ralink: Remove ralink_halt()


-------------

Diffstat:

 Makefile                                           |  13 ++-
 arch/arm64/mm/mmu.c                                |  10 +++
 arch/mips/ralink/reset.c                           |   7 --
 arch/x86/Makefile                                  |   9 ++
 arch/x86/boot/compressed/misc.c                    |   4 +
 arch/x86/entry/entry_64.S                          |   2 +-
 arch/x86/include/asm/vmx.h                         |   1 +
 arch/x86/kernel/cpu/perf_event_intel.c             |   2 +-
 arch/x86/kernel/traps.c                            |  24 +++--
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/mm/pgtable.c                              |  48 ++++++++++
 arch/x86/net/bpf_jit_comp.c                        |   3 +-
 drivers/acpi/numa.c                                |  10 ++-
 drivers/ata/ahci.c                                 |   4 +-
 drivers/ata/libata-core.c                          |  26 +++++-
 drivers/ata/libata-scsi.c                          |   4 +-
 drivers/bluetooth/btusb.c                          |   2 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   4 +
 drivers/gpu/drm/radeon/radeon_connectors.c         |  31 +++----
 drivers/gpu/drm/udl/udl_fb.c                       |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  28 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   5 +-
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/pressure/st_pressure_core.c            |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   6 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |   5 +-
 drivers/net/can/cc770/cc770.c                      | 100 +++++++++++++--------
 drivers/net/can/cc770/cc770.h                      |   2 +
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c      |  24 +++--
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |   3 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   2 +-
 drivers/tty/vt/vt.c                                |   8 +-
 fs/ncpfs/ncplib_kernel.c                           |   4 +
 include/asm-generic/pgtable.h                      |  10 +++
 include/uapi/linux/usb/audio.h                     |   4 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/trace/trace_kprobe.c                        |   4 +-
 kernel/trace/trace_probe.c                         |   8 +-
 kernel/trace/trace_probe.h                         |   2 +-
 lib/ioremap.c                                      |   6 +-
 sound/drivers/aloop.c                              |  17 +++-
 sound/pci/hda/patch_realtek.c                      |   6 +-
 45 files changed, 338 insertions(+), 153 deletions(-)
