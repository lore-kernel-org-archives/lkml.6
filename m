Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11842146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131851;
	bh=1S0W1ljKW3p5IwgSd9rikA5FzanTPNFNCJ6vnz+bExc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cTPQGJv7UQSzT5gOotL3pVuqBrQ22qB1iREIgJSQLYHHeXUDsa/BVbYyxpFDEj853
	 jerkqV5Det3bWiFdQECxpzkelLqvIYKj5HJxl4M5PrGWVRhG8hKcBf+cq4KFGzky9v
	 kisy72AQ7+6LaX7ylPXNvZdMkieUmL52vFbOxres=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfBYVVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbfBYVVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4791217F4;
        Mon, 25 Feb 2019 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129658;
        bh=1S0W1ljKW3p5IwgSd9rikA5FzanTPNFNCJ6vnz+bExc=;
        h=From:To:Cc:Subject:Date:From;
        b=sZq0xAf9k7jvRI3+QdQ1N4T/MjCkfw2EeWQ9xvcsbNIECNaX6MvCjx9K3knC4Kstg
         gJoAiy73GplSyjrLxWk5oP7z121bsQYZs7qWgnBeiohjIT41+J+QsuQ9mgBdlS2EHA
         nk4jJbWVngL0V7uzBHm8LVMoZun1SqP575Bzubf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/152] 4.19.26-stable review
Date:   Mon, 25 Feb 2019 22:09:52 +0100
Message-Id: <20190225195043.645958524@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.26-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.26-rc1
X-KernelTest-Deadline: 2019-02-27T19:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.26 release.
There are 152 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 27 19:49:57 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.26-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.26-rc1

Nathan Chancellor <natechancellor@gmail.com>
    pinctrl: max77620: Use define directive for max77620_pinconf_param values

Mikulas Patocka <mpatocka@redhat.com>
    udlfb: handle unplug properly

Taehee Yoo <ap420073@gmail.com>
    netfilter: ipt_CLUSTERIP: fix sleep-in-atomic bug in clusterip_config_entry_put()

Fernando Fernandez Mancera <ffmancera@riseup.net>
    netfilter: nfnetlink_osf: add missing fmatch check

Eli Cooper <elicooper@gmx.com>
    netfilter: ipv6: Don't preserve original oif for loopback address

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: use-after-free when deleting targets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix flush after rule deletion in the same batch

Hangbin Liu <liuhangbin@gmail.com>
    Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: unzip_vle_lz4.c,utils.c: rectify BUG_ONs

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: unzip_{pagevec.h,vle.c}: rectify BUG_ONs

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: {dir,inode,super}.c: rectify BUG_ONs

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: add a full barrier in erofs_workgroup_unfreeze

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: atomic_cond_read_relaxed on ref-locked workgroup

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: remove the redundant d_rehash() for the root dentry

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: drop multiref support temporarily

Chen Gong <gongchen4@huawei.com>
    staging: erofs: replace BUG_ON with DBG_BUGON in data.c

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: complete error handing of z_erofs_do_read_page

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix a bug when appling cache strategy

Willem de Bruijn <willemb@google.com>
    net: avoid false positives in untrusted gso validation

Willem de Bruijn <willemb@google.com>
    net: validate untrusted gso packets without csum offload

Yu Zhang <yu.c.zhang@linux.intel.com>
    kvm: x86: Return LA57 feature based on hardware capability

Felix Fietkau <nbd@nbd.name>
    mac80211: allocate tailroom for forwarded mesh packets

Leo (Hanghong) Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix MST reboot/poweroff sequence

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/fbdev: Actually configure untiled displays

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: define ARCH_SLAB_MINALIGN = 8

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: U-boot: check arguments paranoidly

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: Enable unaligned access in early ASM code

Dmitry V. Levin <ldv@altlinux.org>
    parisc: Fix ptrace syscall number modification

Eric Biggers <ebiggers@google.com>
    KEYS: always initialize keyring_index_key::desc_len

Eric Biggers <ebiggers@google.com>
    KEYS: user: Align the payload buffer

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Rework SCSI device reset handling

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5e: XDP, fix redirect resources availability check

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: fix two more memory leaks in cls_tcindex

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: fix a memory leak in cls_tcindex

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: fix a race condition in tcindex_destroy()

Hangbin Liu <liuhangbin@gmail.com>
    sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Hangbin Liu <liuhangbin@gmail.com>
    geneve: should not call rt6_lookup() when ipv6 was disabled

