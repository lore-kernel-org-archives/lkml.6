Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FCC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2744B208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1iEUKGJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2744B208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbeFPJpy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754137AbeFPJpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:45:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0296D2088E;
        Sat, 16 Jun 2018 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529142350;
        bh=8cw+VRR4DG9SwdHIxfVfpao/4HPy05nY3YR8BpjnxhU=;
        h=Date:From:To:Cc:Subject:From;
        b=1iEUKGJeUEDT5aSGyyyTdS3z5Z4k3sv/QS9nTCoDUgd3Mc633RZSE3K/ODrsdfMMe
         /t+IspWbkEstDFA7/2nNeLiBH8dLGuKEm31uMZEorkpHgklQHY8ZgHSSsMg5cfN48M
         ngQCKr7dtQAsrmeEJ9pPZDP2kAUHTNqAWrD+hbsU=
Date:   Sat, 16 Jun 2018 11:45:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.109
Message-ID: <20180616094527.GA7553@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.109 kernel.

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

 Makefile                                 |    2=20
 arch/x86/crypto/crc32c-intel_glue.c      |    5 -
 arch/x86/include/asm/cpufeatures.h       |    2=20
 arch/x86/include/asm/fpu/internal.h      |    2=20
 arch/x86/include/asm/kvm_emulate.h       |    6 +-
 arch/x86/kernel/fpu/init.c               |   91 +-------------------------=
-----
 arch/x86/kvm/emulate.c                   |   72 ++++++++++++------------
 arch/x86/kvm/vmx.c                       |   23 +++----
 arch/x86/kvm/x86.c                       |   51 ++++++++++++-----
 arch/x86/kvm/x86.h                       |    4 -
 drivers/crypto/omap-sham.c               |    2=20
 drivers/crypto/vmx/aes.c                 |    2=20
 drivers/crypto/vmx/aes_cbc.c             |    2=20
 drivers/crypto/vmx/aes_ctr.c             |    2=20
 drivers/crypto/vmx/ghash.c               |    2=20
 drivers/gpio/gpiolib.c                   |    9 ++-
 drivers/input/mouse/elan_i2c_core.c      |    1=20
 drivers/input/touchscreen/goodix.c       |    1=20
 drivers/misc/vmw_balloon.c               |   23 ++-----
 drivers/net/bonding/bond_main.c          |   22 ++++---
 drivers/nvme/host/pci.c                  |    4 -
 drivers/nvme/target/admin-cmd.c          |   22 ++++---
 drivers/nvme/target/core.c               |    5 -
 drivers/nvme/target/nvmet.h              |    2=20
 drivers/staging/android/ion/ion.c        |    5 +
 drivers/tty/serial/8250/8250_omap.c      |   16 +++++
 drivers/tty/serial/amba-pl011.c          |   16 +++++
 drivers/tty/serial/atmel_serial.c        |    5 -
 drivers/tty/serial/samsung.c             |    7 --
 drivers/tty/serial/sh-sci.c              |    4 -
 drivers/usb/gadget/udc/renesas_usb3.c    |    7 ++
 drivers/usb/storage/uas.c                |    6 ++
 drivers/usb/storage/unusual_devs.h       |    9 +++
 drivers/usb/storage/unusual_uas.h        |    9 +++
 drivers/usb/usbip/vhci_sysfs.c           |   24 +++++---
 include/net/bonding.h                    |    5 +
 net/key/af_key.c                         |   45 +++++++++++----
 tools/arch/x86/include/asm/cpufeatures.h |    2=20
 38 files changed, 273 insertions(+), 244 deletions(-)

Alexander Kappner (2):
      usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
      usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Andreas Born (1):
      bonding: require speed/duplex only for 802.3ad, alb and tlb

Andy Lutomirski (2):
      x86/fpu: Hard-disable lazy FPU mode
      x86/crypto, x86/fpu: Remove X86_FEATURE_EAGER_FPU #ifdef from the crc=
32c code

Bin Liu (1):
      crypto: omap-sham - fix memleak

Dave Martin (1):
      tty: pl011: Avoid spuriously stuck-off interrupts

Ethan Lee (1):
      Input: goodix - add new ACPI id for GPD Win 2 touch screen

Geert Uytterhoeven (1):
      serial: sh-sci: Stop using printk format %pCr

Gil Kupfer (1):
      vmw_balloon: fixing double free when batching mode is off

Greg Kroah-Hartman (2):
      perf: sync up x86/.../cpufeatures.h
      Linux 4.9.109

Gustavo A. R. Silva (1):
      usbip: vhci_sysfs: fix potential Spectre v1

Johannes Thumshirn (1):
      nvmet: Move serial number from controller to subsystem

Johannes Wienke (1):
      Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Keith Busch (1):
      nvme-pci: initialize queue memory before interrupts

Kevin Easton (1):
      af_key: Always verify length of provided sadb_key

Laura Abbott (1):
      staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy

Linus Walleij (1):
      gpio: No NULL owner

Mahesh Bandewar (2):
      bonding: correctly update link status during mii-commit phase
      bonding: fix active-backup transition

Marek Szyprowski (1):
      serial: samsung: fix maxburst parameter for DMA transactions

Martin Wilck (2):
      nvmet: don't report 0-bytes in serial number
      nvmet: don't overwrite identify sn/fr with 0-bytes

Michael Ellerman (1):
      crypto: vmx - Remove overly verbose printk from AES init routines

Paolo Bonzini (3):
      KVM: x86: introduce linear_{read,write}_system
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_vi=
rt_system
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor ac=
cess

Sebastian Andrzej Siewior (1):
      tty/serial: atmel: use port->name as name in request_irq()

Tony Lindgren (1):
      serial: 8250: omap: Fix idling of clocks for unused uarts

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: disable the controller's irqs for rec=
onnecting


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsk3DcACgkQONu9yGCS
aT7q3g//cWrX2sv9w//P2C5SYJELIrKiElRrDqeTogKLS7pBwMCaUsIZpqEVGbiQ
7OnUuCl1TX75OfbNy1wOfSV4h6ds2ykXw4ONtK+OEdw1mlYjisczgFxQYVu4AT0i
+7q+7EN/NTra7njncJX0HL5l53Kqohi8P0DcvyL493EAPXcpbdQ/DsYkhEsoAd2n
e+59/8PzBRAwJTPeitik/ht+sCIoe/BG5tpA5jokoYOHSr4AGLW6KnjPfRcZUcGR
yYIRpFWbus9MH0aaFJ6FX9TsMVepK0Hv2tpRYgfptpMRsqaIK7moa3hY5Itjbeet
dswXdFqyYvw9GQ7whUIXxJR2wCTbiz1rSRlROa2KTD9wwALadY9KdxcLsPJCvbf2
12nCOlSfoqUUcnyuV/akvIqy04x7oE17xBDWp5l8qnOf4NYhc9Ygad25sqoCzRPP
r6so2A3D5VUDkalbyTvuUGhZWNcBXfpB1pL6fZgGy5r/A9Fm5T/Iv9RRx8KeA7zm
rluspXAyaJ2iD712rJwoHOLzSiT366kK8V13fBx2xrzWyD5XkdA+dPkU2CuJbMZ6
ObWbKfXssV+BAJ16VWzWYpYgdypxekJl1OsBMeWx9m7nzaC+ROBmeYCceyEpYP5M
eSGQyUsMmsHI/4MJcBSQTkLuhORlhDv/l3ZwGJG5mnyRUaRpl0s=
=+mrt
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
