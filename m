Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4191898-1519819911-2-6553438206598322806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519819910; b=C60+OmmOkSYipGybwr34JSVA/NbbDWBV14gy4mhw/fG1u87
    tSgv1kNfS7FZ2BVZnWkV8uKNHH5r2lTJgNFgepvDAnSx8/EoiqBp3/oAwdWG+2HM
    a0CZQNAunolSJ5xK7GCYs5jXxDNuuMmERXy/k/sfblnoo3qJv5Kc8bV6G3Sq05dl
    BhrPoF9raj5GFz/SIUhL9ZivRdvGf/3I1MJg8F3rB7d43mTYYquKrKpOS2nECuA0
    4i/6sCD1GpgILb/84zSdbVaABqcYz4Sq5SXzSi6E/mcbhkrNhzTEsMTxce8YJ+qJ
    n3xuMUGsdVh+ZflzmNF82ClBaMHB1lPH741F85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519819910; bh=XIMLRcy42s5TFW31mJN/xOCQXKRvS6VYrMW6Nc3lXok=; b=p
    Gmsmf082vSoaO99eKquzXWFL6KyjlmiS3kp15d0B+M2Ioa8zscjEMULyuXu/YiNf
    Dpq9qeflkCvDAENu3iLofcwP3rsgMEsc+ovjzIpRYIY7tIirG6GJCkPFXHZH2k1f
    8/RsVMTPxPQL8DZUsGEzs9lwg+7QDhduuGdZraVhxlSSVEtjtvHd/Wz6CzU29HoJ
    ycJoWww3PXMxE/G0uSiDH87wy66bfKi3VaWZotiA0ai/yxaZMl7dT5t5MeDthTTV
    mfB8sr1q9yJNR2UYkbgOitoWLtCkq1jGR4nbPqzvNV6/LjT2fh88YOnZcAcVa/VV
    vzrLTxjcpmxHCFyQLHt2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeB1MJi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:09:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeB1MJg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 07:09:36 -0500
Date: Wed, 28 Feb 2018 13:09:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.85
Message-ID: <20180228120937.GA15533@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.85 kernel.

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

 Makefile                                         |    2=20
 arch/arm64/kernel/traps.c                        |    2=20
 arch/x86/entry/entry_64.S                        |   13 ++++
 arch/x86/oprofile/nmi_int.c                      |    2=20
 arch/xtensa/mm/init.c                            |   70 ++++++++++++++++++=
++---
 crypto/asymmetric_keys/pkcs7_verify.c            |    2=20
 crypto/asymmetric_keys/public_key.c              |    4 -
 crypto/asymmetric_keys/restrict.c                |    7 +-
 drivers/android/binder.c                         |    4 -
 drivers/dax/dax.c                                |   12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   58 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |    2=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |    5 +
 drivers/gpu/drm/drm_edid.c                       |    3=20
 drivers/hid/hid-core.c                           |    3=20
 drivers/hid/hid-ids.h                            |    3=20
 drivers/iio/imu/adis_trigger.c                   |    7 +-
 drivers/iio/industrialio-buffer.c                |    2=20
 drivers/infiniband/core/umem.c                   |    2=20
 drivers/infiniband/core/uverbs_main.c            |   27 ++++++--
 drivers/irqchip/irq-gic-v3.c                     |    2=20
 drivers/media/v4l2-core/videobuf-dma-sg.c        |    5 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c       |   10 ---
 drivers/nvdimm/bus.c                             |   11 +--
 drivers/nvdimm/pfn_devs.c                        |   15 +++-
 drivers/pci/quirks.c                             |   39 +++++++-----
 drivers/scsi/ibmvscsi/ibmvfc.h                   |    2=20
 drivers/usb/core/quirks.c                        |    3=20
 drivers/usb/dwc3/gadget.c                        |    2=20
 drivers/usb/gadget/function/f_fs.c               |    6 -
 drivers/usb/host/ohci-hcd.c                      |   10 ++-
 drivers/usb/host/ohci-hub.c                      |    4 -
 drivers/usb/host/ohci-q.c                        |   17 +++--
 drivers/usb/misc/ldusb.c                         |    6 +
 drivers/usb/musb/musb_host.c                     |    8 --
 drivers/usb/renesas_usbhs/fifo.c                 |    5 +
 fs/dax.c                                         |    1=20
 include/linux/dax.h                              |    5 -
 include/linux/fs.h                               |   20 ++++++
 include/linux/kernel.h                           |    1=20
 include/linux/mm.h                               |   13 ++++
 kernel/memremap.c                                |   13 ++--
 mm/frame_vector.c                                |   12 +++
 mm/gup.c                                         |   64 ++++++++++++++++++=
