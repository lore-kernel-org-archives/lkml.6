Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD8A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPsIy7MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD8A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK1GUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeK1GUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:20:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9E020663;
        Tue, 27 Nov 2018 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543346256;
        bh=2L3ngjp9OIRfC1joeHlgFMk38uI5DZjL7f+N7Dq45Rs=;
        h=Date:From:To:Cc:Subject:From;
        b=DPsIy7MUCCbDw9xc1gqKzLD+06jKV3wXUyDglg402+nb/TqokD4SSbUR7vpo5pToK
         UKEsHEqm4I7flGTwRXAh4w2sCeGAHlsGtYJKGf3cnjwLNU2GFlG2yhUoSyvXrwJJ3f
         VTU4rbGYBIgK3lZb/a7vrR8F7xsNAcNRQwFwGwzo=
Date:   Tue, 27 Nov 2018 20:17:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.127
Message-ID: <20181127191734.GA1312@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.127 kernel.

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

 Makefile                             |    2 -
 arch/s390/kernel/vdso32/Makefile     |    6 ++--
 arch/s390/kernel/vdso64/Makefile     |    6 ++--
 arch/um/os-Linux/skas/process.c      |    5 ++++
 drivers/acpi/acpi_platform.c         |    1=20
 drivers/block/zram/zram_drv.c        |   18 ++++----------
 drivers/bluetooth/Kconfig            |    1=20
 drivers/clk/samsung/clk-exynos5420.c |    1=20
 drivers/gpu/drm/i915/i915_gem.c      |    2 -
 drivers/hid/uhid.c                   |   13 ++++++++++
 drivers/media/v4l2-core/v4l2-event.c |   43 +++++++++++++++++++-----------=
-----
 drivers/misc/atmel-ssc.c             |    2 -
 drivers/uio/uio.c                    |    7 ++++-
 drivers/usb/class/cdc-acm.c          |    3 ++
 drivers/usb/core/quirks.c            |    8 ++++++
 drivers/usb/misc/appledisplay.c      |    1=20
 fs/exofs/super.c                     |    5 +++-
 fs/hfs/brec.c                        |    4 +++
 fs/hfsplus/brec.c                    |    4 +++
 fs/reiserfs/xattr.c                  |    7 +++++
 include/linux/uaccess.h              |    3 ++
 lib/raid6/test/Makefile              |    4 +--
 net/core/dev.c                       |    4 +++
 net/sunrpc/xdr.c                     |    2 -
 24 files changed, 105 insertions(+), 47 deletions(-)

Al Viro (1):
      new helper: uaccess_kernel()

Chengguang Xu (1):
      fs/exofs: fix potential memory leak in mount option parsing

Dan Carpenter (1):
      uio: Fix an Oops on load

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Eric Biggers (1):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Eric Dumazet (1):
      net-gro: reset skb->pkt_type in napi_reuse_skb()

Ernesto A. Fern=E1ndez (2):
      hfs: prevent btree data loss on root split
      hfsplus: prevent btree data loss on root split

Greg Kroah-Hartman (2):
      Revert "Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV"
      Linux 3.18.127

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

Jann Horn (1):
      reiserfs: propagate errors from fill_with_dentries() properly

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Kai-Heng Feng (1):
      USB: quirks: Add no-lpm quirk for Raydium touchscreens

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Marek Szyprowski (1):
      clk: samsung: exynos5420: Enable PERIS clocks for suspend

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Minchan Kim (1):
      zram: close udev startup race condition as default groups

Nathan Chancellor (1):
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Richard Weinberger (1):
      um: Give start_idle_thread() a return code

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" oper=
ation

Sasha Levin (1):
      Revert "Revert "drm/i915: Fix mutex->owner inspection race under DEBU=
G_MUTEXES""

Vasily Gorbik (1):
      s390/vdso: add missing FORCE to build targets

YueHaibing (1):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv9mEwACgkQONu9yGCS
aT4bBQ/9E+5Er/I+0V6kBpwqtUrl6tiicV4Yh0cXY8zsfhScRiGO9A5o4e/DKYCd
+7mSjh1JjQMZMrV7uHSYa4ir2ShI7ANXGZUQQL1JvuG4GutAvPENLUUyfANDu5KU
MFj2rZjcTdS1/knZQhkbNBd957s/ocLtwJOuJyf7VkrsnSxo1NB9/for23effoJ3
iwmEoQY4S7xvb+w50fosPuppjwtOQX+bsHZ21pLPlJM9W5+b+CZmwpb4YIf706SM
fVwbd0rzdRzAIm/unm4xCZHZh8WPp0MnnWN4OHvxbJirLzZykgWhXmC6nXXgSWyX
TVd14Kktkc/VAIniTnjfrlHrVyaCNOquiPzzUgm0Ppkj8DTFX3ZtadOVDw/UQyBT
1NCAstFEdW+oQTBDQkVpY74DxsxZVPNsun2jMjgNIZWoLbMrUHqsAlw2ycn/4ZMu
eFkUOg1qhM96znUtrS62qyaA44r81/6G6H2SMzb5Nph3F2X95XrDT53V/Z160niL
usqaYdxXPz0t0YFJac+bN+dG9jwtINvJQ9f7pRS3qLtWhVG03Mi56JwsnmiIWiDF
hTrafRcnetJUYs5RoTAkeeVkQ8tVCZSTOH7y+dWmP15OZQ63bR/5arLdcGB7WW6e
4fM2BZLumOjYHLZiNGVchVmZuVXhpnd4xUyfdn5ABCMaF2KEns0=
=XNX1
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
