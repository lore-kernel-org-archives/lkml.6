Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0246DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B33520894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B33520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeH1RhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:37:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeH1RhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:37:04 -0400
Received: from localhost (unknown [104.153.224.167])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AE98EC7;
        Tue, 28 Aug 2018 13:45:18 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:45:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.120
Message-ID: <20180828134510.GA9468@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.120 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                           |    2=20
 arch/arm/boot/dts/am3517.dtsi                      |    5 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2=20
 arch/arm/boot/dts/da850.dtsi                       |    6 --
 arch/arm/configs/imx_v4_v5_defconfig               |    2=20
 arch/arm/mach-pxa/irq.c                            |    4 -
 arch/arm64/kernel/smp.c                            |    2=20
 arch/m68k/include/asm/mcf_pgalloc.h                |    4 +
 drivers/dma/k3dma.c                                |    2=20
 drivers/gpu/drm/armada/armada_hw.h                 |    1=20
 drivers/gpu/drm/armada/armada_overlay.c            |   30 +++++++---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   29 ++++++---
 drivers/gpu/drm/exynos/regs-gsc.h                  |    1=20
 drivers/isdn/i4l/isdn_common.c                     |    8 --
 drivers/md/raid10.c                                |    7 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    6 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    6 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    2=20
 drivers/net/ethernet/cisco/enic/enic_clsf.c        |    3 -
 drivers/net/ethernet/cisco/enic/enic_main.c        |    3 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |   12 +++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |    2=20
 drivers/net/ethernet/qualcomm/qca_spi.c            |    5 +
 drivers/net/ethernet/ti/davinci_emac.c             |    4 +
 drivers/net/hamradio/bpqether.c                    |    8 --
 drivers/net/usb/rtl8150.c                          |    2=20
 drivers/net/usb/smsc75xx.c                         |   62 ++++++++++++++++=
+++++
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |    7 ++
 drivers/pci/hotplug/pci_hotplug_core.c             |    9 +++
 drivers/staging/android/ion/ion.c                  |   17 ++++-
 drivers/tty/serial/8250/8250_dw.c                  |    2=20
 drivers/usb/dwc2/hcd_intr.c                        |    3 -
 drivers/usb/gadget/composite.c                     |    3 +
 drivers/usb/serial/sierra.c                        |    4 -
 fs/reiserfs/xattr.c                                |    4 +
 include/net/af_vsock.h                             |    4 -
 include/net/llc.h                                  |    5 +
 include/net/net_namespace.h                        |    1=20
 include/net/netns/ipv6.h                           |    1=20
 kernel/locking/lockdep.c                           |   12 ++--
 kernel/trace/trace.c                               |    5 +
 net/bluetooth/sco.c                                |    3 -
 net/core/dev.c                                     |    4 -
 net/dccp/ccids/ccid2.c                             |    6 +-
 net/ipv4/netfilter/ip_tables.c                     |    1=20
 net/ipv4/tcp.c                                     |    4 -
 net/ipv6/mcast.c                                   |    9 ++-
 net/ipv6/netfilter/ip6_tables.c                    |    1=20
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    6 +-
 net/l2tp/l2tp_core.c                               |    2=20
 net/llc/llc_core.c                                 |    4 -
 net/netfilter/nf_conntrack_proto_dccp.c            |    8 +-
 net/packet/af_packet.c                             |   10 ++-
 net/sched/cls_tcindex.c                            |    8 +-
 net/vmw_vsock/af_vsock.c                           |   15 ++---
 net/vmw_vsock/vmci_transport.c                     |    3 -
 net/xfrm/xfrm_user.c                               |    8 +-
 security/smack/smack_lsm.c                         |    1=20
 sound/core/memalloc.c                              |    8 --
 sound/core/seq/seq_virmidi.c                       |   10 +++
 sound/pci/cs5535audio/cs5535audio.h                |    6 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |    4 -
 sound/pci/vx222/vx222_ops.c                        |    8 +-
 sound/pcmcia/vx/vxp_ops.c                          |   10 +--
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    2=20
 tools/testing/selftests/sync/config                |    4 +
 67 files changed, 315 insertions(+), 128 deletions(-)

Adam Ford (1):
      ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible if po=
ssible

BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reasse=
mble

Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Chen Hu (1):
      serial: 8250_dw: always set baud rate in dw8250_set_termios

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when set_in=
terface

