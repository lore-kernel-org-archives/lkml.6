Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E913C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E2B21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359870;
	bh=BbDZHkRPS52AofZuHjzGuEdhB4l78JaDKKFM8Fin3Ak=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=espLon7+q/eeBXGJh1LhPYwyQaDskraOtHPtn8SP6noc5cGlPhur0Wu9/QyaXZ97J
	 3qT1aHD/OwDRs0IJuWwwwtLvHmUQMVrKc3u12mvTPYSTXVXK4pX4n8iaxmqoOXZCdu
	 n2gtEOguTwhcHnYSvl2p5dX3YiMAez0nWpngt0QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfAXTe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbfAXTew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E709218D4;
        Thu, 24 Jan 2019 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358489;
        bh=BbDZHkRPS52AofZuHjzGuEdhB4l78JaDKKFM8Fin3Ak=;
        h=From:To:Cc:Subject:Date:From;
        b=jT8tXd6Hybyn1f5pIMUEp1uBBvqLaBXp5GdpXQAhQuDbj+3bnz1xvOIpmEcQJ+U5b
         51i117Why3yx9wiARpKLPLm0uUeEblo7LD3/qN+113RHWs0om7blCWuKK38l9axzZk
         xfisIbTwuIjz0tw8DxFKoMCBs3I2olDQmPis3Xsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/106] 4.19.18-stable review
Date:   Thu, 24 Jan 2019 20:19:17 +0100
Message-Id: <20190124190206.342411005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.18-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.18-rc1
X-KernelTest-Deadline: 2019-01-26T19:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.18 release.
There are 106 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jan 26 19:01:18 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.18-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.18-rc1

Corey Minyard <cminyard@mvista.com>
    ipmi: Don't initialize anything in the core until something uses it

Corey Minyard <cminyard@mvista.com>
    ipmi:ssif: Fix handling of multi-part return messages

Fred Klassen <fklassen@appneta.com>
    ipmi: Prevent use-after-free in deliver_response

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ipmi: msghandler: Fix potential Spectre v1 vulnerabilities

Yang Yingliang <yangyingliang@huawei.com>
    ipmi: fix use-after-free of user->release_barrier.rda

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: Fix unnecessary error message for HCI request completion

Avraham Stern <avraham.stern@intel.com>
    iwlwifi: mvm: Send LQ command as async when necessary

Michal Hocko <mhocko@suse.com>
    mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps

Peter Xu <peterx@redhat.com>
    userfaultfd: clear flag if remap event not enabled

Aaron Lu <aaron.lu@intel.com>
    mm/swap: use nr_node_ids for avail_lists in swap_info_struct

Brian Foster <bfoster@redhat.com>
    mm/page-writeback.c: don't break integrity writeback on ->writepage() error

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix panic due to unrecovered local alloc

Eric Sandeen <sandeen@redhat.com>
    iomap: don't search past page end in iomap_is_partially_uptodate

Qian Cai <cai@lca.pw>
    scsi: megaraid: fix out-of-bound array accesses

Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
    scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()

Zhi Chen <zhichen@codeaurora.org>
    ath10k: fix peer stats null pointer dereference

Kevin Barnett <kevin.barnett@microsemi.com>
    scsi: smartpqi: correct lun reset issues

Stephan Günther <moepi@moepi.net>
    scsi: mpt3sas: fix memory ordering on 64bit writes

Parvi Kaustubhi <pkaustub@cisco.com>
    IB/usnic: Fix potential deadlock

Daniel Vetter <daniel.vetter@ffwll.ch>
    sysfs: Disable lockdep for driver bind/unbind files

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix model-id of unit for Apogee Ensemble

Raghuram Hegde <raghuram.hegde@intel.com>
    Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029

Milan Broz <gmazyland@gmail.com>
    dm: Check for device sector overflow if CONFIG_LBDAF is not set

Yangtao Li <tiny.windzz@gmail.com>
    clocksource/drivers/integrator-ap: Add missing of_node_put()

Javier Barrio <javier.barrio.mart@gmail.com>
    quota: Lock s_umount in exclusive mode for Q_XQUOTA{ON,OFF} quotactls.

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf tools: Add missing open_memstream() prototype for systems lacking it

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf tools: Add missing sigqueue() prototype for systems lacking it

Leo Yan <leo.yan@linaro.org>
    perf cs-etm: Correct packets swapping in cs_etm__flush()

Nikos Tsironis <ntsironis@arrikto.com>
    dm snapshot: Fix excessive memory usage and workqueue stalls

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools lib subcmd: Don't add the kernel sources to the include path

