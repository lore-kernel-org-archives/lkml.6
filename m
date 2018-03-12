Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1187825-1520884425-2-16900639541247425169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1520884424; b=QvpBTijosXaQRFGAqpAIP2owCH2nEhZc0i+a+YMz9Vd6jtK
    PZx9hJoemD83XL97LPU3Y7e73pq0evy2/1QKnpfZa6ngyAzzcCP19hArnhXo26r5
    Oe2WG9UJXek26U0RPI8AzYKQJCBzqws2LH1Glgr2BpVm1XesxuMEQ0O6fevjtXnD
    LhLrDa5tgeaq2Qhzrj8j8slADZpE6Q0hvN0VRGnmwmbvdVWYFvqmPZUY/gkcceAW
    0f1hE7lVTgE5/ixoUOIHDoe9ecRbrTppH7yEl/YS2zeecJEawZBhhgm6x4rhF3e2
    ghA/HgQA9hnrVQ5lIRH5ce35HORsBDr/tlixauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1520884424; bh=Xvu5T9ngWbu1yB5qf57Ql7AhDG
    IOYog7GHIGMEOqw7E=; b=aCiIqucN+tYABsLtaUqgzL4gAhtQ2KThkdSk24YNta
    rfUwhZCKOEtnpqtl5TwUvfF6Bl78KWQrfRyESf14FdtP/+uHbq4WUQfiAkqHIkJV
    PV4c+GHVGgAMIB9Kr7yzq5ABArACQn7usj04LUUgZRFk9rZU4Rd2dFUQh43Z8VuJ
    RhNbnS7B1gJcjjj9/DZiZHTlTE0k3UXjONUaZMCoYbgEjQX+fstfIvfv0t1ZNxDJ
    Fxl8gqkZI4XvVAOdNtuYqs0aVsp4oBTuLrGgNOEBpcwHlDc3RVLsZDV01BvL1oFO
    90C7W5kWXiBfftTF0Fk2LzOXKKF+cXEa5Y6iobO11lkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeCLTxl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 15:53:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48885 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932190AbeCLTxk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 15:53:40 -0400
Message-ID: <1520884416.2495.95.camel@decadent.org.uk>
Subject: Re: [PATCH 3.2 000/104] 3.2.101-rc1 review
From: Ben Hutchings <ben@decadent.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date: Mon, 12 Mar 2018 19:53:36 +0000
In-Reply-To: <20180312145444.GA3917@roeck-us.net>
References: <lsq.1520823814.606620518@decadent.org.uk>
         <20180312145444.GA3917@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-cb5JYbF12DPVDMIT3ZYo"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-cb5JYbF12DPVDMIT3ZYo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-12 at 07:54 -0700, Guenter Roeck wrote:
> On Mon, Mar 12, 2018 at 03:03:34AM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.2.101 release.
> > There are 104 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 86 passed: 86 fail: 0
> Qemu test results:
> 	total: 73 passed: 73 fail: 0
>=20
> Details are available at http://kerneltests.org/builders.

Thanks for checking.

Ben.

--=20
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.


--=-cb5JYbF12DPVDMIT3ZYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqm2sAACgkQ57/I7JWG
EQmICBAAnakCAt2P2Iwke5p4vhFquoBEATCw98NuWpkLazobudb2nCngtrJp2zG0
LCB63200GXOjMcVzwjr2qjOZvs5yaIj2ZjMbLI89xE0AQYnikZTa7OiPItB76TQB
wiWRppZVk+wIODlZ6JGtbq/x+nVghZzvVrIM/Oq/tAjQWAGxM0LdqfdZBubu7fjn
YAF0KndFwDhKXJ8KMixCThz1bjcWDRnqONUqqXTDgQej0I38hCHNdc9OdIPx1OZS
w2EECAexxRwrdyCaOTur4EKUHWOlQL36hhIH7PTNq45YWGkzfrNPCOHwkcNnjgFA
oSMEhGlgDTawhuPVpLaqufYH+6aZq0EVs3pCHZ91cMgfO/xULmvSZ1lBkB0pTmIC
fdxRisGEQ7/1fTnq3xAGaAUuR/Yt12YQA2TI+o0j0aVNkFD3u6U+7/XUhj5qJaKL
PUsZyzCa5pmxWXSGWZgb0nj2vufh4fbGK5cRt9aZmDI2/axdwl6ZRJQeO/vxoeCK
qOi2kwh8zfB8y2g15rEbhc2W7D+SQKAlrTM62yRH7TMB4BsHxWXdvpBGu/i4HzCT
ZZt8hCcsrX/hV3VZsGEWSPBZWccIkgrO7b8jSmx2lW8teYPhLvVPCDzukE89PSMH
xKc868z9qrAjPjZXs8AiZlpJoYJNchAi9vp/c6nGCM7bDRjaVjY=
=z1KG
-----END PGP SIGNATURE-----

--=-cb5JYbF12DPVDMIT3ZYo--
