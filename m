Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D2BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415D421726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360199;
	bh=yof+pL7SXWRaFXNmElqP1hhehGEEM8GB3sz/QGBIi4E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WF3SCKgcExe7K8inM0/U1s4ndXs9OxHA9tL3CyTQcGs6xCTnQcfj3MvL/1hPh0pBg
	 1VRwE76FEDUaWqVet3bKqiZVa5LUzWWICevvJBboRkXSKuhtucNaUAUTxavWyw2Z//
	 QFkrguHRmEXP7p6oC3YAv+TnTIhUiFmAMhYbGD0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfAXUDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbfAXTcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:32:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B993218D4;
        Thu, 24 Jan 2019 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358354;
        bh=yof+pL7SXWRaFXNmElqP1hhehGEEM8GB3sz/QGBIi4E=;
        h=From:To:Cc:Subject:Date:From;
        b=DapsNFpno1ceZ08dCys5mJdapKSLBinE+RWuzUacxuLTnpNfIb191tYg6fh2jQNwc
         TYQnJDdXOTTY/eHSCXjjGmdO80JO91aBSLD0veSA/rJgHyZZB2OXq0HhWn8R+rSJ9r
         jQuds7ytRHqRz5kHM67TSR4jMUNQoHtWdaemzaPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/63] 4.14.96-stable review
Date:   Thu, 24 Jan 2019 20:19:49 +0100
Message-Id: <20190124190155.176570028@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.96-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.96-rc1
X-KernelTest-Deadline: 2019-01-26T19:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.96 release.
There are 63 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jan 26 19:01:15 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.96-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.96-rc1

Corey Minyard <cminyard@mvista.com>
    ipmi:ssif: Fix handling of multi-part return messages

Marc Zyngier <marc.zyngier@arm.com>
    PCI: dwc: Move interrupt acking into the proper callback

Zhenyu Wang <zhenyuw@linux.intel.com>
    drm/i915/gvt: Fix mmap range check

Steve French <stfrench@microsoft.com>
    cifs: allow disabling insecure dialects in the config

Corey Minyard <cminyard@mvista.com>
    ipmi:pci: Blacklist a Realtek "IPMI" device

Scott Mayhew <smayhew@redhat.com>
    nfs: fix a deadlock in nfs client initialization

Michal Hocko <mhocko@suse.com>
    mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps

Aaron Lu <aaron.lu@intel.com>
    mm/swap: use nr_node_ids for avail_lists in swap_info_struct

Brian Foster <bfoster@redhat.com>
    mm/page-writeback.c: don't break integrity writeback on ->writepage() error

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix panic due to unrecovered local alloc

Qian Cai <cai@lca.pw>
    scsi: megaraid: fix out-of-bound array accesses

Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
    scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()

Kevin Barnett <kevin.barnett@microsemi.com>
    scsi: smartpqi: correct lun reset issues

Parvi Kaustubhi <pkaustub@cisco.com>
    IB/usnic: Fix potential deadlock

Daniel Vetter <daniel.vetter@ffwll.ch>
    sysfs: Disable lockdep for driver bind/unbind files

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix model-id of unit for Apogee Ensemble

Yangtao Li <tiny.windzz@gmail.com>
    clocksource/drivers/integrator-ap: Add missing of_node_put()

Javier Barrio <javier.barrio.mart@gmail.com>
    quota: Lock s_umount in exclusive mode for Q_XQUOTA{ON,OFF} quotactls.

Nikos Tsironis <ntsironis@arrikto.com>
    dm snapshot: Fix excessive memory usage and workqueue stalls

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools lib subcmd: Don't add the kernel sources to the include path

Nikos Tsironis <ntsironis@arrikto.com>
    dm kcopyd: Fix bug causing workqueue stalls

AliOS system security <alios_sys_security@linux.alibaba.com>
    dm crypt: use u64 instead of sector_t to store iv_offset

Taehee Yoo <ap420073@gmail.com>
    netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is set

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf parse-events: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf svghelper: Fix unchecked usage of strncpy()

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error with config term "pt=0"

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    tty/serial: do not free trasnmit buffer page under port lock

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: improve error handling of btrfs_add_link

Jonas Danielsson <jonas@orbital-systems.com>
    mmc: atmel-mci: do not assume idle after atmci_request_end

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix memory leak when EOF is encountered in quotation

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix file name and line number of warn_ignored_character()

Will Deacon <will.deacon@arm.com>
    arm64: Fix minor issues with the dcache_by_line_op macro

Lucas Stach <l.stach@pengutronix.de>
    clk: imx6q: reset exclusive gates on init

Dmitry V. Levin <ldv@altlinux.org>
    selftests: do not macro-expand failed assertion expressions

David Disseldorp <ddiss@suse.de>
    scsi: target: use consistent left-aligned ASCII INQUIRY data

yupeng <yupeng0921@gmail.com>
    net: call sk_dst_reset when set SO_DONTROUTE

Vivek Gautam <vivek.gautam@codeaurora.org>
    media: venus: core: Set dma maximum segment size

Nathan Chancellor <natechancellor@gmail.com>
    media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Breno Leitao <leitao@debian.org>
    powerpc/pseries/cpuidle: Fix preempt warning

Breno Leitao <leitao@debian.org>
    powerpc/xmon: Fix invocation inside lock region

Joel Fernandes (Google) <joel@joelfernandes.org>
    pstore/ram: Do not treat empty buffers as valid

