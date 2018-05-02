Return-Path: <prvs=166075862b=stefan.potyra@elektrobit.com>
X-Google-Smtp-Source: AB8JxZpTVsf7+XG3N75gj58bzU9d4IN7EO7bs4tjIaFC1+QEYeHF/Q2hrTuAve9jknX4mF6Ig2CD
ARC-Seal: i=1; a=rsa-sha256; t=1525250071; cv=none;
        d=google.com; s=arc-20160816;
        b=n0+mOelLrqYkr2sThxQaG9EShqPO2NHv5qWXNbkOY7SWxyEAXuMdEpO/C+p09gQFqd
         JGzEJt9k6BKUQ1iHGMOR4STMK5p1kD1JQrIXiC4GMgL//sz+Z7stUM4uDbO+YDUUsftv
         rh93v4D+vW+wabKq+M8pKqv9S4LbHsUNizgv1Bk27o3z2yH0IydBoFvHMeqoN4Dz7aAO
         tc91OT3fqX2JxRyp4cTUxTwpxQBAiuTmUfNAZBeqFRl9cr9WKExTL75R5nCzwInReqef
         A9p1Ccqw/GByBUMZUrlK37ct+H2iVXeOroaO03v5DbQv1PTOJWie7TGWg+ITMpZIoPMy
         r37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uQ1FczcvSEiVdzwJNiPr6E9QDKT2SgPgTbQogSpxYZo=;
        b=p9duFzYLmPCJGrqE5ecaz+OCWewEY8hLc9hZKBJuYqlWuydV88sgv9Gaq0RoUtQnyz
         kXlTmhp5PC3u6kjoA2JASelPsr3fPQYXpXD1vP835WyJ6csRRd8tIojmnuqghOntt8Kd
         AOYg3OpNgGsHyIbJAXkIagsK0LEnUeW+VbegjS9gba/dmZizZOdVPB0EEEoMUqoLqnZV
         s4OJ/WokJoSH2MXKVfS3/H+PHv5yh+zbCyXvy4zG597b5Ik2Dlcz+cZjjdHUkpHVzSie
         xyt+KNZXZv3ai7DMO49c7edPs4Q8enHeJ3KjjjT+yn3Rj42+P77X+5kk61KOcvJZJQii
         38Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=166075862b=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=166075862b=stefan.potyra@elektrobit.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=166075862b=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=166075862b=stefan.potyra@elektrobit.com
Date: Wed, 2 May 2018 10:34:26 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Evgeniy Polyakov <zbr@ioremap.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "ldv-project@linuxtesting.org"
	<ldv-project@linuxtesting.org>,
        "sil2review@lists.osadl.org"
	<sil2review@lists.osadl.org>
Subject: Re: [PATCH] Enable clock before calling clk_get_rate() on it.
Message-ID: <20180502083420.GA8549@er01809n.ebgroup.elektrobit.com>
References: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
 <4863111525100577@web2o.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <4863111525100577@web2o.yandex.ru>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es008.ebgroup.elektrobit.com (10.5.139.25) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599183864651429148?=
X-GMAIL-MSGID: =?utf-8?q?1599340619244700459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Evgeniy,

On Mon, Apr 30, 2018 at 06:02:57PM +0300, Evgeniy Polyakov wrote:
> Hi Stefan
>=20
> Nice catch, thank you!
>=20
> 19.04.2018, 16:02, "Stefan Potyra" <stefan.potyra@elektrobit.com>:
> > According to the API, you may only call clk_get_rate() after actually
> > enabling it.
> >
> > Found by Linux Driver Verification project (linuxtesting.org).
> >
> > Fixes: a5fd9139f74c w1: add 1-wire master driver for i.MX27 / i.MX31
> > Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
>=20
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

Oops, just saw that now the clock is leaked in the error case of mdev->regs.
I'll respin the patch and fix that.

Cheers,
  Stefan.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEATY+KFcrMtHMM+b3X8uyjJIzOwAFAlrpeAgACgkQX8uyjJIz
OwDaGw//SD6nuo2EdtZwxayu5icg50RXTFAqeuOle3dwLNxH/UWdCYr0EZIq6THr
iB+n3e179hfCoWGSV5KX+tqhMnVul4JG/qwdPZSzX2DO5O9B0ZxtprJFsS+zmMOl
0ACcs90nV9Dwf7eouZrn8Suujb4ptfM+VL9s3ckQW68fyy4wdaEH2ILp1ldyQ+IX
J7g2coZpd41wF2Vk8DtT0nsYRowckfGrI9HPFClVuj6z3Bv+815dlpTpvOiGPDFA
4IhTbRDJgxQzHs1lOXJy8+yGH9fgXjvIs8xvmVvkNo5rqsaRMw6qWV6jNAhCRBZh
I9ZAuB3aoYZ491+7zdMWi37gRRWRY3xLeUN7YvmxLabTNun4mSAbNvJvbQV9M3sE
lTFClse4kIoloBatwmIBtc7Z6gZRwiy80378OjR1XWvHfYEZkJg6GcseHk48AyaU
ErnhfluVICSGpcz9fM+9WM+qKcglyx0lB5Ntrq7ZFKf1AZg/fRDxSRvR4FWbFljP
bSo87cCcLwxQ1EQVOX6w4QQ5Dt7GhxYIa/O0y3YLyZt1MMkUFwFK1nUyDyP71uvF
KuBn62kSvt0slfbv5meMWC2t4LZp0h7tva1VrditgMeaRmvI+WR3ePJsVIIWpqIV
CmLeUdS9kwQS/ESKfmyM4HTm0G9M1ITP5XYOCV3d0uFW1myAMxQ=
=0rSC
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
