Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91EDC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BAE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725285;
	bh=VEaLXnem8vi+0muEJ5D96zBV5gIm1vLaygwY1Yq/O/U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nfZa6dtpXkfUv6y6JUX7yrdpc2qSv4kdPr7f/Ar+Zi7CE3A/viISpQyB4SUNhBMOO
	 luirxOjHAaajLZDmiAnQN18Vw6WFVx5+393IBhN02CGrkiE48wwptxV1Y3PygnOv8v
	 v0DdsY/9Vt/MAzi+WBkImCL2v6d8YeO3EuR2i4VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfAQLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbfAQLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:41:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F50520855;
        Thu, 17 Jan 2019 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725279;
        bh=VEaLXnem8vi+0muEJ5D96zBV5gIm1vLaygwY1Yq/O/U=;
        h=Date:From:To:Cc:Subject:From;
        b=zbMlSoFz46iTDuUuM/j/3Uhr7xYaJvE/IQrKhnIsqBEanxMw4gAuyHu6hBnGxaSud
         fH6czWxpE2yFz+jKhSn8KS6zgTEdjlnQb8TS6GAxqQCSg4yr5400SmFGTaErbR1esr
         nqw/z2jIb1aUXtjZqq3DKK3v1Y+i0N6KOQMvR7/M=
Date:   Thu, 17 Jan 2019 12:41:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.151
Message-ID: <20190117114117.GA2003@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.151 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 +-
 drivers/acpi/power.c               |   22 ++++++++++++++++++++++
 drivers/block/rbd.c                |    9 ++++-----
 drivers/i2c/i2c-dev.c              |    6 ++++++
 drivers/usb/class/cdc-acm.c        |    7 +++++++
 drivers/usb/core/quirks.c          |    3 ++-
 drivers/usb/storage/scsiglue.c     |    8 ++++++--
 drivers/usb/storage/unusual_devs.h |   12 ++++++++++++
 fs/cifs/file.c                     |    8 ++++----
 fs/cifs/smb2file.c                 |    4 ++--
 fs/cifs/transport.c                |    2 +-
 fs/ext4/inline.c                   |    6 +++---
 fs/ext4/inode.c                    |    3 ++-
 fs/ext4/super.c                    |    2 +-
 include/linux/sunrpc/svc.h         |    5 ++++-
 mm/slab.c                          |    6 ++++--
 mm/util.c                          |    2 +-
 net/sunrpc/svc.c                   |    9 ++++++---
 net/sunrpc/svc_xprt.c              |    5 +++--
 net/sunrpc/svcsock.c               |    2 +-
 sound/pci/hda/patch_realtek.c      |   16 +++++++++++++++-
 21 files changed, 107 insertions(+), 32 deletions(-)

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of the alien cache failed

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

Greg Kroah-Hartman (1):
      Linux 4.9.151

Hans de Goede (1):
      ACPI: power: Skip duplicate power resource references in _PRx

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specified
      USB: storage: add quirk for SMI SM3350

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Jan Stancek (1):
      mm: page_mapped: don't assume compound page is huge or THP

Kailang Yang (1):
      ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225

Pavel Shilovsky (1):
      CIFS: Do not hide EINTR after sending network packets

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array

Theodore Ts'o (3):
      ext4: make sure enough credits are reserved for dioread_nolock writes
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
      ext4: avoid kernel warning when writing the superblock to a dead device

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxAad0ACgkQONu9yGCS
aT7fTw/8Cwk12kVXhoUGcVf7J6CULS/MV/H1WogS/X199qFLiPRwPVjL/i9Qh5SJ
Cq2kSjBL5qtnVJNFfBPftLNWpqde2Tsl7OVDnWUtrvtKDo/muHjxWP8kwvYSytMT
Q3TTlvAmcxU98vuAuqcFl6mBuJmtIkaanogAVXgppver2d2dUADuhB1/BLtzaQsY
dH4Ke+JxoHI0GhhQjLFx4+ZdKX6/MCRpXjvmaGrfJMUhz/jv3vBOQV5Y7A1BB3MV
uJVRmbnn8pGSqNTcXXivFS6PPkZeXVEyGDqaH9DzUGSWQVCxCtto0PJrzY30tPUG
3sEla15J6JLMUfZ68hjQBwyZE426Tsf/HJmyM6/UplM7d0SzjM/VQ1vpqcZ//Rz3
GfeLhbECYKWLk1fB78Ouufj1wmDnEpwZ6ABSY6D7igWZkIQVG/2qXImICShHWKRW
4bHxKO0UocG59Ecb1rlubfJMwwT6VX8jdi3St5KxsruKzjucbsqOlSPfMi9SDQsy
K4bLtRsYLnIfEnSjVSgSe5pfX9Va+nk9qxihdVpHongDOaRTAuecRa2RZWQNOKuf
UagOhLQKaFnV6te3Eu6trkHE437K707raVXHmG/m2Q5O+++4I4U+vnS7FAlHxwSU
jLZ40TxQJWcRYNQ3SY9SzbT7fPcBWvjhyEWVi1BKRXarVRENJ5I=
=J76a
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
