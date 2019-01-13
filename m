Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ACC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7320873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373267;
	bh=xJwrlrbfXviwOma12cjgRXL8MZz2riYyxdXJ73aWk1o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iJ09kUCw+hTnFANX8mbyBKYyEV5gZceF5KI4XCUjg0T4CfmYDyafc2BPx++U+CPQR
	 wwvSHS+ZUC/QGy2AkveXPXxLnqnSiTNUS3rjhYz2VeKlQYkHB+U5X8XdzgJmVHbak7
	 RjhYvZ0AQpQaJYVDAEdA/XmQo8LQjtXGz5RC+SrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfAMJy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfAMJyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:54:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12D9620873;
        Sun, 13 Jan 2019 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373264;
        bh=xJwrlrbfXviwOma12cjgRXL8MZz2riYyxdXJ73aWk1o=;
        h=Date:From:To:Cc:Subject:From;
        b=dDC1BGjT2ySZWGbGRslVj5n4mkPrfpf6RwwiAlKgtH0h/hgBFNZoavklqW5zBLJpR
         SVRQ8vzXVjX5QkSu5BHBQ6dWFxorBpGuScCcrO0xmP7xTY6x3anJFnkUg1PK6L0JjI
         Uux2nJNlrvnumPSh9Dl3mSyMwQAF+EBRK4dh74hM=
Date:   Sun, 13 Jan 2019 10:54:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.170
Message-ID: <20190113095421.GA17779@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.170 kernel.

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

 Makefile                                           |    2=20
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |    2=20
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |    7 +-
 arch/mips/include/asm/pgtable-64.h                 |    5 +
 arch/powerpc/boot/crt0.S                           |    4 -
 arch/x86/crypto/chacha20_glue.c                    |    1=20
 arch/x86/include/asm/kvm_host.h                    |    2=20
 arch/x86/kernel/cpu/mtrr/if.c                      |    2=20
 arch/x86/kvm/vmx.c                                 |   19 +++++
 arch/x86/kvm/x86.c                                 |    3=20
 drivers/gpio/gpio-max7301.c                        |   12 ---
 drivers/gpu/drm/drm_ioctl.c                        |   10 ++-
 drivers/hv/vmbus_drv.c                             |   20 ++++++
 drivers/hwtracing/intel_th/msu.c                   |    3=20
 drivers/input/keyboard/omap4-keypad.c              |   16 +----
 drivers/input/mouse/elan_i2c_core.c                |    1=20
 drivers/iommu/intel-iommu.c                        |    4 -
 drivers/isdn/capi/kcapi.c                          |    4 -
 drivers/media/platform/vivid/vivid-vid-cap.c       |    2=20
 drivers/misc/genwqe/card_utils.c                   |    2=20
 drivers/mmc/core/mmc.c                             |    4 -
 drivers/mmc/host/omap_hsmmc.c                      |   12 +++
 drivers/net/ethernet/ibm/ibmveth.c                 |    6 +
 drivers/net/usb/hso.c                              |   18 +++++
 drivers/net/wireless/b43/phy_common.c              |    2=20
 drivers/net/xen-netfront.c                         |    2=20
 drivers/power/olpc_battery.c                       |    4 -
 drivers/s390/scsi/zfcp_aux.c                       |    6 -
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |    2=20
 drivers/spi/spi-bcm2835.c                          |   16 ++---
 drivers/usb/class/cdc-acm.c                        |   10 +++
 drivers/usb/class/cdc-acm.h                        |    1=20
 drivers/usb/host/r8a66597-hcd.c                    |    5 +
 drivers/usb/host/xhci-hub.c                        |    3=20
 drivers/usb/serial/option.c                        |   20 +++++-
 drivers/usb/serial/pl2303.c                        |    5 +
 drivers/usb/serial/pl2303.h                        |    5 +
 drivers/vhost/vhost.c                              |    2=20
 fs/ceph/caps.c                                     |    1=20
 fs/cifs/smb2maperror.c                             |    4 -
 fs/dlm/lock.c                                      |   17 +++--
 fs/dlm/lockspace.c                                 |    2=20
 fs/ext4/inline.c                                   |    5 +
 fs/ext4/resize.c                                   |    2=20
 fs/ext4/super.c                                    |   13 +++-
 fs/gfs2/rgrp.c                                     |    2=20
 include/net/gro_cells.h                            |    1=20
 include/net/sock.h                                 |   36 ++++++++++-
 include/trace/events/ext4.h                        |   20 ++++++
 include/uapi/linux/input-event-codes.h             |    9 ++
 kernel/fork.c                                      |   13 +++-
 kernel/memremap.c                                  |   11 +--
 mm/memory_hotplug.c                                |   16 +++++
 net/9p/client.c                                    |   21 ++++++
 net/ax25/af_ax25.c                                 |   11 ++-
 net/ax25/ax25_dev.c                                |    2=20
 net/compat.c                                       |   15 ++--
 net/core/sock.c                                    |    3=20
 net/ieee802154/6lowpan/tx.c                        |    3=20
 net/ipv4/ipmr.c                                    |    2=20
 net/ipv6/ip6_udp_tunnel.c                          |    3=20
 net/ipv6/ip6mr.c                                   |    4 +
 net/netrom/af_netrom.c                             |   15 +++-
 net/packet/af_packet.c                             |    8 +-
 net/sctp/ipv6.c                                    |    1=20
 net/sunrpc/auth_gss/svcauth_gss.c                  |    8 +-
 net/sunrpc/cache.c                                 |   10 ++-
 net/sunrpc/svcsock.c                               |    2=20
 net/vmw_vsock/vmci_transport.c                     |   67 +++++++++++++++-=
