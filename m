Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613821929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409474;
	bh=Vaj5fQK6ayYTc5jvYVDHiLj0YLb/JL9JqtK8pRiybFM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Pfm5PRnKRWk7WfrQ8j7y4TEbBOom+oi7529XnAq07U+UeLNQ8N5QkitQoCkrtv7J4
	 EjRVNmG0Uq1Su4LCpydtyHM9UdeUwwooKtBFkn7XLBf/tWbxBN9teoc4+43WheScvR
	 M3cZ9W/jsLSKruF7dEJQJbQhoRucEuzs0K+PY+Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeLUQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbeLUQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:24:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E6D21903;
        Fri, 21 Dec 2018 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409471;
        bh=Vaj5fQK6ayYTc5jvYVDHiLj0YLb/JL9JqtK8pRiybFM=;
        h=Date:From:To:Cc:Subject:From;
        b=2ELRJ424ADuRyBYzwxwCocG5LMQC//JEvwj41zAfEt1/q5+ShB64YEn4otAIKHCGB
         Dk8G/prPSH4kIsE+/xMef0FZnva4hqOV248zvJrKVzWW+0GMkgwAVyvJvKoklwVfML
         SZaV3G/I2DIKNa9AU88u6aVoK4eVFwEpYQ5HIg5A=
Date:   Fri, 21 Dec 2018 17:24:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.90
Message-ID: <20181221162429.GA7416@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.90 kernel.

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

 Makefile                                                 |    2=20
 arch/arc/include/asm/io.h                                |   72 +++++
 arch/arm/mach-mmp/cputype.h                              |    6=20
 arch/arm/mm/cache-v7.S                                   |    8=20
 arch/arm/mm/cache-v7m.S                                  |   14 -
 arch/arm/net/bpf_jit_32.c                                |    2=20
 arch/arm64/mm/dma-mapping.c                              |    2=20
 arch/powerpc/kernel/msi.c                                |    7=20
 arch/x86/Makefile                                        |   10=20
 arch/x86/include/asm/qspinlock.h                         |   25 +
 arch/x86/include/asm/qspinlock_paravirt.h                |    3=20
 arch/x86/platform/efi/early_printk.c                     |    2=20
 block/elevator.c                                         |   44 +--
 drivers/ata/libata-core.c                                |    1=20
 drivers/clk/mmp/clk.c                                    |    2=20
 drivers/clk/mvebu/cp110-system-controller.c              |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                  |    3=20
 drivers/gpu/drm/ast/ast_fb.c                             |    1=20
 drivers/gpu/drm/i915/intel_lrc.c                         |    7=20
 drivers/gpu/drm/msm/msm_atomic.c                         |    5=20
 drivers/gpu/drm/msm/msm_iommu.c                          |    2=20
 drivers/gpu/drm/nouveau/nv50_display.c                   |    1=20
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c              |    6=20
 drivers/hid/hid-hyperv.c                                 |    2=20
 drivers/i2c/busses/i2c-axxia.c                           |   40 ++-
 drivers/i2c/busses/i2c-scmi.c                            |   10=20
 drivers/i2c/busses/i2c-uniphier-f.c                      |   19 +
 drivers/i2c/busses/i2c-uniphier.c                        |    8=20
 drivers/ide/pmac.c                                       |    1=20
 drivers/infiniband/hw/hfi1/user_sdma.c                   |   24 -
 drivers/infiniband/hw/hfi1/user_sdma.h                   |    9=20
 drivers/input/keyboard/omap4-keypad.c                    |   18 +
 drivers/input/mouse/synaptics.c                          |    1=20
 drivers/input/serio/hyperv-keyboard.c                    |    2=20
 drivers/md/dm-cache-metadata.c                           |    4=20
 drivers/md/dm-thin.c                                     |   68 ++---
 drivers/mmc/host/omap.c                                  |   11=20
 drivers/mmc/host/sdhci.c                                 |   18 +
 drivers/net/bonding/bond_3ad.c                           |    3=20
 drivers/net/dsa/mv88e6060.c                              |   10=20
 drivers/net/ethernet/freescale/fman/fman.c               |    5=20
 drivers/net/ethernet/mellanox/mlx4/Kconfig               |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   10=20
 drivers/net/wireless/mac80211_hwsim.c                    |   12=20
 drivers/nvme/target/rdma.c                               |    3=20
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c               |    2=20
 drivers/rtc/rtc-snvs.c                                   |  105 +++++---
 drivers/sbus/char/display7seg.c                          |    1=20
 drivers/sbus/char/envctrl.c                              |    2=20
 drivers/scsi/libiscsi.c                                  |    4=20
 drivers/scsi/vmw_pvscsi.c                                |    4=20
 drivers/tty/serial/suncore.c                             |    1=20
 drivers/vhost/vsock.c                                    |   22 +
 fs/aio.c                                                 |    2=20
 fs/cifs/Kconfig                                          |    2=20
 fs/fuse/dir.c                                            |    2=20
 fs/fuse/file.c                                           |   21 -
 fs/fuse/fuse_i.h                                         |    2=20
 fs/nfs/direct.c                                          |    9=20
 fs/userfaultfd.c                                         |    3=20
 include/asm-generic/qspinlock_types.h                    |   32 ++
 kernel/locking/qspinlock.c                               |  195 +++++++---=
