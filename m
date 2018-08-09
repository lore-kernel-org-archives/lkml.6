Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C56CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19221CF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA2jEM8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE19221CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeHINKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:10:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38589 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHINKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:10:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so4732356wro.5;
        Thu, 09 Aug 2018 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5V0xJ3m6u27Is67FmBPGqRQ0bbdUO9nlLm51kjLIlE=;
        b=IA2jEM8ALDEyyucaY6X9W9Rw5vgCh/4SUG0u/CLBhrPwhrvFrE7NRgSFukyf9biCW7
         KDv3MmctbUpgmObxl2VCvd1NuHqeQskOv18c0Kido/UQkrQIOWOFj9xQ83a9arN61NWC
         7033+DwYjllBYD6BwW+VdjRjbof7prUAMpI1GfByQ7K0ZvY03fXnmWavPn3W/Vvdh7Sv
         c6mN3fSiUxF3hxR3yOOu8J+RstgyHA0oIFQQ8JHfXKeY431bj4k7T8u0TSBeCtE3wxGC
         eU7h8iMap4/WslVfJmttKzTYm/8RJhfvZxXfer8DYM6JsHrGJl6wLQeZjK8hoqAPlK9r
         AcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5V0xJ3m6u27Is67FmBPGqRQ0bbdUO9nlLm51kjLIlE=;
        b=g+EM6SMtpaXOR96ePYCVcG5pJo9Dp3F77tJVjbwWakQL3W8jn/xvOXpaWwNBEEHKMS
         h9W4vqQyIBvFYpF/lNDMNyGKJRML4SGx+ey5fQvZmdzFPJrfGMQuHNqQrJW24OXz8evG
         xRg+IKifCswaIXlMLdFG7eqSSZ1afaUNpC7zN5WC1JX3ISQg4G/HwRjDPzMzrVq4lQ1w
         Cwt0zKrns9btg3pTp4vWrvsa4n83ofX8vvJGQAzu6seCfMLA2jCz3nUXj31zUfzkQ5a0
         FteYxbrUUObD/KRM5v36M3A84nuz/66m8cbdeK2ADBKMFHr5QAj7SQyFSp+hUrnWrxjc
         xl5w==
X-Gm-Message-State: AOUpUlGLKpRDUWKm7z/Xaos1RUZOV6hknEAAoG7Y4W6Z8WjEcKCv0A+a
        xLP4RWjF4TBKkXKDa7c94Otloy3y
X-Google-Smtp-Source: AA+uWPxVVOW7DnV1tREeOQeIY5Iqd1/Rjv8swS0KjLQTuw6xCZ120it6Kn3r/FFYcNvU6moGP64h1Q==
X-Received: by 2002:a5d:6a92:: with SMTP id s18-v6mr1028525wru.44.1533811543631;
        Thu, 09 Aug 2018 03:45:43 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id y206-v6sm9051402wmg.45.2018.08.09.03.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 03:45:42 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:45:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Message-ID: <20180809104541.GC21639@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com>
 <20180803105055.GC28546@ulmo>
 <4457259.6qKMIOUXSS@dimapc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <4457259.6qKMIOUXSS@dimapc>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 02:30:47PM +0300, Dmitry Osipenko wrote:
> On Friday, 3 August 2018 13:50:55 MSK Thierry Reding wrote:
> > On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> > > From time to time new bugs are popping up, causing some host1x client=
 to
> > > fail its initialization. Currently a single clients initialization fa=
ilure
> > > causes whole host1x device registration to fail, as a result a single=
 DRM
> > > sub-device initialization failure makes whole DRM initialization to f=
ail.
> > > Let's ignore clients initialization failure, as a result display panel
> > > lights up even if some DRM clients (say GR2D or VIC) fail to initiali=
ze.
> > >=20
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >=20
> > >  drivers/gpu/host1x/bus.c | 18 +++++++-----------
> > >  1 file changed, 7 insertions(+), 11 deletions(-)
> >=20
> > This is actually done on purpose. I can't think of a case where we would
> > actively like to keep a half-broken DRM device operational. The errors
> > that you're talking about should only happen during development,
>=20
> [only in a perfect world]

