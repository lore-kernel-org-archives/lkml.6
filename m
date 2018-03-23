Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2204151-1521839302-2-14336226074232706033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521839302; b=LpKM2LcibspHCzUoxgu1LHBQSI84BVN07QViAdM7vTVH9bW
    lbplMBVYNutoAlXbV2PciRfWnWC2QkyOljjhDXQWc0iO/fUUrpGL9h4E5KFzzjHG
    mfTvOoMhjtIFRjYNQ7RKfUbrrunhY19hkJ+q3/XVAz969T5ehiwMp31OJOZ11Zp8
    ySEWCzaSGr/QnaYDrJoVvu58NhS8P/ftYvNuktXXJEo69MKbnfuKO8z8WGVYr0JI
    GI6mhogssYUBEd5+FIwp9Uecd9PGN0sfdXcnyzpOE5N3ZV5Ws7FLW6VL6bNBq32r
    InZ3QozynldaBttsL4xeo10mKlR7DoHB3GI8yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521839302; bh=zakOH7XSPPt8JHoR3otlvy3ZeW
    GIedqd/PPoH7aGOvg=; b=Mnbk0L8sq3tDzCihPaPpuriIsSNmh6PRLcPOnlRB7s
    VQkKhrY4Sipk8gmInA5Hly+UElTVutvux1RD9AwEGKfGGxupyDNhLrsX3nFePcLu
    rjIVZrh5hPoZmFZ6N8V/CxQFKTljFmbIVXikBTqYzGuNjVYfLunx3Hi+qDdzkFsQ
    GJlylQdg//Tx/KlA3EKueSbNYW4XhbZCoR+IEkd49U1gd+gdgDWC6dmFPiDoZ/49
    01Yd/123Q1hB+psjq1p3qkqLvaMVNQewWx+V5gstzCgFuzix8+sonErWn4/pNBCx
    BLYuQiipVpp7uo1mWBgJKr0A8ECsbsewvMkOVdgZsVSQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeCWVIT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbeCWVIS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Mar 2018 17:08:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005312168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 23 Mar 2018 21:08:12 +0000
From: James Hogan <jhogan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180323210811.GD11796@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180322222107.GJ13126@saruman>
 <1521777055.1510.9.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <1521777055.1510.9.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 11:50:55AM +0800, Jiaxun Yang wrote:
> =E5=9C=A8 2018-03-22=E5=9B=9B=E7=9A=84 22:21 +0000=EF=BC=8CJames Hogan=E5=
=86=99=E9=81=93=EF=BC=9A
> > Also I think it worth mentioning in the commit message the MIPS
> > configuration you hit this with, presumably a Loongson one? For me
> > decompress_kernel() gets a stack guard on loongson3_defconfig, but
> > not
> > malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> > to
> > the compiler inlining stuff into decompress_kernel() or something
> > such
> > that it suddenly qualifies for a stack guard.
>=20
> Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=3Dy ?

Yes. for malta_defconfig I could only reproduce by adding an array to
decompress_kernel() so that it would get the guard.

Cheers
James

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq1bLsACgkQbAtpk944
dnqRoRAAgQ9jkBNRCrcD5HNMyD7XNnyB4QBm9KgvsYASAFF2b9bzC1qaFsv7ogMe
+yUEgTbXYGvVyBKMRr/D0d0ndlTSPCwVJHwtwgBVp+PizfWmBTF6j1IvbQ1YnQfH
vYfFm72xW0L0awtmXV2tbo/Y/AQopzAaWL09sFhrqSt9tWRmPDnlx0r+DfPp3wVP
I5mA+BftMiVSjqOiwU5QAmj2JVFRpkfKCAftdjG6UFQE0l7aw+4EFHpYiI+8Ai6A
XiFyf+GQu6Bh0GK+mdTSa0pb+UMEhf1Q4Y5BlJca6zThYTdlZKJoAwIPjHh+Pn4M
hsKYqKczPJd0hlDSFG5/LC7tp5ySoRGTP/kFQoodjjOf774FkdTTY73/8JDcHc7n
Jb8UMrMiwWLOPwyqjS9SD2sBcnHVAUZvGhIS5pJHzEiAIKNVVeXpjWYTTwQ2nKiN
r240w2CjnH/l8C4iwUChu2xvoXV/3EYJLibTIaLbAyGu0TTeW8nGQR4m3wRIL3ig
Dg9C3tgQY4NJMaTXWRyJGEf58cezFSkDvHRAmNqO6r4IkXjJ4VXlqCvUj0p+KThw
2oKS6aDj7ZU25DrTAPmb24SCUS9A61Ktwo463YznQdv2WUppc++dRUoBnJ5j89iP
o4ngC6M2GKsRrL2SRphyLz4Pyi+alDWvXm+tQnKD7Uy940M8SF0=
=0EHR
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
