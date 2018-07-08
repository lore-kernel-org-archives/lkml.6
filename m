Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E5C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080E7208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080E7208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeGHN4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 09:56:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754064AbeGHN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 09:56:41 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DAB86CF2;
        Sun,  8 Jul 2018 13:56:39 +0000 (UTC)
Date:   Sun, 8 Jul 2018 15:56:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.5
Message-ID: <20180708135637.GA29725@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.5 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    2=20
 arch/arm/boot/dts/imx6q.dtsi                          |    2=20
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi |    7 +
 arch/x86/include/asm/pgalloc.h                        |    3=20
 drivers/acpi/osl.c                                    |   72 +++++++++++++=
+++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            |   10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            |   24 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h               |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c               |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                |   14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c          |   39 ++++++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                 |    4=20
 drivers/gpu/drm/amd/amdgpu/vi.c                       |   77 +++++++++++++=
+----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |   22 ++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c       |    2=20
 drivers/gpu/drm/i915/i915_irq.c                       |   12 ++
 drivers/gpu/drm/i915/i915_reg.h                       |    5 +
 drivers/gpu/drm/i915/intel_crt.c                      |   20 ++++
 drivers/gpu/drm/i915/intel_ddi.c                      |    8 +
 drivers/gpu/drm/i915/intel_display.c                  |   16 +++
 drivers/gpu/drm/i915/intel_dp.c                       |   34 +++----
 drivers/gpu/drm/i915/intel_dp_mst.c                   |   14 +++
 drivers/gpu/drm/i915/intel_dsi.c                      |    6 +
 drivers/gpu/drm/i915/intel_dvo.c                      |    6 +
 drivers/gpu/drm/i915/intel_hdmi.c                     |    6 +
 drivers/gpu/drm/i915/intel_lrc.c                      |   12 ++
 drivers/gpu/drm/i915/intel_lvds.c                     |    5 +
 drivers/gpu/drm/i915/intel_sdvo.c                     |    6 +
 drivers/gpu/drm/i915/intel_tv.c                       |   12 ++
 drivers/gpu/drm/qxl/qxl_display.c                     |    7 +
 drivers/gpu/drm/sti/Kconfig                           |    3=20
 drivers/gpu/drm/sun4i/sun4i_tcon.c                    |   25 -----
 drivers/iio/accel/mma8452.c                           |    2=20
 drivers/staging/android/ion/ion_heap.c                |    2=20
 drivers/tty/n_tty.c                                   |   55 +++++++-----
 drivers/tty/serdev/core.c                             |    1=20
 drivers/tty/serial/8250/8250_pci.c                    |    2=20
 drivers/tty/vt/vt.c                                   |    4=20
 drivers/usb/class/cdc-acm.c                           |    3=20
 drivers/usb/dwc2/hcd_queue.c                          |    2=20
 drivers/usb/host/xhci-mem.c                           |    4=20
 drivers/usb/host/xhci-trace.h                         |   36 +++++++-
 drivers/usb/serial/cp210x.c                           |   14 +++
 drivers/usb/typec/tcpm.c                              |    7 -
 drivers/usb/typec/ucsi/ucsi.c                         |   13 +++
 drivers/usb/typec/ucsi/ucsi_acpi.c                    |    5 +
 include/linux/acpi.h                                  |    3=20
 net/ipv6/netfilter/ip6t_rpfilter.c                    |    2=20
 net/netfilter/nf_tables_core.c                        |    3=20
 net/netfilter/xt_connmark.c                           |    2=20
 50 files changed, 488 insertions(+), 149 deletions(-)

Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Andrey Ryabinin (1):
      x86/mm: Don't free P4D table when it is folded at runtime

Andy Shevchenko (1):
      serial: 8250_pci: Remove stalled entries in blacklist

Florian Westphal (1):
      netfilter: xt_connmark: fix list corruption on rmmod

Greg Kroah-Hartman (1):
      Linux 4.17.5

Harry Wentland (1):
      drm/amdgpu: Don't default to DC support for Kaveri and older

Heikki Krogerus (3):
      acpi: Add helper for deactivating memory region
      usb: typec: ucsi: acpi: Workaround for cache mode issue
      usb: typec: ucsi: Fix for incorrect status data issue

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Huang Rui (1):
      drm/amdgpu: fix the missed vcn fw version report

