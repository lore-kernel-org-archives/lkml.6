Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2510764-1520532048-2-15507892135054812761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520532047; b=vcBJ/m8vt/p1uwR/s76VGD3OVZZ/qiLxY52vghoI+cjPvUv
    madyrpW3ZbPjAQPWKdGLT75X64XjPDJpVtbA3/eoToOlMg/PjI9Gr6ysFcg70TzQ
    jcuQSubj9/i0XThjA50Ql7DUju2TvINKo0wHbsU83jd2hE78jEGuW/TIzt2lTdoe
    34aCBqblXndRR78LkjXYL6QN5eOMoDRBizZfVJafH29dh1bninBGNqkw5osK/e1+
    W24gDqPQ1/TMzOC8/zPhO91rysAn5PDKxrXJF/4I1iyMJACD2yKECW4MrgaxnYKj
    TwNc5L+npPhKX5DuuGGqvuGn3vX/jzv5mIpJp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520532047; bh=eL1hYdIL+roK/EBOTCjiBnUEqOrIIRS2eTZsNp
    +Bwtg=; b=OZ+sA677+3r1rOQGbl+fzhiCk+edeD4YnoHYiYrZLUshIiBBwOhddq
    wLeFvfPqucRXHvMT6HUIw9H7EhBlF+lTWeIDW0s26Od9ZUi8lPSyobAjqheiCLMp
    BzA8KqMBiLdTRDA+3hwJicZJu0BNSdog1DlABy/XUbsHdvdh2Q8xlIRHB7A0CSbe
    sKlldGJwVS17A+D2yD9EpLHvBFw0R6Sh8l7PC4pQCS1er8jCNnU7M8TJJtVDN8pk
    Xbq3y4oKiEz4uOxDC5m1LYbPGMa3eswxdNFFtM636fXnJIkslWVi8bWXDvapg+oS
    OkfSYUneY8oPi0oMRIqu3wcWma/IYSLg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936094AbeCHSAd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:00:33 -0500
Received: from nala.villavu.com ([188.165.243.101]:47099 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeCHSAc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 13:00:32 -0500
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
From: Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
Date: Thu, 8 Mar 2018 19:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308164613.GH14921@uda0271908>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hZm75pODmaTlC2rCo1648J4tazCEjJbCy"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hZm75pODmaTlC2rCo1648J4tazCEjJbCy
Content-Type: multipart/mixed; boundary="Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
In-Reply-To: <20180308164613.GH14921@uda0271908>

--Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/03/18 17:46, Bin Liu wrote:


> No need to flush, the work is already cancelled at this point.
>=20
>> +
>>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>> +	musb_platform_exit(musb);
>=20
> This can be move down to out side of holding the spinlock,
>=20
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>=20
> to here.

Thank you - with I've verified that it works with these changes. I'm
surprised, because I believe that I had tried this already. I must have
missed a step in my testing-routine.

I will send a patch shortly.

Cheers,
Merlijn


--Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv--

--hZm75pODmaTlC2rCo1648J4tazCEjJbCy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqF6MAAKCRAGN09rynK8
WnwlAQDgI+riQNOpGw/F6Y5s/lB5gMX/BlHIaF/xZYU0qhhGHAD/aH7m4PUJjiXH
vhZzxUJi3W4oTueuQMh2b5UeRmpG/AY=
=A+1J
-----END PGP SIGNATURE-----

--hZm75pODmaTlC2rCo1648J4tazCEjJbCy--
