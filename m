Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CFC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D2421773
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdWHEQ5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBJMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:34:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33828 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfBJMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:34:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so4891872qkc.1;
        Sun, 10 Feb 2019 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OH65mH5Z8fgTEDxaOtleQtwn1KWuY7v5PpJ5PO7FWG8=;
        b=WdWHEQ5WgrAzcmI9q50S8sbmxlXZB80rS5hGJk0T513w326U/MORGuBrOdgd8BYZYA
         Xjtu0xwmBs96VDHExYcl9TQ9JyFLrcvZlu8B+pCL+sayKZJy/duqdXBwcnPXtnAR/gVc
         ZxhttOgBDailmTxSCcQWW4IjpmXNnwCAY3+owQdQuMQ6O4uxzMQsoYTh/WREsukUad/e
         udhTCSsvVae+GA28NBgcvrBhzdInHL4/gWBkc4gQnPJH5q2V+IA1JzgvZAx6w/RovNdo
         wJbwx1UpcIy+Hl9nzzuu3FCPJen0aICU3zFZo9Fp8wc4NDlJNWugLFkTv4J0ngnd65BY
         B8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OH65mH5Z8fgTEDxaOtleQtwn1KWuY7v5PpJ5PO7FWG8=;
        b=OnckpRVMCBwT/GXgo5q06jdQsymuHf1EZk2bAKw3K3YFYn20aYvR31bM2iPLQDSK13
         e7ymXBgIuuK1ZjdD9XvIYZP64lXwPBOTRbD6ISbkRflyQGXr8Lrhi9JZoS8bnGOPPLNN
         GPwYXL8OiFTg1Cvzioc/sVbpaXsqG2/s2uQwMG0zkeivqz6gbugnCBkPubP1Hot0bgQq
         jMIE2ckz9eO4BB4nVma6c9C4INKR+Ri86Xf7m5HhkkLy679yWw7WlVsR7xY+Xn5kWQDk
         P9zs4MyT+s1iq5+k/P73kiwYztHzTL3n0ohAEzLd8OrocQkBazqJTO/eY9lI7qJyPiQs
         PyVQ==
X-Gm-Message-State: AHQUAuZHnZ2eh4eEi6wd10UU8tIYU/aR/M+9sU1RGLOsikdZAlj35Wrt
        TeZdtefS5EjUD5jrH4Oy/iUMi4kK
X-Google-Smtp-Source: AHgI3Iav0cuD/Fo+F7zNyqq9go46V/reZFinMhPTD0P3N4CI8PdAZI8Xi9XNKIiZRMCE0dZSS+Ff4Q==
X-Received: by 2002:a37:96c3:: with SMTP id y186mr17215071qkd.166.1549802081174;
        Sun, 10 Feb 2019 04:34:41 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s67sm7491265qke.56.2019.02.10.04.34.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Feb 2019 04:34:40 -0800 (PST)
Date:   Sun, 10 Feb 2019 10:34:36 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     stable@vger.kernel.org, Haneen Mohammed <hamohammed.sa@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/vkms: Fix license inconsistent
Message-ID: <20190210123436.ipynwm3tb2gg3n7m@smtp.gmail.com>
References: <20190206140116.7qvy2lpwbcd7wds6@smtp.gmail.com>
 <20190206152759.GJ3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywf7logcyiskieoz"
Content-Disposition: inline
In-Reply-To: <20190206152759.GJ3271@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywf7logcyiskieoz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/06, Daniel Vetter wrote:
> On Wed, Feb 06, 2019 at 12:01:16PM -0200, Rodrigo Siqueira wrote:
> > Fixes license inconsistent related to the VKMS driver and remove the
> > redundant boilerplate comment.
> >=20
> > Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> > Changes in V2:
> >   - Add "Cc: stable@vger.kernel.org" tag
>=20
> Since cc: stable please apply this patch to drm-misc-fixes, not
> drm-misc-next like usual.

Hi,

Applied to the drm-misc-fixes branch of drm-misc.git as Daniel suggested
in the previous message.

