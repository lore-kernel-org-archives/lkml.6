Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48940C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1AF217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360767;
	bh=XSA1wSz8CugOTyCIlyksltB0RHH+Ki+IZLMCvaxpwww=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=We2rH2sOqRSmTXXAOjeoV19k1crUH9fvaetOYcAm8/dJK3bMspGH7w2FRvLkWHz+a
	 wgWXejK5YAkJ/D7WNxKPL2yM7KEU583LIz1hss33HFCZf418k5ds6B7g5O0xBLD4Ts
	 8XGI2BTd1a+LxKFz7Q7G0fkwpDN/S3CEH3Dbpg4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfAXUMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:12:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfAXTZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34341218FC;
        Thu, 24 Jan 2019 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357947;
        bh=XSA1wSz8CugOTyCIlyksltB0RHH+Ki+IZLMCvaxpwww=;
        h=From:To:Cc:Subject:Date:From;
        b=s0cmmwc/tZo6wJThByiJcjF/F5+sgxdxavg1OGdWNnKs0rqRG6qJQ+7uwbEJmSLbA
         w4VEQ/QIZkPzLFVFbvKaqk16k5yv4YtJmjODM2DKXXAqji6vuGm6OqI7thXCWXVHeh
         d18vP118emMLyINKXBxILl460aIk6P7pMwHA9bNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/104] 4.4.172-stable review
Date:   Thu, 24 Jan 2019 20:18:49 +0100
Message-Id: <20190124190154.968308875@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.172-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.172-rc1
X-KernelTest-Deadline: 2019-01-26T19:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.172 release.
There are 104 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jan 26 19:01:09 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.172-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.172-rc1

Corey Minyard <cminyard@mvista.com>
    ipmi:ssif: Fix handling of multi-part return messages

Eric Dumazet <edumazet@google.com>
    net: speed up skb_rbtree_purge()

Michal Hocko <mhocko@suse.com>
    mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps

Brian Foster <bfoster@redhat.com>
    mm/page-writeback.c: don't break integrity writeback on ->writepage() error

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix panic due to unrecovered local alloc

Qian Cai <cai@lca.pw>
    scsi: megaraid: fix out-of-bound array accesses

Daniel Vetter <daniel.vetter@ffwll.ch>
    sysfs: Disable lockdep for driver bind/unbind files

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix model-id of unit for Apogee Ensemble

Nikos Tsironis <ntsironis@arrikto.com>
    dm snapshot: Fix excessive memory usage and workqueue stalls

Nikos Tsironis <ntsironis@arrikto.com>
    dm kcopyd: Fix bug causing workqueue stalls

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf parse-events: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf svghelper: Fix unchecked usage of strncpy()

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error with config term "pt=0"

Jonas Danielsson <jonas@orbital-systems.com>
    mmc: atmel-mci: do not assume idle after atmci_request_end

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix memory leak when EOF is encountered in quotation

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix file name and line number of warn_ignored_character()

Lucas Stach <l.stach@pengutronix.de>
    clk: imx6q: reset exclusive gates on init

David Disseldorp <ddiss@suse.de>
    scsi: target: use consistent left-aligned ASCII INQUIRY data

yupeng <yupeng0921@gmail.com>
    net: call sk_dst_reset when set SO_DONTROUTE

Nathan Chancellor <natechancellor@gmail.com>
    media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Breno Leitao <leitao@debian.org>
    powerpc/pseries/cpuidle: Fix preempt warning

Joel Fernandes (Google) <joel@joelfernandes.org>
    pstore/ram: Do not treat empty buffers as valid

Daniel Santos <daniel.santos@pobox.com>
    jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Anders Roxell <anders.roxell@linaro.org>
    arm64: perf: set suppress_bind_attrs flag to true

Maciej W. Rozycki <macro@linux-mips.org>
    MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Anders Roxell <anders.roxell@linaro.org>
    writeback: don't decrement wb->refcnt if !wb->bdi

Miroslav Lichvar <mlichvar@redhat.com>
    e1000e: allow non-monotonic SYSTIM readings

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: don't fail when converting shortform attr to long form during ATTR_REPLACE

David Ahern <dsahern@gmail.com>
    ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Add support for new Realtek Ethernet

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: vb2: be sure to unlock mutex on errors

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

Stephen Smalley <sds@tycho.nsa.gov>
    selinux: fix GPF on invalid policy

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

