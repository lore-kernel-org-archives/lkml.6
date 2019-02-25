Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8517C2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129197;
	bh=FXNzc2C2qTVnXJh6LsVhN/PpSRZrWBP/ZEoIIBq2WM4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1GIT0JkP/6uPGcx92C2uq3YeXtyQzGfNOtA/noh0n6IHq+5MDNLFJTblkeyq8LANH
	 SUzRrO4kckAuw85h+3u5ZcpIy/uFotOQj+x9iREpw3OF+j61rLt22w2Q8vxAVQc/cq
	 Ulb7Y/NPyvhp0p2E8DNAWLKsdsQfdy42xf2sukNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfBYVNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfBYVNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:13:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F242213A2;
        Mon, 25 Feb 2019 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129192;
        bh=FXNzc2C2qTVnXJh6LsVhN/PpSRZrWBP/ZEoIIBq2WM4=;
        h=From:To:Cc:Subject:Date:From;
        b=t/tAPMjONatqnRYMziREd62uaEF5S1Q4zwYbuAi+gM8LtWWFZtNd57kML+TAsgFf8
         vu/6TRDvNy3xUXXes/u/DNy57Q60Vc5jXcPlx7JSVBq4i8wXFoUDzK7qUPDD67PeB9
         MEcMGGwtwEmVIa4jcOJsDDeSYR90UutLqItZjo+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/63] 4.9.161-stable review
Date:   Mon, 25 Feb 2019 22:11:00 +0100
Message-Id: <20190225195035.713274200@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.161-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.161-rc1
X-KernelTest-Deadline: 2019-02-27T19:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.161 release.
There are 63 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 27 19:50:06 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.161-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.161-rc1

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: consolidate Clang compiler flags

Matthias Kaehlcke <mka@chromium.org>
    sched/sysctl: Fix attributes of some extern declarations

Colin Ian King <colin.king@canonical.com>
    phy: tegra: remove redundant self assignment of 'map'

Nathan Chancellor <natechancellor@gmail.com>
    pinctrl: max77620: Use define directive for max77620_pinconf_param values

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix flush after rule deletion in the same batch

Hangbin Liu <liuhangbin@gmail.com>
    Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Nick Desaulniers <nick.desaulniers@gmail.com>
    mm/zsmalloc.c: fix -Wunneeded-internal-declaration warning

Matthias Kaehlcke <mka@chromium.org>
    mm/zsmalloc.c: change stat type parameter to int

Will Deacon <will.deacon@arm.com>
    irqchip/gic-v3: Convert arm64 GIC accessors to {read,write}_sysreg_s

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: add -no-integrated-as Clang option unconditionally

Stefan Agner <stefan@agner.ch>
    kbuild: set no-integrated-as before incl. arch Makefile

Sodagudi Prasad <psodagud@codeaurora.org>
    kbuild: clang: disable unused variable warnings only when constant

Nick Desaulniers <nick.desaulniers@gmail.com>
    kbuild: clang: remove crufty HOSTCFLAGS

David Lin <dtwlin@google.com>
    kbuild: clang: fix build failures with sparse check

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: move cc-option and cc-disable-warning after incl. arch Makefile

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix enum pipe vs. enum transcoder for the PCH transcoder

Matthias Kaehlcke <mka@chromium.org>
    drm/i915: Consistently use enum pipe for PCH transcoders

Matthias Kaehlcke <mka@chromium.org>
    x86/boot: Disable the address-of-packed-member compiler warning

Matthias Kaehlcke <mka@chromium.org>
    tracing: Use cpumask_available() to check if cpumask variable may be used

Matthias Kaehlcke <mka@chromium.org>
    netpoll: Fix device name check in netpoll_setup()

Matthias Kaehlcke <mka@chromium.org>
    clocksource: Use GENMASK_ULL in definition of CLOCKSOURCE_MASK

Matthias Kaehlcke <mka@chromium.org>
    hpet: Make cmd parameter of hpet_ioctl_common() unsigned

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: define ARCH_SLAB_MINALIGN = 8

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: U-boot: check arguments paranoidly

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: Enable unaligned access in early ASM code

Dmitry V. Levin <ldv@altlinux.org>
    parisc: Fix ptrace syscall number modification

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Xin Long <lucien.xin@gmail.com>
    sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment

Hangbin Liu <liuhangbin@gmail.com>
    sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Cong Wang <xiyou.wangcong@gmail.com>
    team: avoid complex list operations in team_nl_cmd_options_set()

Kal Conley <kal.conley@dectris.com>
    net/packet: fix 4gb buffer limit due to overflow check

Eric Dumazet <edumazet@google.com>
    batman-adv: fix uninit-value in batadv_interface_tx()

Eric Biggers <ebiggers@google.com>
    KEYS: always initialize keyring_index_key::desc_len

Eric Biggers <ebiggers@google.com>
    KEYS: user: Align the payload buffer

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Rework SCSI device reset handling

Michael Weiser <michael.weiser@gmx.de>
    net: ethernet: stmmac: change dma descriptors to __le32

Nathan Chancellor <natechancellor@gmail.com>
    isdn: avm: Fix string plus integer warning from Clang

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky

Kangjie Lu <kjlu@umn.edu>
    leds: lp5523: fix a missing check of return value of lp55xx_read

