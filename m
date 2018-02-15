Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225GwVdz7bqtN4NOChjTUYUPuWH7GD5yHyNmTKx9HRlCcz5XYbvTq0+/h46cxqPg8yJT1E0L
ARC-Seal: i=1; a=rsa-sha256; t=1518708386; cv=none;
        d=google.com; s=arc-20160816;
        b=JD3l7Kr3cx7IyR5aEGYUun5efPrCMqMnV1z7K7l6ReKIHo4W5tdmBKMHBVc6dnGrsa
         ee8Cb41Tp4iLaByWN+Jyj2YzwTEWIgzwlk5FCjIJXfA2XjgJIBWmeh2md7KEWvAdWX5a
         xh7Tl2SYqBt1eOtEzL/8cvmUZIcNJ6GH6ZEFTH7iuvs7G00c8CngTxvMcL9m8BiyvO3U
         u+tKbifpzpX3PcbYi38CmFzJS8k5o1i1a8xNNI2Ac9NER2V8qj7vX4sp+4OTb8Ii1HqS
         NNY1yDs4mWgjAWneZYPg0ZXRRDkvOywDRXrOHYPnv9bBwfYMkqIsLJg8cT3xdRE3Y6rq
         3Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NLHaq6X1u2A8a7Tnbpo/VnFDd1BaV4jhdWiQcgrVfng=;
        b=jAuaM+EbEJhWmZ164ubQ3NMtv0jMOZWR+5Q0nr3rAHBlzdVpJQyhiHxqmrZ5P5DJY6
         sPt47KXGdPiHgUOn+604ifXuBCYOk1PRf2qGl4JNBotl6cVkaHydaY8YBx10Ogvdhb/F
         hwOUHqH4JPJHkYiBlT0pgRtM2MS7rsQlS6tU95b/ha5CPKZ//tAbyiIa5UKZlX/wxDEL
         LNGiRm9xwdJiv//1bm389ExhOrxTsy7RGEc5T1opXDtMi0nJ/I+ifXv3nDef8dkWi9m9
         OCutfjSBP5H7cUrU7fEkmLJHAH0mxZn+wK3V5sSAT/pppfDbwSODVtZeytprLaqs+y4d
         T8ZQ==
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
Subject: [PATCH 4.9 00/88] 4.9.82-stable review
Date: Thu, 15 Feb 2018 16:16:27 +0100
Message-Id: <20180215151222.437136975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.82-rc1
X-KernelTest-Deadline: 2018-02-17T15:12+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481165175216146?=
X-GMAIL-MSGID: =?utf-8?q?1592481165175216146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.82 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 17 15:11:46 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.82-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.82-rc1

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace: Remove incorrect setting of glob search field

Eric W. Biederman <ebiederm@xmission.com>
    mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy

Amir Goldstein <amir73il@gmail.com>
    ovl: fix failure to fsync lower dir

Toshi Kani <toshi.kani@hpe.com>
    acpi, nfit: fix register dimm error handling

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ACPI: sbshc: remove raw pointer from printk() message

Imre Deak <imre.deak@intel.com>
    drm/i915: Avoid PPS HW/SW state mismatch due to rounding

Nikolay Borisov <nborisov@suse.com>
    btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Andrey Ryabinin <aryabinin@virtuozzo.com>
    lib/ubsan: add type mismatch handler for new GCC/Clang

Andrew Morton <akpm@linux-foundation.org>
    lib/ubsan.c: s/missaligned/misaligned/

Daniel Lezcano <daniel.lezcano@linaro.org>
    clocksource/drivers/stm32: Fix kernel panic with multiple timers

Bart Van Assche <bart.vanassche@wdc.com>
    pktcdvd: Fix pkt_setup_dev() error path

Mika Westerberg <mika.westerberg@linux.intel.com>
    pinctrl: intel: Initialize GPIO properly when used through irqchip

James Hogan <jhogan@kernel.org>
    EDAC, octeon: Fix an uninitialized variable warning

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix futex_atomic_cmpxchg_inatomic

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix formating of stack content

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix reboot on Avanti platform

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix crash if pthread_create races with signal delivery

Eric W. Biederman <ebiederm@xmission.com>
    signal/sh: Ensure si_signo is initialized in do_divide_error

Eric W. Biederman <ebiederm@xmission.com>
    signal/openrisc: Fix do_unaligned_access to send the proper signal

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btsdio: Do not bind to non-removable BCM43341

Hans de Goede <hdegoede@redhat.com>
    HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working

Eric Biggers <ebiggers@google.com>
    pipe: fix off-by-one error when checking buffer limits

Eric Biggers <ebiggers@google.com>
    pipe: actually allow root to exceed the pipe buffer limits

Eric Biggers <ebiggers@google.com>
    kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    kernel/async.c: revert "async: simplify lowest_in_progress()"

Heiko Carstens <heiko.carstens@de.ibm.com>
    fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: ts2020: avoid integer overflows on 32 bit machines

