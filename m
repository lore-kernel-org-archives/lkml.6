Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0418C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530C420858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHizLfOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530C420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKKCAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:00:44 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB32D20858;
        Sat, 10 Nov 2018 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541866511;
        bh=8oP+xw4PS51TEDwns0nxnMPKXLw4qa3FhmJSXgIryJw=;
        h=Date:From:To:Cc:Subject:From;
        b=vHizLfOssNxSh+fsiolEH+zYfPCBMlBJO48NnyA7RzzIHW3Wo+/Ab+X3Jtea+XBzO
         9fcwFGWw1f3aBXSEwrk+PJklyJInl0og43iULJhhHhqtjYldfjS6gX4bYeHtPHIRe3
         JnPxYyatWgH5+L/qBTS6V6vpKAyTwQVJaOGPejVo=
Date:   Sat, 10 Nov 2018 08:15:11 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.163
Message-ID: <20181110161511.GA28568@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.163 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                             |    2=20
 arch/arm/boot/dts/imx53-qsb-common.dtsi              |   11 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                  |    3=20
 arch/arm/mm/ioremap.c                                |    2=20
 arch/arm64/mm/fault.c                                |   15 ++-
 arch/mips/dec/int-handler.S                          |   34 +-------
 arch/mips/include/asm/fpu_emulator.h                 |   13 +++
 arch/mips/include/asm/switch_to.h                    |   18 ++++
 arch/mips/include/uapi/asm/inst.h                    |    2=20
 arch/mips/kernel/mips-r2-to-r6-emul.c                |   10 +-
 arch/mips/kernel/process.c                           |   11 +-
 arch/mips/kernel/ptrace.c                            |    7 -
 arch/mips/kernel/traps.c                             |   72 ++++++++++----=
