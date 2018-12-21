Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F5021924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409451;
	bh=KB3RHyrww+Yc2+op257t5cvPOez5th8k01PqDeEIm2s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dNYgQwg5Osh50r4usvwHyEBs2hXPj26f/OnusqVaCbnxfDSd9A1LHG8Ps6uV7CQrY
	 xeDc7iEo7Mu/bTicJ9e2JcHZfMVzfB3XTvr0mZAreh0tpvrohfFkM7/+q5MXKxcJ/B
	 mSzW1EKVunLywHNKgLyZ3rTI2jcQvN5fjYD9xtlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbeLUQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388713AbeLUQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:24:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB3221903;
        Fri, 21 Dec 2018 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409447;
        bh=KB3RHyrww+Yc2+op257t5cvPOez5th8k01PqDeEIm2s=;
        h=Date:From:To:Cc:Subject:From;
        b=cBeyQrdGLMMD5u2ZJofY4OuY/2vGPJk32X2kz/MrnEgMknGRpDUgXUQpHIsMFE+87
         SysK4V5xzjOIi/BuCmy1LoxzDsIJbmIvRcfKOYZM+aNezWwxlIkmMXGgFvgb+T9pwg
         5W6RUqzbkOlalCuhz0ruznfCmX1fZyjoqE0+Z0vE=
Date:   Fri, 21 Dec 2018 17:24:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.147
Message-ID: <20181221162405.GA7334@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.147 kernel.

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

 Makefile                                    |    2=20
 arch/arc/include/asm/io.h                   |   72 ++++++++++
 arch/arm/mach-mmp/cputype.h                 |    6=20
 arch/arm/mm/cache-v7.S                      |    8 -
 arch/arm/mm/cache-v7m.S                     |   14 +-
 arch/powerpc/kernel/msi.c                   |    7 -
 arch/x86/include/asm/qspinlock.h            |   25 +++
 arch/x86/include/asm/qspinlock_paravirt.h   |    3=20
 arch/x86/platform/efi/early_printk.c        |    2=20
 drivers/ata/libata-core.c                   |    1=20
 drivers/clk/mmp/clk.c                       |    2=20
 drivers/clk/mvebu/cp110-system-controller.c |    4=20
 drivers/gpu/drm/ast/ast_fb.c                |    1=20
 drivers/gpu/drm/i915/intel_lrc.c            |    7 -
 drivers/gpu/drm/msm/msm_atomic.c            |    5=20
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    6=20
 drivers/i2c/busses/i2c-axxia.c              |   40 ++++-
 drivers/i2c/busses/i2c-scmi.c               |   10 +
 drivers/ide/pmac.c                          |    1=20
 drivers/infiniband/hw/hfi1/user_sdma.c      |   28 +---
 drivers/infiniband/hw/hfi1/user_sdma.h      |    7 -
 drivers/input/keyboard/omap4-keypad.c       |   18 ++
 drivers/mmc/host/omap.c                     |   11 +
 drivers/net/bonding/bond_3ad.c              |    3=20
 drivers/net/dsa/mv88e6060.c                 |   10 -
 drivers/net/ethernet/freescale/fman/fman.c  |    5=20
 drivers/net/ethernet/mellanox/mlx4/Kconfig  |    2=20
 drivers/net/wireless/mac80211_hwsim.c       |   12 +
 drivers/nvme/target/rdma.c                  |    3=20
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c  |    2=20
 drivers/rtc/rtc-snvs.c                      |  104 ++++++++++----
 drivers/sbus/char/display7seg.c             |    1=20
 drivers/sbus/char/envctrl.c                 |    2=20
 drivers/scsi/libiscsi.c                     |    4=20
 drivers/scsi/vmw_pvscsi.c                   |    4=20
 drivers/tty/serial/suncore.c                |    1=20
 drivers/vhost/vsock.c                       |   22 ++-
 fs/aio.c                                    |    2=20
 fs/cifs/Kconfig                             |    2=20
 fs/nfs/direct.c                             |    9 +
 include/asm-generic/qspinlock_types.h       |   32 ++++
 include/linux/compat.h                      |    3=20
 kernel/bpf/verifier.c                       |    3=20
 kernel/locking/qspinlock.c                  |  195 +++++++++++++----------=
