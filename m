Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325FF208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdwmJidt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325FF208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756889AbeFPJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754061AbeFPJpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:45:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D0E2088E;
        Sat, 16 Jun 2018 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529142318;
        bh=C6NgRj5FFKSY4shloReZzDwywdj37geyQOJPCM6rqvo=;
        h=Date:From:To:Cc:Subject:From;
        b=BdwmJidtLx9YvldoQ2FB8ILMKfLsxVM/sd46rrcBDzKGN4eKt86X010Z9TBDZHgA9
         l4jLRY2Rzt2wVwVDKGAGCQG1GQxMaWPEdydCkWgyNGoxjbJhy2/+lb8yN/CtBRZ376
         JvzfY3ky5x/Q7TtIzFhV3xrX4i01kzpUiBU3ifZU=
Date:   Sat, 16 Jun 2018 11:44:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.50
Message-ID: <20180616094455.GA5862@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.50 kernel.

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

 Makefile                                |    2=20
 arch/x86/include/asm/kvm_emulate.h      |    6=20
 arch/x86/kvm/emulate.c                  |   76 +++++-----
 arch/x86/kvm/vmx.c                      |   38 +++--
 arch/x86/kvm/x86.c                      |   53 +++++--
 arch/x86/kvm/x86.h                      |    4=20
 block/blk-zoned.c                       |    8 -
 drivers/crypto/caam/caamalg.c           |  231 ++++++++++++++-------------=
-----
 drivers/crypto/caam/caamalg_qi.c        |  227 ++++++++++++++++-----------=
----
 drivers/crypto/caam/caampkc.c           |   62 ++++++++
 drivers/crypto/caam/caampkc.h           |    8 +
 drivers/crypto/cavium/zip/common.h      |   21 ++
 drivers/crypto/cavium/zip/zip_crypto.c  |   22 +--
 drivers/crypto/cavium/zip/zip_deflate.c |    4=20
 drivers/crypto/cavium/zip/zip_inflate.c |    4=20
 drivers/crypto/omap-sham.c              |    2=20
 drivers/crypto/vmx/aes.c                |    2=20
 drivers/crypto/vmx/aes_cbc.c            |    3=20
 drivers/crypto/vmx/aes_ctr.c            |    2=20
 drivers/crypto/vmx/aes_xts.c            |    2=20
 drivers/crypto/vmx/ghash.c              |    2=20
 drivers/gpio/gpiolib.c                  |    9 -
 drivers/input/joystick/xpad.c           |    2=20
 drivers/input/mouse/elan_i2c_core.c     |    1=20
 drivers/input/touchscreen/goodix.c      |    1=20
 drivers/misc/vmw_balloon.c              |   23 ---
 drivers/nfc/pn533/usb.c                 |   42 ++++-
 drivers/phy/qualcomm/phy-qcom-qusb2.c   |    4=20
 drivers/staging/android/ion/ion.c       |    5=20
 drivers/tty/serial/8250/8250_omap.c     |   16 ++
 drivers/tty/serial/amba-pl011.c         |   16 ++
 drivers/tty/serial/atmel_serial.c       |    5=20
 drivers/tty/serial/samsung.c            |    7=20
 drivers/tty/serial/sh-sci.c             |    4=20
 drivers/usb/gadget/function/f_printer.c |    6=20
 drivers/usb/gadget/udc/renesas_usb3.c   |    7=20
 drivers/usb/storage/uas.c               |    6=20
 drivers/usb/storage/unusual_devs.h      |    9 +
 drivers/usb/storage/unusual_uas.h       |    9 +
 drivers/usb/usbip/vhci_sysfs.c          |   24 ++-
 net/key/af_key.c                        |   45 ++++--
 net/netfilter/nft_ct.c                  |   20 +-
 42 files changed, 628 insertions(+), 412 deletions(-)

Alexander Kappner (2):
      usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
      usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Bart Van Assche (1):
      blkdev_report_zones_ioctl(): Use vmalloc() to allocate large buffers

Bin Liu (1):
      crypto: omap-sham - fix memleak

Dave Martin (1):
      tty: pl011: Avoid spuriously stuck-off interrupts

