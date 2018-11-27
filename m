Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0DD20663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytu6BEta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0DD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeK1GUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbeK1GUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:20:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362362145D;
        Tue, 27 Nov 2018 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543346272;
        bh=WxUPmUixtCOnow9DsAK9T4gzkxlsgM/2VBrMaxcwrBA=;
        h=Date:From:To:Cc:Subject:From;
        b=ytu6BEtaKMktgPHz+QDxzAkOQifxPmWRXYckfIcq3v9GRnlKa2UizEIrRxKzjILi4
         2gknv8tcL+iEYrJg/aV53nijpf5qn/hyYGi60/zezEScYN1vqzb1puLIIS8riiP/dV
         j1LKRauzG5dr+D4nPmBDwyY6mxFAehWO09l5DdPg=
Date:   Tue, 27 Nov 2018 20:17:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.165
Message-ID: <20181127191750.GA1637@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.165 kernel.

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

 .gitignore                                     |    1=20
 Kbuild                                         |   25 --------------
 Makefile                                       |   39 +++++++++++++++-----=
--
 arch/arm64/Makefile                            |    4 ++
 arch/arm64/crypto/sha1-ce-core.S               |    6 ++-
 arch/arm64/crypto/sha1-ce-glue.c               |   11 +-----
 arch/arm64/crypto/sha2-ce-core.S               |    6 ++-
 arch/arm64/crypto/sha2-ce-glue.c               |   13 ++-----
 arch/arm64/include/asm/percpu.h                |    3 +
 arch/ia64/kernel/Makefile                      |   26 +--------------
 arch/s390/kernel/vdso32/Makefile               |    6 +--
 arch/s390/kernel/vdso64/Makefile               |    6 +--
 arch/s390/numa/numa.c                          |    1=20
 arch/um/os-Linux/skas/process.c                |    5 ++
 arch/x86/Makefile                              |   39 ++++++++++++++++----=
--
 arch/x86/boot/compressed/aslr.c                |    3 +
 arch/x86/boot/string.c                         |    9 +++++
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S        |    7 +---
 arch/x86/include/asm/asm.h                     |    1=20
 drivers/acpi/acpi_platform.c                   |    1=20
 drivers/block/zram/zram_drv.c                  |   26 +++------------
 drivers/bluetooth/Kconfig                      |    1=20
 drivers/clk/samsung/clk-exynos5420.c           |    1=20
 drivers/firmware/efi/libstub/Makefile          |    2 -
 drivers/firmware/efi/libstub/arm64-stub.c      |   10 +++++
 drivers/hid/uhid.c                             |   13 +++++++
 drivers/hwmon/ibmpowernv.c                     |    7 +---
 drivers/media/v4l2-core/v4l2-event.c           |   43 +++++++++++++-------=
-----
 drivers/media/v4l2-core/videobuf2-core.c       |    9 +----
 drivers/misc/atmel-ssc.c                       |    2 -
 drivers/misc/sgi-gru/grukdump.c                |    4 ++
 drivers/net/ethernet/broadcom/tg3.c            |   18 +++++++++-
 drivers/platform/x86/acerhdf.c                 |    1=20
 drivers/uio/uio.c                              |    7 ++--
 drivers/usb/class/cdc-acm.c                    |    3 +
 drivers/usb/core/quirks.c                      |    8 ++++
 drivers/usb/host/xhci-hub.c                    |    2 -
 drivers/usb/misc/appledisplay.c                |    1=20
 fs/btrfs/disk-io.c                             |   19 ++++++++---
 fs/exofs/super.c                               |    5 ++
 fs/gfs2/rgrp.c                                 |    3 +
 fs/hfs/brec.c                                  |    4 ++
 fs/hfsplus/brec.c                              |    4 ++
 fs/reiserfs/xattr.c                            |    7 ++++
 include/linux/kbuild.h                         |    6 +--
 include/linux/module.h                         |    4 +-
 include/linux/netfilter/ipset/ip_set_comment.h |    4 +-
 include/linux/uaccess.h                        |    3 +
 lib/raid6/test/Makefile                        |    4 +-
 net/core/dev.c                                 |    4 ++
 net/core/flow_dissector.c                      |    4 +-
 net/ipv4/ip_tunnel_core.c                      |    2 -
 net/ipv6/route.c                               |    8 +++-
 net/netfilter/ipset/ip_set_hash_netportnet.c   |    8 ++--
 net/netfilter/xt_IDLETIMER.c                   |   20 +++++++++++
 net/sunrpc/xdr.c                               |    2 -
 scripts/Kbuild.include                         |   18 ++++++----
 scripts/Makefile.build                         |    8 ++++
 scripts/Makefile.extrawarn                     |    1=20
 scripts/Makefile.lib                           |   31 ++++++++++++++++++
 scripts/mod/Makefile                           |   28 +---------------
 61 files changed, 348 insertions(+), 219 deletions(-)

Al Viro (1):
      new helper: uaccess_kernel()

Andreas Gruenbacher (1):
      gfs2: Put bitmap buffers in put_super

Ard Biesheuvel (3):
      crypto: arm64/sha - avoid non-standard inline asm tricks
      efi/libstub/arm64: Force 'hidden' visibility for section markers
      efi/libstub/arm64: Set -fpie when building the EFI stub

Arnd Bergmann (1):
      modules: mark __inittest/__exittest as __maybe_unused

Behan Webster (2):
      kbuild: Add better clang cross build support
      kbuild: use -Oz instead of -Os when using clang

Chengguang Xu (1):
      fs/exofs: fix potential memory leak in mount option parsing

Chris Fries (1):
      kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Dan Carpenter (1):
      uio: Fix an Oops on load