Johannes Berg <johannes.berg@intel.com>
    net: socket: make bond ioctls go through compat_ifreq_ioctl()

Johannes Berg <johannes.berg@intel.com>
    net: socket: fix SIOCGIFNAME in compat

Johannes Berg <johannes.berg@intel.com>
    Revert "kill dev_ifsioc()"

Johannes Berg <johannes.berg@intel.com>
    Revert "socket: fix struct ifreq size in compat ioctl"

Cong Wang <xiyou.wangcong@gmail.com>
    team: avoid complex list operations in team_nl_cmd_options_set()

Xin Long <lucien.xin@gmail.com>
    sctp: set stream ext to NULL after freeing it in sctp_stream_outq_migrate

Xin Long <lucien.xin@gmail.com>
    sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment

Russell King <rmk+kernel@armlinux.org.uk>
    net: sfp: do not probe SFP module before we're attached

Kal Conley <kal.conley@dectris.com>
    net/packet: fix 4gb buffer limit due to overflow check

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5e: Don't overwrite pedit action when multiple pedit used

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix race between link up and device initalization

Li RongQing <lirongqing@baidu.com>
    ipv6: propagate genlmsg_reply return code

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    inet_diag: fix reporting cgroup classid and fallback to priority

Eric Dumazet <edumazet@google.com>
    batman-adv: fix uninit-value in batadv_interface_tx()

Nathan Chancellor <natechancellor@gmail.com>
    isdn: avm: Fix string plus integer warning from Clang

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Ido Schimmel <idosch@mellanox.com>
    selftests: forwarding: Add a test case for externally learned FDB entries

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky

Ido Schimmel <idosch@mellanox.com>
    net: bridge: Mark FDB entries that were added by user as such

Nir Dotan <nird@mellanox.com>
    mlxsw: pci: Return error on PCI reset timeout

Madalin Bucur <madalin.bucur@nxp.com>
    dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start

Peter Oskolkov <posk@google.com>
    bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Kangjie Lu <kjlu@umn.edu>
    leds: lp5523: fix a missing check of return value of lp55xx_read

Cheng-Min Ao <tony_ao@wiwynn.com>
    hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table

Colin Ian King <colin.king@canonical.com>
    atm: he: fix sign-extension overflow on large shift

Stanislav Fomichev <sdf@google.com>
    selftests/bpf: retry tests that expect build-id

Stanislav Fomichev <sdf@google.com>
    bpf: zero out build_id for BPF_STACK_BUILD_ID_IP

Stanislav Fomichev <sdf@google.com>
    bpf: don't assume build-id length is always 20 bytes

David Howells <dhowells@redhat.com>
    afs: Fix key refcounting in file locking code

Marc Dionne <marc.dionne@auristor.com>
    afs: Don't set vnode->cb_s_break in afs_validate()

Davide Caratti <dcaratti@redhat.com>
    selftests: tc-testing: fix parsing of ife type

Davide Caratti <dcaratti@redhat.com>
    selftests: tc-testing: fix tunnel_key failure if dst_port is unspecified

Davide Caratti <dcaratti@redhat.com>
    selftests: tc-testing: drop test on missing tunnel key id

Wen Yang <wen.yang99@zte.com.cn>
    pvcalls-front: fix potential null dereference

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/sun4i: backend: add missing of_node_puts

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    vhost: return EINVAL if iovecs size does not match the message size

Charlene Liu <charlene.liu@amd.com>
    drm/amd/display: fix PME notification not working in RV desktop

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdkfd: Don't assign dGPUs to APU topology devices

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/meson: add missing of_node_put

Talons Lee <xin.li@citrix.com>
    always clear the X2APIC_ENABLE bit for PV guest

Henry Yen <henry.yen@mediatek.com>
    netfilter: nft_flow_offload: fix checking method of conntrack helper

Varun Prakash <varun@chelsio.com>
    scsi: cxgb4i: add wait_for_completion()

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: Fix geometry descriptor size

Manish Rangankar <mrangankar@marvell.com>
    scsi: qedi: Add ep_state for login completion on un-reachable targets

Stanley Chu <stanley.chu@mediatek.com>
    scsi: ufs: Fix system suspend status

Xiubo Li <xiubli@redhat.com>
    scsi: tcmu: avoid cmd/qfull timers updated whenever a new cmd comes

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Prevent RX starvation in stmmac_napi_poll()

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix the logic of checking if RX Watchdog must be enabled

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Check if CBS is supported before configuring

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: dwxgmac2: Only clear interrupts that are active

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix PCI module removal leak

