Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17253208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxM784qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17253208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeJRREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeJRREs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:04:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD9D208E4;
        Thu, 18 Oct 2018 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539853485;
        bh=qqET7azN41c+cM6ll/ppo7UBPVCGERQho9sE6fhvdn0=;
        h=Date:From:To:Cc:Subject:From;
        b=UxM784qtQCakezuCr4akqLgM03t3Hs5YmfUcE5ea/DLBZTUAktr1vCx7ZOs5GJoWi
         ar++kR1FFXIZ+DUECPDiuEo3fpJVEh4BFiD/821MuJVZk+r5HSL1a7Cz3AMhsAGtrh
         dGtbxO49vP/KNCge9wvejjkGgp1vDj6cyrJPb4XY=
Date:   Thu, 18 Oct 2018 11:04:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.15
Message-ID: <20181018090443.GA994@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.15 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/macb.txt           |    1=20
 Makefile                                                 |   16 -
 arch/arm/boot/dts/sama5d3_emac.dtsi                      |    2=20
 arch/arm64/kernel/perf_event.c                           |    7=20
 arch/mips/include/asm/processor.h                        |   10=20
 arch/mips/kernel/process.c                               |   25 +
 arch/mips/kernel/setup.c                                 |   48 +--
 arch/mips/kernel/vdso.c                                  |   18 +
 arch/powerpc/include/asm/book3s/64/pgtable.h             |    4=20
 arch/powerpc/kvm/book3s_64_mmu_radix.c                   |  101 ++----
 arch/x86/include/asm/pgtable_types.h                     |    2=20
 arch/x86/include/uapi/asm/kvm.h                          |    1=20
 arch/x86/kvm/lapic.c                                     |   22 +
 drivers/bluetooth/hci_ldisc.c                            |    2=20
 drivers/clk/x86/clk-pmc-atom.c                           |   18 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c               |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h               |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c        |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                  |    3=20
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                   |   13=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c          |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                    |    1=20
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                |   21 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h          |    2=20
 drivers/gpu/drm/nouveau/dispnv50/disp.c                  |   15=20
 drivers/gpu/drm/pl111/pl111_vexpress.c                   |    3=20
 drivers/hwmon/nct6775.c                                  |   70 +++-
 drivers/i2c/busses/i2c-scmi.c                            |    1=20
 drivers/input/joystick/xpad.c                            |    3=20
 drivers/md/dm-cache-target.c                             |    5=20
 drivers/md/dm-flakey.c                                   |    2=20
 drivers/md/dm-linear.c                                   |    8=20
 drivers/md/dm.c                                          |   27 +
 drivers/mfd/omap-usb-host.c                              |   11=20
 drivers/mmc/core/block.c                                 |   10=20
 drivers/net/bonding/bond_main.c                          |   65 ++--
 drivers/net/dsa/b53/b53_common.c                         |    4=20
 drivers/net/dsa/bcm_sf2.c                                |   14=20
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c         |   32 +-
 drivers/net/ethernet/broadcom/bcmsysport.c               |   22 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                |   27 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c            |    6=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c             |   20 -
 drivers/net/ethernet/cadence/macb_main.c                 |    8=20
 drivers/net/ethernet/hisilicon/hns/hnae.c                |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c            |   30 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c          |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c        |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c       |    2=20
 drivers/net/ethernet/mscc/ocelot_board.c                 |   12=20
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c      |   17 -
 drivers/net/ethernet/qlogic/qed/qed_hsi.h                |    1=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h              |    8=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c      |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h      |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h           |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c           |   12=20
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c     |    7=20
 drivers/net/ethernet/realtek/r8169.c                     |   24 -
 drivers/net/ethernet/stmicro/stmmac/common.h             |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac.h             |   14=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c        |  238 ++++++++--=
