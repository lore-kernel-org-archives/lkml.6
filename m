Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxo/45EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfAaVyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:54:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33884 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfAaVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:54:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so3113083wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjti96rjxTWG805BS0sMyRjy1EHKCeJRvuL32qimD+s=;
        b=oxo/45EWs6R/+4nfZsmZSInV7FvPoLjEF98SzzgrftgOpbfNUinPnH/6oo1liEdWX6
         dnteZb+C0igUweOt6HYwMYqqwzdIlbwQy1xUwjnRinquDeoZO5YN55SpFGYUI1774Kg5
         ZZ/1WDJpj3xcYbwrtAqOy0hvaUE7SaVbTXDhJdyBHf9KCoaY3o7gHK0qxHql46aJZoEp
         CVlEYlro16lL53uME1Im++O+rPtxn8QTpWyyhkKG83cTIVyr48HehxiBX0vGvYL4vXV2
         yG73DZktmGIppzyGV54FFZyh4SL6+aC/ZGMR/gzB7340BnlPwouRJ4AhYbfNX6oAmD14
         +hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjti96rjxTWG805BS0sMyRjy1EHKCeJRvuL32qimD+s=;
        b=dDLyorzvMkUwgtNjfNN+hA5XlGKxU/IJni3j6c9Dty6sSIbpxYh+H8RPIq0jemQTie
         QRrgNw4UK/oNne3HXWkAlEk+rbaS4SVNOl1J8D/g4szgsV7DRaZ6d3nlRGlrBEYf9X7Q
         fMKOO/YmlxtRDkswfpH+taFdD+NbjGur4wrENCPyF4PVqr0UAOyyTJV2wXOVkBBQPhdv
         d2MhxkjhAh9f7gtyuXWAu6DSutYskf0UeqpskFd8oCvkKoxv3JAvMgHtRbyuTyC727sx
         ubNieMDezEQQ87q81ca7ZE16Yw7F2jDPQgGbB17yc8Zuc4J6z3FmrpZjW6mhDFhqV/yo
         H4rA==
X-Gm-Message-State: AJcUukdq3j8ni+AdP47CCxqfb0E1XtlU0BEoSpTVgWONPpZjmV8ARoEd
        Fls5ihdkjLRf9KIVoBHuqVAPLTkjxDs=
X-Google-Smtp-Source: ALg8bN7Hos6BUlydOdNYClYiZuo3pMr4yMUFrwraf6J2uN0c44SOVA3pIofbenY3ygIZJwOF/GfHdQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr31586746wmi.10.1548971661213;
        Thu, 31 Jan 2019 13:54:21 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id k128sm700475wmd.37.2019.01.31.13.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:54:20 -0800 (PST)
Date:   Thu, 31 Jan 2019 22:54:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190131215417.GA13156@mithrandir>
References: <20190131192619.9763-1-sam@ravnborg.org>
 <20190131200723.GZ114153@art_vandelay>
 <20190131210312.GA8947@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20190131210312.GA8947@ravnborg.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 10:03:12PM +0100, Sam Ravnborg wrote:
> Hi Sean.
>=20
> > Hey Sam,
> > Thanks for the patchset, this will make dmesg grepping easier! One comm=
ent, and
> > you're going to hate me for it: Why use DRM_DEV* instead of DRM_*?
> >=20
> > When I introduced DRM_DEV, it was to cover the case where there are mul=
tiple
> > instances of the same driver (ie: dual-channel mipi, multiple crtcs, et=
c). I
> > suppose that _could_ happen in the panel space, but it seems more unlik=
ely than
> > not.
>=20
> The rationale for using DRM_DEV* are solely that if a struct device * is =
avalible,
> then we can use this to provide more information about the origin of the =
logging.
>=20
> I have not testet it - but from browsing the code I could not see that
> DRM_ERROR and friends picked up the module name.
> If DRM_ERROR is the right choice I will redo the patches - no problem.
>=20
> But if we loose the module name then the DRM_DEV* variants are preferable=
 IMO.

I personally like the DRM_DEV_* variants better because of the
additional information that they provide. That can be useful when
grepping logs etc.

I'm slightly on the fence about this patch. The unwritten, and
admittedly fuzzy, rules that I've been using so far are that dev_*() are
used or messages that have to do with the panel device itself, whereas
DRM_* variants are used for things that are actually related to DRM. So
typically this would mean that roughly everything in ->probe() or
->remove() would be dev_*(), while the rest would be DRM_DEV_*().

The reason for this is that during most of ->probe() there's not really
any connection to DRM. In many cases the DRM device doesn't even exist
yet. Consider component/master setups where some display component will
wait for the panel to be registered before binding the master. So I find
it confusing to have the DRM style messages when there's actually no DRM
going on yet.

That said, I understand that this might not be an immediately obvious
rule and it might not be followed rigorously, which both quite possibly
contribute to the perception that the messages are all inconsistent. It
always made sense to me, but if everyone else thinks that it's totally
nuts, I'm sure I can find a way to get over it.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTboUACgkQ3SOs138+
s6Gcug/+JZImCInI8kyPqT4pN4qRbXmCAFeUpKSh19yHN5MnisK14xu14qClW/q2
3cv+JxY6U93cvWkSn+hfLU0K4TRXS/dmz6AB5AC/lj3ADOUxFW75gweGlCVoKMv2
bwYXlOACghDjdW7uhpgHeTxB/TPkE2Oaz9+47SVZBFbeCFTWx6XfQ5tfQG9BperP
rXXHyZbOHCEu2yoov1zfIWfxxTA9VsSluKB6AX62EJ1XGMQHC+tPJtPXbryZMc5v
AZzaQjv8Q+yitPwrZLmQF7vLJ5C7l/NhOy20BrlHW38gDC8Q2q4quwNaoP8W6mE6
6vp/W3YB7O5YLy5v/fYz+wf9smq3A3o/o3qLAN7g9koMc8OnMCPDLznM4xnkAF69
U0krpggxq/T7aDqroazZI1/WQchbq2+bkSn3xv3CqY3SypEpnoqGhHjR3+cYP3W3
6FnJqpdZ6og4In8P5adVS2KnBXWCZM4iQnFsH+pTSkPv6Wfb6Z3fkeEKX4c5VTXc
oEJuNp7BSO1mJQjCHkwiuR2j6o/iEF6gNTuO4OMCwcqjGM61Fyz1BtIat3hpF/3E
rBWZSS8tlz98+382Zvbc6w92fbu0Gyqky2JGju3qnUdp3e+c4lADLhQWKIXzw0dS
FZd+w9iEO3fBFR/OpcA/KoPE0M1b9FnN54tCCmgdnnVR3W8jBjs=
=XIfx
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
