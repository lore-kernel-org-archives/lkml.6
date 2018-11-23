Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81635C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8B320685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4hC/vMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502503AbeKWSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbeKWSai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:30:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8440820685;
        Fri, 23 Nov 2018 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542959254;
        bh=k/5qgQVZz/+pVGv8/+Jpzc1cCPfPaxn5rKjxvMQGlUg=;
        h=Date:From:To:Cc:Subject:From;
        b=N4hC/vMowkxtGn8MBRohNGkvggZrlbjB41hfXaSoBjjJrIA12QZBIkJ7ooypqtztN
         8zb898Jo5bQP2vrh5lXXbrglwHYqnKEMTD3E0HEvGz/7YV4KWyR+gCmuQqEKEVpjmG
         FZI3xlhj7nMQdpynltsvxSXCOzrQbPWPKv5QIqrg=
Date:   Fri, 23 Nov 2018 08:47:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.139
Message-ID: <20181123074731.GA12130@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.139 kernel.

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

 .gitignore                                |    1=20
 Kbuild                                    |   25 ----
 Makefile                                  |   27 +++-
 arch/arm/include/asm/assembler.h          |   12 ++
 arch/arm/include/asm/barrier.h            |   32 +++++
 arch/arm/include/asm/bugs.h               |    6 -
 arch/arm/include/asm/cp15.h               |    3=20
 arch/arm/include/asm/cputype.h            |    8 +
 arch/arm/include/asm/kvm_asm.h            |    2=20
 arch/arm/include/asm/kvm_host.h           |   14 ++
 arch/arm/include/asm/kvm_mmu.h            |   23 +++
 arch/arm/include/asm/proc-fns.h           |    4=20
 arch/arm/include/asm/system_misc.h        |   15 ++
 arch/arm/include/asm/thread_info.h        |    4=20
 arch/arm/include/asm/uaccess.h            |   26 +++-
 arch/arm/kernel/Makefile                  |    1=20
 arch/arm/kernel/bugs.c                    |   18 +++
 arch/arm/kernel/entry-common.S            |   18 +--
 arch/arm/kernel/entry-header.S            |   25 ++++
 arch/arm/kernel/signal.c                  |   55 +++++----
 arch/arm/kernel/smp.c                     |    4=20
 arch/arm/kernel/suspend.c                 |    2=20
 arch/arm/kernel/sys_oabi-compat.c         |    8 -
 arch/arm/kvm/hyp/hyp-entry.S              |  112 ++++++++++++++++++-
 arch/arm/lib/copy_from_user.S             |    9 +
 arch/arm/mm/Kconfig                       |   23 +++
 arch/arm/mm/Makefile                      |    2=20
 arch/arm/mm/fault.c                       |    3=20
 arch/arm/mm/proc-macros.S                 |    3=20
 arch/arm/mm/proc-v7-2level.S              |    6 -
 arch/arm/mm/proc-v7-bugs.c                |  174 +++++++++++++++++++++++++=
+++++
 arch/arm/mm/proc-v7.S                     |  154 +++++++++++++++++++++-----
 arch/arm/vfp/vfpmodule.c                  |   17 +-
 arch/arm64/crypto/sha1-ce-core.S          |    6 -
 arch/arm64/crypto/sha1-ce-glue.c          |   11 -
 arch/arm64/crypto/sha2-ce-core.S          |    6 -
 arch/arm64/crypto/sha2-ce-glue.c          |   13 --
 arch/arm64/include/asm/efi.h              |    3=20
 arch/arm64/include/asm/uaccess.h          |    4=20
 arch/ia64/kernel/Makefile                 |   26 ----
 arch/x86/Makefile                         |   39 +++++-
 arch/x86/boot/string.c                    |    9 +
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S   |    7 -
 drivers/firmware/efi/libstub/Makefile     |   26 ++--
 drivers/firmware/efi/libstub/arm64-stub.c |   10 +
 drivers/net/ethernet/broadcom/tg3.c       |   18 ++-
 drivers/net/usb/smsc95xx.c                |    7 +
 drivers/xen/Makefile                      |    3=20
 include/linux/kbuild.h                    |    6 -
 include/linux/module.h                    |    4=20
 net/core/dev.c                            |    4=20
 net/core/flow_dissector.c                 |    4=20
 net/ipv4/inet_fragment.c                  |   28 ++--
 net/ipv4/ip_tunnel_core.c                 |    2=20
 net/ipv6/route.c                          |    7 -
 net/sctp/socket.c                         |   26 ----
 scripts/Kbuild.include                    |   18 ++-
 scripts/Makefile.build                    |    8 +
 scripts/Makefile.extrawarn                |    1=20
 scripts/Makefile.host                     |    6 -
 scripts/Makefile.lib                      |   31 +++++
 scripts/mod/Makefile                      |   28 ----
 62 files changed, 901 insertions(+), 296 deletions(-)

Ard Biesheuvel (5):
      crypto: arm64/sha - avoid non-standard inline asm tricks
      efi/libstub/arm64: Use hidden attribute for struct screen_info refere=
nce
      efi/libstub/arm64: Force 'hidden' visibility for section markers
      efi/libstub: Preserve .debug sections after absolute relocation check
      efi/libstub/arm64: Set -fpie when building the EFI stub

