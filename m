Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524727616-2-7089168913228881748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524727615; b=ld8xLRujd7UUDTtO4XJAjG2eNpRM6dXaVZpjLGEhxB9Xt0dGs7
    Ra8HzDztA3l6tDifPzzos/ocQD2RccXTefGq4gGM1z+3wYxXmE2p5HmUEpS1Wgyo
    9XtGr81z+uRXVkDVYtD/0+eo3UByEmih/eKtfv62RWM1WkYdnJ74P8lan/iDCoFu
    vDAPDe9UNFJutiT18+R7dJcYE9Vq7Dei8SkEcZ1hk+yaBhm/omUKcO+z+f1F0s94
    vB9jZ3CDBSYxQJPFWHwEAjHtRU7X0JOW3uTdWOpxpXcCYkLVQ0kOoZfkXAQAQk0X
    L6m7YlFkdbv4x4ZJ71Oo8MOyqwgIDSQelNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524727615; bh=ltLi9bHMCKTZ/IG0F5YscLqS5gPZsA
    ZzsxZq9CLpjyU=; b=Yt+yrJ2ykQdLsAIxXMuQFtHkHT9D4cEucwlT7rwp7HfeLP
    yKkGaYz+1VdtAIJ+KlvL0EwW28/NkXSokUer+h+rMzOGlFrF7sodQUqIGyhZ9MGY
    PhrHkSGxOMg9CoLcTdf27QSZ19Go3GbQryb4VcfBDKpy0myWSJYh/y5Eu8SaUpDe
    lq8h4BHn9TwJ+gP7pkhX17W5GrWWaZSZFjQj7DFj2KU3p8/UDaqtQbtLaF4jPg/x
    fXaLvRWGk9EuGknK61QNFJ+B4IIP/pScie2/0grB42Hy1Be8mL4qzzCs4ZUXDqU0
    oo7VEL/GTBILKST9dN+9UbT3DvcYiTnKIDth8fYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAHi9gg+YTS7/DA+yR2UxxOHnrZz3xP6d10vzqhdl5IXuO59fWOfMXssiQvWUd8EkAsjKMjjhNMnuHPpJxugT5mC9M5n6AVXPhIB2kuv87hY/HTOQ4OE
    PY4bb/Lc6TqensY5L/uaFUnmgGWVK8unheO5bx1IjuQHRjqk8Waj6NMp7ylmYNpTdj8qm+2q8UF4ug6o4pcM4G1xgynyuSdbvDzkjCMfWjE7uEXIiLYFUteG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=zvHNgiCf80bTXUVc6uUA:9 a=7ZJ_7l-li9bharsp:21
    a=3hK6GTRA1I_0mbN8:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=YtFDDYWSUjzPbXN_zIUA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeDZH0w (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:26:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57048 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZH0s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Apr 2018 03:26:48 -0400
Date: Thu, 26 Apr 2018 09:26:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>, jikos@suse.cz
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
Message-ID: <20180426072646.GA31822@amd>
References: <20180413202234.GA4484@amd>
 <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
 <27926.1524148733@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <27926.1524148733@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-19 15:38:53, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > > There is currently no way to verify the resume image when returning
> > > from hibernate.  This might compromise the signed modules trust model,
> > > so until we can work with signed hibernate images we disable it when =
the
> > > kernel is locked down.
> >=20
> > I'd rather see hibernation fixed than disabled like this.
>=20
> The problem is that you have to store the hibernated kernel image encrypt=
ed,
> but you can't store the decryption key on disk unencrypted or you've just
> wasted the effort.

That's not how the crypto needs to work. Talk to Jiri Kosina, ok?

Firmware gives you a key, you keep it secret, use it to sign the
hibernation image on suspend, and verify the signature on resume. Or
something like that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrhfzYACgkQMOfwapXb+vKUbACffzbN2YGUihEbD3PcpM1b3kG9
rwAAoMO4Nkw+49H7bkdJebvsBuJXZDeP
=wRwy
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
