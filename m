Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AEFC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F9420879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079102;
	bh=HRSPJAgL/X9jshxzNmWhiiVrMuJzfSMzyZ0STGF2qPY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DmSDq4xon74jcyZBFH2FfDF/fOtUaHuTwOacFo+/pyOC1fPzVel8IFXpFzVDZBOKS
	 nPplJiJj4ytZ1GmHO0h3h8ecNE5APQGREqrDnxTC48LN69x+XJUhCR2ppRjRVhXRhh
	 kHLvyfYk/EGJT8JmtpRWDirwjxuRb0t6kmrmsCxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfAUN6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731804AbfAUNzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DFBB2084C;
        Mon, 21 Jan 2019 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078947;
        bh=HRSPJAgL/X9jshxzNmWhiiVrMuJzfSMzyZ0STGF2qPY=;
        h=From:To:Cc:Subject:Date:From;
        b=Xz9wsbllw90csSfWVKoly6w4c/1v6GNtHRY5BtrR44WP0Pj5Okblm64oBcd/JzTHc
         kDouaHrlMbQY709g5g9Yyh2SSWow2v18bO3MAv4xqce3sJpNELh4sMH14ZRbebnLn+
         diY4GIO0Tng+CQI79xIvYERvngju5s6HVgIQWnzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/51] 4.9.152-stable review
Date:   Mon, 21 Jan 2019 14:43:56 +0100
Message-Id: <20190121122453.700446926@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.152-rc1
X-KernelTest-Deadline: 2019-01-23T12:24+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.152 release.
There are 51 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jan 23 12:24:02 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.152-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.152-rc1

Michal Hocko <mhocko@suse.com>
    mm, memcg: fix reclaim deadlock with writeback

Ivan Mironov <mironov.ivan@gmail.com>
    drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Jan Kara <jack@suse.cz>
    loop: Get rid of loop_index_mutex

Jan Kara <jack@suse.cz>
    loop: Fold __loop_release into loop_release

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    block/loop: Use global lock for ioctl() operation.

Ying Xue <ying.xue@windriver.com>
    tipc: fix uninit-value in tipc_nl_compat_doit

Ying Xue <ying.xue@windriver.com>
    tipc: fix uninit-value in tipc_nl_compat_name_table_dump

Ying Xue <ying.xue@windriver.com>
    tipc: fix uninit-value in tipc_nl_compat_link_set

Ying Xue <ying.xue@windriver.com>
    tipc: fix uninit-value in tipc_nl_compat_bearer_enable

Ying Xue <ying.xue@windriver.com>
    tipc: fix uninit-value in tipc_nl_compat_link_reset_stats

Xin Long <lucien.xin@gmail.com>
    sctp: allocate sctp_sockaddr_entry with kzalloc

Jan Kara <jack@suse.cz>
    blockdev: Fix livelocks on loop device

Stephen Smalley <sds@tycho.nsa.gov>
    selinux: fix GPF on invalid policy

Shakeel Butt <shakeelb@google.com>
    netfilter: ebtables: account ebt_table_info to kmemcg

J. Bruce Fields <bfields@redhat.com>
    sunrpc: handle ENOMEM in rpcb_getport_async

Hans Verkuil <hverkuil@xs4all.nl>
    media: vb2: vb2_mmap: move lock up

James Morris <james.morris@microsoft.com>
    LSM: Check for NULL cred-security on free

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: set min width/height to a value > 0

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: fix error handling of kthread_run

Vlad Tsyrklevich <vlad@tsyrklevich.net>
    omap2fb: Fix stack memory disclosure

YunQiang Su <ysu@wavecomp.com>
    Disable MSI also when pcie-octeon.pcie_disable on

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: kaslr: ensure randomized quantities are clean to the PoC

Jonathan Hunter <jonathanh@nvidia.com>
    mfd: tps6586x: Handle interrupts on suspend

Arnd Bergmann <arnd@arndb.de>
    mips: fix n32 compat_ipc_parse_version

Christophe Leroy <christophe.leroy@c-s.fr>
    crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK

Christophe Leroy <christophe.leroy@c-s.fr>
    crypto: talitos - reorder code in talitos_edesc_alloc()

Ivan Mironov <mironov.ivan@gmail.com>
    scsi: sd: Fix cache_type_store()

Stanley Chu <stanley.chu@mediatek.com>
    scsi: core: Synchronize request queue PM status only on successful resume

Kees Cook <keescook@chromium.org>
    Yama: Check for pid death before checking ancestry

Josef Bacik <josef@toxicpanda.com>
    btrfs: wait on ordered extents on abort cleanup

Eric Biggers <ebiggers@google.com>
    crypto: authenc - fix parsing key with misaligned rta_len

Harsh Jain <harsh@chelsio.com>
    crypto: authencesn - Avoid twice completion call in decrypt path