+++
 mm/memory.c                                      |   40 +++++++++----
 net/ipv4/ip_sockglue.c                           |    7 --
 net/ipv6/ipv6_sockglue.c                         |   10 ---
 net/mac80211/cfg.c                               |    2=20
 48 files changed, 432 insertions(+), 131 deletions(-)

AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition bet=
ween usb_kill_urb() and finish_unlinks()

Alex Deucher (3):
      drm/amdgpu: Add dpm quirk for Jet PRO (v2)
      drm/amdgpu: add atpx quirk handling (v2)
      drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Arnd Bergmann (2):
      cfg80211: fix cfg80211_beacon_dup
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Bin Liu (1):
      Revert "usb: musb: host: don't start next rx urb if current one faile=
d"

Casey Leedom (1):
      PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Dan Williams (8):
      libnvdimm: fix integer overflow static analysis warning
      device-dax: implement ->split() to catch invalid munmap attempts
      mm: introduce get_user_pages_longterm
      v4l2: disable filesystem-dax mapping support
      IB/core: disable memory registration of filesystem-dax vmas
      libnvdimm, dax: fix 1GB-aligned namespaces vs physical misalignment
      mm: fail get_vaddr_frames() for filesystem-dax mappings
      x86/entry/64: Clear extra registers beyond syscall arguments, to redu=
ce speculation attack surface

Eric Biggers (4):
      X.509: fix BUG_ON() when hash algorithm is unsupported
      PKCS#7: fix certificate chain verification
      binder: add missing binder_unlock()
      X.509: fix NULL dereference when restricting key with unsupported_sig

Greg Kroah-Hartman (1):
      Linux 4.9.85

Jack Pham (1):
      usb: gadget: f_fs: Process all descriptors during bind

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

Jan H. Sch=F6nherr (1):
      mm: Fix devm_memremap_pages() collision handling

Jan Kara (1):
      fs/dax.c: fix inefficiency in dax_writeback_mapping_range()

Kai-Heng Feng (2):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
      drm/amdgpu: add new device to use atpx quirk

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Leon Romanovsky (1):
      RDMA/uverbs: Protect from command mask overflow

Max Filippov (1):
      xtensa: fix high memory/reserved memory collision

Michael Weiser (1):
      arm64: Disable unhandled signal log messages by default

Paolo Abeni (1):
      netfilter: drop outermost socket lock in getsockopt()

Ross Zwisler (1):
      mm: avoid spurious 'bad pmd' warning messages

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Shigeru Yoshida (1):
      ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watc=
hdog_func()

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

Thinh Nguyen (1):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqWnAAACgkQONu9yGCS
aT6FMhAAv/LD7KNYd/AKHtnk4QPUg50ficUsVF6Q1wt2gzjNh127c8EyUk53w9Hg
LrNX1av0eoXg+sYm98mM9aFwJNq0zw6/12WTUGGPcp5JIQVDTvXLJ6D5NXcniImo
0MjIS8UFNPnjl6rE0fbiFIFZMORHJPpvxuAayEN0FURUYszMp14FlfKnVNLjm9rE
AAVbB5JHp4Fv2l5VFTWGvdHFYIefmlYCoxBKRAXz0nxHEkdBfGq30Dc+D9VUR5ug
9yItvxEm4Jjd3nIE+SN7/HEky2X/fjc6KBa05FmK7X5hZDHJeHTZwNVCtE4MHhz1
keKihxMUNQ+yTJR1/cpz71g/YUVOhBhEUTzQ+AAVYhtb7tXpe86VoqJgbkY/hmmJ
fM0YWD7t3IKZha+W+vRwCThiw8mmUyoVjkPtTbjTg4lWgoFFtwesjg03JOeaEZ4j
oS9kh87A+LZi1LitomqOWo5uf4tJmZhuyUE6HBPnPAxZKFjjHZP9Vkjnv3BU7Xtb
gc9YQcUQmraP5rdAVIDfCjxOKRQJJduNYQ41slFVxOR5Os61sPjFdgqsRzxbMlFL
vKSXLJIhLzj52gGkXwaPxgjZulipQpaLSSNQLk3M9DdKNV1xG9sfdtdXWdodVI9z
YNky3fNqsXXkVCJVAM8IfyIoQYmBRH70XauGNhK1e2RsnBjMPvA=
=f2tH
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
