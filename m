Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A86FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E662083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6QXDntu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBGI15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:27:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBGI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:27:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so10475527wrs.8;
        Thu, 07 Feb 2019 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydm80avQtJ0vux7vXW2ZKgg9VQHP9bJ/GFDJpgVwwR8=;
        b=G6QXDntuFvTPGrDIfbQ1+YNVkLuhdxkaXiFPSgGlsuV3M4OBY/iq4htvNqKzgNtl/P
         66TavMtum9EK2tV1ZDQkIiVNpZXcWMwxGdjwQvwk/L+lMqi7s8sYi174lUtx6Wgc3OwS
         k5ve2s+MQ1lzpVhHYinLezoZDvgyviMF2mPm8wru6rEe/rMvTWAiyqxZYgcmXvz4QPSM
         CBFGnhOKOQZqx0HZdjP9m+2hcoNmc5X9zbeYxiwwNvGiq3GTylYr50JnqNRfZ2zbj6AM
         eMFFK14uJxM7BV4vEqnscNzzE89Gu7zMPmSJQ/mI+dF0c/ASoNdG/ZipwGmrze7FIHSH
         R0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydm80avQtJ0vux7vXW2ZKgg9VQHP9bJ/GFDJpgVwwR8=;
        b=NaBrVHPk8ua6JtwhQsZYdPDGYvm+nCd9AI8B1gQrqx7e0qv3evS4dHEdwNqlBgTLYC
         zQqCpmb9Bjk+ddiDVgcZ3NJTIElJEdWcKbaT238A9qE1FQeT5nAsiAX3T8JEifZTb0QY
         6MTEHrwnUEFyEYUM8T5aLjv/gfZe7L7xj1BUi6LIAndVAgBP9omE95p8FTGeulkJW2b2
         k2AZEpufffagSwd9+sbLAq5wWL3TGDwbEnkWVfPq366JudYfz+kPoa031lTeGTU7eDZY
         wthShJ9+65bO0re3+thLLHnH95fjhZ0o2emk4fc+vT7ZFE2zx1z34A36FdYv/kRyxWO9
         ytew==
X-Gm-Message-State: AHQUAuav9GxNfhPnkVGY8pLCrTWGHmLSx/+YvGjkYsMQnLTdi4CxJwP7
        5w0rXz7ZLouQHgDnpqlKupOovLgDiy8=
X-Google-Smtp-Source: AHgI3IajyUZSRrt8THNOF4F8diUX1fFLmLaov1qfz4jdGoU5SSDQxVLnn+viXs4Z1drkuYinrQ3lJA==
X-Received: by 2002:adf:c108:: with SMTP id r8mr11693041wre.233.1549528073095;
        Thu, 07 Feb 2019 00:27:53 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 126sm17050817wmd.1.2019.02.07.00.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 00:27:52 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:27:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
Message-ID: <20190207082751.GA29438@ulmo>
References: <20190128145836.GA31317@ulmo>
 <1548849808.3939.7.camel@pengutronix.de>
 <20190201140025.GB12829@ulmo>
 <1549389941.3929.14.camel@pengutronix.de>
 <20190205221300.GA1372@mithrandir>
 <1549448885.3338.4.camel@pengutronix.de>
 <20190206113849.GA21676@ulmo>
 <1549464390.3338.8.camel@pengutronix.de>
 <20190206160023.GA23805@ulmo>
 <1549476724.3338.10.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1549476724.3338.10.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 07:12:04PM +0100, Philipp Zabel wrote:
> On Wed, 2019-02-06 at 17:00 +0100, Thierry Reding wrote:
[...]
> > That way we operate on the same reset control, but we wouldn't need to
> > iterate over all existing reset controls in order to determine whether
> > we can acquire or not.
>=20
> How could we decide in reset_control_assert whether the provided rstc is
> allowed to change the reset line if both rstc handles point to the same
> struct reset_control?

The idea was that acquire/release would basically act as lock/unlock for
the reset control. So consumers would always have to call acquire()
before assert()/deassert()/reset() and they would be allowed to continue
only if acquire() returns success. Of course that's something you can
only enforce during code review, but that's pretty much the same as with
any type of locking.

So basically the idea is that if a consumers acquire() call succeeds,
the acquired flag gets set on the reset control and that consumer
becomes the only user allowed to modify the reset control. Any other
consumers would call acquire() and fail because the acquired is already
true.

But what you proposed works for me. We can always find constructive ways
to optimize this later if we need or want to.

Another possibility would be to keep an additional, separate list of the
temporarily exclusive resets so that only that list would have to be
iterated to find the ones that are relevant.

> > >  			if (WARN_ON(!rstc->shared || !shared))
> > >  				return ERR_PTR(-EBUSY);
> >=20
> > With the above I think we could just extend this list of conditions with
> >=20
> > 	|| acquired
> >=20
> > and things should work the same. Or perhaps I'm missing something.
> >
> > Other than that this really looks like a very nice solution.
>=20
> Well, apart from the API function names...
> devm_reset_control_get_optional_exclusive_released(dev, "id");
> would be a mouthful.

Yeah, the combinations are somewhat awkward. However, I would expect the
temporarily exclusive resets to be required in most cases, so that would
at least make the name a little shorter.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxb7AAACgkQ3SOs138+
s6E3ig//cmL5YmMqBFP5WPvj0gClgraWwofV1YrWgfDeos46JaOBlh8dcm0x2cvB
OEYwn4MQ4P0kHgGis7UNmN7h85/TPHp1zEdDDp1xJPg0gJSZcoIDbQkXaVUWmH/o
wkkDhNTZhv9idxCaq3IHZVPoAHkoK6O3NRM4Ji6zBX+izJkjtGNHJ0PzvAW3LqyY
Hr9PMmfgolhlxYbIG2E0ubysOYrDdAMLhqSOj1YocMJtxtFOCyDEMHwlIiQZKhXC
2CAz14MYnh6pv4sMuR1xhDIRXFQXMiBSBzeS2gEaUv7jsUl6X8EpBNpeEA8k0FvN
lHujeGZp18q56sIgpdqdr947XZOJ5XYKoNgXN9fqhsUC9NjXPAt5sE7/xuEr+A2n
fmXyDTRKf1wx4qBLr5YWWXf/+FpOom06UMFZlPXAbQdCEY2IWFOTGw/aoELHChbT
y7I8thCuSSAu6qEPXgMR5EyCodTNeTarfvsQz0PVLKmBOWLRuYV6d8LBr9SvqvHV
QOV2bVmT43qhKL0SZnqLhoucE3OPNTSYy2W9jWxf3cYHUzcpRnDNbzKM1NDrPuZN
PZTgsOu/g1EICOyYX/gI9rdv32wukc+/rIX9rXuWxuYdr0yvwP246QHxFS3Mk3UI
acxfpugZRzooaU/PkGfVOlpOFPehINMzk0LDcsOw2LU8IEBF98A=
=62pi
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