Cong Wang (2):
      llc: use refcount_inc_not_zero() for llc_sap_find()
      vsock: split dwork to avoid reinitializations

Dan Carpenter (2):
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
      qlogic: check kstrtoul() for errors

Daniel Mack (2):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Daniel Rosenberg (1):
      staging: android: ion: check for kref overflow

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

Eric Dumazet (2):
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
      xfrm_user: prevent leaking 2 bytes of kernel memory

Fabio Estevam (1):
      ARM: imx_v4_v5_defconfig: Select ULPI support

Fathi Boudra (1):
      selftests: sync: add config fragment for testing sync framework

Florian Westphal (2):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior=
 state

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Govindarajulu Varadarajan (1):
      enic: initialize enic->rfs_h.lock in enic_probe

Greg Kroah-Hartman (1):
      Linux 3.18.120

Greg Ungerer (1):
      m68k: fix "bad page state" oops on ColdFire boot

Hangbin Liu (3):
      net_sched: Fix missing res info when create new tc_index filter
      net_sched: fix NULL pointer dereference when delete tcindex filter
      ipv6: mcast: fix unsolicited report interval after receiving querys

Jann Horn (1):
      reiserfs: fix broken xattr handling (heap corruption, bad retval)

John Ogness (1):
      USB: serial: sierra: fix potential deadlock at close

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kees Cook (1):
      isdn: Disable IIOCDBGVAR

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Lukas Wunner (1):
      PCI: hotplug: Don't leak pci_slot on registration failure

Marek Szyprowski (1):
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Randy Dunlap (1):
      tcp: identify cryptic messages as TCP seq # bugs

Russell King (1):
      drm/armada: fix colorkey mode property

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Stefan Agner (1):
      net: hamradio: use eth_broadcast_addr

Stefan Wahren (2):
      net: qca_spi: Avoid packet drop during initial sync
      net: qca_spi: Make sure the QCA7000 reset is triggered

Steven Rostedt (VMware) (1):
      locking/lockdep: Do not record IRQ state within lockdep code

Sudarsana Reddy Kalluru (1):
      bnx2x: Fix receiving tx-timeout in error or recovery state.

Sudip Mukherjee (1):
      Bluetooth: avoid killing an already killed socket

Takashi Iwai (5):
      ALSA: vx222: Fix invalid endian conversions
      ALSA: virmidi: Fix too long output trigger loop
      ALSA: cs5535audio: Fix invalid endian conversion
      ALSA: memalloc: Don't exceed over the requested size
      ALSA: vxpocket: Fix invalid endian conversions

Wei Wang (1):
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Willem de Bruijn (1):
      packet: refine ring v3 block size test to hold one frame

William Wu (1):
      usb: dwc2: fix isoc split in transfer with no data

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluFUeMACgkQONu9yGCS
aT6zLg/+JGnuhk/MbgOgM4gk92TFi3YU0PthayvLOiPLwcLMQ9iKeEAydVfBWBpL
wWz6ba5tJBnk1pziyf5YiNE9PSOUYB8fRWfbk1nL2vWkYPUOb+7Dw0v6+5whogdR
2abP/93kCvBSyU22F2kHlB0vNtBAcOa7RXcphqj0yXrHP6d783AtMFsWQJcTBKGF
5tCnm69BZjupqgCboOz2wOoHsaexcZw/q3aI1qaAOzcY2cpDn3COIsqpLge915EX
GKcNfrIb+CwEWvAFwFB/1+wb99aXsrMto6BqH81povozmq9orngCghc18OPK+zNR
BOnlhCQLaPYyPRJu9izhMrIZ1GXeNuNHNI53BglabwbiVwNqq+n0TFCr2oLFB5VR
uh7RebBqvmsEZx7CUIMoNQmyQDTGNrrtW43cJx2Ycpl2HIh8XGMpUuSojgCreDcH
nsoeVz87AYCaWorucVYgNFlgE4UbGAN+H3wtncHwSRlONDFal5RqtfCbQXYz2DDG
AHfmSSbK6ztboZ0wuo0ROCudYvE+XFcEVWGsH/26N9L9WkhbODpBb1km4AaD9yV9
xGMOfNNCHjC7ekyvnrZZeMP4DyE7BLvHSpaOZJUTYks0hIwFcTBPx6sM5AR9qx+4
rJqwrRfL7bBkzcd8dK5tOWzNBqdhD5YWo8KdRpHiYYcMu8sJUHQ=
=V5IN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
