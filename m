Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CFC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790853;
	bh=uCsvolYYEKMkhdYhhSdGsgN+aPk06av8JGCRb4Zprb8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sQxko3CNxdW36rHt6Y6co453eo+d7iZExeYns+P4nxy2qDXMKNWAUTfsly4lgqkhc
	 B9xKpnreGHOAxPmXefnXlvG9XaJJsPJ4VVLZGJWfzzcGmUTIneh0/1CCX+YVrumaTZ
	 3Gkvwerp5WrvCk2jI7SQ34W8bXY2CretYbLftdrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB3B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeLNMIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbeLNMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6EB214AE;
        Fri, 14 Dec 2018 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789283;
        bh=uCsvolYYEKMkhdYhhSdGsgN+aPk06av8JGCRb4Zprb8=;
        h=From:To:Cc:Subject:Date:From;
        b=ybZV/h9GemGE4i6zhPCpQHHUcymWoOima9vgHbSjDLGrAdKy6a/TVd52cZDp7QAWn
         dxoe+5E7SrJ+cqvLvnkFNsY0l8xmARaeu4gYgxt2vw8nkGYFmyED8DC2oWHHO2bCF3
         y3mBeqSOImSYCMEcWoWTC5dB87WyDLcEXvLZEjx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/89] 4.14.89-stable review
Date:   Fri, 14 Dec 2018 12:59:13 +0100
Message-Id: <20181214115729.658859279@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.89-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.89-rc1
X-KernelTest-Deadline: 2018-12-16T11:57+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.89 release.
There are 89 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Dec 16 11:57:01 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.89-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.89-rc1

Piotr Stankiewicz <piotr.stankiewicz@intel.com>
    IB/hfi1: Fix an out-of-bounds access in get_hw_stats

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed headphone issue for ALC700

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: fireface: fix reference to wrong register for clock configuration

Guenter Roeck <linux@roeck-us.net>
    staging: speakup: Replace strncpy with memcpy

Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
    flexfiles: enforce per-mirror stateid only for v4 DSes

Davidlohr Bueso <dave@stgolabs.net>
    lib/rbtree-test: lower default params

Petr Mladek <pmladek@suse.com>
    printk: Wake klogd when passing console_lock owner

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    printk: Never set console_may_schedule in console_trylock()

Petr Mladek <pmladek@suse.com>
    printk: Hide console waiter logic into helpers

Steven Rostedt (VMware) <rostedt@goodmis.org>
    printk: Add console owner and waiter logic to load balance console writes

Sasha Levin <sashal@kernel.org>
    Revert "printk: Never set console_may_schedule in console_trylock()"

Pan Bian <bianpan2016@163.com>
    ocfs2: fix potential use after free

Qian Cai <cai@gmx.us>
    debugobjects: avoid recursive calls with kmemleak

Pan Bian <bianpan2016@163.com>
    hfsplus: do not free node before using

Pan Bian <bianpan2016@163.com>
    hfs: do not free node before using

Wei Yang <richard.weiyang@gmail.com>
    mm/page_alloc.c: fix calculation of pgdat->nr_zones

Larry Chen <lchen@suse.com>
    ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value

Sagi Grimberg <sagi@grimberg.me>
    nvme: flush namespace scanning work just before removing namespaces

Colin Ian King <colin.king@canonical.com>
    fscache, cachefiles: remove redundant variable 'cache'

NeilBrown <neilb@suse.com>
    fscache: fix race between enablement and dropping of object

Kees Cook <keescook@chromium.org>
    pstore/ram: Correctly calculate usable PRZ bytes

Igor Druzhinin <igor.druzhinin@citrix.com>
    Revert "xen/balloon: Mark unallocated host memory as UNUSABLE"

Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
    xen: xlate_mmu: add missing header to fix 'W=1' warning

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed reading monitor EDID not stable issue

shaoyunl <shaoyun.liu@amd.com>
    drm/amdgpu: Add delay after enable RLC ucode

Pan Bian <bianpan2016@163.com>
    net: hisilicon: remove unexpected free_netdev

Josh Elsasser <jelsasser@appneta.com>
    ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Yunjian Wang <wangyunjian@huawei.com>
    igb: fix uninitialized variables

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: deactivate expressions in rule replecement routine

Marek Szyprowski <m.szyprowski@samsung.com>
    usb: gadget: u_ether: fix unsafe list iteration

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: fix NULL pointer dereference in nic_remove

Yi Wang <wang.yi59@zte.com.cn>
    x86/kvm/vmx: fix old-style function declaration

Yi Wang <wang.yi59@zte.com.cn>
    KVM: x86: fix empty-body warnings

Artemy Kovalyov <artemyko@mellanox.com>
    IB/mlx5: Fix page fault handling for MW

