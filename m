Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9857C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B1920873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546088921;
	bh=yc95Il/209C7sfV7g1N3uhf9Q+8OpjH9UY0pOhE+984=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2o1b9VJBUgp8wKRZlkVccKyuSw3Vumfjij8/vziZ/GdxEECC6N0E9GO4ETeL2M0JB
	 FIeQrzQ8gyS36bY2NQy2wXagSXlsBBgFILfyqOVBP3mf886GPNyILxbajtadvLks+G
	 9QujtATA7VhfIN/N4UyeYtVPtGTB4nE9zJR0Eng8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeL2NIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeL2NIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:08:38 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A505320873;
        Sat, 29 Dec 2018 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546088917;
        bh=yc95Il/209C7sfV7g1N3uhf9Q+8OpjH9UY0pOhE+984=;
        h=Date:From:To:Cc:Subject:From;
        b=lfgk2DC4ao9CGnpwHhikzClFnz0UuApX4gjFu0QyMhT885rR7rmH890H+6lg6oX6A
         rHdWXj56ylvwgZ9/DpcbLcKMEEX2a24QrFWLJhsn3xydh8opVqOmq/l2IS2M1pzSKA
         JoeWSgBHTgV8C+3DHuoadIGRzb7pzgtCxWhI2I4s=
Date:   Sat, 29 Dec 2018 14:08:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.148
Message-ID: <20181229130834.GA15298@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.148 kernel.

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

 Makefile                              |    2 -
 arch/x86/kernel/cpu/mtrr/if.c         |    2 +
 arch/x86/kernel/fpu/signal.c          |    4 +--
 block/blk-lib.c                       |   22 +++++++++++++++++---
 drivers/gpio/gpio-max7301.c           |   12 ++---------
 drivers/gpu/drm/drm_ioctl.c           |   10 +++++++--
 drivers/hv/vmbus_drv.c                |   20 ++++++++++++++++++
 drivers/infiniband/ulp/srpt/ib_srpt.c |    4 +--
 drivers/mmc/core/mmc.c                |   24 +++++++++++++---------
 drivers/mmc/host/omap_hsmmc.c         |   12 ++++++++++-
 drivers/net/usb/hso.c                 |   18 ++++++++++++++--
 drivers/usb/host/xhci-hub.c           |    3 +-
 drivers/usb/serial/option.c           |   16 +++++++++++++-
 fs/proc/proc_sysctl.c                 |   13 +++++------
 fs/ubifs/replay.c                     |   37 +++++++++++++++++++++++++++++=
+++++
 kernel/panic.c                        |    6 ++++-
 16 files changed, 164 insertions(+), 41 deletions(-)

Bart Van Assche (1):
      ib_srpt: Fix a use-after-free in __srpt_close_all_ch()

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Colin Ian King (1):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Greg Kroah-Hartman (1):
      Linux 4.9.148

Gustavo A. R. Silva (1):
      drm/ioctl: Fix Spectre v1 vulnerabilities

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Ivan Delalande (1):
      proc/sysctl: don't return ENOMEM on lookup when a table is unregister=
ing

Jens Axboe (1):
      block: break discard submissions into the user defined size

J=F6rgen Storvist (4):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Mikulas Patocka (1):
      block: fix infinite loop if the device loses discard capability

Richard Weinberger (1):
      ubifs: Handle re-linking of inodes correctly while recovery

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sebastian Andrzej Siewior (1):
      x86/fpu: Disable bottom halves while loading FPU registers

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwncdIACgkQONu9yGCS
aT5ZVRAAolBWLhPkkrEFtR/AHCK78/IGE2A03g8aOGMwYotzhkQHMfCEN3m0MjlW
az4/B6s2cEhrlVSzUnpVG84WpmFdenLnQApVabK21ZjG8/86H950GsElxFt2SzjA
64cJ6Lwc3WDbcEA/XFYqhlJ1PYtt+8bfmvLNNle1qJFpGZMAmqKHxnapYdjWdqoK
BTES6GZB5TtvwDPndvq6BPGdh7BgRAyKqHr3jYXJZDL4yHLLmHs24iJh4CtWtRMS
rfkXT64BZjZtmKqLnaQEHD+vecaD8y+OyWP+hdirvGAqjfEzG4KGc+HyuvD+ZbiL
iL/UcTTAr7a8kFuk3WdMWlB9hBmiEkl0zczokZPL/U0ypJgc843m4+iqh/3zMljh
0ueoSvvhgMiHrVTEgbC+2RT5jTqQ2DFS6Jhn7ky38iBE9aWPqRTBHYvhj5C4/Ica
PynZT1nksf5SZbyD9kwFxrqzI1fZe7TEsms2Ck94zzSsFxCzX5k26/iSjsyfTfsv
Z1v9q6DdkwdwDoQCFTsDwgfPjPKKhTBpN88UWWztE4rhuTjXlPOKpuzbKUCAAQ2y
ApnPAn+YxuaTUmbT7TZmZkLXQ0tb5woZ+Kw7VOe5YeiNzqQ353NFPXNbSwiXvaEI
pl7QUFyNJuoTgM/uhgreQB6LxeMT70UD3UFpyxb/h+XFupehCMs=
=gaGR
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
