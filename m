Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50478C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D8E218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548495117;
	bh=+HZyirj7erUkqrc5+hDYRFLVobwCCdNKVdvVH9BdgIY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sSNQ9MekCkndI365BDpK/pqVn/Vaos+8V+JhIhTjnI7k+MzzwOKHuu8vVaVMwbCJE
	 ZOL5sPW70mL5WbkRETs8y4+G16uyQD99oiQOiAXaq3pOzOs1wzsHpdos+ixG48yjRJ
	 2Q6o9ETCD5LDiCC7GhMy92B1u15IqyiW6y2UQO8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfAZJbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfAZJby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:31:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACC7218F0;
        Sat, 26 Jan 2019 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548495113;
        bh=+HZyirj7erUkqrc5+hDYRFLVobwCCdNKVdvVH9BdgIY=;
        h=Date:From:To:Cc:Subject:From;
        b=MuO05cow0CJih3S+gE9CQDpnObfhs0DaPUDmVai4+PdKt3hPjV6NVfTJYy1OISYnM
         rlnbeDHFIegI8kcYliN2AGIzcSz+B3qnZ0MB22Zaxd9+ir17jCu9QuRzHXUeyDrRzt
         XOrvx0XGIE3qeDELapKJLOg2CzEizRGBJtxTK8Q4=
Date:   Sat, 26 Jan 2019 10:31:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.5
Message-ID: <20190126093151.GA23783@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.5 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/filesystems/proc.txt                        |    4=20
 Makefile                                                  |   15 -
 arch/arm64/Makefile                                       |    2=20
 arch/arm64/include/asm/assembler.h                        |   30 +-
 arch/arm64/include/asm/memory.h                           |    7=20
 arch/arm64/kernel/cpu_errata.c                            |    6=20
 arch/arm64/kernel/perf_event.c                            |    1=20
 arch/arm64/kernel/vmlinux.lds.S                           |    9=20
 arch/arm64/mm/cache.S                                     |    3=20
 arch/arm64/mm/kasan_init.c                                |    2=20
 arch/mips/Kconfig                                         |    3=20
 arch/mips/include/asm/cpu.h                               |    3=20
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h |    4=20
 arch/mips/kernel/cpu-probe.c                              |    3=20
 arch/mips/kernel/idle.c                                   |    2=20
 arch/mips/loongson64/common/env.c                         |    3=20
 arch/mips/loongson64/loongson-3/smp.c                     |    3=20
 arch/mips/mm/c-r4k.c                                      |    2=20
 arch/mips/sibyte/common/Makefile                          |    1=20
 arch/mips/sibyte/common/dma.c                             |   14 +
 arch/powerpc/kvm/book3s_hv_nested.c                       |    5=20
 arch/powerpc/xmon/xmon.c                                  |   18 +
 arch/x86/include/asm/traps.h                              |    6=20
 arch/x86/kernel/cpu/intel_rdt.c                           |    2=20
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c               |    2=20
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c                  |    2=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                      |    5=20
 arch/x86/kernel/cpu/mcheck/therm_throt.c                  |    3=20
 arch/x86/kernel/cpu/mcheck/threshold.c                    |    3=20
 arch/x86/kernel/smpboot.c                                 |    2=20
 crypto/ecc.c                                              |   16 -
 drivers/base/bus.c                                        |    7=20
 drivers/bluetooth/btusb.c                                 |   72 ++---
 drivers/char/ipmi/ipmi_msghandler.c                       |  173 ++++++++-=
