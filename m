Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0EF2159B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0EF2159B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeI0PZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32BD210A4;
        Thu, 27 Sep 2018 09:07:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 00/88] 4.18.11-stable review
Date:   Thu, 27 Sep 2018 11:02:41 +0200
Message-Id: <20180927090300.631426620@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.11-rc1
X-KernelTest-Deadline: 2018-09-29T09:03+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.11 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Sep 29 09:02:26 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.11-rc1

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: only allow 1 flush on user qps

Nadav Amit <namit@vmware.com>
    vmw_balloon: include asm/io.h

Steve Muckle <smuckle@google.com>
    sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

Toshi Kani <toshi.kani@hpe.com>
    ext4, dax: set ext4_dax_aops for dax files

Toshi Kani <toshi.kani@hpe.com>
    ext4, dax: add ext4_bmap to ext4_dax_aops

Eric Biggers <ebiggers@google.com>
    ext4: show test_dummy_encryption mount option in /proc/mounts

Li Dongyang <dongyangli@ddn.com>
    ext4: don't mark mmp buffer head dirty

Theodore Ts'o <tytso@mit.edu>
    ext4: fix online resizing for bigalloc file systems with a 1k block size

Theodore Ts'o <tytso@mit.edu>
    ext4: fix online resize's handling of a too-small final block group

Theodore Ts'o <tytso@mit.edu>
    ext4: recalucate superblock checksum after updating free blocks/inodes

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid arithemetic overflow that can trigger a BUG

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid divide by zero fault when deleting corrupted inline directories

Theodore Ts'o <tytso@mit.edu>
    ext4: check to make sure the rename(2)'s destination is not freed

Gustavo A. R. Silva <gustavo@embeddedor.com>
    tty: vt_ioctl: fix potential Spectre v1

Lyude Paul <lyude@redhat.com>
    drm/atomic: Use drm_drv_uses_atomic_modeset() for debugfs creation

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add new polaris pci id

Emil Lundmark <lndmrk@chromium.org>
    drm: udl: Destroy framebuffer only if it was initialized

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Fix the "no scaling" case on multi-planar YUV formats

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Fix deadlock with fb_helper with async RPM requests

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Don't forget to cancel hpd_work on suspend/unload

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Fix deadlocks in nouveau_connector_detect()

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Only write DP_MSTM_CTRL when needed

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Reset MST branching unit before enabling

Imre Deak <imre.deak@intel.com>
    drm/i915/bdw: Increase IPS disable timeout to 100ms

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix ocfs2 read block panic

Jens Axboe <axboe@kernel.dk>
    libata: mask swap internal and hardware tag

Richard Weinberger <richard@nod.at>
    Revert "ubifs: xattr: Don't operate on deleted inodes"

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use bin2hex instead of a re-implementation

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use hex2bin instead of a re-implementation

Lubomir Rintel <lkundrak@v3.sk>
    Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"

Alexei Starovoitov <ast@kernel.org>
    bpf/verifier: disallow pointer subtraction

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "rpmsg: core: add support to power domains for devices"

Joel Fernandes (Google) <joel@joelfernandes.org>
    mm: shmem.c: Correctly annotate new inodes for lockdep

Pasha Tatashin <Pavel.Tatashin@microsoft.com>
    mm: disable deferred struct page for 32-bit arches

KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
    fork: report pid exhaustion correctly

Ondrej Mosnacek <omosnace@redhat.com>
    crypto: x86/aegis,morus - Do not require OSXSAVE for SSE2

Vaibhav Nagarnaik <vnagarnaik@google.com>
    ring-buffer: Allow for rescheduling when removing pages

Mika Westerberg <mika.westerberg@linux.intel.com>
    Revert "PCI: Add ACS quirk for Intel 300 series"

Kirill Kapranov <kirill.kapranov@compulab.co.il>
    spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen/x86/vpmu: Zero struct pt_regs before calling into sample handling code

Juergen Gross <jgross@suse.com>
    xen/netfront: don't bug in case of too many frags

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: alienware-wmi: Correct a memory leak

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: dell-smbios-wmi: Correct a memory leak