Aymen Sghaier <aymen.sghaier@nxp.com>
    crypto: caam - fix zero-length buffer DMA mapping

Willem de Bruijn <willemb@google.com>
    ip: on queued skb use skb_header_pointer instead of pskb_may_pull

Willem de Bruijn <willemb@google.com>
    bonding: update nest level on unlink

Jason Gunthorpe <jgg@mellanox.com>
    packet: Do not leak dev refcounts on error exit

JianJhen Chen <kchen@synology.com>
    net: bridge: fix a bug on using a neighbour cache entry without checking its state

Eric Dumazet <edumazet@google.com>
    ipv6: fix kernel-infoleak in ipv6_local_error()

Mark Rutland <mark.rutland@arm.com>
    arm64: Don't trap host pointer auth use to EL2

Mark Rutland <mark.rutland@arm.com>
    arm64/kvm: consistently handle host HCR_EL2 flags

Varun Prakash <varun@chelsio.com>
    scsi: target: iscsi: cxgbit: fix csk leak

Sasha Levin <sashal@kernel.org>
    Revert "scsi: target: iscsi: cxgbit: fix csk leak"

Guenter Roeck <linux@roeck-us.net>
    proc: Remove empty line in /proc/self/status

Ben Hutchings <ben@decadent.org.uk>
    media: em28xx: Fix misplaced reset of dev->v4l::field_count

Chao Yu <yuchao0@huawei.com>
    Revert "f2fs: do not recover from previous remained wrong dnodes"

Oliver Hartkopp <socketcan@hartkopp.net>
    can: gw: ensure DLC boundaries after CAN frame modification

Dmitry Safonov <dima@arista.com>
    tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Dmitry Safonov <dima@arista.com>
    tty: Simplify tty->count math in tty_reopen()

Dmitry Safonov <dima@arista.com>
    tty: Hold tty_ldisc_lock() during tty_reopen()

Dmitry Safonov <dima@arista.com>
    tty/ldsem: Wake up readers after timed out down_write()


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/arm64/include/asm/kvm_arm.h                 |  3 +
 arch/arm64/kernel/head.S                         |  5 +-
 arch/arm64/kernel/kaslr.c                        |  8 ++-
 arch/arm64/kvm/hyp/switch.c                      |  2 +-
 arch/mips/Kconfig                                |  1 +
 arch/mips/pci/msi-octeon.c                       |  4 +-
 crypto/authenc.c                                 | 14 ++++-
 crypto/authencesn.c                              |  2 +-
 drivers/block/loop.c                             | 79 ++++++++++++------------
 drivers/block/loop.h                             |  1 -
 drivers/crypto/caam/caamhash.c                   | 15 +++--
 drivers/crypto/talitos.c                         | 27 +++-----
 drivers/gpu/drm/drm_fb_helper.c                  |  7 ++-
 drivers/media/platform/vivid/vivid-kthread-cap.c |  5 +-
 drivers/media/platform/vivid/vivid-kthread-out.c |  5 +-
 drivers/media/platform/vivid/vivid-vid-common.c  |  2 +-
 drivers/media/usb/em28xx/em28xx-video.c          |  4 +-
 drivers/media/v4l2-core/videobuf2-core.c         | 11 +++-
 drivers/mfd/tps6586x.c                           | 24 +++++++
 drivers/net/bonding/bond_main.c                  |  3 +
 drivers/scsi/scsi_pm.c                           | 26 ++++----
 drivers/scsi/sd.c                                |  6 ++
 drivers/tty/tty_io.c                             | 22 ++++---
 drivers/tty/tty_ldsem.c                          | 10 +++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |  2 +
 fs/block_dev.c                                   | 28 ++++++---
 fs/btrfs/disk-io.c                               |  8 +++
 fs/f2fs/recovery.c                               | 31 +---------
 fs/proc/array.c                                  |  3 +-
 mm/memory.c                                      | 22 +++++++
 net/bridge/br_netfilter_hooks.c                  |  2 +-
 net/bridge/netfilter/ebtables.c                  |  6 +-
 net/can/gw.c                                     | 30 ++++++++-
 net/ipv4/ip_sockglue.c                           | 12 ++--
 net/ipv6/datagram.c                              | 11 ++--
 net/packet/af_packet.c                           |  4 +-
 net/sctp/ipv6.c                                  |  5 +-
 net/sctp/protocol.c                              |  4 +-
 net/sunrpc/rpcb_clnt.c                           |  8 +++
 net/tipc/netlink_compat.c                        | 50 ++++++++++++++-
 security/security.c                              |  7 +++
 security/selinux/ss/policydb.c                   |  3 +-
 security/yama/yama_lsm.c                         |  4 +-
 44 files changed, 352 insertions(+), 178 deletions(-)