David Ahern (1):
      ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

David Lin (1):
      kbuild: clang: fix build failures with sparse check

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Eric Biggers (1):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Eric Dumazet (1):
      net-gro: reset skb->pkt_type in napi_reuse_skb()

Eric Westbrook (1):
      netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Ernesto A. Fern=C3=A1ndez (2):
      hfs: prevent btree data loss on root split
      hfsplus: prevent btree data loss on root split

Geert Uytterhoeven (1):
      hwmon: (ibmpowernv) Remove bogus __init annotations

Greg Kroah-Hartman (2):
      Revert "Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV"
      Linux 4.4.165

Gustavo A. R. Silva (1):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Hans Verkuil (1):
      Revert "media: videobuf2-core: don't call memop 'finish' when queuein=
g"

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

Jann Horn (1):
      reiserfs: propagate errors from fill_with_dentries() properly

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Jeroen Hofstee (1):
      kbuild: fix asm-offset generation to work with clang

Jozsef Kadlecsik (1):
      netfilter: ipset: Correct rcu_dereference() call in ip_set_put_commen=
t()

Justin M. Forbes (1):
      s390/mm: Fix ERROR: "__node_distance" undefined!

Kai-Heng Feng (1):
      USB: quirks: Add no-lpm quirk for Raydium touchscreens

Lu Fengqi (1):
      btrfs: fix pinned underflow after transaction aborted

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Marek Szyprowski (1):
      clk: samsung: exynos5420: Enable PERIS clocks for suspend

Mark Charlebois (1):
      kbuild, LLVMLinux: Add -Werror to cc-option to support clang

Masahiro Yamada (3):
      kbuild: consolidate redundant sed script ASM offset generation
      kbuild: drop -Wno-unknown-warning-option from clang options
      kbuild: move cc-option and cc-disable-warning after incl. arch Makefi=
le

Mathias Nyman (1):
      xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Matthias Kaehlcke (10):
      kbuild: Consolidate header generation from ASM offset information
      kbuild: clang: Disable 'address-of-packed-member' warning
      arm64: Disable asm-operand-width warning for clang
      x86/kbuild: Use cc-option to enable -falign-{jumps/loops}
      x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work aroun=
d Clang incompatibility
      kbuild: Add __cc-option macro
      x86/build: Use __cc-option for boot code compiler options
      x86/build: Specify stack alignment for clang
      x86/build: Fix stack alignment for CLang
      x86/build: Use cc-option to validate stack alignment parameter

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Michael Davidson (3):
      kbuild: clang: add -no-integrated-as to KBUILD_[AC]FLAGS
      crypto, x86: aesni - fix token pasting for clang
      x86/boot: #undef memcpy() et al in string.c

Minchan Kim (1):
      zram: close udev startup race condition as default groups

Nathan Chancellor (2):
      arm64: percpu: Initialize ret in the default case
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Nick Desaulniers (2):
      kbuild: fix linker feature test macros when cross compiling with Clang
      kbuild: clang: remove crufty HOSTCFLAGS

Paul Gortmaker (1):
      platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Richard Weinberger (1):
      um: Give start_idle_thread() a return code

Sabrina Dubroca (1):
      ip_tunnel: don't force DF when MTU is locked

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" oper=
ation

Siva Reddy Kallam (1):
      tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control=
 paths

Sodagudi Prasad (1):
      kbuild: clang: disable unused variable warnings only when constant

Stefan Agner (2):
      kbuild: set no-integrated-as before incl. arch Makefile
      kbuild: allow to use GCC toolchain not in Clang search path

Taehee Yoo (1):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine

Vasily Gorbik (1):
      s390/vdso: add missing FORCE to build targets

Vin=C3=ADcius Tinti (1):
      kbuild: Add support to generate LLVM assembly files

YueHaibing (1):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()

=EB=B0=B0=EC=84=9D=EC=A7=84 (1):
      flow_dissector: do not dissect l4 ports for fragments


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv9mF4ACgkQONu9yGCS
aT7wiRAAs6yJ0AKanePnpPCnKnDJFwMiuUiQCE2BhIf7zSPVphpnkKoN4uGVqOII
qsQuBqvNXmiOmvhvcJUkGUynPjMjoxErSf6YeZh+1ItA2eC6aeNG8DwgdmSmtgDi
BNaKvCtwZRWptN8mxYBC4YqNAA4Ac4vp2JHLVPJmEKone2c7peVswiEMNUN/B/TO
9Ed3qDnZibJI1wwdMZbELBaISz15yHPT4m1gSUW1u08zIBqL2sg1vr6Pj/KC35Ih
JKIzP2HLmwedXGf8Pkigjl3ZgCZFFtGb2ChYMduHyWEDJjiQ7n27CIvt+j4ACieC
XLaR1aRZQYXZpi4ARrIFN2RiR+QueDGOZ+Fq//veBgPXSXHCR1hG8D54KjayDybi
UMq2FQmswLfMhp0OWTpaDM1xmXUZtunkbvqxk6KfkpK9Jvg2V3DDWH+gsOlFEQBY
AE+n4TtYRhx3T6q29gWWPQyKwSxj2xvPzHOBC2XodovVDbVFl22ZnMoDdkQZe9KJ
CvVsdxUk1Yk4txwVdKjqRVsNVeafgZxMUjwm3H0wJF4LaXzYOdf/yS3gcoAm1aZz
n2aZKIO6jZMfoHD9oucd7YgtbaFE2mJDQDc8nTtUM4BelkgDikc+6VO8UlfC8au5
YLv5e3OEy18S0cB1o5imlxIu4T4Ul8jCm5lXaY0y1Byi6bz4Wic=
=m1Lt
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