Masahiro Yamada <yamada.masahiro@socionext.com>
    mtd: rawnand: denali: fix a race condition when DMA is kicked

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: devices: m25p80: Make sure the buffer passed in op is DMA-able

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: fix memory leak of private data

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: fix memory leak of discovered stream formats at error path

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: fix memory leak for model-dependent data at error path

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: fireworks: fix memory leak of response buffer at error path

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-tascam: fix memory leak of private data

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-digi00x: fix memory leak of private data

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: fireface: fix memory leak in ff400_switch_fetching_mode()

Willy Tarreau <w@1wt.eu>
    ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at error path

Dmitry V. Levin <ldv@altlinux.org>
    ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation errors

Jiada Wang <jiada_wang@mentor.com>
    ASoC: rsnd: fixup not to call clk_get/set under non-atomic

Andrew F. Davis <afd@ti.com>
    ASoC: tas6424: Save last fault register even when clear

Sébastien Szymanski <sebastien.szymanski@armadeus.com>
    ASoC: cs4265: fix MMTLR Data switch control

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    ASoC: wm9712: fix replace codec to component

Suren Baghdasaryan <surenb@google.com>
    NFC: Fix the number of pipes

Suren Baghdasaryan <surenb@google.com>
    NFC: Fix possible memory corruption when handling SHDLC I-Frame commands

Roopa Prabhu <roopa@cumulusnetworks.com>
    net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_flags

Antoine Tenart <antoine.tenart@bootlin.com>
    net: mvpp2: let phylink manage the carrier state

Peter Oskolkov <posk@google.com>
    net/ipv6: do not copy dst flags on rt init

Xin Long <lucien.xin@gmail.com>
    ipv6: use rt6_info members when dst is set in rt6_fill_node

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix VF mac address regression.

Daniel Borkmann <daniel@iogearbox.net>
    tls: fix currently broken MSG_PEEK behavior

Johannes Berg <johannes.berg@intel.com>
    socket: fix struct ifreq size in compat ioctl

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix ATU Miss Violation

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix schedule in RCU context

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_sample: fix NULL dereference in the data path

Paolo Abeni <pabeni@redhat.com>
    udp6: add missing checks on edumux packet processing

Vasily Khoruzhick <vasilykh@arista.com>
    neighbour: confirm neigh entries when ARP packet is received

Sabrina Dubroca <sd@queasysnail.net>
    tls: clear key material from kernel memory when do_tls_setsockopt_conf fails

Sabrina Dubroca <sd@queasysnail.net>
    tls: zero the crypto information from tls_context before freeing

Sabrina Dubroca <sd@queasysnail.net>
    tls: don't copy the key out of tls12_crypto_info_aes_gcm_128

Paolo Abeni <pabeni@redhat.com>
    udp4: fix IP_CMSG_CHECKSUM for connected sockets

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: set DTR for modems in forced USB2 mode

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: fix reception of frames with no mac header

Colin Ian King <colin.king@canonical.com>
    net: hp100: fix always-true check for link up state

Willy Tarreau <w@1wt.eu>
    net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Eric Dumazet <edumazet@google.com>
    ipv6: fix possible use-after-free in ip6_xmit()

Toke Høiland-Jørgensen <toke@toke.dk>
    gso_segment: Reset skb->mac_len after modifying network header


-------------

