Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620E02080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vztI/vlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620E02080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbeLBHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbeLBHfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:35:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D066F206B7;
        Sun,  2 Dec 2018 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736149;
        bh=qQ4CVWkm5QyiRD+1VftR8H4UMRFcfs9i8z/n1QH2Hzw=;
        h=Date:From:To:Cc:Subject:From;
        b=vztI/vlXJCWcQ5a2gAMgKDijIplQpVNu2EEHgR7I1Htf5JxeB0BZmX2NYZ/W9qbuX
         okZVGqs4dajwJGV7QCiJogXyzsDwIPH24VN1/JxWw2RBBmK/LtzQfLhNUmuRsTtq4p
         QKaJWzoPJ7yl66W46xzqCscxPkkMW4dXQjhy/1sc=
Date:   Sun, 2 Dec 2018 08:35:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.85
Message-ID: <20181202073546.GA32381@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.85 kernel.

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

 Documentation/devicetree/bindings/net/can/holt_hi311x.txt   |    2=20
 Documentation/sysctl/fs.txt                                 |   36 +++
 MAINTAINERS                                                 |    1=20
 Makefile                                                    |   10 -
 arch/arm/Makefile                                           |    2=20
 arch/arm/boot/compressed/Makefile                           |    2=20
 arch/arm/boot/dts/exynos5420-peach-pit.dts                  |    4=20
 arch/arm/boot/dts/exynos5800-peach-pi.dts                   |    4=20
 arch/arm/firmware/trusted_foundations.c                     |   14 -
 arch/arm64/Makefile                                         |    2=20
 arch/powerpc/include/asm/io.h                               |   20 --
 arch/powerpc/kvm/trace.h                                    |    8=20
 arch/powerpc/kvm/trace_booke.h                              |    9=20
 arch/powerpc/kvm/trace_hv.h                                 |    9=20
 arch/powerpc/kvm/trace_pr.h                                 |    9=20
 arch/powerpc/mm/numa.c                                      |    2=20
 arch/s390/mm/gmap.c                                         |    2=20
 arch/x86/events/intel/uncore_snb.c                          |  115 +++++++=
++++-
 crypto/simd.c                                               |    5=20
 drivers/base/core.c                                         |    2=20
 drivers/block/floppy.c                                      |    3=20
 drivers/bus/arm-cci.c                                       |    2=20
 drivers/clk/samsung/clk-exynos5250.c                        |    6=20
 drivers/cpufreq/imx6q-cpufreq.c                             |    7=20
 drivers/firmware/efi/arm-init.c                             |    4=20
 drivers/firmware/efi/arm-runtime.c                          |    2=20
 drivers/firmware/efi/libstub/Makefile                       |    3=20
 drivers/firmware/efi/memmap.c                               |    3=20
 drivers/gpio/gpiolib.c                                      |    5=20
 drivers/gpu/drm/ast/ast_drv.c                               |   21 ++
 drivers/gpu/drm/ast/ast_mode.c                              |    3=20
 drivers/gpu/drm/mediatek/mtk_hdmi.c                         |    5=20
 drivers/infiniband/core/verbs.c                             |    5=20
 drivers/infiniband/hw/hfi1/user_sdma.c                      |   87 ++++---=
