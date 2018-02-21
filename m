Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224jLZaRbcrCenpZjSmDRTyCtcXzwhPNIS5EMJK5u2vRYQ6ndA1/11w5lJRqM10fJ1PFVoep
ARC-Seal: i=1; a=rsa-sha256; t=1519217670; cv=none;
        d=google.com; s=arc-20160816;
        b=0V1h+ahDcAXRFjGreMXiiZ2yK1ipTQB8xqGzgHX/FTwGBDNP03YOZwO9fLBAaZlIco
         ZS4mtciWiAPOsNdXMdfovEYnuEFkIdxppPDcX7QArPHsWzyVZmOtZz7lkDrJ1ERW0PhQ
         HfnuqdS22JG1h22gwjBprR4xKUkCaT4nxKHK6iRIx7wSI9DwliyG0g4THjjNeZ0xjZDs
         kNVZeOD9A5iTlhdNA1o/BISaSgnG3YqdwiWvpJK69LNNG+RGlERsUK/vV0wlkO2gI9wb
         +s4obZABDeWo09QFxenpnktgXPW6/4eZfA3DjOHqWw/UtmhUY5wqAQd1YLzdGVArb+Up
         f7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kExLmME2f7S5zsjdrHHNrpvd7YMJkpr68WMvxoVFEQo=;
        b=cC9XHrOe0QhMiAeYgIXGKmpi/DZqLwqUg2uV6xmhDdNEe2xqyeF2d0FMDyn4lyrNaX
         HV5aqkLf4Nwz5EEfsAz0KTYWKytAw+8l1ebuyBvuAN6tKNCdnLJA2FX1tTyNm9yzlZxj
         W6DwfHhQ35bxasXOfZoSGDUKCj/FKDvO9+H79TiPBozFsh9s/lKeHzkscREVfZzItQDi
         K0yXLhuWboAi/93Z4lDPIw122AQt0xP0aDthdT78OSBBW9qNvXVEKx5XRaXzOwJ2r1jZ
         PhOfR3MpHeApE9ji1GMDg0IEvT/EjZ09COAGQaYAGdDnLk6cTH53+bgtmjvBvuXAQVpQ
         SmDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 00/77] 4.9.83-stable review
Date: Wed, 21 Feb 2018 13:48:09 +0100
Message-Id: <20180221124432.172390020@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.83-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.83-rc1
X-KernelTest-Deadline: 2018-02-23T12:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015188041868683?=
X-GMAIL-MSGID: =?utf-8?q?1593015188041868683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.83 release.
There are 77 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 23 12:44:14 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.83-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.83-rc1

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb

yinbo.zhu <yinbo.zhu@nxp.com>
    mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec

Arnd Bergmann <arnd@arndb.de>
    media: r820t: fix r820t_write_reg for KASAN

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Delete bogus reference to the charlcd

Matthias Brugger <matthias.bgg@gmail.com>
    arm: dts: mt2701: Add reset-cells

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: s5pv210: add interrupt-parent for ohci

Bjorn Andersson <bjorn.andersson@linaro.org>
    arm64: dts: msm8916: Add missing #phy-cells

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa/tosa-bt: add MODULE_LICENSE tag

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: exynos: fix RTC interrupt for exynos5410

Linus Torvalds <torvalds@linux-foundation.org>
    vfs: don't do RCU lookup of empty pathnames

Arnd Bergmann <arnd@arndb.de>
    x86: fix build warnign with 32-bit PAE

Gustavo A. R. Silva <garsilva@embeddedor.com>
    x86/cpu: Change type of x86_cache_size variable to unsigned int

Dan Carpenter <dan.carpenter@oracle.com>
    x86/spectre: Fix an error message

Jia Zhang <qianyue.zj@alibaba-inc.com>
    x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Rui Wang <rui.y.wang@intel.com>
    selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Peter Zijlstra <peterz@infradead.org>
    x86/speculation: Add <asm/msr-index.h> dependency

Will Deacon <will.deacon@arm.com>
    nospec: Move array_index_nospec() parameter checking into separate macro

Dan Williams <dan.j.williams@intel.com>
    x86/speculation: Fix up array_index_nospec_mask() asm constraint

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c

Dominik Brodowski <linux@dominikbrodowski.net>
    selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c

Ingo Molnar <mingo@kernel.org>
    selftests/x86/pkeys: Remove unused functions

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Clean up various Spectre related details

KarimAllah Ahmed <karahmed@amazon.de>
    X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs

David Woodhouse <dwmw@amazon.co.uk>
    KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Correct Speculation Control microcode blacklist again

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Update Speculation Control microcode blacklist

