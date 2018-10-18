Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE369C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECDA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuyEguFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECDA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJRREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbeJRREY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:04:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9061208E4;
        Thu, 18 Oct 2018 09:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539853462;
        bh=jOOGzKvZ9AVEk/Q5inX+3N7rosX1iI1E6yaJbPyJCKo=;
        h=Date:From:To:Cc:Subject:From;
        b=TuyEguFZ8Nj6wEQBAtgDoQZk43PxxE9Qa8xJvMTIKEyk7UIOg5KTuZTRiHa3U6qLb
         NerboSvRccdM8xyjoE3zqBW1ta8E9nvjaMp3THYRvu/gTrOw2wCr31G9dEykucEmCx
         0f0Ntc4qNK07vFeZY3qhBD7otJ5obNPG4H0c9hjM=
Date:   Thu, 18 Oct 2018 11:04:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.77
Message-ID: <20181018090419.GA32182@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.77 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/macb.txt        |    1=20
 Makefile                                              |    2=20
 arch/arm/boot/dts/sama5d3_emac.dtsi                   |    2=20
 arch/arm/include/asm/assembler.h                      |   12 +
 arch/arm/include/asm/barrier.h                        |   32 +++
 arch/arm/include/asm/bugs.h                           |    6=20
 arch/arm/include/asm/cp15.h                           |    3=20
 arch/arm/include/asm/cputype.h                        |    8=20
 arch/arm/include/asm/kvm_asm.h                        |    2=20
 arch/arm/include/asm/kvm_host.h                       |   14 +
 arch/arm/include/asm/kvm_mmu.h                        |   23 ++
 arch/arm/include/asm/proc-fns.h                       |    4=20
 arch/arm/include/asm/system_misc.h                    |   15 +
 arch/arm/include/asm/thread_info.h                    |    4=20
 arch/arm/include/asm/uaccess.h                        |   26 +-
 arch/arm/kernel/Makefile                              |    1=20
 arch/arm/kernel/bugs.c                                |   18 +
 arch/arm/kernel/entry-common.S                        |   18 -
 arch/arm/kernel/entry-header.S                        |   25 ++
 arch/arm/kernel/signal.c                              |   58 +++---
 arch/arm/kernel/smp.c                                 |    4=20
 arch/arm/kernel/suspend.c                             |    2=20
 arch/arm/kernel/sys_oabi-compat.c                     |    8=20
 arch/arm/kvm/hyp/hyp-entry.S                          |  112 +++++++++++
 arch/arm/lib/copy_from_user.S                         |    9=20
 arch/arm/mm/Kconfig                                   |   23 ++
 arch/arm/mm/Makefile                                  |    2=20
 arch/arm/mm/fault.c                                   |    3=20
 arch/arm/mm/proc-macros.S                             |    3=20
 arch/arm/mm/proc-v7-2level.S                          |    6=20
 arch/arm/mm/proc-v7-bugs.c                            |  174 +++++++++++++=
+++++
 arch/arm/mm/proc-v7.S                                 |  154 ++++++++++++-=
