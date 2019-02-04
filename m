Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297BC2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277268;
	bh=GBzGOgjXy3AH/QHMD4Z8GB6GTYXGvv0M5TJT9oBA9sM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mKOS5EzF395cPgHbK2ZaF1vqOeuG8MY/v2S7mZGyl/NMfbAVPH9fMP9bPZ+rIrCkQ
	 UT0kQQfOHQKVUTGIjNzK4Ft2IVPuXwNJL75R6JVPQjuWj64X+tX/LRhmEA7E0yOZhJ
	 t4+NWWnb4ZqaIG6BzhHfX91kwP9pNPK1Skbl1wqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfBDKrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbfBDKri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822C12087C;
        Mon,  4 Feb 2019 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277257;
        bh=GBzGOgjXy3AH/QHMD4Z8GB6GTYXGvv0M5TJT9oBA9sM=;
        h=From:To:Cc:Subject:Date:From;
        b=wOKVzDUB1eVcEnmw1ClBKnSrSY2dGA8UKLq6NI6V2d4KbKS1b3Uk4BtLIUv7eNisY
         8K2oxwgplda9FHcVUv75Ud4yCZ4scL2VEob8FMzG7GlDgiBlm8Ih2xZXjiuLY5BQ/W
         nt+75P3HyiTJ+kC4wIiUfFnH13ac7+rXLotVUHV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/74] 4.19.20-stable review
Date:   Mon,  4 Feb 2019 11:36:13 +0100
Message-Id: <20190204103619.714714157@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.20-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.20-rc1
X-KernelTest-Deadline: 2019-02-06T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.20 release.
There are 74 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  6 10:35:34 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.20-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.20-rc1

Paulo Alcantara <paulo@paulo.ac>
    cifs: Always resolve hostname before reconnecting

Alexei Naberezhnov <anaberezhnov@fb.com>
    md/raid5: fix 'out of memory' during raid cache recovery

Frank Rowand <frank.rowand@sony.com>
    of: overlay: do not duplicate properties from overlay for new nodes

Frank Rowand <frank.rowand@sony.com>
    of: overlay: use prop add changeset entry for property in new nodes

Frank Rowand <frank.rowand@sony.com>
    of: overlay: add missing of_node_get() in __of_attach_node_sysfs

Frank Rowand <frank.rowand@sony.com>
    of: overlay: add tests to validate kfrees from overlay removal

Rob Herring <robh@kernel.org>
    of: Convert to using %pOFn instead of device_node.name

David Hildenbrand <david@redhat.com>
    mm: migrate: don't rely on __PageMovable() of newpage after unlocking it

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    mm: hwpoison: use do_send_sig_info() instead of force_sig()

Shakeel Butt <shakeelb@google.com>
    mm, oom: fix use-after-free in oom_kill_process

Oscar Salvador <osalvador@suse.de>
    mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    oom, oom_reaper: do not enqueue same task twice

Andrea Arcangeli <aarcange@redhat.com>
    mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT

Andrei Vagin <avagin@gmail.com>
    kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Eric W. Biederman <ebiederm@xmission.com>
    btrfs: On error always free subvol_name in btrfs_mount

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock when allocating tree block during leaf/node split

Stefan Wahren <stefan.wahren@i2se.com>
    mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Remove overly conservative VM_EXEC flag check

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed hp_pin no value

Olek Poplavsky <woodenbits@gmail.com>
    ALSA: usb-audio: Add Opus #3 to quirks for native DSD support

Chaotian Jing <chaotian.jing@mediatek.com>
    mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Lukas Wunner <lukas@wunner.de>
    mmc: bcm2835: Fix DMA channel leak on probe error

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Revert "Fix loop in gfs2_rbm_find"

Neo Hou <neo.hou@unisoc.com>
    gpio: sprd: Fix incorrect irq type setting for the async EIC

Neo Hou <neo.hou@unisoc.com>
    gpio: sprd: Fix the incorrect data register

Roger Quadros <rogerq@ti.com>
    gpio: pcf857x: Fix interrupts on multiple instances

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    gpiolib: fix line event timestamps for nested irqs