--
 drivers/infiniband/hw/hfi1/user_sdma.h                      |    3=20
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                   |    2=20
 drivers/input/joystick/xpad.c                               |   45 ++--
 drivers/input/mouse/synaptics.c                             |    4=20
 drivers/mmc/host/sdhci-pci-core.c                           |    7=20
 drivers/mtd/nand/atmel/nand-controller.c                    |   11 -
 drivers/mtd/ubi/build.c                                     |    1=20
 drivers/mtd/ubi/eba.c                                       |    4=20
 drivers/mtd/ubi/fastmap.c                                   |   20 ++
 drivers/mtd/ubi/ubi.h                                       |   11 +
 drivers/mtd/ubi/vmt.c                                       |    1=20
 drivers/mtd/ubi/vtbl.c                                      |   16 +
 drivers/net/can/dev.c                                       |   48 +++--
 drivers/net/can/flexcan.c                                   |    4=20
 drivers/net/can/rx-offload.c                                |   51 +++++
 drivers/net/can/spi/hi311x.c                                |    2=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c                |    2=20
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c       |    1=20
 drivers/net/usb/lan78xx.c                                   |   42 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    3=20
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                 |   40 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |   12 -
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                |    5=20
 drivers/nfc/nfcmrvl/uart.c                                  |    5=20
 drivers/of/base.c                                           |   25 ++
 drivers/pci/endpoint/pci-ep-cfs.c                           |   14 -
 drivers/pinctrl/meson/pinctrl-meson.c                       |    2=20
 drivers/power/supply/twl4030_charger.c                      |    5=20
 drivers/rtc/rtc-omap.c                                      |    3=20
 drivers/rtc/rtc-pcf2127.c                                   |    3=20
 drivers/tty/n_tty.c                                         |   20 +-
 drivers/tty/tty_buffer.c                                    |    6=20
 drivers/usb/core/hub.c                                      |    4=20
 drivers/usb/dwc3/core.c                                     |    1=20
 drivers/usb/dwc3/gadget.c                                   |    8=20
 drivers/usb/host/xhci-hub.c                                 |   66 +++++-
 drivers/usb/host/xhci-pci.c                                 |    5=20
 drivers/usb/host/xhci-ring.c                                |   38 +++
 drivers/usb/host/xhci.c                                     |    6=20
 drivers/usb/host/xhci.h                                     |   67 +++---
 fs/9p/vfs_dir.c                                             |   11 -
 fs/bfs/inode.c                                              |    9=20
 fs/gfs2/ops_fstype.c                                        |    2=20
 fs/namei.c                                                  |   53 +++++
 include/linux/can/dev.h                                     |    1=20
 include/linux/can/rx-offload.h                              |    7=20
 include/linux/fs.h                                          |    2=20
 include/linux/integrity.h                                   |    1=20
 include/linux/of.h                                          |    8=20
 include/linux/pfn_t.h                                       |    2=20
 include/net/sock.h                                          |    1=20
 kernel/debug/kdb/kdb_io.c                                   |   15 -
 kernel/debug/kdb/kdb_private.h                              |    2=20
 kernel/debug/kdb/kdb_support.c                              |   10 -
 kernel/rcu/tree.c                                           |    9=20
 kernel/sysctl.c                                             |   18 +
 mm/memory.c                                                 |   34 +++
 mm/page_alloc.c                                             |   20 --
 mm/shmem.c                                                  |    4=20
 mm/slab.c                                                   |    4=20
 mm/slab_common.c                                            |   12 -
 mm/z3fold.c                                                 |  101 ++++++-=
---
 net/can/raw.c                                               |   15 -
 net/core/sock.c                                             |    2=20
 net/ieee802154/6lowpan/6lowpan_i.h                          |    4=20
 net/ieee802154/6lowpan/reassembly.c                         |   14 -
 net/ipv4/tcp.c                                              |   11 -
 net/llc/af_llc.c                                            |   11 -
 net/sctp/associola.c                                        |   10 -
 net/sunrpc/auth_generic.c                                   |    8=20
 security/integrity/evm/evm.h                                |    2=20
 security/integrity/evm/evm_crypto.c                         |   75 ++++++-
 security/integrity/evm/evm_main.c                           |   29 +--
 security/integrity/iint.c                                   |    3=20
 security/integrity/ima/ima_api.c                            |   67 ++++--
 security/integrity/ima/ima_appraise.c                       |   31 +--
 security/integrity/ima/ima_crypto.c                         |   10 +
 security/integrity/ima/ima_main.c                           |   77 +++++---
 security/integrity/integrity.h                              |   18 +
 security/selinux/ss/policydb.c                              |    2=20
 sound/core/oss/pcm_oss.c                                    |    6=20
 sound/core/oss/pcm_plugin.c                                 |    6=20
 tools/power/cpupower/bench/Makefile                         |    2=20
 tools/power/cpupower/lib/cpufreq.c                          |    2=20
 tools/power/cpupower/lib/cpuidle.c                          |    2=20
 tools/power/cpupower/lib/cpupower.c                         |    4=20
 tools/power/cpupower/lib/cpupower_intern.h                  |    2=20
 121 files changed, 1253 insertions(+), 513 deletions(-)

