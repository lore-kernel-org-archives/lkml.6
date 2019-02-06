Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5343C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F915218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D58zt+Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfBFQA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:00:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfBFQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:00:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so3028162wmf.0;
        Wed, 06 Feb 2019 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Q1z1E1VEhH4YvR0sG1wuwEqjQ3wT06OEgW8HAveOqo=;
        b=D58zt+CeV6/NqA96/Jujxk3GJeapUnra/RYh44zcoda9CmtpQdaIUNsMtUJDnnC5Z+
         mMnBN872d/zj5/+8mLxk2LO6ISw0CrpzZM3eVTzBmOyc7eJxKGGgF3jPgxi4szGhVir1
         7cdaPJA15LlddCCrLeykroCTudIHlb/n+sWCSqJEYcB677QU7FWt8YVDb/h1Rs26t6qg
         e4Z6q+sFlx9P1YAeJMOOEMaXjasZJH0lZK9iqyyoSxqOxFCF7ETHORB7gkwu+C3j5zdP
         2nR7DipG8ibD9kJtV0hpiiOOVGwgs4TLDtHWnrhr57Sc9dunt6T+YQm4ulmSmozo1rpv
         hHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Q1z1E1VEhH4YvR0sG1wuwEqjQ3wT06OEgW8HAveOqo=;
        b=kKvO6W/8QXwpbgPnwisMOfcJ1Nob5B9KaHz6AzEtkTc+LQX2cX3dSARRcbtjRFBLLe
         eLncW1J/k3N6KnD+czNSO0PCenhLYJVapqeJSJ5ewb8UMbuuvsBCQ1pKAxH1rk/H3gKI
         PHwFJdIJtW5FN+iA45PrC7YPopIDYvAfE5aEF/YbLtxhkhAAhUvURGM4O2G8eVv74qec
         +6PtUswKIjTLqZ6/WkHi97eaWU5iF+rnpZIBux8m5ytKNiTT+UPo1r2CYMgfS1v4LMN+
         IHeW8HNyV6h58PFi0g/Y8XOfZzojqDC7rAbgz+Koh4Qllh8B7l+/7nOErBQWavNDL9wv
         ZcFg==
X-Gm-Message-State: AHQUAubrbekJ37hIiRcI7jVMJS4hOzLpjLgg82+UZ+tU9Ls8tBpO4Lhd
        TF6xmT5QyLHBmnfpCpcRDg0=
X-Google-Smtp-Source: AHgI3IYalS+lLEtJqmHik4FsT4SWrZ64jP3bdlvLW+WauWWQRmx6RJ/HD0DlHOTKirTGKqFJduquGQ==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr3788388wmd.36.1549468825699;
        Wed, 06 Feb 2019 08:00:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a12sm36759733wro.18.2019.02.06.08.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 08:00:24 -0800 (PST)
Date:   Wed, 6 Feb 2019 17:00:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
Message-ID: <20190206160023.GA23805@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
 <1548674808.6421.3.camel@pengutronix.de>
 <20190128145836.GA31317@ulmo>
 <1548849808.3939.7.camel@pengutronix.de>
 <20190201140025.GB12829@ulmo>
 <1549389941.3929.14.camel@pengutronix.de>
 <20190205221300.GA1372@mithrandir>
 <1549448885.3338.4.camel@pengutronix.de>
 <20190206113849.GA21676@ulmo>
 <1549464390.3338.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <1549464390.3338.8.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 03:46:30PM +0100, Philipp Zabel wrote:
> Hi Thierry,
>=20
> On Wed, 2019-02-06 at 12:38 +0100, Thierry Reding wrote:
> [...]
> > I see, that's a very good point. So it sounds indeed like we'll need to
> > add some sort of implicit acquire to request_exclusive() to make this
> > work.
>=20
> See below.
>=20
> > However, that's going to make the API a bit awkward to use, because in
> > order to release the implicit acquisition the driver would have to do a
> > release() that is, from a driver's point of view, unbalanced.
>=20
> That is true. We could make reset_control_acquire on an already acquired
> control a no-op though, so this could look like:
>=20
> reset_control_get_exclusive() // implicitly acquires, may fail
> reset_control_acquire() // optional, just makes acquire explicit (no-op)
> reset_control_assert/deassert()
> reset_control_release()

I don't think we can do that. Otherwise, how do we make sure the acquire
=66rom a second driver isn't a no-op as well?

>=20
> or
>=20
> reset_control_get_exclusive_released() // does not implicitly acquire
> res
> et_control_acquire() // necessary, may fail
> reset_control_assert/deassert
> ()
> reset_control_release()

Mhm... that makes sense.

