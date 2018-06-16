Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AEA208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrAQ8CVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AEA208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeFPJqV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754109AbeFPJqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:46:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07562088E;
        Sat, 16 Jun 2018 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529142379;
        bh=NPRQodyTwrLTbYORKutQokh9OSv/2JCnJKlmc3bZQks=;
        h=Date:From:To:Cc:Subject:From;
        b=jrAQ8CVR3H8LcPtOfO8fC+4J9XYfEcxm61UQZkS1Q5byYDFRiTZN4tmXQ2mAvkhOF
         433EguQZg+wy4zsKqEwOZMuiGP7kHgoz0x+eT/h9NJ3EQyPnkIUBXSMudgbjsc/ppK
         8CFt39lJ9H2ojf7k4UM5Oo6png27sUAt7L3HkOl8=
Date:   Sat, 16 Jun 2018 11:45:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.138
Message-ID: <20180616094556.GA8765@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.138 kernel.

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

 Makefile                                    |    2=20
 arch/x86/crypto/chacha20_glue.c             |    2=20
 arch/x86/crypto/crc32c-intel_glue.c         |    7 -
 arch/x86/include/asm/cmpxchg_32.h           |    2=20
 arch/x86/include/asm/cmpxchg_64.h           |    2=20
 arch/x86/include/asm/cpufeature.h           |   39 ------
 arch/x86/include/asm/fpu/internal.h         |    6=20
 arch/x86/include/asm/fpu/xstate.h           |    2=20
 arch/x86/include/asm/kvm_emulate.h          |    6=20
 arch/x86/include/asm/smp.h                  |    9 -
 arch/x86/include/asm/xor_32.h               |    2=20
 arch/x86/kernel/cpu/amd.c                   |    4=20
 arch/x86/kernel/cpu/common.c                |    4=20
 arch/x86/kernel/cpu/intel.c                 |    3=20
 arch/x86/kernel/cpu/intel_cacheinfo.c       |    6=20
 arch/x86/kernel/cpu/mtrr/generic.c          |    2=20
 arch/x86/kernel/cpu/mtrr/main.c             |    2=20
 arch/x86/kernel/cpu/perf_event_amd.c        |    4=20
 arch/x86/kernel/cpu/perf_event_amd_uncore.c |   11 -
 arch/x86/kernel/fpu/core.c                  |   24 +++
 arch/x86/kernel/fpu/init.c                  |  169 ++++++-----------------=
-----
 arch/x86/kernel/fpu/xstate.c                |    3=20
 arch/x86/kernel/hw_breakpoint.c             |    6=20
 arch/x86/kernel/smpboot.c                   |    2=20
 arch/x86/kernel/traps.c                     |    1=20
 arch/x86/kernel/vm86_32.c                   |    4=20
 arch/x86/kvm/emulate.c                      |   72 +++++------
 arch/x86/kvm/vmx.c                          |   23 +--
 arch/x86/kvm/x86.c                          |   51 ++++++--
 arch/x86/kvm/x86.h                          |    4=20
 arch/x86/mm/setup_nx.c                      |    4=20
 drivers/char/hw_random/via-rng.c            |    5=20
 drivers/crypto/padlock-aes.c                |    2=20
 drivers/crypto/padlock-sha.c                |    2=20
 drivers/crypto/vmx/aes.c                    |    2=20
 drivers/crypto/vmx/aes_cbc.c                |    2=20
 drivers/crypto/vmx/aes_ctr.c                |    2=20
 drivers/crypto/vmx/ghash.c                  |    2=20
 drivers/gpio/gpiolib.c                      |    9 +
 drivers/input/mouse/elan_i2c_core.c         |    1=20
 drivers/input/touchscreen/goodix.c          |    1=20
 drivers/iommu/intel_irq_remapping.c         |    2=20
 drivers/misc/vmw_balloon.c                  |   23 +--
 drivers/tty/serial/samsung.c                |    7 -
 fs/btrfs/disk-io.c                          |    2=20
 include/linux/fs.h                          |    4=20
 net/key/af_key.c                            |   45 +++++--
 47 files changed, 258 insertions(+), 331 deletions(-)

