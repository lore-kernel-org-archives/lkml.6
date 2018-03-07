Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-108815-1520459030-2-17482768457474412711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520459029; b=KW9t+LVobFu3rshUZNBpwJFDFJmX64HOBo5/YQ9NdzEhWv5
    Gn9AVWc3Q/HaNYoGAlrDEN+/8iuw4Sfki7ZZi6dOA83xh0tNvPYZlUi+uFchCtvd
    f1N5z+8a8uP1i6ur+eZf5aHITYUQ1YuocXaKbkf77Z8UzwtH2e+wRgu8dgI6MGqk
    cx/BJgqcTMhkvHVjv604/xw4UCqyKQv+qd5pbauVqmH0LhtyGU5Yi8ukc2l2DYvd
    eSr3hsB/ezaGnxgvMy+hImJAUHxkA0NdAUfZDQ/XYHI/8nWosYS22LyKnjcpWnjT
    GwwVd6D3hmZyf8hfBjUyVJH4E++qQyQ4ZnPUYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520459029; bh=9TdU/mIc0NArgTpM07bshbvvLn
    M9aTXti52I4nAdkbo=; b=X1d6/wEjPpxod8lYxLdAsa37R6q1eCH4nloBV0V866
    eF2xP/xlcLac9lZ00YOHu3LW0FNaGVp9upT8uC+gpGLXHoggoQYnOkOTvUQol67R
    dZ7MbcWZkxKkXd5SQbKo1nQFQKq6mWBIMbKdnkhMLfNRF7fvyKiVQHf+4KjJMr1U
    3q/nhmkHD2vpiFPlDlgB7Z4LslcHUMeL1d52JBz3o+xs/c6ibSPslSBzOpb+Wbf9
    tm1NIMBD+zbJULq1IzjpZ39Jtz1y6OPkPDEUR1crH+5JBmFcG03SjZhF75DAgcc3
    UFiy9s/NuwyPb58dn6kR+3DM0fjAquXDP5bvKYmrGSgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeCGVnq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 16:43:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58602 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeCGVnp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 16:43:45 -0500
Date: Wed, 7 Mar 2018 22:43:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, dedekind1@gmail.com, tharvey@gateworks.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180307214342.GA9852@amd>
References: <20180303104554.5958-1-richard@nod.at>
 <20180306231805.GA28183@amd>
 <6772577.AmT7QaWTNU@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <6772577.AmT7QaWTNU@blindfold>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-07 09:01:16, Richard Weinberger wrote:
> Pavel,
>=20
> Am Mittwoch, 7. M=E4rz 2018, 00:18:05 CET schrieb Pavel Machek:
> > On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:
> > > While UBI and UBIFS seem to work at first sight with MLC NAND, you wi=
ll
> > > most likely lose all your data upon a power-cut or due to read/write
> > > disturb.
> > > In order to protect users from bad surprises, refuse to attach to MLC
> > > NAND.
> > >=20
> > > Cc: stable@vger.kernel.org
> >=20
> > That sounds like _really_ bad idea for stable. All it does is it
> > removes support for hardware that somehow works.
>=20
> MLC is not supported and does not work. Full stop.
> If someone manages to get it somehow work, either with hardware or softwa=
re=20
> hacks they are on their own.
> Having it in stable is the only chance we have to get it into vendor
> kernels.

Can you show how it meets the stable kernel criteria? They are
documented in tree. This should not be in stable.

And I'd like to see changelog improved. Real reason MLC is not
supported is upper/lower page parts on MLC. And real fix to work with
bigger pages in UBI.


									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqgXQ4ACgkQMOfwapXb+vL/RQCfcpBSzmmWE68AU/fR354AZh14
0bkAn1T3J8vwYErdMbytKXu7fUJ4kbvO
=uVCT
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
