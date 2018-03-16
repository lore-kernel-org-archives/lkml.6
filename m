Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221645-2-9693073913298934101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RED 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221644; b=Mx18p8uOFSdXuRByTW2piIRilY9AGqIoer6TiFbrLoEuDE4
    y31SSnHKb7kFe5vhuwFnbGniT6Y9flJCn8xoWAR8Bsr+zkaXn6lOGDK72qU+YB3V
    De/wfQ3xFXIEu7NFugU7wEjGqB0pdzeqhnlnp3cShyF0VQ9T1I3ioGiDCAmtyS2B
    MVVlYcSYzwqNgbDhX0lk6ZpzE/k1VixVUCvEyT/BYpPqtDTNyFRTyvxwEflV8lpr
    DaGgTA7AHtMgO4s6xa+K2ieTvnN/8dkf9NiRZZg0DCTixj8tcRmDWBiv6fl5rQj9
    Uv9CGuFEuI+XP0M6PU0zMXum3h7HXccWmpZU/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521221644; bh=is2VdNR7uV8SsqKGe5JcP2VpYd
    a1gvD4Jql63eugnpg=; b=r1NE4fgtNm/crKZJANLGt+vQ3rkn7ZJmDElAimk8ou
    62IiM3ir/b7Mno0Lo8cRjqX0kjZzBVD6sDpeEc0Yv3KogvMCmxPEiWyIUzyBF2IP
    z+t+Ixd8aey7fB9tzBpZfdo6Zbw3EDtLs2/k2hj55c6dxIGatzSHS0BlvjSlxJsm
    L5sgXbLORciI3H3JP7ly5Pc5oQfDbneyuyzNagb5R3Or9mSPou4a9behmDuOohIJ
    yAw2y4saR+TSFgbxrRC3ADkZrYSnQTNyjtecwx3eCu1piG2fvDjMN4+uRJM+lyuN
    /8PSKigenp7lUx4bioTA+RUAeEDbMXUzN0Qge9T+jixA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCPP1O (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbeCPP1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/63] 4.4.122-stable review
Date: Fri, 16 Mar 2018 16:22:32 +0100
Message-Id: <20180316152259.964532775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.122-rc1
X-KernelTest-Deadline: 2018-03-18T15:23+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.122 release.
There are 63 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.122-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    fixup: sctp: verify size of a new chunk in _sctp_make_chunk()

Nikola Ciprich <nikola.ciprich@linuxbox.cz>
    serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Xinyong <xinyong.fang@linux.alibaba.com>
    usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Pete Zaitcev <zaitcev@kotori.zaitcev.us>
    usb: usbmon: Read text within supplied buffer size

Julia Lawall <Julia.Lawall@lip6.fr>
    USB: usbmon: remove assignment from IS_ERR argument

Danilo Krummrich <danilokrummrich@dk-develop.de>
    usb: quirks: add control message delay for 1b1c:1b20

Teijo Kinnunen <teijo.kinnunen@code-q.fi>
    USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Joel Fernandes <joelaf@google.com>
    staging: android: ashmem: Fix lockdep issue during llseek

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: fix comedi_nsamples_left.

Oliver Neukum <oneukum@suse.com>
    uas: fix comparison for error code

Jonas Danielsson <jonas@orbital-systems.com>
    tty/serial: atmel: add new version check for usart

Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
    serial: sh-sci: prevent lockup on full TTY buffers

H.J. Lu <hjl.tools@gmail.com>
    x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/module: Detect and skip invalid relocations

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux"

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix an incorrect type in struct nfs_direct_req

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Clay McClure <clay@daemons.net>
    ubi: Fix race condition between ubi volume creation and udev

Tahsin Erdogan <tahsin@google.com>
    ext4: inplace xattr block update fails to deduplicate blocks

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pack percpu counter allocations

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pass xt_counters struct to counter allocator

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pass xt_counters struct instead of packet counter

Florian Westphal <fw@strlen.de>
    netfilter: use skb_to_full_sk in ip_route_me_harder

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add missing match size checks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets

Eric Dumazet <edumazet@google.com>
    netfilter: IDLETIMER: be syzkaller friendly

Paolo Abeni <pabeni@redhat.com>
    netfilter: nat: cope with negative port range

Paolo Abeni <pabeni@redhat.com>
    netfilter: x_tables: fix missing timer initialization in xt_LED

Florian Westphal <fw@strlen.de>
    netfilter: add back stackpointer size checks

Philipp Zabel <p.zabel@pengutronix.de>
    tc358743: fix register i2c_rd/wr function fix

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca8418_keypad - remove double read of key event register

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Florian Westphal <fw@strlen.de>
    netfilter: nfnetlink_queue: fix timestamp attribute

Arnd Bergmann <arnd@arndb.de>
    watchdog: hpwdt: fix unused variable warning

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Check source of NMI

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: SMBIOS check

Dan Williams <dan.j.williams@intel.com>
    nospec: Include <asm/barrier.h> dependency

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G2

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 820 G3

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: More protection for concurrent write and ioctl races

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Don't allow resizing pool in use

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520

Seunghun Han <kkamagui@gmail.com>
    x86/MCE: Serialize sysfs changes

Michael Lyle <mlyle@lyle.org>
    bcache: don't attach backing with duplicate UUID