Andy Lutomirski (6):
      x86/fpu: Default eagerfpu=3Don on all CPUs
      x86/fpu: Fix 'no387' regression
      x86/fpu: Hard-disable lazy FPU mode
      x86/fpu: Fix FNSAVE usage in eagerfpu mode
      x86/fpu: Fix math emulation in eager fpu mode
      x86/crypto, x86/fpu: Remove X86_FEATURE_EAGER_FPU #ifdef from the crc=
32c code

Borislav Petkov (2):
      x86/cpufeature: Remove unused and seldomly used cpu_has_xx macros
      x86/fpu: Fix eager-FPU handling on legacy FPU machines

Ethan Lee (1):
      Input: goodix - add new ACPI id for GPD Win 2 touch screen

Gil Kupfer (1):
      vmw_balloon: fixing double free when batching mode is off

Greg Kroah-Hartman (1):
      Linux 4.4.138

Johannes Wienke (1):
      Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Juergen Gross (1):
      x86: Remove unused function cpu_has_ht_siblings()

Kevin Easton (1):
      af_key: Always verify length of provided sadb_key

Linus Torvalds (1):
      Clarify (and fix) MAX_LFS_FILESIZE macros

Linus Walleij (1):
      gpio: No NULL owner

Marek Szyprowski (1):
      serial: samsung: fix maxburst parameter for DMA transactions

Michael Ellerman (1):
      crypto: vmx - Remove overly verbose printk from AES init routines

Paolo Bonzini (3):
      KVM: x86: introduce linear_{read,write}_system
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_vi=
rt_system
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor ac=
cess

Yu-cheng Yu (1):
      x86/fpu: Revert ("x86/fpu: Disable AVX when eagerfpu is off")

yu-cheng yu (3):
      x86/fpu: Fix early FPU command-line parsing
      x86/fpu: Disable MPX when eagerfpu is off
      x86/fpu: Disable AVX when eagerfpu is off


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsk3FQACgkQONu9yGCS
aT7vLRAAwcPKi7uL+9TOPCOolxpSt8ZagrLWkatNxHV9cmI/VOnUhIV5qAfC95/T
KwCq4CsvuSEksW/1cF/vVv7qgdzOZpc0MW7ycoEd6QJm3FZ8AFyuoInWxynK879z
qgRAF0n7hgF9cyQodEr3lO/Rp6UCBs8DOmx3vyxpFfGfE4xD3lss7aWGgVD5/LAj
PWX0fNJEF72WXxpDXWYCli9xVssHhu/pu1o7LHxAIBplUFeNUhCloAKx5wyc9Yx8
iTEnw3n21D2XEOLrUy8cPcaYGUEKtOSTFLkQMmWrhnTCXgYjCZAI0W9Om79bC1iE
29SmnhytoHP9wby6Q6WIh2JBF/gyM2YsaG8NJGGRLcn/2hUfYUJPfdSqkJGBqFhY
LSHEFSXIcrtOG+5UZ37bGTH4aVM5tGi0+OozOoIm7JIf6usgbYnXLcE7p1ZwFIXN
MMWfiKrPhzSzRGuT7HrGcqsrFBsCmitG9lxW3wENgJuCo+KYt3KgLy7YpHkrus8f
PvJ5sKZkmoTsK/btJ90a0njjXvzi6Wig1ZQSAQJzKN0TtLWxdgCDFZUR7pBzrQfS
tzWioVAwAWmYo3enStNYhGP1cuL79/VlLYTwCHpTuADN+cyg+7FRIkxrl00tL9oM
y4ka+cwM0fTyX7yFPUlP6YpKFCB6dSlPZG0Sy4wCriKTsBYIm+Y=
=rgVE
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
