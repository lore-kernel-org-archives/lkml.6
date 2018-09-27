Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0598C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C212150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C212150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeI0PnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:43:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeI0PnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:43:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0A5D111C;
        Thu, 27 Sep 2018 09:25:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/44] 4.9.130-stable review
Date:   Thu, 27 Sep 2018 11:03:49 +0200
Message-Id: <20180927090117.997362691@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.130-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.130-rc1
X-KernelTest-Deadline: 2018-09-29T09:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.130 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Sep 29 09:00:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.130-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.130-rc1

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: only allow 1 flush on user qps

Nadav Amit <namit@vmware.com>
    vmw_balloon: include asm/io.h

Zachary Zhang <zhangzg@marvell.com>
    PCI: aardvark: Size bridges before resources allocation

Roderick Colenbrander <roderick.colenbrander@sony.com>
    HID: sony: Support DS4 dongle

Roderick Colenbrander <roderick.colenbrander@sony.com>
    HID: sony: Update device ids

Steve Muckle <smuckle@google.com>
    sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

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
    ext4: avoid divide by zero fault when deleting corrupted inline directories

Theodore Ts'o <tytso@mit.edu>
    ext4: check to make sure the rename(2)'s destination is not freed

Gustavo A. R. Silva <gustavo@embeddedor.com>
    tty: vt_ioctl: fix potential Spectre v1

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Fix the "no scaling" case on multi-planar YUV formats

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix ocfs2 read block panic

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use hex2bin instead of a re-implementation

Vasily Khoruzhick <vasilykh@arista.com>
    neighbour: confirm neigh entries when ARP packet is received

Paolo Abeni <pabeni@redhat.com>
    udp4: fix IP_CMSG_CHECKSUM for connected sockets

Colin Ian King <colin.king@canonical.com>
    net: hp100: fix always-true check for link up state

Willy Tarreau <w@1wt.eu>
    net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Eric Dumazet <edumazet@google.com>
    ipv6: fix possible use-after-free in ip6_xmit()

Toke Høiland-Jørgensen <toke@toke.dk>
    gso_segment: Reset skb->mac_len after modifying network header

Joel Fernandes (Google) <joel@joelfernandes.org>
    mm: shmem.c: Correctly annotate new inodes for lockdep

Vaibhav Nagarnaik <vnagarnaik@google.com>
    ring-buffer: Allow for rescheduling when removing pages

Mika Westerberg <mika.westerberg@linux.intel.com>
    Revert "PCI: Add ACS quirk for Intel 300 series"

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen/x86/vpmu: Zero struct pt_regs before calling into sample handling code

Juergen Gross <jgross@suse.com>
    xen/netfront: don't bug in case of too many frags

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: alienware-wmi: Correct a memory leak

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

Willy Tarreau <w@1wt.eu>
    ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at error path

Sébastien Szymanski <sebastien.szymanski@armadeus.com>
    ASoC: cs4265: fix MMTLR Data switch control

Suren Baghdasaryan <surenb@google.com>
    NFC: Fix the number of pipes

Suren Baghdasaryan <surenb@google.com>
    NFC: Fix possible memory corruption when handling SHDLC I-Frame commands


-------------

Diffstat:

 Makefile                                    |  4 +--
 arch/x86/xen/pmu.c                          |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 20 ++++++------
 drivers/gpu/drm/nouveau/nouveau_display.c   | 33 ++++++++++++++-----
 drivers/gpu/drm/vc4/vc4_plane.c             | 25 +++++++--------
 drivers/hid/hid-core.c                      |  3 ++
 drivers/hid/hid-ids.h                       |  2 ++
 drivers/hid/hid-sony.c                      |  6 ++++
 drivers/infiniband/hw/cxgb4/qp.c            |  6 ++++
 drivers/misc/vmw_balloon.c                  |  1 +
 drivers/net/appletalk/ipddp.c               |  8 +++--
 drivers/net/ethernet/hp/hp100.c             |  2 +-
 drivers/net/xen-netfront.c                  |  8 ++++-
 drivers/pci/host/pci-aardvark.c             |  1 +
 drivers/pci/quirks.c                        |  6 ----
 drivers/platform/x86/alienware-wmi.c        |  1 +
 drivers/target/iscsi/iscsi_target_auth.c    | 30 +++++++++---------
 drivers/tty/vt/vt_ioctl.c                   |  4 +++
 fs/ext4/dir.c                               | 20 ++++++------
 fs/ext4/inline.c                            |  4 ++-
 fs/ext4/mmp.c                               |  1 -
 fs/ext4/namei.c                             |  6 ++++
 fs/ext4/resize.c                            | 23 +++++++++++++-
 fs/ext4/super.c                             |  4 +++
 fs/ocfs2/buffer_head_io.c                   |  1 +
 include/net/nfc/hci.h                       |  2 +-
 kernel/sched/fair.c                         |  3 +-
 kernel/trace/ring_buffer.c                  |  2 ++
 mm/shmem.c                                  |  2 ++
 net/core/neighbour.c                        | 13 +++++---
 net/ipv4/af_inet.c                          |  1 +
 net/ipv4/udp.c                              | 49 +++++++++++++++--------------
 net/ipv6/ip6_offload.c                      |  1 +
 net/ipv6/ip6_output.c                       |  6 ++--
 net/nfc/hci/core.c                          | 10 ++++++
 sound/firewire/bebob/bebob.c                |  2 ++
 sound/firewire/bebob/bebob_maudio.c         | 28 ++++++++---------
 sound/firewire/digi00x/digi00x.c            |  1 +
 sound/firewire/fireworks/fireworks.c        |  2 ++
 sound/firewire/oxfw/oxfw.c                  | 10 ++++++
 sound/firewire/tascam/tascam.c              |  1 +
 sound/pci/emu10k1/emufx.c                   |  2 +-
 sound/soc/codecs/cs4265.c                   |  4 +--
 43 files changed, 236 insertions(+), 124 deletions(-)


