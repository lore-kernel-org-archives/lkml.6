Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E788521104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789519;
	bh=09PPZgYMTvVMbzIbKLyOqpe7bqTQETrDDdHdK8Jk+Ec=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mevf8b3hlwlIz0/tpMVCh1p+pYMtGMIB4xSg8B1q/0CDLFDv3cuIGUMMF2S3Dgls6
	 IYtnq3pOUi1kWArAPCME3JyESEtKQADBXdQsMKm0ZQovqK5RlbDQyyiNENZMvb745W
	 BrSvkEB7hd0wiDFjO8q51pg9emmBbUSbqu5cjxWY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E788521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeLNML5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730665AbeLNMLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F12120892;
        Fri, 14 Dec 2018 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789513;
        bh=09PPZgYMTvVMbzIbKLyOqpe7bqTQETrDDdHdK8Jk+Ec=;
        h=From:To:Cc:Subject:Date:From;
        b=cc5FOSYeHQ0/PQckspjQAZ8J3XA20JLArpqayKUIkz9iUz2gfbcWOAOyVbelwKvJ6
         l1JKv0QFLXKGgw2BXlFH9BUbHpdf0vpa4MNZhqVdq9ivjMnutq49/Rf4HlrDOvKZRa
         qDQ3LW1qkB6TAWkxxx1DKFa/9GpHORRAUxGHvMww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/51] 4.9.146-stable review
Date:   Fri, 14 Dec 2018 13:00:02 +0100
Message-Id: <20181214115713.244259772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.146-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.146-rc1
X-KernelTest-Deadline: 2018-12-16T11:57+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.146 release.
There are 51 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Dec 16 11:56:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.146-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.146-rc1

Guenter Roeck <linux@roeck-us.net>
    staging: speakup: Replace strncpy with memcpy

Namhyung Kim <namhyung@kernel.org>
    pstore: Convert console write to use ->write_buf

Pan Bian <bianpan2016@163.com>
    ocfs2: fix potential use after free

Qian Cai <cai@gmx.us>
    debugobjects: avoid recursive calls with kmemleak

Pan Bian <bianpan2016@163.com>
    hfsplus: do not free node before using

Pan Bian <bianpan2016@163.com>
    hfs: do not free node before using

Larry Chen <lchen@suse.com>
    ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Colin Ian King <colin.king@canonical.com>
    fscache, cachefiles: remove redundant variable 'cache'

NeilBrown <neilb@suse.com>
    fscache: fix race between enablement and dropping of object

Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
    xen: xlate_mmu: add missing header to fix 'W=1' warning

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed reading monitor EDID not stable issue

Pan Bian <bianpan2016@163.com>
    net: hisilicon: remove unexpected free_netdev

Josh Elsasser <jelsasser@appneta.com>
    ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Yunjian Wang <wangyunjian@huawei.com>
    igb: fix uninitialized variables

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: fix NULL pointer dereference in nic_remove

Yi Wang <wang.yi59@zte.com.cn>
    x86/kvm/vmx: fix old-style function declaration

Yi Wang <wang.yi59@zte.com.cn>
    KVM: x86: fix empty-body warnings

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

Majd Dibbiny <majd@mellanox.com>
    RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Robbie Ko <robbieko@synology.com>
    Btrfs: send, fix infinite loop due to directory rename dependencies

Artem Savkov <asavkov@redhat.com>
    objtool: Fix segfault in .cold detection with -ffunction-sections

Artem Savkov <asavkov@redhat.com>
    objtool: Fix double-free in .cold detection error path

Huacai Chen <chenhc@lemote.com>
    hwmon: (w83795) temp4_type has writable permission

Tzung-Bi Shih <tzungbi@google.com>
    ASoC: dapm: Recalculate audio map forcely when card instantiated

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred probing

Nicolin Chen <nicoleotsuka@gmail.com>
    hwmon: (ina2xx) Fix current value calculation

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_cf: Reject request for sampling in event initialization