Arnd Bergmann <arnd@arndb.de>
    media: dvb-frontends: fix i2c access helpers for KASAN

Martin Kaiser <martin@kaiser.cx>
    watchdog: imx2_wdt: restore previous timeout after suspend+resume

Takashi Iwai <tiwai@suse.de>
    ASoC: skl: Fix kernel warning due to zero NHTL entry

John Keeping <john@metanate.com>
    ASoC: rockchip: i2s: fix playback after runtime resume

James Morse <james.morse@arm.com>
    KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2

Marc Zyngier <marc.zyngier@arm.com>
    arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix Kernel Oops on hashing an empty file

Eric Biggers <ebiggers@google.com>
    crypto: sha512-mb - initialize pending lengths correctly

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix endless loop when DECO acquire fails

Daniel Mentz <danielmentz@google.com>
    media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32

Daniel Mentz <danielmentz@google.com>
    media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha

Hans Verkuil <hansverk@cisco.com>
    media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: avoid sizeof(type)

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4l2_format32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix the indentation

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

Cong Wang <xiyou.wangcong@gmail.com>
    nsfs: mark dentry with DCACHE_RCUACCESS

Eric Biggers <ebiggers@google.com>
    crypto: poly1305 - remove ->setkey() method

Eric Biggers <ebiggers@google.com>
    crypto: mcryptd - pass through absence of ->setkey()

Eric Biggers <ebiggers@google.com>
    crypto: cryptd - pass through absence of ->setkey()

Eric Biggers <ebiggers@google.com>
    crypto: hash - introduce crypto_hash_alg_has_setkey()

Mika Westerberg <mika.westerberg@linux.intel.com>
    ahci: Add Intel Cannon Lake PCH-H PCI ID

Hans de Goede <hdegoede@redhat.com>
    ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI

Hans de Goede <hdegoede@redhat.com>
    ahci: Annotate PCI ids for mobile Intel chipsets as such

Ivan Vecera <ivecera@redhat.com>
    kernfs: fix regression in kernfs_fop_write caused by wrong type

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix a race between mmap() and O_DIRECT

Eric Biggers <ebiggers@google.com>
    NFS: reject request for id_legacy key without auxdata

J. Bruce Fields <bfields@redhat.com>
    NFS: commit direct writes even if they fail partially

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Add a cond_resched() to nfs_commit_release_pages()

Scott Mayhew <smayhew@redhat.com>
    nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Xiaolei Li <xiaolei.li@mediatek.com>
    ubifs: Massage assert in ubifs_xattr_set() wrt. init_xattrs

Bradley Bolen <bradleybolen@gmail.com>
    ubi: block: Fix locking for idr_alloc/idr_remove

Sascha Hauer <s.hauer@pengutronix.de>
    ubi: fastmap: Erase outdated anchor PEBs during attach

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: sunxi: Fix ECC strength choice

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: Fix nand_do_read_oob() return value

Kamal Dasu <kdasu.kdev@gmail.com>
    mtd: nand: brcmnand: Disable prefetch by default

Arnd Bergmann <arnd@arndb.de>
    mtd: cfi: convert inline functions to macros

Arvind Yadav <arvind.yadav.cs@gmail.com>
    media: hdpvr: Fix an error handling path in hdpvr_probe()

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: Improve logic checking of warm start

Mohamed Ghannam <simo.ghannam@gmail.com>
    dccp: CVE-2017-8824: use-after-free in DCCP code

Steven Rostedt (VMware) <rostedt@goodmis.org>
    sched/rt: Up the root domain ref count when passing it around via IPIs

Steven Rostedt (VMware) <rostedt@goodmis.org>
    sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()

Petr Cvek <petr.cvek@tul.cz>
    usb: gadget: uvc: Missing files for configfs interface

Thomas Gleixner <tglx@linutronix.de>
    posix-timer: Properly check sigevent->sigev_notify

Hugh Dickins <hughd@google.com>
    kaiser: fix compile error without vsyscall

Yang Shunyong <shunyong.yang@hxt-semitech.com>
    dmaengine: dmatest: fix container_of member in dmatest_callback

Aurelien Aptel <aaptel@suse.com>
    CIFS: zero sensitive data when freeing

Daniel N Pettersson <danielnp@axis.com>
    cifs: Fix autonegotiate security settings mismatch

Matthew Wilcox <mawilcox@microsoft.com>
    cifs: Fix missing put_xid in cifs_file_strict_mmap