-----
 drivers/char/ipmi/ipmi_ssif.c                             |   25 +-
 drivers/clk/imx/clk-busy.c                                |    2=20
 drivers/clk/imx/clk-fixup-mux.c                           |    2=20
 drivers/clk/imx/clk-imx6q.c                               |    6=20
 drivers/clk/imx/clk.h                                     |   18 -
 drivers/clk/meson/meson8b.c                               |   20 +
 drivers/clocksource/timer-integrator-ap.c                 |   25 +-
 drivers/cpuidle/cpuidle-pseries.c                         |    8=20
 drivers/firmware/efi/libstub/Makefile                     |    5=20
 drivers/fpga/altera-cvp.c                                 |   34 +-
 drivers/gpio/gpio-pl061.c                                 |   21 -
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                     |    8=20
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                     |    8=20
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                     |    8=20
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                     |    8=20
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                   |    5=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c     |    5=20
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c          |    2=20
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c         |    2=20
 drivers/gpu/drm/drm_atomic_helper.c                       |    3=20
 drivers/gpu/drm/scheduler/sched_main.c                    |   17 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c           |    2=20
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c              |   11=20
 drivers/infiniband/sw/rxe/rxe_req.c                       |    1=20
 drivers/md/dm-crypt.c                                     |    8=20
 drivers/md/dm-delay.c                                     |    2=20
 drivers/md/dm-flakey.c                                    |    2=20
 drivers/md/dm-kcopyd.c                                    |   19 +
 drivers/md/dm-linear.c                                    |    2=20
 drivers/md/dm-raid1.c                                     |    3=20
 drivers/md/dm-snap.c                                      |   22 +
 drivers/md/dm-unstripe.c                                  |    2=20
 drivers/media/firewire/firedtv-avc.c                      |    6=20
 drivers/media/firewire/firedtv.h                          |    6=20
 drivers/media/platform/qcom/venus/core.c                  |    8=20
 drivers/media/usb/uvc/uvc_driver.c                        |   13 -
 drivers/media/usb/uvc/uvc_status.c                        |   12=20
 drivers/media/usb/uvc/uvcvideo.h                          |    1=20
 drivers/mmc/host/atmel-mci.c                              |    3=20
 drivers/net/dsa/mv88e6xxx/chip.c                          |  113 +++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                          |    5=20
 drivers/net/dsa/mv88e6xxx/port.h                          |   10=20
 drivers/net/ethernet/intel/e1000e/ptp.c                   |   13 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c            |    4=20
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c           |    4=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            |    7=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c  |    2=20
 drivers/net/ethernet/realtek/r8169.c                      |    2=20
 drivers/net/ethernet/socionext/sni_ave.c                  |    6=20
 drivers/net/usb/qmi_wwan.c                                |    1=20
 drivers/net/wireless/ath/ath10k/debugfs_sta.c             |    2=20
 drivers/net/wireless/ath/ath10k/htt_rx.c                  |    4=20
 drivers/net/wireless/quantenna/qtnfmac/commands.c         |   21 +
 drivers/of/overlay.c                                      |    4=20
 drivers/platform/mips/cpu_hwmon.c                         |    3=20
 drivers/platform/x86/asus-wmi.c                           |    3=20
 drivers/scsi/megaraid/megaraid_sas_fp.c                   |    2=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c               |    2=20
 drivers/scsi/mpt3sas/mpt3sas_base.c                       |    3=20
 drivers/scsi/qedi/qedi_main.c                             |    3=20
 drivers/scsi/smartpqi/smartpqi_init.c                     |    4=20
 drivers/staging/erofs/unzip_vle.c                         |   13 -
 drivers/target/target_core_spc.c                          |   17 -
 drivers/target/target_core_transport.c                    |   35 ++
 drivers/target/target_core_xcopy.c                        |    6=20
 drivers/tty/serial/amba-pl011.c                           |    2=20
 drivers/tty/serial/pic32_uart.c                           |    1=20
 drivers/tty/serial/serial_core.c                          |   22 +
 drivers/tty/serial/xilinx_uartps.c                        |    1=20
 drivers/usb/dwc2/gadget.c                                 |   41 +--
 drivers/usb/gadget/udc/renesas_usb3.c                     |   15 -
 drivers/usb/typec/tcpm/tcpm.c                             |   12=20
 fs/btrfs/dev-replace.c                                    |   63 +++--
 fs/btrfs/inode.c                                          |    7=20
 fs/btrfs/volumes.c                                        |   30 +-
 fs/iomap.c                                                |   17 +
 fs/jffs2/super.c                                          |    3=20
 fs/ocfs2/localalloc.c                                     |    9=20
 fs/pstore/ram_core.c                                      |    5=20
 fs/quota/quota.c                                          |    3=20
 fs/userfaultfd.c                                          |   10=20
 include/linux/backing-dev-defs.h                          |    8=20
 include/linux/filter.h                                    |   16 -
 include/linux/memblock.h                                  |    1=20
 include/linux/swap.h                                      |   11=20
 include/linux/usb/tcpm.h                                  |    1=20
 include/sound/soc.h                                       |    2=20
 include/target/target_core_base.h                         |    1=20
 include/target/target_core_fabric.h                       |    2=20
 kernel/bpf/verifier.c                                     |   37 ++
 mm/memblock.c                                             |   19 -
 mm/page-writeback.c                                       |   35 +-
 mm/swapfile.c                                             |    3=20
 net/bluetooth/hci_event.c                                 |    6=20
 net/bridge/br_forward.c                                   |    1=20
 net/core/skbuff.c                                         |    7=20
 net/core/sock.c                                           |    1=20
 net/ipv4/devinet.c                                        |    2=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                        |  159 +++++++--=