A.s. Dong <aisheng.dong@nxp.com>
    clk: imx: make mux parent strings const

Daniel Santos <daniel.santos@pobox.com>
    jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Chuck Lever <chuck.lever@oracle.com>
    rxe: IB_WR_REG_MR does not capture MR's iova field

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: always allow mounting submounts

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device

Anders Roxell <anders.roxell@linaro.org>
    arm64: perf: set suppress_bind_attrs flag to true

Maciej W. Rozycki <macro@linux-mips.org>
    MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Borislav Petkov <bp@suse.de>
    x86/mce: Fix -Wmissing-prototypes warnings

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: add support for APOGEE duet FireWire

Anders Roxell <anders.roxell@linaro.org>
    serial: set suppress_bind_attrs flag only if builtin

Anders Roxell <anders.roxell@linaro.org>
    writeback: don't decrement wb->refcnt if !wb->bdi

Miroslav Lichvar <mlichvar@redhat.com>
    e1000e: allow non-monotonic SYSTIM readings

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    gpio: pl061: Move irq_chip definition inside struct pl061

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88x6xxx: mv88e6390 errata

David Ahern <dsahern@gmail.com>
    ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Add support for new Realtek Ethernet

Daniele Palmas <dnlplm@gmail.com>
    qmi_wwan: add MTU default to qmap network interface

David Rientjes <rientjes@google.com>
    net, skbuff: do not prefer skb allocation fails early

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion

Jiri Pirko <jiri@mellanox.com>
    mlxsw: spectrum: Disable lag port TX before removing it

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address


-------------

Diffstat:

 Documentation/filesystems/proc.txt                 |   4 +-
 Makefile                                           |   4 +-
 arch/arm64/include/asm/assembler.h                 |  30 +++---
 arch/arm64/kernel/perf_event.c                     |   1 +
 arch/arm64/mm/cache.S                              |   3 +
 arch/mips/Kconfig                                  |   3 +
 arch/mips/sibyte/common/Makefile                   |   1 +
 arch/mips/sibyte/common/dma.c                      |  14 +++
 arch/powerpc/xmon/xmon.c                           |  18 +++-
 arch/x86/include/asm/traps.h                       |   6 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |   5 +-
 arch/x86/kernel/cpu/mcheck/therm_throt.c           |   3 +-
 arch/x86/kernel/cpu/mcheck/threshold.c             |   3 +-
 drivers/base/bus.c                                 |   7 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |  12 +++
 drivers/char/ipmi/ipmi_ssif.c                      |  25 +++--
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx6q.c                        |   6 +-
 drivers/clk/imx/clk.h                              |  18 ++--
 drivers/clocksource/timer-integrator-ap.c          |  25 +++--
 drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
 drivers/gpio/gpio-pl061.c                          |  21 ++--
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  21 +++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   1 +
 drivers/md/dm-crypt.c                              |   6 +-
 drivers/md/dm-kcopyd.c                             |  19 +++-
 drivers/md/dm-snap.c                               |  22 ++++
 drivers/media/firewire/firedtv-avc.c               |   6 +-
 drivers/media/firewire/firedtv.h                   |   6 +-
 drivers/media/platform/qcom/venus/core.c           |   8 ++
 drivers/mmc/host/atmel-mci.c                       |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   | 113 +++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                   |   5 +
 drivers/net/dsa/mv88e6xxx/port.h                   |  10 ++
 drivers/net/ethernet/intel/e1000e/ptp.c            |  13 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   7 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   2 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/pci/dwc/pcie-designware-host.c             |  15 ++-
 drivers/platform/x86/asus-wmi.c                    |   3 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   4 +
 drivers/target/target_core_spc.c                   |  17 +++-
 drivers/tty/serial/amba-pl011.c                    |   2 +
 drivers/tty/serial/pic32_uart.c                    |   1 +
 drivers/tty/serial/serial_core.c                   |  22 ++--
 drivers/tty/serial/xilinx_uartps.c                 |   1 +
 drivers/usb/gadget/udc/renesas_usb3.c              |  15 ++-
 fs/btrfs/inode.c                                   |   7 +-
 fs/cifs/Kconfig                                    |  17 +++-
 fs/cifs/connect.c                                  |   9 ++
 fs/jffs2/super.c                                   |   3 +-
 fs/nfs/client.c                                    |  11 ++
 fs/nfs/nfs4client.c                                |  17 +++-
 fs/ocfs2/localalloc.c                              |   9 +-
 fs/pstore/ram_core.c                               |   5 +
 fs/quota/quota.c                                   |   3 +-
 include/linux/backing-dev-defs.h                   |   8 ++
 include/linux/swap.h                               |  11 +-
 mm/page-writeback.c                                |  35 ++++---
 mm/swapfile.c                                      |   3 +-
 net/core/skbuff.c                                  |   7 +-
 net/core/sock.c                                    |   1 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   3 +-
 net/ipv6/af_inet6.c                                |  14 ++-
 scripts/kconfig/zconf.l                            |   4 +-
 security/selinux/hooks.c                           |   2 +-
 sound/firewire/Kconfig                             |   1 +
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/oxfw/oxfw.c                         |   8 ++
 tools/lib/subcmd/Makefile                          |   2 -
 tools/perf/arch/x86/util/intel-pt.c                |  11 ++
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/svghelper.c                        |   2 +-
 tools/testing/selftests/kselftest_harness.h        |  42 ++++----
 79 files changed, 624 insertions(+), 176 deletions(-)


