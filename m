Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839050-2-14461448018047488000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839050; b=wx1TE5JGrHPUvB/RjK+MZmGerecrPNOqxsRfF6EkWYDfFZO
    lON/491A1VpIHxXfHIE87SSVuy6ujtsycG1jWbPVufdg90fVlyqqW2KyA+sDnv+L
    jqvWUPiV873Sw2khBGfyQ0X4ZRZiD5VQXA1OWB6S6qxJ03w/vXXjxec0KUJGWj7P
    JD4ZgucD0EENjDmho27AVgqiIA2LgFAYmnonA+qrUrkwv3U4p2Fx+ryMiJBHdZR+
    6eH+WxEM37GjfratOUKaQhyCKBYSTZOe3s1P1Y52ZEM9+dZBAyuOEtbLRV0wF2Bg
    gkM5lgqAFgqOnqO8B6YFoJeKytTL75rq3uVmzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1519839050; bh=niIvPGQd3Brc3KlH8zSmb/aHst
    kESNuNw+uN7INPRgg=; b=ebJuQv3pT8UbdWexazpYCjuF6U5x7LfQ223iB/KE5D
    vc6NNF31wlIV0NFu8DMF0SP1653hCv+1GHjHMDPPY3zH7wHIAJxejkXRN8BAvQm2
    WApVqjQnvcD8WRhP40IX6C1U+bCUghylSOvlH8jfBk9Jw8+GnUSh2rYq0II88YZh
    3c/O1dOaY9gE9BHi/H/qexgBt9NaPe5wFc/jjjqtTkEw7LHKsut8kEeQ3mYILb7+
    2Qp7lezqW62rynXKulTBSJy7ala9B0s3uFzgGS39cKcA/f9HeZWlH8bCH3Cz/e0m
    bqkUabLYgRGrVuerDSCQzp/3qxaI5LTTBw4xOZCssqUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeB1Rad (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:30:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35945 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753195AbeB1Rac (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 12:30:32 -0500
Message-ID: <1519839015.2617.356.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/254] 3.16.55-rc1 review
From: Ben Hutchings <ben@decadent.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date: Wed, 28 Feb 2018 17:30:15 +0000
In-Reply-To: <20180228165737.GB15218@roeck-us.net>
References: <lsq.1519831217.271785318@decadent.org.uk>
         <20180228165737.GB15218@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-B3PO2cYUQr+vYQAFOa2U"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-B3PO2cYUQr+vYQAFOa2U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-28 at 08:57 -0800, Guenter Roeck wrote:
> On Wed, Feb 28, 2018 at 03:20:17PM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.55 release.
> > There are 254 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Fri Mar 02 18:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 108 pass: 108 fail: 0
>=20
> Details are available at http://kerneltests.org/builders.

Thanks for testing both of these.

Ben.

--=20
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.


--=-B3PO2cYUQr+vYQAFOa2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqW5ycACgkQ57/I7JWG
EQnaLBAAuQyq78LZSe7Jl/pAGvxVWkBcmA02rpNLCdi/vYSBU2lJOkSEtaxJzD+0
n/8x1GnwHVDMW/0HNWXyqvpTN1yrUoys1qYl50iOYS9CXP66sMl65UgqjjliwWOv
GKJjcVlSEARUZHNAl+7+cVMM7Fs5kHpy6IByStai3sGwIYo41/b6dLuSCH9jqjTv
KwK4YLGCO8R+T6QhyBIJ4vSonUfOEmYXqY7Pvlq3EohuJNN7kERn9FagMpVA09rr
MH5nqcMefNRu8WJKc+op2XYxE/hVEYCCNrjHgNtmGgAJvI/pjy/MmiUje3Ks+xmO
vgMO2j8Bae5xJ7uYMZPFc9OVTvv3ylMRe/xS77xdfALzaDIfJBR+E8uxrY9mVWhu
677tdFi4KpVQlKtnYC+gCM7vgzuIGVzf2imDMgBdVPa+Ib2VEpI9rNGY+fWjOic6
N7HrxThS9iuXhwTLfXV7bR3FBHx6wSIPp1FFFvhrJZvJWmzVn/FyuSfuDTAjau1D
JvnYxIyg3JxNjWNzvVc7cgiEAut/olOuuclLVhQ47j+eyqvpcW+ENiCQoLqnfOIF
4Z2cDUHjG807yF2yIwxZmRqXni3rvCN6jzyLYtRWq+3i2QuRvD4U7wJn49c2Lv9S
uCt5wrnu//6v64XS4j87YlW1kRPbNtoQHoJgodNeowI+Xno2jVc=
=SBV0
-----END PGP SIGNATURE-----

--=-B3PO2cYUQr+vYQAFOa2U--
