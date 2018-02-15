Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Mtl9gqRqnhvCoJTQdJHs63YvXCbXDIL3ru7V0JYM7qi4ioc1Ky2BvulupOW+f+NluoYx0
ARC-Seal: i=1; a=rsa-sha256; t=1518708068; cv=none;
        d=google.com; s=arc-20160816;
        b=NAicXw00qkvw1biF9sjE0uQ+D/fSGdXBtkoZZ03WxHhnC3YM6lNV3tYBgJ7egWlGDj
         6PVwr/os3uLyrehUmcCL4+s9nIXXYzLkGX8nGRKAzmZPp81upir7+VvamgbRXutibo1l
         k4G6XguKcleqZEq4Qk4ZIJsafJzXsJysapSC8oj5AI2j0YleeieYXpRLGu5n978xTRkI
         SeNLyXry7OL8rPcfSTWPHWw13dJ884ddRWdZ0wA4u3lW1e0xQDLFj5LvG/M83E87j0Uj
         2X8MpYG33XvoIjY7TfF9x4H5BA4F71TAKoqUlxMuKpNLybqINOHD7b9FTHYU8SoKiOry
         or6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RQxHloZRTRJ66/3LkD0u9aUqQ+l9RzWqMzsQvwTrdBk=;
        b=vOPsF4EHTTB86QasjdyI4c+wvIBo2RdaiYw/Z0+Ix8YCHNSOD+5cKLo4lzriJyCCDk
         BS6RUopnBQXJyGxNQtJno5N/xSDowv36XpYZZuQVpeGhdHBGnQ4QdokLjYba1q77yya3
         6RFQdUlhPmz6bmDylT1tf6vhObUydPAxh8rvw3AaTld2+Tljc5Q8/CHfPctedqD/y03b
         BEl3hfuy1Zn0S3NPhi3zgzggsuugqH0ZydkLilNBt4hiRZjrRimmvl0GJAp+/90h8gnA
         4fxxM/xfgMidcZuBRsu31yVYmcx39qCx79vIQ4qoa2GN181cFWf/qWoCqugAYF7cSeEe
         4OrA==
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
Subject: [PATCH 4.4 000/108] 4.4.116-stable review
Date: Thu, 15 Feb 2018 16:15:57 +0100
Message-Id: <20180215151222.267507937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.116-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.116-rc1
X-KernelTest-Deadline: 2018-02-17T15:12+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480831775234699?=
X-GMAIL-MSGID: =?utf-8?q?1592480831775234699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.116 release.
There are 108 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.116-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.116-rc1

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace: Remove incorrect setting of glob search field

Eric W. Biederman <ebiederm@xmission.com>
    mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy

Amir Goldstein <amir73il@gmail.com>
    ovl: fix failure to fsync lower dir

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ACPI: sbshc: remove raw pointer from printk() message

Keith Busch <keith.busch@intel.com>
    nvme: Fix managing degraded controllers

Nikolay Borisov <nborisov@suse.com>
    btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Bart Van Assche <bart.vanassche@wdc.com>
    pktcdvd: Fix pkt_setup_dev() error path

James Hogan <jhogan@kernel.org>
    EDAC, octeon: Fix an uninitialized variable warning

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix futex_atomic_cmpxchg_inatomic

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

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    kernel/async.c: revert "async: simplify lowest_in_progress()"

Mauro Carvalho Chehab <mchehab@osg.samsung.com>
    media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: ts2020: avoid integer overflows on 32 bit machines

Martin Kaiser <martin@kaiser.cx>
    watchdog: imx2_wdt: restore previous timeout after suspend+resume

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2

Marc Zyngier <marc.zyngier@arm.com>
    arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

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

Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    vb2: V4L2_BUF_FLAG_DONE is set after DQBUF

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

Cong Wang <xiyou.wangcong@gmail.com>
    nsfs: mark dentry with DCACHE_RCUACCESS

Eric Biggers <ebiggers@google.com>
    crypto: poly1305 - remove ->setkey() method

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

Eric Biggers <ebiggers@google.com>
    NFS: reject request for id_legacy key without auxdata

J. Bruce Fields <bfields@redhat.com>
    NFS: commit direct writes even if they fail partially

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Add a cond_resched() to nfs_commit_release_pages()

Scott Mayhew <smayhew@redhat.com>
    nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Bradley Bolen <bradleybolen@gmail.com>
    ubi: block: Fix locking for idr_alloc/idr_remove

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: sunxi: Fix ECC strength choice

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: Fix nand_do_read_oob() return value

Kamal Dasu <kdasu.kdev@gmail.com>
    mtd: nand: brcmnand: Disable prefetch by default

Arnd Bergmann <arnd@arndb.de>
    mtd: cfi: convert inline functions to macros

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

Eric W. Biederman <ebiederm@xmission.com>
    netfilter: nf_queue: Make the queue_handler pernet

