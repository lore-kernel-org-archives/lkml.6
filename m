Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2165CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D680321924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409406;
	bh=eFI5bNDkuilzMSwasCuKTrgAdwA76L/XD3DmoaylHNY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=irGzR9RHcwRAzR4tJaU6f4tGVJYnCiiYDYTd8eUf8LWpYwKEWh2Ftv086YyWrGr2R
	 pZ/m4aSQlTQnXs4Y+S4v3noX18lphilofF89PXF44R2SG6rfcYOsbHghAuSwEvK5ce
	 n0rsoKcG7lHvts3KYXuv+DbNePLNxzP03MIFOj1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbeLUQXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbeLUQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:23:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D008E21903;
        Fri, 21 Dec 2018 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409403;
        bh=eFI5bNDkuilzMSwasCuKTrgAdwA76L/XD3DmoaylHNY=;
        h=Date:From:To:Cc:Subject:From;
        b=RZa2LnylCA8ikG4cdf6q2vr0K74fLKCuR3raH73ax3CRfg6FANAA+dnbRwiPQzDCS
         yBJz9sJFFXf1O/6Kyh5L1lqkooEAoaJIALyvK8ThrKL2lp/fpuLzDN+mmJSSj2eOGK
         OlbB3gTNMCLHcBqzvu48i8mE/CamklR77VC39JsY=
Date:   Fri, 21 Dec 2018 17:23:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.169
Message-ID: <20181221162319.GA7209@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.169 kernel.

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

 Makefile                                    |    2=20
 arch/arc/include/asm/io.h                   |   72 +++++++++++++++++++
 arch/arm/mm/cache-v7.S                      |    8 +-
 arch/powerpc/boot/Makefile                  |    3=20
 arch/powerpc/kernel/msi.c                   |    7 +
 arch/x86/platform/efi/early_printk.c        |    2=20
 drivers/ata/libata-core.c                   |    1=20
 drivers/clk/mmp/clk.c                       |    2=20
 drivers/gpu/drm/msm/msm_atomic.c            |    5 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    6 -
 drivers/i2c/busses/i2c-axxia.c              |   40 +++++++---
 drivers/i2c/busses/i2c-scmi.c               |   10 +-
 drivers/ide/pmac.c                          |    1=20
 drivers/input/keyboard/omap4-keypad.c       |   18 +++-
 drivers/mmc/host/omap.c                     |   11 ++
 drivers/net/bonding/bond_3ad.c              |    3=20
 drivers/net/dsa/mv88e6060.c                 |   10 --
 drivers/net/wireless/mac80211_hwsim.c       |   12 +--
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c  |    2=20
 drivers/rtc/rtc-snvs.c                      |  104 ++++++++++++++++++-----=
-----
 drivers/sbus/char/display7seg.c             |    1=20
 drivers/sbus/char/envctrl.c                 |    2=20
 drivers/scsi/libiscsi.c                     |    4 -
 drivers/scsi/vmw_pvscsi.c                   |    4 -
 drivers/tty/serial/suncore.c                |    1=20
 fs/aio.c                                    |    2=20
 fs/cifs/Kconfig                             |    2=20
 fs/f2fs/segment.c                           |    5 +
 kernel/time/timer_list.c                    |    2=20
 kernel/trace/ftrace.c                       |    1=20
 kernel/trace/trace_events_trigger.c         |    6 +
 lib/interval_tree_test.c                    |   93 ++++++++++++++++-------=
--
 lib/rbtree_test.c                           |   55 +++++++++-----
 net/mac80211/mlme.c                         |    3=20
 net/sunrpc/xprt.c                           |   11 ++
 sound/isa/wavefront/wavefront_synth.c       |    9 ++
 36 files changed, 375 insertions(+), 145 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

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

Dan Carpenter (2):
      clk: mmp: Off by one in mmp_clk_add()
      ALSA: isa/wavefront: prevent some out of bound writes

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
      Linux 4.4.169

Guenter Roeck (1):
      powerpc/boot: Fix random libfdt related build errors

Guy Shapiro (1):
      rtc: snvs: add a missing write sync

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI devi=
ce node

Ilan Peer (1):
      mac80211: Fix condition validating WMM IE

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jose Abreu (1):
      ARC: io.h: Implement reads{x}()/writes{x}()

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

Sean Paul (1):
      drm/msm: Grab a vblank reference when waiting for commit_done

Steve French (1):
      cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure =
cifs)

Steven Rostedt (VMware) (2):
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trent Piepho (1):
      rtc: snvs: Add timeouts to avoid kernel lockups

Trond Myklebust (1):
      SUNRPC: Fix a potential race in xprt_connect()

Yangtao Li (4):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()
      ide: pmac: add of_node_put()

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths

Yunlei He (1):
      f2fs: fix a panic caused by NULL flush_cmd_control


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwdE3UACgkQONu9yGCS
aT5tNg/8CJ5LzViMA/FpfGynSHqTegWpZAhNGw7tNoPulYm/DTuE0SCRwvlXh5or
NE2QrtuhMbnpZS9NKkzWfS/QXf/2kFa1k5YvRz0nieY0NfFxB+kFseksy4qrSW/V
k3J0Mb6/M8lhDdQIgpFT2fWvXNY/VBH+s02w6KxGkVz/HecqJ9rYkwG+g7LfwCO8
GpxjE8wvzeoLBwRZ/ay8JTHTXYCZrjoW2olauO19o3GyLjyzdnHv+CN5xYCjy2w9
RP9H+UhxJYfQArj8S/FVGcKI8EYJrgg1uYXOs1CFv2lspXgx/gTed0H+wPllE4ti
ZPCR1RW7r54+2cNi6GP1gMk7BlpXlYg0H5xYwIZ/eg3/BOzkp2gc8ft0O7hGXtmW
L+7bGQ0TB6+wKj6PoGaynNVxzK/tlLPfooBLOsh3UpMclrGwvZUQ3K5UVubM7kh4
eZ58xfUQrPL68c6qwYt4bfRiVhXkcskTYDokVnCirFlTKQqxHe9DvvBhvdQTefPJ
mAVc2tsnNHhbGKNneigVsuaUik27FvhWwwNmPF62jswD7crzFauqB/ornUvw4lvZ
9sDB07MdXG20q9AYnUzD9alZsU3Kk0pUXRMLV3RqiEIGoaK4wblb/ZEptzmdeCvG
aakePZ2FTSV8w8ZACjk3OCR5qlck1cMvvw8Y3+E9nZMTbJ/dD/o=
=dq5w
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
