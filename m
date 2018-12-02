Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E43C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C93206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGIEFMFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C93206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLBHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbeLBHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:36:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FCF206B7;
        Sun,  2 Dec 2018 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736171;
        bh=x9FhttOubnvAg0s5io1mRV9jMbdlrK5HvxH1nEaJvO8=;
        h=Date:From:To:Cc:Subject:From;
        b=PGIEFMFkpuv5wessoc6enlCvMq/Qe9nq+fqW/zrA3Azgn0SpQOf1AwLkxHC/sSCSA
         DianQztDrikVRXEhQbTrIIyZOQXfMuDmeMYrBCB7CFyTrFOIYMZAqwc3LXI+QBLi7+
         ql+3txISgAZr74w42qKQgMurRefRTip5472Hq5Wg=
Date:   Sun, 2 Dec 2018 08:36:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.6
Message-ID: <20181202073608.GA32458@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.6 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/security-bugs.rst                 |   48 +-
 Documentation/devicetree/bindings/net/can/holt_hi311x.txt   |    2=20
 MAINTAINERS                                                 |    1=20
 Makefile                                                    |    2=20
 arch/powerpc/include/asm/io.h                               |   20=20
 arch/powerpc/kvm/trace.h                                    |    8=20
 arch/powerpc/kvm/trace_booke.h                              |    9=20
 arch/powerpc/kvm/trace_hv.h                                 |    9=20
 arch/powerpc/kvm/trace_pr.h                                 |    9=20
 arch/powerpc/mm/numa.c                                      |    2=20
 arch/riscv/Makefile                                         |    4=20
 arch/riscv/kernel/module.c                                  |   12=20
 arch/x86/events/intel/uncore_snb.c                          |  115 +++++
 block/bio.c                                                 |    1=20
 block/bounce.c                                              |    1=20
 crypto/simd.c                                               |    5=20
 drivers/acpi/acpica/dsopcode.c                              |    4=20
 drivers/block/floppy.c                                      |    3=20
 drivers/cpufreq/imx6q-cpufreq.c                             |    7=20
 drivers/firmware/efi/arm-init.c                             |    4=20
 drivers/firmware/efi/arm-runtime.c                          |    2=20
 drivers/firmware/efi/libstub/Makefile                       |    3=20
 drivers/firmware/efi/memmap.c                               |    3=20
 drivers/gpio/gpiolib.c                                      |    5=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                  |    7=20
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c                       |    1=20
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c                      |    2=20
 drivers/gpu/drm/ast/ast_drv.c                               |   21=20
 drivers/gpu/drm/ast/ast_mode.c                              |    3=20
 drivers/gpu/drm/drm_fb_helper.c                             |    3=20
 drivers/gpu/drm/i915/intel_pm.c                             |   41 +
 drivers/gpu/drm/vc4/vc4_kms.c                               |    6=20
 drivers/hid/hid-steam.c                                     |  154 ++++---
 drivers/infiniband/hw/hfi1/user_sdma.c                      |   87 +--
 drivers/infiniband/hw/hfi1/user_sdma.h                      |    3=20
 drivers/input/mouse/synaptics.c                             |    4=20
 drivers/media/i2c/ov5640.c                                  |  263 +++++++=
