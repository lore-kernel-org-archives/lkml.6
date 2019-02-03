Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447FC2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B10V/vSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfBCUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:53:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40025 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfBCUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:53:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so13457380qtf.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9miVuWMDoUUlePX4IVnF+FygUaVJNSSOOOd4iftvxA=;
        b=B10V/vSZIlhAgFRM0ZH5SYSeDC62w+NHnMJ7DLfgQhcsJi26vmDbueWJ9aeonXdJlW
         iUaho8xoqMxLlssgkRvuR0rwe69Io0+90+a7YJsfwagJh+JcS8ytI4lNdIM9g3ehOAvR
         cQhol0YEMqQfyQ84S60aLMq0vJ50bRJ+4UunaqgdKykdiImRtigrH4dW0qWEQ6B4XF6T
         z1bi+SgWAKWY03UoTslIoXFll60FBS9dvxEXQ0Zrnvx9zYM+QhFvIALjh0AYUv7sB9Cz
         2mlFOHMlMT9dWVJjAC2/T96kYzdSsfndkrypJ3r6WRDvDTlAufwT6KhjPo/XSXZ3gRP8
         4ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9miVuWMDoUUlePX4IVnF+FygUaVJNSSOOOd4iftvxA=;
        b=Ol5QjLMquC9QmTbz679pxlMkFqtGFKtufx2xpfDji/xj3kSJvqhY6u+zKt8GZgd4w3
         lufBlYZe26dgl6WW6WMUsihc/cn8tvIyRON8/8od48xcB4W82H3Nylu30aSNhHAe9IRQ
         745foFhoH5etDi05vJ54sWwNrQoVFlzb7uH4oCluvoIJvgoVt7UsXBy+crTxfeLz2k/l
         u93FvPge9ByslCZRYj72ayEfOsm6SC47FvcrMQRHHMwZ3zKu1VbluOKQLl6XT2gtR7KH
         BVIAbT5BW/Vvo9FK8rwiznBoTPPvKYPKjPE+PHeFKgcfPLn97LzKGfSOEORku1uI7jye
         Vblg==
X-Gm-Message-State: AHQUAubRFvsja5Gx5uiXUhAmaUJprwEGe/mDWJ/qUjK/gfAPfH3yfTzR
        v7JCYONah2MG49EW/RBz3ss=
X-Google-Smtp-Source: AHgI3IbGEm0OuqspJcbDZkVdaNLDrBRTwhl59ko211+4CtOyTBVsxGghkSmYaBEdIViJlLqkREVB1w==
X-Received: by 2002:ac8:7497:: with SMTP id v23mr2735553qtq.38.1549227219155;
        Sun, 03 Feb 2019 12:53:39 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u19sm1294810qka.43.2019.02.03.12.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 12:53:38 -0800 (PST)
Date:   Sun, 3 Feb 2019 18:53:34 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/vkms: Bugfix for igt-tests
Message-ID: <20190203205334.3umwktkr4tb6f2bp@smtp.gmail.com>
References: <cover.1548856186.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="536w2wkjkw5bfbup"
Content-Disposition: inline
In-Reply-To: <cover.1548856186.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--536w2wkjkw5bfbup
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/30, Shayenne Moura wrote:
> This patchset contains patches to fix the extra frame bug on kms_flip=20
> igt-test. First patch solves the extra vblank frame that breaks many
> tests on kms_flip and second patch solves the race condition caused
> by the solution added in the first one.
>=20
> Shayenne Moura (2):
>   drm/vkms: Bugfix extra vblank frame
>   drm/vkms: Bugfix racing hrtimer vblank handle
>=20
>  drivers/gpu/drm/vkms/vkms_crtc.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Hi,

Thanks for the patchset :)

The patchset worked like a charm; it fixes many of the tests in the
kms_flip. \o/

I'll apply it.

Thanks!

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--536w2wkjkw5bfbup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxXVM4ACgkQWJzP/com
vP92VA//ZYJ1Uwu9jl2YE0ItlyE7wmwW1cGxZL63qkJJRs30uf44gv0VVILREhoy
jNjYBbPX6mRYCeVLjV5GwgXH6q869h4CBB9UKBipBfB2DdzoA/82AZs9glP+6zbw
xsDKMwnL0UbakqXarjYX4BOpjtcC2jH0hAYFFk3+KwL4st3utShvaC2QmvIp8G8H
pRhZjWSmOKYfoY1k+XEaerhZm7zObVRwVt6E5cpHCu+TsryYGwdc/DQYYRbJURS/
CRntwTYP8O7TPen5K9Pwr6d8cLFBJ4T28hEH0kCAzsbtcviY92JJSlrC4m/u89mm
Qkc+W9fAfFFU+8FE83uQJZLH3Xt+qhRJQjcukpKxqibDhUINA+AI/OWCKAeDEy1w
suDSBHR3awXwS6EQZ2rsP2FF+dovuTFApIO8akiDENaGLftJ9vMPfo1DkhGvZLo5
/cS0QLt1vJghuY/P7+WpcuZN7GHoheD/QNBBmYO9y2b/9QmFMp7Q8rIsFez83Qn7
k7CB1srJvtEf0Bty9G/y5BdxhT0WIlmpqPY13SmyPrRvTyHbHnhz7/T2rIozJKRM
kmFhSjb3qgc7Jl7g7gmJojSrmctkNHH+uwFBDjI6uA6Xspncaz7XyfkiDHeIffIO
ftV/XBzMNyp+H/hLBph24cTtzuvUdMOy5mBUQCspmxmIRadHn1Y=
=nMHD
-----END PGP SIGNATURE-----

--536w2wkjkw5bfbup--
