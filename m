Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17446C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6425218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357765;
	bh=bDSli6pXKXBtz4YEORPidUKfYCnIqKcwQQhEgaymhkI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QJjeDrtDw7mKguKLRxe6bM9J6y0cbgvTKOsK5pkGm3W8zkwrpC53qauoM4cOswtjI
	 DFHLzFL8FfTRuKUWV6MEPSmQsPn1kDqsVQXwY0II2H5eg6HDRWayIKJ32AK4DI9oat
	 NXsXXvWFHSfjoeByQGahrjmPWBipPn86ySJjr0mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfAXTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbfAXTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DE0218D9;
        Thu, 24 Jan 2019 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357762;
        bh=bDSli6pXKXBtz4YEORPidUKfYCnIqKcwQQhEgaymhkI=;
        h=From:To:Cc:Subject:Date:From;
        b=EOw9rgIVV+X0aggZWcjknkyHMsB6V6J3CIV+/ftBfK8CSUfawkptx/xexlDO136u8
         a9GwE3RI6R841ie+kvZ5cMJkFPzUa8aUohPBdX0gvIxFELG9RtC1xJvsztsbihljpp
         dbF1iBBw0uSDMOCYHJdSzu9C0q2kSYN3978mTyYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/52] 3.18.133-stable review
Date:   Thu, 24 Jan 2019 20:19:24 +0100
Message-Id: <20190124190140.879495253@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.133-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.133-rc1
X-KernelTest-Deadline: 2019-01-26T19:01+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.133 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jan 26 19:01:07 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.133-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.133-rc1

Michal Hocko <mhocko@suse.com>
    mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix panic due to unrecovered local alloc

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

Jonas Danielsson <jonas@orbital-systems.com>
    mmc: atmel-mci: do not assume idle after atmci_request_end

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix memory leak when EOF is encountered in quotation

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

Maciej W. Rozycki <macro@linux-mips.org>
    MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Add support for new Realtek Ethernet

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: vb2: be sure to unlock mutex on errors

Ivan Mironov <mironov.ivan@gmail.com>
    drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    block/loop: Use global lock for ioctl() operation.

Xin Long <lucien.xin@gmail.com>
    sctp: allocate sctp_sockaddr_entry with kzalloc

Stephen Smalley <sds@tycho.nsa.gov>
    selinux: fix GPF on invalid policy

J. Bruce Fields <bfields@redhat.com>
    sunrpc: handle ENOMEM in rpcb_getport_async

Hans Verkuil <hverkuil@xs4all.nl>
    media: vb2: vb2_mmap: move lock up

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

Ivan Mironov <mironov.ivan@gmail.com>
    scsi: sd: Fix cache_type_store()

Kees Cook <keescook@chromium.org>
    Yama: Check for pid death before checking ancestry

Josef Bacik <josef@toxicpanda.com>
    btrfs: wait on ordered extents on abort cleanup

Eric Biggers <ebiggers@google.com>
    crypto: authenc - fix parsing key with misaligned rta_len

JianJhen Chen <kchen@synology.com>
    net: bridge: fix a bug on using a neighbour cache entry without checking its state

Jason Gunthorpe <jgg@mellanox.com>
    packet: Do not leak dev refcounts on error exit

Eric Dumazet <edumazet@google.com>
    ipv6: fix kernel-infoleak in ipv6_local_error()

Ben Hutchings <ben@decadent.org.uk>
    media: em28xx: Fix misplaced reset of dev->v4l::field_count

Oliver Hartkopp <socketcan@hartkopp.net>
    can: gw: ensure DLC boundaries after CAN frame modification

Dmitry Safonov <dima@arista.com>
    tty/ldsem: Wake up readers after timed out down_write()

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use-after-free in svc_process_common()

Eric Biggers <ebiggers@google.com>
    crypto: cts - fix crash on short inputs

Yi Zeng <yizeng@asrmicro.com>
    i2c: dev: prevent adapter retries and timeout being set as minus value

Hans de Goede <hdegoede@redhat.com>
    ACPI: power: Skip duplicate power resource references in _PRx

Christoph Lameter <cl@linux.com>
    slab: alien caches must not be initialized if the allocation of the alien cache failed

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: add quirk for SMI SM3350

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: don't insert sane sense for SPC3+ when bad sense specified