-----
 drivers/mmc/host/sdhci-pci-core.c                           |   86 +++
 drivers/net/can/dev.c                                       |   48 +-
 drivers/net/can/flexcan.c                                   |  108 ++--
 drivers/net/can/rx-offload.c                                |   51 ++
 drivers/net/can/spi/hi311x.c                                |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    3=20
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h                |    4=20
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                 |   38 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |   12=20
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                |    5=20
 drivers/opp/ti-opp-supply.c                                 |    5=20
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c                  |    2=20
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                   |    2=20
 drivers/pinctrl/meson/pinctrl-meson.c                       |    2=20
 drivers/pinctrl/meson/pinctrl-meson8.c                      |    2=20
 drivers/pinctrl/meson/pinctrl-meson8b.c                     |    2=20
 drivers/rtc/rtc-cmos.c                                      |   16=20
 drivers/rtc/rtc-pcf2127.c                                   |    3=20
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                      |    2=20
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                      |    2=20
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                      |    2=20
 drivers/scsi/lpfc/lpfc_debugfs.c                            |    2=20
 drivers/tty/n_tty.c                                         |   20=20
 drivers/tty/tty_buffer.c                                    |    6=20
 drivers/usb/core/hub.c                                      |    4=20
 drivers/usb/dwc3/core.c                                     |    1=20
 drivers/usb/dwc3/dwc3-pci.c                                 |    4=20
 drivers/usb/dwc3/gadget.c                                   |    8=20
 drivers/usb/host/xhci-histb.c                               |    6=20
 drivers/usb/host/xhci-hub.c                                 |   66 ++-
 drivers/usb/host/xhci-mtk.c                                 |    6=20
 drivers/usb/host/xhci-pci.c                                 |    6=20
 drivers/usb/host/xhci-plat.c                                |    6=20
 drivers/usb/host/xhci-ring.c                                |   45 +-
 drivers/usb/host/xhci-tegra.c                               |    1=20
 drivers/usb/host/xhci.c                                     |    2=20
 drivers/usb/host/xhci.h                                     |    3=20
 fs/9p/vfs_dir.c                                             |   11=20
 fs/bfs/inode.c                                              |    9=20
 fs/dax.c                                                    |    7=20
 fs/gfs2/bmap.c                                              |   40 -
 fs/gfs2/ops_fstype.c                                        |    2=20
 fs/nfs/callback_proc.c                                      |    4=20
 fs/nfs/delegation.c                                         |   11=20
 fs/notify/fanotify/fanotify.c                               |   10=20
 fs/notify/fsnotify.c                                        |   15=20
 include/linux/can/dev.h                                     |    1=20
 include/linux/can/rx-offload.h                              |    7=20
 include/linux/fsnotify_backend.h                            |    9=20
 include/linux/pfn_t.h                                       |    2=20
 include/net/sock.h                                          |    1=20
 kernel/debug/kdb/kdb_io.c                                   |   15=20
 kernel/debug/kdb/kdb_private.h                              |    2=20
 kernel/debug/kdb/kdb_support.c                              |   10=20
 kernel/rcu/tree.c                                           |    9=20
 kernel/sched/fair.c                                         |   62 ++
 mm/memory.c                                                 |   34 +
 mm/page_alloc.c                                             |   28 -
 mm/shmem.c                                                  |    4=20
 mm/slab.c                                                   |    4=20
 mm/slab_common.c                                            |   12=20
 mm/z3fold.c                                                 |  101 ++--
 net/can/raw.c                                               |   15=20
 net/core/sock.c                                             |    2=20
 net/ipv4/tcp.c                                              |   11=20
 net/llc/af_llc.c                                            |   11=20
 net/sctp/associola.c                                        |   10=20
 net/sunrpc/auth_generic.c                                   |    8=20
 security/selinux/ss/policydb.c                              |    2=20
 sound/core/oss/pcm_oss.c                                    |    6=20
 sound/core/oss/pcm_plugin.c                                 |    6=20
 tools/power/cpupower/bench/Makefile                         |    2=20
 tools/power/cpupower/lib/cpufreq.c                          |    2=20
 tools/power/cpupower/lib/cpuidle.c                          |    2=20
 tools/power/cpupower/lib/cpupower.c                         |    4=20
 tools/power/cpupower/lib/cpupower_intern.h                  |    2=20
 tools/testing/nvdimm/test/nfit.c                            |    8=20
 114 files changed, 1341 insertions(+), 617 deletions(-)

Aaron Ma (2):
      usb: xhci: fix uninitialized completion when USB3 port got wrong stat=
us
      usb: xhci: fix timeout for transition from RExit to U0

Adrian Hunter (1):
      mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning=
 value

Alexander Stein (1):
      can: flexcan: Always use last mailbox for TX

Alistair Strachan (1):
      efi/libstub: arm: support building with clang

Amir Goldstein (2):
      fsnotify: generalize handling of extra event flags
      fanotify: fix handling of events on child sub-directory

