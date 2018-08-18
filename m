Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232A620C51
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232A620C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeHRLvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:51:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeHRLvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:51:44 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 335483EE;
        Sat, 18 Aug 2018 08:44:50 +0000 (UTC)
Date:   Sat, 18 Aug 2018 10:44:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.16
Message-ID: <20180818084445.GA31615@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.16 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
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
 arch/x86/kernel/apic/x2apic_uv_x.c                   |    4=20
 arch/x86/kernel/cpu/bugs.c                           |    3=20
 arch/x86/kernel/cpu/common.c                         |    2=20
 arch/x86/kernel/cpu/cpu.h                            |    1=20
 arch/x86/mm/pageattr.c                               |    6=20
 arch/x86/mm/pgtable.c                                |   61 ++
 arch/x86/mm/pti.c                                    |   34 +
 arch/x86/xen/enlighten_pv.c                          |    3=20
 crypto/ablkcipher.c                                  |   57 +-
 crypto/blkcipher.c                                   |   54 +-
 crypto/skcipher.c                                    |   55 +-
 crypto/vmac.c                                        |  412 ++++++++------=
-----
 drivers/crypto/ccp/psp-dev.c                         |    7=20
 drivers/crypto/ccree/cc_cipher.c                     |  111 +++--
 drivers/crypto/ccree/cc_hash.c                       |   81 ---
 include/asm-generic/pgtable.h                        |    8=20
 include/crypto/vmac.h                                |   63 --
 lib/ioremap.c                                        |    4=20
 net/bluetooth/hidp/core.c                            |    4=20
 scripts/depmod.sh                                    |    8=20
 25 files changed, 488 insertions(+), 518 deletions(-)

Chintan Pandya (1):
      ioremap: Update pgtable free interfaces with addr

Dave Hansen (1):
      x86/mm/pti: Clear Global bit more aggressively

Dou Liyang (1):
      x86/platform/UV: Mark memblock related init code and data correctly

Eric Biggers (7):
      crypto: x86/sha256-mb - fix digest copy in sha256_mb_mgr_get_comp_job=
_avx2()
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path
      crypto: skcipher - fix aligning block size in skcipher_copy_iv()
      crypto: skcipher - fix crash flushing dcache in error path

Gilad Ben-Yossef (1):
      crypto: ccree - fix iv handling

Greg Kroah-Hartman (1):
      Linux 4.17.16

Guenter Roeck (2):
      x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled
      x86: i8259: Add missing include file

Hadar Gat (1):
      crypto: ccree - fix finup

M. Vefa Bicakci (1):
      xen/pv: Call get_cpu_address_sizes to set x86_virt/phys_bits

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Randy Dunlap (1):
      kbuild: verify that $DEPMOD is installed

Tom Lendacky (2):
      crypto: ccp - Check for NULL PSP pointer at module unload
      crypto: ccp - Fix command completion detection race

Toshi Kani (2):
      x86/mm: Disable ioremap free page handling on x86-PAE
      x86/mm: Add TLB purge to free pmd/pte page interfaces


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt33H0ACgkQONu9yGCS
aT4v6xAAibZv/7lzGMp5iloaeBLisoQvHb5BiKEz1L1kwpe/d6wY1O+pTKUI+7Tp
LMkWuelqWrUWJlDYIXQhhyiqnEzc7MuEHJ0YSDhQvJHPSr8fNUfXEU55cDiNmPLY
P00qx4Fi/c9PcYgf9tFTOB80ALsXhMqwEuxMv5dLMTal4N2QCHxp3dUrbeWXO1n8
T9VFiP9My2VOmWff8qDzDC1koRz3ZAqqBOxmK6gS7lC5IIsXrXEn3Iw2WvY2V53G
Oj4RgKz4RL+9fOAUVlZzeIh7eq3AM8CcoS9eRwo/D5BHFa15kOSdHolos6bNuous
GVB/zUewYMY3iMnJx7RLFbR5RXJ6qWLwej3rZCXIpfZKlm+7eGe8FIqtVlEt0NTB
B8JKnh7s12TeInosQeIqnzmd77sz300og7/TiU5yIR9n0BjerPErQdE2xTxdzTDm
xyvmNt6tvxlXXslOZ13nKKR8YFXsFBYh/QpqlBa55aXLqJxmmhWitm5IxLkKu+67
9GS1xkQL+9v1c6KLaf9HOfvUHKtgOjpEqum61mTThnOEqnpXKron7hVwm1oaBUgf
mNvBDkDsDVScOVaRR1meFJANK7UFR8rgUHtYb4glri+9jXUtye/LSNS4m7oXqxSx
3FxBpc0/4Vv/bUJTMRwrFunNa46FykODPFmUgytoq6JSkIfJzUU=
=JWgu
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