Jonathan Hunter <jonathanh@nvidia.com>
    mfd: tps6586x: Handle interrupts on suspend

Arnd Bergmann <arnd@arndb.de>
    mips: fix n32 compat_ipc_parse_version

Ivan Mironov <mironov.ivan@gmail.com>
    scsi: sd: Fix cache_type_store()

Kees Cook <keescook@chromium.org>
    Yama: Check for pid death before checking ancestry

Josef Bacik <josef@toxicpanda.com>
    btrfs: wait on ordered extents on abort cleanup

Eric Biggers <ebiggers@google.com>
    crypto: authenc - fix parsing key with misaligned rta_len

Harsh Jain <harsh@chelsio.com>
    crypto: authencesn - Avoid twice completion call in decrypt path

Willem de Bruijn <willemb@google.com>
    ip: on queued skb use skb_header_pointer instead of pskb_may_pull

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

Gwendal Grignou <gwendal@chromium.org>
    proc: Remove empty line in /proc/self/status

Ben Hutchings <ben@decadent.org.uk>
    media: em28xx: Fix misplaced reset of dev->v4l::field_count

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    f2fs: fix validation of the block count in sanity_check_raw_super

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix missing up_read

Chao Yu <yuchao0@huawei.com>
    f2fs: fix invalid memory access

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with cp_pack_start_sum

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with block address in main area v2

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with block address in main area

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with reserved blkaddr of inline inode

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with node footer and iblocks

Ben Hutchings <ben.hutchings@codethink.co.uk>
    f2fs: Add sanity_check_inode() function

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with user_block_count

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with secs_per_zone

Chao Yu <yuchao0@huawei.com>
    f2fs: introduce and spread verify_blkaddr

Chao Yu <yuchao0@huawei.com>
    f2fs: clean up with is_valid_blkaddr()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: enhance sanity_check_raw_super() to avoid potential overflow

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check on sit entry

Yunlei He <heyunlei@huawei.com>
    f2fs: check blkaddr more accuratly before issue a bio

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: return error during fill_super

Chao Yu <yuchao0@huawei.com>
    f2fs: fix race condition in between free nid allocator/initializer

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: free meta pages if sanity check for ckpt is failed

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: detect wrong layout

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: put directory inodes before checkpoint in roll-forward recovery

Tiezhu Yang <kernelpatch@126.com>
    f2fs: introduce get_checkpoint_version for cleanup

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: use crc and cp version to determine roll-forward recovery

Chao Yu <yuchao0@huawei.com>
    f2fs: avoid unneeded loop in build_sit_entries

Yunlei He <heyunlei@huawei.com>
    f2fs: not allow to write illegal blkaddr

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to avoid reading out encrypted data in page cache

Chao Yu <yuchao0@huawei.com>
    f2fs: fix inode cache leak

Chao Yu <yuchao0@huawei.com>
    f2fs: factor out fsync inode entry operations

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: remove an obsolete variable

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: give -EINVAL for norecovery and rw mount

Chao Yu <chao2.yu@samsung.com>
    f2fs: fix to convert inline directory correctly

Shawn Lin <shawn.lin@rock-chips.com>
    f2fs: move sanity checking of cp into get_valid_checkpoint

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: cover more area with nat_tree_lock

Chao Yu <chao2.yu@samsung.com>
    f2fs: clean up argument of recover_data

Oliver Hartkopp <socketcan@hartkopp.net>
    can: gw: ensure DLC boundaries after CAN frame modification

Dmitry Safonov <dima@arista.com>
    tty/ldsem: Wake up readers after timed out down_write()


-------------