Aaron Ma (2):
      usb: xhci: fix timeout for transition from RExit to U0
      usb: xhci: fix uninitialized completion when USB3 port got wrong stat=
us

Alexander Aring (1):
      net: ieee802154: 6lowpan: fix frag reassembly

Alexandre Belloni (1):
      rtc: omap: fix error path when pinctrl_register fails

Alistair Strachan (1):
      efi/libstub: arm: support building with clang

Andrew Price (1):
      gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Andy Shevchenko (1):
      usb: dwc3: core: Clean up ULPI device

Aneesh Kumar K.V (1):
      mm/memory.c: recheck page table entry with page table lock held

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Ard Biesheuvel (2):
      crypto: simd - correctly take reqsize of wrapped skcipher into account
      efi/arm: Revert deferred unmap of early memmap mapping

Cherian, George (1):
      xhci: Add quirk to workaround the errata seen on Cavium Thunder-X2 Soc

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dmitry Kasatkin (1):
      ima: re-introduce own integrity cache lock

Dmitry Torokhov (1):
      Input: synaptics - avoid using uninitialized variable when probing

Dmitry Vyukov (1):
      mm: don't warn about large allocations for slab

Dominique Martinet (1):
      v9fs_dir_readdir: fix double-free on p9stat_read error

Emmanuel Grumbach (2):
      iwlwifi: mvm: support sta_statistics() even on older firmware
      iwlwifi: mvm: fix regulatory domain update when the firmware starts

Eran Ben Elisha (1):
      net/mlx4_core: Fix wrong calculation of free counters

Eric Dumazet (2):
      llc: do not use sk_eat_skb()
      tcp: do not release socket ownership in tcp_close()

Felipe Balbi (1):
      usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers

Francis Therien (1):
      Input: xpad - add PDP device id 0x02a4

Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Greg Kroah-Hartman (3):
      MAINTAINERS: Add Sasha as a stable branch maintainer
      tty: wipe buffer if not echoing data
      Linux 4.14.85

Janosch Frank (1):
      s390/mm: Check for valid vma before zapping in gmap_discard

Jeffy Chen (1):
      driver core: Move device_links_purge() after bus_remove_device()

Jens Axboe (1):
      floppy: fix race condition in __floppy_read_block_0()

Jerome Brunet (1):
      pinctrl: meson: fix pinconf bias disable

Johan Hovold (6):
      of: add helper to lookup compatible child node
      NFC: nfcmrvl_uart: fix OF child-node lookup
      net: bcmgenet: fix OF child-node lookup
      drm/mediatek: fix OF sibling-node lookup
      power: supply: twl4030-charger: fix OF sibling-node lookup
      mtd: rawnand: atmel: fix OF child-node lookup

Kan Liang (1):
      perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLa=
ke CPUs

Konstantin Khlebnikov (1):
      tools/power/cpupower: fix compilation with STATIC=3Dtrue

Krzysztof Kozlowski (1):
      ARM: dts: exynos: Fix invalid node referenced by i2c20 alias in Peach=
 Pit and Pi

Leo Sperling (1):
      Input: xpad - fix some coding style issues

Linus Torvalds (1):
      tty: wipe buffer.

Luca Coelho (1):
      iwlwifi: mvm: don't use SAR Geo if basic SAR is not used

Lukas Wunner (1):
      can: hi311x: Use level-triggered interrupt

Marc Kleine-Budde (4):
      can: dev: can_get_echo_skb(): factor out non sending code to __can_ge=
t_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_fra=
me to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::e=
cho_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to ech=
o non existing skb

Marc Zyngier (1):
      xhci: Allow more than 32 quirks

Marcus Folkesson (1):
      Input: xpad - avoid using __set_bit() for capabilities

Marek Szyprowski (1):
      clk: samsung: exynos5250: Add missing clocks for FIMC LITE SYSMMU dev=
ices

Mathias Nyman (1):
      usb: xhci: Prevent bus suspend if a port connect change or polling st=
ate is detected

Matt Chen (1):
      iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE

Matthew Garrett (1):
      EVM: Add support for portable signature format

