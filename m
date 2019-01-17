Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA959C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983D720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725311;
	bh=PRJlRrJSYhelrGeEvJXdfugj9IZv1hvpWgqJk2cZZWg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IyquWlh+Mnj+QxsahBGo8Sp/a6eHCPVCnWgLd/YcUZ6SuzuXnTIvoMDfsKQ+R/VDf
	 N6NnN+/ZdU3xIh4zMKILZ1FBXZzvdIesj/8x5dn3klo1jkRHZXBBkbdyjKXuI+zD/i
	 CBjNytO9nIHi37Q89f+xA3WcBuR2/oPcRAT+nA9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfAQLlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfAQLls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:41:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54D320657;
        Thu, 17 Jan 2019 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725307;
        bh=PRJlRrJSYhelrGeEvJXdfugj9IZv1hvpWgqJk2cZZWg=;
        h=Date:From:To:Cc:Subject:From;
        b=gnhMQoFbnI7FzKrk/Q8IJ2hLSXV1VBol6uDJHcC6+0lmRonXA+T+N9bufPWWhlHq6
         r88YMhqAdK5bK+IcsmLupDsPZGQlrA+iQ5I3vqdS8sxQ2YkwmMuDJd85VCxBP8N2j5
         d5sqCmtZ4tZZyXEFaLi75juoxrjU0M4GuY6gsCjc=
Date:   Thu, 17 Jan 2019 12:41:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.94
Message-ID: <20190117114144.GA2109@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.94 kernel.

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

 Makefile                              |    2=20
 arch/x86/include/asm/kvm_host.h       |   13 +++
 arch/x86/kernel/cpu/bugs.c            |    2=20
 arch/x86/kvm/x86.c                    |   34 +++------
 drivers/acpi/pmic/intel_pmic_xpower.c |   41 ++++++++---
 drivers/acpi/power.c                  |   22 +++++
 drivers/block/rbd.c                   |    9 +-
 drivers/gpu/drm/drm_fb_helper.c       |  126 +++++++++++++++++++----------=
-----
 drivers/i2c/i2c-dev.c                 |    6 +
 drivers/usb/class/cdc-acm.c           |    7 +
 drivers/usb/core/quirks.c             |    3=20
 drivers/usb/storage/scsiglue.c        |    8 +-
 drivers/usb/storage/unusual_devs.h    |   12 +++
 fs/cifs/file.c                        |    8 +-
 fs/cifs/smb2file.c                    |    4 -
 fs/cifs/smb2pdu.c                     |    8 +-
 fs/cifs/transport.c                   |    2=20
 fs/ext4/fsync.c                       |   16 +++-
 fs/ext4/inline.c                      |    6 -
 fs/ext4/inode.c                       |    3=20
 fs/ext4/super.c                       |    2=20
 include/linux/compiler-gcc.h          |    2=20
 include/linux/kvm_host.h              |    2=20
 include/linux/module.h                |    2=20
 include/linux/sunrpc/svc.h            |    5 +
 mm/memory.c                           |   23 ++++++
 mm/slab.c                             |    6 +
 mm/util.c                             |    2=20
 net/sunrpc/svc.c                      |   11 +-
 net/sunrpc/svc_xprt.c                 |    5 -
 net/sunrpc/svcsock.c                  |    2=20
 scripts/mod/modpost.c                 |    2=20
 sound/pci/hda/patch_realtek.c         |   18 ++++
 virt/kvm/arm/arm.c                    |   23 ++----
 34 files changed, 299 insertions(+), 138 deletions(-)

Christoffer Dall (1):
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of the a=
lien cache failed

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

Greg Kroah-Hartman (1):
      Linux 4.14.94

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
      ACPI / PMIC: xpower: Fix TS-pin current-source handling

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specif=
ied
      USB: storage: add quirk for SMI SM3350

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Ivan Mironov (1):
      drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Jan Stancek (1):
      mm: page_mapped: don't assume compound page is huge or THP

Kailang Yang (3):
      ALSA: hda/realtek - Support Dell headset mode for New AIO platform
      ALSA: hda/realtek - Add unplug function into unplug state of Headset =
Mode for ALC225
      ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC2=
25

Michal Hocko (1):
      mm, memcg: fix reclaim deadlock with writeback

Pavel Shilovsky (2):
      CIFS: Fix adjustment of credits for MTU requests
      CIFS: Do not hide EINTR after sending network packets

Rik van Riel (1):
      x86,kvm: move qemu/guest FPU switching out to vcpu_run

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array

Theodore Ts'o (5):
      ext4: make sure enough credits are reserved for dioread_nolock writes
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
      ext4: avoid kernel warning when writing the superblock to a dead devi=
ce
      ext4: use ext4_write_inode() when fsyncing w/o a journal
      ext4: track writeback errors using the generic tracking infrastructure

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxAafgACgkQONu9yGCS
aT72hxAAscpEzanHYBhogE/HPWDLcc0KkPZhJRktcCq0jD9QsOl/5MsOAWoTnPnP
oLg7n2e6s+6nXz6a037OUABSAbqK8Osuyice5PdGpnuGGgp7ZIuQa43LtnRlAbdv
EeeVqGqp5hZzVA38bBPZRlRBnPNolumIDGfhEH9MtTp+1vn8MKZlhSPSUVCE3k9n
EGwiE0FJhtD9J9girrYNWE532U+HVrrvXYBPREpDzXq3P9wi1USncFnMaZS0R8Fh
GY+4iEVOkyAMjHst0bMcDq8Sf8O0A1wYCv/PoNTBMp2MPTFqS11oAbYeWp+Xil+T
qRT/zAO4ahgmvYhTiGGguPXImX5dwFzHERdfLRh8r9PIfVS2H82MaHn6SWamfCLB
AAFZOKJZLKyOJ04YMUWdFuSeM/EeHrd7B17uNwT6DxVVFQIhkMmiEstfrtkhqVNZ
+wwBQLB+rUdBnJrqrIjifOEigVV9TWNpOWSduHZ/cCB5wFTNoTDSVTtEQLOpW9ip
K1XfQse4Rmld5UiHwykn92SLIHEtF+jN5N0Gg/fiZfpba4+EyzS5XaBbHuoiXqmg
ttm7W3tEYNSR+mO0e7MvaG/WHCzf4hsZYQO6oIk8hnXHb7gUfF3eaVs2CMYqcQTH
DErhbaSBP1Y1ObE/cFphQri9+2HjGChENDltW4dmrVQucchx0Vs=
=o70V
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
