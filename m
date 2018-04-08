Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523200259-5-4256520129582691408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523200256; b=lKXEIH4UODfjeBbgjXKA0HPHNi1rS6JsgWR5j2mlUXkyUMGnxT
    d1KDSgzPCwyxnP9r25rfUka+Q7p8/5A/FVHemH5yfJLSETzPF6Uj5VqK+2Vt3KjG
    WtlegwBm3EU9jddpzkYE2KbVQBkeYM+TYUPo2GGlEVLG1Hbd4KDJORwJIeSqADE+
    zZ8LUWqXB88kHWab9ruPnZLff18zLbphbixkpFufLw2lcpDcBEW16mLx4CKLbvVe
    QOL4SEz11/MUXVBt9ICneU6mPpTLS5n56xUkOW9fLlxa9dQmhzg/l60UBkWCBsQM
    MzkxdF15vu3XKJecW6kfTG7D4Fu6Ce12aX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523200256;
    bh=3L1gyJJlygrmAcTdm9i07JR3hSQTuHjOTBurrsYj4+s=; b=GO39Ypujz6pi
    nuGwL9paM+2lyc52KW6tLjKTQXYQzT967za5MwfoaIo3ggmKmbTX5W2C0z8YEEem
    44hEaqYjp9WzPwoImet2o2b6IuzVXAhYB7keU+cPnsgdRwqqGh2ThXWQaqMeeK/Q
    dg/Ms3xjc+HP1LFlQZNwbVmLw+DJLCMR1kAn5BsZL6y5EXRESjCF99dzfxmiy7Dq
    ih1LHlPmLirGcYd9l0d9/gW5YM4iUe7enZRb6g4j79V11GL65RuyIk/HPsCmvOO9
    JXjSFi6mPyUH6YHwTSqF4VnFdzqQziPoLFYjCxw1Uj2DpiyNCOXm51WmJPhm72mW
    PTcQlBoDvg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC1YXS/70a9j3CV9LGI3hflWY6H0qflAU+oPWtBJnLBIZ2NQba4nUfUmsP5hGJX7iqzWGy7QtyQcmOs09WfZs4jq7JNh6TrCunL84HhHPsIg8YeQyOFV
    qGYwcAq53X5SsF6ohgK9F86/oBO+Qzrn0pH4qhCdDm6dR1GR1iDHFSPv81HmgpMEhFcpPhtbuVMmtVXWGq6q4YZLlyVV/uQho1fCh4udKbIW2iphVPrr/GBl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=NXRJqRMSX7HBYtoNxQ4A:9 a=CjuIK1q_8ugA:10 a=Wl1ffxZU5OMkNWDpsLcA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeDHPKU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:10:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeDHPKT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:10:19 -0400
Date: Sun, 8 Apr 2018 17:10:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.1
Message-ID: <20180408151014.GA16271@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.1 kernel.

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

 Documentation/devicetree/bindings/serial/8250.txt |    1=20
 Makefile                                          |    2=20
 arch/arm/crypto/Makefile                          |    2=20
 arch/arm64/crypto/Makefile                        |    2=20
 arch/x86/crypto/cast5_avx_glue.c                  |    3=20
 block/bio.c                                       |    4=20
 crypto/ahash.c                                    |    7=20
 crypto/lrw.c                                      |    2=20
 crypto/testmgr.h                                  |    6=20
 drivers/base/arch_topology.c                      |   12 -
 drivers/bluetooth/hci_bcm.c                       |    6=20
 drivers/char/mem.c                                |    6=20
 drivers/crypto/caam/ctrl.c                        |    3=20
 drivers/crypto/ccp/ccp-crypto-aes-cmac.c          |    2=20
 drivers/crypto/ccp/ccp-crypto-rsa.c               |    7=20
 drivers/crypto/ccp/ccp-crypto-sha.c               |    2=20
 drivers/crypto/inside-secure/safexcel.c           |    2=20
 drivers/crypto/talitos.c                          |  168 ++++++++---------=
