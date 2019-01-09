Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C6C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC6A20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058536;
	bh=1/0yX+rDe4Q2SCsJ2KP20ciceXarRMEECilhchnWGNI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fLc9YUQNNt0+pDsq65Ml1KzJ/mMDBdXr79w2s9pPrMzazdGggY1eo1fXi4f/zroY7
	 5J+0FgII75VqSjVIdcElWP/1OuqSzgVneWatlSzg9OSPOAjzU2rheZr918+s/d/eH6
	 s0muTKBcZs+/JAU8T/KAxeEnZ6azYF7z9xRdr/Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAIS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfAIS2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:28:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E978E20665;
        Wed,  9 Jan 2019 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058533;
        bh=1/0yX+rDe4Q2SCsJ2KP20ciceXarRMEECilhchnWGNI=;
        h=Date:From:To:Cc:Subject:From;
        b=s3Z7f4pghF20xg6BCNvzrJMG/AM7h8DfCPQphRu6u/8Uv0G6u+AJhf2J+dzxyvTc0
         GbXTaTFxEvqMWt3qBqXF5WywXX3SuHh6o9Ag/QR0B9tGm2x8qO17ROetp5LV6c3XcP
         +H5tMDLV7h6U7X8ojXYd0W7Cfss0i0g65ShoFWOY=