-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c    |    5=20
 drivers/net/ethernet/ti/Kconfig                          |    1=20
 drivers/net/phy/phylink.c                                |   48 +--
 drivers/net/phy/sfp-bus.c                                |    4=20
 drivers/net/team/team.c                                  |    6=20
 drivers/net/tun.c                                        |   43 +-
 drivers/net/usb/qmi_wwan.c                               |    1=20
 drivers/net/usb/smsc75xx.c                               |    1=20
 drivers/net/vxlan.c                                      |    3=20
 drivers/pci/controller/pci-hyperv.c                      |   37 ++
 drivers/perf/arm_pmu.c                                   |    8=20
 drivers/pinctrl/intel/pinctrl-cannonlake.c               |    2=20
 drivers/pinctrl/pinctrl-mcp23s08.c                       |   13=20
 drivers/s390/cio/vfio_ccw_cp.c                           |    2=20
 drivers/scsi/qla2xxx/qla_target.h                        |    4=20
 drivers/target/iscsi/iscsi_target.c                      |   22 -
 drivers/video/fbdev/aty/atyfb.h                          |    3=20
 drivers/video/fbdev/aty/atyfb_base.c                     |    7=20
 drivers/video/fbdev/aty/mach64_ct.c                      |   10=20
 fs/afs/rxrpc.c                                           |    2=20
 fs/dax.c                                                 |   13=20
 include/linux/cgroup-defs.h                              |    1=20
 include/linux/netdevice.h                                |    7=20
 include/linux/perf/arm_pmu.h                             |    1=20
 include/linux/stmmac.h                                   |    1=20
 include/linux/virtio_net.h                               |   18 +
 include/net/bonding.h                                    |    7=20
 include/net/inet_sock.h                                  |    6=20
 include/net/ip_fib.h                                     |    1=20
 include/sound/hdaudio.h                                  |    1=20
 include/sound/soc-dapm.h                                 |    1=20
 kernel/bpf/btf.c                                         |    2=20
 kernel/cgroup/cgroup.c                                   |   25 +
 lib/vsprintf.c                                           |    2=20
 mm/huge_memory.c                                         |    6=20
 mm/mmap.c                                                |    2=20
 mm/percpu.c                                              |    1=20
 mm/vmscan.c                                              |   11=20
 mm/vmstat.c                                              |    1=20
 net/bluetooth/smp.c                                      |   16 -
 net/core/dev.c                                           |   28 +
 net/core/ethtool.c                                       |    1=20
 net/core/filter.c                                        |    3=20
 net/core/rtnetlink.c                                     |   41 +-
 net/dccp/input.c                                         |    4=20
 net/dccp/ipv4.c                                          |    4=20
 net/ipv4/fib_frontend.c                                  |   12=20
 net/ipv4/fib_semantics.c                                 |   50 +++
 net/ipv4/inet_connection_sock.c                          |    5=20
 net/ipv4/ip_sockglue.c                                   |    3=20
 net/ipv4/ip_tunnel.c                                     |    9=20
 net/ipv4/route.c                                         |    7=20
 net/ipv4/tcp_input.c                                     |    4=20
 net/ipv4/tcp_ipv4.c                                      |    4=20
 net/ipv4/udp.c                                           |    2=20
 net/ipv6/addrconf.c                                      |    4=20
 net/ipv6/ip6_fib.c                                       |    2=20
 net/ipv6/ip6_tunnel.c                                    |   13=20
 net/ipv6/raw.c                                           |   29 +
 net/ipv6/route.c                                         |    5=20
 net/netlabel/netlabel_unlabeled.c                        |    3=20
 net/packet/af_packet.c                                   |   11=20
 net/sched/cls_u32.c                                      |   10=20
 net/sched/sch_api.c                                      |   24 +
 net/sctp/transport.c                                     |   12=20
 net/tipc/socket.c                                        |    4=20
 scripts/subarch.include                                  |   13=20
 sound/hda/hdac_controller.c                              |   15=20
 sound/soc/amd/acp-pcm-dma.c                              |   21 +
 sound/soc/codecs/max98373.c                              |    3=20
 sound/soc/codecs/rt5514.c                                |    8=20
 sound/soc/codecs/sigmadsp.c                              |    3=20
 sound/soc/codecs/wm8804-i2c.c                            |   15=20
 sound/soc/intel/skylake/skl.c                            |    2=20
 sound/soc/qcom/qdsp6/q6routing.c                         |    4=20
 sound/soc/sh/rcar/adg.c                                  |    5=20
 sound/soc/sh/rcar/core.c                                 |   10=20
 sound/soc/sh/rcar/dma.c                                  |    4=20
 sound/soc/soc-core.c                                     |    4=20
 sound/soc/soc-dapm.c                                     |    4=20
 tools/perf/scripts/python/export-to-postgresql.py        |    9=20
 tools/perf/scripts/python/export-to-sqlite.py            |    6=20
 tools/testing/selftests/android/Makefile                 |    2=20
 tools/testing/selftests/android/config                   |    5=20
 tools/testing/selftests/android/ion/Makefile             |    2=20
 tools/testing/selftests/android/ion/config               |    5=20
 tools/testing/selftests/cgroup/cgroup_util.c             |   17 -
 tools/testing/selftests/efivarfs/config                  |    1=20
 tools/testing/selftests/futex/functional/Makefile        |    1=20
 tools/testing/selftests/gpio/Makefile                    |    7=20
 tools/testing/selftests/kselftest.h                      |    1=20
 tools/testing/selftests/kvm/Makefile                     |    7=20
 tools/testing/selftests/lib.mk                           |   12=20
 tools/testing/selftests/memory-hotplug/config            |    1=20
 tools/testing/selftests/net/Makefile                     |    1=20
 tools/testing/selftests/networking/timestamping/Makefile |    1=20
 tools/testing/selftests/vm/Makefile                      |    4=20
 160 files changed, 1294 insertions(+), 626 deletions(-)

