Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEECC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE2206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217999;
	bh=PTXY6K/ZrKAWneBIv2i44qYKPv6LuwpDYsoW+o5hA7k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yK8vzXXjQ0BLjoJ60uKUdaPCdMmBbEYdA4RgTw8/QNGqMN1iIbx6RtEL+3HUOGXV8
	 IEZ96NPxG0p3O6nPJfiMMtE/L2HeO3VzS9GuNBYYd/jzHwoDMMXmynpvRabGWf2w77
	 v+HgATWuvQsB93Hy5wIVpRfqYP1NxCsS12hQinCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbfAKOnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404289AbfAKOnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B065421841;
        Fri, 11 Jan 2019 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217781;
        bh=PTXY6K/ZrKAWneBIv2i44qYKPv6LuwpDYsoW+o5hA7k=;
        h=From:To:Cc:Subject:Date:From;
        b=jxKAUh325oEgqBFu/gOXcJsIF4ivN1FdVBdRdR7RYfJXChXT0RWv8hG5DOeW4dzXx
         7ZKgmNYN5ltX/5sfnFsvt/tYFOfzpCui0Q8VAZ9gLIqaRVcAqTQ/Q9DmE8TACxs0dN
         Yj9buxmlpsgVPWuBQpJUjbLn4RJ7A5ITqMITiVvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/65] 4.20.2-stable review
Date:   Fri, 11 Jan 2019 15:14:46 +0100
Message-Id: <20190111131055.331350141@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.2-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.2-rc1
X-KernelTest-Deadline: 2019-01-13T13:11+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.2 release.
There are 65 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:10:14 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.2-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.2-rc1

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    drm/rockchip: psr: do not dereference encoder before it is null checked.

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Set ->is_yuv to false when num_planes == 1

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Check rc from drm_dp_mst_topology_mgr_resume()

Christophe Leroy <christophe.leroy@c-s.fr>
    lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Frank Rowand <frank.rowand@sony.com>
    of: __of_detach_node() - remove node from phandle cache

Frank Rowand <frank.rowand@sony.com>
    of: of_node_get()/of_node_put() nodes held in phandle cache

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: msu: Fix an off-by-one in attribute store

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Shuah Khan <shuah@kernel.org>
    selftests: Fix test errors related to lib.mk khdr target

Christian Lamparter <chunkeey@gmail.com>
    powerpc/4xx/ocm: Fix compilation error due to PAGE_KERNEL usage

Shaokun Zhang <zhangshaokun@hisilicon.com>
    drivers/perf: hisi: Fixup one DDRC PMU register offset

YueHaibing <yuehaibing@huawei.com>
    video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Linus Torvalds <torvalds@linux-foundation.org>
    sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

Sohil Mehta <sohil.mehta@intel.com>
    iommu/vt-d: Handle domain agaw being less than iommu agaw

Steve Wise <swise@opengridcomputing.com>
    RDMA/iwcm: Don't copy past the end of dev_name() string

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Fix a use-after-free in the channel release code

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Fix a module refcount leak in policy creation error path

Sagi Grimberg <sagi@grimberg.me>
    rxe: fix error completion wr_id and qp_num

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Mircea Caprioru <mircea.caprioru@analog.com>
    iio: dac: ad5686: fix bit shift read register

Evan Green <evgreen@chromium.org>
    iio: adc: qcom-spmi-adc5: Initialize prescale properly

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"

J. Bruce Fields <bfields@redhat.com>
    nfsd4: zero-length WRITE should succeed

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Yet another double DMA-unmap

Benjamin Coddington <bcodding@redhat.com>
    lockd: Show pid of lockd for remote locks

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    PCI / PM: Allow runtime PM without callback functions

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: policydb - fix byte order and alignment issues

Larry Finger <Larry.Finger@lwfinger.net>
    b43: Fix error in cordic routine

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix loop in gfs2_rbm_find

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Get rid of potential double-freeing in gfs2_create_inode

Vasily Averin <vvs@virtuozzo.com>
    dlm: memory leaks on error path in dlm_user_request()

Vasily Averin <vvs@virtuozzo.com>
    dlm: lost put_lkb on error path in receive_convert() and receive_unlock()

Vasily Averin <vvs@virtuozzo.com>
    dlm: possible memory leak on error path in create_lkb()

Vasily Averin <vvs@virtuozzo.com>
    dlm: fixed memory leaks after failed ls_remove_names allocation

Jaegeuk Kim <jaegeuk@kernel.org>
    dm: do not allow readahead to limit IO size

Damien Le Moal <damien.lemoal@wdc.com>
    block: mq-deadline: Fix write completion handling

Ming Lei <ming.lei@redhat.com>
    block: deactivate blk_stat timer in wbt_disable_default()

Matthew Wilcox <willy@infradead.org>
    Fix failure path in alloc_pid()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    driver core: Add missing dev->bus->need_parent_lock checks

Dennis Krein <Dennis.Krein@netapp.com>
    srcu: Lock srcu_data structure in srcu_gp_start()

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Always check descriptor sizes in parser code

Hui Peng <benquike@163.com>
    ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Check mixer unit descriptors more strictly

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: cs46xx: Potential NULL dereference in probe

