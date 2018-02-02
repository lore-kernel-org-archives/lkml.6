Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2277npjANz+FCXS1Co2Fl2qbcTk09p62Xh5TLEVLaB/mhmHlzKlRnbO4EaxNTRjKpgHGbHFn
ARC-Seal: i=1; a=rsa-sha256; t=1517590841; cv=none;
        d=google.com; s=arc-20160816;
        b=FTMvb98K4dfY+EcnmwuYuZBGvIlXNn4RMPMBiNkrACUNaHNyYpxK4MT9jTMHuGHnKw
         tS5pFIZwKZLCJuH/5YP8aBfWnaNSScCXH8OngO9PyRfp/wxswb8BQ+Ng2KkxH7tkNlkB
         g8hQtb10ApYc4dY4UplM0FeNlt9NfAtzv+BkpXPZAbEiQoyCifWf8W0oODkd805gn4G+
         KEogq/fuAVN3gSZPLCFugaeh4v821ec7b72aNyfmVYw/3X40sPvUSPNl/l/my1I/RARo
         LMK6U+enq7+Vmf5VStkfFrF6EcyGQRG2v6SvJb5V0csbGr6Hsm50TBcqEj7EM3M6tD85
         C37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uj81maFlpEayur1UvRh+kWl0/VsVjNNF2vLMbUwa8DA=;
        b=lPsP6x7FmrFwUTahxBsH7t9ftM6FF3fcu/dep+5adr3I09k1X11P53iLkzrwXDsB7T
         cbCUwDIUhzxlk8ENZXc2GcY+BnJNRGeFadYeTbjqwnc5NNM8ks8A88IkZ4XUOhfpXf6j
         ugyQahn+tipoJ1XRbSTPea8W2DyYtUqdRx2RrVSTlISD7fLrt328u7IeGbJAZS1sLYiw
         hEYirxCU6aKu0HR1K0zcxXnzSK80hSBOkV9X8EY20tWJSQ6T8SpqJjjam6Q9kgZtfVl9
         IGfynavon2bHOPXPOloHSgQacuaiS5g36XcjJ4kDHXGIZP+pgeyUc5FGorwIo1AFEc4R
         lT4A==
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
Subject: [PATCH 4.4 00/67] 4.4.115-stable review
Date: Fri,  2 Feb 2018 17:57:29 +0100
Message-Id: <20180202140815.091718203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.115-rc1
X-KernelTest-Deadline: 2018-02-04T14:08+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309333973438361?=
X-GMAIL-MSGID: =?utf-8?q?1591309333973438361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.115 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.115-rc1

Stefan Agner <stefan@agner.ch>
    spi: imx: do not access registers while clocks disabled

Fabio Estevam <fabio.estevam@nxp.com>
    serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Mark Salyzyn <salyzyn@android.com>
    selinux: general protection fault in sock_has_perm

Oliver Neukum <oneukum@suse.com>
    usb: uas: unconditionally bring back host after reset

Hemant Kumar <hemantk@codeaurora.org>
    usb: f_fs: Prevent gadget unbind if it is already unbound

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra driver

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: list: don't list devices attached to vhci_hcd

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: prevent bind loops on devices attached to vhci_hcd

Jia-Ju Bai <baijiaju1990@gmail.com>
    USB: serial: io_edgeport: fix possible sleep-in-atomic

Oliver Neukum <oneukum@suse.com>
    CDC-ACM: apply quirk for card reader

Hans de Goede <hdegoede@redhat.com>
    USB: cdc-acm: Do not log urb submission errors on disconnect

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: pl2303: new device id for Chilitag

OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>
    usb: option: Add support for FS040U modem

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Colin Ian King <colin.king@canonical.com>
    usb: gadget: don't dereference g until after it has been null checked

Icenowy Zheng <icenowy@aosc.io>
    media: usbtv: add a new usbid

Gustavo A. R. Silva <garsilva@embeddedor.com>
    scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: ubsan fixes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/omap: Fix error handling path in 'omap_dmm_probe()'