Jeremy Cline (1):
      drm/qxl: Call qxl_bo_unref outside atomic context

Johan Hovold (2):
      USB: serial: cp210x: add CESINEL device ids
      serdev: fix memleak on module unload

Junwei Zhang (1):
      drm/amdgpu: fix clear_all and replace handling in the VM (v2)

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Kenneth Graunke (1):
      drm/i915: Enable provoking vertex fix on Gen9 systems.

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Leonard Crestez (1):
      iio: mma8452: Fix ignoring MMA8452_INT_DRDY

Lyude Paul (3):
      drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()
      drm/i915/dp: Send DPCD ON for MST before phy_up
      drm/amdgpu: Count disabled CRTCs in commit tail earlier

Michel D=E4nzer (5):
      drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes array
      drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper
      drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size always accurate
      drm/amdgpu: Update pin_size values before unpinning BO
      drm/amdgpu: GPU vs CPU page size fixes in amdgpu_vm_bo_split_mapping

Mikita Lipski (1):
      drm/amd/display: Clear connector's edid pointer

Neil Armstrong (1):
      ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

Oliver O'Halloran (1):
      drm/sti: Depend on OF rather than selecting it

Paul Kocialkowski (1):
      Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"

Peter Chen (1):
      usb: typec: tcpm: fix logbuffer index is wrong if _tcpm_log is re-ent=
ered

Rex Zhu (2):
      drm/amdgpu: Add APU support in vi_set_uvd_clocks
      drm/amdgpu: Add APU support in vi_set_vce_clocks

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Shirish S (1):
      drm/amd/display: release spinlock before committing updates to stream

Stefan Agner (1):
      drm/atmel-hlcdc: check stride values in the first plane

Taehee Yoo (1):
      netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_ch=
ain()

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

Ville Syrj=E4l=E4 (4):
      drm/i915: Allow DBLSCAN user modes with eDP/LVDS/DSI
      drm/i915: Fix PIPESTAT irq ack on i965/g4x
      drm/i915: Disallow interlaced modes on g4x DP outputs
      drm/i915: Turn off g4x DP port in .post_disable()

Vincent Bernat (1):
      netfilter: ip6t_rpfilter: provide input interface for route lookup

William Wu (1):
      usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

Zhengjun Xing (1):
      xhci: Fix kernel oops in trace_xhci_free_virt_device


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltCGBUACgkQONu9yGCS
aT7/KA/+PmWQTOR5Y8f8BtPCSU5fecEzeHp+aW2wF6pj0BNsZmR659fbkszWDm16
nVfEstTL5IZT5eQFdw6k3OZScqAWhWxz818FllO85elsVFjBXqtJd+tPy8E+Ehzc
ZDbaEtUinf6yID/IlXDBF0svovc9r7FtuusQNzY/lCg4H9Zpw6yvyIyl1mdfYXga
cxyHU4++9701foHL7V5sU+1c0oOyPUR/0NjOhP0y09HBJSriQkM9TxI8dCVzo7wz
v1WL7dgMKoZZanjNjFBbxVbjG9CwBxErGiCOqTjoRX3fHzqr7+NzJEfOsbCZzIly
VWUv43OLlYWDyi2RlhRM2f/sVJ2UTNqbLcajM/ejFVWY6fghJnC1wb6vhSLmXIJJ
9M5SaSz3IX5HHBUrPgtZkfvRowvbbTdyUlPfLHyFMpl0v+kvYx7B5Tgfu/1x+jbG
rVFzVHBtgskUAabN1h/iDz6BuR5xp7cw3on+ZdeXZJ1qwI8u6TjEl1Yp5A1oO0Ep
1HF9m0yvyOQdIeiiIhUEubUuakHSoOKouDQyllN2pB9G3HW7HcD7KIeDcZIiuHwh
HJxbHPgfuylAq4oV1CPvoiS/OXdEALMaOGdhk9cQ+KIEZL+1jLCbcFu5x2ekeuuU
Mc1PgiuLTGFpljS9hmTgM2d4ieWPHGsIAmRxyiCllYKMmb8lXIk=
=yxXO
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
