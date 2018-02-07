Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-329116-1518023150-2-7387705916763536193
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
    t=1518023150; b=niD4Yczv5l25d9CVklAlJF20zDJIlkttHeIIJQQp7xfjvGC
    jyVjZbIzdQlBPpMgLZptNx6FRQyurzxrkyUeUPf6VjGfrLdQ2SrDfNvgJYnBgSFk
    uuVJxFoSIiHzH2uf/EdON/yRqD8s16iDfoBmGvS3FrqEIQl/cPKm1bPY1k8uvdhx
    HAETbnyXkCgtTNCOCdpc7FOQkFOFsvVHzYJTMaHyGIu99Rxe8EwV6WksU3YR84WW
    S26XdDFxXXU7Jij8H49PrKJrQgk6Z65L1SYdKWz1Gk2l8JPrQ+gdLYelWDWtnpTP
    DT9x+hmJ3CD/g3kp90vyGyQo12q2CSWBcmC8Xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518023150; bh=p0cAtcSXR12nr8IFvpf8G7UMyC
    6CF4Rge+ZhP+BykhY=; b=ml54lGaIKsLfNtnVH1xoaOnrd3nvwDp1d71mMPXS2z
    EMCIUaTMJA8pRGL50WMmR404TRMG4yFHgSuLp7anoP/el+YlHLAKlGNNOoYmkHvs
    ssheL6iJwghEVSWl4m2t1/KNqjCoQeelE7w7YEFjq61U8DvuS4UTocAUtEHl1NBI
    h8ndbO76lzNXmNg6XAOioqVg96bU+KqcxhxO0uabVBZRF1psTA415HNSizFLDmgj
    JQ5uYzU00nsJqljV/gU4QRbHaKVx7qyk1hrPX5jfZehKwBPP/0lmphaGz12zxLqt
    xEF/dJw9fOBHGqT9CD0H6X5IxzP+m0ztiaYPcWMEBaog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeBGRFr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 12:05:47 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:51900
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeBGRFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 12:05:46 -0500
Message-ID: <1518023139.2100.7.camel@debian.org>
Subject: Re: Regression for ip6-in-ip4 IPsec tunnel in 4.14.16
From: Yves-Alexis Perez <corsac@debian.org>
To: Mike Maloney <maloney@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, debian-kernel@lists.debian.org,
        Tobias Brunner <tobias@strongswan.org>
Date: Wed, 07 Feb 2018 18:05:39 +0100
In-Reply-To: <1518021487.2100.2.camel@debian.org>
References: <1518021487.2100.2.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y8aIgBAAEi5nr6gUuEcQ"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-y8aIgBAAEi5nr6gUuEcQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-07 at 17:38 +0100, Yves-Alexis Perez wrote:
> Starting with 4.14.16, IPv6 traffic is broken. When trying a simple ping
> to an IPv6 address I get:
>=20
> ping: sendmsg: Invalid argument

I forgot an important bit of information: due to the way routers usually br=
oke
path MTU discovery by filtering ICMP, I'm lowering the MTU to 1280 (so exac=
tly
  IPV6_MIN_MTU) when using IPsec.

The MTU is configured by the IKE daemon (strongSwan, thus adding Tobias to
CC:) in routing table 220:

default via 192.168.28.254 dev eth0 proto static src 192.168.0.129 mtu 1280=
 advmss 1320

I'll try to printk the mtu before returning EINVAL to see why it's lower th=
an
1280, but maybe the IP encapsulation is not correctly handled?

Regards,
--=20
Yves-Alexis
--=-y8aIgBAAEi5nr6gUuEcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlp7MeMACgkQ3rYcyPpX
RFvDVQf/Rwp34RBjpnoH3yV0Nrl+VP+ImCLTrtB+p/jItLvUJtbXOT7SBYpOrm65
icvr5CXMOGYp66Rb3q2xXlhfurteiB1HnlSDYw4X5x9jcx/GhU6RDZQ/fUBW91/0
jLx68QQ6Iv7nYoAEaFUy6Rv+mCLZsoS1pHsoqgfIE6eRpb2wtZQFeXaWhYGk0M7W
FWrvSGDeGngYkb+dvqyq5KsJwig3fTV/A1x0hfI8Pa6hhzOaHYJSrkC6r+kRyGhK
haxQFgVA42uc50I01mp+04Hk76ltoX/OSoUaIPIL7DfcyyHGHrj+prlYlwoW5tWA
kcDotjz3pbQmIcyCK0YlYuDYO2nZ7w==
=mt20
-----END PGP SIGNATURE-----

--=-y8aIgBAAEi5nr6gUuEcQ--
