Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2298957-1525339093-5-2121898723303587252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525339093; b=M4AWOOgdnvRifFptFg6CPYYZPk6RlL9YF50pvYSIhDHMtFnQVm
    822CfHOASPRD0mm/3E8VXP5ob0ioxkKTf9J+sK3LX1Sab8o9WI3M3AA/IWMZLOxm
    9pOZgIWHXFRmai9m/F5qwEhKt0jK9Ymu+ign1eWdR28RzsL7kILbOhzfAir2gUcY
    ov0hSuVYEhuCrRQWcAQM2Y2Iogrp6xHIOsEOJCZyvTrVpVnYvno0zuuvdiNKM8mn
    dFHu6p9SUuMaA77j/M9rfD5ylX2bc8EFdEFMMZDHTu0kXxlFXIWyiFG7GNXXNwpE
    F8fJc3zuPwj5w8wUH/XrHsrC1bOtWi2SDtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525339093; bh=a+E+uLoOV30yoFfxqN2db8bCrcJmj7
    YvwL1DHyplt+E=; b=i2GjpZk2W3YTDwNmsJH5Pq/ECZzmT3kSQrm5CVNdqjo8LM
    SNhbLB0lhnlzAC8DZq+XxSDbYBsYhfQOuzqclyY7xVXdayAAKFuygooDBVX6vIXX
    mZEkOr81/ylvPQu2ng/25wrtktwXTDqWQqoeQYJA9C0Ls39UQLBXNU0ly04220+o
    Ws3nkwCKeVUhFhDu/yRH5rGojzeDKMiOj97hPkJRxXZTSpAcYy7zVFnipwrqjhhv
    wYia1saogX9Sfx0JynEUTidMkCgPRVjLRb+0diVhgzUCaPkjhzI3vBfJTYIsMc4M
    CPRF+Mu0t1ifUwCcCiz1upGmpql/cHJFrGZB0Cyw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPclMrVfnyEmFD8nu4guWqj6a+TGNOv2oeWBUlm1Jm+TQijDSg/MuMAQeq7MwNbGGNiFbwN7NF76TyiluZiehCcOVLvIv+0jN05RZVb3pyStucO0SsFn
    cwaQLqasPSw3TnZsIChtCbKn49O5xZVxwHnw0ro/XySbBubTVzqcIJ2wLE+VPiPJiXXYH86aAZaDyEykG2l+3axmst45NHSF3ymVzpqC2XQvYRSgTGeRBeF6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=kJN-5EVp-gxxPv1zTmsA:9 a=QEXdDO2ut3YA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=F8o1otVkKab_vsnVrbwA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeECJSI (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 05:18:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41573 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECJSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 May 2018 05:18:07 -0400
Date: Thu, 3 May 2018 11:18:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180503091806.GA32180@amd>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180426061108.GB4977@amd>
 <4153280.6zxFApgOmi@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <4153280.6zxFApgOmi@merkaba>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-26 12:36:50, Martin Steigerwald wrote:
> Pavel Machek - 26.04.18, 08:11:
> > On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > > Recently ncpfs got moved to staging.  Also recently, we had some
> > > fuzzer developers report bugs in hfs, which they deem a security
> > > hole because Ubuntu attempts to automount an inserted USB device as
> > > hfs.
> >=20
> > We promise "no-regressions" for code in main repository, no such
> > promise for staging. We have quite a lot of code without maintainer.
> >=20
> > Moving code to staging means it will get broken -- staging was not
> > designed for this. I believe moving anything there is bad idea.
> >=20
> > Staging is for ugly code, not for code that needs new maintainter.
>=20
> Good point.
>=20
> Moving things in and out to some "unmaintained" directory=E2=80=A6 I am n=
ot sure=20
> about that either. I tend to think that moving code around does not=20
> solve the underlying issue.
>=20
> Which, according to what I got from Matthew, was that distributors=20
> enable just about every filesystem they can enable which lead to hfs=20
> being used for automounting an USB stick formatted with it.

If distro's are shipping it, they are also willing to fix it. So
=2E.. no need to drop the code just yet.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq084ACgkQMOfwapXb+vI0RgCdGQM/1OfUo5SKsCqPuq/o6IBY
t2IAn3HRqsyXUzYaoKFuv2PdBBIFhbGH
=dgPV
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