--
 arch/arm/vfp/vfpmodule.c                              |   17 -
 arch/arm64/kernel/perf_event.c                        |    7=20
 arch/mips/include/asm/processor.h                     |   10 -
 arch/mips/kernel/process.c                            |   25 ++
 arch/mips/kernel/vdso.c                               |   18 +
 arch/powerpc/include/asm/book3s/64/pgtable.h          |    4=20
 arch/x86/include/asm/pgtable_types.h                  |    2=20
 arch/x86/include/uapi/asm/kvm.h                       |    1=20
 arch/x86/kvm/lapic.c                                  |   22 +-
 drivers/bluetooth/hci_ldisc.c                         |    2=20
 drivers/clk/x86/clk-pmc-atom.c                        |   18 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c     |    2=20
 drivers/i2c/busses/i2c-scmi.c                         |    1=20
 drivers/md/dm-cache-target.c                          |    5=20
 drivers/md/dm-flakey.c                                |    2=20
 drivers/md/dm-linear.c                                |    8=20
 drivers/md/dm.c                                       |   27 ++
 drivers/mfd/omap-usb-host.c                           |   11 -
 drivers/mmc/core/block.c                              |   10 +
 drivers/net/bonding/bond_main.c                       |   65 +++---
 drivers/net/dsa/bcm_sf2.c                             |   12 -
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c      |   32 +--
 drivers/net/ethernet/broadcom/bcmsysport.c            |   22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c             |   23 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c          |   20 +-
 drivers/net/ethernet/cadence/macb_main.c              |    8=20
 drivers/net/ethernet/hisilicon/hns/hnae.c             |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c         |   30 +--
 drivers/net/ethernet/marvell/mvpp2.c                  |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c       |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c     |    4=20
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c   |   17 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h           |    8=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h        |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c        |   12 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     |    8=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |    5=20
 drivers/net/hyperv/netvsc_drv.c                       |    9=20
 drivers/net/team/team.c                               |    5=20
 drivers/net/usb/qmi_wwan.c                            |    1=20
 drivers/net/usb/smsc75xx.c                            |    1=20
 drivers/pci/host/pci-hyperv.c                         |   37 +++
 drivers/perf/arm_pmu.c                                |    8=20
 drivers/pinctrl/pinctrl-mcp23s08.c                    |   13 +
 drivers/s390/cio/vfio_ccw_cp.c                        |    2=20
 drivers/scsi/qla2xxx/qla_target.h                     |    4=20
 drivers/target/iscsi/iscsi_target.c                   |   22 +-
 drivers/usb/host/xhci-hub.c                           |   18 -
 drivers/video/fbdev/aty/atyfb.h                       |    3=20
 drivers/video/fbdev/aty/atyfb_base.c                  |    7=20
 drivers/video/fbdev/aty/mach64_ct.c                   |   10 -
 fs/dcache.c                                           |   38 +++
 include/linux/cgroup-defs.h                           |    1=20
 include/linux/mmzone.h                                |    1=20
 include/linux/netdevice.h                             |    7=20
 include/linux/perf/arm_pmu.h                          |    1=20
 include/linux/virtio_net.h                            |   18 +
 include/net/bonding.h                                 |    7=20
 include/net/inet_sock.h                               |    6=20
 include/net/ip_fib.h                                  |    1=20
 include/sound/hdaudio.h                               |    1=20
 kernel/cgroup/cgroup.c                                |   25 +-
 mm/huge_memory.c                                      |    6=20
 mm/page_alloc.c                                       |    7=20
 mm/percpu.c                                           |    1=20
 mm/util.c                                             |    7=20
 mm/vmstat.c                                           |    6=20
 net/core/dev.c                                        |   28 ++
 net/core/ethtool.c                                    |    1=20
 net/core/rtnetlink.c                                  |   35 ++-
 net/dccp/input.c                                      |    4=20
 net/dccp/ipv4.c                                       |    4=20
 net/ipv4/fib_frontend.c                               |   12 -
 net/ipv4/fib_semantics.c                              |   50 +++++
 net/ipv4/inet_connection_sock.c                       |    5=20
 net/ipv4/ip_sockglue.c                                |    3=20
 net/ipv4/ip_tunnel.c                                  |    9=20
 net/ipv4/tcp_input.c                                  |    4=20
 net/ipv4/tcp_ipv4.c                                   |    4=20
 net/ipv4/udp.c                                        |    2=20
 net/ipv6/addrconf.c                                   |    4=20
 net/ipv6/ip6_tunnel.c                                 |   13 +
 net/ipv6/raw.c                                        |   29 ++-
 net/netlabel/netlabel_unlabeled.c                     |    3=20
 net/packet/af_packet.c                                |   11 -
 net/sched/sch_api.c                                   |   22 +-
 net/sctp/transport.c                                  |   12 +
 net/tipc/socket.c                                     |    4=20
 sound/hda/hdac_controller.c                           |   15 +
 sound/soc/codecs/rt5514.c                             |    8=20
 sound/soc/codecs/sigmadsp.c                           |    3=20
 sound/soc/codecs/wm8804-i2c.c                         |   15 +
 sound/soc/intel/skylake/skl.c                         |    2=20
 sound/soc/sh/rcar/adg.c                               |    5=20
 sound/soc/sh/rcar/core.c                              |   10 -
 sound/soc/sh/rcar/dma.c                               |    4=20
 tools/perf/builtin-script.c                           |   22 +-
 tools/perf/scripts/python/export-to-postgresql.py     |    9=20
 tools/perf/scripts/python/export-to-sqlite.py         |    6=20
 tools/perf/tests/attr.c                               |    4=20
 tools/perf/tests/mem.c                                |    2=20
 tools/perf/tests/pmu.c                                |    2=20
 tools/perf/util/cgroup.c                              |    2=20
 tools/perf/util/parse-events.c                        |    4=20
 tools/perf/util/pmu.c                                 |    2=20
 tools/testing/selftests/efivarfs/config               |    1=20
 tools/testing/selftests/memory-hotplug/config         |    1=20
 141 files changed, 1488 insertions(+), 427 deletions(-)