---
 net/ipv6/addrconf.c                                       |    2=20
 net/ipv6/af_inet6.c                                       |   14 +
 net/ipv6/ip6_fib.c                                        |    6=20
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                 |   10=20
 net/netfilter/ipset/ip_set_hash_ipmac.c                   |   16 -
 net/netfilter/ipset/ip_set_hash_mac.c                     |   10=20
 net/openvswitch/flow.c                                    |    8=20
 samples/bpf/bpf_load.c                                    |   33 +-
 scripts/Kbuild.include                                    |   10=20
 scripts/Makefile.build                                    |   12=20
 scripts/kconfig/zconf.l                                   |    4=20
 security/selinux/hooks.c                                  |    2=20
 sound/firewire/Kconfig                                    |    1=20
 sound/firewire/bebob/bebob.c                              |    2=20
 sound/firewire/oxfw/oxfw.c                                |    8=20
 sound/soc/amd/acp-pcm-dma.c                               |    7=20
 sound/soc/codecs/pcm3168a.c                               |   18 -
 sound/soc/codecs/wm9705.c                                 |   10=20
 sound/soc/codecs/wm9712.c                                 |   10=20
 sound/soc/codecs/wm9713.c                                 |   10=20
 tools/lib/subcmd/Makefile                                 |    2=20
 tools/lib/traceevent/event-parse.c                        |   10=20
 tools/perf/Makefile.config                                |    2=20
 tools/perf/arch/x86/util/intel-pt.c                       |   11=20
 tools/perf/builtin-stat.c                                 |    8=20
 tools/perf/builtin-timechart.c                            |    4=20
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json   |    2=20
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json  |    2=20
 tools/perf/tests/bp_signal.c                              |   20 +
 tools/perf/util/cs-etm.c                                  |    2=20
 tools/perf/util/evlist.c                                  |    4=20
 tools/perf/util/parse-events.c                            |    2=20
 tools/perf/util/svghelper.c                               |    2=20
 tools/testing/selftests/bpf/Makefile                      |   10=20
 tools/testing/selftests/bpf/test_libbpf.sh                |   14 -
 tools/testing/selftests/bpf/test_verifier.c               |   13 +
 tools/testing/selftests/kselftest_harness.h               |   42 +--
 170 files changed, 1329 insertions(+), 644 deletions(-)

A.s. Dong (1):
      clk: imx: make mux parent strings const

Aaron Lu (1):
      mm/swap: use nr_node_ids for avail_lists in swap_info_struct

Adrian Hunter (2):
      tools lib traceevent: Fix compile warnings in tools/lib/traceevent/ev=
