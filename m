Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154C220821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhZkOSkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBCU5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:57:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44922 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfBCU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:57:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so13430046qte.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2X8y1DrqWl8MJKwH+RgIo7D7U+ZYN5MLly5SAkB7M4=;
        b=dhZkOSkvPAFNWh+Q94DbTeuEohXmvCPxShTmyeSn128gKNd7TgiybFB/RHi+0KVjV2
         BtAwW5r1PqyrIM5mL+y3sqWo9u1Mk8qx7fF8eLAAit7tS3s+SwqHcoZqpH35r8SO+AUi
         zouTPRwsAZNEx65uCwBb7HwU/cPlcoeLFu+0EHxcU1PneLeMfZDmZgFPiXNHLp+lb6vo
         NwZ04SSnS6bYslt7IV9dILitRyp2Vub+qBSogPRRVNHReJT3oJJ9nIFJaW4a6iAYubZX
         EAj/uYZfeHfLT0WfdcAhDKHjcOVFR/8tRepq8F5wh7pyDR3xUQKfNB/eCeoF+LdJypK2
         iwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2X8y1DrqWl8MJKwH+RgIo7D7U+ZYN5MLly5SAkB7M4=;
        b=ud5Quj8365OUeSpT+9gEoPKl++Z1qpGOAAnYmFhYZ3Y20b4NgH0ddntE91wBeQsuqM
         jj2m+VohTQ4tqNp19QuK0F14jEZtfDTDcvB0/2oTbqiJZ/zE5OHeHXI+mmVJBFFjqYcW
         o4O+G4OxwEAvc9vJjFGFnAlRXRBzAWjV1suTEIORLqPMPg0BtUdS/dp74KvkdwdGebB+
         5uZSkkcai/rwBaLV/MzJ5hwCZQtqTBpizgX6agq+b/oF0epQ1ff6SL3v5wf6QdQ6/7cQ
         k+t5UmJnJvP2gstw83HteEOygJPpZ4S//h4H+t15AGsSDKZWZtRmDCdNfVx/vxy4l6zm
         roRA==
X-Gm-Message-State: AJcUukehr9LIcxINLIAzN/Qcln3UG/s8Rfd7cMWprK8/pK+MI22m5GJ2
        FGmTkMeamh0KFuFu/NX/yIg=
X-Google-Smtp-Source: ALg8bN6DHbfby4F3oWsU1HHXUbktkoGUpaR/8P/vd9Hg+sKapmTiR0GO0phJbK2qZmwA44sCUeroQw==
X-Received: by 2002:aed:306c:: with SMTP id 99mr46206080qte.61.1549227430442;
        Sun, 03 Feb 2019 12:57:10 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b27sm4550398qkj.17.2019.02.03.12.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 12:57:09 -0800 (PST)
Date:   Sun, 3 Feb 2019 18:57:07 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/vkms: Bugfix extra vblank frame
Message-ID: <20190203205707.7pqv6s5xuhbxduqv@smtp.gmail.com>
References: <cover.1548856186.git.shayenneluzmoura@gmail.com>
 <171e6e1c239cbca0c3df7183ed8acdfeeace9cf4.1548856186.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kojcgas5cotmjhuj"
Content-Disposition: inline
In-Reply-To: <171e6e1c239cbca0c3df7183ed8acdfeeace9cf4.1548856186.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kojcgas5cotmjhuj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/30, Shayenne Moura wrote:
> kms_flip tests are breaking on vkms when simulate vblank because vblank
> event sequence count returns one extra frame after arm vblank event to
> make a page flip.
>=20
> When vblank interrupt happens, userspace processes the vblank event and
> issues the next page flip command. Kernel calls queue_work to call
> commit_planes and arm the new page flip. The next vblank picks up the
> newly armed vblank event and vblank interrupt happens again.
>=20
> The arm and vblank event are asynchronous, then, on the next vblank, we
> receive x+2 from `get_vblank_timestamp`, instead x+1, although timestamp
> and vblank seqno matches.
>=20
> Function `get_vblank_timestamp` is reached by 2 ways:
>=20
>   - from `drm_mode_page_flip_ioctl`: driver is doing one atomic operation
>     to synchronize planes in the same output. There is no vblank simulati=
on,
>     the `drm_crtc_arm_vblank_event` function adds 1 on vblank count, and =
the
>     variable in_vblank_irq is false
>   - from `vkms_vblank_simulate`: since the driver is doing a vblank simul=
ation,
>     the variable in_vblank_irq is true.
>=20
> Fix this problem subtracting one vblank period from vblank_time when
> `get_vblank_timestamp` is called from trace `drm_mode_page_flip_ioctl`,
> i.e., is not a real vblank interrupt, and getting the timestamp and vblank
> seqno when it is a real vblank interrupt.
>=20
> The reason for all this is that get_vblank_timestamp always supplies the
> timestamp for the next vblank event. The hrtimer is the vblank simulator,
> and it needs the correct previous value to present the next vblank. Since
> this is how hw timestamp registers work and what the vblank core expects.
>=20
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>=20
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index d44bfc392491..23146ff2a25b 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -87,6 +87,9 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, =
unsigned int pipe,
> =20
>  	*vblank_time =3D output->vblank_hrtimer.node.expires;
> =20
> +	if (!in_vblank_irq)
> +		*vblank_time -=3D output->period_ns;
> +
>  	return true;
>  }
> =20
> --=20
> 2.17.1
>=20

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--kojcgas5cotmjhuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxXVaIACgkQWJzP/com
vP/Uow//Vu98UqGq6ZmhdIx+tQ7ZtMhKOXDtACHTqLA1+DKR+DIObYmVl41BkwlR
c8IthbpMsG9bwlmhZH5j9tunZwoysT+iRSLQ3GCih3j8esEyXFITD4zgzEIXK4en
mYx2bCjZvmng6zL/4L3TDnNXZYWCoiCeOMmtRR9cuil4Fm6M938w5O2wCbDj0Ut8
Q3pb9qTDk3uROT7EFRZ7BgGfZ5krK4Gr5MzZUi3VgujhKkDr/nIl0Tkc/LUafrbX
9u7PDNPHF+SASTuL4sY+JdPXCFYjdjq8pzxjwfGvfh4sH8wp/YIspXGaZjG2Ni4M
HewmifLCgC3AT7Da7LmySAORm8pvryMfwT8AmXupMlCw3V531U84/jGGmO4Pk2Q1
scbLO0Lx+xVPhOkc6+kPRb33e4582NwaLu8oMOAh8qbX4FYCslDuJz0JUBiQN7+K
zcqC9iU+SY5h0eoHhO14Y7KfJJukdn/Ro4HhWnDmwdgrJJ2ZyDJaMzBrAYDw6+DP
+hhKtdDttQTL1EwVSvj/IAXipB3JzaCLKtQFKTcUm/AI2ueRkhEoTq4qtc5Dy775
xHvMXqizNcvvyC34UioPWelmU0nORYIXkgGt7P1EYmR0DF9F5h+K7SdpX1YESyHX
JVKJOkNAbZ2vwET9F7wdDpFhQlCBKLsuaR4gE1ILXhhrBqCNcjg=
=MjX9
-----END PGP SIGNATURE-----

--kojcgas5cotmjhuj--