Yisheng Xie <xieyisheng1@huawei.com>
    kmemleak: add scheduling point to kmemleak_scan()

Trond Myklebust <trond.myklebust@primarydata.com>
    SUNRPC: Allow connect to return EHOSTUNREACH

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    quota: Check for register_shrinker() failure.

Geert Uytterhoeven <geert+renesas@glider.be>
    net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Robert Lippert <roblip@gmail.com>
    hwmon: (pmbus) Use 64bit math for DIRECT format values

Vasily Averin <vvs@virtuozzo.com>
    lockd: fix "list_add double add" caused by legacy signal interface

Andrew Elble <aweits@rit.edu>
    nfsd: check for use of the closed special stateid

Vasily Averin <vvs@virtuozzo.com>
    grace: replace BUG_ON by WARN_ONCE in exit_net hook

Trond Myklebust <trond.myklebust@primarydata.com>
    nfsd: Ensure we check stateid validity in the seqid operation checks

Trond Myklebust <trond.myklebust@primarydata.com>
    nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: remove warning when unloading module

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: VMX: Fix rflags cache during vCPU reset

Josef Bacik <jbacik@fb.com>
    btrfs: fix deadlock when writing out space cache

Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
    mac80211: fix the update of path metric for RANN frame

zhangliping <zhangliping02@baidu.com>
    openvswitch: fix the incorrect flow action alloc size

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdkfd: Fix SDMA oversubsription handling

shaoyunl <Shaoyun.Liu@amd.com>
    drm/amdkfd: Fix SDMA ring buffer size calculation

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode

Michael Lyle <mlyle@lyle.org>
    bcache: check return value of register_shrinker

James Hogan <jhogan@kernel.org>
    cpufreq: Add Loongson machine dependencies

Hans de Goede <hdegoede@redhat.com>
    ACPI / bus: Leave modalias empty for devices which are not present

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Preserve read-only values in the redirection table

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-triggered

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: X86: Fix operand/address-size during instruction decoding

Liran Alon <liran.alon@oracle.com>
    KVM: x86: Don't re-execute instruction when not passing CR2 value

Liran Alon <liran.alon@oracle.com>
    KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure

Lyude Paul <lyude@redhat.com>
    igb: Free IRQs when device is hotplugged

Jesse Chan <jc@linux.com>
    mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE

Jesse Chan <jc@linux.com>
    gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Stephan Mueller <smueller@chronox.de>
    crypto: af_alg - whitelist mask and type

Stephan Mueller <smueller@chronox.de>
    crypto: aesni - handle zero length dst buffer

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Make ioctls race-free

Hugh Dickins <hughd@google.com>
    kaiser: fix intel_bts perf crashes

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pti: Make unpoison of pgd for trusted boot work for real

Daniel Borkmann <daniel@iogearbox.net>
    bpf: reject stores into ctx via st and xadd

Alexei Starovoitov <ast@kernel.org>
    bpf: fix 32-bit divide by zero

Eric Dumazet <edumazet@google.com>
    bpf: fix divides by zero

Daniel Borkmann <daniel@iogearbox.net>
    bpf: avoid false sharing of map refcount with max_entries

Daniel Borkmann <daniel@iogearbox.net>
    bpf: arsh is not supported in 32 bit alu thus reject it

Alexei Starovoitov <ast@kernel.org>
    bpf: introduce BPF_JIT_ALWAYS_ON config

Alexei Starovoitov <ast@fb.com>
    bpf: fix bpf_tail_call() x64 JIT

Eric Dumazet <edumazet@google.com>
    x86: bpf_jit: small optimization in emit_bpf_tail_call()

Alexei Starovoitov <ast@fb.com>
    bpf: fix branch pruning logic