-----
 net/xfrm/xfrm_state.c                              |    2=20
 scripts/checkstack.pl                              |    4 -
 sound/core/pcm.c                                   |    2=20
 sound/pci/cs46xx/dsp_spos.c                        |    3=20
 sound/pci/emu10k1/emufx.c                          |    5 +
 sound/pci/hda/hda_tegra.c                          |    2=20
 sound/pci/hda/patch_conexant.c                     |    1=20
 sound/pci/rme9652/hdsp.c                           |   10 +--
 sound/synth/emux/emux_hwdep.c                      |    7 +-
 sound/usb/mixer.c                                  |   10 ++-
 sound/usb/quirks-table.h                           |    3=20
 tools/perf/util/pmu.c                              |    8 +-
 81 files changed, 484 insertions(+), 144 deletions(-)

Alexander Shishkin (1):
      intel_th: msu: Fix an off-by-one in attribute store

Andreas Gruenbacher (1):
      gfs2: Fix loop in gfs2_rbm_find

Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Christian Borntraeger (1):
      genwqe: Fix size check

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Colin Ian King (1):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Cong Wang (3):
      ax25: fix a use-after-free in ax25_fillin_cb()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()
      netrom: fix locking in nr_find_socket()

Dan Carpenter (2):
      scsi: bnx2fc: Fix NULL dereference in error handling
      ALSA: cs46xx: Potential NULL dereference in probe

Dan Williams (2):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: kill mapping "System RAM" support

David Herrmann (1):
      fork: record start_time late

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Eric Biggers (1):
      crypto: x86/chacha20 - avoid sleeping with preemption disabled

Eric Dumazet (1):
      isdn: fix kernel-infoleak in capi_unlocked_ioctl

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 4.4.170

Gustavo A. R. Silva (7):
      drm/ioctl: Fix Spectre v1 vulnerabilities
      ip6mr: Fix potential Spectre v1 vulnerability
      ipv4: Fix potential Spectre v1 vulnerability
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: emux: Fix potential Spectre v1 vulnerabilities

Hans Verkuil (1):
      media: vivid: free bitmap_cap when updating std/timings/etc.

Huacai Chen (2):
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB

Hui Peng (2):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Jorgen Hansen (1):
      VSOCK: Send reset control packet when socket is partially bound

Juergen Gross (1):
      xen/netfront: tolerate frags with no data

J=C3=B6rgen Storvist (5):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series
      USB: serial: option: add Fibocom NL678 series

Larry Finger (1):
      b43: Fix error in cordic routine

Lorenzo Bianconi (1):
      gro_cell: add napi_disable in gro_cells_destroy

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Lukas Wunner (4):
      spi: bcm2835: Fix race on DMA termination
      spi: bcm2835: Fix book-keeping of DMA termination
      spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
      spi: bcm2835: Unbreak the build of esoteric configs

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Mantas Mikul=C4=97nas (1):
      ALSA: hda: add mute LED support for HP EliteBook 840 G4

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michal Hocko (1):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Pan Bian (1):
      ext4: fix possible use after free in ext4_quota_enable

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

Qian Cai (1):
      checkstack.pl: fix for aarch64

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (1):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Takashi Iwai (1):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()

Theodore Ts'o (1):
      ext4: force inode writes when nfsd calls commit_metadata()

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle sta=
tes

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Ulf Hansson (1):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs

Vasily Averin (6):
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()

Vitaly Kuznetsov (1):
      x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when=
 running nested

Willem de Bruijn (3):
      ieee802154: lowpan_header_create check must check daddr
      packet: validate address length
      packet: validate address length if non-zero

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export

ruippan (=E6=BD=98=E7=9D=BF) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7Cs0ACgkQONu9yGCS
aT75qg/+PL/sNx8mRNIQfBI3cFG/+1gv0HQzOl9vqjcJgYYnOrthD/nuVrmzv+/B
Rh/p/eA+c/2IHTRPdgxgAfvmuO1kxu2X+IEnYvtKhkh/iQLgt13ZswjPaQlCblmz
gNFv8HZ3H3qqrZfy9VGWW84ZbqazlMZdRFNtsWidVm4r17EyV7MsYkDbxeAqcWct
ebukS9f1lzpHOsbu9yv5UYHpe5VXSSD5+fDLLKmXlzV7vQP1asx+u/6iZAHXrOYW
eRAZH6ZDvx72QlPxalWC3xcUrmG1LKOnPbta560QJCz9kd/wFj/f0aFetQgxunB3
g73oTkG9FRSqdXwGPtdEOC7OZwwrXk4jRohqXFvm7i3jxqut/LznZZZClYQieLmd
7LN07XOEqs+Sx1s/aON9Ia7pW8tSx1qqlyvAVesQL0QsISBZ6UmqHBpU1BINiGDy
KUpECZHh3DKaWp9G1hykd6/yHuxLovQ4KZ19lseA9BnHjPsH7lsSxfmoMRdThptu
kZzLvihd5tKLoE68lYxZ0INouI8zM2l3ry5WX2usoT5r5UZfDdKtdKYG/oobnJ6t
jwnFBRKinxCfZVk/oFXIPQ7yIpY+nfWs8/McWlnISQb6g6TaA1qiGC4qPmrLvftm
iEmPrxlKSQb+uBSnfF8ra6zGfNyjAwdUwxOj/ko4boYArzQGLgk=
=JuxD
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