-----
 arch/sparc/include/asm/page_64.h                     |    1=20
 arch/sparc/kernel/pci.c                              |   29 +++++--
 arch/sparc/lib/U3memcpy.S                            |    4 -
 arch/sparc/mm/fault_64.c                             |    1=20
 arch/sparc/mm/tlb.c                                  |   35 ++++++++-
 arch/sparc/mm/tsb.c                                  |   18 +++-
 arch/um/Makefile                                     |    4 +
 arch/x86/include/asm/percpu.h                        |    8 +-
 arch/x86/kernel/time.c                               |    2=20
 arch/x86/mm/pageattr.c                               |   21 ++---
 arch/x86/pci/fixup.c                                 |    7 +
 arch/x86/um/setjmp_32.S                              |   16 ++--
 arch/x86/um/setjmp_64.S                              |   16 ++--
 crypto/shash.c                                       |    2=20
 drivers/ata/ahci.c                                   |    5 +
 drivers/char/tpm/tpm-chip.c                          |    6 +
 drivers/devfreq/tegra-devfreq.c                      |    6 -
 drivers/gpio/gpio-msic.c                             |    4 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c              |    7 +
 drivers/gpu/host1x/dev.c                             |    4 -
 drivers/infiniband/core/ucm.c                        |    3=20
 drivers/infiniband/core/ucma.c                       |    3=20
 drivers/input/mouse/elan_i2c_core.c                  |    1=20
 drivers/isdn/gigaset/ser-gigaset.c                   |    9 --
 drivers/media/usb/usbvision/usbvision-video.c        |    7 -
 drivers/mfd/db8500-prcmu.c                           |    3=20
 drivers/mtd/spi-nor/spi-nor.c                        |    6 +
 drivers/net/bonding/bond_main.c                      |    2=20
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c      |   17 ++++
 drivers/net/ethernet/intel/igb/e1000_82575.c         |   11 --
 drivers/net/ethernet/intel/ixgbe/ixgbe.h             |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h        |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c        |    9 --
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c    |    2=20
 drivers/net/ethernet/mellanox/mlx4/en_clock.c        |    5 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h         |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |   30 +++++--
 drivers/net/ethernet/realtek/r8169.c                 |    8 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c    |    2=20
 drivers/net/usb/asix_common.c                        |    3=20
 drivers/net/usb/ax88179_178a.c                       |    3=20
 drivers/net/usb/lan78xx.c                            |   17 +---
 drivers/net/usb/r8152.c                              |    3=20
 drivers/net/usb/smsc75xx.c                           |    3=20
 drivers/net/usb/smsc95xx.c                           |    3=20
 drivers/net/usb/sr9800.c                             |    3=20
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c     |    7 -
 drivers/net/wireless/mac80211_hwsim.c                |    3=20
 drivers/ptp/ptp_chardev.c                            |    4 +
 drivers/scsi/aacraid/linit.c                         |    2=20
 drivers/scsi/aacraid/src.c                           |    2=20
 drivers/scsi/scsi_scan.c                             |    5 -
 drivers/scsi/scsi_sysfs.c                            |    8 +-
 drivers/spi/spi-bcm63xx-hsspi.c                      |    4 -
 drivers/spi/spi-bcm63xx.c                            |    4 -
 drivers/spi/spi-xlp.c                                |    4 -
 drivers/thermal/Kconfig                              |    6 -
 drivers/tty/serial/sprd_serial.c                     |    4 -
 drivers/usb/class/cdc-acm.c                          |   14 +--
 drivers/usb/core/devio.c                             |    4 -
 drivers/usb/dwc3/dwc3-omap.c                         |    4 -
 drivers/usb/gadget/function/f_mass_storage.c         |    3=20
 drivers/usb/host/ehci-omap.c                         |    4 -
 drivers/usb/host/imx21-hcd.c                         |    6 +
 drivers/usb/storage/transport.c                      |   14 +++
 drivers/vhost/vhost.c                                |    2=20
 drivers/video/fbdev/pxa168fb.c                       |    6 -
 drivers/video/fbdev/pxa3xx-gcu.c                     |    4 -
 fs/btrfs/disk-io.c                                   |    4 -
 fs/btrfs/disk-io.h                                   |    2=20
 fs/btrfs/root-tree.c                                 |   27 ++++---
 fs/cachefiles/namei.c                                |    2=20
 fs/cifs/connect.c                                    |    3=20
 fs/fat/fatent.c                                      |    1=20
 fs/fuse/file.c                                       |    6 -
 fs/fuse/fuse_i.h                                     |    1=20
 include/linux/bpf.h                                  |    5 -
 include/linux/cpuidle.h                              |    3=20
 include/linux/radix-tree.h                           |    1=20
 include/net/inet_ecn.h                               |    3=20
 include/scsi/scsi_device.h                           |    1=20
 kernel/bpf/arraymap.c                                |    4 -
 kernel/bpf/syscall.c                                 |   13 ---
 kernel/events/core.c                                 |    5 +
 kernel/sched/core.c                                  |    4 -
 kernel/sched/fair.c                                  |   59 ++++++++++-----
 kernel/sched/idle.c                                  |    2=20
 kernel/sched/sched.h                                 |    4 -
 kernel/trace/trace.c                                 |   19 ++++-
 mm/huge_memory.c                                     |    6 +
 mm/mremap.c                                          |   21 ++++-
 net/bluetooth/mgmt.c                                 |    7 -
 net/bluetooth/smp.c                                  |   29 ++++++-
 net/bluetooth/smp.h                                  |    3=20
 net/bridge/br_multicast.c                            |    9 ++
 net/core/rtnetlink.c                                 |   10 ++
 net/ipv4/fou.c                                       |   16 ++++
 net/ipv4/ip_fragment.c                               |   12 ++-
 net/ipv6/addrconf.c                                  |    6 +
 net/ipv6/ip6_vti.c                                   |   31 ++++++++
 net/ipv6/mcast.c                                     |   16 ++--
 net/ipv6/ndisc.c                                     |    3=20
 net/ipv6/netfilter/nf_conntrack_reasm.c              |    1=20
 net/ipv6/xfrm6_output.c                              |    2=20
 net/iucv/af_iucv.c                                   |    8 --
 net/l2tp/l2tp_ip.c                                   |   16 ++--
 net/l2tp/l2tp_ip6.c                                  |   16 ++--
 net/mac80211/status.c                                |    7 -
 net/sched/sch_gred.c                                 |    2=20
 net/sched/sch_red.c                                  |    4 +
 net/sctp/socket.c                                    |    5 -
 net/socket.c                                         |   11 ++
 net/unix/af_unix.c                                   |    5 -
 net/wireless/reg.c                                   |    1=20
 net/xfrm/xfrm_state.c                                |    1=20
 net/xfrm/xfrm_user.c                                 |   15 +++
 security/keys/process_keys.c                         |    7 +
 sound/core/timer.c                                   |   14 +++
 sound/soc/codecs/ak4613.c                            |    1=20
 sound/soc/codecs/wm8940.c                            |    1=20
 sound/soc/spear/spdif_in.c                           |    6 +
 tools/perf/Makefile                                  |    4 -
 136 files changed, 745 insertions(+), 391 deletions(-)

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Alan Stern (2):
      usb-storage: fix bogus hardware error messages for ATA pass-thru devi=
ces
      USB: fix the usbfs flag sanitization for control transfers

Alexander Duyck (1):
      gro: Allow tunnel stacking in the case of FOU/GUE

Alexander Shishkin (1):
      perf/core: Don't leak event in the syscall error path

Andrei Otcheretianski (2):
      mac80211: Always report TX status
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Andrey Ryabinin (1):
      radix-tree: fix radix_tree_iter_retry() for tagged iterators.

Ard Biesheuvel (1):
      ahci: don't ignore result code of ahci_reset_controller()

