Return-Path: <sfr@canb.auug.org.au>
X-Google-Smtp-Source: AH8x224TMIiqVU5vqFYyc0HK499w5J5XQD4mMGvONIhD+fuujaB5Xvn5KqGebqe4Tr0UvW50mi8t
ARC-Seal: i=1; a=rsa-sha256; t=1519592103; cv=none;
        d=google.com; s=arc-20160816;
        b=GfmzssY0Y1coV2HHHifafzLyvZW7TNhEr7c4DDTC+2dMzMTWo8aASvB7Fxki7RYLzH
         GWaOMZS8vfw0JDxBARMWmmWS+f4/3F1QMK58AtWdf/eeRpkdHCpBo8qfh1ENeosVRUcr
         xMTvHAlphgsceLU7sDCmJIi6DfoFR3I+G2loU4zJpP2ia6aBNb0Fwbh0SHEcO3HfbVAd
         s3DZ2GYfMY2RnC4NUUkkMJiYVrPXXKvz9cVMPhROTNhtNMlrxWith/9SExRvUGtnLTNu
         umqcGppTED/ylbhH3HhXOq4WmRK+j7mdQRxfu5ml1tSV2MXQvXyb0NCaCjFDQg5bXe/X
         1EpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:dkim-signature:arc-authentication-results;
        bh=TAo8O6MHrrxYHAc0EvKC8Xp+8tYg+u7W4Y71efOCW10=;
        b=B9qarv8sKrtuE4F+Sd3cRGXGBn0CJQTuIYmdAmQWjLPT/Zm/NKKjni5uAyKUvQqzl4
         wjE+1gmdaNjrQ8773XCjwYHpJ8F1pQ/o229ei2HrD3VW9lIS7mZLZbNA/DulrP8gB+yg
         rO3w8HGOyPZ77U+u00Ees1hmraEV13cMtyWyABEXIbCaqB3iVIznvpLPkvnADbs8PVDF
         dvhS46er8edjy90CW4X5V8gb/AZuz4bg6jWmitwLu6ESXIrqQACr+StqSbAi1UeCx/+O
         qLGtImwaR3oFGq18DoImGwKaepzup65yRJLMep5hNRENJJnLCC9Pgg5QXeQMtVlBUK5z
         MVSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=e9fA62XS;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=e9fA62XS;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 07:54:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, tycho@tycho.ws, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Pull Request for linux-next
Message-ID: <20180226075422.6d55953d@canb.auug.org.au>
In-Reply-To: <20180225075907.GB9456@eros>
References: <20180225075907.GB9456@eros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/16di3vRB_/m2AX.QEVf7Opp"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593358997453174821?=
X-GMAIL-MSGID: =?utf-8?q?1593407809108245422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/16di3vRB_/m2AX.QEVf7Opp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tobin,

On Sun, 25 Feb 2018 18:59:07 +1100 "Tobin C. Harding" <me@tobin.cc> wrote:
>
> Would it be possible to get the development tree for
> scripts/leaking_addresses.pl included in Linux-next please.
>=20
> The tree is hosted on kernel.org
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git/
>=20
> I have created a branch called linux-next.  This branch is not tagged or
> signed.  I'm super new to kernel maintainer branch management, ATM the
> tree mirrors GregKH's staging tree setup i.e 3 branches
>=20
> 	master
> 	leaks-testing
> 	leaks-next
>=20
> Development done on leaks-testing.  Once patches have been rinsed
> through LKML move them to leaks-next.  Any holes in that?

That looks fine to me.  I have added your leaks-next branch from
today.  It would be nice to see some Reviewed-by or Acked-by tags on
your commits.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/16di3vRB_/m2AX.QEVf7Opp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqTIn4ACgkQAVBC80lX
0Gw2/QgAk3VJYEP0IWWUp/L17hyYDe7vkPjDAF8w1GX4F55t6UvNP0GH+M/n1Q/l
3w0IzZpDNoJD7c8nNsEvNAdCBbSOgTD7ArsrgogrrQhb2nd+Bf+ysN7ICLtBb79P
Zziu55x2qOr7D+76ZxX+hVoikDpjwPF/qQ4t9u1QVUVI4bTvZl602R84ERWoXo7o
FGIHs/yQJ4AI20nuuPLkOGzST3AATeosR+osZIMxR3YiN2lzTje5yyRRMT/6jZno
SXiqfq6nhXUDUB4H526K2jx7E9O+bBrqtYWj9Sxkl6wtdH4NronEzEjBodMfDZAn
vSA350lcbHz5x6GZzP75Jhg6ZOeTCw==
=sUh/
-----END PGP SIGNATURE-----

--Sig_/16di3vRB_/m2AX.QEVf7Opp--