Michael Petlan <mpetlan@redhat.com>
    perf stat: Avoid segfaults caused by negated options

Nikos Tsironis <ntsironis@arrikto.com>
    dm kcopyd: Fix bug causing workqueue stalls

AliOS system security <alios_sys_security@linux.alibaba.com>
    dm crypt: use u64 instead of sector_t to store iv_offset

Hui Wang <john.wanghui@huawei.com>
    x86/topology: Use total_cpus for max logical packages calculation

Taehee Yoo <ap420073@gmail.com>
    netfilter: ipt_CLUSTERIP: fix deadlock in netns exit routine

Taehee Yoo <ap420073@gmail.com>
    netfilter: ipt_CLUSTERIP: remove wrong WARN_ON_ONCE in netns exit routine

Taehee Yoo <ap420073@gmail.com>
    netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is set

Andi Kleen <ak@linux.intel.com>
    perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf parse-events: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf svghelper: Fix unchecked usage of strncpy()

Florian Fainelli <f.fainelli@gmail.com>
    perf tests ARM: Disable breakpoint tests 32-bit

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error with config term "pt=0"

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    tty/serial: do not free trasnmit buffer page under port lock

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: improve error handling of btrfs_add_link

Anand Jain <anand.jain@oracle.com>
    btrfs: fix use-after-free due to race between replace start and cancel

Hans van Kranenburg <hans.van.kranenburg@mendix.com>
    btrfs: alloc_chunk: fix more DUP stripe size handling

Qu Wenruo <wqu@suse.com>
    btrfs: volumes: Make sure there is no overlap of dev extents at mount time

Jonas Danielsson <jonas@orbital-systems.com>
    mmc: atmel-mci: do not assume idle after atmci_request_end

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix memory leak when EOF is encountered in quotation

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix file name and line number of warn_ignored_character()

Jiong Wang <jiong.wang@netronome.com>
    bpf: relax verifier restriction on BPF_MOV | BPF_ALU

Will Deacon <will.deacon@arm.com>
    arm64: Fix minor issues with the dcache_by_line_op macro

Lucas Stach <l.stach@pengutronix.de>
    clk: imx6q: reset exclusive gates on init

Qian Cai <cai@lca.pw>
    arm64: kasan: Increase stack size for KASAN_EXTRA

Dmitry V. Levin <ldv@altlinux.org>
    selftests: do not macro-expand failed assertion expressions

Bart Van Assche <bvanassche@acm.org>
    scsi: target/core: Make sure that target_wait_for_sess_cmds() waits long enough

David Disseldorp <ddiss@suse.de>
    scsi: target: use consistent left-aligned ASCII INQUIRY data

