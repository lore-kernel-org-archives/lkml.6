Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F98C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DA020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUhiDOwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfBFLiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:38:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41695 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:38:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so7138798wrs.8;
        Wed, 06 Feb 2019 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDmasbB+fsX/bOMN8gTtv/k/jjzbtUkl6RhbbHbuXAU=;
        b=RUhiDOwx48X6VO/37aAPp79ClNumF3WJy0e4+2++E4Mq96fRlD+rr9oV0cmkhtEQO8
         oxGGzPNVitSgRupDz5hHKJ4Mjvc6QnKi3PpcruWCaFsV/MV/Oce724AdeGR19odyjZ1t
         ZAPO/lP1mssbiKLJ4jiP1xgUGu6p4ualZlQJBexnrgc0JaMviCFASAgpr93neVqV8acM
         ASJ9rsB4szeNe18IzF6uwmRbShqK0cnH297AJL8YJEb/GZTVl1kBu++vyZi4lej1Fsh5
         HA92A8NI0gsU6z73EqtOO6yeCHRq37lGGpzCsm/Znbf6ZHvNoJKNXi5DTuLomNUja8za
         1kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDmasbB+fsX/bOMN8gTtv/k/jjzbtUkl6RhbbHbuXAU=;
        b=LxmwjJMfIqP1nVfmarcMgrKj9wANXAdP61EPmDuXcIeXh+zrUZEEipwLIyrqDsCs3e
         iXKgMTRYMTyTIzN59GfS2/Rnp8U8BfGet/Z0cy8F8Sc0fi51I2yTO0ueCXllAasZfo+w
         qFRWtD3MHnFctpyxZSloTQGZsT9jaejvq7Yv4OKj9ubO/hRgNhYE0j177Pjd3Jtc6Bwl
         mR9eaY2daoaELUWQpNTdSicj+vpcNYcuZtnjfE80kiq0BWOuCtfstKYGmzKnrSwjO5uO
         wbIMOOA0cqbcuWv3UWhZLQIqB8gPCv5k2ayPhTi19ntjCUkIyB5s/xABD8lANegCyqJ3
         Olww==
X-Gm-Message-State: AHQUAubMZwxyODiTiFVbXL9YkALi9pYhnzey7OBso4ZMs+tx9tXXkOUM
        x9RTwjoIiYIbzmiLqGNDtJ3m74h+vhk=
X-Google-Smtp-Source: AHgI3IbpfXc9hUib7DjTPD5vIEJzVoIMRihkvGyEAKnz2qLD3vFwzIMxsuKbZHcpddVZOV+dw97/Pg==
X-Received: by 2002:a5d:6041:: with SMTP id j1mr310881wrt.297.1549453131984;
        Wed, 06 Feb 2019 03:38:51 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j124sm16472997wmb.48.2019.02.06.03.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 03:38:50 -0800 (PST)
Date:   Wed, 6 Feb 2019 12:38:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
Message-ID: <20190206113849.GA21676@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
 <1548674808.6421.3.camel@pengutronix.de>
 <20190128145836.GA31317@ulmo>
 <1548849808.3939.7.camel@pengutronix.de>
 <20190201140025.GB12829@ulmo>
 <1549389941.3929.14.camel@pengutronix.de>
 <20190205221300.GA1372@mithrandir>
 <1549448885.3338.4.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1549448885.3338.4.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:28:05AM +0100, Philipp Zabel wrote:
> On Tue, 2019-02-05 at 23:13 +0100, Thierry Reding wrote:
> [...]
> > > Drivers that never call _acquire()/_release() must continue to work as
> > > they are, so exclusive reset controls have to be acquired by default.
> >=20
> > I don't think they have to. See below.
>=20
> Currently the API makes guarantees about the state a reset line is in
> after an assert() or deassert() call. I'm thinking of the following
> scenario:
>=20
> driver A                     driver B
>=20
> request_exclusive()
> deassert()
>  |                           request_exclusive()
>  |                           acquire()
>  |                           assert()
>  | driver A expects reset     | driver B expects reset line
>  |=C2=A0line to stay deasserted    | to stay asserted during this
>  | during this time           | this time
>  |                           release()
> assert()
>=20
> If driver A deassert() succeeds because the control refcnt is still 1,
> and driver B acquire() succeeds because driver A didn't explicitly
> acquire the control, driver B assert() should succeed as well
> and that would cause a conflict without either driver getting an error.

I see, that's a very good point. So it sounds indeed like we'll need to
add some sort of implicit acquire to request_exclusive() to make this
work.

