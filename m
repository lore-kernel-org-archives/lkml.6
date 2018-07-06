Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E93A208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E93A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeGFFuO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGFFuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:10 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47CBFBC1;
        Fri,  6 Jul 2018 05:50:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/61] 4.14.54-stable review
Date:   Fri,  6 Jul 2018 07:46:24 +0200
Message-Id: <20180706054712.332416244@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.54-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.54-rc1
X-KernelTest-Deadline: 2018-07-08T05:47+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.54 release.
There are 61 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul  8 05:46:58 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.54-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.54-rc1

Damien Thébault <damien.thebault@vitec.com>
    net: dsa: b53: Add BCM5389 support

Finn Thain <fthain@telegraphics.com.au>
    net/sonic: Use dma_mapping_error()

João Paulo Rechi Vita <jprvita@endlessm.com>
    platform/x86: asus-wmi: Fix NULL pointer dereference

Paul Burton <paul.burton@mips.com>
    sched/core: Require cpu_active() in select_task_rq(), for user tasks

Peter Zijlstra <peterz@infradead.org>
    sched/core: Fix rules for running on online && !active CPUs

Darrick J. Wong <darrick.wong@oracle.com>
    fs: clear writeback errors in inode_init_always

YueHaibing <yuehaibing@huawei.com>
    perf bpf: Fix NULL return handling in bpf__prepare_load()

Thomas Richter <tmricht@linux.ibm.com>
    perf test: "Session topology" dumps core on s390

Josh Hill <josh@joshuajhill.com>
    net: qmi_wwan: Add Netgear Aircard 779S

Ivan Bornyakov <brnkv.i1@gmail.com>
    atm: zatm: fix memcmp casting

Hao Wei Tee <angelsl@in04.sg>
    iwlwifi: pcie: compare with number of IRQs requested for, not number of CPUs

Julian Anastasov <ja@ssi.bg>
    ipvs: fix buffer overflow with sync daemon and service

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_limit: fix packet ratelimiting

Sebastian Ott <sebott@linux.ibm.com>
    s390/dasd: use blk_mq_rq_from_pdu for per request data

Paolo Abeni <pabeni@redhat.com>
    netfilter: ebtables: handle string from userspace with care

David Howells <dhowells@redhat.com>
    afs: Fix directory permissions check

Eric Dumazet <edumazet@google.com>
    xfrm6: avoid potential infinite loop in _decode_session6()

Abhishek Sahu <absahu@codeaurora.org>
    mtd: rawnand: fix return value check for bad block status

Sean Nyekjaer <sean.nyekjaer@prevas.dk>
    ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_chain()

Vincent Bernat <vincent@bernat.im>
    netfilter: ip6t_rpfilter: provide input interface for route lookup

Florian Westphal <fw@strlen.de>
    netfilter: don't set F_IFACE on ipv6 fib lookups

NeilBrown <neilb@suse.com>
    md: remove special meaning of ->quiesce(.., 2)

NeilBrown <neilb@suse.com>
    md: allow metadata update while suspending.

NeilBrown <neilb@suse.com>
    md: use mddev_suspend/resume instead of ->quiesce()

NeilBrown <neilb@suse.com>
    md: move suspend_hi/lo handling into core md code

NeilBrown <neilb@suse.com>
    md: don't call bitmap_create() while array is quiesced.

NeilBrown <neilb@suse.com>
    md: always hold reconfig_mutex when calling mddev_suspend()

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix NULL-ptr in nf_tables_dump_obj()

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: add missing netlink attrs to policies

Colin Ian King <colin.king@canonical.com>
    netfilter: nf_tables: fix memory leak on error exit return

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: increase nft_counters_enabled in nft_chain_stats_replace()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disable preemption in nft_update_chain_stats()

Taehee Yoo <ap420073@gmail.com>
    netfilter: nft_meta: fix wrong value dereference in nft_meta_set_eval

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bogus EBUSY in chain deletions

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't assume chain stats are set when jumplabel is set

Florian Westphal <fw@strlen.de>
    netfilter: nft_compat: fix handling of large matchinfo size

Florian Westphal <fw@strlen.de>
    netfilter: nft_compat: prepare for indirect info storage

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: nft_compat: fix refcount leak on xt module

Kenneth Graunke <kenneth@whitecape.org>
    drm/i915: Enable provoking vertex fix on Gen9 systems.

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes array

Stefan Agner <stefan@agner.ch>
    drm/atmel-hlcdc: check stride values in the first plane

