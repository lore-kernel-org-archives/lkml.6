Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3048566-1520547496-2-5107205180940003898
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
    t=1520547495; b=PXuIqoT13R8ZDV/XGNEHfOS+LXLfkdWIkzcldDwe3pwgb7q
    CziwnKNoQSCr4W7xrAxeo/y4jFWRyPJBg4lFEmiWc/M6IOkrujRutXBXWptAMk9h
    N47soNXA2KKlSk/fSz+Xl0TQCU81vYbnRHBqf7RQH11e9p2QdVjyrKeJrPuYX0Nr
    BxMLFddIdDpF9OYgE+yg1TrQlPQBprIjJ16cFWlgDms7fhOhhX36PQ5gNrk4BLDJ
    Em5ozrjqnbnR/H/VgCx4YWFdexqPJZST4VdJLQpLNnYT0HRWDRnYB61341PsLHzV
    EZXc2nnNQ9waMNYSkgN2Mf8o8SrrtEaHO13MMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520547495; bh=LqhBOYHwLjLe16bLeK/ws4QzNiwLkELyVDRUli
    jeDuI=; b=E5B+4gOt9ZBHqLv/5pRwzHztrKGgTnYATHSlsUsk9JB8qnjr3MU8ej
    HzFl+rfpLiR3vbJ6dDuTEDjhp5QGLSmpMBo3boD7bliwV9BkEUrQ3j1udhtjcbOv
    js6Ofq940WIrTOvQE4Ra0UvV9ytLifncdy/t9jqRMdGo2pzZei/b5UNWaoajJEN/
    pekLUpC4Vr98nDLkP0gEP1fqMs7Jr3fVlsmhcDGcqFjd30qkeaqGEKUMiK/w2j3Y
    yjhQmvtc4kWvaS++wRL5+VpYmdr4JQ9xwIS4CoaxMFI45GhpoexFAuYmc8t0Lh75
    KNjCCFypK+KUlhgEppsB2NX1uEtI9/mQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751185AbeCHWSD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 17:18:03 -0500
Received: from nala.villavu.com ([188.165.243.101]:53361 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCHWSC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 17:18:02 -0500
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
From: Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
Date: Thu, 8 Mar 2018 23:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308211525.GJ14921@uda0271908>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk
Content-Type: multipart/mixed; boundary="k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
In-Reply-To: <20180308211525.GJ14921@uda0271908>

--k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/03/18 22:15, Bin Liu wrote:

> please add patch version numbers in the subject when necessary. This
> helps cross-referencing.

Will do. I naively assumed that the first patch would implicitly be
number 1. Will send out v2 now.

>> =20
>> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>=20
> Does it solve the issue if not moving this line? I'd like to have
> minimum change if possible.

Yes, it does. The only reason I moved musb_writeb is because I
understood you wanted me to move both (per previous message: "This can
be move down to out side of holding the spinlock").

Thanks for the tips.

Cheers,
Merlijn


--k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA--

--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqG2jQAKCRAGN09rynK8
WtJ4AP4gr4QRu+iZHEY1fP6vDc5hm7+e6TEtFNkIdmwFdCLXoAEA6RqkCUMx2v8o
ncTfy4KbWPE6VufCw2lfB/2fLkWVWQc=
=Uwkz
-----END PGP SIGNATURE-----

--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk--