Adrian Hunter (2):
      perf script python: Fix export-to-postgresql.py occasional failure
      perf script python: Fix export-to-sqlite.py sample columns

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Antoine Tenart (1):
      net: mvpp2: fix a txq_done race condition

Chris Boot (1):
      mmc: block: avoid multiblock reads for the last sector in SPI mode

Damien Le Moal (2):
      dm: fix report zone remapping to account for partition offset
      dm linear: fix linear_end_io conditional definition

Dan Carpenter (1):
      scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

David Ahern (1):
      net: sched: Add policy validation for tc attributes

Davide Caratti (1):
      bnxt_en: don't try to offload VLAN 'modify' action

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Eran Ben Elisha (1):
      net/mlx5: E-Switch, Fix out of bound access when setting vport rate

Eric Dumazet (4):
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      tcp/dccp: fix lockdep issue when SYN is backlogged
      inet: make sure to grab rcu_read_lock before using ireq->ireq_opt

Eric Farman (1):
      s390/cio: Fix how vfio-ccw checks pinned pages

Florian Fainelli (3):
      net: dsa: bcm_sf2: Call setup during switch resume
      net: systemport: Fix wake-up interrupt race during resume
      net: dsa: bcm_sf2: Fix unbind ordering

Friedemann Gerold (1):
      net: aquantia: memory corruption on jumbo frames

Giacinto Cifelli (1):
      qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Greg Kroah-Hartman (1):
      Linux 4.14.77

Hans de Goede (2):
      clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail
      clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Hermes Zhang (1):
      Bluetooth: hci_ldisc: Free rw_semaphore on close

Ido Schimmel (1):
      team: Forbid enslaving team device to itself

Jakub Kicinski (1):
      nfp: avoid soft lockups under control message storm

Jan Kara (1):
      mm: Preserve _PAGE_DEVMAP across mprotect() calls

Jann Horn (1):
      mm/vmstat.c: fix outdated vmstat_text

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Jianbo Liu (1):
      net/mlx5e: Set vlan masks for all offloaded TC rules

Jianfeng Tan (1):
      net/packet: fix packet drop as of virtio gso

Jiri Kosina (1):
      udp: Unbreak modules that rely on external __skb_recv_udp() availabil=
ity

Jiri Olsa (1):
      perf tools: Fix snprint warnings for gcc 8

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Jose Abreu (1):
      net: stmmac: Fixup the tail addr setting in xmit path

J=C3=A9r=C3=B4me Glisse (1):
      mm/thp: fix call to mmu_notifier in set_pmd_migration_entry() v2

Kuninori Morimoto (2):
      ASoC: rsnd: adg: care clock-frequency size
      ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Laura Abbott (1):
      scsi: iscsi: target: Don't use stack buffer for scatterlist

Lei Yang (2):
      selftests/efivarfs: add required kernel configs
      selftests: memory-hotplug: add required configs

Maciej =C5=BBenczykowski (1):
      net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Mahesh Bandewar (3):
      bonding: avoid possible dead-lock
      bonding: pass link-local packets to bonding master also.
      bonding: fix warning message

Marc Zyngier (2):
      ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17
      ARM: KVM: invalidate icache on guest exit for Cortex-A15

Marco Felsch (1):
      pinctrl: mcp23s08: fix irq and irqchip setup order

Mathias Nyman (1):
      xhci: Don't print a warning when setting link state for disabled ports

Mauricio Faria de Oliveira (1):
      rtnetlink: fix rtnl_fdb_dump() for ndmsg header

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offl=
oad

Michael Chan (1):
      bnxt_en: Fix TX timeout during netpoll.

Mike Rapoport (1):
      percpu: stop leaking bitmap metadata blocks

Mike Snitzer (1):
      dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Nicolas Ferre (2):
      net: macb: disable scatter-gather for macb on sama5d3
      ARM: dts: at91: add new compatibility string for macb on sama5d3

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied again

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Parthasarathy Bhuvaragan (1):
      tipc: fix flow control accounting for implicit connect

