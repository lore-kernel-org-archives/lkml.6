Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9280520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131162;
	bh=1ZBNb2BU51kmR1igqwx4Mxx3Mt5/BXhiJ2xZ+SvPGgU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bdd3/EmeCsnV8pfgybE15F08vGI5hJyUcccYMPVQS9d2VyF6gQGghPaqSwXDY4wiI
	 7pj9Wj+KOeYWCex2cWzNg0hfLtef4V0yf2VEcuivX4jj6s83Lb6CLGYM1ekb3nzEeL
	 eKRAt+aqXm2N4CPsg8YULvDhtBJOgRDRURpYmRNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfBYV25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731906AbfBYV2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9F920663;
        Mon, 25 Feb 2019 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130133;
        bh=1ZBNb2BU51kmR1igqwx4Mxx3Mt5/BXhiJ2xZ+SvPGgU=;
        h=From:To:Cc:Subject:Date:From;
        b=egEI79xmL2ovE74FNh5brlbk7hc9F6BBbdI0pt4c2+8rJNPvyrdagG8vxx7Q/1wbj
         GM/WrD+yTqMev/nfTbEjzYKfAweehbPXxepJH6zbZLB4ns5pMoZFqxGvrdVHex4EYl
         8r3IomyngmmoZi5arYtv/ju1CgfWu5m88pG3MDtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 000/183] 4.20.13-stable review
Date:   Mon, 25 Feb 2019 22:09:33 +0100
Message-Id: <20190225195054.748060397@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.13-rc1
X-KernelTest-Deadline: 2019-02-27T19:51+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.13 release.
There are 183 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.13-rc1

Nathan Chancellor <natechancellor@gmail.com>
    pinctrl: max77620: Use define directive for max77620_pinconf_param values

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

Willem de Bruijn <willemb@google.com>
    net: avoid false positives in untrusted gso validation

Willem de Bruijn <willemb@google.com>
    net: validate untrusted gso packets without csum offload

Curtis Malainey <cujomalainey@chromium.org>
    ASoC: soc-core: fix init platform memory handling

Pierre Morel <pmorel@linux.ibm.com>
    s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity

Yu Zhang <yu.c.zhang@linux.intel.com>
    kvm: x86: Return LA57 feature based on hardware capability

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/mmu: fix switch between root and guest MMUs

Yu Zhang <yu.c.zhang@linux.intel.com>
    KVM: MMU: record maximum physical address width in kvm_mmu_extended_role

Felix Fietkau <nbd@nbd.name>
    mac80211: allocate tailroom for forwarded mesh packets

Toke Høiland-Jørgensen <toke@redhat.com>
    mac80211: Change default tx_sk_pacing_shift to 7

Leo (Hanghong) Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix MST reboot/poweroff sequence

Christian König <ckoenig.leichtzumerken@gmail.com>
    drm/amdgpu: disable bulk moves for now

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/fbdev: Actually configure untiled displays

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Yangtao Li <tiny.windzz@gmail.com>
    cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: define ARCH_SLAB_MINALIGN = 8

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: U-boot: check arguments paranoidly

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: Enable unaligned access in early ASM code

Dmitry V. Levin <ldv@altlinux.org>
    parisc: Fix ptrace syscall number modification

Alexandre Belloni <alexandre.belloni@bootlin.com>
    clk: at91: fix at91sam9x5 peripheral clock number

Alexandre Belloni <alexandre.belloni@bootlin.com>
    clk: at91: fix masterck name

Eric Biggers <ebiggers@google.com>
    KEYS: always initialize keyring_index_key::desc_len

Eric Biggers <ebiggers@google.com>
    KEYS: user: Align the payload buffer

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Rework SCSI device reset handling

Masato Suzuki <masato.suzuki@wdc.com>
    scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5e: XDP, fix redirect resources availability check

Raed Salem <raeds@mellanox.com>
    net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance

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

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Fix NPD checking for br_vlan_enabled()

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

Daniel Borkmann <daniel@iogearbox.net>
    bpf: pull in pkt_sched.h header for tooling to fix bpftool build

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

