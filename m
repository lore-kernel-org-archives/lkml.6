Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D94BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B20217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129479;
	bh=Rs+Vpv793QpHXmBo4Vg97b0zfoIPHMozhZ2LbcgYfOI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LyPDd6vFPT7O5Az//O6qQu+qYhMMDG3Bd8gC0EUHc8vizU4wJ1+dqBWznOqtrdA/P
	 pQDiUkg9S9Fi+CcudpM2O+vQGCzSZOFnoOAyztgh+y0bWNDrphQ2Zy/u2ybqPW1qtu
	 rBpK6i/r4q2iZ7omuS4svJDlKI+QfJFxH6AU2Y8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfBYVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfBYVRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BDE2147C;
        Mon, 25 Feb 2019 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129473;
        bh=Rs+Vpv793QpHXmBo4Vg97b0zfoIPHMozhZ2LbcgYfOI=;
        h=From:To:Cc:Subject:Date:From;
        b=ysDkEkmRquYPIMYafzXfbdSOaGxk8hJBapbX0Ei2wWaUreZj5uZXhK9Hv9qWVaSkn
         a/D43FhG8mcCTQxiWNihNpCVQisBJ/txCYpfEGgYq4xKjUhsKvz+nKKzGW43mPud0h
         T9A71VFqwYCj1S+QVmAHESS0zGs0eCHXjK0uUIao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/71] 4.14.104-stable review
Date:   Mon, 25 Feb 2019 22:11:02 +0100
Message-Id: <20190225195034.555044862@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.104-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.104-rc1
X-KernelTest-Deadline: 2019-02-27T19:50+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.104 release.
There are 71 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 27 19:50:01 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.104-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.104-rc1

Matthias Kaehlcke <mka@chromium.org>
    sched/sysctl: Fix attributes of some extern declarations

Colin Ian King <colin.king@canonical.com>
    phy: tegra: remove redundant self assignment of 'map'

Nathan Chancellor <natechancellor@gmail.com>
    pinctrl: max77620: Use define directive for max77620_pinconf_param values

Eli Cooper <elicooper@gmx.com>
    netfilter: ipv6: Don't preserve original oif for loopback address

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: use-after-free when deleting targets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix flush after rule deletion in the same batch

Hangbin Liu <liuhangbin@gmail.com>
    Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Willem de Bruijn <willemb@google.com>
    net: avoid false positives in untrusted gso validation

Willem de Bruijn <willemb@google.com>
    net: validate untrusted gso packets without csum offload

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/fbdev: Actually configure untiled displays

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

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    inet_diag: fix reporting cgroup classid and fallback to priority

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Hangbin Liu <liuhangbin@gmail.com>
    sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Cong Wang <xiyou.wangcong@gmail.com>
    team: avoid complex list operations in team_nl_cmd_options_set()

Xin Long <lucien.xin@gmail.com>
    sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment

Russell King <rmk+kernel@armlinux.org.uk>
    net: sfp: do not probe SFP module before we're attached

Kal Conley <kal.conley@dectris.com>
    net/packet: fix 4gb buffer limit due to overflow check

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5e: Don't overwrite pedit action when multiple pedit used

Li RongQing <lirongqing@baidu.com>
    ipv6: propagate genlmsg_reply return code

Eric Dumazet <edumazet@google.com>
    batman-adv: fix uninit-value in batadv_interface_tx()

Nathan Chancellor <natechancellor@gmail.com>
    isdn: avm: Fix string plus integer warning from Clang

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky

Peter Oskolkov <posk@google.com>
    bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Kangjie Lu <kjlu@umn.edu>
    leds: lp5523: fix a missing check of return value of lp55xx_read

Cheng-Min Ao <tony_ao@wiwynn.com>
    hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table

Colin Ian King <colin.king@canonical.com>
    atm: he: fix sign-extension overflow on large shift

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/meson: add missing of_node_put

Talons Lee <xin.li@citrix.com>
    always clear the X2APIC_ENABLE bit for PV guest

Manish Rangankar <mrangankar@marvell.com>
    scsi: qedi: Add ep_state for login completion on un-reachable targets

Stanley Chu <stanley.chu@mediatek.com>
    scsi: ufs: Fix system suspend status

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix PCI module removal leak

Yuchung Cheng <ycheng@google.com>
    bpf: correctly set initial window on active Fast Open sender

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: jazz: fix 64bit build

Logan Gunthorpe <logang@deltatee.com>
    scsi: isci: initialize shost fully before calling scsi_add_host()

YueHaibing <yuehaibing@huawei.com>
    scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix leaking object reference count

Alban Bedel <albeu@free.fr>
    MIPS: ath79: Enable OF serial ports in the default config

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

Vignesh R <vigneshr@ti.com>
    mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells

