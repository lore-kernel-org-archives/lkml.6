Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086321852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298003;
	bh=lpKVLOmXqgXvCCx6C3wuxIUSeqwLxN0r2M+7EkkTQbs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WN6ir3o4jlWEwl45xEWCuz8oIH9N4QizgaPoSkf54VXHcdryx85+ieZNdw3kZIuk+
	 JK8e79tz9bXAbDQmJuIemr1I3Uxs4iakk7vMmkaxiAJY+7dvWKDngAH9OvGjMmC84s
	 FJHI7dLWmQrmvcaO2ctxbCE6WYYUQJrdwCBBmKck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeLTJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbeLTJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DF2217D7;
        Thu, 20 Dec 2018 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297999;
        bh=lpKVLOmXqgXvCCx6C3wuxIUSeqwLxN0r2M+7EkkTQbs=;
        h=From:To:Cc:Subject:Date:From;
        b=S8KKR3SHuBDw9MIhhCUtKiwhceGFp9ESVPtf2CM55V2AUQdJ5ATwR67ZUV3XtlIhp
         T/Wze/KuU3pjxtp96DLMDRa4COovej0xLZdbxLT/7SNwozkZ/zjwJ2ofm/Nd45jGXs
         xl9iIL+69BdbL3W8LHy4fKh8r+sWSeDR6fpsf4UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/72] 4.14.90-stable review
Date:   Thu, 20 Dec 2018 10:17:59 +0100
Message-Id: <20181220085922.332225035@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.90-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.90-rc1
X-KernelTest-Deadline: 2018-12-22T08:59+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.90 release.
There are 72 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.90-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.90-rc1

Nicolas Schichan <nschichan@freebox.fr>
    bpf, arm: fix emit_ldx_r and emit_mov_i using TMP_REG_1

Trent Piepho <tpiepho@impinj.com>
    rtc: snvs: Add timeouts to avoid kernel lockups

Israel Rukshin <israelr@mellanox.com>
    nvmet-rdma: fix response use after free

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier: fix violation of tLOW requirement for Fast-mode

Hans de Goede <hdegoede@redhat.com>
    i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c: axxia: properly handle master timeout

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix reset orphans race with close timeout

Steve French <stfrench@microsoft.com>
    cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)

Sam Bobroff <sbobroff@linux.ibm.com>
    drm/ast: Fix connector leak during driver unload

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    ethernet: fman: fix wrong of_node_put() in probe function

Vladimir Murzin <vladimir.murzin@arm.com>
    ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Chris Cole <chris@sageembedded.com>
    ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Fix build break when CONFIG_INET is off

Anderson Luiz Alves <alacn1@gmail.com>
    mv88e6060: disable hardware level MAC learning

Juha-Matti Tilli <juha-matti.tilli@iki.fi>
    libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix keyboard debounce configuration

Teika Kazura <teika@gmx.com>
    Input: synaptics - enable SMBus for HP 15-ay000

Dan Carpenter <dan.carpenter@oracle.com>
    clk: mmp: Off by one in mmp_clk_add()

Dan Carpenter <dan.carpenter@oracle.com>
    clk: mvebu: Off by one bugs in cp110_of_clk_get()

Wen Yang <wen.yang99@zte.com.cn>
    drm/msm: Fix error return checking

Yangtao Li <tiny.windzz@gmail.com>
    ide: pmac: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/tty: add missing of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/sbus/char: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    sbus: char: add of_node_put()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a potential race in xprt_connect()

Dave Kleikamp <dave.kleikamp@oracle.com>
    nfs: don't dirty kernel pages read by direct-io

David Miller <davem@davemloft.net>
    bpf: Fix verifier log string check for bad alignment.

Toni Peltonen <peltzi@peltzi.fi>
    bonding: fix 802.3ad state sent to partner when unbinding slave

Jose Abreu <joabreu@synopsys.com>
    ARC: io.h: Implement reads{x}()/writes{x}()

Sean Paul <seanpaul@chromium.org>
    drm/msm: Grab a vblank reference when waiting for commit_done

YiFei Zhu <zhuyifei1999@gmail.com>
    x86/earlyprintk/efi: Fix infinite loop on some screen widths

Cathy Avery <cavery@redhat.com>
    scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload

Fred Herard <fred.herard@oracle.com>
    scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Vitaly Kuznetsov <vkuznets@redhat.com>
    Input: hyper-v - fix wakeup from suspend-to-idle

Alexey Khoroshilov <khoroshilov@ispras.ru>
    mac80211_hwsim: fix module init error paths for netlink

Steven Rostedt (VMware) <rostedt@goodmis.org>
    locking/qspinlock: Fix build for anonymous union in older GCC compilers

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Remove race conditions in user_sdma send path

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix condition validating WMM IE

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't WARN on bad WMM parameters from buggy APs

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Fix wraparound in hash:*net* types

Jens Axboe <axboe@kernel.dk>
    elevator: lookup mq vs non-mq elevators

Peter Zijlstra <peterz@infradead.org>
    locking/qspinlock, x86: Provide liveness guarantee

Will Deacon <will.deacon@arm.com>
    locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound

Peter Zijlstra <peterz@infradead.org>
    locking/qspinlock: Re-order code

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Kill cmpxchg() loop when claiming lock from head of queue

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Remove duplicate clear_pending() function from PV code

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Remove unbounded cmpxchg() loop from locking slowpath

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Bound spinning on pending->locked transition in slowpath

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Ensure node is initialised before updating prev->next

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    locking: Remove smp_read_barrier_depends() from queued_spin_lock_slowpath()

