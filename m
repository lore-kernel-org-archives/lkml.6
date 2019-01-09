Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CDC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AA420665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058507;
	bh=NjzdMd0/idtB5ptnqnqdrwgEhfjvxNa9y9JtyFy/koQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=j2KIhhlUbBUY38pa/n70ktpvXAAr5Jv/uX+XYYG94RNBQLu5dPS1sEWp2qQxSvvXl
	 PxNJdhR1Cmg0FZKJLWLp0Zhr3P6QOBe4zT2okJvbJ/mdUTt/PhK9dnvJXpeDxvBW4F
	 a9kXVgmINtWfsbBlixdkHidNS+iLJ0cC9zFzLbYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAIS20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfAIS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:28:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB56920665;
        Wed,  9 Jan 2019 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058504;
        bh=NjzdMd0/idtB5ptnqnqdrwgEhfjvxNa9y9JtyFy/koQ=;
        h=Date:From:To:Cc:Subject:From;
        b=HQYHJTGvGanvCljLcvB9TxPwiAF2+wcRhAftXFhA6aOKVisdqRNE/h0yGrkabMZQ/
         gBrXetVvRzldyaaM5/+wMzFqVxinX8XFnsWRg3emEaGeDLSfmSyOrkd0x8V/h5m9El
         +12f/Latv/8UgOQDAOEkxw8dcwI5ZXcMh4znzMLg=
Date:   Wed, 9 Jan 2019 19:28:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.149
Message-ID: <20190109182821.GA17303@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.149 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                             |    2=20
 arch/arm64/include/asm/kvm_arm.h                     |    2=20
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c   |    7 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c      |    3=20
 arch/mips/include/asm/pgtable-64.h                   |    5 +
 arch/x86/include/asm/kvm_host.h                      |    2=20
 arch/x86/kvm/vmx.c                                   |   19 ++++-
 arch/x86/kvm/x86.c                                   |    3=20
 drivers/base/platform-msi.c                          |    6 +
 drivers/char/tpm/tpm_i2c_nuvoton.c                   |   11 +--
 drivers/clk/rockchip/clk-rk3188.c                    |    2=20
 drivers/input/mouse/elan_i2c_core.c                  |    1=20
 drivers/isdn/capi/kcapi.c                            |    4 -
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c        |    2=20
 drivers/media/platform/vivid/vivid-vid-cap.c         |    2=20
 drivers/mtd/spi-nor/Kconfig                          |    2=20
 drivers/net/ethernet/ibm/ibmveth.c                   |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   11 ---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |    2=20
 drivers/net/phy/phy_device.c                         |    7 -
 drivers/net/usb/qmi_wwan.c                           |    2=20
 drivers/net/wan/x25_asy.c                            |    2=20
 drivers/net/xen-netfront.c                           |    2=20
 drivers/nfc/nxp-nci/firmware.c                       |    2=20
 drivers/nfc/nxp-nci/i2c.c                            |    2=20
 drivers/rtc/rtc-m41t80.c                             |    2=20
 drivers/spi/spi-bcm2835.c                            |   16 +---
 drivers/staging/wilc1000/wilc_sdio.c                 |    1=20
 drivers/tty/serial/xilinx_uartps.c                   |    4 -
 drivers/usb/class/cdc-acm.c                          |   10 ++
 drivers/usb/class/cdc-acm.h                          |    1=20
 drivers/usb/host/r8a66597-hcd.c                      |    5 +
 drivers/usb/serial/option.c                          |    4 +
 drivers/usb/serial/pl2303.c                          |    5 +
 drivers/usb/serial/pl2303.h                          |    5 +
 drivers/vhost/vhost.c                                |    2=20
 fs/cifs/smb2maperror.c                               |    4 -
 fs/ext4/inline.c                                     |    5 +
 fs/ext4/resize.c                                     |    2=20
 fs/ext4/super.c                                      |   13 +++
 fs/ext4/xattr.c                                      |    2=20
 fs/f2fs/super.c                                      |    6 -
 include/linux/msi.h                                  |    2=20
 include/linux/ptr_ring.h                             |    2=20
 include/net/gro_cells.h                              |    1=20
 include/net/sock.h                                   |   36 +++++++++-
 include/trace/events/ext4.h                          |   20 +++++
 net/ax25/af_ax25.c                                   |   11 ++-
 net/ax25/ax25_dev.c                                  |    2=20
 net/compat.c                                         |   15 ++--
 net/core/sock.c                                      |    3=20
 net/ieee802154/6lowpan/tx.c                          |    3=20
 net/ipv4/ip_fragment.c                               |   18 +++--
 net/ipv4/ipmr.c                                      |    3=20
 net/ipv6/ip6_tunnel.c                                |    1=20
 net/ipv6/ip6_udp_tunnel.c                            |    3=20
 net/ipv6/ip6_vti.c                                   |    1=20
 net/ipv6/ip6mr.c                                     |    4 +
 net/netrom/af_netrom.c                               |   15 ++--
 net/packet/af_packet.c                               |    8 +-
 net/sctp/ipv6.c                                      |    1=20
 net/sunrpc/svcsock.c                                 |    2=20
 net/tipc/socket.c                                    |    8 +-
 net/tipc/udp_media.c                                 |    9 +-
 net/vmw_vsock/vmci_transport.c                       |   67 ++++++++++++++=
