Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52BDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E20D20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cWEfOFMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E20D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeKBW3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:29:32 -0400
Received: from ozlabs.org ([203.11.71.1]:39219 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBW3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:29:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42mjRJ3vMdz9sTJ;
        Sat,  3 Nov 2018 00:22:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541164940;
        bh=Zw4PHYZEGuLpXTO43fA6RRfJSTphsVYK/rkHiJYM4x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cWEfOFMPeVaZd1QWEKL8BsCZ9CIyLoK9BfaHZFWTaqOEo92Alw7XNZbFW7YiVfIBI
         Ne6gzHp2petSO2XSYHzx9F4iBpX7Ekw3ERiHd/1p+ktN6knzsUxDcA/t8vh/0bgZOJ
         HGfQsUXZtN7zqIOUQcRq1Fcb1rM3kD9ji2oNvm0QEcqs+6IaRHkTjRPrRPLTXDCJ97
         qAVk6yrkTaFqrNVIvU6LEW05VZzVPKOsZ1ZcapYtaqJsfNdUQVNfeRW2ptCKuWd5td
         L97v4mwcnZVWZinfGygESZ60YIg4zJTZgstvla+QuNZQe0tfvmFa2VtAifItCxqG+v
         1loAWP0HAD4GQ==
Date:   Sat, 3 Nov 2018 00:22:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Nov 2
Message-ID: <20181103002218.3bd015b3@canb.auug.org.au>
In-Reply-To: <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
References: <20181102143018.09feb051@canb.auug.org.au>
        <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KVQ2XWkcfW3Bxgio75KWddp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KVQ2XWkcfW3Bxgio75KWddp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Fri, 2 Nov 2018 11:44:07 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail=
.com> wrote:
>
> On Fri, Nov 2, 2018 at 4:33 AM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >
> > Please do not add any v4.21/v5.1 code to your linux-next included trees
> > until after the merge window closes. =20
>=20
> Is it OK to move forward the branch up to the point where it landed in
> mainline, no? What about changes for this release that will be sent
> for -rc2, -rc3... etc.?

Its always OK (and actually useful) to move your branch head up to
where Linus merged it (this is usually a fast forward anyway) since
that doesn't add any new code to linux-next to conflict with code that
is still pending to be merged by Linus.

Also, adding bug fixes is always fine.

I just want to avoid getting conflicts in linux-next between code
that Linus will merge during this merge window and new code destined
for the next merge window.
--=20
Cheers,
Stephen Rothwell

--Sig_/KVQ2XWkcfW3Bxgio75KWddp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvcT4oACgkQAVBC80lX
0GwE/Qf/daFJ5clgwmnwyYGxELmK/o0SXf4y4lrmjbmt7XI32EUZyCa/py4cAbLE
cq0rhecb2HbmBk+QQLGNC3R0UBkO/g9yRrJ7e8zDNSoMJCFNBZt3BMR4gGLSWS79
DlOcVGP8abcdxtO1n3SB2FZKu6ekqIGizFzqxqJo4tCEb655YHnsWoZqtjY94ell
BjRGbNfvwqKOh8+ZLn/3fcPpwUTrIK4fD8Cea/ZdjGHpj6+GkFHc8tNgKOg+n8kL
bu5xEZxOCcjkiD0Q1SsDFRwD88WO3oSKGRKczi0PLiNgGkNuCHEostdWHUuRCBGt
TJrxAFEYjaRjCMQ3BIAuBq+o18pKzQ==
=sSum
-----END PGP SIGNATURE-----

--Sig_/KVQ2XWkcfW3Bxgio75KWddp--