-----
 kernel/locking/qspinlock_paravirt.h                      |   42 ---
 kernel/time/timer_list.c                                 |    2=20
 kernel/trace/ftrace.c                                    |    1=20
 kernel/trace/trace_events_trigger.c                      |    6=20
 net/mac80211/mlme.c                                      |    3=20
 net/netfilter/ipset/ip_set_hash_ipportnet.c              |   26 +-
 net/netfilter/ipset/ip_set_hash_net.c                    |    9=20
 net/netfilter/ipset/ip_set_hash_netiface.c               |    9=20
 net/netfilter/ipset/ip_set_hash_netnet.c                 |   28 +-
 net/netfilter/ipset/ip_set_hash_netport.c                |   19 -
 net/netfilter/ipset/ip_set_hash_netportnet.c             |   35 +-
 net/sunrpc/xprt.c                                        |   11=20
 tools/testing/selftests/bpf/test_verifier.c              |    2=20
 75 files changed, 691 insertions(+), 420 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Alek Du (1):
      mmc: sdhci: fix the timeout check window for clock and reset

Alexey Khoroshilov (1):
      mac80211_hwsim: fix module init error paths for netlink

Anderson Luiz Alves (1):
      mv88e6060: disable hardware level MAC learning

Andrea Arcangeli (1):
      userfaultfd: check VM_MAYWRITE was set after verifying the uffd is re=
gistered

Brian Norris (1):
      Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Cathy Avery (1):
      scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq d=
uring unload

Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Chen-Yu Tsai (1):
      pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Chris Cole (1):
      ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address=
 handling

Chris Wilson (1):
      drm/i915/execlists: Apply a full mb before execution for Braswell

Dan Carpenter (2):
      clk: mvebu: Off by one bugs in cp110_of_clk_get()
      clk: mmp: Off by one in mmp_clk_add()

Dave Kleikamp (1):
      nfs: don't dirty kernel pages read by direct-io

David Miller (1):
      bpf: Fix verifier log string check for bad alignment.

Emmanuel Grumbach (1):
      mac80211: don't WARN on bad WMM parameters from buggy APs

Fred Herard (1):
      scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Greg Kroah-Hartman (1):
      Linux 4.14.90

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI devi=
ce node

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl

Ilan Peer (1):
      mac80211: Fix condition validating WMM IE

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400

Israel Rukshin (1):
      nvmet-rdma: fix response use after free

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jens Axboe (1):
      elevator: lookup mq vs non-mq elevators

Jose Abreu (1):
      ARC: io.h: Implement reads{x}()/writes{x}()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix wraparound in hash:*net* types

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Junwei Zhang (1):
      drm/amdgpu: update SMC firmware image for polaris10 variants

Lubomir Rintel (1):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Lyude Paul (1):
      drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Masahiro Yamada (3):
      x86/build: Fix compiler support check for CONFIG_RETPOLINE
      i2c: uniphier: fix violation of tLOW requirement for Fast-mode
      i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Michael J. Ruhl (1):
      IB/hfi1: Remove race conditions in user_sdma send path

