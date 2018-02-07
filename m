Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356697-1518024210-2-11864510436698772982
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
    t=1518024210; b=sRuwWtNzPDWeDsqASd4DnZiZLM3q9QRFkXXrjsmoR5Gjw8f
    U+dBjMP7YUOAn6vTEDtCDcQCt9A+HrEx+Jk/Lf9CriFpafBPmALbJoqRKVsb5mhR
    6pfMGW31GjqciKmd6Q93VuU+sC72ax1LhS2bwUXTnC2E1Rq6VltHbkKQD9/eExQi
    P1Ln/YibQjkOA8KWF2pUJZch6WAMhjDabK2L18ulKkPsLsqElEOvI7tA4lgRQRlw
    0eKTfhqos+tMohRGCjn33OYkqTMa1xM/DA3dVgnE7HTLcPytObxBC68t5CJQTa18
    E0Eqb+/EE5+tEd6sq3egu4g21w2eyuTmaUW+EGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518024210; bh=q6XWr0OmIWWB0iHGG77R/HYfUR
    HdwcDM9D/S2KVhhug=; b=UFVtTDXYwxAlmnVdTnsylqzpeD/4EChpc4RKmb1qT8
    9UNwZeYm+/B1uqYCAPmlDwZy1qzQSxAipy7mTaK8qILtoPwQQxMTqaxSW+TULLRH
    n84+K0zLoJUXdTZ7YdWixU2wg8cvGjPgD1YdQkZ5gOxRCBdKdplnd8yPOAh0NNGn
    dVJ/bU4+PnNDvveMiGLmws4AArF8I8qGkVjVILCEJ9MGhoinHDj7381Nuj7dFkFp
    BzkG4DDnpD8iEOAU26t5xDx+ffNEqPVmpOoqvQq01MhwnGDgYxdJV28z+oOwEOp1
    ix5ptTDDejsw12R3abQwpSvN4H5/Q96bmfLeH7bVNKgg==
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
        id S1754531AbeBGRXL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 12:23:11 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:52218
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754343AbeBGRXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 12:23:10 -0500
Message-ID: <1518024182.2136.3.camel@debian.org>
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
Date: Wed, 07 Feb 2018 18:23:02 +0100
In-Reply-To: <1518023139.2100.7.camel@debian.org>
References: <1518021487.2100.2.camel@debian.org>
         <1518023139.2100.7.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RiUeG7/sVUdT5Bwl3BXM"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-RiUeG7/sVUdT5Bwl3BXM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-07 at 18:05 +0100, Yves-Alexis Perez wrote:
> I'll try to printk the mtu before returning EINVAL to see why it's lower =
than
> 1280, but maybe the IP encapsulation is not correctly handled?

I did:

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3763dc01e374..d3c651158d35 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1215,7 +1215,7 @@ static int ip6_setup_cork(struct sock *sk, struct ine=
t_cork_full *cork,
                        mtu =3D np->frag_size;
        }
        if (mtu < IPV6_MIN_MTU)
-               return -EINVAL;
+               printk("mtu: %d\n", mtu);
        cork->base.fragsize =3D mtu;
        if (dst_allfrag(rt->dst.path))
                cork->base.flags |=3D IPCORK_ALLFRAG;

and I get:

f=C3=A9vr. 07 18:19:50 scapa kernel: mtu: 1218

and it doesn't depend on the original packet size (same thing happens with
ping -s 100). It also happens with UDP (DNS) traffic, but apparently not wi=
th
TCP.

Regards,
--=20
Yves-Alexis
--=-RiUeG7/sVUdT5Bwl3BXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlp7NfYACgkQ3rYcyPpX
RFt+PwgAx+VG1WqNLIKE3pjxS15vsQqDdP0GA2BqG98fT/viHocDeg6+zCDqvLnW
12Nv/Nr+OVMRcFO87aVWvM5Z4u/CXIzObjpzUYdV2NGBOIq/S22lnlZhi50eqY0y
vzl1us9bFdP6Jgba/JLT3UirJ2NbB39wxFO2aWaHO2v0zn0E1ETZF7jSNjkiI4xL
kVZcsNtlugX19qDSiNWeXbRfZ2jU7JI1Pmi6wVQX7MtrjdHAsLBrPaSwqMw1DmkW
9kly6UpafeT8Lw3WrvoXaWJSW4wvdku6lUHxa5ztxALNCpdlFqa+NmpxcoEIixtj
ttdGcJEUEBb2veDkaPunq4jIkGIW2w==
=SBA+
-----END PGP SIGNATURE-----

--=-RiUeG7/sVUdT5Bwl3BXM--