ent-parse.c
      perf intel-pt: Fix error with config term "pt=3D0"

AliOS system security (1):
      dm crypt: use u64 instead of sector_t to store iv_offset

Anand Jain (1):
      btrfs: fix use-after-free due to race between replace start and cancel

Anatolij Gustschin (1):
      fpga: altera-cvp: fix probing for multiple FPGAs on the bus

Anders Roxell (3):
      writeback: don't decrement wb->refcnt if !wb->bdi
      serial: set suppress_bind_attrs flag only if builtin
      arm64: perf: set suppress_bind_attrs flag to true

Andi Kleen (1):
      perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX

Andrew Lunn (1):
      net: dsa: mv88x6xxx: mv88e6390 errata

Andrey Ignatov (1):
      bpf: Allow narrow loads with offset > 0

Ard Biesheuvel (1):
      arm64: relocatable: fix inconsistencies in linker script and options

Arnaldo Carvalho de Melo (5):
      perf svghelper: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()
      tools lib subcmd: Don't add the kernel sources to the include path
      perf tools: Add missing sigqueue() prototype for systems lacking it
      perf tools: Add missing open_memstream() prototype for systems lackin=
g it

Arnd Bergmann (1):
      ASoC: wm97xx: fix uninitialized regmap pointer problem

Arthur Gautier (1):
      netlink: fixup regression in RTM_GETADDR

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Do not disconnect link for self powered devices

Bart Van Assche (1):
      scsi: target/core: Make sure that target_wait_for_sess_cmds() waits l=
ong enough

Borislav Petkov (1):
      x86/mce: Fix -Wmissing-prototypes warnings

Breno Leitao (2):
      powerpc/xmon: Fix invocation inside lock region
      powerpc/pseries/cpuidle: Fix preempt warning

Brian Foster (1):
      mm/page-writeback.c: don't break integrity writeback on ->writepage()=
 error

Chris Wilson (1):
      drm/amdgpu: Reorder uvd ring init before uvd resume

Christian K=F6nig (1):
      drm/amdkfd: fix interrupt spin lock

Christophe JAILLET (1):
      octeontx2-af: Fix a resource leak in an error handling path in 'cgx_p=
robe()'

Chuck Lever (1):
      rxe: IB_WR_REG_MR does not capture MR's iova field

Corey Minyard (2):
      ipmi: Don't initialize anything in the core until something uses it
      ipmi:ssif: Fix handling of multi-part return messages

Daniel Axtens (1):
      media: uvcvideo: Refactor teardown of uvc on USB disconnect

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Daniel T. Lee (1):
      samples: bpf: fix: error handling regarding kprobe_events

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

Daniele Palmas (1):
      qmi_wwan: add MTU default to qmap network interface

David Ahern (3):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped a=
ddress
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses
      ipv6: Fix dump of specific table with strict checking

David Disseldorp (1):
      scsi: target: use consistent left-aligned ASCII INQUIRY data

David Rientjes (1):
      net, skbuff: do not prefer skb allocation fails early

Dmitry V. Levin (1):
      selftests: do not macro-expand failed assertion expressions

Eric Sandeen (1):
      iomap: don't search past page end in iomap_is_partially_uptodate

Florian Fainelli (1):
      perf tests ARM: Disable breakpoint tests 32-bit

Frank Rowand (1):
      of: overlay: add missing of_node_put() after add new node to changeset

Fred Klassen (1):
      ipmi: Prevent use-after-free in deliver_response

