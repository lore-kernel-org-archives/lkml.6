Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447065-1523351438-2-2031567202649397612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523351438; b=wGuBlkCsfnBe7QLsQiJLtgN9bmu9AlXjuRXqCaQtlmY6wjDtop
    6o/jHZqvGuDV5AhM07I8MtVXfVCO1S+rHVsJi+SERcV/S3OcH6N/HqwbXJiZzUmX
    lehPj5oMlXJnpmQCKbt3ggtqIhzPRiIcGDt1I4MZkYc6y1hX78dcKKZHn5G0Y/tw
    dOVIYRKGYSDAxTdl+PzC3koF5YHZ1CpLLVb0kS78MuaeawZ1Yxos/L0DIRFgyX/6
    36HhwJkWfntzVRFJmiVFUSQmbNPlDV8QQvXBP/b/Tyw28kzNEhwMnFMXhscYZvfK
    sh9FdANxlsLbM8oMJKJk31BuL2/cpvehLS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523351438; bh=0FqBM1+gSz+lvjc9Jj64ksvGPWduGf
    yLkQRKoUqpnCQ=; b=FV3vIJCi12R1FSu8HIYFF06OX8QUZpgh2Dihe2uWv3vJVd
    P26XRJCgMsDn280LuPYNCQl+wbueQCR4x06w1FjmKQusO6IVY/A/Xr9w1ODNglVF
    xXhzqPA5u+dMdC32n0LgArmnBQGG80/E+lRK97kya1IbxZSjnd94aqs1yEYF8ClH
    8Nl0gv2OhT+WzRBpPTyLT9PO4zA4HyVmGYUlM0KOA0pG5JhazoNgF7528FKAFgbf
    lx+mXxTeeTsMUD9jWQFNRqo0lpLyGU/BdDQo9nPSGq5mjgQvUpPnoV9gYD9GWB/m
    LhqaBwZRkl0xs05A/nd6zBdsd082S1OZV2blPhCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGXVG0yZj3CBGxP4RGQ3tIHcCz3hOdCtGH7Rl0yoBkmuSiGJ5usTOn/WIDCewxBAJTt83f/8t9W05deB46UN0s2n71jiZQ1dZ2xyvKVtwQzfagornD8X
    x9J4+/JNdv+qhqEbjeCj3amkszBvilfbvhqD8OOgbzplqe3cPLQWG8lQi0TJCzGGQupCgTMrZE/0lScDViEuudho3lh5T/vXoBIFfws1965RxqpBvPsRtWdN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=r56wvsoRNKPQF_Rh30cA:9
    a=CjuIK1q_8ugA:10 a=51gvEHhNqAmumGMN5noA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeDJJKL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 05:10:11 -0400
Received: from sauhun.de ([88.99.104.3]:38612 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeDJJKJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 05:10:09 -0400
Date: Tue, 10 Apr 2018 11:10:05 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: Jason Andryuk <jandryuk@gmail.com>, benjamin.tissoires@redhat.com,
        andyrtr@archlinux.org, aduggan@synaptics.com,
        stable@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Message-ID: <20180410091005.2cijsmavmay37d7l@ninjato>
References: <20180404225643.6b40782f@endymion>
 <20180405183824.13333-1-jandryuk@gmail.com>
 <20180410093836.1e39d9d8@endymion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4t4jerzb3qp4osn"
Content-Disposition: inline
In-Reply-To: <20180410093836.1e39d9d8@endymion>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--m4t4jerzb3qp4osn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > (...)
>=20
> Wolfram and stable, please hold on with this patch, Jason and I may have
> found a proper fix so blacklisting would no longer be needed.

Awesome, thanks Jean!


--m4t4jerzb3qp4osn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrMf2kACgkQFA3kzBSg
KbYWvw//Q9wCGT6qItgdGnVZHdmaYSrpjjaIXDWiFA17oLAb8ec1fAgKp728yxxz
FnHFtwiRcggjbHm+aagL7eLgzT1qslalUEcVDx7VvXBd+TjaGO037mh0pxrRBKOF
CVmY6rw1S7UbDtLiydr8W7mg/INBF8iFfp59UHOEPlcsv8Q/GBLM8hhVFUh7NvEg
P20GScKfNvXxhT6HewD/uD9hy1fIJj0CUsr5MFYIMJWmV00VLKkLaa0ZPeix+1s0
VdRmWNKYQZdbWjD+KyhRhCFlLiPu0+AQocNPoNGPR1w9SGsZBCAXjtD/kgahd57V
v+qfljgjkc92MI5hW13+dqg+ttemj6vJPOo6YW/JQE+ju2GtUyu6+XmvBuQFe5eL
d7YMKDsn7GX7uP8evm4VqpH/tzPBed+W4E2cVE8xUB1yimIG4bHIdgr8HokTSmMR
mCXhuAou8Fi9oTylwMqeB+/7JDAmbF3NKsXmDvFucDVl7ozsUAvAfpOpsIqBtemv
T0fhoPJxtpuwITGVICVyRZDEv/soiuEJbgKJrpRj9tdBcnGjsGfDRYBdlN0aT8jL
qXbAkoPJWDy+L/k7UC5+PV4uxDkLIX/UwJGgFq7Ush1RGyoPYd8VeF8R8Tx55Dlb
nHPQ/mrNeG5Pri/e43JSlMsD62rLTUm8iGQZituzKC+luYuaR9A=
=CGVX
-----END PGP SIGNATURE-----

--m4t4jerzb3qp4osn--
