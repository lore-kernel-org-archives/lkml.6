Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D52C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E09217A6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E09217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHRLuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:50:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeHRLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:50:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A5F13EE;
        Sat, 18 Aug 2018 08:43:28 +0000 (UTC)
Date:   Sat, 18 Aug 2018 10:43:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.149
Message-ID: <20180818084325.GA31385@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.149 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/Changes                        |   17 -
 Makefile                                     |    5=20
 arch/arm64/mm/mmu.c                          |    4=20
 arch/x86/mm/pgtable.c                        |   61 +++
 crypto/ablkcipher.c                          |   57 +--
 crypto/blkcipher.c                           |   54 +--
 crypto/vmac.c                                |  412 ++++++++++++----------=
-----
 drivers/i2c/busses/i2c-ismt.c                |    2=20
 include/asm-generic/pgtable.h                |    8=20
 include/crypto/vmac.h                        |   63 ----
 lib/ioremap.c                                |    4=20
 net/bluetooth/hidp/core.c                    |    4=20
 net/ipv4/tcp_input.c                         |    1=20
 scripts/Makefile.kasan                       |    3=20
 scripts/Makefile.lib                         |    2=20
 scripts/depmod.sh                            |    8=20
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |   45 ++
 17 files changed, 353 insertions(+), 397 deletions(-)

Andrey Konovalov (1):
      kasan: don't emit builtin calls when sanitization is off

Chintan Pandya (1):
      ioremap: Update pgtable free interfaces with addr

Eric Biggers (4):
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path

Greg Kroah-Hartman (1):
      Linux 4.4.149

Liwei Song (1):
      i2c: ismt: fix wrong device address when unmap the data buffer

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Randy Dunlap (1):
      kbuild: verify that $DEPMOD is installed

Takashi Iwai (1):
      tcp: Fix missing range_truesize enlargement in the backport

Thierry Escande (1):
      ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

Toshi Kani (2):
      x86/mm: Disable ioremap free page handling on x86-PAE
      x86/mm: Add TLB purge to free pmd/pte page interfaces


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt33CwACgkQONu9yGCS
aT5whxAA1cliK0gyIhwf5rTHmYBBjjBeHhOwKMKgSh0dYOSw/5z7DwqVayebSgHO
euEvRJvkdKCdcyMwxA4G2smOmO2UP+GYgDkf5UlCoP+0KLXy6o4E16lTwoL+M9Nl
cUfnAICwES/vpTpwpQE1VHl/NJGnw+OhYhVfCY3QL3JqM1o0Ki5zKsXn8FMara2s
9lME7Aa5/eGCpRdBgSWsmBDE4c2KPvk7m2Qr50KPEvTA8t8Hsa5OlUzKN4v7t0CA
sHaEr9DnlyJ4k8+UsnE+HfCYJvrRwORmWseT2G5G+kcSwlLpd6gbdChjn94ITgoR
UkPsvLSMzzHu2RxXIogfLTya/CIypHS2A0bw0q2OMBTz6EOhBIW5v9iQXwfxuwGM
7oAqNA3Y14oxybAe8HsFT7R/8BImlgPKG+Y8Vwx6m9XxziaNYvMEmgHFfI9C68z6
Y5CYWfxenxC3VB3tuyoKrvnDC2MsB7oOvqSzFBWLlwZd6iEoWMIthcjd4uq7o+18
U0b35pqXjybRwnffIjhYFifUoRfWe0cI+ilyHcavNXH1SFsr9C7rYO5tyPMjeEpn
Diz0KBRIoY9vVku5Kf7gYz9MX9uw1DFPI5D4vDCfuNqKB9196kF+c5MIAoKecsQh
l//ojLcZKbFVZCWeC3k9V58M9H8eba0BV8xF4LQZvPC1SJ22a7M=
=Ihu8
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