Yuchung Cheng <ycheng@google.com>
    bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing

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
    afs: Fix race in async call refcounting

David Howells <dhowells@redhat.com>
    afs: Provide a function to get a ref on a call

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

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ9031

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: EC: Look for ECDT EC after calling acpi_load_tables()

Wen Yang <wen.yang99@zte.com.cn>
    pvcalls-front: fix potential null dereference

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/sun4i: backend: add missing of_node_puts

Trond Myklebust <trondmy@gmail.com>
    SUNRPC: Ensure we respect the RPCSEC_GSS sequence number limit

Trond Myklebust <trondmy@gmail.com>
    SUNRPC: Ensure rq_bytes_sent is reset before request transmission

Yonghong Song <yhs@fb.com>
    samples/bpf: workaround clang asm goto compilation errors

Stanislav Fomichev <sdf@google.com>
    selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh

Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
    xsk: Check if a queue exists during umem setup

Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
    vhost/scsi: Use copy_to_iter() to send control queue response

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

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    scsi: qla1280: set 64bit coherent mask

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

Marc Dionne <marc.dionne@auristor.com>
    afs: Set correct lock type for the yfs CreateFile

Song Liu <songliubraving@fb.com>
    bpf: fix panic in stack_map_get_build_id() on i386 and arm32

Anders Roxell <anders.roxell@linaro.org>
    selftests: bpf: install files tcp_(server|client)*.py

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

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum: Add VXLAN dependency for spectrum

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

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix chip ID for NCT6798D

Andrey Ignatov <rdna@fb.com>
    selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock_addr

Andrey Ignatov <rdna@fb.com>
    bpf: Fix [::] -> [::1] rewrite in sys_sendmsg

Peter Oskolkov <posk@google.com>
    selftests: net: fix/improve ip_defrag selftest

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix use after free identified by SLUB debug

Denis Bolotin <dbolotin@marvell.com>
    qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier

Denis Bolotin <dbolotin@marvell.com>
    qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page count

Wen Yang <wen.yang99@zte.com.cn>
    soc/fsl/qe: fix err handling of ucc_of_parse_tdm

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

Jean Delvare <jdelvare@suse.de>
    mfd: at91-usart: Add platform dependency

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

Bjorn Andersson <bjorn.andersson@linaro.org>
    pinctrl: qcom: qcs404: Correct SDC tile

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

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x0u: fix suspend/resume

Paul Burton <paul.burton@mips.com>
    MIPS: eBPF: Always return sign extended 32b values

Quentin Perret <quentin.perret@arm.com>
    tracing: Fix number of entries in trace header