Alin Nastac <alin.nastac@gmail.com>
    netfilter: ipv6: Preserve link scope traffic original oif

Christian Hewitt <christianshewitt@gmail.com>
    drm/meson: add support for 1080p25 mode

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix rejection of out transfers when DMA is used

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix USB gadget functionality on Palm Tungsten E

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix omap_udc_start() on 15xx machines

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix crashes on probe error and module removal

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: use devm_request_irq()

Xin Long <lucien.xin@gmail.com>
    ipvs: call ip_vs_dst_notifier earlier than ipv6_dev_notf

Martynas Pumputis <m@lambda.lt>
    bpf: fix check of allowed specifiers in bpf_trace_printk

Pan Bian <bianpan2016@163.com>
    exportfs: do not read dentry after free

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CPU_IDLE

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-mcbsp: Fix latency value calculation for pm_qos

Kamal Heib <kamalheib1@gmail.com>
    RDMA/rdmavt: Fix rvt_create_ah function signature

Majd Dibbiny <majd@mellanox.com>
    RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Robbie Ko <robbieko@synology.com>
    Btrfs: send, fix infinite loop due to directory rename dependencies

Romain Izard <romain.izard.pro@gmail.com>
    ARM: dts: at91: sama5d2: use the divided clock for SMC

Artem Savkov <asavkov@redhat.com>
    objtool: Fix segfault in .cold detection with -ffunction-sections

Artem Savkov <asavkov@redhat.com>
    objtool: Fix double-free in .cold detection error path

Trent Piepho <tpiepho@impinj.com>
    PCI: imx6: Fix link training status detection in link up check

Jiri Olsa <jolsa@kernel.org>
    perf tools: Restore proper cwd on return from mnt namespace

Huacai Chen <chenhc@lemote.com>
    hwmon: (w83795) temp4_type has writable permission

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_hashlimit: fix a possible memory leak in htable_create()

Hans de Goede <hdegoede@redhat.com>
    iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers

Tzung-Bi Shih <tzungbi@google.com>
    ASoC: dapm: Recalculate audio map forcely when card instantiated

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred probing

Nicolin Chen <nicoleotsuka@gmail.com>
    hwmon: (ina2xx) Fix current value calculation

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_cf: Reject request for sampling in event initialization

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

Nicolin Chen <nicoleotsuka@gmail.com>
    hwmon (ina2xx) Fix NULL id pointer in probe()

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix use-after-free when deleting compat expressions

Florian Westphal <fw@strlen.de>
    selftests: add script to stress-test nft packet path vs. control plane

YueHaibing <yuehaibing@huawei.com>
    sysv: return 'err' instead of 0 in __sysv_write_inode

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_read32()'

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: fixup clock start checker

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Jason Wang <jasowang@redhat.com>
    virtio-net: keep vnet header zeroed after processing XDP

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    tun: forbid iface creation with rtnl ops

Yuchung Cheng <ycheng@google.com>
    tcp: fix NULL ref in tail loss probe

Eric Dumazet <edumazet@google.com>
    tcp: Do not underestimate rwnd_limited

Xin Long <lucien.xin@gmail.com>
    sctp: kfree_rcu asoc

Eric Dumazet <edumazet@google.com>
    rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices

Christoph Paasch <cpaasch@apple.com>
    net: Prevent invalid access to skb->prev in __qdisc_drop_all

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: don't allow __set_phy_supported to add unsupported modes

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx4_en: Change min MTU size to ETH_MIN_MTU

Tarick Bedeir <tarick@google.com>
    net/mlx4_core: Correctly set PFC param if global pause is turned off.

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Shmulik Ladkani <shmulik@metanetworks.com>
    ipv6: sr: properly initialize flowi6 prior passing to ip6_route_output

Stefano Brivio <sbrivio@redhat.com>
    neighbour: Avoid writing before skb->head in neigh_hh_output()

Stefano Brivio <sbrivio@redhat.com>
    ipv6: Check available headroom in ip6_xmit() even without options