-----
 sound/core/pcm.c                                     |    2=20
 sound/pci/emu10k1/emufx.c                            |    5 +
 sound/pci/hda/hda_tegra.c                            |    2=20
 sound/pci/hda/patch_conexant.c                       |    1=20
 sound/pci/rme9652/hdsp.c                             |   10 +-
 sound/synth/emux/emux_hwdep.c                        |    7 +
 tools/perf/util/pmu.c                                |    8 +-
 72 files changed, 347 insertions(+), 119 deletions(-)

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

Colin Ian King (1):
      staging: wilc1000: fix missing read_write setting when reading data

Cong Wang (8):
      ax25: fix a use-after-free in ax25_fillin_cb()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()
      netrom: fix locking in nr_find_socket()
      net/wan: fix a double free in x25_asy_open_tty()
      tipc: fix a double kfree_skb()
      tipc: use lock_sock() in tipc_sk_reinit()
      tipc: compare remote and local protocols in tipc_udp_enable()
      ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Eric Dumazet (2):
      ipv6: tunnels: fix two use-after-free
      isdn: fix kernel-infoleak in capi_unlocked_ioctl

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 4.9.149

Guenter Roeck (1):
      NFC: nxp-nci: Include unaligned.h instead of access_ok.h

Gustavo A. R. Silva (6):
      ip6mr: Fix potential Spectre v1 vulnerability
      ipv4: Fix potential Spectre v1 vulnerability
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: emux: Fix potential Spectre v1 vulnerabilities

Hans Verkuil (2):
      media: vivid: free bitmap_cap when updating std/timings/etc.
      media: v4l2-tpg: array index could become negative

Huacai Chen (2):
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

J=C3=B6rgen Storvist (1):
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

Martin Blumenstingl (1):
      f2fs: fix validation of the block count in sanity_check_raw_super

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michal Kubecek (1):
      net: ipv4: do not handle duplicate fragments as overlapping

Miquel Raynal (1):
      platform-msi: Free descriptors in platform_msi_domain_free()

Nava kishore Manne (1):
      serial: uartps: Fix interrupt mask issue to handle the RX interrupts =
properly

Pan Bian (1):
      ext4: fix possible use after free in ext4_quota_enable

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (1):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Theodore Ts'o (2):
      ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
      ext4: force inode writes when nfsd calls commit_metadata()

Tomas Winkler (1):
      tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Vitaly Kuznetsov (1):
      x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when=
 running nested

Will Deacon (1):
      arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1

Willem de Bruijn (3):
      ieee802154: lowpan_header_create check must check daddr
      packet: validate address length
      packet: validate address length if non-zero

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yuval Avnery (1):
      net/mlx5: Typo fix in del_sw_hw_rule

ruippan (=E6=BD=98=E7=9D=BF) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw2PUUACgkQONu9yGCS
aT5xiQ/+In8EK9YmpFzKP4GrfZKmHx15LAeQNLX9jPAO1PH/zZjUyDvKH3IB/rqj
i/Tu2QyRXZbsOU7fRHkbqHCekotaQZD7AmikLExZuG61Kr4hvZdrUvS2z5kmBhzt
px2bQyLidje0H+He8v5MKfENywh7i6N6tJnwhJz3ncbPlkWt0WY5qlYUK5kCz+4J
LFYs3aBFHJreCOLdydDhmtA95s93UZXCmwQkaRiwp886ftU13SnNbhkB+R2CdU08
itqtDn7hjA4MdGO1DarBCPWk2YRsYOg5Hw/zB6bniaE3uBTV7QTXCYtQgPE51gQt
RGpzdSbW953fNE1CJkza9RDQSyBQPtGWZXISnBk4zrSAvOHX9pP+D1HBmYopblVm
4aA1QxgNiOqIWEs2RKpmUHnJqpShDOqXnY0O+NTKVc2tb8Nhof526VtUDSj4mtwU
72v8GcxSILr5at/lQ5VcAxPVQH2N/TwxkuWQ9HpWT3N/OiwfHTB8ie5r0xMAq+fo
dz2aviKtm4w3fb+WgVQdWkkwqNok72a3k/Yb5xXoLxoa6oIMrLHe4k26h6C8+4do
3VjKD8JKaytFzpDyy/rJ746TlaBzdqGXEwB4JzNafjdIDV0f2ensiCSouH/S/4eQ
uDv/4bzeFbF2ACmuyQKiDNXPpxRzKEoMsNSB3aAAlyMnoWS0Z+0=
=pKrv
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