Gao Xiang (1):
      staging: erofs: fix use-after-free of on-stack `z_erofs_vle_unzip_io'

Greg Kroah-Hartman (1):
      Linux 4.20.5

Gustavo A. R. Silva (1):
      ipmi: msghandler: Fix potential Spectre v1 vulnerabilities

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix more DUP stripe size handling

Huacai Chen (1):
      MIPS: Loongson: Add Loongson-3A R2.1 basic support

Hui Wang (1):
      x86/topology: Use total_cpus for max logical packages calculation

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion

James Morse (1):
      arm64: Use a raw spinlock in __install_bp_hardening_cb()

Javier Barrio (1):
      quota: Lock s_umount in exclusive mode for Q_XQUOTA{ON,OFF} quotactls.

Jiada Wang (1):
      ASoC: pcm3168a: Don't disable pcm3168a when CONFIG_PM defined

Jiong Wang (1):
      bpf: relax verifier restriction on BPF_MOV | BPF_ALU

Jiri Pirko (1):
      mlxsw: spectrum: Disable lag port TX before removing it

Joel Fernandes (Google) (1):
      pstore/ram: Do not treat empty buffers as valid

Johan Hedberg (1):
      Bluetooth: Fix unnecessary error message for HCI request completion

Johannes Thumshirn (1):
      btrfs: improve error handling of btrfs_add_link

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Tell the EC the OS will handle the display of=
f hotkey

Junxiao Bi (1):
      ocfs2: fix panic due to unrecovered local alloc

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kevin Barnett (1):
      scsi: smartpqi: correct lun reset issues

Kunihiko Hayashi (1):
      net: ethernet: ave: Set initial wol state to disabled

Leo Yan (2):
      coresight: tmc: Fix bad register address for CLAIM
      perf cs-etm: Correct packets swapping in cs_etm__flush()

Lucas Stach (1):
      clk: imx6q: reset exclusive gates on init

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Manish Rangankar (1):
      scsi: qedi: Check for session online before getting iSCSI TLV data.

Manivannan Sadhasivam (1):
      gpio: pl061: Move irq_chip definition inside struct pl061

Martin Blumenstingl (2):
      clk: meson: meson8b: add support for more M/N values in sys_pll
      clk: meson: meson8b: fix incorrect divider mapping in cpu_scale_table

Masahiro Yamada (3):
      kbuild: let fixdep directly write to .*.cmd files
      kconfig: fix file name and line number of warn_ignored_character()
      kconfig: fix memory leak when EOF is encountered in quotation

Michael Petlan (1):
      perf stat: Avoid segfaults caused by negated options

Michal Hocko (1):
      mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/sma=
ps

Milan Broz (1):
      dm: Check for device sector overflow if CONFIG_LBDAF is not set

Minas Harutyunyan (1):
      usb: dwc2: Fix disable all EP's on disconnect

Miroslav Lichvar (1):
      e1000e: allow non-monotonic SYSTIM readings

Nathan Chancellor (2):
      efi/libstub: Disable some warnings for x86{,_64}
      media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Nicholas Kazlauskas (2):
      drm/amd/display: Guard against null stream_state in set_crc_source
      drm/amd/display: Fix disabled cursor on top screen edge

Nikos Tsironis (2):
      dm kcopyd: Fix bug causing workqueue stalls
      dm snapshot: Fix excessive memory usage and workqueue stalls

Ondrej Mosnacek (1):
      selinux: always allow mounting submounts

Paolo Abeni (1):
      net: clear skb->tstamp in bridge forwarding path

Parvi Kaustubhi (1):
      IB/usnic: Fix potential deadlock

Peter Xu (1):
      userfaultfd: clear flag if remap event not enabled

Qian Cai (3):
      arm64: kasan: Increase stack size for KASAN_EXTRA
      scsi: megaraid: fix out-of-bound array accesses
      mm/memblock.c: skip kmemleak for kasan_init()

Qu Wenruo (1):
      btrfs: volumes: Make sure there is no overlap of dev extents at mount=
 time

Quentin Monnet (1):
      selftests/bpf: enable (uncomment) all tests in test_libbpf.sh

Raghuram Hegde (1):
      Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029

Reinette Chatre (1):
      x86/resctrl: Fix rdt_find_domain() return value and checks

Sergey Matyukevich (1):
      qtnfmac: fix error handling in control path

Sergey Senozhatsky (1):
      tty/serial: do not free trasnmit buffer page under port lock

Shannon Nelson (1):
      ixgbe: allow IPsec Tx offload in VEPA mode

Stefano Brivio (1):
      netfilter: ipset: Allow matching on destination MAC address for mac a=
nd ipmac sets

Stephan G=FCnther (1):
      scsi: mpt3sas: fix memory ordering on 64bit writes

Suraj Jitindar Singh (2):
      KVM: PPC: Book3S HV: Align gfn to L1 page size when inserting nest-rm=
ap entry
      KVM: PPC: Book3S HV: Apply combination of host and l1 pte rc for nest=
ed guest

Taehee Yoo (3):
      netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is =
set
      netfilter: ipt_CLUSTERIP: remove wrong WARN_ON_ONCE in netns exit rou=
tine
      netfilter: ipt_CLUSTERIP: fix deadlock in netns exit routine

Takashi Sakamoto (2):
      ALSA: oxfw: add support for APOGEE duet FireWire
      ALSA: bebob: fix model-id of unit for Apogee Ensemble

Trigger Huang (1):
      drm/scheduler: Fix bad job be re-processed in TDR

Ville Syrj=E4l=E4 (1):
      drm/atomic-helper: Complete fake_commit->flip_done potentially earlier

Vitaly Chikunov (1):
      crypto: ecc - regularize scalar for scalar multiplication

Vivek Gautam (1):
      media: venus: core: Set dma maximum segment size

Will Deacon (1):
      arm64: Fix minor issues with the dcache_by_line_op macro

Yang Yingliang (1):
      ipmi: fix use-after-free of user->release_barrier.rda

Yangtao Li (1):
      clocksource/drivers/integrator-ap: Add missing of_node_put()

Yanjiang Jin (1):
      scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()

Yi-Hung Wei (1):
      openvswitch: Fix IPv6 later frags parsing

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: add a safety connection way for force=
d_b_device

Yu Zhao (1):
      ASoC: use dma_ops of parent device for acp_audio_dma

Zhi Chen (1):
      ath10k: fix peer stats null pointer dereference

yupeng (1):
      net: call sk_dst_reset when set SO_DONTROUTE


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxMKQcACgkQONu9yGCS
aT4/hA//cb2A8PwMfxw/e9F+vTzmdLo4Y/hprBce6uD0rtxSV02E+CLJa4tVSc2/
YFHwwDP0WO7LQJzmEDbdjFThl6Tvr0QVCjrbHr3rPURDYFenCFueF8ZnZzWJ9+pM
BknqxhiDHj5WsOZjq1yvHeV65gTrU9HB01Gdcgfumymr1gXf6OsBJVJyzFz8LSTP
eB5BtI2G4tbIM2cwSXCwS5KLhcL4jmq0P61tJf31JTIkDXxCRZ/WUoEK7d0O8xfR
Dx7hQSS8KgWIRZ7CHwOvbLEvBZjESOWruXLAjKBdEtxnMd7USL1pujDKJW2SX9/N
OT+L2PSglvUv/90S5U2LNdzzatjn0BS6588TN3aTwuA/9lrTYHUxN0DjP2HjbraL
rRvFxZuxK0DZ1nFZyChYWUnaSCm3mbiY7PvMc2Eb4alRickpWL3iidslbeYGBwCp
5Ce77LB1NQjxhqbTh1onJI3BWmDIAdF2h7WOr6u/07lufjSq/UjJKAk1c5soJFnq
I0ps4dDgbnYxPhrp6so48sR78ZfepBbeFvTR7wrO9wtYDyhFC9Iajn7rSGKIeLmg
MuvD2a9J2c7CUwKC8R19gr4xjlrzgqyaH27hP2DN61f7psALXa8P6IV99n+exikR
7dIQXdnH1wPMS5k1rhG0kj3kscyjquXnh5dupgcrTW8jsf6yrxk=
=uTOY
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