Axel Lin <axel.lin@ingics.com>
    gpio: altera-a10sr: Set proper output level for direction_output

James Morse <james.morse@arm.com>
    arm64: hibernate: Clean the __hyp_text to PoC after resume

James Morse <james.morse@arm.com>
    arm64: hyp-stub: Forbid kprobing of the hyp-stub

Catalin Marinas <catalin.marinas@arm.com>
    arm64: Do not issue IPIs for user executable ptes

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: kaslr: ensure randomized quantities are clean also when kaslr is off

Koen Vandeputte <koen.vandeputte@ncentric.com>
    ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment

Trond Myklebust <trondmy@gmail.com>
    NFS: Fix up return value on fatal errors in nfs_page_async_flush()

Kees Cook <keescook@chromium.org>
    selftests/seccomp: Enhance per-arch ptrace syscall skip tests

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Waiman Long <longman@redhat.com>
    fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not consider -ENODATA as stat failure for reads

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix trace command logging for SMB2 reads and writes

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not count -ENODATA as failure for query directory

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Differentiate sk_buff and xdp_frame on freeing

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Don't process redirected XDP frames when XDP is disabled

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Fix out of bounds access of sq

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Fix not restoring real_num_rx_queues

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Don't call free_old_xmit_skbs for xdp_frames

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Don't enable NAPI when interface is down

Xin Long <lucien.xin@gmail.com>
    sctp: set flow sport from saddr only when it's 0

Xin Long <lucien.xin@gmail.com>
    sctp: set chunk transport correctly when it's a new asoc

Bodong Wang <bodong@mellanox.com>
    Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager"

Nir Dotan <nird@mellanox.com>
    ip6mr: Fix notifiers call on mroute_clean_tables()

Aya Levin <ayal@mellanox.com>
    net/mlx5e: Allow MAC invalidation while spoofchk is ON

Xin Long <lucien.xin@gmail.com>
    sctp: improve the events for sctp stream adding

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip6_gre: always reports o_key to userspace

Jason Wang <jasowang@redhat.com>
    vhost: fix OOB in get_rx_bufs()

Mathias Thore <mathias.thore@infinera.com>
    ucc_geth: Reset BQL queue when stopping device

George Amanakis <gamanakis@gmail.com>
    tun: move the call to tun_set_real_num_queues

Xin Long <lucien.xin@gmail.com>
    sctp: improve the events for sctp stream reset

Simon Horman <horms+renesas@verge.net.au>
    ravb: expand rx descriptor data to accommodate hw checksum

Josh Elsasser <jelsasser@appneta.com>
    net: set default network namespace in init_dummy_netdev()

Bernard Pidoux <f6bvp@free.fr>
    net/rose: fix NULL ax25_cb kernel panic

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: switch to sock timer API

Aya Levin <ayal@mellanox.com>
    net/mlx4_core: Add masking for a few queries on HCA caps

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip_gre: use erspan key field for tunnel lookup

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip_gre: always reports o_key to userspace

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: fix reading optional fields of L2TPv3

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: copy 4 more bytes to linear part if necessary

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan, l3mdev: fix broken l3s mode wrt local routes

Yohei Kanemaru <yohei.kanemaru@gmail.com>
    ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to an address

