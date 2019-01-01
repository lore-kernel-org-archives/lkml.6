Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D12C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07C2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 00:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlmqFh1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAAAVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 19:21:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43370 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfAAAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 19:21:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so13650867pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 16:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xs0DOor6riAMBvGvncxA8hc+sXAg7Y+KCqawPJPM/L4=;
        b=mlmqFh1N2rKInWKL+zaXRB6n+Tgab2ngy33K1W8EPhOixEQB4tUwAJCn+BAcR7kkPI
         pybrkzhm5Wy2kEhczCTxEyz6teVevTOPVXAggHuT5zgIsHsegbrSus+S2wyrubczdHyZ
         LpjKw81MDH5gqk2UJuNFZ4fIzFktkREtcnXHeozxATXIH5lDG/OU8ArKNzw52o0OnUEl
         5PPI2Glah7BP9mMjPkzmYZv1J4H4fnpELYMXN9lMdtqn5aVpyNQ/heKPn6196o5RQl3O
         ifhY9gcTydT4MCB7xOtqUcZan9VJSi7ZsLHFRftqi+hBUu0ZlTvhkHYxarYR5hwymCPn
         85Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Xs0DOor6riAMBvGvncxA8hc+sXAg7Y+KCqawPJPM/L4=;
        b=PilKTjab0fzlsHZ9GSMj9odBdQiNrIzj7C0P+xeqFpI+rhHbDGr1/hzLGgwoQWN70v
         MMkXqI4/QaHJbTV+xw4/kV2ZOBVN/sWattNRCW6GxzJBVFFY1SfqKwSdTjGeRUAnhgP2
         I/ddwaDj0eERhRLrooM6laezoK6jyAkde9PBdiRpQO4d0+LS5Yo7YiwlqZbOyJ8c+ng/
         VgEzhlFY8PKgOY7Tt6e5FMW/5rk/k3rV/chr0kLtm5QZ0JQls1gnNrLNyhrhLN6Zmabz
         OtRV4uFntz8OxdN84ecucHrr7WNOIdhNhOyxof6g4cD1maj1I4OYZNDFIIuhJCOthF76
         ZB0g==
X-Gm-Message-State: AA+aEWZ9Rt1B4qTjf1HaZJrLceYqDIRwJ8dtgw82oubGZ7zpOxljXwW0
        fWJ7Fe0kkPJTkKX+dGTBAAdzU/tDHTE60w==
X-Google-Smtp-Source: ALg8bN5OrwF+89s9Qnnva5gnz310uVHL52bdOQw+T/GLl2da1QxSv2l/eOZHTYAuARWsU3Cfh2OWaw==
X-Received: by 2002:a62:3603:: with SMTP id d3mr40913334pfa.146.1546302099517;
        Mon, 31 Dec 2018 16:21:39 -0800 (PST)
Received: from gmail.com ([2605:e000:1117:c227:3b53:d0fe:bff:4913])
        by smtp.gmail.com with ESMTPSA id n7sm83522312pff.36.2018.12.31.16.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 16:21:38 -0800 (PST)
Date:   Mon, 31 Dec 2018 14:21:36 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>, Willy Tarreau <w@1wt.eu>,
        mingo@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20190101002136.fvn3hy7ybkhmgd3r@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>, mingo@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
 <20181230070846.GA17139@1wt.eu>
 <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
 <20181231200854.GS4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wxiw7bbzajuuvrw"
Content-Disposition: inline
In-Reply-To: <20181231200854.GS4170@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2wxiw7bbzajuuvrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 31, 2018 at 12:08:54PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 29, 2018 at 09:40:20PM -1000, Joey Pabalinas wrote:
> > On Sun, Dec 30, 2018 at 08:08:46AM +0100, Willy Tarreau wrote:
> > > Definitely! Same, I won't emit a patch just for this, Paul already qu=
eued it.
> >=20
> > Yeah, not that big a deal :)
> >=20
> > Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
>=20
> But as long as I am rebasing to add the Reviewed-by, might as well
> update the others.
>=20
> The English rules for capitalization and lists are baroque and completely
> unsuited to word processors ("If any list item is longer than one line,
> capitalize all the items."), but in this case each item has multiple
> sentences, so it makes sense to capitalize.
>=20
> Please see below for the updated commit, and thank you all!

Interesting, I had no idea it was actually that odd, hah.

> And Happy New Year!!!  ;-)

Glad to help, and happy new year to you as well  :)

--=20
Cheers,
Joey Pabalinas

--2wxiw7bbzajuuvrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwqso8ACgkQ2rGdfm9D
tVJBfBAAnELVDn1WR6KHONC4ToV0uRjg1HaaHcp1RwJoTAHEqSdJ9VYPIjH4p11d
9XNjmQ/X6Bj08L5rluQd/mWcosdWrGQWz52A3xJ12PoXr41pRvbZZ6rR9+MXZK63
lYzbHXgCBXbVkiNcGO+bPCSGD8B/CD//G2GbITu46c6BEIlKvlc0PpOpz4orPOen
dFqKhUfi3jQFuqdvt126VhIOG57XuUL5AmIXiBpdIVA4QnvB3cBGOnMsbVx6ZnNk
TnUl0eUKJ/hvOUunqNOzA4py1EuBPTl6y7iVHIUV7NWvb6sgNOe9i+3I/2NgM67+
U2PUEJeREUnVwLUjiY0sacwAWMW9AvENTQHCCZDdFI2z6tMhmZI2yI7yASq7P366
OCUmn+7mcd4vZhrwpGADzNdnLvXZpJ9D6YPAKP4/8SirxZadVOs+DMO93j6I9a/P
8qmEIYfscLcVnGo+XCTUrrJjzZVgtBMoX1jFODS0l/kDMUXy7d/tcE8sfZmHS8f3
TWHpzdmbGH4kr0UEny6N0LpnYLt/x2Eb6FdBxCYDrTWcqs6FznXj9Q5BmLYVEVtk
7HKWF7KYqJniL6+bAr/OFrKVrKQgLblH0F1lY4x6fJ9gjaXtG/rRVmpSyhHQMeLc
LHrLPkfYtH96DvSTnEi4p3WCcDvYXadkHF0zVifcfCqxXf1zjsk=
=B3ur
-----END PGP SIGNATURE-----

--2wxiw7bbzajuuvrw--
