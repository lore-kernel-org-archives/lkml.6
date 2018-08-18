Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C3B217A6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C3B217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHRLtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:49:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeHRLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:49:54 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 098FE3EE;
        Sat, 18 Aug 2018 08:43:00 +0000 (UTC)
Date:   Sat, 18 Aug 2018 10:42:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.119
Message-ID: <20180818084255.GA31251@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.119 kernel.

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

 Documentation/Changes          |   17 -
 Makefile                       |    2=20
 arch/arm/boot/dts/imx6sx.dtsi  |    2=20
 arch/x86/kernel/kprobes/core.c |    4=20
 crypto/ablkcipher.c            |   57 ++---
 crypto/blkcipher.c             |   54 ++---
 crypto/vmac.c                  |  412 ++++++++++++++++++------------------=
-----
 drivers/i2c/busses/i2c-ismt.c  |    2=20
 drivers/net/xen-netfront.c     |    8=20
 fs/dcache.c                    |    6=20
 fs/namespace.c                 |   28 ++
 include/crypto/vmac.h          |   63 ------
 mm/slub.c                      |    6=20
 net/bluetooth/hidp/core.c      |    4=20
 scripts/depmod.sh              |    8=20
 sound/core/info.c              |    4=20
 16 files changed, 296 insertions(+), 381 deletions(-)

Al Viro (3):
      root dentries need RCU-delayed freeing
      fix mntput/mntput race
      fix __legitimize_mnt()/mntput() race

Andrey Ryabinin (1):
      mm: slub: fix format mismatches in slab_err() callers

Eric Biggers (4):
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path

Erick Reyes (1):
      ALSA: info: Check for integer overflow in snd_info_entry_write()

Greg Kroah-Hartman (1):
      Linux 3.18.119

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()

Liwei Song (1):
      i2c: ismt: fix wrong device address when unmap the data buffer

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Masami Hiramatsu (1):
      kprobes/x86: Fix %p uses in error messages

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Randy Dunlap (1):
      kbuild: verify that $DEPMOD is installed


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt33AwACgkQONu9yGCS
aT4Kuw/+Pvq9xI8ZpQgDBQiGQozqHdsjvwBCQ1zX5FCEWkYHyVprQvuW2FZ5xNZQ
y2+6S0PWiEtNCsqAHWuO3qtaey59h4UoWKEdQyxWlfwSdzg+TL5OYk+pMdRnCbHA
e1NQ94zs5cvG4yPtcNeSOgVuWILQhQz0/v0bQVeB9XJa4lGarPbDP05dSo+ZVElt
kbumFrSnL8TEb6gfJh6UolHPlxjt2+UOZOGD9g0ryz65YSDs6VKrq1gOgpZS77m0
yCmxYI/YJDX3KKsn6l+0CbsF07QZxPpBINMXo/HJCX5taPSTpMcpy5ScYL/dB9cp
xl2Ig1ymOGZVMwKS8JyqfN/MGWNnzqX6YVgUNk95svauiqu0QjABQrcTV9NQaEtM
Z+CX9NLCiqNFn/yobMRmaeLCo6hXye3De9vxkef7cLFMb9TC+tCw/VIv72xtTBi5
BvKpy+JYqqFH3tMqfFkhKXrpY+vmJMPDkPDWfz6xSgeIwO5N0uQ1P8YqPXcgeBfI
6n+w1Nf0Fepz1RPzNujw4iAkF0+eeMrOPbsV8313LRz+i8nfzy+07ORDLIj9nJ87
i5aksUY2w9Ly3101jZDnAFlAB5uhm8fp3bYu6CEuHMsmXVDukP0/x0VbCUvFZd/6
Ep8frd7+jGZyO/1ZnI4B1dNHZdozZ/uV2ycHgf1yW/nBC34PMXI=
=bSsH
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
