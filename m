Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-635946-1518032797-2-8158073453416111536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518032797; b=edod/QVFWJky/qXlCgJ0FvNyICYdqbzeJos3ZMNO9nEKoIh
    mkt0Tt2uUZe03IDWnFhSB96qMwOar8UBrr5GiS/M0AmMKEREnp1i3wrQXs5yEJBf
    J04GZ46KXc+AadNirxTLVb/qJjK94j3tGt7x5quFcrYSxFTZVQ6HL97zkia3H3qR
    EeSPZR7QA4Q5+vOrfVIkRiwBjfOfdQZuBJWehRYA5IbyaJ9TlbWdULG+guVE5Ovk
    hR+rBlZ/tO82KGcWR5nMDcCuUYhphfDgsiS01/slu3Hj5jAeg0eL2ZGt4KMbnCyv
    1535iAHP+eTc0gENMVXQPJX4nfYFDxUjyjft1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518032797; bh=HJp0e2iZFVHwCSLK2BdBjUvlbF
    /s41XU7MNcR1FNtIQ=; b=urNaK/IWCaW1PDuvTLK8bzoDH0vuTUXI82uebyH9Rk
    JxGp3bVQUdSaz01VWqVMkyGDIrpM5j04+BxE73Ojyg7RewJtR3cVXOy47Winxg2F
    90YUx0MlPnqhHXTctmV3eZPx2KP4cW78JXq8GYOmUFo7727Vve/Za+DnO8tRc9AO
    m0w9lSEWaHt62W8jFUTncpxq168q99UZJeXg0Pi3Iz8lnYrjWizkhQZp3Px2F+ll
    o9wJHWVvymRKronHwSiQ0P6Q2asBNLucmy/7KLsYCGa08jq5mn4qBfh0UjgDFesc
    rES7M/6qJ+wTq90K6SMNrd5TsL4ki5AbDBODoHXWldzQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeBGTqe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 14:46:34 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:54018
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGTqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 14:46:34 -0500
Message-ID: <1518032786.4024.1.camel@debian.org>
Subject: Re: Regression for ip6-in-ip4 IPsec tunnel in 4.14.16
From: Yves-Alexis Perez <corsac@debian.org>
To: Mike Maloney <maloneykernel@gmail.com>
Cc: Mike Maloney <maloney@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, debian-kernel@lists.debian.org,
        Tobias Brunner <tobias@strongswan.org>
Date: Wed, 07 Feb 2018 20:46:26 +0100
In-Reply-To: <CAJegeYkqg97ZyiJRe9ZZAk_C_KX_NrcmuK9SRrEbLzHMXfdv1Q@mail.gmail.com>
References: <1518021487.2100.2.camel@debian.org>
         <1518023139.2100.7.camel@debian.org> <1518024182.2136.3.camel@debian.org>
         <CAJegeYkqg97ZyiJRe9ZZAk_C_KX_NrcmuK9SRrEbLzHMXfdv1Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xcjzKwrRtayp0DcLflyt"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-xcjzKwrRtayp0DcLflyt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-07 at 13:50 -0500, Mike Maloney wrote:
> On Wed, Feb 7, 2018 at 12:23 PM, Yves-Alexis Perez <corsac@debian.org>
>=20
> Hi Yves-Alexis -
>=20
> I apologize for the problem.  It seems to me that tunneling with an
> outer MTU that causes the inner MTU to be smaller than the min, is
> potentially problematic in other ways as well.

Maybe. I tried with removing the MTU setting, and I get (on ping again)

f=C3=A9vr. 07 20:44:01 scapa kernel: mtu: 1266

which means I would get -EINVAL on standards kernels, which is not really g=
ood
either.

> But also it could seem unfortunate that the code with my fix does not
> look at actual packet size, but instead only looks at the MTU and then
> fails, even if no packet was going to be so large.  The intention of
> my patch was to prevent a negative number while calculating the
> maxfraglen in  __ip6_append_data().  An alternative fix maybe to
> instead return an error only if the mtu is less than or equal to the
> fragheaderlen.   Something like:
>=20
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 3763dc01e374..5d912a289b95 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1214,8 +1214,6 @@ static int ip6_setup_cork(struct sock *sk,
> struct inet_cork_full *cork,
>                 if (np->frag_size)
>                         mtu =3D np->frag_size;
>         }
> -       if (mtu < IPV6_MIN_MTU)
> -               return -EINVAL;
>         cork->base.fragsize =3D mtu;
>         if (dst_allfrag(rt->dst.path))
>                 cork->base.flags |=3D IPCORK_ALLFRAG;
> @@ -1264,6 +1262,8 @@ static int __ip6_append_data(struct sock *sk,
>=20
>         fragheaderlen =3D sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len =
+
>                         (opt ? opt->opt_nflen : 0);
> +       if (mtu < fragheaderlen + 8)
> +               return -EINVAL;
>         maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen -
>                      sizeof(struct frag_hdr);
>                         (opt ? opt->opt_nflen : 0);
>=20
> But then we also have to convince ourselves that maxfraglen can never
> be <=3D 0.  I'd have to think about that.
>=20
> I am not sure if others have thoughts on supporting MTUs configured
> below the min in the spec.
>=20
Here, the MTU is not below, so I'm not sure what happens.

Regards,
--=20
Yves-Alexis
--=-xcjzKwrRtayp0DcLflyt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlp7V5IACgkQ3rYcyPpX
RFvW8Af+OCN9KuYMrqEiMKNEa3mpucZMOgWDQirN/pH+NmZqbr2Dfv1GaBoKbuZT
inIAoati6lE43Kg87J8nii9mwTFQzS9F85KKSWoRZsVKAetXYNOpah9tjVeAG4yU
JSrKsSqwyfPb3nUMUHnUanZDBweBvltMu7aT6BscRg38eJ4pUE7xwMk2Zt3HFHMW
IcPX6buiOW1rdfP27l9CGusFMdiwSizXYxGWQKw7XFWm0gawOrw98kAowiHK6gcd
4Y3jpZA6QWrcMHHDQa1Y4BfE8+luLuEDegL8mCh15QlNcs9BIm+ZtZozAVE2JEPR
UAG9yRcNrKSMxEGZuH9ce5VTEeQm3w==
=Bj06
-----END PGP SIGNATURE-----

--=-xcjzKwrRtayp0DcLflyt--