However, that's going to make the API a bit awkward to use, because in
order to release the implicit acquisition the driver would have to do a
release() that is, from a driver's point of view, unbalanced. Also, if
we implicitly acquire() in request_exclusive(), aren't we going to get
into a situation where both driver A and driver B will try to acquire on
request and one of them is going to fail?

> Also, how to decide at driver B request_exclusive() time whether or not
> to throw a warning? We the core doesn't know at this point whether
> driver B will use acquire()/release().

My suggestion was not to throw a warning a request_exclusive() time, but
at acquire() time.

> [...]
> > > If the reset line is kept asserted while the power domain is turned o=
ff,
> > > it could indeed stay acquired by the power domain.
> >=20
> > That's at least the way that it works on Tegra. Not sure if that is
> > universally applicable, though it seems logical to me from a hardware
> > point of view. It may not be required to keep the reset asserted while
> > the power domain is turned off, but I'd be surprised if there was a
> > requirement that it be deasserted while the power domain is off.
>=20
> There is hardware that doesn't allow to control the level of the reset
> line, providing only a self clearing bit that can be used to trigger a
> reset pulse (via reset_control_reset()).

I don't think that really matters. The important part here is ownership.
If the power domain owns the reset control upon turning off, no driver
whose device is under that power domain should be handling the reset
anyway. The device should only be able to take back control of the reset
after the power domain has powered on again.

> > > > Hm... actually this means that power domains would have to request =
the
> > > > reset controls and call reset_control_acquire() during probe. That =
way
> > > > when the domain is powered on it will release the reset and free it=
 up
> > > > for the SOR driver to use.
> > >=20
> > > If you can guarantee that the power domain is powered up and releases
> > > the reset control before the SOR driver tries to request the reset li=
ne,
> > > that would work.
> >=20
> > Well, that's the part that the acquire/release protocol would enforce.
>=20
> Only if both drivers use it. I'd prefer the API to provide consistent
> behaviour even if one of the drivers doesn't use acquire/release.

I'm not sure how to solve that, unless we make the API asymmetric. So if
an exclusive reset is implicitly acquired at request time, you need to
have an unbalanced release() to release it for a second driver to use.
But you also don't know which one of the drivers will get the implicit
acquire, so the second driver to request the reset control is already
going to fail to acquire() at request time. Or if we build in some smart
mechanism to only acquire() for the first driver to request, we'll end
up with a situation where neither driver knows whether they own the
reset control or not.

To be honest, I have no idea if that could even work. It's like if you
pass down a lock to two users but you don't tell them if it's locked or
not. What are they supposed to do with that lock? None of them know who
owns it, so the purpose of the lock is completely defeated.

The simplest alternative would be to introduce some sort of flag that
would enable the acquire/release protocol. Drivers that want to share
exclusive resets this way would then explicitly request using this flag
and have to implement the acquire/release protocol if they do. All
consumers will get a released reset control and have to call acquire()
on it first to gain exclusive access to it.

> > If your device shares a reset control with a power domain, this should
> > work fine, provided that the device driver uses the reset only between
> > (or during) ->runtime_resume() and ->runtime_suspend().
>=20
> There should be a clear error path in case drivers don't use the reset
> control only during suspend/resume as expected.

There are two things that I imagine could work. I think in general we
should return an error (-EBUSY) if we call acquire() on a reset control
that's already acquired. Something else that may make sense is to allow
acquire() to block if the consumers wish to do that. This has the usual
caveats in that it could block on consumer indefinitely if another
consumer never releases the reset control.

On the other hand, what's a consumer to do if they get -EBUSY? If they
use this protocol, then surely they do so because they won't work
without access to the reset control, so if they get -EBUSY, presumably
there's no way forward for them.

Perhaps that means that such a condition is actually a bug and we should
throw a big warning to make sure it gets addressed. Maybe this means the
users of this protocol need to be extra cautious about sequencing, and
that would be, in my opinion, a good argument in favour of adding an
extra flag for this type of reset control.