Michael Ellerman (1):
      powerpc/io: Fix the IO workarounds code to work with Radix

Michael J. Ruhl (1):
      IB/hfi1: Eliminate races in the SDMA send error path

Michal Hocko (1):
      mm, page_alloc: check for max order in hot path

Mimi Zohar (2):
      ima: always measure and audit files in policy
      ima: re-initialize iint->atomic_flags

Mustafa Ismail (1):
      i40iw: Fix memory leak in error path of create QP

Niklas Cassel (1):
      PCI: endpoint: Populate func_no before calling pci_epc_add_epf()

Oleksij Rempel (2):
      can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_o=
ffload_queue_sorted() functions
      can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_=
offload_queue_tail()

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()

Parav Pandit (1):
      IB/core: Perform modify QP on real one

Paul E. McKenney (1):
      rcu: Make need_resched() respond to urgent RCU-QS needs

Phil Elwell (1):
      lan78xx: Read MAC address from DT if present

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix reporting support for 160 MHz channels

Rajat Jain (1):
      mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL

Ramses Ram=C3=ADrez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Richard Weinberger (1):
      ubi: fastmap: Check each mapping only once

Salvatore Mesoraca (1):
      namei: allow restricted O_CREAT of FIFOs and regular files

Sandeep Singh (1):
      xhci: Add check for invalid byte size error when UAS devices are conn=
ected.

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Sebastien Boisvert (1):
      include/linux/pfn_t.h: force '~' to be parsed as an unary operator

Stefan Agner (5):
      ARM: 8766/1: drop no-thumb-interwork in EABI mode
      ARM: 8767/1: add support for building ARM kernel with clang
      bus: arm-cci: remove unnecessary unreachable()
      ARM: trusted_foundations: do not use naked function
      kbuild: allow to use GCC toolchain not in Clang search path

Takashi Iwai (1):
      ALSA: oss: Use kvzalloc() for local buffer allocations

Tetsuo Handa (2):
      selinux: Add __GFP_NOWARN to allocation at str_read()
      bfs: add sanity check at bfs_fill_super()

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly check last unaligned/zero chain TRB

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Trond Myklebust (1):
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Vitaly Wool (1):
      z3fold: fix possible reclaim races

Vladimir Zapolskiy (1):
      gpio: don't free unallocated ida on gpiochip_add_data_with_key() erro=
r path

Xin Long (1):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc=
_rm_peer

Xulin Sun (1):
      rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwDi1IACgkQONu9yGCS
aT7T1xAArjWo93r72Cx0Y7ZFHdsQjzZUlwmdwQ64yGiKUXSXsFqr2Nr2BLUKMPpK
PNXs6KGV3fRVeviL4O652+VfWmABvMbg7darzvxsforkPINRSa1Bnr6WyJgUYWM9
Yg/OjT6EreZm8JcmjPaFLGMA+qRFVpw61lm2yt3asm5zFuw18gTKBjOuaW0YM72B
dheWWlH4cf3rUS+JP/p7dobhIqRWXILcgKvBfXnbP6iK/ZB56bFUgXIWcJsDKJo5
4gvlTAiP/h3YGnzR9PU0CtHueqAQZ2ogQpxeHte7uIxuJUbKUN6WqmyuGcBDm1lV
gk8SGj2hoNBboVF9gVHPkSgL9ud9yYFHxx23108tnL/F6tFK3BziJnANtEVOF6dD
GsR3OLNEwsUAZDJi1kS/eUaP28BirbNehyMktoMG4nmylJtY80QCtypFCv+wJhhV
uHtNGAdZlyiarV/rX//qQKhJ8F7W74l5XlPn+E/c7A8h09AdcLq7RFjyC+VVXB7i
tkUR3Wtdf7L5NCMoUiU752NXPxCODskURj3tTD5KKNLms+HYcEemoKxx5rQAtmF3
9/FmkGeS/aI1Yf24YyZ3Tr6zJ+Evh3m5Ai9Mtvr2eOdOHT2szVi7FLDoe/nHIbTZ
EJkY5L2yV0D0kyPJsgj46vp9t9/SMJeCAOtEnuMAEn6+F8i9o8s=
=gBn2
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