-----
 kernel/locking/qspinlock_paravirt.h         |   42 +-----
 kernel/signal.c                             |   17 +-
 kernel/time/timer_list.c                    |    2=20
 kernel/trace/ftrace.c                       |    1=20
 kernel/trace/trace_events_trigger.c         |    6=20
 lib/interval_tree_test.c                    |   93 ++++++++-----
 lib/rbtree_test.c                           |   55 ++++---
 net/mac80211/mlme.c                         |    3=20
 net/sunrpc/xprt.c                           |   11 +
 53 files changed, 603 insertions(+), 328 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Alexei Starovoitov (1):
      bpf: check pending signals while verifying programs

Alexey Khoroshilov (1):
      mac80211_hwsim: fix module init error paths for netlink

Anderson Luiz Alves (1):
      mv88e6060: disable hardware level MAC learning

Brian Norris (1):
      Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Cathy Avery (1):
      scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq d=
uring unload

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

Davidlohr Bueso (5):
      lib/interval_tree_test.c: make test options module parameters
      lib/interval_tree_test.c: allow full tree search
      lib/rbtree_test.c: make input module parameters
      lib/rbtree-test: lower default params
      lib/interval_tree_test.c: allow users to limit scope of endpoint

Emmanuel Grumbach (1):
      mac80211: don't WARN on bad WMM parameters from buggy APs

Fred Herard (1):
      scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Greg Kroah-Hartman (1):
      Linux 4.9.147

Guy Shapiro (1):
      rtc: snvs: add a missing write sync

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI devi=
ce node

Ilan Peer (1):
      mac80211: Fix condition validating WMM IE

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400

Israel Rukshin (1):
      nvmet-rdma: fix response use after free

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jose Abreu (1):
      ARC: io.h: Implement reads{x}()/writes{x}()

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Lubomir Rintel (1):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Michael J. Ruhl (1):
      IB/hfi1: Remove race conditions in user_sdma send path

Nicolas Saenz Julienne (1):
      ethernet: fman: fix wrong of_node_put() in probe function

Paul E. McKenney (1):
      locking: Remove smp_read_barrier_depends() from queued_spin_lock_slow=
path()

Peter Zijlstra (2):
      locking/qspinlock: Re-order code
      locking/qspinlock, x86: Provide liveness guarantee

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

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

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trent Piepho (1):
      rtc: snvs: Add timeouts to avoid kernel lockups

Trond Myklebust (1):
      SUNRPC: Fix a potential race in xprt_connect()

Vladimir Murzin (1):
      ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Will Deacon (8):
      signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
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


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwdE6UACgkQONu9yGCS
aT4QsBAApN5Q9JvPQ88ABfYq7nFHD3tTCFjRR+VU7Rslzwjvdhnk6Sat4SCSLyQ+
DClfrgHawnb2cEZbmHrMj+Y4GDJanU/FhRlh0Y17nnwzUF/xtnLwVwWRTGNECHf/
XqbQGV3ohOL9izBRIYfCPOHMo/Wt7GvCdKA1nfTIXQJcm3E08MHLqLj92IACrbY5
O3AdOSt8L7ZaVpMboVx3M8JbnfxIn+U0RS7SkOUyQb47BOBn53SsVEi7vLDIlCrF
MONE2jf+VsHWp+Uk4AiZqQA12Jj6Q9J2aLWIPCzZRWbzyaec4cGg4KUE9je+IbkG
V6q7JCNy/MN5ztkjUlOquvei8MK3DgTUrnqdSnJ6g/gBiKdmb5wijU3j4Zly2X6V
lim63PNfCANPGCOKWZcDYiioZzz/+HqYett7ZsvMRHNy2PpkksUcZgRLL/ItFJ3u
Q9G4nC80y7Zg/L92+S01gfvDp2WOn2xXrsjvA90AMMascSjsMq+U6xmJz7cDt+Ua
QjYEYcV+bAPOJei8JzldtHgi7QKs3WvPmH48Y+c+cVGm47Iu2gv0uWtTsOEuRQUx
m19O2aAhtYDvcrh+/fJS2Rly0WnNfZH5gi/uJleHMuXJXMYLlvnhTDp3UX7O3nG9
DjSbNgVsLg5e/IaXNbxJW5ojxjyEGe2o0UekvX5VW6xXMluvRFk=
=QD2U
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