Jeremy Cline <jcline@redhat.com>
    drm/qxl: Call qxl_bo_unref outside atomic context

Huang Rui <ray.huang@amd.com>
    drm/amdgpu: fix the missed vcn fw version report

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Add APU support in vi_set_vce_clocks

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Add APU support in vi_set_uvd_clocks

Alexander Potapenko <glider@google.com>
    vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Johan Hovold <johan@kernel.org>
    serdev: fix memleak on module unload

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Remove stalled entries in blacklist

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Return an ERR_PTR in ion_map_kernel

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Access echo_* variables carefully.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Fix stall at n_tty_receive_char_special().

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: Fix kernel oops in trace_xhci_free_virt_device

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: Fix for incorrect status data issue

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: acpi: Workaround for cache mode issue

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    acpi: Add helper for deactivating memory region

William Wu <william.wu@rock-chips.com>
    usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

Karoly Pados <pados@pados.hu>
    USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add CESINEL device ids

Houston Yaroschoff <hstn@4ever3.net>
    usb: cdc_acm: Add quirk for Uniden UBC125 scanner


-------------

Diffstat:

 Documentation/devicetree/bindings/net/dsa/b53.txt |   1 +
 Makefile                                          |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                      |   2 +-
 drivers/acpi/osl.c                                |  72 ++++++++
 drivers/atm/zatm.c                                |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c      |  23 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                   |  77 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                   |   5 +
 drivers/gpu/drm/i915/intel_lrc.c                  |  12 +-
 drivers/gpu/drm/qxl/qxl_display.c                 |   7 +-
 drivers/md/dm-raid.c                              |  10 +-
 drivers/md/md-cluster.c                           |   6 +-
 drivers/md/md.c                                   |  90 ++++++----
 drivers/md/md.h                                   |  15 +-
 drivers/md/raid0.c                                |   2 +-
 drivers/md/raid1.c                                |  27 +--
 drivers/md/raid10.c                               |  10 +-
 drivers/md/raid5-cache.c                          |  30 ++--
 drivers/md/raid5-log.h                            |   2 +-
 drivers/md/raid5.c                                |  40 +----
 drivers/mtd/nand/nand_base.c                      |   2 +-
 drivers/net/dsa/b53/b53_common.c                  |  13 ++
 drivers/net/dsa/b53/b53_mdio.c                    |   5 +-
 drivers/net/dsa/b53/b53_priv.h                    |   1 +
 drivers/net/ethernet/natsemi/sonic.c              |   2 +-
 drivers/net/usb/qmi_wwan.c                        |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   |  10 +-
 drivers/platform/x86/asus-wmi.c                   |  23 +--
 drivers/s390/block/dasd.c                         |   7 +-
 drivers/staging/android/ion/ion_heap.c            |   2 +-
 drivers/tty/n_tty.c                               |  55 +++---
 drivers/tty/serdev/core.c                         |   1 +
 drivers/tty/serial/8250/8250_pci.c                |   2 -
 drivers/tty/vt/vt.c                               |   4 +-
 drivers/usb/class/cdc-acm.c                       |   3 +
 drivers/usb/dwc2/hcd_queue.c                      |   2 +-
 drivers/usb/host/xhci-mem.c                       |   4 +-
 drivers/usb/host/xhci-trace.h                     |  36 +++-
 drivers/usb/serial/cp210x.c                       |  14 ++
 drivers/usb/typec/ucsi/ucsi.c                     |  13 ++
 drivers/usb/typec/ucsi/ucsi_acpi.c                |   5 +
 fs/afs/security.c                                 |  10 +-
 fs/inode.c                                        |   1 +
 include/linux/acpi.h                              |   3 +
 include/net/netfilter/nf_tables.h                 |   5 +
 kernel/sched/core.c                               |  45 +++--
 net/bridge/netfilter/ebtables.c                   |   3 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                |   4 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                 |  12 +-
 net/ipv6/xfrm6_policy.c                           |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                    |  21 ++-
 net/netfilter/nf_tables_api.c                     |  61 ++++++-
 net/netfilter/nf_tables_core.c                    |  20 ++-
 net/netfilter/nft_compat.c                        | 201 +++++++++++++++++-----
 net/netfilter/nft_immediate.c                     |  15 +-
 net/netfilter/nft_limit.c                         |  38 ++--
 net/netfilter/nft_meta.c                          |  14 +-
 tools/perf/tests/topology.c                       |  30 +++-
 tools/perf/util/bpf-loader.c                      |   6 +-
 64 files changed, 809 insertions(+), 340 deletions(-)


