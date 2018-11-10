Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2FC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3120892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CluzHBkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD3120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeKKCBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbeKKCBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:01:34 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406DD20858;
        Sat, 10 Nov 2018 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541866560;
        bh=fO06ZCHnGE4pUC0cfuDqq7YEMxpxV37kVmL6NwqP4Po=;
        h=Date:From:To:Cc:Subject:From;
        b=CluzHBkQE7Y9mHwLifLvJ1Jk4GWNuVSTdGCzqw7jZuvJ0/cme5Upv08edJ+OhuVJT
         9nxhcB9Wo/56xtZni2qNZfcsUZeVFw9ppKxl7DRdg3f3uDGw/i3+opvJJgk4YvnCql
         6nraGX/rsc+99MznjKQMK3n1NaGD0Uxt7Tj2fK/I=
Date:   Sat, 10 Nov 2018 08:15:59 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.80
Message-ID: <20181110161559.GA28761@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.80 kernel.

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

 Makefile                                              |    2=20
 arch/arm/boot/dts/tegra20.dtsi                        |    2=20
 arch/x86/include/asm/fpu/internal.h                   |    2=20
 arch/x86/include/asm/percpu.h                         |    8 -
 arch/x86/kernel/setup.c                               |    2=20
 arch/x86/kernel/time.c                                |    2=20
 arch/x86/kernel/tsc.c                                 |    6 -
 drivers/gpio/gpio-mxs.c                               |    4=20
 drivers/gpu/drm/drm_edid.c                            |    5=20
 drivers/gpu/drm/drm_fb_helper.c                       |   91 +++++--------=
-----
 drivers/infiniband/core/ucm.c                         |    3=20
 drivers/infiniband/core/ucma.c                        |    3=20
 drivers/input/mouse/elan_i2c_core.c                   |    1=20
 drivers/misc/eeprom/at24.c                            |   17 +++
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |   16 ++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h      |    1=20
 drivers/ptp/ptp_chardev.c                             |    4=20
 drivers/usb/class/cdc-acm.c                           |   16 +--
 drivers/usb/core/devio.c                              |    4=20
 drivers/usb/gadget/function/f_mass_storage.c          |    3=20
 drivers/usb/serial/option.c                           |   15 ++
 drivers/usb/usbip/vhci_hcd.c                          |   57 ++++++++---
 fs/cachefiles/namei.c                                 |    2=20
 fs/ioctl.c                                            |    2=20
 fs/nfsd/vfs.c                                         |    3=20
 fs/notify/fsnotify.c                                  |   14 --
 fs/overlayfs/copy_up.c                                |    2=20
 fs/read_write.c                                       |   17 ++-
 fs/xfs/libxfs/xfs_trans_resv.c                        |    9 -
 include/drm/drm_edid.h                                |    6 -
 include/linux/bpf_verifier.h                          |    3=20
 include/linux/fs.h                                    |   17 ---
 kernel/bpf/verifier.c                                 |   10 +
 kernel/sched/fair.c                                   |   22 +++-
 kernel/sched/sched.h                                  |    2=20
 35 files changed, 215 insertions(+), 158 deletions(-)

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Alan Chiang (1):
      eeprom: at24: Add support for address-width property

Alan Stern (1):
      USB: fix the usbfs flag sanitization for control transfers

Amir Goldstein (2):
      vfs: swap names of {do,vfs}_clone_file_range()
      fsnotify: fix ignore mask logic in fsnotify()

Brian Foster (1):
      xfs: truncate transaction does not modify the inobt

Christophe Leroy (1):
      net: fs_enet: do not call phy_stop() in interrupts

Clint Taylor (1):
      drm/edid: VSDB yCBCr420 Deep Color mode bit definitions

Daniel Borkmann (1):
      bpf: fix partial copy of map_ptr when dst is scalar

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests

Greg Kroah-Hartman (1):
      Linux 4.14.80

Gustavo A. R. Silva (4):
      ptp: fix Spectre v1 vulnerability
      RDMA/ucma: Fix Spectre v1 vulnerability
      IB/ucm: Fix Spectre v1 vulnerability
      usb: gadget: storage: Fix Spectre v1 vulnerability

Johan Hovold (1):
      USB: serial: option: add two-endpoints device-id flag

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Kristian Evensen (1):
      USB: serial: option: improve Quectel EP06 detection

Linus Walleij (1):
      gpio: mxs: Get rid of external API call

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Nathan Chancellor (1):
      x86/time: Correct the attribute on jiffies' definition

Oliver Neukum (1):
      cdc-acm: fix race between reset and control messaging

Peter Zijlstra (2):
      x86/tsc: Force inlining of cyc2ns bits
      x86/percpu: Fix this_cpu_read()

Phil Auld (1):
      sched/fair: Fix throttle_list starvation with low CFS quota

Sasha Levin (1):
      Revert "ARM: tegra: Fix ULPI regression on Tegra20"

Sebastian Andrzej Siewior (1):
      x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on =
context switch if there is an FPU

Shuah Khan (Samsung OSG) (1):
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Tobias Herzog (2):
      cdc-acm: do not reset notification buffer index upon urb unlinking
      cdc-acm: correct counting of UART states in serial state notification

Zhimin Gu (1):
      x86, hibernate: Fix nosave_regions setup for hibernation


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvnBD8ACgkQONu9yGCS
aT6wCg//afgbXD7dqEUoHxlN3AJceDabDOu3w7uIlYAAmWbZykku7LsVJQe5lyUM
o14vQ9gO+7nHhRrN48Uyv+mqjobcBRpHkbKjKtI9uYgGg9cUgo6UU5zliU6xfJLz
nZjKJkWePTqTzWyZrY0obgtdgxHx//giJTsiApIsxf7eUmD+8fhBJjD+wjBt/HoC
ABz+al75O/J4+2bkpF2CYB2apfGRdA32M7v+7oxgqXxHOhST+tOMuyANGWoDwt8C
haDno/R/pOlptQYUpqdopAE6nSMDMSePn6bVYAgZcSwFb/pgTLxRm14WnPwrNUSG
b9n3j2etTAsi5J+c8rFkn2l3fyVH6CsPV4qEt/F1K6boZ8lBxumr6YaL2clVoBo0
iFUEMZo7bzAUKpsBUkL7REIi48skKXYX2Igz0AtX08v4IVrcN+M6GFiGpQwN7nt0
RPgLN6ZO2aY1AGIREMiH1WLdk/qtJOu6qayowh9ZYcVkbRIPdewUy3/HrfX8IrFS
ROVrKC4ptNHX57TKY9U3UhSwtwXUzM6HhzaZLvTZWIoQSr6BLi2j51LIpaS+dGzS
nyDw/5jgkAnym2RXFJS132gXpT0/PC137m2eqoNxSFmA3idUSgW+m/RxLXdGpsbs
0r8x/Q9B68XcooFzrgGzmx+bNOjmATuade7CRKURbD4n77VItpY=
=jU1S
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