Daniele Palmas <dnlplm@gmail.com>
    usb: cdc-acm: send ZLP for Telit 3G Intel based modems

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Fix potential OOB access of lock element array

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not hide EINTR after sending network packets

Andreas Larsson <andreas@gaisler.com>
    sparc32: Fix inverted invalid_frame_pointer checks on sigreturns


-------------

Diffstat:

 Documentation/filesystems/proc.txt               |  4 +-
 Makefile                                         |  4 +-
 arch/arm/mach-imx/clk-imx6q.c                    |  6 ++-
 arch/mips/Kconfig                                |  3 ++
 arch/mips/pci/msi-octeon.c                       |  4 +-
 arch/mips/sibyte/common/Makefile                 |  1 +
 arch/mips/sibyte/common/dma.c                    | 14 +++++++
 arch/sparc/kernel/signal_32.c                    |  4 +-
 crypto/authenc.c                                 | 14 +++++--
 crypto/cts.c                                     |  8 ++--
 drivers/acpi/power.c                             | 22 +++++++++++
 drivers/base/bus.c                               |  7 +++-
 drivers/block/loop.c                             | 47 ++++++++++++------------
 drivers/block/loop.h                             |  1 -
 drivers/cpuidle/cpuidle-pseries.c                |  8 +++-
 drivers/gpu/drm/drm_fb_helper.c                  |  7 +++-
 drivers/i2c/i2c-dev.c                            |  6 +++
 drivers/md/dm-kcopyd.c                           | 19 +++++++---
 drivers/md/dm-snap.c                             | 22 +++++++++++
 drivers/media/firewire/firedtv-avc.c             |  6 ++-
 drivers/media/firewire/firedtv.h                 |  6 ++-
 drivers/media/platform/vivid/vivid-kthread-cap.c |  5 ++-
 drivers/media/platform/vivid/vivid-kthread-out.c |  5 ++-
 drivers/media/platform/vivid/vivid-vid-common.c  |  2 +-
 drivers/media/usb/em28xx/em28xx-video.c          |  4 +-
 drivers/media/v4l2-core/videobuf2-core.c         | 14 +++++--
 drivers/mfd/tps6586x.c                           | 24 ++++++++++++
 drivers/mmc/host/atmel-mci.c                     |  3 +-
 drivers/net/ethernet/realtek/r8169.c             |  2 +
 drivers/scsi/sd.c                                |  6 +++
 drivers/target/target_core_spc.c                 | 17 ++++++---
 drivers/tty/tty_ldsem.c                          | 10 +++++
 drivers/usb/class/cdc-acm.c                      |  7 ++++
 drivers/usb/storage/scsiglue.c                   |  8 +++-
 drivers/usb/storage/unusual_devs.h               | 12 ++++++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |  2 +
 fs/btrfs/disk-io.c                               |  8 ++++
 fs/cifs/file.c                                   |  8 ++--
 fs/cifs/smb2file.c                               |  4 +-
 fs/cifs/transport.c                              |  2 +-
 fs/jffs2/super.c                                 |  3 +-
 fs/ocfs2/localalloc.c                            |  9 ++++-
 fs/pstore/ram_core.c                             |  5 +++
 include/linux/sunrpc/svc.h                       |  5 ++-
 mm/slab.c                                        |  6 ++-
 net/bridge/br_netfilter.c                        |  2 +-
 net/can/gw.c                                     | 30 +++++++++++++--
 net/core/sock.c                                  |  1 +
 net/ipv6/datagram.c                              |  1 +
 net/packet/af_packet.c                           |  4 +-
 net/sctp/ipv6.c                                  |  5 +--
 net/sctp/protocol.c                              |  4 +-
 net/sunrpc/rpcb_clnt.c                           |  8 ++++
 net/sunrpc/svc.c                                 | 10 +++--
 net/sunrpc/svc_xprt.c                            |  5 ++-
 net/sunrpc/svcsock.c                             |  2 +-
 scripts/kconfig/zconf.l                          |  2 +
 security/selinux/ss/policydb.c                   |  3 +-
 security/yama/yama_lsm.c                         |  4 +-
 sound/firewire/bebob/bebob.c                     |  2 +-
 tools/perf/util/parse-events.c                   |  2 +-
 tools/perf/util/svghelper.c                      |  2 +-
 62 files changed, 366 insertions(+), 105 deletions(-)