-----
 drivers/input/mouse/alps.c                        |   24 ++-
 drivers/input/serio/i8042-x86ia64io.h             |   24 +++
 drivers/media/usb/usbtv/usbtv-core.c              |    2=20
 drivers/misc/mei/main.c                           |    1=20
 drivers/parport/parport_pc.c                      |    4=20
 drivers/siox/siox-core.c                          |    2=20
 drivers/staging/comedi/drivers/ni_mio_common.c    |    2=20
 drivers/tty/serial/8250/8250_of.c                 |    1=20
 drivers/tty/serial/8250/8250_port.c               |   33 ++++
 drivers/tty/vt/vt.c                               |    6=20
 drivers/usb/serial/cp210x.c                       |    1=20
 drivers/usb/serial/ftdi_sio.c                     |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                 |    9 +
 fs/btrfs/inode.c                                  |   37 ++++
 include/linux/bitmap.h                            |   22 ++
 include/linux/compat.h                            |    6=20
 include/uapi/asm-generic/siginfo.h                |    7=20
 include/uapi/linux/serial_core.h                  |    3=20
 36 files changed, 268 insertions(+), 155 deletions(-)

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (1):
      mei: remove dev_err message on an unsupported ioctl

Conor McLoughlin (1):
      crypto: testmgr - Fix incorrect values in PKCS#1 test vector

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Eric Biggers (1):
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one

Eric W. Biederman (1):
      signal: Correct the offset of si_pkey and si_lower in struct siginfo =
on m68k

Frank Mori Hess (1):
      staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Gaku Inami (1):
      Revert "base: arch_topology: fix section mismatch build warnings"

Gary R Hook (1):
      crypto: ccp - Fill the result buffer only on digest, finup, and final=
 ops

Gavin Schenk (1):
      siox: fix possible buffer overflow in device_add_store

Greg Kroah-Hartman (1):
      Linux 4.16.1

Gregory CLEMENT (1):
      crypto: inside-secure - fix clock management

Hans de Goede (1):
      Bluetooth: hci_bcm: Add 6 new ACPI HIDs

Herbert Xu (2):
      crypto: lrw - Free rctx->ext with kzfree
      crypto: ahash - Fix early termination in hash walk

Joel Stanley (1):
      serial: 8250: Add Nuvoton NPCM UART

Johan Hovold (1):
      USB: serial: cp210x: add ELDAT Easywave RX09 id

Kees Cook (1):
      /dev/mem: Avoid overwriting "err" in read_mem()

LEROY Christophe (2):
      crypto: talitos - don't persistently map req_ctx->hw_context and req_=
ctx->buf
      crypto: talitos - fix IPsec cipher in length

Leonard Crestez (1):
      crypto: arm,arm64 - Fix random regeneration of S_shipped

Liu Bo (1):
      Btrfs: fix unexpected cow in run_delalloc_nocow

Maciej S. Szmigiero (1):
      crypto: ccp - return an actual key size from RSA max_size callback

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Masaki Ota (1):
      Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude =
7370

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Mikulas Patocka (1):
      Fix slab name "biovec-(1<<(21-12))"

Oliver Neukum (1):
      media: usbtv: prevent double free in error case

Omar Sandoval (1):
      bitmap: fix memset optimization on big-endian systems

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Rui Miguel Silva (1):
      crypto: caam - Fix null dereference at error path


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrKMNUACgkQONu9yGCS
aT5dqBAAjAODDT+kupr81TLkbolCQdZUwd/yFue1tLdnITEuEXEXdzQzvHXRAZbY
DJM0Fz2kuvleFuPQtrTOjloFLzPDr/DAb9ozATMXmgAK8b/e0nflA4w+pHNZ/j+O
GpXhkjHlDlRqBmq31NxRHZchaU/WtC0tqy1tnS7OMfdqb9xapuie25AwWAv7AsPl
SqdK9vd10UkUTvZRk6tvCsxFmSywhcrrpKm827C5e1akvdMtxmDz9WSkYxat+Qps
Y/jPSqgL7wJ7FrJQY4q/FqgHVFVIWhMHr5XHgJ5k2VbGUI06sEM9nTHW+WfsSIn9
O6I5O5m99KKrVowPlZi2DYqERjtQ2QHxMLKCTrCjsiIC2HxM7v9XveYhZGQHVMai
50JCemyifZCIU+ayaHKVMptmLhW/QcllE8nzPyS/LLpaAXkwb8L9c3/x2uCdxnz+
kzNQZ+cvuUCuXMpD2VMJM+taHAZPhFyNxQADn87B5/sWg7EBbaihN9rSrXXxeB7r
0fi7Fhwq0QF+Xhza+Rj+94tvUntwVCDGJ2yDMU8vDp1vkeA8F+efDMdvWUoRvan1
MZolar5vcLHgdg/hJaIbcVw55oe2RMUGNIs9CJUmYBJgB4lnAv+/MXpxPyIZqn5f
Z5vmxjHUZFNBoLUNsvzq9Fk9gTpZDBMzUNg6XZdmVpNGtHFqoYM=
=hEUt
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