Arnd Bergmann (2):
      thermal: allow spear-thermal driver to be a module
      thermal: allow u8500-thermal driver to be a module

Ashish Samant (1):
      fuse: Dont call set_page_dirty_lock() for ITER_BVEC pages for async_d=
io

Catalin Marinas (2):
      arm64: Fix potential race with hardware DBM in ptep_set_access_flags()
      cpuidle: Do not access cpuidle_devices when !CONFIG_CPU_IDLE

Christian Gr=F6nke (1):
      igb: Remove superfluous reset to PHY and page 0 selection

Cong Wang (1):
      net: drop skb on failure in ip_check_defrag()

Daniel Borkmann (1):
      bpf: generally move prog destruction to RCU deferral

David Ahern (1):
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

David Herrmann (1):
      net: drop write-only stack variable

David S. Miller (1):
      sparc64: Fix exception handling in UltraSPARC-III memcpy.

Emil Tantilov (1):
      ixgbe: fix RSS limit for X550

Eric Biggers (1):
      KEYS: put keyring if install_session_keyring_to_cred() fails

Eric Dumazet (2):
      ipv6: orphan skbs in reassembly unit
      ipv6: mcast: fix a use-after-free in inet6_mc_check

Eugenia Emantayev (1):
      net/mlx4_en: Resolve dividing by zero in 32-bit system

Ewan D. Milne (1):
      scsi: Add STARGET_CREATED_REMOVE state to scsi_target_state

Florian Fainelli (8):
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      lan78xx: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes
      um: Avoid longjmp/setjmp symbol clashes with libpthread.a

Geert Uytterhoeven (2):
      ASoC: ak4613: Enable cache usage to fix crashes on resume
      ASoC: wm8940: Enable cache usage to fix crashes on resume

Greg Kroah-Hartman (1):
      Linux 4.4.163

Guillaume Nault (2):
      l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()
      l2tp: hold tunnel socket when handling control frames in l2tp_ip and =
l2tp_ip6

Gustavo A. R. Silva (16):
      tty: serial: sprd: fix error return code in sprd_probe()
      video: fbdev: pxa3xx_gcu: fix error return code in pxa3xx_gcu_probe()
      gpu: host1x: fix error return code in host1x_probe()
      gpio: msic: fix error return code in platform_msic_gpio_probe()
      usb: imx21-hcd: fix error return code in imx21_probe()
      usb: ehci-omap: fix error return code in ehci_hcd_omap_probe()
      usb: dwc3: omap: fix error return code in dwc3_omap_probe()
      spi/bcm63xx-hspi: fix error return code in bcm63xx_hsspi_probe()
      spi/bcm63xx: fix error return code in bcm63xx_spi_probe()
      spi: xlp: fix error return code in xlp_spi_probe()
      ASoC: spear: fix error return code in spdif_in_probe()
      PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()
      ptp: fix Spectre v1 vulnerability
      RDMA/ucma: Fix Spectre v1 vulnerability
      IB/ucm: Fix Spectre v1 vulnerability
      usb: gadget: storage: Fix Spectre v1 vulnerability

Hangbin Liu (1):
      bridge: do not add port to router list when receives query with sourc=
e 0.0.0.0

Heiner Kallweit (1):
      r8169: fix NAPI handling under high load

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

Jarkko Sakkinen (1):
      tpm: fix: return rc when devm_add_action() fails

Jason Wang (1):
      vhost: Fix Spectre V1 vulnerability

Jeff Mahoney (1):
      btrfs: don't create or leak aliased root while cleaning up orphans

Jia-Ju Bai (1):
      crypto: shash - Fix a sleep-in-atomic bug in shash_setkey_unaligned

Jiri Olsa (1):
      perf/ring_buffer: Prevent concurent ring buffer access

Johannes Berg (1):
      ipv6: suppress sparse warnings in IP6_ECN_set_ce()

Jonathan Basseri (1):
      xfrm: Clear sk_dst_cache when applying per-socket policy.

Khazhismel Kumykov (1):
      fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Kimmo Rautkoski (1):
      mtd: spi-nor: Add support for is25wp series chips

Linus Torvalds (1):
      mremap: properly flush TLB before releasing the page

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Maciej W. Rozycki (2):
      MIPS: Fix FCSR Cause bit handling for correct SIGFPE issue
      MIPS: DEC: Fix an int-handler.S CPU_DADDI_WORKAROUNDS regression

Marcelo Ricardo Leitner (1):
      sctp: fix race on sctp_id2asoc

Mark Rustad (1):
      ixgbe: Correct X550EM_x revision check

Mark Syms (1):
      CIFS: handle guest access errors to Windows shares

Martin Willi (1):
      mac80211_hwsim: do not omit multicast announce of first added radio

Mateusz Jurczyk (1):
      af_iucv: Move sockaddr length checks to before accessing sa_family in=
 bind and connect handlers

Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

