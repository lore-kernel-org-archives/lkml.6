Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591019-2-16563337317978111554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591018; b=LZJ9UWg1SPxnejB2F45udduEzpemzT9IuZtZMIbUdEYoJ7T
    IGqPNAAG1iOa4JGSUClTxrWat5wnn1JRu4BmCm0FOq7XYiayCxb+g2AVImwJFLj/
    GkJ0C9VBX4esrkzeYATiQDpY5+Tqql8FJ0sLx5PTJh4kJD/EOM/BFJp86d0MAMUo
    pjp/BF31jrCyE8PHd2SpC3qyi3UUitv+8ZotbheXpqDRfyjvq525OW1vpWfJpabT
    qWYxB+BlWsnJYNJdrcJBjVxWtHSSjZa/pihGOKZjkvkL+SwK1wQSjxjOypokHuj+
    H72CCyJYx5zMFHWZi/BC+/jkxzZVBaZ60FNCiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517591018; bh=1bCS2DlTlTfBuHAmT+SqIZrhQ4
    tLff3Cgj3/chIdQ50=; b=A5FHwRhCU20SK1es522CrJDt1cR2qs5dNPmZVJpN16
    f4iHXfa48a14ZWAmq8WXKnEehOPHGASxCf+Lct4yIZTjiVR0wS0rXadEffZvKON8
    mwFQlRvBMKSk4DhQaY86CCZiG2+kuHju722QssyTIvHjpFaQYEh2p67iJB4JS+1O
    mO8YY3CMRcvjKgr915NrEsRkJEmqQ8x2UyLRc64arcSs2wiIrW47R9bxzYwL8b0S
    qf18QzC0d3MeUeY8R9rg5bXc4vz4cQmfqn6z0ADODByasadWD8J12w3OYrVNrHbS
    hpbti73jxg4LSQp1k95VmIzUdu18+mU2F0R7vaowFpmQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeBBRDf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:03:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeBBRDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:03:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/86] 4.9.80-stable review
Date: Fri,  2 Feb 2018 17:57:20 +0100
Message-Id: <20180202140822.679101338@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.80-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.80-rc1
X-KernelTest-Deadline: 2018-02-04T14:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.80 release.
There are 86 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb  4 14:07:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.80-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.80-rc1

Stefan Agner <stefan@agner.ch>
    spi: imx: do not access registers while clocks disabled

Fabio Estevam <fabio.estevam@nxp.com>
    serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Shuah Khan <shuah@kernel.org>
    usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Oliver Neukum <oneukum@suse.com>
    usb: uas: unconditionally bring back host after reset

Hemant Kumar <hemantk@codeaurora.org>
    usb: f_fs: Prevent gadget unbind if it is already unbound

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra driver

Shuah Khan <shuah@kernel.org>
    usbip: list: don't list devices attached to vhci_hcd

Shuah Khan <shuah@kernel.org>
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

Gaurav Kohli <gkohli@codeaurora.org>
    tty: fix data race between tty_init_dev and flush of buf

Dmitry Eremin <dmitry.eremin@intel.com>
    staging: lustre: separate a connection destroy from free struct kib_conn

Stefan Schake <stschake@gmail.com>
    drm/vc4: Move IRQ enable to PM path

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Colin Ian King <colin.king@canonical.com>
    usb: gadget: don't dereference g until after it has been null checked

Icenowy Zheng <icenowy@aosc.io>
    media: usbtv: add a new usbid

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix PPI interrupt types

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type

Gustavo A. R. Silva <garsilva@embeddedor.com>
    scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path

Carlos Maiolino <cmaiolino@redhat.com>
    xfs: Properly retry failed dquot items in case of error during buffer writeback

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: ubsan fixes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/omap: Fix error handling path in 'omap_dmm_probe()'

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix 1-lane behavior

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix AUXDATAn registers access

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix timing calculations

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix DP0_MISC register set

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: filter out too high modes

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: do no fail on hi-res displays

Yisheng Xie <xieyisheng1@huawei.com>
    kmemleak: add scheduling point to kmemleak_scan()

Trond Myklebust <trond.myklebust@primarydata.com>
    SUNRPC: Allow connect to return EHOSTUNREACH

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    quota: Check for register_shrinker() failure.

Geert Uytterhoeven <geert+renesas@glider.be>
    net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Christian König <christian.koenig@amd.com>
    drm/amdgpu: don't try to move pinned BOs

Michal Hocko <mhocko@suse.com>
    xfs: fortify xfs_alloc_buftarg error handling

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    bnxt_en: Fix an error handling path in 'bnxt_get_module_eeprom()'

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

Thomas Meyer <thomas@m3y3r.de>
    auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: remove warning when unloading module

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: always free inline data before resetting inode fork during ifree

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: VMX: Fix rflags cache during vCPU reset

Wanpeng Li <kernellwp@gmail.com>
    KVM: X86: Fix softlockup when get the current kvmclock

Jeff Layton <jlayton@redhat.com>
    reiserfs: remove unneeded i_version bump

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

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Preserve read-only values in the redirection table

Hans de Goede <hdegoede@redhat.com>
    ACPI / bus: Leave modalias empty for devices which are not present

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

Abhishek Goel <huntbag@linux.vnet.ibm.com>
    cpupower : Fix cpupower working when cpu0 is offline

Abhishek Goel <huntbag@linux.vnet.ibm.com>
    cpupowerutils: bench - Fix cpu online check

Stefan Schake <stschake@gmail.com>
    drm/vc4: Account for interrupts in flight

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

Aaron Armstrong Skomra <skomra@gmail.com>
    HID: wacom: EKR: ensure devres groups at higher indexes are released

