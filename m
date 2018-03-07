Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907620-1520387861-2-7843789439599568305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520387860; b=Ssq/Q6yjqlgws4E03vQ6SnNOgvg8ksudswiI5FGYgqGQMM9
    PM4u8cEUyAoOiP/J2IP7LkvjflLTte7dJ/MB4+BAxYgukT8h24BVA9R/Ae4UJWPz
    PnYe7ipEtkh/WhGxFF73WsbU4VsWVnNiDdynP2WvAH88FirmG2pvJuQbrYlubrI8
    v7wGvA1knWDb18KN656v8t/Oip0VD/9BecCpO27XyeBZzfq0zgfPlwws3S5tVCsv
    diaJ2PVU9ef95sgXAp2IjX1DHKKK9l5REZoyYwW5Nbg3CJqjtOpvP2LKvC1GwnwO
    2oocnEnh8cT0uryBOseQdYqZbzVKXE1CS1x4ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:cc:references:from:to:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520387860; bh=U1Xp0UF9N8kLZ1t9cbVstb1XyV1cWvJ5k5eZsg
    J22ug=; b=swtZ4jR4lBLTp8iZfmamRS0ZRBFY+5BxxgiZDttci/zKec9qq2M7M9
    7OpCBdgJMgfEfC5RAzbQpgKw+Edy4Ja3lrK+biXZqJ7QNuUSgCPu3mCK1yoE7DWf
    9hHv299PUWJSN7wdGjcSyqm53FHwjkFc+Vp5JYvSN0vFPeG7ymVL4B6nsjB1+LmS
    nVJErqpp1oFlctA60tNpFWAJx+kUj3BIf6exe6TS3SyC5GyisRyjwgL8W1SVrLqA
    XTz2NeD0PdZp4MzpRZiOhVNGPqwhqMKdtK485B6xknUcbHBLsJ4vBa4BmZYD1Gr8
    BF9rTalBElrxsmYXGBtNP1elPqKMjDig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sigma-star.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sigma-star.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sigma-star.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sigma-star.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCGB5i (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 20:57:38 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58394 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeCGB5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 20:57:37 -0500
Subject: Re: [PATCH] ubi: Reject MLC NAND
Cc: Pavel Machek <pavel@ucw.cz>, Richard Weinberger <richard@nod.at>,
        boris.brezillon@free-electrons.com, dedekind1@gmail.com,
        tharvey@gateworks.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr, computersforpeace@gmail.com,
        dwmw2@infradead.org
References: <20180303104554.5958-1-richard@nod.at>
 <20180306231805.GA28183@amd>
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Organization: sigma star gmbh
To: linux-mtd@lists.infradead.org
Message-ID: <a95e4eaa-8890-a5a6-1512-c9800ee2a37c@sigma-star.at>
Date: Wed, 7 Mar 2018 02:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306231805.GA28183@amd>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VJf6WKdm3rDswI30wYXg6zdsyWkB3QgH2"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJf6WKdm3rDswI30wYXg6zdsyWkB3QgH2
Content-Type: multipart/mixed; boundary="fQ0ClPwfwkUs8jTBCVa8trd4qWVAOb8vp";
 protected-headers="v1"
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: linux-mtd@lists.infradead.org
Cc: Pavel Machek <pavel@ucw.cz>, Richard Weinberger <richard@nod.at>,
 boris.brezillon@free-electrons.com, dedekind1@gmail.com,
 tharvey@gateworks.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
 computersforpeace@gmail.com, dwmw2@infradead.org
Message-ID: <a95e4eaa-8890-a5a6-1512-c9800ee2a37c@sigma-star.at>
Subject: Re: [PATCH] ubi: Reject MLC NAND
References: <20180303104554.5958-1-richard@nod.at>
 <20180306231805.GA28183@amd>
In-Reply-To: <20180306231805.GA28183@amd>

--fQ0ClPwfwkUs8jTBCVa8trd4qWVAOb8vp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/07/2018 12:18 AM, Pavel Machek wrote:
> Now... Yes, handling flash is hard, MLC NAND is worst of the
> bunch. But...
>=20
MLC is not just more flimsy than SLC NAND.

The real problem is that on MLC NAND, pages come in pairs.

Multiple voltage levels inside a single, physical memory cell are used to=

encode more than one bit. Instead of just having pages that are twice as =
big,
the flash exposes them as *two different pages*. Those pages are usually =
not
ordered sequentially either, but according to a vendor/device specific
pairing scheme.


> Read disturb is not unique to MLC, right? Happens to all the flashes,
> its just that MLC has tighter margins for error.
>=20
You don't just have more read disturb on a single page. Reading one page
will also affect the paired page as well.[0]

In addition to that, you also have program disturb. Even *writing success=
fully*
to the upper page of a pair also causes bit flips on the lower one, affec=
ting
completely different data.[0]

This could be addressed using the experimental ubihealthd that crawls the=
 flash
from time to time (at UBI level), making UBI notice and fix bit flips.[0]=



> Power-cut. UBIFS is just not power-cut safe, right? My notes say that
> power-cut during erase could result in flash that contains all 1s, but
> will start showing errors very quickly. Again, not MLC specific. Can
> be solved with battery...
>=20
> (And yes, there are some problems specific to MLC, where parts of page
> need to be written in specific order. Not sure how it affects
> ubifs. But it was not listed as a reason for the patch.)
>=20

Both UBI and UBIFS were designed to be power cut tolerant.[1]

On MLC however, if you interrupt a write access to the upper page of a pa=
ir,
you will also corrupt the lower one, i.e. *data that was already written*=
,
which is a serious issue.[0]


Richard and Boris did spend a lot of time working on a solution for that =
at
UBI level which would currently still require a lot of testing and fine
tuning, but sadly we ran out of budget.

The proposed patch tries to prevent further bad surprises for people who =
try
to use UBI and UBIFS on top of MLC by making sure that UBI _refuses_ to r=
un
on MLC (at least for now).


Regards,

David

[0] http://linux-mtd.infradead.org/doc/ubifs.html#L_ubifs_mlc
[1] http://linux-mtd.infradead.org/doc/ubifs.html#L_powercut


--fQ0ClPwfwkUs8jTBCVa8trd4qWVAOb8vp--

--VJf6WKdm3rDswI30wYXg6zdsyWkB3QgH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEEwY/cjyeWErqzVubvOXcPHQaAtEFAlqfRwYACgkQvOXcPHQa
AtGUnAf/akx6/qBxZYbO6ODBoH4M7ULAPQVd2k2esYpHRWjjroJJTiD7TEd6phTD
Y4Bubdf1FaqRI8kSGDYLFdSMhBUjtWYJucPJmjImBnvjubS++SybjO7lSi4y6HMw
ndzaHb1OwbuBAASwBrNuwqYsuIbLWHxNOWtxzJHo8iv46Gd3MPY0xBocerbR8n+A
qjXN55CWa1huLiHNg7pp4zPpTW24eiEnJBLhqa/AWCM8lUXfXRnqF69rNr7mc6Y5
ZQxWi5TqZrNqKipQFS1KJ11gslQc4bJ8QYmeaAE9NBC3vMxggSTUveJQXMO3d5sE
W/EFXCjgPdzjZRX1WkODjmtKOevyxg==
=JTRb
-----END PGP SIGNATURE-----

--VJf6WKdm3rDswI30wYXg6zdsyWkB3QgH2--