> > Also, if
> > we implicitly acquire() in request_exclusive(), aren't we going to get
> > into a situation where both driver A and driver B will try to acquire on
> > request and one of them is going to fail?
>=20
> That is true, at least one of the drivers must request the control as
> initially released, otherwise probing may fail depending on whether the
> other driver currently acquired the reset control.

Yeah. I think that this would really only be a temporary situation.
Eventually drivers that deal with temporarily exclusive resets should
transition to the acquire/release protocol in all consumer drivers.

But yeah, the implicit acquire would make sure that existing code
continues to work and the assumptions of the API hold true.

> > > Also, how to decide at driver B request_exclusive() time whether or n=
ot
> > > to throw a warning? We the core doesn't know at this point whether
> > > driver B will use acquire()/release().
> >=20
> > My suggestion was not to throw a warning a request_exclusive() time, but
> > at acquire() time.
>=20
> I'd like to keep the warning in case of two drivers that never call
> _acquire(). I assume this is error case that can easily happen by
> writing a wrong phandle argument in the device tree.

Yeah, makes sense.

> [...]
> > > > That's at least the way that it works on Tegra. Not sure if that is
> > > > universally applicable, though it seems logical to me from a hardwa=
re
> > > > point of view. It may not be required to keep the reset asserted wh=
ile
> > > > the power domain is turned off, but I'd be surprised if there was a
> > > > requirement that it be deasserted while the power domain is off.
> > >=20
> > > There is hardware that doesn't allow to control the level of the reset
> > > line, providing only a self clearing bit that can be used to trigger a
> > > reset pulse (via reset_control_reset()).
> >=20
> > I don't think that really matters. The important part here is ownership.
> > If the power domain owns the reset control upon turning off, no driver
> > whose device is under that power domain should be handling the reset
> > anyway. The device should only be able to take back control of the reset
> > after the power domain has powered on again.
>=20
> Ok, that makes sense.
>=20
> > > > > > Hm... actually this means that power domains would have to requ=
est the
> > > > > > reset controls and call reset_control_acquire() during probe. T=
hat way
> > > > > > when the domain is powered on it will release the reset and fre=
e it up
> > > > > > for the SOR driver to use.
> > > > >=20
> > > > > If you can guarantee that the power domain is powered up and rele=
ases
> > > > > the reset control before the SOR driver tries to request the rese=
t line,
> > > > > that would work.
> > > >=20
> > > > Well, that's the part that the acquire/release protocol would enfor=
ce.
> > >=20
> > > Only if both drivers use it. I'd prefer the API to provide consistent
> > > behaviour even if one of the drivers doesn't use acquire/release.
> >=20
> > I'm not sure how to solve that, unless we make the API asymmetric. So if
> > an exclusive reset is implicitly acquired at request time, you need to
> > have an unbalanced release() to release it for a second driver to use.
>=20
> Correct.
>=20
> > But you also don't know which one of the drivers will get the implicit
> > acquire, so the second driver to request the reset control is already
> > going to fail to acquire() at request time. Or if we build in some smart
> > mechanism to only acquire() for the first driver to request, we'll end
> > up with a situation where neither driver knows whether they own the
> > reset control or not.
>=20
> That's why I suggested there should be a new method to explicitly get a
> reset control without the implicit acquire step. That's more or less the
> same as what you suggest below, just by a different name.

Okay, great.

> > To be honest, I have no idea if that could even work. It's like if you
> > pass down a lock to two users but you don't tell them if it's locked or
> > not. What are they supposed to do with that lock? None of them know who
> > owns it, so the purpose of the lock is completely defeated.
> >=20
> > The simplest alternative would be to introduce some sort of flag that
> > would enable the acquire/release protocol. Drivers that want to share
> > exclusive resets this way would then explicitly request using this flag
> > and have to implement the acquire/release protocol if they do. All
> > consumers will get a released reset control and have to call acquire()
> > on it first to gain exclusive access to it.
>=20
> ^ This. I currently call this reset_control_get_exclusive_released.
>=20
> > > > If your device shares a reset control with a power domain, this sho=
uld
> > > > work fine, provided that the device driver uses the reset only betw=
een
> > > > (or during) ->runtime_resume() and ->runtime_suspend().
> > >=20
> > > There should be a clear error path in case drivers don't use the reset
> > > control only during suspend/resume as expected.
> >=20
> > There are two things that I imagine could work. I think in general we
> > should return an error (-EBUSY) if we call acquire() on a reset control
> > that's already acquired.
>=20
> Agreed.
>=20
> > Something else that may make sense is to allow
> > acquire() to block if the consumers wish to do that. This has the usual
> > caveats in that it could block on consumer indefinitely if another
> > consumer never releases the reset control.
>=20
> I'd rather not open that can of worms.
>=20
> > On the other hand, what's a consumer to do if they get -EBUSY? If they
> > use this protocol, then surely they do so because they won't work
> > without access to the reset control, so if they get -EBUSY, presumably
> > there's no way forward for them.
> >=20
> > Perhaps that means that such a condition is actually a bug and we should
> > throw a big warning to make sure it gets addressed. Maybe this means the
> > users of this protocol need to be extra cautious about sequencing, and
> > that would be, in my opinion, a good argument in favour of adding an
> > extra flag for this type of reset control.
>=20
> I agree with all of this. In the case we are currently talking about
> (driver/pm domain), reset_control_acquire() returning -EBUSY is a bug.
>=20
> [...]
> > Perhaps one alternative would be for all consumers to be modified with
> > an explicit acquire() and release() pair before the new semantics take
> > effect. But that seems a bit daunting:
> >=20
> > 	$ git grep -n reset_control_get | wc -l
> > 	381
>=20
> Even if it was easy to change, I wouldn't want every driver to have to
> deal with the acquire/release dance just because in some special cases
> we have to be extra careful about who controls the reset line at what
> time.

