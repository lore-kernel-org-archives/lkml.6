Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B209C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183C9208D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAvJLIbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183C9208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756829AbeFPJoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756241AbeFPJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:44:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66616208B5;
        Sat, 16 Jun 2018 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529142292;
        bh=147DVOyA7kVN+8v63zdZCxNv3Dr5YcgAb+f0sAxpQmI=;
        h=Date:From:To:Cc:Subject:From;
        b=eAvJLIbImk79Mfs9u7pc3jQCVMA2ifpb6rVor/KkPcQgsruRXJKNSAQRkCRWNkOPY
         yxspdns70CvnRyXZb+b0VopSXVi+XohEWtJAYuGu6zEQYU5LBhu8XicwOSJD6q2b8D
         KiuLmgflXDsxKuy1QJfpUTBCfCn0qS/s89d1hFNw=
Date:   Sat, 16 Jun 2018 11:44:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.16
Message-ID: <20180616094430.GA4455@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.16 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
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
 drivers/crypto/chelsio/chcr_ipsec.c     |   35 ++--
 drivers/crypto/omap-sham.c              |    2=20
 drivers/crypto/vmx/aes.c                |    2=20
 drivers/crypto/vmx/aes_cbc.c            |    3=20
 drivers/crypto/vmx/aes_ctr.c            |    2=20
 drivers/crypto/vmx/aes_xts.c            |    2=20
 drivers/crypto/vmx/ghash.c              |    2=20
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
 drivers/usb/core/message.c              |    2=20
 drivers/usb/gadget/function/f_printer.c |    6=20
 drivers/usb/gadget/udc/renesas_usb3.c   |   37 +++--
 drivers/usb/storage/uas.c               |    6=20
 drivers/usb/storage/unusual_devs.h      |    9 +
 drivers/usb/storage/unusual_uas.h       |    9 +
 drivers/usb/typec/typec_wcove.c         |   30 +++-
 drivers/usb/usbip/vhci_sysfs.c          |   24 ++-
 net/key/af_key.c                        |   45 ++++--
 net/netfilter/nft_ct.c                  |   20 +-
 44 files changed, 685 insertions(+), 443 deletions(-)

Alexander Kappner (2):
      usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
      usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Atul Gupta (1):
      crypto: chelsio - request to HW should wrap

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
      Linux 4.16.16

Gustavo A. R. Silva (1):
      usbip: vhci_sysfs: fix potential Spectre v1

Heikki Krogerus (1):
      usb: typec: wcove: Remove dependency on HW FSM

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

Ruslan Bilovol (1):
      usb: core: message: remove extra endianness conversion in usb_set_iso=
ch_delay

Sebastian Andrzej Siewior (1):
      tty/serial: atmel: use port->name as name in request_irq()

Taehee Yoo (1):
      netfilter: nf_tables: fix NULL pointer dereference on nft_ct_helper_o=
bj_dump()

Tony Lindgren (1):
      serial: 8250: omap: Fix idling of clocks for unused uarts

Wanpeng Li (1):
      KVM: X86: Fix reserved bits check for MOV to CR3

Yoshihiro Shimoda (7):
      usb: gadget: function: printer: avoid wrong list handling in printer_=
write()
      usb: gadget: udc: renesas_usb3: fix double phy_put()
      usb: gadget: udc: renesas_usb3: should remove debugfs
      usb: gadget: udc: renesas_usb3: should call pm_runtime_enable() befor=
e add udc
      usb: gadget: udc: renesas_usb3: should call devm_phy_get() before add=
 udc
      usb: gadget: udc: renesas_usb3: should fail if devm_phy_get() returns=
 error
      usb: gadget: udc: renesas_usb3: disable the controller's irqs for rec=
onnecting


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsk2/0ACgkQONu9yGCS
aT5MaRAApoprrk4GY0l7WYhX39u7xxMGXaAjRLT997rlXkG3RJVQ7quuojQLZ587
EhxDgbspqO97V/E/vjle3woW7OIuBjSCjHhWZbT1GcGpk6bt9O8FzXkKd3Q3dss/
CtkJEffMTMqwQc8vKetrz5wGdJGBQKPi/GREGOyCJTrag3/aSFfvH8FH5BoaMszO
Y5JTvlW+WI1jYoA2VW+qTY/h0C2CzVK0E7Nk7Wu0MF4PVG8qnQLGHgiAAmUwfsmv
tUKNLHwge/1HbMOxC5c0j3/ItiD88VSAw9+q+r1AX3qmNvO9lvhRSuWFdBlxzDTb
asJnYQlAEgpgz6307ga7lwNZMAGlZ6I9DwR2AzIAxV1QTr8P/zlfBbC+UCzPgE9E
ZH9mHV1ujyUtz/mJLbXNfhB5S7z6DvcAMKOP6cxWRflGOSqPUtvke9d6XRVlEIzt
X7iJdivXnld6i66iB6P1yAth0uAsX1PIZFu1Clqv89GEIlJyn3xdNa3B4ubL1pv0
4+zokC6mrNP3F/zp2hweDLpp9Elbb0OA2nrrzzI1XZ3DxrDUtIlALVLFXixEbylz
U9pXWjzAnoufgQM2S7dp/2lAsbzq4bLO34DaydENdliJmwSIG/NlgdYgT1wxo9QN
8qjzPVLtvzaYLCdT0FNXG4waXqQnL/s/o1Rcd+YCpUKKgqRprwQ=
=8bGr
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