Changbin Du <changbin.du@gmail.com>
    kprobe: Do not use uaccess functions to access kernel memory that can fault

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arc/include/asm/cache.h                       |   11 +
 arch/arc/kernel/head.S                             |   14 +-
 arch/arc/kernel/setup.c                            |   87 +-
 arch/arm/probes/kprobes/opt-arm.c                  |    2 +-
 arch/mips/configs/ath79_defconfig                  |    1 +
 arch/mips/jazz/jazzdma.c                           |    5 +-
 arch/mips/net/ebpf_jit.c                           |    9 +-
 arch/parisc/kernel/ptrace.c                        |   29 +-
 arch/powerpc/kernel/head_8xx.S                     |    3 +-
 arch/s390/kvm/vsie.c                               |    2 +-
 arch/x86/include/asm/kvm_host.h                    |    2 +
 arch/x86/kvm/cpuid.c                               |    4 +
 arch/x86/kvm/mmu.c                                 |   18 +-
 arch/x86/xen/enlighten_pv.c                        |    5 +-
 drivers/acpi/bus.c                                 |   24 +-
 drivers/acpi/nfit/core.c                           |    6 +-
 drivers/atm/he.c                                   |    2 +-
 drivers/clk/at91/at91sam9x5.c                      |    5 +-
 drivers/clk/at91/sama5d2.c                         |    4 +-
 drivers/clk/at91/sama5d4.c                         |    2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |    2 +-
 drivers/gpio/gpio-mt7621.c                         |   20 +-
 drivers/gpio/gpio-pxa.c                            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   12 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    5 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |    7 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |   12 +-
 drivers/gpu/drm/meson/meson_drv.c                  |    9 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |    1 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    5 +-
 drivers/hwmon/nct6775.c                            |   12 +-
 drivers/hwmon/tmp421.c                             |    2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    4 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   10 -
 drivers/isdn/hardware/avm/b1.c                     |    2 +-
 drivers/isdn/i4l/isdn_tty.c                        |    6 +-
 drivers/leds/leds-lp5523.c                         |    4 +-
 drivers/mfd/Kconfig                                |    1 +
 drivers/mfd/ab8500-core.c                          |    2 +-
 drivers/mfd/axp20x.c                               |  126 ++-
 drivers/mfd/bd9571mwv.c                            |    1 +
 drivers/mfd/cros_ec_dev.c                          |    1 +
 drivers/mfd/db8500-prcmu.c                         |    4 +-
 drivers/mfd/mc13xxx-core.c                         |    4 +-
 drivers/mfd/mt6397-core.c                          |    3 +-
 drivers/mfd/qcom_rpm.c                             |    4 +
 drivers/mfd/ti_am335x_tscadc.c                     |    5 +-
 drivers/mfd/tps65218.c                             |   24 +-
 drivers/mfd/twl-core.c                             |    4 +-
 drivers/mfd/wm5110-tables.c                        |    2 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    6 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   22 +-
 drivers/net/ethernet/mellanox/mlx4/icm.c           |   92 +-
 drivers/net/ethernet/mellanox/mlx4/icm.h           |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |   17 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    6 +
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |    1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |    4 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c   |   10 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   12 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   51 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   10 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    2 +
 drivers/net/geneve.c                               |   10 +-
 drivers/net/phy/micrel.c                           |    1 +
 drivers/net/phy/sfp-bus.c                          |    2 +
 drivers/net/phy/sfp.c                              |   30 +-
 drivers/net/phy/sfp.h                              |    2 +
 drivers/net/team/team.c                            |   27 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |   62 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   46 +-
 drivers/pinctrl/pinctrl-max77620.c                 |   14 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |    2 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |    9 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |   28 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |    7 +-
 drivers/scsi/cxgbi/libcxgbi.h                      |    5 +-
 drivers/scsi/isci/init.c                           |   14 +-
 drivers/scsi/qedi/qedi_iscsi.c                     |    3 +
 drivers/scsi/qedi/qedi_iscsi.h                     |    1 +
 drivers/scsi/qla1280.c                             |    2 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |    2 +
 drivers/scsi/sd_zbc.c                              |    8 +-
 drivers/scsi/ufs/ufs.h                             |    2 +-
 drivers/scsi/ufs/ufshcd.c                          |    2 +
 drivers/soc/fsl/qe/qe_tdm.c                        |   55 -
 drivers/staging/erofs/dir.c                        |    7 +-
 drivers/staging/erofs/inode.c                      |   10 +-
 drivers/staging/erofs/internal.h                   |   70 +-
 drivers/staging/erofs/super.c                      |   19 +-
 drivers/staging/erofs/unzip_pagevec.h              |    2 +-
 drivers/staging/erofs/unzip_vle.c                  |   35 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |    2 +-
 drivers/staging/erofs/utils.c                      |   12 +-
 drivers/target/target_core_user.c                  |   88 +-
 drivers/vhost/scsi.c                               |   20 +-
 drivers/vhost/vhost.c                              |    8 +-
 drivers/video/backlight/pwm_bl.c                   |   19 +-
 drivers/watchdog/mt7621_wdt.c                      |    1 +
 drivers/watchdog/rt2880_wdt.c                      |    1 +
 drivers/xen/pvcalls-back.c                         |    9 +-
 drivers/xen/pvcalls-front.c                        |  100 +-
 fs/afs/flock.c                                     |    4 +-
 fs/afs/inode.c                                     |    3 +-
 fs/afs/protocol_yfs.h                              |   11 +
 fs/afs/rxrpc.c                                     |   53 +-
 fs/afs/yfsclient.c                                 |    2 +-
 fs/ceph/snap.c                                     |    3 +-
 fs/proc/base.c                                     |    4 -
 include/keys/user-type.h                           |    2 +-
 include/linux/compiler-clang.h                     |    5 +-
 include/linux/compiler-gcc.h                       |    4 -
 include/linux/compiler-intel.h                     |    4 +-
 include/linux/compiler.h                           |    4 +-
 include/linux/qed/qed_chain.h                      |   31 +
 include/linux/skbuff.h                             |    2 +-
 include/linux/virtio_net.h                         |   19 +
 include/net/netfilter/nf_flow_table.h              |    1 -
 include/sound/soc.h                                |    6 +
 include/trace/events/afs.h                         |    2 +
 include/uapi/linux/inet_diag.h                     |   16 +-
 kernel/bpf/stackmap.c                              |   12 +-
 kernel/trace/trace.c                               |    2 +
 kernel/trace/trace_kprobe.c                        |   10 +-
 mm/mempolicy.c                                     |    6 +-
 net/batman-adv/soft-interface.c                    |    2 +
 net/bridge/br_fdb.c                                |    5 +
 net/bridge/br_multicast.c                          |    9 +-
 net/ceph/messenger.c                               |   15 +-
 net/core/filter.c                                  |   11 +-
 net/dsa/port.c                                     |    4 +-
 net/ipv4/inet_diag.c                               |   10 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   19 +-
 net/ipv6/netfilter.c                               |    4 +-
 net/ipv6/seg6.c                                    |    4 +-
 net/ipv6/sit.c                                     |    3 +-
 net/ipv6/udp.c                                     |    8 +-
 net/mac80211/cfg.c                                 |    6 +-
 net/mac80211/main.c                                |    4 +-
 net/mac80211/mesh.h                                |    6 +
 net/mac80211/mesh_pathtbl.c                        |  155 +--
 net/mac80211/rx.c                                  |    7 +-
 net/netfilter/nf_flow_table_core.c                 |    5 +-
 net/netfilter/nf_tables_api.c                      |    5 +
 net/netfilter/nfnetlink_osf.c                      |    4 +
 net/netfilter/nft_compat.c                         |    3 +-
 net/netfilter/nft_flow_offload.c                   |   13 +-
 net/packet/af_packet.c                             |    2 +-
 net/sched/cls_tcindex.c                            |   80 +-
 net/sctp/diag.c                                    |    1 +
 net/sctp/offload.c                                 |    1 +
 net/sctp/stream.c                                  |    4 +-
 net/socket.c                                       |   82 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   12 +-
 net/sunrpc/clnt.c                                  |   20 +-
 net/sunrpc/xprt.c                                  |    1 +
 net/sunrpc/xprtrdma/verbs.c                        |    6 +-
 net/xdp/xdp_umem.c                                 |   16 +-
 samples/bpf/Makefile                               |    1 +
 samples/bpf/asm_goto_workaround.h                  |   16 +
 security/keys/key.c                                |    4 +-
 security/keys/keyring.c                            |    4 +-
 security/keys/proc.c                               |    3 +-
 security/keys/request_key.c                        |    1 +
 security/keys/request_key_auth.c                   |    2 +-
 sound/pci/hda/patch_realtek.c                      |   42 +-
 sound/soc/soc-core.c                               |   11 +-
 tools/include/uapi/linux/pkt_sched.h               | 1163 ++++++++++++++++++++
 tools/testing/selftests/bpf/Makefile               |    5 +-
 tools/testing/selftests/bpf/test_progs.c           |   30 +
 tools/testing/selftests/bpf/test_sock_addr.c       |   53 +-
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |   47 +-
 tools/testing/selftests/net/ip_defrag.c            |   96 +-
 tools/testing/selftests/net/ip_defrag.sh           |    9 +-
 .../selftests/tc-testing/tc-tests/actions/ife.json |   88 +-
 .../tc-testing/tc-tests/actions/tunnel_key.json    |   31 +-
 188 files changed, 2941 insertions(+), 988 deletions(-)