Colin Ian King <colin.king@canonical.com>
    atm: he: fix sign-extension overflow on large shift

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix PCI module removal leak

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: jazz: fix 64bit build

Logan Gunthorpe <logang@deltatee.com>
    scsi: isci: initialize shost fully before calling scsi_add_host()

YueHaibing <yuehaibing@huawei.com>
    scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

Alban Bedel <albeu@free.fr>
    MIPS: ath79: Enable OF serial ports in the default config

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix use after free identified by SLUB debug

Denis Bolotin <dbolotin@marvell.com>
    qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier

Kangjie Lu <kjlu@umn.edu>
    mfd: mc13xxx: Fix a missing check of a register-read failure

Charles Keepax <ckeepax@opensource.cirrus.com>
    mfd: wm5110: Add missing ASRC rate register

Jonathan Marek <jonathan@marek.ca>
    mfd: qcom_rpm: write fw_version to CTRL_REG

Dan Carpenter <dan.carpenter@oracle.com>
    mfd: ab8500-core: Return zero in get_register_interruptible()

Nicolas Boichat <drinkcat@chromium.org>
    mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Nathan Chancellor <natechancellor@gmail.com>
    mfd: db8500-prcmu: Fix some section annotations

Nathan Chancellor <natechancellor@gmail.com>
    mfd: twl-core: Fix section annotations on {,un}protect_pm_master

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


-------------

Diffstat:

 Makefile                                           | 60 +++++++--------
 arch/arc/include/asm/cache.h                       | 11 +++
 arch/arc/kernel/head.S                             | 14 +++-
 arch/arc/kernel/setup.c                            | 87 +++++++++++++++-------
 arch/arm64/include/asm/arch_gicv3.h                | 47 +++++-------
 arch/mips/configs/ath79_defconfig                  |  1 +
 arch/mips/jazz/jazzdma.c                           |  5 +-
 arch/parisc/kernel/ptrace.c                        | 29 ++++++--
 arch/x86/boot/compressed/Makefile                  |  1 +
 drivers/atm/he.c                                   |  2 +-
 drivers/char/hpet.c                                |  2 +-
 drivers/gpu/drm/i915/i915_irq.c                    | 10 +--
 drivers/gpu/drm/i915/intel_display.c               | 14 ++--
 drivers/gpu/drm/i915/intel_drv.h                   |  4 +-
 drivers/gpu/drm/i915/intel_fifo_underrun.c         | 24 +++---
 drivers/infiniband/ulp/srp/ib_srp.c                | 10 ---
 drivers/isdn/hardware/avm/b1.c                     |  2 +-
 drivers/isdn/i4l/isdn_tty.c                        |  6 +-
 drivers/leds/leds-lp5523.c                         |  4 +-
 drivers/mfd/ab8500-core.c                          |  2 +-
 drivers/mfd/db8500-prcmu.c                         |  4 +-
 drivers/mfd/mc13xxx-core.c                         |  4 +-
 drivers/mfd/mt6397-core.c                          |  3 +-
 drivers/mfd/qcom_rpm.c                             |  4 +
 drivers/mfd/ti_am335x_tscadc.c                     |  5 +-
 drivers/mfd/twl-core.c                             |  4 +-
 drivers/mfd/wm5110-tables.c                        |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         | 23 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  1 +
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 12 +--
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  4 +
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   | 55 +++++++-------
 drivers/net/ethernet/stmicro/stmmac/descs.h        | 20 ++---
 drivers/net/ethernet/stmicro/stmmac/descs_com.h    | 48 ++++++------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 62 +++++++--------
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     | 55 +++++++-------
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    | 48 ++++++------
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    | 39 +++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 51 +++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 10 +++
 drivers/net/team/team.c                            | 27 ++-----
 drivers/phy/tegra/xusb.c                           |  2 +-
 drivers/pinctrl/pinctrl-max77620.c                 | 14 ++--
 drivers/scsi/isci/init.c                           | 14 ++--
 drivers/scsi/qla4xxx/ql4_os.c                      |  2 +
 fs/ceph/snap.c                                     |  3 +-
 fs/proc/base.c                                     |  4 -
 include/keys/user-type.h                           |  2 +-
 include/linux/clocksource.h                        |  2 +-
 include/linux/sched/sysctl.h                       |  6 +-
 kernel/trace/trace.c                               |  5 +-
 mm/mempolicy.c                                     |  6 +-
 mm/zsmalloc.c                                      | 11 ++-
 net/batman-adv/soft-interface.c                    |  2 +
 net/bridge/br_multicast.c                          |  9 +--
 net/ceph/messenger.c                               | 15 ++--
 net/core/netpoll.c                                 |  2 +-
 net/ipv6/sit.c                                     |  3 +-
 net/mac80211/mesh_pathtbl.c                        | 17 +++--
 net/netfilter/nf_tables_api.c                      |  3 +
 net/packet/af_packet.c                             |  2 +-
 net/sctp/offload.c                                 |  1 +
 security/keys/key.c                                |  4 +-
 security/keys/keyring.c                            |  4 +-
 security/keys/proc.c                               |  3 +-
 security/keys/request_key.c                        |  1 +
 security/keys/request_key_auth.c                   |  2 +-
 68 files changed, 528 insertions(+), 433 deletions(-)