Thanks.
=20
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >=20
> >  drivers/gpu/drm/vkms/vkms_crc.c    | 3 ++-
> >  drivers/gpu/drm/vkms/vkms_crtc.c   | 8 +-------
> >  drivers/gpu/drm/vkms/vkms_drv.c    | 7 +------
> >  drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
> >  drivers/gpu/drm/vkms/vkms_gem.c    | 8 +-------
> >  drivers/gpu/drm/vkms/vkms_output.c | 8 +-------
> >  drivers/gpu/drm/vkms/vkms_plane.c  | 8 +-------
> >  7 files changed, 9 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkm=
s_crc.c
> > index 9d9e8146db90..d7b409a3c0f8 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> > @@ -1,4 +1,5 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> >  #include "vkms_drv.h"
> >  #include <linux/crc32.h>
> >  #include <drm/drm_atomic.h>
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vk=
ms_crtc.c
> > index 5a095610726b..6ddaa1610807 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -1,10 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0+
> > =20
> >  #include "vkms_drv.h"
> >  #include <drm/drm_atomic_helper.h>
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkm=
s_drv.c
> > index b13f99a5c849..738dd6206d85 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -1,9 +1,4 @@
> > -/*
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0+
> > =20
> >  /**
> >   * DOC: vkms (Virtual Kernel Modesetting)
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkm=
s_drv.h
> > index e4469cd3d254..81f1cfbeb936 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -1,3 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> >  #ifndef _VKMS_DRV_H_
> >  #define _VKMS_DRV_H_
> > =20
> > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkm=
s_gem.c
> > index 80311daed47a..138b0bb325cf 100644
> > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > @@ -1,10 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0+
> > =20
> >  #include <linux/shmem_fs.h>
> > =20
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index c5b16efed51a..3b162b25312e 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -1,10 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0+
> > =20
> >  #include "vkms_drv.h"
> >  #include <drm/drm_atomic_helper.h>
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/v=
kms_plane.c
> > index 418817600ad1..0e67d2d42f0c 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -1,10 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0+
> > =20
> >  #include "vkms_drv.h"
> >  #include <drm/drm_plane_helper.h>
> > --=20
> > 2.20.1
> >=20
> >=20
> > --=20
> > Rodrigo Siqueira
> > https://siqueira.tech
> > Graduate Student
> > Department of Computer Science
> > University of S=E3o Paulo
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--ywf7logcyiskieoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxgGlwACgkQWJzP/com
vP/dSRAAutaNZjCevXT/tBhbxGQVJfsmh4qZNLl5ZiIugzwZ2OUonol/aOMrm//c
TtlKrR8ej9WIwa27KUHkEdTEycuetcomMOJrNcR2/JuQzNJiQBtumgDVqAdyHtOM
sWEQi5ybubjw25H3yr6TBWENHOcf35Zu3l3IDZbhJY9Xb9uUjddTUKcvS9V6jDco
9vwCWtZlRCJcEurYjP3MN5VD3skWLe4xhznG9KX55ExpYj7F3f1WmabmNB0M8+Eo
99O+zMdU3mBdZc4ANpGzAAxTmGe1LLO3uerR7O8gGXR3LVudXrVtEHD/ncmJVBVd
8CH0M7DccLwr9GksOyxevKTTakq6IbNWJ3rUZ1QAhj1AF5cJcdhQtZfI71vDZL/R
kHodaHYiaVNpJhy6CReNh/RB8DopeLWkLxoKGh5zkip5OsYtz7v+Dmyl6YoR7+Hn
R8E7UphDonPRWAVP00wJ2gQSk9vjNvJG0NkyypUBdu4V2hC80ConaGAjmHRJv84g
Fkeyxb1k+2mEX8evzMCfc7/EmbPIaLDAOYtrt9UacWVEUdQ1BUS1wTsDbG+cXi4c
ERhaB3WtpVFMIf7oNX91YPfnY4tOwv7GHzHXqlfbpLs7TXXivYSQXbzYr5tX0DnV
gc61swq2vvqBrC2CMtQTkQWG5hhAO7Bw5Gb3J3G0vvXfDQYIzoU=
=3aZ0
-----END PGP SIGNATURE-----

--ywf7logcyiskieoz--