> > > > This seems right because it also happens to work from a runtime PM
> > > > sequencing point of view.
> > > >=20
> > > > I think the problem for single-user exclusive reset controls could =
be
> > > > solved by making use of the reference counting that's already used =
by
> > > > shared resets. We should be able to go ahead and use the reference
> > > > counting in general, and the acquire()/release() dance would only h=
ave
> > > > to be enforced when the reference count is > 1.
> > >=20
> > > I'm not sure I understand what you mean by making use of the shared
> > > resets' refcounting. I suppose you could check the reset_control's
> > > refcnt to determine whether there are other users. Or did you want to
> > > repurpose deassert_count?
> >=20
> > Yes, if we make the new acquire/release protocol only apply if the
> > reset control's refcnt is > 1, then I think we should be able to keep
> > exclusive resets working exactly the same way they are now. Since the
> > exclusive resets are guaranteed to have refcnt =3D=3D 1 right now, there
> > should be no need for them to be implicitly acquired at request time.
>=20
> Ok, thanks for the explanation. That is correct, but it would break the
> guarantee we give for exclusive reset controls, that the state of the
> reset line stays exactly as requested. refcnt could change at any time
> due to a second driver being probed, that could acquire and (de)assert
> the reset line.

Perhaps one alternative would be for all consumers to be modified with
an explicit acquire() and release() pair before the new semantics take
effect. But that seems a bit daunting:

	$ git grep -n reset_control_get | wc -l
	381

> > However, when you start using them from multiple users, the acquire/
> > release protocol would kick in and refuse to assert/deassert before
> > you've acquired them.
> >
> > I think we should also be able to keep the WARN_ON(), albeit maybe in
> > different form. We could have one if the user tries to acquire a reset
> > control that's already acquired. And we could also have a warning if we
> > assert or deassert a reset control that hasn't been acquired *and* that
> > has refcnt > 1. With the above I think "acquired" really needs to mean
> > acquired && refcnt > 1, and then the current exclusive resets should
> > work out of the box.
>=20
> How would you resolve the above scenario? Implicitly acquiring exclusive
> resets during request by default would be one method, but maybe there is
> a better one?

I'm beginning to wonder if we're on a wild goose chase here. We've been
focusing on exclusive resets here, but we're really talking about shared
resets here. What we really want to do is share resets across multiple
users and then allow one user to take exclusive control over the reset
for a limited amount of time.

Would it be any easier to implement this on top of shared resets? Given
the deassert count this would probably be difficult to do. Users of the
shared reset could be at any point in their code execution when another
user decides to acquire and assert/deassert.

Hm... so I don't think the implicit acquire step during request would
work because of the race conditions I mentioned above. The only other
solution that I can think of is to have an explicit way to mark these
resets as "exclusively shared" and require users of such resets to
implement the acquire/release protocol.

Thierry

> > I was wondering whether maybe we needed a way to track the current owner
> > of a reset control, so that we could be clever about when acquire needs
> > to fail or succeed (e.g. acquiring twice by the same owner would be
> > okay), but I think that's overkill. I think this should just be treated
> > like a lock and drivers need to make sure they properly balance acquire
> > and release calls.
>=20
> I agree.
>=20
> regards
> Philipp

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxax0YACgkQ3SOs138+
s6E+gQ//c0QPBIcs3SOJfowI+GCAJWsvEDqYVglIzStoRwFnnMmVEHV1qUYwwRHu
31OlJlHc5NNqXmYrR1NrSHjrWqlXl5XjzuM8Gv36VHGoFC2DjIvE994l3hh/avUb
du6UYdy52q1uL6HT0MdeoBQkbnV05ccEgvVYpnpaolRqZ1swrhpHGf1yB7I1QjnG
LQDnYFcywMP0oTj4B/K1S+R4Az8LYIIG1SMz+Sd0BodElN6VVi7QCcNp5wN1vazb
jf9y5HlnKGpzHUKfnPnfB8pcN60YOUbHdowR9L913iMCN1+j8v2VoWNL98MZXhVZ
bEMpOGd7bM5dhAacI7aP3PahZKh1ZUQtNAl2TWCfhE8PttTezUlHCWfnIK3cPon0
K4O0BxfN/antGxwBgCeeM8aWm+CMT1bZG6efccQKLjC3BJmcRi84GcS3W2qfVbYF
PBs1JJ6pLh8P9btOxmK65fSdWlsbkUV5eSD4MOXWm8Xq5/It/YMf2pGlh9/ZfJyL
I5qPQRRRGx1MBXQQEakIdB/slrI+cNPenOYdvGmEWxtqNjxh/kp1cb6+a2G7TRVf
ffJhY1RrJ+vqAwetgiQkZwIqmMX8rfP134YfbaVXZOvQQKORpqh9rcVK9JbvGgy4
ZXrkbQkFY6d6tbGqHjicDnyO9UwsQWeE+x+321NWapUDi10uH+I=
=rx64
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
