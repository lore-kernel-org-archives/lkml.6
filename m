Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E46C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE3F218F9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE3F218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHRLvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:51:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeHRLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:51:22 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5169B3EE;
        Sat, 18 Aug 2018 08:44:28 +0000 (UTC)
Date:   Sat, 18 Aug 2018 10:44:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.64
Message-ID: <20180818084424.GA31547@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.64 kernel.

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

 Documentation/process/changes.rst                    |   19=20
 Makefile                                             |    2=20
 arch/arm64/mm/mmu.c                                  |    4=20
 arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S |    2=20
 arch/x86/include/asm/i8259.h                         |    1=20
 arch/x86/kernel/cpu/bugs.c                           |    3=20
 arch/x86/mm/pgtable.c                                |   61 ++
 block/bfq-iosched.c                                  |   50 +-
 crypto/ablkcipher.c                                  |   57 +-
 crypto/blkcipher.c                                   |   54 +-
 crypto/skcipher.c                                    |   51 +-
 crypto/vmac.c                                        |  412 ++++++++------=
-----
 drivers/acpi/apei/ghes.c                             |   39 -
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c                 |    2=20
 drivers/firmware/qemu_fw_cfg.c                       |    3=20
 include/asm-generic/pgtable.h                        |    8=20
 include/crypto/vmac.h                                |   63 --
 include/trace/events/sched.h                         |    6=20
 lib/ioremap.c                                        |    4=20
 net/bluetooth/hidp/core.c                            |    4=20
 scripts/depmod.sh                                    |    8=20
 sound/soc/codecs/msm8916-wcd-digital.c               |    4=20
 sound/soc/intel/boards/cht_bsw_max98090_ti.c         |   45 +-
 sound/soc/sh/rcar/adg.c                              |    4=20
 24 files changed, 418 insertions(+), 488 deletions(-)

Alexander Syring (1):
      clk: sunxi-ng: Fix missing CLK_SET_RATE_PARENT in ccu-sun4i-a10.c

Chintan Pandya (1):
      ioremap: Update pgtable free interfaces with addr

Eric Biggers (7):
      crypto: x86/sha256-mb - fix digest copy in sha256_mb_mgr_get_comp_job=
_avx2()
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path
      crypto: skcipher - fix aligning block size in skcipher_copy_iv()
      crypto: skcipher - fix crash flushing dcache in error path

Greg Kroah-Hartman (1):
      Linux 4.14.64

Guenter Roeck (2):
      x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled
      x86: i8259: Add missing include file

James Morse (1):
      ACPI / APEI: Remove ghes_ioremap_area

Jean-Fran=E7ois T=EAtu (1):
      ASoC: msm8916-wcd-digital: fix RX2 MIX1 and RX3 MIX1

Kuninori Morimoto (1):
      ASoC: rsnd: fix ADG flags

Marc-Andr=E9 Lureau (1):
      fw_cfg: fix driver remove

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Paolo Valente (1):
      block, bfq: fix wrong init of saved start time for weight raising

Randy Dunlap (1):
      kbuild: verify that $DEPMOD is installed

Thierry Escande (1):
      ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

Thomas Gleixner (1):
      sched/debug: Fix task state recording/printout

Toshi Kani (2):
      x86/mm: Disable ioremap free page handling on x86-PAE
      x86/mm: Add TLB purge to free pmd/pte page interfaces


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt33GgACgkQONu9yGCS
aT4J6w/9FNYpnLu/0/obxmzGPeaIejy6P8dkF/uhV46FuD+PqNYRlP850W7IGgvo
fPTWwta49j9NlEp/zZN9gYsw9txbfOoTzvyK57D+G28qEynqoNgAj1L0FF1t0d7X
j35xw7MNKNajH3SkVyIqcJDP4ZcgwOM3J27wuEUilxcA536mF6Wd0IxOJIhYCjh5
rqppIKrmUGvXrHf+g6QndeBsfy+5+yENGgT988hOjR/Wzwh1tSgnvwIKDGvzdC0K
ql4NdnI5SW1fHAXlYMA/x4lGF4xQYSJmYYejD+IdR8T8FF2PjC5PWNqog0Uxa5Wy
9VriCN9YP2oEYzsLokWfQH3NKft9PsUbDnn7xmAlpi+pUmK6xiueI6yrCOSIqIQo
FxOQvBhbYmdQWgcXkzt0XDYb7STljh0X6oihoXAHo5OsrekPLFZsq397lRR76LzN
XohXdx5D8Fv0437dbpC6W2ae7q4vqGS43rTY8aydQ1vvHITVLiYJ9sIW0tzuO5Yk
qpmuELQYp7oRbCfKRp0uRzDnxxoCscXhfbnDnW6VoFymq5LbDuEkHK7H8vflBzXn
F6mq7OF+rJCO999D43xfb+0TlOUbV8uyyNFtfd9il+rRi/ly52mfr4NcHJS1El/4
1+c5CeyTRwjcFcTSUoCnwTW8oBicNUa/HmAvSRxwn9GxIc2Yois=
=+X2j
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