Linus Torvalds <torvalds@linux-foundation.org>
    loop: fix concurrent lo_open/lo_release


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm64/Kconfig                                 |  1 +
 arch/s390/Kconfig                                  |  1 +
 arch/x86/Kconfig                                   |  1 +
 arch/x86/crypto/aesni-intel_glue.c                 |  2 +-
 arch/x86/include/asm/kvm_host.h                    |  3 +-
 arch/x86/kernel/cpu/perf_event_intel_bts.c         | 44 ++++++++++----
 arch/x86/kernel/tboot.c                            | 10 ++++
 arch/x86/kvm/emulate.c                             |  7 +++
 arch/x86/kvm/ioapic.c                              | 20 ++++++-
 arch/x86/kvm/vmx.c                                 |  4 +-
 arch/x86/kvm/x86.c                                 |  2 +-
 arch/x86/net/bpf_jit_comp.c                        | 13 ++--
 crypto/af_alg.c                                    | 10 ++--
 drivers/acpi/device_sysfs.c                        |  4 ++
 drivers/block/loop.c                               | 10 +++-
 drivers/cpufreq/Kconfig                            |  2 +
 drivers/gpio/gpio-ath79.c                          |  3 +
 drivers/gpio/gpio-iop.c                            |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  | 47 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 18 ++++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  3 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 21 ++++---
 drivers/md/bcache/btree.c                          |  5 +-
 drivers/media/usb/usbtv/usbtv-core.c               |  1 +
 drivers/mtd/nand/denali_pci.c                      |  4 ++
 drivers/net/ethernet/intel/igb/igb_main.c          |  2 +-
 drivers/net/ethernet/xilinx/Kconfig                |  1 +
 drivers/net/xen-netfront.c                         | 18 ++++++
 drivers/power/reset/zx-reboot.c                    |  4 ++
 drivers/scsi/aacraid/commsup.c                     |  2 +-
 drivers/scsi/ufs/ufshcd.c                          |  7 ++-
 drivers/spi/spi-imx.c                              | 15 ++++-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     | 14 ++---
 drivers/tty/serial/imx.c                           | 14 +++--
 drivers/usb/class/cdc-acm.c                        |  5 +-
 drivers/usb/gadget/composite.c                     |  7 ++-
 drivers/usb/gadget/function/f_fs.c                 |  3 +-
 drivers/usb/serial/Kconfig                         |  1 +
 drivers/usb/serial/io_edgeport.c                   |  1 -
 drivers/usb/serial/option.c                        |  5 ++
 drivers/usb/serial/pl2303.c                        |  1 +
 drivers/usb/serial/pl2303.h                        |  1 +
 drivers/usb/serial/usb-serial-simple.c             |  7 +++
 drivers/usb/storage/uas.c                          |  7 +--
 fs/btrfs/free-space-cache.c                        |  3 +-
 fs/nfs_common/grace.c                              | 10 +++-
 fs/nfsd/nfs4state.c                                | 34 ++++++-----
 fs/quota/dquot.c                                   |  3 +-
 fs/xfs/xfs_aops.c                                  |  6 +-
 include/linux/bpf.h                                | 16 +++--
 init/Kconfig                                       |  7 +++
 kernel/bpf/core.c                                  | 30 ++++++++--
 kernel/bpf/verifier.c                              | 70 ++++++++++++++++++++++
 lib/test_bpf.c                                     | 13 ++--
 mm/kmemleak.c                                      |  2 +
 net/Kconfig                                        |  3 +
 net/core/filter.c                                  |  8 ++-
 net/core/sysctl_net_core.c                         |  6 ++
 net/mac80211/mesh_hwmp.c                           | 15 +++--
 net/openvswitch/flow_netlink.c                     | 16 ++---
 net/socket.c                                       |  9 +++
 net/sunrpc/xprtsock.c                              |  1 +
 security/selinux/hooks.c                           |  2 +
 sound/core/seq/seq_clientmgr.c                     | 10 +++-
 sound/core/seq/seq_clientmgr.h                     |  1 +
 tools/usb/usbip/src/usbip_bind.c                   |  9 +++
 tools/usb/usbip/src/usbip_list.c                   |  9 +++
 69 files changed, 504 insertions(+), 142 deletions(-)