Tony Luck <tony.luck@intel.com>
    acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.

Leon Romanovsky <leon@kernel.org>
    RDMA/mthca: Clear QP objects during their allocation

wenxu <wenxu@ucloud.cn>
    netfilter: nft_flow_offload: fix interaction with vrf slave device

Song Liu <songliubraving@fb.com>
    bpf: fix panic in stack_map_get_build_id() on i386 and arm32

Wen Yang <wen.yang99@zte.com.cn>
    pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock

Yuchung Cheng <ycheng@google.com>
    bpf: correctly set initial window on active Fast Open sender

wenxu <wenxu@ucloud.cn>
    netfilter: nft_flow_offload: Fix reverse route lookup

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: jazz: fix 64bit build

Michael S. Tsirkin <mst@redhat.com>
    include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR

Logan Gunthorpe <logang@deltatee.com>
    scsi: isci: initialize shost fully before calling scsi_add_host()

YueHaibing <yuehaibing@huawei.com>
    scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix leaking object reference count

Ido Schimmel <idosch@mellanox.com>
    selftests: forwarding: Add a test for VLAN deletion

Nir Dotan <nird@mellanox.com>
    mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition

Dan Carpenter <dan.carpenter@oracle.com>
    xprtrdma: Double free in rpcrdma_sendctxs_create()

Alban Bedel <albeu@free.fr>
    MIPS: ath79: Enable OF serial ports in the default config

Stephen Warren <swarren@nvidia.com>
    net/mlx4: Get rid of page operation after dma_alloc_coherent

NeilBrown <neil@brown.name>
    watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem

Andrey Ignatov <rdna@fb.com>
    selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock_addr

Andrey Ignatov <rdna@fb.com>
    bpf: Fix [::] -> [::1] rewrite in sys_sendmsg

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix use after free identified by SLUB debug

Denis Bolotin <dbolotin@marvell.com>
    qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier

Denis Bolotin <dbolotin@marvell.com>
    qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page count

YueHaibing <yuehaibing@huawei.com>
    xen/pvcalls: remove set but not used variable 'intf'

Kangjie Lu <kjlu@umn.edu>
    mfd: mc13xxx: Fix a missing check of a register-read failure

Keerthy <j-keerthy@ti.com>
    mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove

Oskari Lemmela <oskari@lemmela.net>
    mfd: axp20x: Add supported cells for AXP803

Chen-Yu Tsai <wens@csie.org>
    mfd: axp20x: Re-align MFD cell entries

Oskari Lemmela <oskari@lemmela.net>
    mfd: axp20x: Add AC power supply cell for AXP813

Charles Keepax <ckeepax@opensource.cirrus.com>
    mfd: wm5110: Add missing ASRC rate register

Jonathan Marek <jonathan@marek.ca>
    mfd: qcom_rpm: write fw_version to CTRL_REG

Dien Pham <dien.pham.ry@renesas.com>
    mfd: bd9571mwv: Add volatile register to make DVFS work

Dan Carpenter <dan.carpenter@oracle.com>
    mfd: ab8500-core: Return zero in get_register_interruptible()

Nicolas Boichat <drinkcat@chromium.org>
    mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Nathan Chancellor <natechancellor@gmail.com>
    mfd: db8500-prcmu: Fix some section annotations

Nathan Chancellor <natechancellor@gmail.com>
    mfd: twl-core: Fix section annotations on {,un}protect_pm_master

Stefano Stabellini <sstabellini@kernel.org>
    pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read

Stefano Stabellini <sstabellini@kernel.org>
    pvcalls-front: properly allocate sk

Stefano Stabellini <sstabellini@kernel.org>
    pvcalls-front: don't try to free unallocated rings

Stefano Stabellini <sstabellini@kernel.org>
    pvcalls-front: read all data before closing the connection

Vignesh R <vigneshr@ti.com>
    mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells

Heiko Stuebner <heiko.stuebner@bq.com>
    backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness tables

Eric Biggers <ebiggers@google.com>
    KEYS: allow reaching the keys quotas exactly

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek: Disable PC beep in passthrough on alc285

Jeremy Soller <jeremy@system76.com>
    ALSA: hda/realtek - Headset microphone and internal speaker support for System76 oryp5