Jiri Wiesner <jwiesner@suse.com>
    ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   3 +
 arch/arm/mach-omap2/prm44xx.c                      |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   2 +
 arch/x86/kvm/lapic.c                               |   2 +-
 arch/x86/kvm/vmx.c                                 |   8 +-
 arch/x86/xen/enlighten.c                           |  78 ----------
 arch/x86/xen/setup.c                               |   6 +-
 drivers/acpi/arm64/iort.c                          |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   7 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  36 ++++-
 drivers/gpu/drm/meson/meson_venc.c                 |   1 +
 drivers/hid/hid-sensor-custom.c                    |   2 +-
 drivers/hid/hid-sensor-hub.c                       |  13 +-
 drivers/hwmon/ina2xx.c                             |   6 +-
 drivers/hwmon/w83795.c                             |   2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   5 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   5 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |   3 +-
 drivers/iio/light/hid-sensor-als.c                 |   8 +-
 drivers/iio/light/hid-sensor-prox.c                |   8 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   8 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   8 +-
 drivers/iio/pressure/hid-sensor-press.c            |   8 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |   3 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   3 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   2 +
 drivers/infiniband/hw/hfi1/verbs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   1 +
 drivers/infiniband/hw/mlx5/qp.c                    |  19 +--
 drivers/infiniband/sw/rdmavt/ah.c                  |   4 +-
 drivers/infiniband/sw/rdmavt/ah.h                  |   3 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   3 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |   4 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c        |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   1 -
 drivers/net/ethernet/realtek/8139cp.c              |   5 +
 drivers/net/phy/phy_device.c                       |  19 ++-
 drivers/net/tun.c                                  |   6 +-
 drivers/net/virtio_net.c                           |  14 +-
 drivers/nvme/host/core.c                           |   4 +-
 drivers/pci/dwc/pci-imx6.c                         |  10 +-
 drivers/rtc/rtc-hid-sensor-time.c                  |   2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   2 +-
 drivers/staging/speakup/kobjects.c                 |   4 +-
 drivers/usb/gadget/function/u_ether.c              |  11 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  88 ++++--------
 drivers/xen/balloon.c                              |  65 ++-------
 drivers/xen/xlate_mmu.c                            |   1 +
 fs/btrfs/send.c                                    |  11 +-
 fs/cachefiles/rdwr.c                               |   9 +-
 fs/exportfs/expfs.c                                |   2 +-
 fs/fscache/object.c                                |   3 +
 fs/hfs/btree.c                                     |   3 +-
 fs/hfsplus/btree.c                                 |   3 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |   6 +-
 fs/ocfs2/export.c                                  |   2 +-
 fs/ocfs2/move_extents.c                            |  47 +++---
 fs/pstore/ram.c                                    |  15 +-
 fs/sysv/inode.c                                    |   2 +-
 include/linux/hid-sensor-hub.h                     |   4 +-
 include/linux/pstore.h                             |   5 +-
 include/net/neighbour.h                            |  28 +++-
 include/net/sctp/structs.h                         |   2 +
 include/xen/balloon.h                              |   5 -
 kernel/printk/printk.c                             | 160 ++++++++++++++++++++-
 kernel/trace/bpf_trace.c                           |   8 +-
 lib/debugobjects.c                                 |   5 +-
 lib/interval_tree_test.c                           |   4 +-
 lib/rbtree_test.c                                  |   2 +-
 mm/page_alloc.c                                    |   4 +-
 net/core/rtnetlink.c                               |   3 +
 net/ipv4/ip_fragment.c                             |   7 +
 net/ipv4/tcp_output.c                              |  17 ++-
 net/ipv6/ip6_output.c                              |  42 +++---
 net/ipv6/netfilter.c                               |   3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   8 +-
 net/ipv6/reassembly.c                              |   8 +-
 net/ipv6/seg6_iptunnel.c                           |   1 +
 net/netfilter/ipvs/ip_vs_ctl.c                     |   3 +
 net/netfilter/nf_tables_api.c                      |  20 +--
 net/netfilter/nft_compat.c                         |   3 +-
 net/netfilter/xt_hashlimit.c                       |   9 +-
 net/sched/sch_netem.c                              |   3 +
 net/sctp/associola.c                               |   2 +-
 sound/firewire/fireface/ff-protocol-ff400.c        |   2 +-
 sound/pci/hda/patch_realtek.c                      |  33 +++++
 sound/soc/codecs/wm_adsp.c                         |  37 ++---
 sound/soc/omap/omap-abe-twl6040.c                  |  67 ++++-----
 sound/soc/omap/omap-dmic.c                         |   9 ++
 sound/soc/omap/omap-mcbsp.c                        |   6 +-
 sound/soc/omap/omap-mcpdm.c                        |  43 +++++-
 sound/soc/sh/rcar/ssi.c                            |   2 +-
 sound/soc/soc-core.c                               |   1 +
 tools/objtool/elf.c                                |  19 ++-
 tools/perf/util/namespaces.c                       |  17 ++-
 tools/perf/util/namespaces.h                       |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/netfilter/Makefile         |   6 +
 tools/testing/selftests/netfilter/config           |   2 +
 .../selftests/netfilter/nft_trans_stress.sh        |  78 ++++++++++
 106 files changed, 820 insertions(+), 483 deletions(-)