Florian Westphal <fw@strlen.de>
    selftests: add script to stress-test nft packet path vs. control plane

YueHaibing <yuehaibing@huawei.com>
    sysv: return 'err' instead of 0 in __sysv_write_inode

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Stefano Brivio <sbrivio@redhat.com>
    neighbour: Avoid writing before skb->head in neigh_hh_output()

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    tun: forbid iface creation with rtnl ops

Yuchung Cheng <ycheng@google.com>
    tcp: fix NULL ref in tail loss probe

Eric Dumazet <edumazet@google.com>
    rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices

Christoph Paasch <cpaasch@apple.com>
    net: Prevent invalid access to skb->prev in __qdisc_drop_all

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: don't allow __set_phy_supported to add unsupported modes

Tarick Bedeir <tarick@google.com>
    net/mlx4_core: Correctly set PFC param if global pause is turned off.

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Stefano Brivio <sbrivio@redhat.com>
    ipv6: Check available headroom in ip6_xmit() even without options

Jiri Wiesner <jwiesner@suse.com>
    ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |  3 +
 arch/arm/mach-omap2/prm44xx.c                      |  2 +-
 arch/s390/kernel/perf_cpum_cf.c                    |  2 +
 arch/x86/kvm/lapic.c                               |  2 +-
 arch/x86/kvm/vmx.c                                 |  8 +-
 drivers/gpu/drm/ast/ast_mode.c                     | 36 +++++++--
 drivers/hwmon/ina2xx.c                             |  2 +-
 drivers/hwmon/w83795.c                             |  2 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 19 ++---
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  3 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  4 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c        |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |  4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  4 +-
 drivers/net/ethernet/realtek/8139cp.c              |  5 ++
 drivers/net/phy/phy_device.c                       | 19 ++---
 drivers/net/tun.c                                  |  6 +-
 drivers/staging/speakup/kobjects.c                 |  4 +-
 drivers/usb/gadget/udc/omap_udc.c                  | 87 ++++++++--------------
 drivers/xen/xlate_mmu.c                            |  1 +
 fs/btrfs/send.c                                    | 11 ++-
 fs/cachefiles/rdwr.c                               |  9 ++-
 fs/exportfs/expfs.c                                |  2 +-
 fs/fscache/object.c                                |  3 +
 fs/hfs/btree.c                                     |  3 +-
 fs/hfsplus/btree.c                                 |  3 +-
 fs/ocfs2/export.c                                  |  2 +-
 fs/ocfs2/move_extents.c                            | 47 ++++++------
 fs/pstore/platform.c                               |  4 +-
 fs/sysv/inode.c                                    |  2 +-
 include/net/neighbour.h                            | 28 +++++--
 kernel/trace/bpf_trace.c                           |  8 +-
 lib/debugobjects.c                                 |  3 +-
 net/core/rtnetlink.c                               |  3 +
 net/ipv4/ip_fragment.c                             |  7 ++
 net/ipv4/tcp_output.c                              | 12 ++-
 net/ipv6/ip6_output.c                              | 42 +++++------
 net/ipv6/netfilter/nf_conntrack_reasm.c            |  8 +-
 net/ipv6/reassembly.c                              |  8 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  3 +
 net/sched/sch_netem.c                              |  3 +
 sound/soc/omap/omap-abe-twl6040.c                  | 67 ++++++++---------
 sound/soc/omap/omap-dmic.c                         |  9 +++
 sound/soc/omap/omap-mcpdm.c                        | 43 ++++++++++-
 sound/soc/soc-core.c                               |  1 +
 tools/objtool/elf.c                                | 19 ++++-
 tools/testing/selftests/Makefile                   |  1 +
 tools/testing/selftests/netfilter/Makefile         |  6 ++
 tools/testing/selftests/netfilter/config           |  2 +
 .../selftests/netfilter/nft_trans_stress.sh        | 78 +++++++++++++++++++
 52 files changed, 439 insertions(+), 218 deletions(-)