gr2d and VIC are fairly deterministic. What are the errors you are
seeing that cause initialization failure? Note that it is possible for
these devices to malfunction even if initialization succeeds. A failure
to initialize can only happen if there's something wrong in the device
tree, firmware is missing (in case of VIC) or a regression was
introduced in some subsystem that causes a failure (maybe deferred probe
or something similar).

> > and the
> > device not showing up is a pretty good indicator that something is wrong
> > as opposed to everything booting normally and then getting some cryptic
> > error at runtime because one of the clients didn't initialize.
>=20
> If machine doesn't have a serial port and it doesn't have ssh server runn=
ing=20
> or network doesn't come up, you'll end up with a completely dysfunctional=
=20
> piece of hardware. Hence there is no chance for you to even check what is=
=20
> wrong. The argument about a cryptic error doesn't make much sense, you ha=
ve to=20
> improve your runtime as well (and you'll get a error message in the kerne=
ls=20
> log).

You make a good point here. I'm not aware of any devices we support in
the kernel that don't have a serial console, but that doesn't mean the
kernel could be used on an "unsupported" device  that doesn't have one.

> > From my perspective, all clients should always be operational in
> > whatever baseline version you use. If it isn't that's a bug that should
> > be fixed. Ideally those bugs should get fixed before making it into a
> > baseline version (mainline, linux-next, ...), so that this never impacts
> > even developers, unless they break it themselves, in which case refusing
> > to register the DRM device is a pretty good incentive to fix it.
>=20
> Sounds like you're assuming that only kernel developers are supposed to u=
se=20
> Tegra, though at least (for now) for upstream it is kinda true. Of course=
 that=20
> could be changed ;-)

That's not at all what I'm saying. What I am saying is that we should
make it difficult for developers to break the kernel in a way that would
put users into a position that is difficult to get themselves out of. If
we refuse to register the complete DRM device in case some subdevice
fails to initialize we increase the chances of developers noticing and
fixing it.

If all we do on failure is output an error message, it's very likely to
go unnoticed. Developers are likely to check specifically the
functionality that they're working on and ignore failures that they may
have caused in other parts of the code as a side-effect of their current
work.

Perhaps a good middle ground would be to turn initialization failures
into WARN_ON() to increase the chances of them getting notified and then
continue on a best effort basis in the hopes of having enough
initialized to get a message to users. Another alternative would be to
mark essential subdevices (such as the display controller) so that only
they will cause failure to register the whole DRM device.

Thierry

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsG1MACgkQ3SOs138+
s6H/fRAAoJTQvB6jRwe0QK5JL38mYcoD2oYR9XUGug1CDJQelmWkn6+BaTx/nPrc
9DU0aRsrjU+pywIvhOAw3M3Q2npIiWxMRoNqNQUX29HmeOG+o/9R6en15J0kv4N2
1aqLlekQYBrHK0kWPs53SVXmRLXIBqRprzRN+aHMvR9SI+EyEf5cnCrn61MgLAHw
QTqh85FletD1taWiTe3R6ykfIjRJTX8ga1TLRO9acftc/8JnvcYO4F6wN2ct267q
aD9ZLJPshy2cTddV3Oo0xULOFiYspOEwcAp6x5lpLuBapkdcP6XjYhIJbmSE9aau
ceOvYSteNluRfXqxhOpnwCcYNBdldBckELpnS6UfX8WBfH+Hm4uxjcbhWkW+Vjc/
se60w5HMeZ9C/riBXmzEIyKCdS3WcCQTJFphnYaUgT91BefQJ+ZOXbQj1X3MzqQQ
Nq68PmLWS4tXjPqjw4sQdRQ/ikqzUepo2rQFkAv3Fq9w6Nwh92YcUMfKtFKljzl6
1wmGS9t19WFMzDUqm5LNucv24RmDgkGCe6hq9lOJtPJ+cW2tG/JaIQE83D0EX4tA
0DYhPlFMuXeA2F+DYbirF0pQGW+zYXH4CSFnaQRziGszo8L8G2By7Z181WM/gahO
JDfKwFGtke8TzxFoYcWVOoLRSbfkusSR57XqChwr3gnZlojEaPQ=
=giF+
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