Yeah, makes sense.

> [...]
> > I'm beginning to wonder if we're on a wild goose chase here. We've been
> > focusing on exclusive resets here, but we're really talking about shared
> > resets here. What we really want to do is share resets across multiple
> > users and then allow one user to take exclusive control over the reset
> > for a limited amount of time.
>=20
> I suppose you could just use shared resets and patch the reset
> controller driver to initially assert these resets. But that would again
> make it work by accident.
> If at any point you want to call reset_control_assert() and expect this
> to have an effect, shared reset controls are not the right method.
>=20
> > Would it be any easier to implement this on top of shared resets? Given
> > the deassert count this would probably be difficult to do. Users of the
> > shared reset could be at any point in their code execution when another
> > user decides to acquire and assert/deassert.
>=20
> Right. As soon as any shared reset control user has called deassert,
> there is no sane way to explicitly assert the reset from another driver.
> We'd have to build some kind of notification framework for reset
> requests and then argue about whether to give other drivers veto power
> or force them to store internal state and cease all operations.
>=20
> > Hm... so I don't think the implicit acquire step during request would
> > work because of the race conditions I mentioned above. The only other
> > solution that I can think of is to have an explicit way to mark these
> > resets as "exclusively shared" and require users of such resets to
> > implement the acquire/release protocol.
>=20
> I agree. Here is an (untested) patch to illustrate how I thought
> handling 'acquired' state could work:

Very nice, just a couple of comments and questions inline.

> ----------8<----------
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Subject: [PATCH] reset: add acquired/released state for exclusive reset
>  controls
>=20
> There are cases where a driver needs explicit control over a reset line
> that is exclusively conneted to its device, but this control has to be
> temporarily handed over to the power domain controller to handle reset
> requirements during power transitions.
> Allow multiple exclusive reset controls to be requested in 'released'
> state for the same physical reset line, only one of which can be
> acquired at the same time.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/core.c  | 79 ++++++++++++++++++++++++++++++------
>  include/linux/reset.h | 93 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 140 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 9582efb70025..c6a7a4474142 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -34,6 +34,7 @@ static LIST_HEAD(reset_lookup_list);
>   * @id: ID of the reset controller in the reset
>   *      controller device
>   * @refcnt: Number of gets of this reset_control
> + * @acquired: Only one reset_control may be acquired for a given rcdev a=
nd id.
>   * @shared: Is this a shared (1), or an exclusive (0) reset_control?
>   * @deassert_cnt: Number of times this reset line has been deasserted
>   * @triggered_count: Number of times this reset line has been reset. Cur=
rently
> @@ -45,6 +46,7 @@ struct reset_control {
>  	struct list_head list;
>  	unsigned int id;
>  	struct kref refcnt;
> +	bool acquired;
>  	bool shared;
>  	bool array;
>  	atomic_t deassert_count;
> @@ -272,6 +274,9 @@ int reset_control_reset(struct reset_control *rstc)
> =20
>  		if (atomic_inc_return(&rstc->triggered_count) !=3D 1)
>  			return 0;
> +	} else {
> +		if (!rstc->acquired)
> +			return -EINVAL;

Perhaps something like -EPERM would be more appropriate here? -EINVAL
could be confusing because we already return that under a number of
other conditions.

>  	}
> =20
>  	ret =3D rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
> @@ -334,6 +339,9 @@ int reset_control_assert(struct reset_control *rstc)
>  		 */
>  		if (!rstc->rcdev->ops->assert)
>  			return -ENOTSUPP;
> +
> +		if (!rstc->acquired)
> +			return -EINVAL;