Date:   Wed, 9 Jan 2019 19:28:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.92
Message-ID: <20190109182850.GA17384@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.92 kernel.

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

 Documentation/admin-guide/kernel-parameters.txt      |    3=20
 Documentation/admin-guide/l1tf.rst                   |    6 -
 Makefile                                             |    2=20
 arch/arm64/include/asm/kvm_arm.h                     |    2=20
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c   |    7 -
 arch/mips/cavium-octeon/executive/cvmx-helper.c      |    3=20
 arch/mips/include/asm/cpu-info.h                     |    2=20
 arch/mips/include/asm/mach-loongson64/mmzone.h       |    1=20
 arch/mips/include/asm/mmu.h                          |    2=20
 arch/mips/include/asm/mmu_context.h                  |   10 -
 arch/mips/include/asm/mmzone.h                       |   13 ++
 arch/mips/include/asm/pgtable-64.h                   |    5=20
 arch/mips/include/asm/r4kcache.h                     |   22 ++++
 arch/mips/kernel/vdso.c                              |    4=20
 arch/mips/math-emu/dsemul.c                          |   38 +++----
 arch/mips/mm/c-r3k.c                                 |    2=20
 arch/mips/mm/c-r4k.c                                 |   44 +++++++-
 arch/s390/pci/pci_clp.c                              |    2=20
 arch/x86/include/asm/kvm_host.h                      |    2=20
 arch/x86/kernel/cpu/bugs.c                           |    3=20
 arch/x86/kvm/vmx.c                                   |    7 -
 arch/x86/mm/init.c                                   |    2=20
 arch/x86/mm/init_64.c                                |    6 -
 drivers/base/platform-msi.c                          |    6 -
 drivers/char/tpm/tpm-interface.c                     |   15 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                   |   11 +-
 drivers/clk/rockchip/clk-rk3188.c                    |    2=20
 drivers/crypto/cavium/nitrox/nitrox_algs.c           |   12 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c            |   22 +++-
 drivers/crypto/cavium/nitrox/nitrox_req.h            |    7 +
 drivers/infiniband/hw/hfi1/verbs.c                   |    2=20
 drivers/input/mouse/elan_i2c_core.c                  |    1=20
 drivers/isdn/capi/kcapi.c                            |    4=20
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c        |    2=20
 drivers/media/platform/vivid/vivid-vid-cap.c         |    2=20
 drivers/mtd/spi-nor/Kconfig                          |    2=20
 drivers/net/ethernet/cadence/macb_main.c             |   21 +++-
 drivers/net/ethernet/ibm/ibmveth.c                   |    6 -
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   12 --
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c      |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |    2=20
 drivers/net/ethernet/mellanox/mlxsw/core.c           |   19 +++
 drivers/net/ethernet/mellanox/mlxsw/core.h           |    3=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |    7 +
 drivers/net/phy/phy_device.c                         |    7 -
 drivers/net/usb/qmi_wwan.c                           |    5=20
 drivers/net/wan/x25_asy.c                            |    2=20
 drivers/net/xen-netfront.c                           |    2=20
 drivers/rtc/rtc-m41t80.c                             |    2=20
 drivers/spi/spi-bcm2835.c                            |   16 +--
 drivers/staging/wilc1000/wilc_sdio.c                 |    1=20
 drivers/tty/serial/xilinx_uartps.c                   |    4=20
 drivers/usb/class/cdc-acm.c                          |   10 +
 drivers/usb/class/cdc-acm.h                          |    1=20
 drivers/usb/host/r8a66597-hcd.c                      |    5=20
 drivers/usb/serial/option.c                          |    4=20
 drivers/usb/serial/pl2303.c                          |    5=20
 drivers/usb/serial/pl2303.h                          |    5=20
 drivers/vhost/vhost.c                                |    2=20
 fs/btrfs/btrfs_inode.h                               |    6 +
 fs/btrfs/inode.c                                     |   17 +++
 fs/btrfs/tree-log.c                                  |   16 +++
 fs/cifs/smb2maperror.c                               |    4=20
 fs/ext4/ext4.h                                       |    2=20
 fs/ext4/inline.c                                     |    5=20
 fs/ext4/inode.c                                      |    9 +
 fs/ext4/migrate.c                                    |   36 +++---
 fs/ext4/resize.c                                     |   74 +++++++-------
 fs/ext4/super.c                                      |   36 ++++++
 fs/ext4/xattr.c                                      |   78 +++++++-------
 fs/f2fs/super.c                                      |    6 -
 include/linux/msi.h                                  |    2=20
 include/linux/ptr_ring.h                             |    2=20
 include/net/netfilter/nf_conntrack_count.h           |   15 ++
 include/net/sock.h                                   |   38 ++++++-
 include/trace/events/ext4.h                          |   20 +++
 kernel/cgroup/cgroup.c                               |   29 +++--
 net/ax25/af_ax25.c                                   |   11 +-
 net/ax25/ax25_dev.c                                  |    2=20
 net/compat.c                                         |   15 +-
 net/core/gro_cells.c                                 |    1=20
 net/core/sock.c                                      |    3=20
 net/ieee802154/6lowpan/tx.c                          |    3=20
 net/ipv4/inet_diag.c                                 |    4=20
 net/ipv4/ip_fragment.c                               |   18 ++-
 net/ipv4/ipmr.c                                      |    3=20
 net/ipv6/ip6_tunnel.c                                |    1=20
 net/ipv6/ip6_udp_tunnel.c                            |    3=20
 net/ipv6/ip6_vti.c                                   |    1=20
 net/ipv6/ip6mr.c                                     |    4=20
 net/netfilter/xt_connlimit.c                         |   99 ++++++++++++++=
-----
 net/netrom/af_netrom.c                               |   15 +-
 net/packet/af_packet.c                               |    8 +
 net/sctp/ipv6.c                                      |    1=20
 net/smc/af_smc.c                                     |   14 ++
 net/smc/smc.h                                        |    4=20
 net/sunrpc/svcsock.c                                 |    2=20
 net/tipc/socket.c                                    |    8 +
 net/tipc/udp_media.c                                 |    9 +
 net/vmw_vsock/vmci_transport.c                       |   67 +++++++++---
 sound/core/pcm.c                                     |    2=20
 sound/firewire/amdtp-stream-trace.h                  |    4=20
 sound/firewire/amdtp-stream.c                        |    4=20
 sound/firewire/fireface/ff-protocol-ff400.c          |    2=20
 sound/pci/emu10k1/emufx.c                            |    5=20
 sound/pci/hda/hda_tegra.c                            |    2=20
 sound/pci/hda/patch_conexant.c                       |    1=20
 sound/pci/rme9652/hdsp.c                             |   10 +
 sound/synth/emux/emux_hwdep.c                        |    7 -
 tools/perf/util/pmu.c                                |    8 -
 virt/kvm/arm/vgic/vgic-mmio.c                        |    6 -
 111 files changed, 840 insertions(+), 329 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: mark RGMII interface disabled on OCTEON III