Stephan Mueller <smueller@chronox.de>
    crypto: af_alg - whitelist mask and type

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha3-generic - fixes for alignment and big endian operation

Stephan Mueller <smueller@chronox.de>
    crypto: aesni - handle zero length dst buffer

Hauke Mehrtens <hauke@hauke-m.de>
    crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Linus Walleij <linus.walleij@linaro.org>
    gpio: Fix kernel stack leak to userspace

Patrice Chotard <patrice.chotard@st.com>
    gpio: stmpe: i2c transfer are forbiden in atomic context

Joel Stanley <joel@jms.id.au>
    tools/gpio: Fix build error with musl libc

Max Gurtovoy <maxg@mellanox.com>
    RDMA/mlx5: set UMR wqe fence according to HCA cap

Max Gurtovoy <maxg@mellanox.com>
    net/mlx5: Define interface bits for fencing UMR wqe

Linus Torvalds <torvalds@linux-foundation.org>
    loop: fix concurrent lo_open/lo_release


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  4 +-
 arch/x86/crypto/aesni-intel_glue.c                 |  2 +-
 arch/x86/include/asm/kvm_host.h                    |  3 +-
 arch/x86/kvm/emulate.c                             |  7 +++
 arch/x86/kvm/ioapic.c                              | 20 +++++-
 arch/x86/kvm/vmx.c                                 |  4 +-
 arch/x86/kvm/x86.c                                 | 13 ++--
 crypto/Kconfig                                     |  2 +-
 crypto/af_alg.c                                    | 10 +--
 crypto/sha3_generic.c                              |  5 +-
 drivers/acpi/device_sysfs.c                        |  4 ++
 drivers/auxdisplay/Kconfig                         |  1 +
 drivers/block/loop.c                               | 10 ++-
 drivers/cpufreq/Kconfig                            |  2 +
 drivers/gpio/gpio-ath79.c                          |  3 +
 drivers/gpio/gpio-iop.c                            |  4 ++
 drivers/gpio/gpio-stmpe.c                          | 20 +++---
 drivers/gpio/gpiolib.c                             |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  | 47 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 18 ++++++
 drivers/gpu/drm/bridge/tc358767.c                  | 73 ++++++++++++----------
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  3 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |  3 +
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  3 +
 drivers/hid/wacom_sys.c                            | 24 +++----
 drivers/hwmon/pmbus/pmbus_core.c                   | 21 ++++---
 drivers/infiniband/hw/mlx5/main.c                  | 14 +++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  3 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 59 +++++++----------
 drivers/md/bcache/btree.c                          |  5 +-
 drivers/media/usb/usbtv/usbtv-core.c               |  1 +
 drivers/mtd/nand/denali_pci.c                      |  4 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  2 +-
 drivers/net/ethernet/xilinx/Kconfig                |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  2 +
 drivers/net/xen-netfront.c                         | 18 ++++++
 drivers/power/reset/zx-reboot.c                    |  4 ++
 drivers/scsi/aacraid/commsup.c                     |  2 +-
 drivers/scsi/ufs/ufshcd.c                          |  7 ++-
 drivers/spi/spi-imx.c                              | 15 ++++-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |  7 +--
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |  2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |  6 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     | 14 ++---
 drivers/tty/serial/imx.c                           | 14 +++--
 drivers/tty/tty_io.c                               |  8 ++-
 drivers/tty/tty_ldisc.c                            |  4 +-
 drivers/usb/class/cdc-acm.c                        |  5 +-
 drivers/usb/gadget/composite.c                     |  7 ++-
 drivers/usb/gadget/function/f_fs.c                 |  3 +-
 drivers/usb/gadget/udc/core.c                      |  2 +-
 drivers/usb/serial/Kconfig                         |  1 +
 drivers/usb/serial/io_edgeport.c                   |  1 -
 drivers/usb/serial/option.c                        |  5 ++
 drivers/usb/serial/pl2303.c                        |  1 +
 drivers/usb/serial/pl2303.h                        |  1 +
 drivers/usb/serial/usb-serial-simple.c             |  7 +++
 drivers/usb/storage/uas.c                          |  7 +--
 drivers/usb/usbip/vhci_hcd.c                       |  2 +-
 fs/btrfs/free-space-cache.c                        |  3 +-
 fs/nfs_common/grace.c                              | 10 ++-
 fs/nfsd/nfs4state.c                                | 34 +++++-----
 fs/quota/dquot.c                                   |  3 +-
 fs/reiserfs/super.c                                |  1 -
 fs/xfs/xfs_aops.c                                  |  6 +-
 fs/xfs/xfs_buf.c                                   | 15 +++--
 fs/xfs/xfs_dquot.c                                 | 14 ++++-
 fs/xfs/xfs_dquot_item.c                            | 40 +++++++++++-
 fs/xfs/xfs_inode.c                                 | 21 +++++++
 include/linux/mlx5/mlx5_ifc.h                      | 10 ++-
 include/linux/tty.h                                |  2 +
 mm/kmemleak.c                                      |  2 +
 net/mac80211/mesh_hwmp.c                           | 15 +++--
 net/openvswitch/flow_netlink.c                     | 16 ++---
 net/sunrpc/xprtsock.c                              |  1 +
 tools/gpio/gpio-event-mon.c                        |  1 +
 tools/power/cpupower/bench/system.c                |  2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |  9 ++-
 tools/usb/usbip/src/usbip_bind.c                   |  9 +++
 tools/usb/usbip/src/usbip_list.c                   |  9 +++
 84 files changed, 543 insertions(+), 239 deletions(-)
