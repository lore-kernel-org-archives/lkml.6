Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824A320851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q8QsbaEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824A320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeK1J1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:27:15 -0500
Received: from ozlabs.org ([203.11.71.1]:33421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeK1J1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:27:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 434JMB6kh4z9rxp;
        Wed, 28 Nov 2018 09:27:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543357671;
        bh=Nz+IR27z1YzH2+03wyfiL3L5Y0H7VPS7vycYEOxkwb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q8QsbaEq1yFxbcvF+Af0Ok4ryOvftTBJdVCcI17afYDt/dXFHadvnhT6lCmpuekCl
         XT3z0cSN7EEy5uN3ij0+EBAqY7FTbk8QAhbPWM5LSzTRZsjMZ1sqidccjD+emy1Nje
         17PPmzCVwDzg9Dz73he1Z/Qu6Ukw4ABA5T3DCLUeUfn7KpSuhKzpQtvIawqpGnnmMn
         0KU+0kUmhRyV+JSUTd8hDpsbeKXfbliQVWInhrhNDyPY5y29EYUNGD+T+nnEku+DzI
         RxVvZA2EDnyIMnVpyLY1YB3SHGXz8gyT2Ap78fGNGNG0uI0SHlc8yl7lQJJWdv/dfe
         Is1xww2NEXYgw==
Date:   Wed, 28 Nov 2018 09:27:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     shuah <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Rue <dan.rue@linaro.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the kselftest
 tree
Message-ID: <20181128092735.7a2f830f@canb.auug.org.au>
In-Reply-To: <6235956e-5edd-3b7d-1898-ab55094a7e16@kernel.org>
References: <20181128073603.3786e528@canb.auug.org.au>
        <6235956e-5edd-3b7d-1898-ab55094a7e16@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/to4+TA8.zCLxyH3aZBDWixN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/to4+TA8.zCLxyH3aZBDWixN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, 27 Nov 2018 14:17:57 -0700 shuah <shuah@kernel.org> wrote:
>
> Thanks for catching this. I will fix it. This is the result of change=20
> log content messing up the commit: The diff -Z in the change log=20
> resulted in throwing out the Signed-off and Acked-by.

Tricky :-(

> -----------------------------------------------------------------
> diff -Z is used to trim the trailing whitespace when comparing the
> loaded firmware file with the source firmware file. However, per the
> comment in the source code, -Z should not be necessary. In testing, the
> input and output files are identical.
>=20
> Additionally, -Z is not a standard option and is not available in
> environments such as busybox. When -Z is not supported, diff fails with
> a usage error, which is suppressed, but then causes read_firmwares() to
> exit with a false failure message.
> --------------------------------------------------------------------
>=20
> Oh well! I will fix-up the change-log and amend the commit.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/to4+TA8.zCLxyH3aZBDWixN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv9xNgACgkQAVBC80lX
0Gxv3gf+ICfHY/Q3qKU/lOgvCWm2r2BFYqoVrlZU6JxK3+oHtRb8VOYg0JA2AQa/
wylxNGvVFq/Izmkl0J6K9Xq9jJ+DbZCQYTuJnQ+BFr/auenL0fotdaTd0tYmKpBo
MevU0Q+3YEuoV+Yu1MUe2WBun1Hp18MC+EbV904ajQbKMVabJwNk+2hbIo1dzRfa
Mry+7KvDCj+Q5pgS4jMoF31KFLB81aIuXOzUpTO6lY13bknbDg4i64ynfYK2P6fR
h2CUYcMNf22SMeVIrsiz/4SU4sfCXKrlB+a6UiuMNpUpmT0p/eMpWptzveK2bC95
Yph/BQal2tDbR4w5ZL7eDnt2Fd4KWw==
=4WWZ
-----END PGP SIGNATURE-----

--Sig_/to4+TA8.zCLxyH3aZBDWixN--