Geert Uytterhoeven <geert@linux-m68k.org>
    compiler-gcc.h: Introduce __optimize function attribute

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix spics gpio controller's warning

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix dmas cells

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear600: Add missing interrupt-parent of rtc

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: nomadik: add interrupt-parent for clcd

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Arnd Bergmann <arnd@arndb.de>
    ARM: lpc3250: fix uda1380 gpio numbers

Bjorn Andersson <bjorn.andersson@linaro.org>
    arm64: dts: msm8916: Correct ipc references for smsm

Eugene Syromiatnikov <esyr@redhat.com>
    s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Gang He <ghe@suse.com>
    ocfs2: try a blocking lock before return AOP_TRUNCATED_PAGE

Bjorn Andersson <bjorn.andersson@linaro.org>
    PM / devfreq: Propagate error from devfreq_add_device()

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
    cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix a race condition related to the QP error state

Arnd Bergmann <arnd@arndb.de>
    kselftest: fix OOM in memory compaction test

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/qib: Fix comparison error with qperf compare/swap test

Nicholas Piggin <npiggin@gmail.com>
    powerpc: fix build errors in stable tree

NeilBrown <neilb@suse.com>
    dm: correctly handle chained bios in dec_pending()

James Hogan <jhogan@kernel.org>
    usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT

Mikulas Patocka <mpatocka@redhat.com>
    mvpp2: fix multicast address filter

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix racy pool initializations

Lassi Ylikojola <lassi.ylikojola@gmail.com>
    ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Jan-Marek Glogowski <glogow@fbihome.de>
    ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Fix headset mic detection problem for two Dell machines

Stefan Agner <stefan@agner.ch>
    mtd: nand: vf610: set correct ooblayout

Greg Kurz <groug@kaod.org>
    9p/trans_virtio: discard zero-length reply

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected -EEXIST when creating new inode

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix extent state leak from tree log

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix crash due to not cleaning up tree log block's dirty bits

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix deadlock in run_delalloc_nocow

David Disseldorp <ddiss@suse.de>
    target/iscsi: avoid NULL dereference in CHAP auth error path

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8821ae: Fix connection lost problem correctly

Nicolas Pitre <nicolas.pitre@linaro.org>
    console/dummy: leave .con_font_get set to NULL

Johan Hovold <johan@kernel.org>
    video: fbdev: atmel_lcdfb: fix display-timings lookup

Johan Hovold <johan@kernel.org>
    PCI: keystone: Fix interrupt-controller-node lookup

Corentin Labbe <clabbe.montjoie@gmail.com>
    MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN

Jan H. Schönherr <jschoenh@amazon.de>
    mm: Fix memory size alignment in devm_memremap_pages_release()

Arnd Bergmann <arnd@arndb.de>
    mm: hide a #warning for COMPILE_TEST

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    ext4: correct documentation for grpid mount option

Zhouyi Zhou <zhouzhouyi@gmail.com>
    ext4: save error to disk in __ext4_grp_locked_error()

Harshad Shirwadkar <harshads@google.com>
    ext4: fix a race in the ext4 shutdown path

Tobin C. Harding <me@tobin.cc>
    jbd2: fix sphinx kernel-doc build warnings

Alexander Potapenko <glider@google.com>
    mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Stewart Smith <stewart@linux.vnet.ibm.com>
    rtc-opal: Fix handling of firmware error codes, prevent busy loops

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/radeon: adjust tested variable

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: Add dpm quirk for Jet PRO (v2)

Steffen Weber <steffen.weber@gmail.com>
    scsi: smartpqi: allow static build ("built-in")


-------------