Mike Snitzer (2):
      dm thin: send event about thin-pool state change _after_ making it
      dm cache metadata: verify cache has blocks in blocks_are_clean_separa=
te_dirty()

Nicolas Saenz Julienne (1):
      ethernet: fman: fix wrong of_node_put() in probe function

Nicolas Schichan (1):
      bpf, arm: fix emit_ldx_r and emit_mov_i using TMP_REG_1

Paul E. McKenney (1):
      locking: Remove smp_read_barrier_depends() from queued_spin_lock_slow=
path()

Peter Zijlstra (2):
      locking/qspinlock: Re-order code
      locking/qspinlock, x86: Provide liveness guarantee

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

Robin Murphy (1):
      arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

Saeed Mahameed (1):
      net/mlx4_en: Fix build break when CONFIG_INET is off

Sam Bobroff (1):
      drm/ast: Fix connector leak during driver unload

Sean Paul (1):
      drm/msm: Grab a vblank reference when waiting for commit_done

Stefan Hajnoczi (1):
      vhost/vsock: fix reset orphans race with close timeout

Steve French (1):
      cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure =
cifs)

Steven Rostedt (VMware) (3):
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters
      locking/qspinlock: Fix build for anonymous union in older GCC compile=
rs

Teika Kazura (1):
      Input: synaptics - enable SMBus for HP 15-ay000

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trent Piepho (1):
      rtc: snvs: Add timeouts to avoid kernel lockups

Trond Myklebust (1):
      SUNRPC: Fix a potential race in xprt_connect()

Vitaly Kuznetsov (1):
      Input: hyper-v - fix wakeup from suspend-to-idle

Vladimir Murzin (1):
      ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Wen Yang (1):
      drm/msm: Fix error return checking

Will Deacon (7):
      locking/qspinlock: Ensure node is initialised before updating prev->n=
ext
      locking/qspinlock: Bound spinning on pending->locked transition in sl=
owpath
      locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'
      locking/qspinlock: Remove unbounded cmpxchg() loop from locking slowp=
ath
      locking/qspinlock: Remove duplicate clear_pending() function from PV =
code
      locking/qspinlock: Kill cmpxchg() loop when claiming lock from head o=
f queue
      locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound

Yangtao Li (4):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()
      ide: pmac: add of_node_put()

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwdE70ACgkQONu9yGCS
aT7t6Q//fCbe1rvpcLILRf/GagnDt4tfJXTPp6tvVPu46URmt07FavEaTffhuhT8
4gYbkEmxyiI0uG9XJ3k32JHWyAzOjiCN1oFN/qyR2Y78sT6V/abHM+AOJ6W8yuw6
cqhWHk5GIv95EJbQ1oEjV5iTIJJUw2quFydj+3gpPcXOOL+nPXFHPWf/cTZUAW+5
lomCSQkTk5FpINC4Dc/RJE/+0hSE8/9hCa3uaqQG+J1GaIqMza8qTFKEsqCcQq5x
HS8+AnXawygW4axxR8+uKpIldCb98DYljqgMe7Gaj0RmOMeme0HC+F+WIIKKt9MW
qq1t25a0x0dOkFe6P13cGeFwpAfiOUU4aN5g6n524hSxiUsvruhtVRW43LbLtDVs
xxbDcJKhFE4UKVYPWAZOjO3GpuZc90uaRRvfZ+bINjNBEdQB6EPT+jE5BzVhYGna
Ri8Yq6LOPe40vBTbZev9MFxDbCj0l0pVBFTCgRG0eo989M7HBt/cKvrjSX53Xjlh
u3rEZAIgcANKzXj20BOmziIgSoruJG1G1FdySj4Le8AVciAF91LpXmLe8D7L/5K3
l/J1xLjAO62N1PfcKhjS1wILHDubTRo7qnj3SYNHRRiSnwNelvAu0QxI4zrobJL3
mBr+Qc26ROB4w2rF9LX0kN+dyBAEN3osIO7olmIZU7wp4MkBZXU=
=DlfJ
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