Andreas Gruenbacher (1):
      gfs2: Fix iomap buffer head reference counting bug

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

Arnd Bergmann (1):
      scsi: lpfc: fix remoteport access

Boris Brezillon (1):
      drm/vc4: Set ->legacy_cursor_update to false when doing non-async upd=
ates

Cherian, George (1):
      xhci: Add quirk to workaround the errata seen on Cavium Thunder-X2 Soc

David Abdurachmanov (1):
      riscv: add missing vdso_install target

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dmitry Torokhov (1):
      Input: synaptics - avoid using uninitialized variable when probing

Dmitry Vyukov (1):
      mm: don't warn about large allocations for slab

Dominique Martinet (1):
      v9fs_dir_readdir: fix double-free on p9stat_read error

Emmanuel Grumbach (2):
      iwlwifi: mvm: support sta_statistics() even on older firmware
      iwlwifi: mvm: fix regulatory domain update when the firmware starts

Eric Dumazet (2):
      llc: do not use sk_eat_skb()
      tcp: do not release socket ownership in tcp_close()

Erik Schmauss (1):
      ACPICA: AML interpreter: add region addresses in global list during i=
nitialization

Felipe Balbi (1):
      usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers

Felix Kuehling (1):
      drm/amdgpu: Fix oops when pp_funcs->switch_power_profile is unset

Greg Kroah-Hartman (3):
      MAINTAINERS: Add Sasha as a stable branch maintainer
      tty: wipe buffer if not echoing data
      Linux 4.19.6

Hannes Reinecke (1):
      block: copy ioprio in __bio_clone_fast() and bounce

Hans de Goede (1):
      rtc: cmos: Do not export alarm rtc_ops when we do not support alarms

Hugues Fruchet (4):
      media: ov5640: fix exposure regression
      media: ov5640: fix auto gain & exposure when changing mode
      media: ov5640: fix wrong binning value in exposure calculation
      media: ov5640: fix auto controls values when switching to manual mode

Jacopo Mondi (2):
      media: ov5640: Re-work MIPI startup sequence
      media: ov5640: Fix timings setup code

Jens Axboe (1):
      floppy: fix race condition in __floppy_read_block_0()

Jerome Brunet (5):
      pinctrl: meson: fix pinconf bias disable
      pinctrl: meson: fix gxbb ao pull register bits
      pinctrl: meson: fix gxl ao pull register bits
      pinctrl: meson: fix meson8 ao pull register bits
      pinctrl: meson: fix meson8b ao pull register bits

Kan Liang (1):
      perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLa=
ke CPUs

Keerthy (2):
      opp: ti-opp-supply: Dynamically update u_volt_min
      opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage ca=
ll

Konstantin Khlebnikov (1):
      tools/power/cpupower: fix compilation with STATIC=3Dtrue

Kuppuswamy Sathyanarayanan (1):
      usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()

Linus Torvalds (1):
      tty: wipe buffer.

Luca Coelho (1):
      iwlwifi: mvm: don't use SAR Geo if basic SAR is not used

Lukas Wunner (1):
      can: hi311x: Use level-triggered interrupt

Marc Kleine-Budde (5):
      can: dev: can_get_echo_skb(): factor out non sending code to __can_ge=
t_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_fra=
me to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::e=
cho_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to ech=
o non existing skb
      can: flexcan: remove not needed struct flexcan_priv::tx_mb and struct=
 flexcan_priv::tx_mb_idx

Masayoshi Mizuma (1):
      tools/testing/nvdimm: Fix the array size for dimm devices.

Mathias Nyman (3):
      xhci: Fix leaking USB3 shared_hcd at xhci removal
      xhci: handle port status events for removed USB3 hcd
      usb: xhci: Prevent bus suspend if a port connect change or polling st=
ate is detected

Matt Chen (1):
      iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE

Matthew Wilcox (1):
      dax: Avoid losing wakeup in dax_lock_mapping_entry

Michael Ellerman (1):
      powerpc/io: Fix the IO workarounds code to work with Radix

Michael J. Ruhl (1):
      IB/hfi1: Eliminate races in the SDMA send error path