Diffstat:

 Documentation/filesystems/proc.txt               |   4 +-
 Makefile                                         |   4 +-
 arch/arm64/include/asm/kvm_arm.h                 |   3 +
 arch/arm64/kernel/head.S                         |   3 +-
 arch/arm64/kernel/perf_event.c                   |   1 +
 arch/arm64/kvm/hyp.S                             |   2 +-
 arch/mips/Kconfig                                |   4 +
 arch/mips/pci/msi-octeon.c                       |   4 +-
 arch/mips/sibyte/common/Makefile                 |   1 +
 arch/mips/sibyte/common/dma.c                    |  14 ++
 crypto/authenc.c                                 |  14 +-
 crypto/authencesn.c                              |   2 +-
 drivers/base/bus.c                               |   7 +-
 drivers/block/loop.c                             |  79 +++++------
 drivers/block/loop.h                             |   1 -
 drivers/char/ipmi/ipmi_ssif.c                    |  25 ++--
 drivers/clk/imx/clk-imx6q.c                      |   6 +-
 drivers/cpuidle/cpuidle-pseries.c                |   8 +-
 drivers/gpu/drm/drm_fb_helper.c                  |   7 +-
 drivers/md/dm-kcopyd.c                           |  19 ++-
 drivers/md/dm-snap.c                             |  22 +++
 drivers/media/firewire/firedtv-avc.c             |   6 +-
 drivers/media/firewire/firedtv.h                 |   6 +-
 drivers/media/platform/vivid/vivid-kthread-cap.c |   5 +-
 drivers/media/platform/vivid/vivid-kthread-out.c |   5 +-
 drivers/media/platform/vivid/vivid-vid-common.c  |   2 +-
 drivers/media/usb/em28xx/em28xx-video.c          |   4 +-
 drivers/media/v4l2-core/videobuf2-core.c         |  14 +-
 drivers/mfd/tps6586x.c                           |  24 ++++
 drivers/mmc/host/atmel-mci.c                     |   3 +-
 drivers/net/ethernet/intel/e1000e/ptp.c          |  13 +-
 drivers/net/ethernet/realtek/r8169.c             |   2 +
 drivers/platform/x86/asus-wmi.c                  |   3 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c          |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c      |   2 +-
 drivers/scsi/sd.c                                |   6 +
 drivers/target/target_core_spc.c                 |  17 ++-
 drivers/tty/tty_ldsem.c                          |  10 ++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |   2 +
 fs/btrfs/disk-io.c                               |   8 ++
 fs/f2fs/checkpoint.c                             | 168 ++++++++++++-----------
 fs/f2fs/data.c                                   | 118 ++++++++++------
 fs/f2fs/dir.c                                    |  87 ++++++------
 fs/f2fs/f2fs.h                                   |  77 ++++++++---
 fs/f2fs/file.c                                   |  21 ++-
 fs/f2fs/inline.c                                 | 115 +++++++++++++++-
 fs/f2fs/inode.c                                  |  68 ++++++++-
 fs/f2fs/node.c                                   | 103 ++++++++------
 fs/f2fs/node.h                                   |  77 +++++++----
 fs/f2fs/recovery.c                               | 165 +++++++++++-----------
 fs/f2fs/segment.c                                |  93 +++++++------
 fs/f2fs/segment.h                                |  48 +++++--
 fs/f2fs/super.c                                  | 134 +++++++++++++++---
 fs/jffs2/super.c                                 |   3 +-
 fs/ocfs2/localalloc.c                            |   9 +-
 fs/proc/array.c                                  |   2 +-
 fs/pstore/ram_core.c                             |   5 +
 fs/xfs/libxfs/xfs_attr.c                         |   9 +-
 include/linux/backing-dev-defs.h                 |   8 ++
 include/linux/f2fs_fs.h                          |   3 +
 mm/page-writeback.c                              |  35 +++--
 net/bridge/br_netfilter_hooks.c                  |   2 +-
 net/can/gw.c                                     |  30 +++-
 net/core/skbuff.c                                |  11 +-
 net/core/sock.c                                  |   1 +
 net/ipv4/ip_sockglue.c                           |  12 +-
 net/ipv6/af_inet6.c                              |  14 +-
 net/ipv6/datagram.c                              |  11 +-
 net/packet/af_packet.c                           |   4 +-
 net/sctp/ipv6.c                                  |   5 +-
 net/sctp/protocol.c                              |   4 +-
 net/sunrpc/rpcb_clnt.c                           |   8 ++
 net/tipc/netlink_compat.c                        |  50 ++++++-
 scripts/kconfig/zconf.l                          |   4 +-
 security/security.c                              |   7 +
 security/selinux/ss/policydb.c                   |   3 +-
 security/yama/yama_lsm.c                         |   4 +-
 sound/firewire/bebob/bebob.c                     |   2 +-
 tools/perf/arch/x86/util/intel-pt.c              |  11 ++
 tools/perf/util/parse-events.c                   |   2 +-
 tools/perf/util/svghelper.c                      |   2 +-
 81 files changed, 1335 insertions(+), 564 deletions(-)