Diffstat:

 Makefile                                        |   4 +-
 arch/x86/crypto/aegis128-aesni-glue.c           |   1 -
 arch/x86/crypto/aegis128l-aesni-glue.c          |   1 -
 arch/x86/crypto/aegis256-aesni-glue.c           |   1 -
 arch/x86/crypto/morus1280-sse2-glue.c           |   1 -
 arch/x86/crypto/morus640-sse2-glue.c            |   1 -
 arch/x86/xen/pmu.c                              |   2 +-
 drivers/ata/libata-core.c                       |  14 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c         |  14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |   1 +
 drivers/gpu/drm/drm_atomic.c                    |   2 +-
 drivers/gpu/drm/drm_debugfs.c                   |   2 +-
 drivers/gpu/drm/i915/intel_display.c            |   8 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c         |  67 +++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c     |  42 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_display.c       |  44 +++++++---
 drivers/gpu/drm/nouveau/nouveau_display.h       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c           |   3 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c         |  57 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h         |   5 ++
 drivers/gpu/drm/udl/udl_fb.c                    |   8 +-
 drivers/gpu/drm/vc4/vc4_plane.c                 |  25 +++---
 drivers/infiniband/hw/cxgb4/qp.c                |   6 ++
 drivers/misc/vmw_balloon.c                      |   1 +
 drivers/mtd/devices/m25p80.c                    |  26 +++++-
 drivers/mtd/nand/raw/denali.c                   |   6 ++
 drivers/net/appletalk/ipddp.c                   |   8 +-
 drivers/net/dsa/mv88e6xxx/global1.h             |   2 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c         |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h |   2 +-
 drivers/net/ethernet/hp/hp100.c                 |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  21 ++---
 drivers/net/hyperv/netvsc_drv.c                 |   9 +-
 drivers/net/ppp/pppoe.c                         |   3 +
 drivers/net/usb/qmi_wwan.c                      |  14 ++--
 drivers/net/xen-netfront.c                      |   8 +-
 drivers/pci/quirks.c                            |   6 --
 drivers/platform/x86/alienware-wmi.c            |   1 +
 drivers/platform/x86/dell-smbios-wmi.c          |   1 +
 drivers/rpmsg/rpmsg_core.c                      |   7 --
 drivers/spi/spi.c                               |   9 ++
 drivers/target/iscsi/iscsi_target_auth.c        |  45 ++++------
 drivers/tty/vt/vt_ioctl.c                       |   4 +
 fs/ext4/dir.c                                   |  20 ++---
 fs/ext4/ext4.h                                  |   3 +
 fs/ext4/inline.c                                |   4 +-
 fs/ext4/inode.c                                 |  11 ++-
 fs/ext4/mmp.c                                   |   1 -
 fs/ext4/namei.c                                 |   6 ++
 fs/ext4/resize.c                                |  23 ++++-
 fs/ext4/super.c                                 |   4 +
 fs/ocfs2/buffer_head_io.c                       |   1 +
 fs/ubifs/xattr.c                                |  24 ------
 include/net/nfc/hci.h                           |   2 +-
 include/net/tls.h                               |  19 ++---
 include/uapi/linux/keyctl.h                     |   2 +-
 include/uapi/sound/skl-tplg-interface.h         | 106 ++++++++++++------------
 kernel/bpf/verifier.c                           |   2 +-
 kernel/pid.c                                    |   2 +-
 kernel/sched/fair.c                             |   3 +-
 kernel/trace/ring_buffer.c                      |   2 +
 mm/Kconfig                                      |   1 +
 mm/shmem.c                                      |   2 +
 net/core/neighbour.c                            |  13 +--
 net/core/rtnetlink.c                            |   2 +-
 net/ipv4/af_inet.c                              |   1 +
 net/ipv4/udp.c                                  |  49 ++++++-----
 net/ipv6/ip6_offload.c                          |   1 +
 net/ipv6/ip6_output.c                           |   6 +-
 net/ipv6/route.c                                |  44 ++++++----
 net/ipv6/udp.c                                  |  65 ++++++++-------
 net/nfc/hci/core.c                              |  10 +++
 net/sched/act_sample.c                          |   2 +-
 net/socket.c                                    |  22 +++--
 net/tls/tls_device.c                            |   4 +-
 net/tls/tls_device_fallback.c                   |   2 +-
 net/tls/tls_main.c                              |  22 +++--
 net/tls/tls_sw.c                                |  21 +++--
 security/keys/dh.c                              |   2 +-
 sound/firewire/bebob/bebob.c                    |   2 +
 sound/firewire/bebob/bebob_maudio.c             |  28 +++----
 sound/firewire/digi00x/digi00x.c                |   1 +
 sound/firewire/fireface/ff-protocol-ff400.c     |   9 +-
 sound/firewire/fireworks/fireworks.c            |   2 +
 sound/firewire/oxfw/oxfw.c                      |  10 +++
 sound/firewire/tascam/tascam.c                  |   1 +
 sound/pci/emu10k1/emufx.c                       |   2 +-
 sound/soc/codecs/cs4265.c                       |   4 +-
 sound/soc/codecs/tas6424.c                      |  12 ++-
 sound/soc/codecs/wm9712.c                       |   2 +-
 sound/soc/sh/rcar/core.c                        |  11 +++
 sound/soc/sh/rcar/rsnd.h                        |   7 ++
 sound/soc/sh/rcar/ssi.c                         |  16 ++--
 95 files changed, 714 insertions(+), 403 deletions(-)