Michal Suchanek <msuchanek@suse.de>
    powerpc/pseries: include linux/types.h in asm/hvcall.h


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/alpha/kernel/pci_impl.h                       |    3 +-
 arch/alpha/kernel/process.c                        |    3 +-
 arch/alpha/kernel/traps.c                          |   13 +-
 arch/arm/kvm/arm.c                                 |    1 +
 arch/arm/kvm/handle_exit.c                         |   13 +-
 arch/mn10300/mm/misalignment.c                     |    2 +-
 arch/openrisc/kernel/traps.c                       |   10 +-
 arch/powerpc/include/asm/hvcall.h                  |    1 +
 arch/sh/kernel/traps_32.c                          |    3 +-
 arch/x86/crypto/poly1305_glue.c                    |    1 -
 .../x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10 +-
 arch/x86/include/asm/vsyscall.h                    |    2 +-
 arch/x86/kvm/vmx.c                                 |    5 +-
 arch/xtensa/include/asm/futex.h                    |   23 +-
 crypto/ahash.c                                     |   11 +
 crypto/cryptd.c                                    |    3 +-
 crypto/mcryptd.c                                   |    3 +-
 crypto/poly1305_generic.c                          |   17 +-
 drivers/acpi/nfit/core.c                           |    3 +
 drivers/acpi/sbshc.c                               |    4 +-
 drivers/ata/ahci.c                                 |   37 +-
 drivers/block/pktcdvd.c                            |    4 +-
 drivers/bluetooth/btsdio.c                         |    9 +
 drivers/bluetooth/btusb.c                          |   19 +-
 drivers/clocksource/timer-stm32.c                  |    7 +-
 drivers/crypto/caam/ctrl.c                         |    8 +-
 drivers/crypto/talitos.c                           |    4 +
 drivers/dma/dmatest.c                              |    2 +-
 drivers/edac/octeon_edac-lmc.c                     |    1 +
 drivers/gpu/drm/i915/intel_dp.c                    |    6 +
 drivers/hid/hid-core.c                             |   12 +-
 drivers/media/dvb-frontends/ascot2e.c              |    4 +-
 drivers/media/dvb-frontends/cxd2841er.c            |    4 +-
 drivers/media/dvb-frontends/helene.c               |    4 +-
 drivers/media/dvb-frontends/horus3a.c              |    4 +-
 drivers/media/dvb-frontends/itd1000.c              |    5 +-
 drivers/media/dvb-frontends/mt312.c                |    5 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |    3 +-
 drivers/media/dvb-frontends/stb6100.c              |    6 +-
 drivers/media/dvb-frontends/stv0367.c              |    4 +-
 drivers/media/dvb-frontends/stv090x.c              |    4 +-
 drivers/media/dvb-frontends/stv6110x.c             |    4 +-
 drivers/media/dvb-frontends/ts2020.c               |    4 +-
 drivers/media/dvb-frontends/zl10039.c              |    4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |   39 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |    2 +
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    1 +
 drivers/media/usb/hdpvr/hdpvr-core.c               |   26 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      | 1023 ++++++++++++--------
 drivers/media/v4l2-core/v4l2-ioctl.c               |    5 +-
 drivers/mtd/nand/brcmnand/brcmnand.c               |   13 +-
 drivers/mtd/nand/nand_base.c                       |    5 +-
 drivers/mtd/nand/sunxi_nand.c                      |    8 +-
 drivers/mtd/ubi/block.c                            |   42 +-
 drivers/mtd/ubi/wl.c                               |   77 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   23 +-
 drivers/usb/gadget/function/uvc_configfs.c         |   16 +-
 drivers/watchdog/imx2_wdt.c                        |   20 +-
 fs/btrfs/inode.c                                   |   11 +-
 fs/cifs/cifsencrypt.c                              |    3 +-
 fs/cifs/connect.c                                  |    6 +-
 fs/cifs/file.c                                     |   26 +-
 fs/cifs/misc.c                                     |   14 +-
 fs/cifs/smb2pdu.c                                  |    3 +-
 fs/kernfs/file.c                                   |    2 +-
 fs/nfs/direct.c                                    |    4 +-
 fs/nfs/io.c                                        |    2 +-
 fs/nfs/nfs4idmap.c                                 |    6 +-
 fs/nfs/pnfs.c                                      |    4 +-
 fs/nfs/write.c                                     |    2 +
 fs/nsfs.c                                          |    1 +
 fs/overlayfs/readdir.c                             |    6 +-
 fs/pipe.c                                          |   15 +-
 fs/proc/kcore.c                                    |   18 +-
 fs/ubifs/xattr.c                                   |   12 +-
 include/crypto/internal/hash.h                     |    2 +
 include/crypto/poly1305.h                          |    2 -
 include/linux/mtd/map.h                            |  130 ++-
 kernel/async.c                                     |   20 +-
 kernel/relay.c                                     |    1 -
 kernel/sched/core.c                                |   13 +
 kernel/sched/rt.c                                  |   24 +-
 kernel/sched/sched.h                               |    2 +
 kernel/time/posix-timers.c                         |   34 +-
 kernel/trace/ftrace.c                              |    1 -
 lib/ubsan.c                                        |   50 +-
 lib/ubsan.h                                        |   14 +
 net/dccp/proto.c                                   |    5 +
 sound/soc/intel/skylake/skl-nhlt.c                 |    3 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    6 +
 91 files changed, 1248 insertions(+), 793 deletions(-)