Michal Hocko <mhocko@suse.com>
    proc, oom: do not report alien mms when setting oom_score_adj

Ralph Campbell <rcampbell@nvidia.com>
    numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES

Yan, Zheng <zyan@redhat.com>
    ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Ilya Dryomov <idryomov@gmail.com>
    libceph: handle an empty authorize reply

Herbert Xu <herbert@gondor.apana.org.au>
    mac80211: Free mpath object when rhashtable insertion fails

Herbert Xu <herbert@gondor.apana.org.au>
    mac80211: Use linked list instead of rhashtable walk for mesh tables

Rakesh Pillai <pillair@codeaurora.org>
    mac80211: Restore vif beacon interval if start ap fails

Lubomir Rintel <lkundrak@v3.sk>
    gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2

René van Dorst <opensource@vdorst.com>
    gpio: MT7621: use a per instance irq_chip structure

Paul Burton <paul.burton@mips.com>
    MIPS: eBPF: Always return sign extended 32b values

Quentin Perret <quentin.perret@arm.com>
    tracing: Fix number of entries in trace header

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/cache.h                       |  11 ++
 arch/arc/kernel/head.S                             |  14 +-
 arch/arc/kernel/setup.c                            |  87 ++++++++----
 arch/arm/probes/kprobes/opt-arm.c                  |   2 +-
 arch/mips/configs/ath79_defconfig                  |   1 +
 arch/mips/jazz/jazzdma.c                           |   5 +-
 arch/mips/net/ebpf_jit.c                           |   9 +-
 arch/parisc/kernel/ptrace.c                        |  29 ++--
 arch/powerpc/kernel/head_8xx.S                     |   3 +-
 arch/x86/kvm/cpuid.c                               |   4 +
 arch/x86/xen/enlighten_pv.c                        |   5 +-
 drivers/acpi/nfit/core.c                           |   6 +-
 drivers/atm/he.c                                   |   2 +-
 drivers/gpio/gpio-mt7621.c                         |  20 +--
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  12 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   7 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |  12 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   9 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   1 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   5 +-
 drivers/hwmon/tmp421.c                             |   2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |   4 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  10 --
 drivers/isdn/hardware/avm/b1.c                     |   2 +-
 drivers/isdn/i4l/isdn_tty.c                        |   6 +-
 drivers/leds/leds-lp5523.c                         |   4 +-
 drivers/mfd/ab8500-core.c                          |   2 +-
 drivers/mfd/axp20x.c                               | 126 +++++++++--------
 drivers/mfd/bd9571mwv.c                            |   1 +
 drivers/mfd/cros_ec_dev.c                          |   1 +
 drivers/mfd/db8500-prcmu.c                         |   4 +-
 drivers/mfd/mc13xxx-core.c                         |   4 +-
 drivers/mfd/mt6397-core.c                          |   3 +-
 drivers/mfd/qcom_rpm.c                             |   4 +
 drivers/mfd/ti_am335x_tscadc.c                     |   5 +-
 drivers/mfd/tps65218.c                             |  24 +---
 drivers/mfd/twl-core.c                             |   4 +-
 drivers/mfd/wm5110-tables.c                        |   2 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   6 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  22 ++-
 drivers/net/ethernet/mellanox/mlx4/icm.c           |  92 +++++++-----
 drivers/net/ethernet/mellanox/mlx4/icm.h           |  22 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |  17 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 ++--
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c   |  10 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   4 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  51 +++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |  10 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   2 +
 drivers/net/geneve.c                               |  10 +-
 drivers/net/phy/sfp-bus.c                          |   2 +
 drivers/net/phy/sfp.c                              |  30 ++--
 drivers/net/phy/sfp.h                              |   2 +
 drivers/net/team/team.c                            |  27 +---
 drivers/pinctrl/pinctrl-max77620.c                 |  14 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |   9 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |  28 ++--
 drivers/scsi/cxgbi/libcxgbi.c                      |   7 +-
 drivers/scsi/cxgbi/libcxgbi.h                      |   5 +-
 drivers/scsi/isci/init.c                           |  14 +-
 drivers/scsi/qedi/qedi_iscsi.c                     |   3 +
 drivers/scsi/qedi/qedi_iscsi.h                     |   1 +
 drivers/scsi/qla4xxx/ql4_os.c                      |   2 +
 drivers/scsi/ufs/ufs.h                             |   2 +-
 drivers/scsi/ufs/ufshcd.c                          |   2 +
 drivers/staging/erofs/data.c                       |  31 +++--
 drivers/staging/erofs/dir.c                        |   7 +-
 drivers/staging/erofs/inode.c                      |  10 +-
 drivers/staging/erofs/internal.h                   |  70 ++++++----
 drivers/staging/erofs/super.c                      |  19 +--
 drivers/staging/erofs/unzip_pagevec.h              |   2 +-
 drivers/staging/erofs/unzip_vle.c                  |  95 +++++--------
 drivers/staging/erofs/unzip_vle.h                  |  12 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |   2 +-
 drivers/staging/erofs/utils.c                      |  12 +-
 drivers/target/target_core_user.c                  |  88 ++++++++----
 drivers/vhost/vhost.c                              |   8 +-
 drivers/video/backlight/pwm_bl.c                   |  19 +--
 drivers/video/fbdev/udlfb.c                        | 141 +++++--------------
 drivers/watchdog/mt7621_wdt.c                      |   1 +
 drivers/watchdog/rt2880_wdt.c                      |   1 +
 drivers/xen/pvcalls-back.c                         |   9 +-
 drivers/xen/pvcalls-front.c                        | 100 +++++++++----
 fs/afs/flock.c                                     |   4 +-
 fs/afs/inode.c                                     |   3 +-
 fs/ceph/snap.c                                     |   3 +-
 fs/proc/base.c                                     |   4 -
 include/keys/user-type.h                           |   2 +-
 include/linux/compiler-clang.h                     |   5 +-
 include/linux/compiler-gcc.h                       |   4 -
 include/linux/compiler-intel.h                     |   4 +-
 include/linux/compiler.h                           |   4 +-
 include/linux/qed/qed_chain.h                      |  31 +++++
 include/linux/skbuff.h                             |   2 +-
 include/linux/virtio_net.h                         |  19 +++
 include/net/netfilter/nf_flow_table.h              |   1 -
 include/uapi/linux/inet_diag.h                     |  16 ++-
 include/video/udlfb.h                              |   3 -
 kernel/bpf/stackmap.c                              |  12 +-
 kernel/trace/trace.c                               |   2 +
 mm/mempolicy.c                                     |   6 +-
 net/batman-adv/soft-interface.c                    |   2 +
 net/bridge/br_fdb.c                                |   5 +
 net/bridge/br_multicast.c                          |   9 +-
 net/ceph/messenger.c                               |  15 +-
 net/core/filter.c                                  |   7 +-
 net/ipv4/inet_diag.c                               |  10 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  19 ++-
 net/ipv6/netfilter.c                               |   4 +-
 net/ipv6/seg6.c                                    |   4 +-
 net/ipv6/sit.c                                     |   3 +-
 net/ipv6/udp.c                                     |   8 +-
 net/mac80211/cfg.c                                 |   6 +-
 net/mac80211/mesh.h                                |   6 +
 net/mac80211/mesh_pathtbl.c                        | 155 ++++++---------------
 net/mac80211/rx.c                                  |   7 +-
 net/netfilter/nf_flow_table_core.c                 |   5 +-
 net/netfilter/nf_tables_api.c                      |   5 +
 net/netfilter/nfnetlink_osf.c                      |   4 +
 net/netfilter/nft_compat.c                         |   3 +-
 net/netfilter/nft_flow_offload.c                   |  13 +-
 net/packet/af_packet.c                             |   2 +-
 net/sched/cls_tcindex.c                            |  80 ++++++-----
 net/sctp/diag.c                                    |   1 +
 net/sctp/offload.c                                 |   1 +
 net/sctp/stream.c                                  |   4 +-
 net/socket.c                                       |  82 ++++++++---
 net/sunrpc/xprtrdma/verbs.c                        |   6 +-
 security/keys/key.c                                |   4 +-
 security/keys/keyring.c                            |   4 +-
 security/keys/proc.c                               |   3 +-
 security/keys/request_key.c                        |   1 +
 security/keys/request_key_auth.c                   |   2 +-
 sound/pci/hda/patch_realtek.c                      |  42 +++++-
 tools/testing/selftests/bpf/test_progs.c           |  30 ++++
 tools/testing/selftests/bpf/test_sock_addr.c       |  53 ++++++-
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |  47 ++++++-
 .../selftests/tc-testing/tc-tests/actions/ife.json |  88 ++++++------
 .../tc-testing/tc-tests/actions/tunnel_key.json    |  31 +----
 152 files changed, 1464 insertions(+), 989 deletions(-)