Arnd Bergmann (2):
      modules: mark __inittest/__exittest as __maybe_unused
      Kbuild: use -fshort-wchar globally

Behan Webster (2):
      kbuild: Add better clang cross build support
      kbuild: use -Oz instead of -Os when using clang

David Ahern (1):
      ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

Eric Dumazet (2):
      net-gro: reset skb->pkt_type in napi_reuse_skb()
      inet: frags: better deal with smp races

Frieder Schrempf (1):
      usbnet: smsc95xx: disable carrier check while suspending

Greg Kroah-Hartman (1):
      Linux 4.9.139

Jeroen Hofstee (1):
      kbuild: fix asm-offset generation to work with clang

Marc Zyngier (2):
      ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17
      ARM: KVM: invalidate icache on guest exit for Cortex-A15

Mark Charlebois (1):
      kbuild, LLVMLinux: Add -Werror to cc-option to support clang

Mark Rutland (1):
      arm64: uaccess: suppress spurious clang warning

Masahiro Yamada (2):
      kbuild: consolidate redundant sed script ASM offset generation
      kbuild: drop -Wno-unknown-warning-option from clang options

Matthias Kaehlcke (8):
      kbuild: Consolidate header generation from ASM offset information
      x86/kbuild: Use cc-option to enable -falign-{jumps/loops}
      kbuild: Add __cc-option macro
      x86/build: Use __cc-option for boot code compiler options
      x86/build: Specify stack alignment for clang
      kbuild: clang: Disable 'address-of-packed-member' warning
      x86/build: Fix stack alignment for CLang
      x86/build: Use cc-option to validate stack alignment parameter

Michael Davidson (3):
      kbuild: clang: add -no-integrated-as to KBUILD_[AC]FLAGS
      crypto, x86: aesni - fix token pasting for clang
      x86/boot: #undef memcpy() et al in string.c

Russell King (22):
      ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs
      ARM: bugs: prepare processor bug infrastructure
      ARM: bugs: hook processor bug checking into SMP and suspend paths
      ARM: bugs: add support for per-processor bug checking
      ARM: spectre: add Kconfig symbol for CPUs vulnerable to Spectre
      ARM: spectre-v2: harden branch predictor on context switches
      ARM: spectre-v2: add Cortex A8 and A15 validation of the IBE bit
      ARM: spectre-v2: harden user aborts in kernel space
      ARM: spectre-v2: add firmware based hardening
      ARM: spectre-v2: warn about incorrect context switching functions
      ARM: spectre-v2: KVM: invalidate icache on guest exit for Brahma B15
      ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1
      ARM: spectre-v1: add speculation barrier (csdb) macros
      ARM: spectre-v1: add array_index_mask_nospec() implementation
      ARM: spectre-v1: fix syscall entry
      ARM: signal: copy registers using __copy_from_user()
      ARM: vfp: use __copy_from_user() when restoring VFP state
      ARM: oabi-compat: copy semops using __copy_from_user()
      ARM: use __inttype() in get_user()
      ARM: spectre-v1: use get_user() for __get_user()
      ARM: spectre-v1: mitigate user accesses

Sabrina Dubroca (1):
      ip_tunnel: don't force DF when MTU is locked

Siva Reddy Kallam (1):
      tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control=
 paths

Vin=C3=ADcius Tinti (1):
      kbuild: Add support to generate LLVM assembly files

Xin Long (1):
      sctp: not allow to set asoc prsctp_enable by sockopt

=EB=B0=B0=EC=84=9D=EC=A7=84 (1):
      flow_dissector: do not dissect l4 ports for fragments


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv3sJMACgkQONu9yGCS
aT7gCxAAiFzDmcNy2LBHbz+j0T9QqWfH/+BQ+92s4B22eursfeLdlQaYoYQ3J08Q
K1Ne2g6FYsUIPeiJnzerXk/2x0rR/3Zgp3Av5o5NsISruGdi75+o/8LmodsjoU0u
2vRebS3FtXW+RVTS2/BV0R5mFkJZO8YttwSdbzt9l/aBpa6gJotHuKwQYScoBLJs
H2Xt6T/7FAf/u9B5QF1iVhT28wuAL0AHvuMr1qOKPY09s35Lq3eeSybKGe1pYm5j
/TkSKqR3FbEpQtK+zkgf55/PWh8fNqS5XbC/qiZLGZAz+AyTzwBHRcqW18fEaZkY
IY54ZtBaif6Mzo0vAQyDPYO07OUaGVtgv5HwVb/IJQq6w/mA0XPeUW04QDZVQXTa
TYc+bIX9VV/c/m/AqDJZzIVIOF5IoLf7NdqQjgBwU9PR1+cqPeW7FgtzM1+co5p2
CUvDGMIRZc7pj0AyFiVYRJ9AMkPk/p5NcaTIwmq3+hZ8b7QQoWDbJZ/xWtaHu2qB
Yv2bVSnGcDJvkn8hMCVlUF5YIJ7ZSglZr5VwbqkvqRAgkD+UpSJmf4/SiMmkq695
o5TABuK3SvDc34/9JBB8xVY1T1Jd7/HMM3nqKbQmMC3PwpOcWlOhI8zG8M1g7mHL
svt4hVOvRKqD2gIjmcpOwA34YpTMFaIS3aXSgt+KNYAlciT5mgk=
=V1te
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