Michal Hocko (2):
      mm, memory_hotplug: check zone_movable in has_unmovable_pages
      mm, page_alloc: check for max order in hot path

Oleksij Rempel (4):
      can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_o=
ffload_queue_sorted() functions
      can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_=
offload_queue_tail()
      can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*=
()
      can: flexcan: handle tx-complete CAN frames via rx-offload infrastruc=
ture

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()

Olof Johansson (1):
      RISC-V: Silence some module warnings on 32-bit

Pankaj Bansal (1):
      can: flexcan: Unlock the MB unconditionally

Patrick Bellasi (1):
      sched/fair: Fix cpu_util_wake() for 'execl' type workloads

Paul E. McKenney (1):
      rcu: Make need_resched() respond to urgent RCU-QS needs

Paul Kocialkowski (1):
      drm/fb-helper: Blacklist writeback when adding connectors to fbdev

Philip Yang (1):
      drm/amdgpu: fix bug with IH ring setup

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix reporting support for 160 MHz channels

Rajat Jain (1):
      mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL

Rodrigo Rivas Costa (1):
      HID: steam: remove input device when a hid client is running.

Sandeep Singh (1):
      xhci: Add check for invalid byte size error when UAS devices are conn=
ected.

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Sebastien Boisvert (1):
      include/linux/pfn_t.h: force '~' to be parsed as an unary operator

Takashi Iwai (2):
      ALSA: oss: Use kvzalloc() for local buffer allocations
      drm/amdgpu: Add missing firmware entry for HAINAN

Tetsuo Handa (2):
      selinux: Add __GFP_NOWARN to allocation at str_read()
      bfs: add sanity check at bfs_fill_super()

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly check last unaligned/zero chain TRB

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Trond Myklebust (2):
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()
      NFSv4: Fix an Oops during delegation callbacks

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Disable LP3 watermarks on all SNB machines

Vitaly Wool (1):
      z3fold: fix possible reclaim races

Vladimir Zapolskiy (1):
      gpio: don't free unallocated ida on gpiochip_add_data_with_key() erro=
r path

Will Deacon (2):
      Documentation/security-bugs: Clarify treatment of embargoed informati=
on
      Documentation/security-bugs: Postpone fix publication in exceptional =
cases

Xin Long (1):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc=
_rm_peer

Xulin Sun (1):
      rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

YueHaibing (1):
      scsi: hisi_sas: Remove set but not used variable 'dq_list'

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwDi2gACgkQONu9yGCS
aT5YIg/+OnEIQtrtcKQea9qJ3DuMnQwPxne8gmOZC3CFAhHa5mdSZaX86LcekKt0
0N4jlNfts3TCplQCk84ktdxtUnO6VEEvUknHm2nK2G7EHx3eJErJM3zxWJ6QhOQT
ptVUM0BjC2rnkBCQjolxYWcP/gNIEptAqS6tngNqycgkGdiSy5xM05L384kLTThR
rK22LvemtmJCnzv7BRUG0++venUuXmFkjgJWLLFqmolhSRrUse6XlVybh3stTw06
VEV+3zLl1jaraLLcFY/Mf0vLkM7f2UvRxUOVnhtuluX1vOf6btdjC25t+XNuteUA
B5/VHoNeW754B9zC2rE+udL+NTj6GIes8kPGMTTOPLoLiibR3H+giXdyDmpG+DjV
t1e9GRbpOFk8u1UOuxJrHdotYNdAzmic+sN1azKKkcu7DW01gGIEYfphBszs/n3N
0ZSg5iVBqlXGQnfuFXHnj99IYSpGequI5+es+oKWJ+ig9yyx2gm6R0k5DcgK+9ju
yI1BsEiTRrA+Szh+zeQDDQofaptkwg3dMvD8Ilblz28Plnc2DFPM6bYvYMHUZxMN
HcKJVBG6tG/Mz6TY17QZou+v8b/qsVZCt0zZOZVfpkWbyL/qQzq1IYkoeMTmc/+j
TWjv3lj7gKyvLixBkxVZewYMj28E6TGYvah/KtajMnX1IydpGEg=
=j1Hz
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