Adrian Hunter (2):
      perf script python: Fix export-to-postgresql.py occasional failure
      perf script python: Fix export-to-sqlite.py sample columns

Akshu Agrawal (1):
      ASoC: AMD: Ensure reset bit is cleared before configuring

Al Viro (1):
      net: sched: cls_u32: fix hnode refcounting

Alaa Hleihel (1):
      net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Anders Roxell (2):
      selftests: android: move config up a level
      selftests: add headers_install to lib.mk

Antoine Tenart (2):
      net: mvpp2: fix a txq_done race condition
      net: mscc: fix the frame extraction into the skb

Baruch Siach (1):
      net: phy: phylink: fix SFP interface autodetection

Charles Keepax (1):
      ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

Chris Boot (1):
      mmc: block: avoid multiblock reads for the last sector in SPI mode

Corentin Labbe (1):
      net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency

Damien Le Moal (2):
      dm: fix report zone remapping to account for partition offset
      dm linear: fix linear_end_io conditional definition

Dan Carpenter (1):
      scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Dan Williams (1):
      filesystem-dax: Fix dax_layout_busy_page() livelock

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

David Ahern (3):
      net: sched: Add policy validation for tc attributes
      rtnetlink: Fail dump if target netnsid is invalid
      net/ipv6: Remove extra call to ip6_convert_metrics for multipath case

David Howells (2):
      afs: Fix afs_server struct leak
      afs: Fix clearance of reply

Davide Caratti (1):
      bnxt_en: don't try to offload VLAN 'modify' action

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Eran Ben Elisha (1):
      net/mlx5: E-Switch, Fix out of bound access when setting vport rate

Eric Dumazet (7):
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      tun: remove unused parameters
      tun: initialize napi_mutex unconditionally
      tun: napi flags belong to tfile
      tcp/dccp: fix lockdep issue when SYN is backlogged
      inet: make sure to grab rcu_read_lock before using ireq->ireq_opt

Eric Farman (1):
      s390/cio: Fix how vfio-ccw checks pinned pages

Florian Fainelli (4):
      net: dsa: bcm_sf2: Call setup during switch resume
      net: systemport: Fix wake-up interrupt race during resume
      net: dsa: bcm_sf2: Fix unbind ordering
      net: dsa: b53: Keep CPU port as tagged in all VLANs

Friedemann Gerold (1):
      net: aquantia: memory corruption on jumbo frames

Giacinto Cifelli (1):
      qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Greg Kroah-Hartman (1):
      Linux 4.18.15

Guenter Roeck (4):
      hwmon: (nct6775) Fix access to fan pulse registers
      hwmon: (nct6775) Fix virtual temperature sources for NCT6796D
      hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D
      hwmon: (nct6775) Use different register to get fan RPM for fan7

Hangbin Liu (1):
      vxlan: fill ttl inherit info

Hans de Goede (2):
      clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail
      clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Heiner Kallweit (1):
      r8169: fix network stalls due to missing bit TXCFG_AUTO_FIFO

Hermes Zhang (1):
      Bluetooth: hci_ldisc: Free rw_semaphore on close

Ido Schimmel (1):
      team: Forbid enslaving team device to itself

Jakub Kicinski (1):
      nfp: avoid soft lockups under control message storm

Jan Kara (1):
      mm: Preserve _PAGE_DEVMAP across mprotect() calls

Jann Horn (2):
      mm/vmstat.c: fix outdated vmstat_text
      mm/mmap.c: don't clobber partially overlapping VMA with MAP_FIXED_NOR=
EPLACE

Jay Kamat (1):
      Fix cg_read_strcmp()

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Jianbo Liu (1):
      net/mlx5e: Set vlan masks for all offloaded TC rules

Jianfeng Tan (1):
      net/packet: fix packet drop as of virtio gso

Jiri Kosina (1):
      udp: Unbreak modules that rely on external __skb_recv_udp() availabil=
ity

Johan Hedberg (1):
      Bluetooth: SMP: Fix trying to use non-existent local OOB data

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Jose Abreu (2):
      net: stmmac: Fixup the tail addr setting in xmit path
      net: stmmac: Rework coalesce timer and fix multi-queue races

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

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()

Maciej S. Szmigiero (1):
      r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family chips

Maciej =C5=BBenczykowski (1):
      net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Mahesh Bandewar (3):
      bonding: avoid possible dead-lock
      bonding: pass link-local packets to bonding master also.
      bonding: fix warning message

Marco Felsch (1):
      pinctrl: mcp23s08: fix irq and irqchip setup order

Martin KaFai Lau (1):
      bpf: btf: Fix end boundary calculation for type section