Eric Biggers <ebiggers@google.com>
    KEYS: allow reaching the keys quotas exactly

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

Rakesh Pillai <pillair@codeaurora.org>
    mac80211: Restore vif beacon interval if start ap fails

Paul Burton <paul.burton@mips.com>
    MIPS: eBPF: Always return sign extended 32b values

Quentin Perret <quentin.perret@arm.com>
    tracing: Fix number of entries in trace header

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/cache.h                       | 11 +++
 arch/arc/kernel/head.S                             | 14 +++-
 arch/arc/kernel/setup.c                            | 87 +++++++++++++++-------
 arch/arm/probes/kprobes/opt-arm.c                  |  2 +-
 arch/mips/configs/ath79_defconfig                  |  1 +
 arch/mips/jazz/jazzdma.c                           |  5 +-
 arch/mips/net/ebpf_jit.c                           |  9 ++-
 arch/parisc/kernel/ptrace.c                        | 29 ++++++--
 arch/x86/xen/enlighten_pv.c                        |  5 +-
 drivers/atm/he.c                                   |  2 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 | 12 +--
 drivers/gpu/drm/meson/meson_drv.c                  |  9 ++-
 drivers/hwmon/tmp421.c                             |  2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                | 10 ---
 drivers/isdn/hardware/avm/b1.c                     |  2 +-
 drivers/isdn/i4l/isdn_tty.c                        |  6 +-
 drivers/leds/leds-lp5523.c                         |  4 +-
 drivers/mfd/ab8500-core.c                          |  2 +-
 drivers/mfd/bd9571mwv.c                            |  1 +
 drivers/mfd/db8500-prcmu.c                         |  4 +-
 drivers/mfd/mc13xxx-core.c                         |  4 +-
 drivers/mfd/mt6397-core.c                          |  3 +-
 drivers/mfd/qcom_rpm.c                             |  4 +
 drivers/mfd/ti_am335x_tscadc.c                     |  5 +-
 drivers/mfd/tps65218.c                             | 24 +-----
 drivers/mfd/twl-core.c                             |  4 +-
 drivers/mfd/wm5110-tables.c                        |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         | 23 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 25 ++++---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 12 +--
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 10 +++
 drivers/net/phy/sfp-bus.c                          |  2 +
 drivers/net/phy/sfp.c                              | 30 +++++---
 drivers/net/phy/sfp.h                              |  2 +
 drivers/net/team/team.c                            | 27 ++-----
 drivers/phy/tegra/xusb.c                           |  2 +-
 drivers/pinctrl/pinctrl-max77620.c                 | 14 ++--
 drivers/scsi/isci/init.c                           | 14 ++--
 drivers/scsi/qedi/qedi_iscsi.c                     |  3 +
 drivers/scsi/qedi/qedi_iscsi.h                     |  1 +
 drivers/scsi/qla4xxx/ql4_os.c                      |  2 +
 drivers/scsi/ufs/ufshcd.c                          |  2 +
 drivers/xen/pvcalls-back.c                         |  9 +--
 fs/ceph/snap.c                                     |  3 +-
 fs/proc/base.c                                     |  4 -
 include/keys/user-type.h                           |  2 +-
 include/linux/qed/qed_chain.h                      | 31 ++++++++
 include/linux/sched/sysctl.h                       |  6 +-
 include/linux/skbuff.h                             |  2 +-
 include/linux/virtio_net.h                         | 19 +++++
 include/uapi/linux/inet_diag.h                     | 16 ++--
 kernel/trace/trace.c                               |  2 +
 mm/mempolicy.c                                     |  6 +-
 net/batman-adv/soft-interface.c                    |  2 +
 net/bridge/br_multicast.c                          |  9 +--
 net/ceph/messenger.c                               | 15 ++--
 net/core/filter.c                                  |  7 +-
 net/ipv4/inet_diag.c                               | 10 ++-
 net/ipv6/netfilter.c                               |  4 +-
 net/ipv6/seg6.c                                    |  4 +-
 net/ipv6/sit.c                                     |  3 +-
 net/mac80211/cfg.c                                 |  6 +-
 net/mac80211/mesh_pathtbl.c                        | 17 +++--
 net/netfilter/nf_tables_api.c                      |  5 ++
 net/netfilter/nft_compat.c                         |  3 +-
 net/packet/af_packet.c                             |  2 +-
 net/sctp/offload.c                                 |  1 +
 net/sctp/sctp_diag.c                               |  1 +
 security/keys/key.c                                |  4 +-
 security/keys/keyring.c                            |  4 +-
 security/keys/proc.c                               |  3 +-
 security/keys/request_key.c                        |  1 +
 security/keys/request_key_auth.c                   |  2 +-
 77 files changed, 417 insertions(+), 233 deletions(-)