Brad Love <brad@nextdimension.cc>
    media: cx23885: only reset DMA on problematic CPUs

Huang Ying <ying.huang@intel.com>
    mm, swap: fix swapoff with KSM pages

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: replace hmm_devmem_pages_create() with devm_memremap_pages()

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: use devm semantics for hmm_devmem_{add, remove}

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

Michal Hocko <mhocko@suse.com>
    memcg, oom: notify on oom killer invocation from the charge path

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: fix shutdown handling

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: kill mapping "System RAM" support

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL

Michal Hocko <mhocko@suse.com>
    hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Minchan Kim <minchan@kernel.org>
    zram: fix double free backing device

David Herrmann <dh.herrmann@gmail.com>
    fork: record start_time late

Ewan D. Milne <emilne@redhat.com>
    scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcnt is invalid

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/powerpc/kernel/signal_32.c                    |  38 ++-
 arch/powerpc/kernel/signal_64.c                    |  64 +++--
 arch/powerpc/platforms/4xx/ocm.c                   |   4 +-
 block/blk-mq-sched.c                               |   3 +-
 block/blk-mq-sched.h                               |   1 +
 block/blk-stat.h                                   |   5 +
 block/blk-wbt.c                                    |   4 +-
 block/mq-deadline.c                                |  12 +-
 drivers/base/dd.c                                  |   4 +-
 drivers/block/zram/zram_drv.c                      |   4 +-
 drivers/dax/pmem.c                                 |  14 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  12 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |   4 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   1 +
 drivers/hwtracing/intel_th/msu.c                   |   3 +-
 drivers/hwtracing/stm/policy.c                     |  12 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |  58 ++--
 drivers/iio/dac/ad5686.c                           |   3 +-
 drivers/infiniband/core/iwcm.c                     |  12 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  13 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  18 +-
 drivers/iommu/intel-iommu.c                        |   4 +-
 drivers/md/dm-table.c                              |   3 +
 drivers/media/pci/cx23885/cx23885-core.c           |  55 +++-
 drivers/media/pci/cx23885/cx23885.h                |   2 +
 drivers/misc/genwqe/card_utils.c                   |   2 +-
 drivers/net/wireless/broadcom/b43/phy_common.c     |   2 +-
 drivers/nvdimm/pmem.c                              |  13 +-
 drivers/of/base.c                                  | 101 +++++--
 drivers/of/dynamic.c                               |   3 +
 drivers/of/of_private.h                            |   4 +
 drivers/pci/p2pdma.c                               |  10 +-
 drivers/pci/pci-driver.c                           |  27 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   4 +-
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/s390/scsi/zfcp_aux.c                       |   6 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   3 +-
 drivers/video/fbdev/pxafb.c                        |   4 +-
 fs/ceph/caps.c                                     |   1 -
 fs/dlm/lock.c                                      |  17 +-
 fs/dlm/lockspace.c                                 |   2 +-
 fs/gfs2/inode.c                                    |  18 +-
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/lockd/clntproc.c                                |   2 +-
 fs/lockd/xdr.c                                     |   4 +-
 fs/lockd/xdr4.c                                    |   4 +-
 fs/nfsd/nfs4proc.c                                 |   2 -
 include/linux/hmm.h                                |   4 +-
 include/linux/memremap.h                           |   2 +
 kernel/fork.c                                      |  13 +-
 kernel/memremap.c                                  |  94 ++++---
 kernel/pid.c                                       |   6 +-
 kernel/rcu/srcutree.c                              |   2 +
 kernel/sched/fair.c                                |  43 +--
 lib/test_debug_virtual.c                           |   1 +
 mm/hmm.c                                           | 305 +++------------------
 mm/memcontrol.c                                    |  20 +-
 mm/memory_hotplug.c                                |  16 ++
 mm/swapfile.c                                      |   3 +-
 net/9p/client.c                                    |  21 ++
 net/sunrpc/auth_gss/svcauth_gss.c                  |   8 +-
 net/sunrpc/cache.c                                 |  10 +-
 net/sunrpc/xprtrdma/frwr_ops.c                     |   6 +-
 net/sunrpc/xprtrdma/verbs.c                        |   9 +-
 security/selinux/ss/policydb.c                     |  51 +++-
 sound/pci/cs46xx/dsp_spos.c                        |   3 +
 sound/usb/card.c                                   |   2 +-
 sound/usb/mixer.c                                  |  29 +-
 sound/usb/quirks-table.h                           |   6 +
 sound/usb/stream.c                                 |  36 ++-
 tools/testing/nvdimm/test/iomap.c                  |  17 +-
 tools/testing/selftests/android/Makefile           |   2 +-
 tools/testing/selftests/futex/functional/Makefile  |   1 +
 tools/testing/selftests/gpio/Makefile              |   6 +-
 tools/testing/selftests/kvm/Makefile               |   2 +-
 tools/testing/selftests/lib.mk                     |   8 +-
 .../selftests/networking/timestamping/Makefile     |   1 +
 tools/testing/selftests/tc-testing/bpf/Makefile    |   1 +
 tools/testing/selftests/vm/Makefile                |   1 +
 80 files changed, 710 insertions(+), 611 deletions(-)


