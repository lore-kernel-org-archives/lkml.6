Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D53C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDDE20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFyB+8cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDDE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeLMQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:14:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34189 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:14:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so2518717ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=05dSwzXONDLgvi1VK+Y1ZyzVNyTa7YET+zO8+qnhefI=;
        b=pFyB+8cAvb83GYjyrphTqZAjkCvP4lpcpd5uUV8ePQypxPCOl+TNcoYfSagILA/DRY
         IOKtZ04PIkbZLj+PaC2XL4fVkOgo9QLUb2MRGObKM17Q+dqZRUL1qXaFqKZtrUDyihZn
         xKnGXhM0w2nI7XPmNHba/y9j4C78Euf/ociUyDLxtDJXhv20b5XnH47uJPreeUVeGNJk
         891S+hBNZ577PjY8PuMx8oxmJUB6ohvFdcHXsBT4OHVbbdS7ujlfNhO6VaUe/HoLiFLk
         pqM5WmC16R4TjK1aASlSGBqrsg1mpWqcloiRDfylLxooZfIRJ5dBacXt0hf2v90wmDDX
         8faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05dSwzXONDLgvi1VK+Y1ZyzVNyTa7YET+zO8+qnhefI=;
        b=hWAMwVhrAMSOr0eR5TapsIlrjdY6Ecf7EJs+iuH2vj7WDi1sCF72/l3jj93GxNNuqp
         6Sq8+PxyKJlWk2XzHc0G2bC3oXvQL8BgqzLTUryHE3qSpGeu0nDMkKRgtAiMD5VMTCcg
         p1XcdaTCadmgdXHKk1I7jyNFgaVPLNS7NiplLfSk6NSp2CUWKZgM8yk1zQKjDtbtE2mY
         gWHK1ahlVlgCcpoZVKjAWQEHCLdUYAXe611yZkBfo1mE0puC95E8V9F4gCd2ST6ujMRm
         7iy99D/DDTev2oXP2nqEi3qazUBURQ8TifiZNY+4bGuW/S8i2xpYwy7v29xUY4OczID1
         KZZw==
X-Gm-Message-State: AA+aEWYTeuCNLQub0kDl93xPF3KlMR/zKvKzNZ9I5ay/nPpnbKtAFT/s
        ZMt1ugwyV45U9OBm9AI2j68=
X-Google-Smtp-Source: AFSGD/VCdP6cc0eRxY1PANKBBQQacXwzcIaY5Zj6bXtB7+I+ojzOWXMNrt3Jnt0VU3PKTlBd/zGjbQ==
X-Received: by 2002:a50:c9c3:: with SMTP id c3mr23001416edi.56.1544717665928;
        Thu, 13 Dec 2018 08:14:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y4-v6sm399886ejc.10.2018.12.13.08.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:14:24 -0800 (PST)
Date:   Thu, 13 Dec 2018 17:14:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jeremy Cline <jcline@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
Message-ID: <20181213161423.GB13531@ulmo>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
 <20181212181410.GC2352@laptop.jcline.org>
 <642dd9ea144c03041ad74b14777553fe652acd1a.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <642dd9ea144c03041ad74b14777553fe652acd1a.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 06:51:19PM -0800, Joe Perches wrote:
> On Wed, 2018-12-12 at 13:14 -0500, Jeremy Cline wrote:
> > It might be worth noting this fixes commit 6f4d29df66ac
> > ("scripts/spdxcheck.py: make python3 compliant")
>=20
> umm, how does it do that?
>=20
> > and also Cc this for
> > stable since 6f4d29df66ac got backported to v4.19. While that commit
> > did indeed make the script work with Python 3 for piping data, it broke
> > Python 2 and made its way to stable.
>=20
> I think attempting to use spdxcheck on binary files
> is not useful in the first place.

Agreed. However, if run without arguments the tool will walk the entire
tree and inevitably run into binary files. I realize that this is kind
of a lame way of dealing with binary files, but the alternatives would
be much more complicated and involve dealing with mimetypes and such.

Thierry

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwShV8ACgkQ3SOs138+
s6G2ihAArS30f0Z6GO/6ezyyJ7cMvAmNCSNBudE+d9bIbQ/F+T+tv15ENs8wQ3Kt
yYZQ9DaaKZ7fCEFkw1T+hmwbnD0xmy8vKZvHA1M18SIueGcv+tUEULW80Fp1ZBS2
QUsHfKwJmGNbVsETLtSBTNYhYhJhXqzq2d6i9uHUKrGNOtIPY5ztQRCnNEbhLQC9
QcuKZAoks2dECk1nDy0+xcenzzdVpco+PS5aNezNhVckugvXM19NHx0c7XVkxWwL
bmoUSMy6mrvkaONBvxX1pfgRp2V5hMgHfy2o/j7J9ddmOfj4KBXb1DWM2+sGVIRe
fjBYx7N2PJ32ZUn5xVWALcQY71Ih4x7Pk4+XJz3l9yA/QNehe2Dom78+Fhuut4uq
dQhGbaP+NU6gDlXJAWflzsn3i0M+jt9raXXa9Bs9rGxU7F0ru+EUkxNJBo7mjfbX
wP+8/DIphee13MPNuzBLjOj4+qxAUmBuorsetEhpWShBac8gWjraTofA1O494p3z
YFGMq79AvVtXKnIYkh6NwmnaNJy/H1vx4t3aBCexbXmXQ5uWCYN7BjkDRJFOtWiN
xegxvWqy0vjKLZM+uy+xw9pJFxv/k9wvfRVCdOCkERyWRTtSWtW2Psu/H7y0d+hd
6NUB4O+hBg7Evc2OZNb07lAVJ5/mflCCf9dcnTwp8NjJOiJxmwU=
=0vKG
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