yupeng <yupeng0921@gmail.com>
    net: call sk_dst_reset when set SO_DONTROUTE

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix use-after-free of on-stack `z_erofs_vle_unzip_io'

Vivek Gautam <vivek.gautam@codeaurora.org>
    media: venus: core: Set dma maximum segment size

Yu Zhao <yuzhao@google.com>
    ASoC: use dma_ops of parent device for acp_audio_dma

Nathan Chancellor <natechancellor@gmail.com>
    media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Breno Leitao <leitao@debian.org>
    powerpc/pseries/cpuidle: Fix preempt warning

Breno Leitao <leitao@debian.org>
    powerpc/xmon: Fix invocation inside lock region

Daniel Axtens <dja@axtens.net>
    media: uvcvideo: Refactor teardown of uvc on USB disconnect

Joel Fernandes (Google) <joel@joelfernandes.org>
    pstore/ram: Do not treat empty buffers as valid

A.s. Dong <aisheng.dong@nxp.com>
    clk: imx: make mux parent strings const

Daniel Santos <daniel.santos@pobox.com>
    jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Nathan Chancellor <natechancellor@gmail.com>
    efi/libstub: Disable some warnings for x86{,_64}

Chuck Lever <chuck.lever@oracle.com>
    rxe: IB_WR_REG_MR does not capture MR's iova field

Chris Wilson <chris@chris-wilson.co.uk>
    drm/amdgpu: Reorder uvd ring init before uvd resume

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qedi: Check for session online before getting iSCSI TLV data.

Jiada Wang <jiada_wang@mentor.com>
    ASoC: pcm3168a: Don't disable pcm3168a when CONFIG_PM defined

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: always allow mounting submounts

Anatolij Gustschin <agust@denx.de>
    fpga: altera-cvp: fix probing for multiple FPGAs on the bus

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device

Daniel T. Lee <danieltimlee@gmail.com>
    samples: bpf: fix: error handling regarding kprobe_events

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: meson8b: fix incorrect divider mapping in cpu_scale_table

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic-helper: Complete fake_commit->flip_done potentially earlier

Anders Roxell <anders.roxell@linaro.org>
    arm64: perf: set suppress_bind_attrs flag to true

Vitaly Chikunov <vt@altlinux.org>
    crypto: ecc - regularize scalar for scalar multiplication

Maciej W. Rozycki <macro@linux-mips.org>
    MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Borislav Petkov <bp@suse.de>
    x86/mce: Fix -Wmissing-prototypes warnings

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: add support for APOGEE duet FireWire

Andrey Ignatov <rdna@fb.com>
    bpf: Allow narrow loads with offset > 0

Anders Roxell <anders.roxell@linaro.org>
    serial: set suppress_bind_attrs flag only if builtin

Anders Roxell <anders.roxell@linaro.org>
    writeback: don't decrement wb->refcnt if !wb->bdi

Frank Rowand <frank.rowand@sony.com>
    of: overlay: add missing of_node_put() after add new node to changeset

Quentin Monnet <quentin.monnet@netronome.com>
    selftests/bpf: enable (uncomment) all tests in test_libbpf.sh

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tcpm: Do not disconnect link for self powered devices

Miroslav Lichvar <mlichvar@redhat.com>
    e1000e: allow non-monotonic SYSTIM readings

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey

Shannon Nelson <shannon.nelson@oracle.com>
    ixgbe: allow IPsec Tx offload in VEPA mode

Christian König <christian.koenig@amd.com>
    drm/amdkfd: fix interrupt spin lock

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Guard against null stream_state in set_crc_source

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    gpio: pl061: Move irq_chip definition inside struct pl061

Stefano Brivio <sbrivio@redhat.com>
    netfilter: ipset: Allow matching on destination MAC address for mac and ipmac sets

Paolo Abeni <pabeni@redhat.com>
    net: clear skb->tstamp in bridge forwarding path

David Ahern <dsahern@gmail.com>
    ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Add support for new Realtek Ethernet

Daniele Palmas <dnlplm@gmail.com>
    qmi_wwan: add MTU default to qmap network interface

David Rientjes <rientjes@google.com>
    net, skbuff: do not prefer skb allocation fails early

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88x6xxx: mv88e6390 errata

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
 arch/arm64/include/asm/assembler.h                 |  30 ++--
 arch/arm64/include/asm/memory.h                    |   7 +-
 arch/arm64/kernel/perf_event.c                     |   1 +
 arch/arm64/mm/cache.S                              |   3 +
 arch/mips/Kconfig                                  |   3 +
 arch/mips/sibyte/common/Makefile                   |   1 +
 arch/mips/sibyte/common/dma.c                      |  14 ++
 arch/powerpc/xmon/xmon.c                           |  18 ++-
 arch/x86/include/asm/traps.h                       |   6 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |   5 +-
 arch/x86/kernel/cpu/mcheck/therm_throt.c           |   3 +-
 arch/x86/kernel/cpu/mcheck/threshold.c             |   3 +-
 arch/x86/kernel/smpboot.c                          |   2 +-
 crypto/ecc.c                                       |  16 +-
 drivers/base/bus.c                                 |   7 +-
 drivers/bluetooth/btusb.c                          |  72 +++++----
 drivers/char/ipmi/ipmi_msghandler.c                | 178 ++++++++++++---------
 drivers/char/ipmi/ipmi_ssif.c                      |  25 ++-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx6q.c                        |   6 +-
 drivers/clk/imx/clk.h                              |  18 ++-
 drivers/clk/meson/meson8b.c                        |  15 +-
 drivers/clocksource/timer-integrator-ap.c          |  25 +--
 drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
 drivers/firmware/efi/libstub/Makefile              |   5 +-
 drivers/fpga/altera-cvp.c                          |  34 ++--
 drivers/gpio/gpio-pl061.c                          |  21 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   5 +
 drivers/gpu/drm/drm_atomic_helper.c                |   3 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   1 +
 drivers/md/dm-crypt.c                              |   8 +-
 drivers/md/dm-delay.c                              |   2 +-
 drivers/md/dm-flakey.c                             |   2 +-
 drivers/md/dm-kcopyd.c                             |  19 ++-
 drivers/md/dm-linear.c                             |   2 +-
 drivers/md/dm-raid1.c                              |   3 +-
 drivers/md/dm-snap.c                               |  22 +++
 drivers/md/dm-unstripe.c                           |   2 +-
 drivers/media/firewire/firedtv-avc.c               |   6 +-
 drivers/media/firewire/firedtv.h                   |   6 +-
 drivers/media/platform/qcom/venus/core.c           |   8 +
 drivers/media/usb/uvc/uvc_driver.c                 |  13 +-
 drivers/media/usb/uvc/uvc_status.c                 |  12 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   1 +
 drivers/mmc/host/atmel-mci.c                       |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   | 113 +++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                   |   5 +
 drivers/net/dsa/mv88e6xxx/port.h                   |  10 ++
 drivers/net/ethernet/intel/e1000e/ptp.c            |  13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   7 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   2 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |   2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  18 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   7 +-
 drivers/of/overlay.c                               |   4 +-
 drivers/platform/x86/asus-wmi.c                    |   3 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   3 +-
 drivers/scsi/qedi/qedi_main.c                      |   3 +
 drivers/scsi/smartpqi/smartpqi_init.c              |   4 +
 drivers/staging/erofs/unzip_vle.c                  |  13 +-
 drivers/target/target_core_spc.c                   |  17 +-
 drivers/target/target_core_transport.c             |  35 ++--
 drivers/target/target_core_xcopy.c                 |   6 +-
 drivers/tty/serial/amba-pl011.c                    |   2 +
 drivers/tty/serial/pic32_uart.c                    |   1 +
 drivers/tty/serial/serial_core.c                   |  22 ++-
 drivers/tty/serial/xilinx_uartps.c                 |   1 +
 drivers/usb/gadget/udc/renesas_usb3.c              |  15 +-
 drivers/usb/typec/tcpm.c                           |  12 +-
 fs/btrfs/dev-replace.c                             |  63 +++++---
 fs/btrfs/inode.c                                   |   7 +-
 fs/btrfs/volumes.c                                 |  30 ++--
 fs/iomap.c                                         |  17 +-
 fs/jffs2/super.c                                   |   3 +-
 fs/ocfs2/localalloc.c                              |   9 +-
 fs/pstore/ram_core.c                               |   5 +
 fs/quota/quota.c                                   |   3 +-
 fs/userfaultfd.c                                   |  10 +-
 include/linux/backing-dev-defs.h                   |   8 +
 include/linux/filter.h                             |  16 +-
 include/linux/swap.h                               |  11 +-
 include/linux/usb/tcpm.h                           |   1 +
 include/target/target_core_base.h                  |   1 +
 include/target/target_core_fabric.h                |   2 +-
 kernel/bpf/verifier.c                              |  37 +++--
 mm/page-writeback.c                                |  35 ++--
 mm/swapfile.c                                      |   3 +-
 net/bluetooth/hci_event.c                          |   6 +
 net/bridge/br_forward.c                            |   1 +
 net/core/skbuff.c                                  |   7 +-
 net/core/sock.c                                    |   1 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 | 159 ++++++++++--------
 net/ipv6/af_inet6.c                                |  14 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c          |  10 +-
 net/netfilter/ipset/ip_set_hash_ipmac.c            |  16 +-
 net/netfilter/ipset/ip_set_hash_mac.c              |  10 +-
 samples/bpf/bpf_load.c                             |  33 ++--
 scripts/kconfig/zconf.l                            |   4 +-
 security/selinux/hooks.c                           |   2 +-
 sound/firewire/Kconfig                             |   1 +
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/oxfw/oxfw.c                         |   8 +
 sound/soc/amd/acp-pcm-dma.c                        |   7 +-
 sound/soc/codecs/pcm3168a.c                        |  18 ++-
 tools/lib/subcmd/Makefile                          |   2 -
 tools/perf/Makefile.config                         |   2 +
 tools/perf/arch/x86/util/intel-pt.c                |  11 ++
 tools/perf/builtin-stat.c                          |   8 +-
 tools/perf/builtin-timechart.c                     |   4 +
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   2 +-
 tools/perf/tests/bp_signal.c                       |  20 ++-
 tools/perf/util/cs-etm.c                           |   2 +-
 tools/perf/util/evlist.c                           |   4 +
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/svghelper.c                        |   2 +-
 tools/testing/selftests/bpf/Makefile               |  10 ++
 tools/testing/selftests/bpf/test_libbpf.sh         |  14 +-
 tools/testing/selftests/bpf/test_verifier.c        |  13 ++
 tools/testing/selftests/kselftest_harness.h        |  42 ++---
 138 files changed, 1191 insertions(+), 556 deletions(-)