Matias Karhumaa (1):
      Bluetooth: Use correct tfm to generate OOB data

Mauricio Faria de Oliveira (1):
      rtnetlink: fix rtnl_fdb_dump() for ndmsg header

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offl=
oad

Michael Chan (2):
      bnxt_en: Fix TX timeout during netpoll.
      bnxt_en: Fix VNIC reservations on the PF.

Mike Rapoport (2):
      net/ipv6: stop leaking percpu memory in fib6 info
      percpu: stop leaking bitmap metadata blocks

Mike Snitzer (1):
      dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Don't use compound_order to determine host mappi=
ng size

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

Paul Burton (2):
      MIPS: Fix CONFIG_CMDLINE handling
      MIPS: VDSO: Always map near top of user memory

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Avoid crash from THP collapse during radix page =
fault

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Ramses Ram=C3=ADrez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Roman Gushchin (1):
      mm: slowly shrink slabs with a relatively small number of objects

Russell King (1):
      sfp: fix oops with ethtool -m

Ryan Lee (2):
      ASoC: max98373: Added speaker FS gain cotnrol register to volatile.
      ASoC: max98373: Added 10ms sleep after amp software reset

Sabrina Dubroca (2):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes
      net: ipv4: don't let PMTU updates increase route MTU

Sean Tranchetti (2):
      netlabel: check for IPV4MASK in addrinfo_get
      net: qualcomm: rmnet: Skip processing loopback packets

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Shenghui Wang (1):
      dm cache: destroy migration_cache if cache target registration failed

Simon Detheridge (1):
      pinctrl: cannonlake: Fix gpio base for GPP-E

Srinivas Kandagatla (1):
      ASoC: q6routing: initialize data correctly

Stephen Hemminger (1):
      PCI: hv: support reporting serial number as slot information

Steven Rostedt (VMware) (1):
      vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced=
 pointers

Subash Abhinov Kasiviswanathan (2):
      net: qualcomm: rmnet: Fix incorrect allocation flag in transmit
      net: qualcomm: rmnet: Fix incorrect allocation flag in receive path

Sudarsana Reddy Kalluru (1):
      qed: Fix shmem structure inconsistency between driver and the mfw.

Tejun Heo (1):
      cgroup: Fix dom_cgrp propagation when enabling threaded mode

Thiago Jung Bauermann (1):
      selftests: kselftest: Remove outdated comment

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

Tushar Dave (1):
      bpf: use __GFP_COMP while allocating page

Vasundhara Volam (2):
      bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request
      bnxt_en: get the reduced max_irqs by the ones used by RDMA

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

Yong Zhao (2):
      drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9
      drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs

Yu Zhao (3):
      net/usb: cancel pending work when unbinding smsc75xx
      sound: enable interrupt after dma buffer initialization
      sound: don't call skl_init_chip() to reset intel skl soc

Yunsheng Lin (1):
      net: hns: fix for unmapping problem when SMMU is on

zhong jiang (1):
      drm/pl111: Make sure of_device_id tables are NULL terminated


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvITKoACgkQONu9yGCS
aT4DXBAAvOWPKADvfRknkXC8az8VkUR0o/LYwkXT+5RBBpWLzTWz/ZuMo4d1PaEt
Qu9AzUddYJfk/SuM4lGCP/CrjBFTdjlQTn1fxRyrh1yVnrkzng+T8CEZTwqN6brk
8IVW1KfFWhbGuhuaAcCD9hQr5+QAKMDgbY/IQ9T33ZCVFHSY3tZqKMag4EcIPNbg
sQic7bGYnqY2f8bl6EkezMR3YbZPW1KyCOLRvwzggHZ8pOTjQaAUa+9wGlKUv+t5
BLNWnYIIissJlOVJaHPi9tIwi5tpdZzo6ZXmFgfGcXtZJXZ1iN2QVaRDvFZAIe/4
lnXB2kWnfY1K27VPZXtPiIVsLtgHCqg1yESUOr63nPxmVvRPCUneuRCux3kR1X0X
tpVis2x274f1FdDd5J7XkQ2T1JnIwkPIMFZe2vaoqXlu1O/UqsIi9ocNmltel2Y8
ioj8ACdQd5jNpNEzRgZtOuyGIAsfyIaP0deNe5uXowwzUrT2TVajbw7iVjlN47oZ
p1gp7BJXzsb0nLQXzq8lKnlQ17VbgIy8Zy/3s9W99vIENEqigNKLsyJEOAHV2Lvt
Xu02bumIzI8AbndEgSm61F13+sIIIp0aSajSnCDJv8JjJJFp0DjwnmH9Jguj53X4
1dlFh4NttMpAYz2ySZnH5LDYA8zwLs5lymLAKxADP+4qY1JMElA=
=hPfU
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
