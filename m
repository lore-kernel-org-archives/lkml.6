Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D2217A6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D2217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeHRLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:50:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeHRLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:50:52 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3770F3EE;
        Sat, 18 Aug 2018 08:43:58 +0000 (UTC)
Date:   Sat, 18 Aug 2018 10:43:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.121
Message-ID: <20180818084353.GA31485@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.121 kernel.

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

 Documentation/Changes                                |   19=20
 Makefile                                             |    5=20
 arch/arm64/mm/mmu.c                                  |    4=20
 arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S |    2=20
 arch/x86/include/asm/i8259.h                         |    1=20
 arch/x86/kernel/cpu/bugs.c                           |    3=20
 arch/x86/mm/pgtable.c                                |   61 ++
 crypto/ablkcipher.c                                  |   57 +-
 crypto/blkcipher.c                                   |   54 +-
 crypto/vmac.c                                        |  412 ++++++++------=
-----
 drivers/i2c/busses/i2c-ismt.c                        |    2=20
 include/asm-generic/pgtable.h                        |    8=20
 include/crypto/vmac.h                                |   63 --
 lib/ioremap.c                                        |    4=20
 net/bluetooth/hidp/core.c                            |    4=20
 scripts/Makefile.kasan                               |    3=20
 scripts/Makefile.lib                                 |    2=20
 scripts/depmod.sh                                    |    8=20
 sound/soc/intel/boards/cht_bsw_max98090_ti.c         |   45 +-
 19 files changed, 356 insertions(+), 401 deletions(-)

Andrey Konovalov (1):
      kasan: don't emit builtin calls when sanitization is off

Chintan Pandya (1):
      ioremap: Update pgtable free interfaces with addr

Eric Biggers (5):
      crypto: x86/sha256-mb - fix digest copy in sha256_mb_mgr_get_comp_job=
_avx2()
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path

Greg Kroah-Hartman (1):
      Linux 4.9.121

Guenter Roeck (2):
      x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled
      x86: i8259: Add missing include file

Liwei Song (1):
      i2c: ismt: fix wrong device address when unmap the data buffer

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Randy Dunlap (1):
      kbuild: verify that $DEPMOD is installed

Thierry Escande (1):
      ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

Toshi Kani (2):
      x86/mm: Disable ioremap free page handling on x86-PAE
      x86/mm: Add TLB purge to free pmd/pte page interfaces


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt33EkACgkQONu9yGCS
aT5UYxAAlCQgnZ0WEhzUoUGivXvwtGZEGoZyaAjZZL5itCoVvN4hnzqrnmL6Z2s2
A74inpIDoLuY1lCWIFdUMhfyS8IiHaUKNIyvN86j5igN4M1B5KWAz6+OxZMMDqZk
DYdxkHRtd0yWIz7LnkMhGa7q+gJ52UYtp5dqHMIXRnysoSsK+JWHFcnrTALY8ICj
moFGl6JBpdbIMvlM1vx9L+SORKvAXv2A5G9E1jhS2rgVyluDKuTngLLWuAAn4ikh
v9qK+IvHvuP1sBMREAce5h6re3W5gV5MdRJWfYOleSHkOzwBn1gNj/vrYuFj1roY
dwwNK4Fh975rhPq32bkm8sQfUP4kv5CkqSnB3wPKLsU+bcNyM8uHlnbpvoD3MVz0
MtR9f2jUL3pBREmkopdGFO/Ls3G39ssXvt3/at2Uv4yljMa1q2xAPZRjudNUToCm
e2DWOXVS1qZ8DDgUImiebdhfH9hZH+8sI7rxD8m4kwfR2jrns1LBjFB/0jJZWpN+
uVJTwpv1o3kazxZaxuDwPTx3Kwy9sPWxrfIzQ+ZlpFsgLiXLumIzcB+zjp8Iy5jk
VuKz2p9k95g1OvDiykYWIil5BcEr5XCnBk8j1uGKenM6GsQ9wFpyEvmQQbPESlv+
doPR1YsoTPdPdGrEVky6tsJIvApsbGh16o25egKBm7koNJVrT2k=
=3Jsk
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
