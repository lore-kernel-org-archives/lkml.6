Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-40035-1521508023-2-8510281333556719147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521508023; b=UCrKk7N3WpxGydqmR5HDIadonO3KyEUU0AlGfbkjaldrLMg
    DalT8on/Bo497v4Rg0Qpr10xWkOOg4ZbWWxq8SssnWQRio5uATLGzffC24lfgEKk
    +UPcG+jB0a8NNp75IcUl2U4jEN/JKmnpzFmADoeKhJKGXvzxj/U+TFjCsWY0GQ8A
    9dSkyAufdig3WqcuDYhk3aP+7Nrwi8jily3X8Js1aimUH+y40pUiNML3/lomlaps
    PwYkSypCusMh8MMhxei8vWrs071TgGopOXctifA4psaZeXSLEIzlxrjFdfitCBsg
    pXHj05mZoTPL/dssn9HrbFq0VeuzzuGyFDW1mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521508023; bh=ozjLSN7Q560T45fAaNt4qinm4bT
    W1jDDux/hHPtKBxk=; b=AStEPZB8B4crA/kTCCVSVSnqA6sFuwfBVpoQOsp32PB
    cJqeCuUa+ZaJ8b0+wm6qmBmSlBZFza7tLB5CT3T37OyVoSwXPQ1huGWnU6HcU339
    w6mTcSdX1vbpiWMGeELkqIarWZqh0bUWDm9rOLsF4Zj+AdAfvw72cgv1pi4fzmHo
    dP+EhRtg0bnTgwmmvJDVaJ+5xpirvg69PWm698/eSJWIwA1hmZmSvyY5LDs8BgQa
    ta8ubwZjku0kbKNtzmXRtPkq6tylhemSv7hg3gaZ+chpqYXYyGADQagOrSrQZC8s
    AbxI3o8ublDt9pkuts48KbtcdNqP0JgbsbyJrI/WNSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvfffujghfkfggphejjfegudeftdgtvghssehmtderredttddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesshhushgvrdgtohhmqeenucfkphepudegtddrvdduuddrudeiiedrudeffedpudelhedrudefhedrvddvtddrvdehgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeileellecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvfffujghfkfggphejjfegudeftdgtvghssehmtderredttddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesshhushgvrdgtohhmqeenucfkphepudegtddrvdduuddrudeiiedrudeffedpudelhedrudefhedrvddvtddrvdehgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeileellecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Justin Skists <j.skists@gmail.com>, devel@driverdev.osuosl.org
Date: Tue, 20 Mar 2018 12:06:45 +1100
Subject: Re: [PATCH] staging: lustre: Fix unneeded byte-ordering cast
In-Reply-To: <20180317091530.GA18271@tanglefoot>
References: <20180317091530.GA18271@tanglefoot>
Message-ID: <87lgena72y.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Patrick Farrell <paf@cray.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7461461982317880703=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7461461982317880703==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17 2018, Justin Skists wrote:

> Fix sparse warning:
>
>   CHECK   drivers/staging//lustre/lnet/lnet/acceptor.c
> drivers/staging//lustre/lnet/lnet/acceptor.c:243:30: warning: cast to
> restricted __le32
>
> LNET_PROTO_TCP_MAGIC, as a define, is already CPU byte-ordered when
> compared to 'magic', so no need for a cast.
>
> Signed-off-by: Justin Skists <j.skists@gmail.com>
> ---
>  drivers/staging/lustre/lnet/lnet/acceptor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/lustre/lnet/lnet/acceptor.c b/drivers/stagin=
g/lustre/lnet/lnet/acceptor.c
> index fb478e20e204..13e981781b9a 100644
> --- a/drivers/staging/lustre/lnet/lnet/acceptor.c
> +++ b/drivers/staging/lustre/lnet/lnet/acceptor.c
> @@ -240,7 +240,7 @@ lnet_accept(struct socket *sock, __u32 magic)
>  			return -EPROTO;
>  		}
>=20=20
> -		if (magic =3D=3D le32_to_cpu(LNET_PROTO_TCP_MAGIC))
> +		if (magic =3D=3D LNET_PROTO_TCP_MAGIC)
>  			str =3D "'old' socknal/tcpnal";
>  		else
>  			str =3D "unrecognised";

This code is almost completely irrelevant (it just choose which error
message to use when failing), but we may as well get it right and I
cannot see why your change is a fix.

"magic" was passed as an argument from lnet_acceptor() to lnet_accept(),
and lnet_acceptor() got it by reading bytes off the network with
lnet_sock_read().
My knowledge is far from complete, but from what I've seen, lustre sends
data in host-byte-order on the sender, and expects the receiver to
determine which byte-order that is (often by looking at a "magic" word
like this) and do any byte-swap that is necessary.

While I agree that LNET_PROTO_TCP_MAGIC is in host-byte-order so calling
le32_to_cpu() on it makes no sense, I don't agree that "magic" is also
host byte-ordered.

I suspect a more correct fix would be to use
  lnet_accept_magic(magic, LNET_PROTO_TCP_MAGIC)
as the condition of the if().  This is consistent with other code that
tests magic, and it is consistent with the general understanding that
"magic" should be in host-byte-order for the peer which sent the
message.
=20=20
Could you resubmit with that change?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwXqYACgkQOeye3VZi
gbn4JA/+JBs8P3l+2uWdL4GjS4KvdfpCiMH3a3QTiSpNbnVg3RMGrdRhHF+v1BYX
oHHxmOxaN/2JgWBnisv/hXjKZJs7i0j+NThbqypSDv+G0iQW2nYDvhs0wmlPDJuU
tqTBRw8NEA522+PL66f1CAgRwZJSXG/EIYlVZKjqxN/BFMePXiWPyEYuhWAUcpWl
20cgVJeVaOyhcmH09dJvJNe8VMDefcfqBqq0jp5b7td+UVF/45D5Wdz6Zy6AOSL0
x+qAi0DX3QhAszDqnMfkjHamWAQbh8oz018HdLjgVN+DsugaNzxw5XzI5R5r7Ptm
fcHdYIdZ8D6xE38uyv8VzJadEu7ZMoLwI9AxI9HguzzvTLekmJoZL9nwGzM9WO+e
NbinUJWcUj6Cd9RWhOCD6Z7lp4YNGeyehAUxtC8HMQmz29v3LARp4rmgM5Vtmr5C
4+psqDmEt8Y67Mjie468u3pnWDbaGzxw2m49S8drknynOgJ4Tms9juBJGmPS+UuD
HoY4H7upWymkXxrZDEGHd1tLTrTecFdJiFntZdxmbjAh6pq08xvcHVC4o1EcxaVp
eoi+r0+nSYtAW5MD/BROwZrOnUaMG7W1GzYR1abeDfy6p58jlpHtPpN4Nx/pOnx3
bUMTeUya28XTLPaWRyqRGmitsQyEJGEvUiLZ4HdEsHp3P9Odsiw=
=/Gpd
-----END PGP SIGNATURE-----
--=-=-=--

--===============7461461982317880703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============7461461982317880703==--