Masahiro Yamada <yamada.masahiro@socionext.com>
    x86/build: Fix compiler support check for CONFIG_RETPOLINE

Junwei Zhang <Jerry.Zhang@amd.com>
    drm/amdgpu: update SMC firmware image for polaris10 variants

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/execlists: Apply a full mb before execution for Braswell

Brian Norris <briannorris@chromium.org>
    Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Lyude Paul <lyude@redhat.com>
    drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Radu Rendec <radu.rendec@gmail.com>
    powerpc/msi: Fix NULL pointer access in teardown code

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak of instance function hash filters

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak in set_trigger_filter()

Mike Snitzer <snitzer@redhat.com>
    dm cache metadata: verify cache has blocks in blocks_are_clean_separate_dirty()

Mike Snitzer <snitzer@redhat.com>
    dm thin: send event about thin-pool state change _after_ making it

Lubomir Rintel <lkundrak@v3.sk>
    ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Chad Austin <chadaustin@fb.com>
    fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Alek Du <alek.du@intel.com>
    mmc: sdhci: fix the timeout check window for clock and reset

Aaro Koskinen <aaro.koskinen@iki.fi>
    MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Robin Murphy <robin.murphy@arm.com>
    arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered

Jeff Moyer <jmoyer@redhat.com>
    aio: fix spectre gadget in lookup_ioctx

Chen-Yu Tsai <wens@csie.org>
    pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Ingo Molnar <mingo@kernel.org>
    timer/debug: Change /proc/timer_list from 0444 to 0400


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/io.h                          |  72 ++++++++
 arch/arm/mach-mmp/cputype.h                        |   6 +-
 arch/arm/mm/cache-v7.S                             |   8 +-
 arch/arm/mm/cache-v7m.S                            |  14 +-
 arch/arm/net/bpf_jit_32.c                          |   2 +-
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 arch/powerpc/kernel/msi.c                          |   7 +-
 arch/x86/Makefile                                  |  10 +-
 arch/x86/include/asm/qspinlock.h                   |  25 ++-
 arch/x86/include/asm/qspinlock_paravirt.h          |   3 +-
 arch/x86/platform/efi/early_printk.c               |   2 +-
 block/elevator.c                                   |  44 +++--
 drivers/ata/libata-core.c                          |   1 +
 drivers/clk/mmp/clk.c                              |   2 +-
 drivers/clk/mvebu/cp110-system-controller.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   3 +-
 drivers/gpu/drm/ast/ast_fb.c                       |   1 +
 drivers/gpu/drm/i915/intel_lrc.c                   |   7 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   5 +
 drivers/gpu/drm/msm/msm_iommu.c                    |   2 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   6 -
 drivers/hid/hid-hyperv.c                           |   2 +-
 drivers/i2c/busses/i2c-axxia.c                     |  40 +++--
 drivers/i2c/busses/i2c-scmi.c                      |  10 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  19 +-
 drivers/i2c/busses/i2c-uniphier.c                  |   8 +-
 drivers/ide/pmac.c                                 |   1 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |  24 ++-
 drivers/infiniband/hw/hfi1/user_sdma.h             |   9 +-
 drivers/input/keyboard/omap4-keypad.c              |  18 +-
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/hyperv-keyboard.c              |   2 +-
 drivers/md/dm-cache-metadata.c                     |   4 +
 drivers/md/dm-thin.c                               |  68 +++----
 drivers/mmc/host/omap.c                            |  11 +-
 drivers/mmc/host/sdhci.c                           |  18 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +
 drivers/net/dsa/mv88e6060.c                        |  10 +-
 drivers/net/ethernet/freescale/fman/fman.c         |   5 +-
 drivers/net/ethernet/mellanox/mlx4/Kconfig         |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  10 +-
 drivers/net/wireless/mac80211_hwsim.c              |  12 +-
 drivers/nvme/target/rdma.c                         |   3 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c         |   2 +-
 drivers/rtc/rtc-snvs.c                             | 105 +++++++----
 drivers/sbus/char/display7seg.c                    |   1 +
 drivers/sbus/char/envctrl.c                        |   2 +
 drivers/scsi/libiscsi.c                            |   4 +-
 drivers/scsi/vmw_pvscsi.c                          |   4 +-
 drivers/tty/serial/suncore.c                       |   1 +
 drivers/vhost/vsock.c                              |  22 ++-
 fs/aio.c                                           |   2 +
 fs/cifs/Kconfig                                    |   2 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/file.c                                     |  21 +--
 fs/fuse/fuse_i.h                                   |   2 +-
 fs/nfs/direct.c                                    |   9 +-
 fs/userfaultfd.c                                   |   3 +-
 include/asm-generic/qspinlock_types.h              |  32 +++-
 kernel/locking/qspinlock.c                         | 195 ++++++++++-----------
 kernel/locking/qspinlock_paravirt.h                |  42 ++---
 kernel/time/timer_list.c                           |   2 +-
 kernel/trace/ftrace.c                              |   1 +
 kernel/trace/trace_events_trigger.c                |   6 +-
 net/mac80211/mlme.c                                |   3 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |  26 +--
 net/netfilter/ipset/ip_set_hash_net.c              |   9 +-
 net/netfilter/ipset/ip_set_hash_netiface.c         |   9 +-
 net/netfilter/ipset/ip_set_hash_netnet.c           |  28 +--
 net/netfilter/ipset/ip_set_hash_netport.c          |  19 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |  35 ++--
 net/sunrpc/xprt.c                                  |  11 +-
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 75 files changed, 692 insertions(+), 421 deletions(-)


