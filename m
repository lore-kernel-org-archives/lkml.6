Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1937C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE1F222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CtH/V8Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfBPHei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:34:38 -0500
Received: from ozlabs.org ([203.11.71.1]:53449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBPHeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:34:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 441hj61Mj3z9s1l;
        Sat, 16 Feb 2019 18:34:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550302474;
        bh=Iz20c0e7w0IjTuC49Rxnmj9ccx7yYMlFK+Zzs9kgdio=;
        h=Date:From:To:Cc:Subject:From;
        b=CtH/V8Te8A+k5sNVCDvL7zBYZr/1QK8+S1Vtm4bpFh7mlO8YvBfDCr1v9eWwXxSCZ
         hQ2AjNWT8KY9TBdZKDUB0ONuCCLPAb+2J+SG8s0yu42t/ZAu+W6cnUTReTlMhiNMMy
         f8siuzCEPkl0rCDCn0D7nSLH5dbHeOK54MoGm1lNS8qL4t5NY/LfgQ3pWn6QokbCfa
         KINFK2CkoCwIqTE5LzS0We/ksy9PVaR1a2+kVh2JVOsPtg39KscoqYY84LmSm404Fd
         xmCqVd09kQlIN3Hgj9RFp7QUb8/3WwVPD/mnOQ9HbDV96TwiWqqTAIHXb1tX2fmpuh
         a2cylgHVj8gIg==
Date:   Sat, 16 Feb 2019 18:34:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: Fixes tag needs some work in the kvm tree
Message-ID: <20190216183433.71b7cfa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hT0TtUrI84sJUehGndQa1v_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hT0TtUrI84sJUehGndQa1v_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  aa8359972cfc ("KVM: x86/mmu: Differentiate between nr zapped and list uns=
table")

Fixes tag

  Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return

has these problem(s):

  - Subject has leading but no trailing quotes
    Please do not split Fixes tags over more than one line

In commit

  4d3f8e4ff75e ("kvm: vmx: Fix typos in vmentry/vmexit control setting")

Fixes tag

  Fixes: 'commit f99e3daf94ff ("KVM: x86: Add Intel PT virtualization work =
mode")'

has these problem(s):

  - No SHA1 recognised
    The leading word 'commit' is unexpected and the surrounding single
    quotes likewise.
    Please just use
	git log -1 --format=3D'Fixes: %h ("%s")' <SHA>

--=20
Cheers,
Stephen Rothwell

--Sig_/hT0TtUrI84sJUehGndQa1v_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxnvQkACgkQAVBC80lX
0Gxprwf8CWexXHWXQA91GxrA3UJL1hOxOOGpSXagv2JwXVraclf1I1A8UgI3+y7W
Wqk0XXTyWZIjhH6MkUVY3os32Ox3NtXk6ew8K9XuZGPjoSVTAxRRdAdUVQPEyO2q
+asrvQl3k8DbylsJB+w7EqJEEDpuvkKwzkse6SDZAezVbJlH7SW7dJyDgE391HTt
Tjb8MnPW09ULg+79YnKVj7+TMn6/lZBMo4K/3+UHcvTASeeATYVO4rCO8enljzoH
mjxQoYMu3BAVPv5tO+188Shitu20HYQjeLJGwpxgT8DVjltbukvODuSoJKivzGkG
areJk+MDZZJNPntCCGkEihSwCVnZ1g==
=LwcH
-----END PGP SIGNATURE-----

--Sig_/hT0TtUrI84sJUehGndQa1v_--
