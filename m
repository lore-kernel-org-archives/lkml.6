Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219543-1527084420-2-10167021918130651848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
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
    1527084419; b=RGBRFZ1ysZjduMuIzDY2uJbIXf/PN67YjsZC08dw3Dk3zfSQBQ
    Ml2OcLv2jZjBayezApmd0bdcUOj6/CRqtwd+3hVEjMEdUmv5nLGcZYeZMZA5ydwn
    bV43PVBqL/lDvVbZ5XnxiD41Dvn8t8im9e1W2hYupksq+OWSAtZOHeN8dvAlIGiw
    qQbQ7xT4GyRFUx0nmBBz2A/nOwIZMiCSQCt3Y+4JjkN5epkLIt9Gy6FxwMCts3kJ
    Vm8dl30vLAllWrOPTpX2MaETBHyKQiVuLmylk0mPwoUQob9toYZiCMt7+HiqtG0k
    ZvrEwyC7EVxKUduBWlbnFBxP60H60aNDRopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527084419; bh=bcppMqdois3m3K9lqkbMwGTZz5XsiH
    JokMb3zJKwNgw=; b=VafdLyrkrrPiYWPvMkXjh9QFaXN+6F2lNnE5SVgWbvOawk
    vKl5jUjlFz9DlQx9O4WZBNM8P2Psir4HZYEDMQFq2o32jFvdcW8KHDwTkB9mbQ+s
    ybRQUxMjZLFAMzxI+9WcLuciRjdP/Kalki3TGVAJCAgqKwLvc//ea5JmD+L8G1iJ
    6vW5uPQJo2eW7CP0bBU9zRfSSofceNzhLZvm+4fqaXpjItTayaOgomwcfkI8pVQ0
    gTOtrp2fYGi8CDdPS6kiDB4llBUsLPe/Z4QmnjU28ZCFgjfQpmbA0GHwb4m+9hyB
    G2tar+PzaYz2CN66NvmJRUh937E9+ItKygdP5xWg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG7dDqD2xw0VbiTbQvEmxUe7EMrv3BEuILzTn4bjNCHxaZPSOJCzx/Jyrl3b/AJyXGEuN5z6H2pdJXW1PQa4Pm1MY1iXGWUIr6Fxr15/BgyLR0F2zA2F
    iLZ76TmViGsvAHUa79MIVu7DGITOYNVOcOB4u6uRQuhIxQ62fqhjmTWGVZBpJBh4mYmKMDxZeCvLf6Uvrfq9jDj4RDA1FgXnEfL4d0cdDnQrt3TyJd4Dcsad
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=enOvQawGAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=6k61cMStaJteE3b6fooA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=8Ti36qRfL5-QbQZRC-wA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=OuzhcWw_GC9nAYdNdRwA:22 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbeEWOG2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 10:06:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43269 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbeEWOGX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 10:06:23 -0400
Date: Wed, 23 May 2018 16:06:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH 07/24] arm64: ilp32: add documentation on the ILP32 ABI
 for ARM64
Message-ID: <20180523140620.GA27215@amd>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-8-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-8-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-16 11:18:52, Yury Norov wrote:
> Based on Andrew Pinski's patch-series.
>=20
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

So Andrew's signoff should be here?

> ---
>  Documentation/arm64/ilp32.txt | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/arm64/ilp32.txt
>=20
> diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> new file mode 100644
> index 000000000000..d0fd5109c4b2
> --- /dev/null
> +++ b/Documentation/arm64/ilp32.txt
> @@ -0,0 +1,45 @@
> +ILP32 AARCH64 SYSCALL ABI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic compat linux syscall interface.

I was hoping to learn what ILP32 is / what is it good for, but no,
this does not tell me... it would be good to do a short explanation
here, and maybe reference it from cover letter of the series...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsFdVwACgkQMOfwapXb+vIqwQCfYjjsUAivfLJZGZGD+OxZQomb
x7kAoKfYf3WV9YCXwGsSlCM1C9pUE3kr
=dVu7
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