Paul Burton (1):
      MIPS: VDSO: Always map near top of user memory

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Roman Gushchin (5):
      mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
      mm: treat indirectly reclaimable memory as available in MemAvailable
      dcache: account external names as indirectly reclaimable memory
      mm: treat indirectly reclaimable memory as free in overcommit logic
      mm: don't show nr_indirectly_reclaimable in /proc/vmstat

Russell King (22):
      ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs
      ARM: bugs: prepare processor bug infrastructure
      ARM: bugs: hook processor bug checking into SMP and suspend paths
      ARM: bugs: add support for per-processor bug checking
      ARM: spectre: add Kconfig symbol for CPUs vulnerable to Spectre
      ARM: spectre-v2: harden branch predictor on context switches
      ARM: spectre-v2: add Cortex A8 and A15 validation of the IBE bit
      ARM: spectre-v2: harden user aborts in kernel space
      ARM: spectre-v2: add firmware based hardening
      ARM: spectre-v2: warn about incorrect context switching functions
      ARM: spectre-v2: KVM: invalidate icache on guest exit for Brahma B15
      ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1
      ARM: spectre-v1: add speculation barrier (csdb) macros
      ARM: spectre-v1: add array_index_mask_nospec() implementation
      ARM: spectre-v1: fix syscall entry
      ARM: signal: copy registers using __copy_from_user()
      ARM: vfp: use __copy_from_user() when restoring VFP state
      ARM: oabi-compat: copy semops using __copy_from_user()
      ARM: use __inttype() in get_user()
      ARM: spectre-v1: use get_user() for __get_user()
      ARM: spectre-v1: mitigate user accesses

Sabrina Dubroca (1):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes

Sean Tranchetti (1):
      netlabel: check for IPV4MASK in addrinfo_get

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Shenghui Wang (1):
      dm cache: destroy migration_cache if cache target registration failed

Stephen Hemminger (2):
      hv_netvsc: fix schedule in RCU context
      PCI: hv: support reporting serial number as slot information

Tejun Heo (1):
      cgroup: Fix dom_cgrp propagation when enabling threaded mode

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

Venkat Duvvuru (1):
      bnxt_en: free hwrm resources, if driver probe fails.

Vitaly Kuznetsov (1):
      x86/kvm/lapic: always disable MMIO interface in x2APIC mode

Wei Wang (1):
      ipv6: take rcu lock in rawv6_send_hdrinc()

Will Deacon (1):
      arm64: perf: Reject stand-alone CHAIN events for PMUv3

Xin Long (1):
      sctp: update dst pmtu with the correct daddr

Yu Zhao (3):
      net/usb: cancel pending work when unbinding smsc75xx
      sound: enable interrupt after dma buffer initialization
      sound: don't call skl_init_chip() to reset intel skl soc

Yunsheng Lin (1):
      net: hns: fix for unmapping problem when SMMU is on


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvITJMACgkQONu9yGCS
aT4J2g//SLaaYqhCWnbU0ccH7R+UNISWhXeL3tSvfCrgNn1FHzXvpWEa5GVq6H/+
RIBSOvPGCtH94PtQMs9QctYXHB/TDJg1CeKi2qikl2YBDerOgXLYOAvwhqHdML6M
e6NixWvqQiVCOmsyo/Zo2ixh4Ri/AA1zj+kLdNfGyYWgbiTffO6zMOhGt8oaZ3WB
daesRrHoF+DK/dvBGnrX/xYriJ1QxOfg4xEcjrHBALsFYRSVpGMPE4PkDsSBthXD
oDaUlvojv82s1TXy7lxiKcwvc7adfW0LGY9TXFQCGz1u/wnhWsui1kXZT0A/ONNd
klEez4fnXFSsGJFbsockobNbaS59pMIG+Qcos3clawxwPHISHsPzjY1iqp5zA1Pv
wUsLWE6ufo5U35+FNzR0lLTXRNGroQASCXf9BDzCZWsYaI/taVHZjxl488QoHYcL
E/0KjP7wYR6V1NgCIok1Lh9AbC9mU7fD+mLA3CenYz/cETph6TH4/blJFLdEisMR
bET6A51VUzDu/G7k+ks+f670dFB377M33Y5bHmfFwNGrs8PbCcnYybxpr7oHvryl
H6+0SX2wzIAwb45udnG5CfH2zRqpWDCibH9X1m4SDE5+FqOhLebV2ii16Q7aYXEe
V2kGucTkVYB0E7UjdKEHskYWXNJSSFcD3hZXVqh46h8RDJ4G36o=
=9Bwn
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
