Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365ACC6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1DD2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OcgE1xMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1DD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeJHIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:12:43 -0400
Received: from ozlabs.org ([203.11.71.1]:48131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHIMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:12:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T2DN2TWYz9sCr;
        Mon,  8 Oct 2018 12:03:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538960612;
        bh=DSU7R02dYanA93J17GHpS2zqb0FRLEPY26NvzukKqk4=;
        h=Date:From:To:Cc:Subject:From;
        b=OcgE1xMRN2YG4qj7PHs+bhPeua3nrDRvxqkM7lHpt3dcK34sb/nQA7/VsK1YdtaEb
         tp8jkDW4gRIAPhAUmDRWvUygsAihmutK1xdOoFFmftqz6ulGypkTBWagjtwjXWN84V
         hjhW37yRQdzn0+vu1bD9n+r/PBMSMLz0PpEkdyyhXPEBw3o1S6bzLDfURtXukp08RL
         EiIPca7cn61wx+dGElZw9g88kri0GyDtopvr/nfm6gnXVc9oJbisQSruibSxjMCdds
         8V9GkPr+zR6uXIYE0qhnfdv6NCWYZmL2CfFvdXlI+GczZ8MQgFlQZaDIjDpta0sqtw
         jr6W7EcTLutWA==
Date:   Mon, 8 Oct 2018 12:03:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20181008120330.5d63f54b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7BpRpp=xAc/De5PqaOGl6o1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7BpRpp=xAc/De5PqaOGl6o1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "crypto_fpu_exit" [arch/x86/crypto/aesni-intel.ko] undefined!
ERROR: "crypto_fpu_init" [arch/x86/crypto/aesni-intel.ko] undefined!

Caused by commit

  944585a64f5e ("crypto: x86/aes-ni - remove special handling of AES in PCB=
C mode")

I have used the version of the crypto tree from next-20181005 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/7BpRpp=xAc/De5PqaOGl6o1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6rOIACgkQAVBC80lX
0GyOngf+JoprrOZFMXVND6FwoU9wQwzYXvoEOHbDMqGk9borKOlh7KNhfDs9Ws8M
86cG2a7rMOpaGYL75UcZvZRHgGhHbUYHGIArJC4seiehKsVWzPM+oPA1NBHS/Xq2
urv5hKhZPAwn7Jj+76Z5oxTjyHcMBHr8PuhzwDNUKkjL0BR310XJ8vx9daLD4abW
zR58OF4bHZbr0VXl+zdDafQPNqVd+dVr59bsJHAFavEacGi7MHFgLgJVtmVm1eT7
6+mePhkxuN0MvUbC1QrJ0osQhUmU2m8S7w+DQvZZc8/D0N+0DU1gzDXuOuXHOzNM
CMTauMHM0AK1lhz4ezD+EjrYUbgOAA==
=FA30
-----END PGP SIGNATURE-----

--Sig_/7BpRpp=xAc/De5PqaOGl6o1--
