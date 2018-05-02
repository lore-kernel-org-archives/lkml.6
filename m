Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1007980-1525279238-2-6557728864840057598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525279238; b=O3kJmbBTZPcSrfj8fTKfV3AVK1QWNxhqTo9v2tYWiKhtNsinsT
    P06k35s1fx0PaWEfXOutChOD5tiveVdTx6gUQga1/mlAaAVUmZu8GmA7snUVPiKQ
    LaIOLzuuVbqH9zNH6rl0UM53JRRtjPCdUxPI2FRfOBVxHEqM2zNJEIcaU1m362i5
    cO4rldICYuHAxXr2bsCEjqOm2uicv3jQRFArnsjpsj9JaN3prJSAmIgGQb2/U7kO
    ltrdv4l4v8C9HoIzzCbwAEsYCpVjb1qu+iAmoAjR4ibedQwHSQ1EWpbk3CmuKrMk
    rINrUQqpAr/WaMIej9HkDL97XTkgoqcBnthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525279238;
    bh=DIfI6eIe6TK3tb20ACRTTtSLzp1EgnflplZcmlGFDrA=; b=E+N3wzwqUrPJ
    3bH+YB1nou+UmjdQoKQ8fQyLXLlGQ3fYEESTYPoWCnr2bxwLZ8HHHMd1HzNKKje1
    1ZYH+JER44chzOAhSgb30lBsgQXFZ1xFnvQBjtmXUn19AF32vFTWkS28DRp7CtZh
    wDXCfcw1Ft58QtqOy9wQSxlcVXOoFFtKXySDpCp9xJ1eK6Yxd9FRuoGzpeFCQWgC
    aZekg3NNBf2+ArOr7UhxBkuuii2EzKergstyP5Xhh3ngi9j+1cE+dFMIfKjYs14f
    0fUuBgIH2iQzIJK0TV6tDGsnLUd08+/kabdADxNKiooN3H0oUEyHvnyWmGRc5/T8
    6a20nQLN1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=I51tXcS+ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=I51tXcS+ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHirBtLiLQOvAiV1Nf2VWo5EKRdYrZSehvXZ2SCouoidVKt14O3GXsm0hlX9yq6x+pS8CxqK3VcIYs5f+Yvi4fFxX7ktRRJDBznaQD0HI8XP9S7lhVFv
    j8uKkvfQPXZAWfAmCY4+cCA8r4FrfZlqe02kFqpm2QDLYOpsVzyL6vv2qjyqJ1HaBrGxcl+R5NgV65/QLLXu564h4NbtpK3SQZAHbpU/y1rKcwjEJpmzDmH7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=OqteGePwSNspY_fPzfUA:9 a=CjuIK1q_8ugA:10 a=FwyTtEEc952rmi_b6HUA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEBQkW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbeEBQj4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 12:39:56 -0400
Date: Wed, 2 May 2018 09:39:45 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.108
Message-ID: <20180502163945.GA20895@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.108 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                            |    2 -
 drivers/char/virtio_console.c       |   49 +++++++++++++++++--------------=
-----
 drivers/mtd/chips/cfi_cmdset_0001.c |   33 ++++++++++++++++++++----
 drivers/mtd/chips/cfi_cmdset_0002.c |    9 ++++--
 drivers/scsi/sd.c                   |    2 +
 drivers/tty/n_gsm.c                 |   23 ++++++++++++++++
 drivers/tty/tty_ldisc.c             |   11 +++-----
 drivers/usb/core/hcd.c              |    1=20
 drivers/usb/core/hub.c              |   10 ++++++-
 drivers/usb/core/quirks.c           |    3 ++
 drivers/usb/serial/cp210x.c         |    1=20
 drivers/usb/serial/ftdi_sio.c       |    3 +-
 drivers/usb/usbip/stub_main.c       |    5 +++
 drivers/usb/usbip/usbip_common.h    |    2 -
 fs/ext4/balloc.c                    |   17 +++++++++++-
 fs/ext4/ialloc.c                    |    8 +++++
 fs/jbd2/transaction.c               |    1=20
 include/linux/mtd/flashchip.h       |    1=20
 include/linux/virtio.h              |    3 ++
 lib/kobject.c                       |   12 +++-----
 net/ceph/messenger.c                |    7 +++++
 sound/core/pcm_native.c             |    1=20
 sound/core/seq/oss/seq_oss_synth.c  |   12 +++++---
 sound/soc/fsl/fsl_esai.c            |    7 +++++
 sound/usb/mixer_maps.c              |    3 ++
 tools/perf/tests/code-reading.c     |   20 --------------
 26 files changed, 169 insertions(+), 77 deletions(-)

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Dmitry Vyukov (1):
      kobject: don't use WARN for registration failures

Greg Kroah-Hartman (2):
      Revert "perf tests: Decompress kernel module before objdump"
      Linux 3.18.108

Ilya Dryomov (1):
      libceph: validate con->state at the top of try_write()

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Lukas Czerner (1):
      ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Michael S. Tsirkin (2):
      virtio: add ability to iterate over vqs
      virtio_console: free buffers after reset

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Shuah Khan (2):
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: vhci_hcd: Fix usb device and sockfd leaks

Takashi Iwai (2):
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device

Tetsuo Handa (1):
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Theodore Ts'o (2):
      ext4: set h_journal if there is a failure starting a reserved handle
      ext4: add validity checks for bitmap block numbers

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrp6dEACgkQONu9yGCS
aT5sGQ//d6RKwRGsm5BWCglLomj65ZXXiYki4UvYY1yw1aiTMR5MSmXe8u0bLJGo
7Ye7j092BMvCw+4MMCkL2xL99/pXU496Cw0AJnOfZo80UDec4rXDBfHss2ZbOYkh
WWwV/fYS7POuE4mIy/M0q5DuT3JZ/bfAipNl2N3GDWb3O1mvxterdo3YnryXTp54
w0N67S1KMvZUb4zxUFMmqM0/suKv/zvqbnrCE1TP/CirgVoIAp34OAo+B93RmwvF
CKVNQwzWSzgHRRkcrdGoiPa1hpqnyc8VhM1ORTIg2t0X+AT/VGdRMfxobvrzBlP9
96eplKCLrCTnwPDSuD+nmtqKiCWD9rMxNTlWbb8uPW3hlEAbWGphofqJtO9sOO5r
Xab3njSeGmJv9Vo19b69oXHHW+ilX6QUCEBfAN34aDrEN1RA3T6rWz2R1SZXKsfi
kgTHhaFDGhR121javXKWJOVWi9avBQAyms2+FdVqd+D3Zr6zdIWPWXLW6HFzBh5V
kHtcApjx+V3JQuiKk6Tt8uNvDSQZofyQLZQFXQ89ZP4EhRrh6GD8hG8nHbdCEqin
vhROs6KiaztHa0FURP0ayGcJs3ir41z+DYz8jxtfTsvnxTgg9PTYuAcrQ2MnrhYq
j89q1gaEeCtSVftFFs4IwPM6O4+/vDc2cNi8iq7qaBDsDAAgOjY=
=FEnr
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
