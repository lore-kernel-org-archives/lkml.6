Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44557C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DD4206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fW5qPGaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DD4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeIKIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:51:09 -0400
Received: from ozlabs.org ([203.11.71.1]:48203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeIKIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:51:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428WHK2KHjz9s4s;
        Tue, 11 Sep 2018 13:53:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536638030;
        bh=U7hm81LaUaRsiFBGgJZJKRJFO+l+BCvVJ9bLnjhYi6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=fW5qPGaD88j9ihPXkj+9HB54r+cDJCEnIVZXvWydL4K0NJTqg8fLUVKYxHLD24xlR
         Z/WhKSpZfYPphQ93AItp5EVKcr8K+44aF17nrcMz5huo2PmN4CC5KnhejeThRU87Ev
         h4ffQlbTjIIiYK4qzZpYa8jY7Ly9I/gZ0iHwf7JRVH/CGmJD3AaYPoOh69Q0GeaqKS
         m+BnunEVZtTMVIK4fzEvTJDsTYnbLX2qooOyPAlecuwe7h4c6Xo93+X2hzlvJofqPr
         p+Nx39K8bpn6GRpONy7nrkAy8JNUyi/izvZCqeqcEv4VwSsBkX+PUQ3C7p4CqsafuV
         u+jnDJ61+4fsw==
Date:   Tue, 11 Sep 2018 13:53:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20180911135347.0af423f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PdVK_xcHAtsPUE5Is.0h_F="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PdVK_xcHAtsPUE5Is.0h_F=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
produced this warning:

arch/x86/kernel/cpu/common.c: In function 'syscall_init':
arch/x86/kernel/cpu/common.c:1534:6: warning: unused variable 'cpu' [-Wunus=
ed-variable]
  int cpu =3D smp_processor_id();
      ^~~

Introduced by commit

  86635715ee42 ("x86/pti/64: Remove the SYSCALL64 entry trampoline")

--=20
Cheers,
Stephen Rothwell

--Sig_/PdVK_xcHAtsPUE5Is.0h_F=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluXPEsACgkQAVBC80lX
0Gyv4wf6A9EUl1isf2tWoyRA+rpUyU35DDMG861H8dApxf0Hw4WevT7GIzyfNb07
6Sv17/6uXD6wxrP0xPe4L7hZGRDfE3NqTZaCzlaXJaJ5xnXlLhbrdKYoEOdLe7vy
qwrRcGO9sdMx68Y/ksPQf0ADocNDc59HQWlCp1d7OXPTJ6Xtwg/3THnYjpd2FPQV
7c1hKvMSUi88GpUQwt7HhtpQ2WLIH1DxP9WuL0xic8I0dFaNH92JErbeh2ugycVs
bK/SFj8EDUGaMleNwtOTuOEJyPTorNLoFBciJ3IBHhYszeOCDXriNLlnMM6YBfK3
h7g01nAH5soEwQ2141heyv8V/nIcZA==
=av4c
-----END PGP SIGNATURE-----

--Sig_/PdVK_xcHAtsPUE5Is.0h_F=--