James Hogan <jhogan@kernel.org>
    kbuild: Handle builtin dtb file names containing hyphens

Ross Zwisler <ross.zwisler@linux.intel.com>
    loop: Fix lost writes caused by missing flag

Zhang Bo <zbsdta@126.com>
    Input: matrix_keypad - fix race when disabling interrupts

Colin Ian King <colin.king@canonical.com>
    MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Colin Ian King <colin.king@canonical.com>
    MIPS: ath25: Check for kzalloc allocation failure

Justin Chen <justinpopo6@gmail.com>
    MIPS: BMIPS: Do not mask IPIs during suspend

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix KV harvesting

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: fix KV harvesting

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Notify sbios device ready before send request

Lukas Wunner <lukas@wunner.de>
    drm/amdgpu: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/radeon: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/nouveau: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm: Allow determining if current task is output poll worker

Lukas Wunner <lukas@wunner.de>
    workqueue: Allow retrieval of current task's work struct

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix integer overflow while resizing CQ

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that user doesn't overflow QP state

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Limit possible option size


-------------

Diffstat:

 Makefile                                       |   4 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     |   8 --
 arch/arm/mach-omap2/omap-secure.c              |   2 +
 arch/mips/ath25/board.c                        |   2 +
 arch/mips/cavium-octeon/octeon-irq.c           |   2 +
 arch/mips/kernel/smp-bmips.c                   |   8 +-
 arch/x86/kernel/cpu/mcheck/mce.c               |  22 ++++-
 arch/x86/kernel/machine_kexec_64.c             |   1 +
 arch/x86/kernel/module.c                       |  14 +++
 arch/x86/tools/relocs.c                        |   3 +
 drivers/block/loop.c                           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  58 ++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  30 +-----
 drivers/gpu/drm/drm_probe_helper.c             |  20 ++++
 drivers/gpu/drm/nouveau/nouveau_connector.c    |  18 +++-
 drivers/gpu/drm/radeon/cik.c                   |  31 +------
 drivers/gpu/drm/radeon/radeon_connectors.c     |  74 ++++++++++-----
 drivers/infiniband/core/ucma.c                 |   6 ++
 drivers/infiniband/hw/mlx5/cq.c                |   7 +-
 drivers/input/keyboard/matrix_keypad.c         |   4 +-
 drivers/input/keyboard/tca8418_keypad.c        |   2 -
 drivers/md/bcache/super.c                      |  11 +++
 drivers/media/i2c/tc358743.c                   |   2 +-
 drivers/mtd/ubi/vmt.c                          |  15 ++-
 drivers/scsi/qla2xxx/qla_init.c                |   1 +
 drivers/scsi/qla2xxx/qla_target.c              |   2 +-
 drivers/staging/android/ashmem.c               |  15 ++-
 drivers/staging/comedi/drivers.c               |   3 +-
 drivers/tty/serial/8250/8250_pci.c             |  11 +++
 drivers/tty/serial/atmel_serial.c              |   1 +
 drivers/tty/serial/sh-sci.c                    |   2 +
 drivers/usb/core/message.c                     |   4 +
 drivers/usb/core/quirks.c                      |   3 +-
 drivers/usb/gadget/function/f_fs.c             |   1 -
 drivers/usb/mon/mon_text.c                     | 124 ++++++++++++++++---------
 drivers/usb/storage/uas.c                      |   2 +-
 drivers/usb/storage/unusual_devs.h             |   7 ++
 drivers/watchdog/hpwdt.c                       |  12 ++-
 fs/ext4/xattr.c                                |   3 +-
 fs/nfs/direct.c                                |   2 +-
 include/drm/drm_crtc_helper.h                  |   1 +
 include/linux/netfilter/x_tables.h             |  38 ++------
 include/linux/nospec.h                         |   1 +
 include/linux/usb/quirks.h                     |   3 +
 include/linux/workqueue.h                      |   1 +
 kernel/workqueue.c                             |  16 ++++
 net/bridge/netfilter/ebt_among.c               |  21 ++++-
 net/bridge/netfilter/ebtables.c                |  13 ++-
 net/ipv4/netfilter.c                           |   7 +-
 net/ipv4/netfilter/arp_tables.c                |  20 ++--
 net/ipv4/netfilter/ip_tables.c                 |  20 ++--
 net/ipv6/netfilter/ip6_tables.c                |  21 +++--
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c       |   4 +
 net/netfilter/nf_nat_proto_common.c            |   7 +-
 net/netfilter/nfnetlink_queue.c                |   2 +-
 net/netfilter/x_tables.c                       |  55 +++++++++++
 net/netfilter/xt_IDLETIMER.c                   |   9 +-
 net/netfilter/xt_LED.c                         |  12 +--
 net/sctp/sm_make_chunk.c                       |   2 +-
 scripts/Makefile.lib                           |   8 +-
 sound/core/seq/seq_clientmgr.c                 |  21 +++--
 sound/core/seq/seq_fifo.c                      |   2 +-
 sound/core/seq/seq_memory.c                    |  14 ++-
 sound/core/seq/seq_memory.h                    |   3 +-
 sound/pci/hda/patch_conexant.c                 |   2 +
 sound/pci/hda/patch_realtek.c                  |  16 ++++
 67 files changed, 572 insertions(+), 289 deletions(-)
