Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B97D218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L65vyQQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfBRDmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:42:06 -0500
Received: from ozlabs.org ([203.11.71.1]:58651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfBRDmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:42:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442qRs3JDMz9s3x;
        Mon, 18 Feb 2019 14:42:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550461321;
        bh=6LoDtU7qK9+pONGYsy7pcrn9THXZJVLXhkxOZBSfHTk=;
        h=Date:From:To:Cc:Subject:From;
        b=L65vyQQHyUqpNENdZyaIySkfghueQnZMSLljFMWttwMTBtF8+xp9mOVmEYVPsdCbM
         BVLnuAm/jU4coOfKTjItVlhCIChzr6gSzOva/mToa5ua5pcv/52ePMw6hJ1ZwpYTSm
         pqrfBldD/DkwASknXctJ80AwEqFY/4MjuD5AfhflK/DoXbLXVYu4X2mxoO5IMJGs90
         klTWu+WhB7UOEvKAdd7meHgd0JE8RFZ5sqTPWiqKFkBUeayVhEXydgTXQA39ioekEC
         tvVBwVHTLg+vVx2jWUlZtt7jI0m153cedWDDcgK2bZSb1SorVJN0HcHqQOOpn6CZ91
         dwj/e8i6bgWSA==
Date:   Mon, 18 Feb 2019 14:42:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: build failure after merge of the kvm tree
Message-ID: <20190218144200.2dc3283f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kBSwC6M=QS2NBKYnWU6mIKd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kBSwC6M=QS2NBKYnWU6mIKd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c:14:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/kvm_main.c:21:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/eventfd.c:24:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/irqchip.c:27:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/async_pf.c:23:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/../../../virt/kvm/vfio.c:14:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/x86.c:22:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/irq.h:27,
                 from arch/x86/kvm/mmu.c:21:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from arch/x86/kvm/emulate.c:23:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kvm_host.h:38,
                 from drivers/gpu/drm/i915/gvt/kvmgt.c:42:
arch/x86/include/asm/kvm_host.h:38:10: fatal error: asm/kvm_vcpu_regs.h: No=
 such file or directory
 #include <asm/kvm_vcpu_regs.h>
          ^~~~~~~~~~~~~~~~~~~~~

Caused by commits

  1561fcbc8e16 ("KVM: x86: Explicitly #define the VCPU_REGS_* indices")
  a46e726511f4 ("KVM: VMX: Move vCPU-run code to a proper assembly routine")

It looks like a file was not git added :-(

I have used the kvm tree from next-20190215 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kBSwC6M=QS2NBKYnWU6mIKd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqKYgACgkQAVBC80lX
0GwXJggAmATWb08AJYliDghecOEVUJ6KsLonX8QoruP/A+RWn1jUrxXwlk/aK42R
k0PKpAE1hNuvKQZVHZLa8KCuC5EbwM+9XjKm7OUd1Mu/czRJ1ceimTj3QdqUJEb8
U3gdHWbHM+G0jE1xIWKqMMyE31inS6D+4bUq/6t16Day86KcW3FdeSfrBh5JAn+k
VGWGzOoAdj4HWWxwDAVbnf2c5pY0VwoZamInLa6GihJB+7ii7SvGxdJdyPPH3BWS
OlfPdwISVUTFCKDwWT3ngp348TBRC6Mhbto5C6aezK22/VhyPO5dwo2A6UIbQcMY
y3e1HwvJyrN4+MliMZYnEd8xlGM+vw==
=N5hA
-----END PGP SIGNATURE-----

--Sig_/kBSwC6M=QS2NBKYnWU6mIKd--