Hugh Dickins <hughd@google.com>
    kaiser: fix compile error without vsyscall

Eric Biggers <ebiggers@google.com>
    x86/kaiser: fix build error with KASAN && !FUNCTION_GRAPH_TRACER

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

Borislav Petkov <bp@suse.de>
    x86/microcode: Do the family check first

Borislav Petkov <bp@suse.de>
    x86/microcode/AMD: Do not load when running on a hypervisor

Robert Baronescu <robert.baronescu@nxp.com>
    crypto: tcrypt - fix S/G table for test_aead_speed()

Al Viro <viro@zeniv.linux.org.uk>
    don't put symlink bodies in pagecache into highmem

Eric Biggers <ebiggers@google.com>
    KEYS: encrypted: fix buffer overread in valid_master_desc()

Jesse Chan <jc@linux.com>
    media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jason Wang <jasowang@redhat.com>
    vhost_net: stop device during reset owner

Li RongQing <lirongqing@baidu.com>
    tcp: release sk_frag.page in tcp_disconnect

Chunhao Lin <hau@realtek.com>
    r8169: fix RTL8168EP take too long to complete driver initialization.

Junxiao Bi <junxiao.bi@oracle.com>
    qlcnic: fix deadlock bug

Eric Dumazet <edumazet@google.com>
    net: igmp: add a missing rcu locking section

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    ip6mr: fix stale iterator

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/asm: Fix inline asm call constraints for GCC 4.4

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Fix race condition when disabling planes at CRTC stop

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Use the VBK interrupt for vblank events

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: avoid duplicate free_irq()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: don't call free_irq() on Parent SSI

Julian Scheel <julian@jusst.de>
    ASoC: simple-card: Fix misleading error message

Matthias Hintzmann <matthias.dev@gmx.de>
    net: cdc_ncm: initialize drvflags before usage

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: fix 3eee23c3ec14 tcp_socket address still in the status file

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit

Jesse Chan <jc@linux.com>
    ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Allow control of RFI flush via debugfs

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_meltdown()

Oliver O'Halloran <oohall@gmail.com>
    powerpc/powernv: Check device-tree for RFI flush settings

Michael Neuling <mikey@neuling.org>
    powerpc/pseries: Query hypervisor for RFI flush settings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Add support for RFI flush of L1-D cache

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Simple RFI macro conversions

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Add macros for annotating the destination of rfid/hrfid

Michael Neuling <mikey@neuling.org>
    powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper

Alan Modra <amodra@gmail.com>
    powerpc: Simplify module TOC handling

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC

Oliver O'Halloran <oohall@gmail.com>
    powerpc/64: Fix flush_(d|i)cache_range() called from modules

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc/bpf/jit: Disable classic BPF JIT on ppc64le


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/alpha/kernel/pci_impl.h                       |    3 +-
 arch/alpha/kernel/process.c                        |    3 +-
 arch/arm/kvm/handle_exit.c                         |   13 +-
 arch/mn10300/mm/misalignment.c                     |    2 +-
 arch/openrisc/kernel/traps.c                       |   10 +-
 arch/powerpc/Kconfig                               |    3 +-
 arch/powerpc/include/asm/exception-64e.h           |    6 +
 arch/powerpc/include/asm/exception-64s.h           |   55 +-
 arch/powerpc/include/asm/feature-fixups.h          |   15 +
 arch/powerpc/include/asm/hvcall.h                  |   18 +
 arch/powerpc/include/asm/paca.h                    |   10 +
 arch/powerpc/include/asm/plpar_wrappers.h          |   14 +
 arch/powerpc/include/asm/ppc_asm.h                 |   12 +
 arch/powerpc/include/asm/setup.h                   |   13 +
 arch/powerpc/kernel/asm-offsets.c                  |    4 +
 arch/powerpc/kernel/entry_64.S                     |   44 +-
 arch/powerpc/kernel/exceptions-64s.S               |  126 ++-
 arch/powerpc/kernel/misc_64.S                      |   32 +-
 arch/powerpc/kernel/module_64.c                    |   12 +-
 arch/powerpc/kernel/process.c                      |    5 +-
 arch/powerpc/kernel/setup_64.c                     |  139 +++
 arch/powerpc/kernel/vmlinux.lds.S                  |    9 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |    7 +-
 arch/powerpc/kvm/book3s_rmhandlers.S               |    7 +-
 arch/powerpc/kvm/book3s_segment.S                  |    4 +-
 arch/powerpc/lib/feature-fixups.c                  |   42 +
 arch/powerpc/platforms/powernv/setup.c             |   50 +
 arch/powerpc/platforms/pseries/setup.c             |   37 +-
 arch/sh/kernel/traps_32.c                          |    3 +-
 arch/x86/crypto/poly1305_glue.c                    |    1 -
 arch/x86/include/asm/asm.h                         |    4 +-
 arch/x86/include/asm/vsyscall.h                    |    2 +-
 arch/x86/kernel/cpu/microcode/core.c               |   47 +-
 arch/x86/kvm/vmx.c                                 |    5 +-
 arch/x86/mm/kaiser.c                               |    2 +-
 arch/xtensa/include/asm/futex.h                    |   23 +-
 crypto/ahash.c                                     |   11 +
 crypto/cryptd.c                                    |    3 +-
 crypto/poly1305_generic.c                          |   17 +-
 crypto/tcrypt.c                                    |    6 +-
 drivers/acpi/sbshc.c                               |    4 +-
 drivers/ata/ahci.c                                 |   37 +-
 drivers/block/pktcdvd.c                            |    4 +-
 drivers/bluetooth/btsdio.c                         |    9 +
 drivers/bluetooth/btusb.c                          |   19 +-
 drivers/crypto/caam/ctrl.c                         |    8 +-
 drivers/dma/dmatest.c                              |    2 +-
 drivers/edac/octeon_edac-lmc.c                     |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   56 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |    8 +
 drivers/hid/hid-core.c                             |   12 +-
 drivers/media/dvb-frontends/ts2020.c               |    4 +-
 drivers/media/platform/soc_camera/soc_scale_crop.c |    4 +
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |   39 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |    2 +
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    1 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      | 1023 ++++++++++++--------
 drivers/media/v4l2-core/v4l2-ioctl.c               |    5 +-
 drivers/media/v4l2-core/videobuf2-v4l2.c           |    6 +
 drivers/mtd/nand/brcmnand/brcmnand.c               |   13 +-
 drivers/mtd/nand/nand_base.c                       |    5 +-
 drivers/mtd/nand/sunxi_nand.c                      |    8 +-
 drivers/mtd/ubi/block.c                            |   42 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   18 +-
 drivers/net/ethernet/realtek/r8169.c               |    4 +-
 drivers/net/usb/cdc_ncm.c                          |    6 +-
 drivers/nvme/host/pci.c                            |   13 +-
 drivers/usb/gadget/function/uvc_configfs.c         |   16 +-
 drivers/usb/usbip/vhci_hcd.c                       |    2 +-
 drivers/usb/usbip/vhci_sysfs.c                     |    7 +-
 drivers/vhost/net.c                                |    1 +
 drivers/watchdog/imx2_wdt.c                        |   20 +-
 fs/btrfs/inode.c                                   |   10 +-
 fs/cifs/cifsencrypt.c                              |    3 +-
 fs/cifs/connect.c                                  |    6 +-
 fs/cifs/file.c                                     |   26 +-
 fs/cifs/misc.c                                     |   14 +-
 fs/cifs/smb2pdu.c                                  |    3 +-
 fs/ext4/inode.c                                    |    1 +
 fs/ext4/namei.c                                    |    1 +
 fs/ext4/symlink.c                                  |   10 +-
 fs/f2fs/inode.c                                    |    1 +
 fs/f2fs/namei.c                                    |    5 +-
 fs/inode.c                                         |    6 +
 fs/kernfs/file.c                                   |    2 +-
 fs/nfs/direct.c                                    |    4 +-
 fs/nfs/nfs4idmap.c                                 |    6 +-
 fs/nfs/pnfs.c                                      |    4 +-
 fs/nfs/write.c                                     |    2 +
 fs/nsfs.c                                          |    1 +
 fs/overlayfs/readdir.c                             |    6 +-
 include/crypto/internal/hash.h                     |    2 +
 include/crypto/poly1305.h                          |    2 -
 include/linux/fs.h                                 |    1 +
 include/linux/mtd/map.h                            |  130 ++-
 include/net/netfilter/nf_queue.h                   |    4 +-
 include/net/netns/netfilter.h                      |    2 +
 kernel/async.c                                     |   20 +-
 kernel/sched/core.c                                |   13 +
 kernel/sched/rt.c                                  |   24 +-
 kernel/sched/sched.h                               |    2 +
 kernel/time/posix-timers.c                         |   34 +-
 kernel/trace/ftrace.c                              |    1 -
 net/dccp/proto.c                                   |    5 +
 net/ipv4/igmp.c                                    |    4 +
 net/ipv4/tcp.c                                     |    6 +
 net/ipv6/ip6mr.c                                   |    1 +
 net/netfilter/nf_queue.c                           |   17 +-
 net/netfilter/nfnetlink_queue.c                    |   18 +-
 scripts/mod/modpost.c                              |    3 +-
 security/keys/encrypted-keys/encrypted.c           |   31 +-
 sound/soc/codecs/pcm512x-spi.c                     |    4 +
 sound/soc/generic/simple-card.c                    |    8 +-
 sound/soc/sh/rcar/rsnd.h                           |    2 +
 sound/soc/sh/rcar/ssi.c                            |    5 +
 116 files changed, 1821 insertions(+), 851 deletions(-)