Same here...

>  	}
> =20
>  	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
> @@ -369,6 +377,9 @@ int reset_control_deassert(struct reset_control *rstc)
> =20
>  		if (atomic_inc_return(&rstc->deassert_count) !=3D 1)
>  			return 0;
> +	} else {
> +		if (!rstc->acquired)
> +			return -EINVAL;

=2E.. and here.

>  	}
> =20
>  	/*
> @@ -406,9 +417,38 @@ int reset_control_status(struct reset_control *rstc)
>  }
>  EXPORT_SYMBOL_GPL(reset_control_status);
> =20
> +int reset_control_acquire(struct reset_control *rstc)
> +{
> +	struct reset_control *rc;
> +
> +	if (!rstc || rstc->acquired)
> +		return 0;
> +
> +	mutex_lock(&reset_list_mutex);
> +
> +	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
> +		if (rstc !=3D rc && rstc->id =3D=3D rc->id) {
> +			if (rc->acquired) {
> +				mutex_unlock(&reset_list_mutex);
> +				return -EBUSY;
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&reset_list_mutex);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_acquire);

Okay, so I see that you're trying to make sure a shared reset ID isn't
acquired for any of the users. I think the idea of having different
struct reset_control objects pointing at the same ID is pretty elegant,
though I wonder if the loop here may not be a bit much overhead if the
system has a large number of reset controls.

> +
> +void reset_control_release(struct reset_control *rstc)
> +{
> +	rstc->acquired =3D false;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_release);
> +
>  static struct reset_control *__reset_control_get_internal(
>  				struct reset_controller_dev *rcdev,
> -				unsigned int index, bool shared)
> +				unsigned int index, bool shared, bool acquired)
>  {
>  	struct reset_control *rstc;
> =20
> @@ -416,6 +456,14 @@ static struct reset_control *__reset_control_get_int=
ernal(
> =20
>  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
>  		if (rstc->id =3D=3D index) {
> +			/*
> +			 * Allow creating a secondary exclusive reset_control
> +			 * that is initially not acquired for an already
> +			 * controlled reset line.
> +			 */
> +			if (!rstc->shared && !shared && !acquired)
> +				break;
> +

Instead of allowing this to fall through and create a second reset
control pointing at the same ID, wouldn't it be possible to just take a
reference to the original reset control that has the same ID? That way
we operate on the same reset control, but we wouldn't need to iterate
over all existing reset controls in order to determine whether we can
acquire or not.

>  			if (WARN_ON(!rstc->shared || !shared))
>  				return ERR_PTR(-EBUSY);

With the above I think we could just extend this list of conditions with

	|| acquired

and things should work the same. Or perhaps I'm missing something.

Other than that this really looks like a very nice solution.

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxbBJAACgkQ3SOs138+
s6EivA//RBiJ/wObCN9PAcqgLzIMALZBcRqp7QBLfs3+yhKSpHPQG5JY9lp6XpaS
RAthtpHH4oeKSZkUT3kJSwpvvULoTYrxtL5ylCLHUS5kZJqw60tQeytl3aRzpyfq
VbWQkCcOOeREiNCzTTZjSkWahwtlxkyGCKhrnxY5FAHKobqIO7YCd+oghF5h7s+H
FWyXWMEcg8/5bX6rjXIQr/uCWP4eHpYbf3h6N9dsjum9io1bdrGHWtDlp3uiCcLN
XKbu/HhLkdJqFLwV+425XXesJw7up8J4X1b/CDdfqDkVQ4OfAWFszcF7NeAcR0d2
JFTW3m5npkJDJBc4KmH6aADw7dkWx9T39G0uysflYa8DGpxp6cMMo/wR/3+Hbr7n
k0QjL/z47Jan0Ei4qEmE+8UkifUf6pF0TJMkUE6S1EfSlfvdzUjqRCBbsPbzhJqu
Wohmz3NHfQ+g0ClK1bfelo5JOFKAY9G+0lknaArQhIGdSvkEAPtntW6M4wr73SLS
XPb4GXo5gvPOFmzmhrgjiAhdWH0+Z8XNQ69fFmyAuBW7eCxi8pYY8EWcoi4+/vFg
xOX0TTedb3M/NTR568x5xcOIvwnFsKZX9meKeBsyiV4lxJUXcAV8OjfCSoRk2oc3
xsABAnaeZ052x6yRh5MF5LkZbN0kcTA4+WY5BwCqD0Y6Vj8e9UE=
=OBox
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