Alaa Hleihel (1):
      net/mlx5e: Remove the false indication of software timestamping suppo=
rt

Arnd Bergmann (1):
      mtd: atmel-quadspi: disallow building on ebsa110

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Bj=C3=B8rn Mork (1):
      qmi_wwan: apply SET_DTR quirk to the SIMCOM shared device ID

Claudiu Beznea (1):
      net: macb: restart tx after tx used bit read

Colin Ian King (1):
      staging: wilc1000: fix missing read_write setting when reading data

Cong Wang (8):
      ax25: fix a use-after-free in ax25_fillin_cb()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()
      netrom: fix locking in nr_find_socket()
      net/wan: fix a double free in x25_asy_open_tty()
      ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()
      tipc: fix a double kfree_skb()
      tipc: use lock_sock() in tipc_sk_reinit()
      tipc: compare remote and local protocols in tipc_udp_enable()

Dan Williams (1):
      x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_in=
it()

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Eric Dumazet (3):
      ipv6: tunnels: fix two use-after-free
      isdn: fix kernel-infoleak in capi_unlocked_ioctl
      tcp: fix a race in inet_diag_dump_icsk()

Filipe Manana (1):
      Btrfs: fix fsync of files with multiple hard links in new directories

Florian Westphal (3):
      netfilter: xt_connlimit: don't store address in the conn nodes
      netfilter: nf_conncount: fix garbage collection confirm race
      netfilter: nf_conncount: don't skip eviction when age is negative

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 4.14.92

Gustavo A. R. Silva (6):
      ipv4: Fix potential Spectre v1 vulnerability
      ip6mr: Fix potential Spectre v1 vulnerability
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: emux: Fix potential Spectre v1 vulnerabilities

Hans Verkuil (2):
      media: vivid: free bitmap_cap when updating std/timings/etc.
      media: v4l2-tpg: array index could become negative

Huacai Chen (3):
      MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Johan Jonker (1):
      clk: rockchip: fix typo in rk3188 spdif_frac parent

Jorgen Hansen (1):
      VSOCK: Send reset control packet when socket is partially bound

Juergen Gross (1):
      xen/netfront: tolerate frags with no data

J=C3=B6rgen Storvist (4):
      qmi_wwan: Added support for Telit LN940 series
      qmi_wwan: Added support for Fibocom NL668 series
      qmi_wwan: Add support for Fibocom NL678 series
      USB: serial: option: add Fibocom NL678 series

Kunihiko Hayashi (1):
      net: phy: Fix the issue that netif always links up after resuming

Lorenzo Bianconi (1):
      gro_cell: add napi_disable in gro_cells_destroy

Lukas Wunner (4):
      spi: bcm2835: Fix race on DMA termination
      spi: bcm2835: Fix book-keeping of DMA termination
      spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
      spi: bcm2835: Unbreak the build of esoteric configs

Maciej W. Rozycki (1):
      rtc: m41t80: Correct alarm month range with RTC reads

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Mantas Mikul=C4=97nas (1):
      ALSA: hda: add mute LED support for HP EliteBook 840 G4

Marc Zyngier (1):
      arm/arm64: KVM: vgic: Force VM halt when changing the active state of=
 GICv3 PPIs/SGIs

Martin Blumenstingl (1):
      f2fs: fix validation of the block count in sanity_check_raw_super

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michael J. Ruhl (1):
      IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Michal Hocko (1):
      x86/speculation/l1tf: Drop the swap storage limit restriction when l1=
tf=3Doff

Michal Kubecek (1):
      net: ipv4: do not handle duplicate fragments as overlapping

Miquel Raynal (1):
      platform-msi: Free descriptors in platform_msi_domain_free()

