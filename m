Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE7C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F482083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj/qPCDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfB0XMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:12:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35421 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfB0XMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:12:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so21423315qtk.2;
        Wed, 27 Feb 2019 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvvPJ3ku8WsN8OZc8jUqSePl8LcgS009Lc6Cr/WY73g=;
        b=Zj/qPCDhKdfvhi+wPc/PncCae3fiBouEBGjuz34i7wRm1RrboAkFE/WnlrwVC075iL
         dBZcQjPJFuaCmUXDbBhkknC981GmogYx0xMiXLKd1IrJvHFzU4RQTpTlBygard8cIsES
         0+YJPpg37GhV/vbaKESeAlyQ6OUO76MANXV1ViX9pHouxOtF6TFs1Pbo2bSHOcFsGECW
         EZfBI+nu0yEOLBRSyhLlsOY9bUA2bPVGOU+5JKAJJPlrfwEeBvO96aW9UO8DtvJpGZ53
         xOXKsbRTQN/eqUhPjGHGg+N7Kaw706iH2GE4kdF3/aXkt20ZJ82P815D/lfP0c46j08h
         oA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvvPJ3ku8WsN8OZc8jUqSePl8LcgS009Lc6Cr/WY73g=;
        b=MQaUFaUJ4+Uv8eBcJEo7sT3luqommAf5xIaK7mbrcO+n5aEf3odmw5HPhN5uFybQob
         7qBOTJ7wIdy/w91BHSo8MNXsejVQtDum0W/ei9hQbfAxBpFsGQm+gVsAvCclDYLjkFnd
         PgwS1F+UoPlAx+1LTBR1ZipzLbNNIJOdSZqmhtTRdZ7w+Lvx+2VgVuA7CbC0jWDh7qzq
         nqlV2IyYj6ACrTcrfAbWIZaEV1iYflIaH63E2tXqIcXIbuKsYi0yuVrS30T3JUjLbaL8
         qCyQeuT4mTgkeIKc6PuVBFFCl3+JCF2tdpZHH6o+ZPW0bJe9gyOzBlEdU4N7bJ0OZ249
         QjLA==
X-Gm-Message-State: APjAAAVHsOalvZMNeAj8BsfSEEadmhqY/voCxYsJwBpaQnwAz5/3E6eu
        +lGNhCQf2TnxsMXFBYA5WEs=
X-Google-Smtp-Source: APXvYqyh4/Xa7Vv3OQcy6ir8xco9k79eijBwjKTfOPbdNa6J1jD67//fybbep+ybRPLP76FWH4kasA==
X-Received: by 2002:a0c:b5ed:: with SMTP id o45mr4065623qvf.242.1551309126788;
        Wed, 27 Feb 2019 15:12:06 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u31sm12239170qth.15.2019.02.27.15.12.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Feb 2019 15:12:05 -0800 (PST)
Date:   Wed, 27 Feb 2019 20:12:02 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: fix use-after-free when
 drm_gem_handle_create() fails
Message-ID: <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com>
References: <20190226213053.GC218103@gmail.com>
 <20190226220858.214438-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zv4pfadv7tlm7aiw"
Content-Disposition: inline
In-Reply-To: <20190226220858.214438-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zv4pfadv7tlm7aiw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/26, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> If drm_gem_handle_create() fails in vkms_gem_create(), then the
> vkms_gem_object is freed twice: once when the reference is dropped by
> drm_gem_object_put_unlocked(), and again by the extra calls to
> drm_gem_object_release() and kfree().
>=20
> Fix it by skipping the second release and free.
>=20
> This bug was originally found in the vgem driver by syzkaller using
> fault injection, but I noticed it's also present in the vkms driver.
>=20
> Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_=
gem.c
> index 138b0bb325cf9..69048e73377dc 100644
> --- a/drivers/gpu/drm/vkms/vkms_gem.c
> +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> @@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struct drm_de=
vice *dev,
> =20
>  	ret =3D drm_gem_handle_create(file, &obj->gem, handle);
>  	drm_gem_object_put_unlocked(&obj->gem);
> -	if (ret) {
> -		drm_gem_object_release(&obj->gem);
> -		kfree(obj);
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
> =20
>  	return &obj->gem;
>  }
> --=20
> 2.21.0.rc2.261.ga7da99ff1b-goog
>=20

Hi,

Thanks for your patch! :)

The patch looks good for me. I also tested it under the IGT tests on my
local VM and everything was fine.

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--zv4pfadv7tlm7aiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlx3GUIACgkQWJzP/com
vP8ashAAjVUU9uyTdgnZhM9fHdtKxqgp5lN+Rr6GejyOyjFgNVusANtf2Ed+7ucz
9wq6NfRRZotGTtj0MBSUVE6lwYmkMkE9XS0CRtwrt4EnDFy14V7u1JBuoMw3hDCo
RZ+P51j0vVERvCiaBP+yCdgcP+ih+y25TmIPaSQonFGy8cFhU+HxjNUT0NdS85M2
/JvaBjgzoE978YAKZJr3WQzyzF8EHz5zJVfBeVJez6VSF1oVGXZbGfy7nwRv8twH
1JnlnP/8/7Uglo7EUtS8nWvoeN253JYLeeOOmTiXlT4QXfrxxMmzwAh8ArL2bgEe
3JYDwxS3rzxUj7iQPD+HfRFg/R5QkBUoGaAhSrYSImO0OWNrADk+oV47DNzRn6Ww
Cq6sKdBWpzpfHpYkJfx01x4dEA7kNonVdg3v9LgRmTh63El7Yl41UbU8zAELpRrB
R2oBlVqC5cSMfKAAduEqXa14uMjd5mzA5rrqSzvLm8nI6wk++n/uOmPnAQVCflBb
PkxXO4ic0SKolFGL1/lstiVfJbqBsK1yPRb/SuRJdgeDsARy0xYIpav8PKGVg4gm
uu5+vYJ+X5RCGNn8jVMIZ9dgi3bySnwC/Jqs1VDuMm30lsiOXDXlmjzd/FfZNJ04
s4nq9umM/YTaMo3XP2hBVAHZ5SX+3KZXNgZesiJL8wONOuF+vyw=
=XvvV
-----END PGP SIGNATURE-----

--zv4pfadv7tlm7aiw--