Arnd Bergmann <arnd@arndb.de>
    drm/msm/gpu: fix building without debugfs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Fix "net: ipv4: do not handle duplicate fragments as overlapping"


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm/mach-cns3xxx/pcie.c                      |   2 +-
 arch/arm64/kernel/hibernate.c                     |   4 +-
 arch/arm64/kernel/hyp-stub.S                      |   2 +
 arch/arm64/kernel/kaslr.c                         |   1 +
 arch/arm64/mm/flush.c                             |   6 +-
 drivers/gpio/gpio-altera-a10sr.c                  |   4 +-
 drivers/gpio/gpio-eic-sprd.c                      |  14 +-
 drivers/gpio/gpio-pcf857x.c                       |  26 ++--
 drivers/gpio/gpiolib.c                            |  10 +-
 drivers/gpu/drm/msm/msm_gpu.h                     |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c             |   2 +-
 drivers/iommu/intel-iommu.c                       |   2 +-
 drivers/md/raid5-cache.c                          |  33 +++--
 drivers/md/raid5.c                                |   8 +-
 drivers/mmc/host/bcm2835.c                        |   2 +
 drivers/mmc/host/mtk-sd.c                         |   2 +-
 drivers/mmc/host/sdhci-iproc.c                    |   5 +-
 drivers/net/ethernet/freescale/ucc_geth.c         |   2 +
 drivers/net/ethernet/mellanox/mlx4/fw.c           |  75 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |  22 +--
 drivers/net/ethernet/renesas/ravb_main.c          |  12 +-
 drivers/net/ipvlan/ipvlan_main.c                  |   6 +-
 drivers/net/tun.c                                 |   3 +-
 drivers/net/virtio_net.c                          | 169 +++++++++++++++-------
 drivers/of/device.c                               |   5 +-
 drivers/of/dynamic.c                              |  32 +++-
 drivers/of/kobj.c                                 |   4 +-
 drivers/of/of_mdio.c                              |  12 +-
 drivers/of/of_numa.c                              |   4 +-
 drivers/of/overlay.c                              | 117 ++++++++++-----
 drivers/of/platform.c                             |   8 +-
 drivers/of/unittest.c                             |  12 +-
 drivers/platform/x86/asus-nb-wmi.c                |   3 +-
 drivers/vhost/net.c                               |   3 +-
 drivers/vhost/scsi.c                              |   2 +-
 drivers/vhost/vhost.c                             |   7 +-
 drivers/vhost/vhost.h                             |   4 +-
 drivers/vhost/vsock.c                             |   2 +-
 fs/btrfs/ctree.c                                  |  78 ++++++----
 fs/btrfs/super.c                                  |   3 +
 fs/cifs/connect.c                                 |  53 +++++++
 fs/cifs/smb2pdu.c                                 |  50 ++++---
 fs/dcache.c                                       |   6 +-
 fs/gfs2/rgrp.c                                    |   2 +-
 fs/nfs/write.c                                    |   9 +-
 include/linux/netdevice.h                         |   8 +
 include/linux/of.h                                |  15 +-
 include/linux/sched/coredump.h                    |   1 +
 include/net/l3mdev.h                              |   3 +-
 kernel/exit.c                                     |  12 +-
 mm/hugetlb.c                                      |   3 +-
 mm/memory-failure.c                               |   3 +-
 mm/memory_hotplug.c                               |  36 +++--
 mm/migrate.c                                      |   7 +-
 mm/oom_kill.c                                     |  12 +-
 net/core/dev.c                                    |   3 +
 net/ipv4/gre_demux.c                              |  17 +++
 net/ipv4/ip_fragment.c                            |   2 +-
 net/ipv4/ip_gre.c                                 |  16 +-
 net/ipv6/af_inet6.c                               |   3 +
 net/ipv6/ip6_gre.c                                |  11 +-
 net/ipv6/ip6mr.c                                  |   7 +-
 net/ipv6/seg6_iptunnel.c                          |   2 +
 net/l2tp/l2tp_core.c                              |   9 +-
 net/l2tp/l2tp_core.h                              |  20 +++
 net/l2tp/l2tp_ip.c                                |   3 +
 net/l2tp/l2tp_ip6.c                               |   3 +
 net/netrom/nr_timer.c                             |  20 +--
 net/rose/rose_route.c                             |   5 +
 net/sctp/ipv6.c                                   |   3 +-
 net/sctp/protocol.c                               |   3 +-
 net/sctp/sm_make_chunk.c                          |  11 +-
 net/sctp/stream.c                                 |  58 ++++----
 sound/pci/hda/patch_realtek.c                     |  78 +++++-----
 sound/usb/quirks.c                                |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c     |  72 +++++++--
 77 files changed, 858 insertions(+), 423 deletions(-)