Myungho Jung (1):
      net/smc: fix TCP fallback socket release

Nava kishore Manne (1):
      serial: uartps: Fix interrupt mask issue to handle the RX interrupts =
properly

Pablo Neira Ayuso (1):
      netfilter: nf_conncount: expose connection list interface

Pan Bian (1):
      ext4: fix possible use after free in ext4_quota_enable

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Paul Burton (3):
      MIPS: math-emu: Write-protect delay slot emulation pages
      MIPS: Expand MIPS32 ASIDs to 64 bits
      MIPS: Only include mmzone.h when CONFIG_NEED_MULTIPLE_NODES=3Dy

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (2):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
      KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails

Sebastian Ott (1):
      s390/pci: fix sleeping in atomic during hotplug

Shalom Toledo (1):
      mlxsw: core: Increase timeout during firmware flash process

Takashi Sakamoto (4):
      ALSA: fireface: fix for state to fetch PCM frames
      ALSA: firewire-lib: fix wrong handling payload_length as payload_quad=
let
      ALSA: firewire-lib: fix wrong assignment for 'out_packet_without_head=
er' tracepoint
      ALSA: firewire-lib: use the same print format for 'without_header' tr=
acepoints

Tariq Toukan (1):
      net/mlx5e: RX, Fix wrong early return in receive queue poll

Tejun Heo (1):
      cgroup: fix CSS_TASK_ITER_PROCS

Theodore Ts'o (4):
      ext4: add ext4_sb_bread() to disambiguate ENOMEM cases
      ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
      ext4: force inode writes when nfsd calls commit_metadata()
      ext4: check for shutdown and r/o file system in ext4_write_inode()

Tomas Winkler (2):
      tpm: tpm_try_transmit() refactor error flow.
      tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Wenwen Wang (1):
      crypto: cavium/nitrox - fix a DMA pool free failure

Will Deacon (1):
      arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1

Willem de Bruijn (3):
      ieee802154: lowpan_header_create check must check daddr
      packet: validate address length
      packet: validate address length if non-zero

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yi-Hung Wei (1):
      netfilter: nf_conncount: Fix garbage collection with zones

Yuval Avnery (1):
      net/mlx5: Typo fix in del_sw_hw_rule

ruippan (=E6=BD=98=E7=9D=BF) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw2PWIACgkQONu9yGCS
aT4KQBAAxbDG97nBHt2Im5ElzwwbkXSOTAd8f624FuMlLUM0cFMLbPyMqErGNZiY
7zqDYbe7zlhte2juRAj4L2TlKL8i85yQ5cZVC+EZ6DNlRIzeqW2GYoOC4HIVR+LT
JJaScP8IVoqTHLRmXmzzhh6/E5p4z5Fu+w+WCxD3jo+kUBLfLQokNtX0YRZDV3sC
6yYgW9ukTxi9uelHxzoqEE/liebu1uAubNG3y3z+g8foPB/t08P/En7gWvHc0VcL
t0NegAyTbDjyd8jrDKo6XEED7fOrFddllEFYUqZiyVxRGoPoIGO1QWDbQAQJLYM8
y0QzJ5jTd+QNTsRisAwUlbIQqiJ79ewiRHmm73vj6bfc2XfYhO0++TvafgPe6tc1
tQMut6RZm5kqwLTi7XZ+N5gPBtgwk6cr4dmK9Ksr1ixcJJpyRsYRnE3iH4cXJntb
yzk9g01BkWBrc/PLHpE34CkoIVAU7QGMWABGZGbWiILKD71mV7TB78VlRCON3w9Y
9s4NpyzIMGEepZ9dWHRlrai0M/Sdfemlt/Bz245ZaE/fKGYdaMBz9hdyDFNCgbS3
KtdMuchsn/jDMiiGg16GR2UqTs/uwn8UAcaejxbFmgmqhIqHCT8ORHCyUwrDodTu
w+bnbbYf+IrW7C5l5fhSTPC5DtQJ4eoHNlv8wTLXDsUDjawbGMc=
=sXOe
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