Ethan Lee (2):
      Input: xpad - add GPD Win 2 Controller USB IDs
      Input: goodix - add new ACPI id for GPD Win 2 touch screen

Felix Wilhelm (1):
      kvm: nVMX: Enforce cpl=3D0 for VMX instructions

Geert Uytterhoeven (1):
      serial: sh-sci: Stop using printk format %pCr

Gil Kupfer (1):
      vmw_balloon: fixing double free when batching mode is off

Greg Kroah-Hartman (2):
      NFC: pn533: don't send USB data off of the stack
      Linux 4.14.50

Gustavo A. R. Silva (1):
      usbip: vhci_sysfs: fix potential Spectre v1

Horia Geant=C4=83 (5):
      crypto: caam - strip input zeros from RSA input buffer
      crypto: caam - fix DMA mapping dir for generated IV
      crypto: caam - fix IV DMA mapping and updating
      crypto: caam/qi - fix IV DMA mapping and updating
      crypto: caam - fix size of RSA prime factor q

Jan Glauber (2):
      crypto: cavium - Fix fallout from CONFIG_VMAP_STACK
      crypto: cavium - Limit result reading attempts

Johannes Wienke (1):
      Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Kevin Easton (1):
      af_key: Always verify length of provided sadb_key

Laura Abbott (1):
      staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy

Linus Walleij (1):
      gpio: No NULL owner

Manu Gautam (1):
      phy: qcom-qusb2: Fix crash if nvmem cell not specified

Marek Szyprowski (1):
      serial: samsung: fix maxburst parameter for DMA transactions

Michael Ellerman (2):
      crypto: vmx - Remove overly verbose printk from AES init routines
      crypto: vmx - Remove overly verbose printk from AES XTS init

Paolo Bonzini (3):
      KVM: x86: introduce linear_{read,write}_system
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_vi=
rt_system
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor ac=
cess

Sebastian Andrzej Siewior (1):
      tty/serial: atmel: use port->name as name in request_irq()

Taehee Yoo (1):
      netfilter: nf_tables: fix NULL pointer dereference on nft_ct_helper_o=
bj_dump()

Tony Lindgren (1):
      serial: 8250: omap: Fix idling of clocks for unused uarts

Wanpeng Li (1):
      KVM: X86: Fix reserved bits check for MOV to CR3

Yoshihiro Shimoda (2):
      usb: gadget: function: printer: avoid wrong list handling in printer_=
write()
      usb: gadget: udc: renesas_usb3: disable the controller's irqs for rec=
onnecting


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsk3BcACgkQONu9yGCS
aT5ZqA//e1UZousJiHoW29Z6E+Gxvy8sFCXk8DGYu59KN4sz5u64Iu9Ov4TsdgTq
DyPjzhZ2om3XB7EsthnRQpS4ghmJx2SGXpQlCZycYofTLWbcXwaGIgvCCiBHc4kV
UVROw2/A5i8nhctQCu98dtESNnwPQFioW+8zTRHz8T3vVFlg/VRYIpYDxCOb6wPE
vgzTESdw4JZ7yYZidRHjjWlUDTXI25buFwTKTiNwSEkljLQs7uaqdySVj4D+8VZx
mzD24oHhzhBamI33JdoBJNPwycCo4R70txT52O8AbXL9DnOz3fKwg0IWEM0FCoxn
KFKmwxUaSIJVdQivqmCpn95VLt6IuvUGw4WzP99zQD5903WGRPTCyNwdV+WX9SEI
zHUGs0UO13J/k+sMfIFgJjniTa5QgGBqJBkg37LTi1fx0bv1HEkiLQy6KZO+cvqn
6HJeYRpiiA1kVyV9jva9QtiwpD4TYegImpaSu/B2PWxiHx4pF2dR3bnjr22fo1SL
bCwz1adTn9mTzhTar3XoV5fCg9xkXZIfCefhVLNRsQzBJJmoF6+goPyXa9o7VXjf
jbhOjTRSPKd7chNRXz7AHjGg6YGzVrAlk7tLGsisAt9qf+wDIY6nfZO5s7z6EitB
/iebfaYbAA1VEAzESx53Vz9i/pWq4uBpkjs6/SJh6LQEQi8nt7c=
=DnmC
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