Diffstat:

 Documentation/devicetree/bindings/dma/snps-dma.txt |   2 +-
 Documentation/filesystems/ext4.txt                 |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi          |   5 -
 arch/arm/boot/dts/exynos5410.dtsi                  |   1 -
 arch/arm/boot/dts/lpc3250-ea3250.dts               |   4 +-
 arch/arm/boot/dts/lpc3250-phy3250.dts              |   4 +-
 arch/arm/boot/dts/mt2701.dtsi                      |   2 +
 arch/arm/boot/dts/s5pv210.dtsi                     |   1 +
 arch/arm/boot/dts/spear1310-evb.dts                |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |   4 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/spear600.dtsi                    |   1 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |   1 +
 arch/arm/boot/dts/stih407.dtsi                     |   3 +-
 arch/arm/boot/dts/stih410.dtsi                     |   3 +-
 arch/arm/mach-pxa/tosa-bt.c                        |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +-
 arch/mips/Kconfig                                  |  12 +-
 arch/powerpc/kernel/entry_64.S                     |   5 +
 arch/s390/kernel/compat_linux.c                    |   8 +-
 arch/x86/entry/entry_64_compat.S                   |  30 ++
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/lbr.c                        |   2 +-
 arch/x86/events/intel/p6.c                         |   2 +-
 arch/x86/include/asm/acpi.h                        |   2 +-
 arch/x86/include/asm/barrier.h                     |   2 +-
 arch/x86/include/asm/nospec-branch.h               |   1 +
 arch/x86/include/asm/processor.h                   |   4 +-
 arch/x86/kernel/amd_nb.c                           |   2 +-
 arch/x86/kernel/asm-offsets_32.c                   |   2 +-
 arch/x86/kernel/cpu/amd.c                          |  26 +-
 arch/x86/kernel/cpu/bugs.c                         |  28 +-
 arch/x86/kernel/cpu/centaur.c                      |   4 +-
 arch/x86/kernel/cpu/common.c                       |  10 +-
 arch/x86/kernel/cpu/cyrix.c                        |   2 +-
 arch/x86/kernel/cpu/intel.c                        |  31 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |   2 +-
 arch/x86/kernel/cpu/mtrr/main.c                    |   4 +-
 arch/x86/kernel/cpu/proc.c                         |   8 +-
 arch/x86/kernel/head_32.S                          |   4 +-
 arch/x86/kernel/mpparse.c                          |   2 +-
 arch/x86/kvm/mmu.c                                 |  10 +-
 arch/x86/kvm/vmx.c                                 |   4 +-
 arch/x86/lib/cpu.c                                 |   2 +-
 drivers/char/hw_random/via-rng.c                   |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/longhaul.c                         |   6 +-
 drivers/cpufreq/p4-clockmod.c                      |   2 +-
 drivers/cpufreq/powernow-k7.c                      |   2 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   4 +-
 drivers/cpufreq/speedstep-centrino.c               |   4 +-
 drivers/cpufreq/speedstep-lib.c                    |   6 +-
 drivers/crypto/padlock-aes.c                       |   2 +-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/edac/amd64_edac.c                          |   2 +-
 drivers/edac/mce_amd.c                             |   2 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   5 +
 drivers/hwmon/coretemp.c                           |   6 +-
 drivers/hwmon/hwmon-vid.c                          |   2 +-
 drivers/hwmon/k10temp.c                            |   2 +-
 drivers/hwmon/k8temp.c                             |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |  13 +-
 drivers/infiniband/hw/qib/qib_rc.c                 |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   2 +
 drivers/md/dm.c                                    |   3 +-
 drivers/media/tuners/r820t.c                       |  13 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   8 +
 drivers/mtd/nand/vf610_nfc.c                       |   6 +-
 drivers/net/ethernet/marvell/mvpp2.c               |  11 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c            |   3 +
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   5 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   1 +
 drivers/pci/host/pci-keystone.c                    |   5 +-
 drivers/rtc/rtc-opal.c                             |  12 +-
 drivers/scsi/smartpqi/Makefile                     |   2 +-
 drivers/target/iscsi/iscsi_target_auth.c           |   3 +-
 drivers/usb/Kconfig                                |   8 +
 drivers/usb/host/Kconfig                           |   8 -
 drivers/video/console/dummycon.c                   |   1 -
 drivers/video/fbdev/atmel_lcdfb.c                  |   8 +-
 drivers/video/fbdev/geode/video_gx.c               |   2 +-
 fs/btrfs/inode.c                                   |   7 +-
 fs/btrfs/tree-log.c                                |  32 +-
 fs/ext4/inode.c                                    |  16 +-
 fs/ext4/super.c                                    |   1 +
 fs/jbd2/transaction.c                              |   5 +-
 fs/mbcache.c                                       |   1 +
 fs/namei.c                                         |   3 +
 fs/ocfs2/dlmglue.c                                 |   9 +
 include/linux/compiler-gcc.h                       |   4 +
 include/linux/compiler.h                           |   4 +
 include/linux/jbd2.h                               | 431 +++++++++++++--------
 include/linux/kaiser.h                             |   2 +-
 include/linux/nospec.h                             |  36 +-
 kernel/memremap.c                                  |   3 +-
 mm/memory.c                                        |   2 +-
 net/9p/trans_virtio.c                              |   3 +-
 sound/core/seq/seq_clientmgr.c                     |   8 +-
 sound/pci/hda/patch_realtek.c                      |  70 ++++
 sound/usb/mixer.c                                  |  18 +-
 sound/usb/pcm.c                                    |   9 +
 tools/testing/selftests/vm/compaction_test.c       |   2 +
 tools/testing/selftests/x86/Makefile               |   2 +
 tools/testing/selftests/x86/mpx-mini-test.c        |  32 +-
 tools/testing/selftests/x86/protection_keys.c      |  28 --
 tools/testing/selftests/x86/single_step_syscall.c  |   5 +-
 tools/testing/selftests/x86/test_mremap_vdso.c     |   4 +
 110 files changed, 766 insertions(+), 417 deletions(-)