Matt Fleming (1):
      x86/mm/pat: Prevent hang during boot when mapping pages

Matt Redfearn (2):
      MIPS: Handle non word sized instructions when examining frame
      MIPS: microMIPS: Fix decoding of swsp16 instruction

Mike Kravetz (1):
      sparc64 mm: Fix more TSB sizing issues

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Nathan Chancellor (1):
      x86/time: Correct the attribute on jiffies' definition

Nicolas Dichtel (1):
      vti6: flush x-netns xfrm cache when vti interface is removed

Niklas Cassel (1):
      net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Nikolay Aleksandrov (1):
      net: bridge: remove ipv6 zero address check in mcast queries

Paolo Abeni (1):
      bonding: avoid defaulting hard_header_len to ETH_HLEN on slave removal

Paul Bolle (1):
      ser_gigaset: use container_of() instead of detour

Pavel Roskin (1):
      drm/nouveau/fbcon: fix oops without fbdev emulation

Peter S. Housel (1):
      brcmfmac: Fix glom_skb leak in brcmf_sdiod_recv_chain

Peter Zijlstra (2):
      sched/cgroup: Fix cgroup entity load tracking tear-down
      x86/percpu: Fix this_cpu_read()

Phil Auld (1):
      sched/fair: Fix throttle_list starvation with low CFS quota

Prarit Bhargava (1):
      x86/PCI: Mark Broadwell-EP Home Agent 1 as having non-compliant BARs

Raghava Aditya Renukunta (2):
      aacraid: Start adapter after updating number of MSIX vectors
      scsi: aacraid: Fix typo in blink status

Rasmus Villemoes (1):
      perf tools: Disable parallelism for 'make clean'

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

Sean Tranchetti (1):
      xfrm: validate template mode

Sowmini Varadhan (1):
      sparc/pci: Refactor dev_archdata initialization into pci_init_dev_arc=
hdata

Srinivas Kandagatla (1):
      ARM: dts: apq8064: add ahci ports-implemented mask

Stefano Brivio (1):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers a=
re called

Steffen Klassert (1):
      xfrm: Validate address prefix lengths in the xfrm selector.

Steven Rostedt (Red Hat) (1):
      tracing: Skip more functions when doing stack tracing of events

Takashi Iwai (1):
      ALSA: timer: Fix zero-division by continue of uninitialized instance

Tariq Toukan (2):
      net/mlx5e: Fix LRO modify
      net/mlx5e: Correctly handle RSS indirection table when changing numbe=
r of channels

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig

Thomas Petazzoni (1):
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check

Tobias Herzog (1):
      cdc-acm: correct counting of UART states in serial state notification

Vladis Dronov (1):
      usbvision: revert commit 588afcc1

WANG Cong (1):
      sch_red: update backlog as well

Wenwen Wang (2):
      net: cxgb3_main: fix a missing-check bug
      net: socket: fix a missing-check bug

William Dauchy (1):
      ixgbevf: Fix handling of NAPI budget when multiple queues are enabled=
 per vector


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvnBA8ACgkQONu9yGCS
aT4DEg/9E2AqgehLQXKIsmJEyyY5tUIs8IPXFmwNs/VRryCREU/WXc3XpKbUmfMs
uszkiLkNmQHXzeaFjre32AdjlyyfVLtkGpO6xyV/NJCWe6/BFt1qUJAAEp9dQoVe
8M19IUcyDb5P86UB47j7yQ5rI05b1ExSnIDl3vx34Sng44+yRVqVbSpZTurE8AX7
GWOiV/5CWwNueUb2HEEtl4HBCeFpl+xbjRWKspLtX/wZ0EhhP9yQTF65bRiQfP58
cDilTFE2AHpsWwlVHOqNFeEBLYoICMwnzWJGzQRbjQ89Gr2rpVs9jYNPrggp6QA0
ei06BZRvhwlhqik3eiObnkuowfKyx+/xiP7M9VkZT7COt0F/pBoECGk7NnzdYCW4
KdcN7NLWEa1y6iQtwNTaKSKbMPuA/d7NFYlbtrCsCMTJ3ZQaAItFuS4/E8nha85K
lDN632Y5zywwW+NO+OoLqoGCM7A7WMFRILBNd8xy4SJ8Se1KdJrD7KcU4RmLzHEJ
a0EmcAMaG2WBKst6dvx7xfsQrPLGzE+3S3NyUw1EgYVwdKjUdQdjN6OPVl00OfbH
djHjtKx4y6mH5m++jzb+pKAPqiKaGuQFMvkyaCPtwhtUu/0mUzc9BwL5CDHVO2v6
H7Nyk3FTAgyOomycrvOqCehREZ092zQuD7bhyDVd5qekhskiiZ0=
=tlVP
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
