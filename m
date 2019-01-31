Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCDC218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcvQTIoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfAaOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:30:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33411 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:30:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so3579269wru.0;
        Thu, 31 Jan 2019 06:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6PPGh6J7iYJHxSY4+xGTOTYJvR4R4wWg+Y+0LcK8cY=;
        b=UcvQTIoRm0jbpSt+gzxN5VeDWH0Uj9DcueNcV9TBkj/eDHcFZwJKubev29KjP9YPcE
         LLfAH8OhuB1zprnG3Am5Nrwvdz8VEC8whxgPermeDfI8W2m+B7464NwBpG6BwgpQn6TJ
         lELLxv7F0qoL6iliSrTXuPVKyNrXfDGLzaLeVzB4XXeL7GWo3JzdwV2vn51ao8yh4Cqb
         sDA+aST3ZA96bBy79JoiPYtjWv5/2NELViVcI+4fuSlCtaLGPfVIJWUi/poPSVpzEIsr
         2bo/YaXCqcEt/yhTMX+7PyBIGemE0Pn8Z1hIqnbbjt8rmx2pF/0Yk+ASapxt2jU//8xD
         Qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6PPGh6J7iYJHxSY4+xGTOTYJvR4R4wWg+Y+0LcK8cY=;
        b=uByMK/Wp3l8HRlAnM5WDOQcDpaWLeP90d8nRxJZauHy3Okox3OY11OIZ/Ia0/LEGqg
         0C6LXt+e2DVkxtXGwkX9WZSvCzm/FUj3OKNosmyMjUuWGXk+XR9rp0T6Oc4XA5FQUwfF
         NUJXnSwoq9H5a8bZEya2xP7MpITYCgp+8XJuExZIeb68Q70UAxJaNqpNMsx8fsCQA7fe
         e9GEA4rcqY37mphEPcOdgE7PknLeTVzPfiQO6r+gpf4mytAhg6SBfSHAUXil4h7/r/5a
         Yya1XK/2eSWOsmWR+dbsxDzOrPbQRMopc2i7nW17/V+VFEFgN0eoymrdcLvsbdXwh6Fc
         Qqjw==
X-Gm-Message-State: AJcUukers5IQY/z1R81S4cniovG2MMAGw6JXT7MSK8UMAQMIP407H0tL
        du/1Jb3poluNm+yG11vD0lI=
X-Google-Smtp-Source: ALg8bN5YyRchlLPb4ccbs3JZi4cHH6ooVy33Tgc3mGTIu8omjK5PjJfr8WpoOzfSNbMpfo7/qP+crQ==
X-Received: by 2002:adf:d243:: with SMTP id o3mr35874562wri.66.1548945027368;
        Thu, 31 Jan 2019 06:30:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g67sm12118697wmd.38.2019.01.31.06.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 06:30:26 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:30:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Message-ID: <20190131143024.GO23438@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo>
 <s5htvhpax8s.wl-tiwai@suse.de>
 <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
 <s5hh8dpavhw.wl-tiwai@suse.de>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pk/CTwBz1VvfPIDp"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk/CTwBz1VvfPIDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 31 Jan 2019 12:46:54 +0100,
> > Rafael J. Wysocki wrote:
> > >
> > > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > > Thierry Reding wrote:
> > > > >
> > > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> > >
> > > [cut]
> > >
> > > > > > If I understand correctly the code, the pm domain is already ac=
tivated
> > > > > > at calling driver's probe callback.
> > > > >
> > > > > As far as I can tell, the domain will also be powered off again a=
fter
> > > > > probe finished, unless the device grabs a runtime PM reference. T=
his is
> > > > > what happens via the dev->pm_domain->sync() call after successful=
 probe
> > > > > of a driver.
> > > >
> > > > Ah, a good point.  This can be a problem with a probe work like this
> > > > case.
> > > >
> > > > > It seems to me like it's not a very well defined case what to do =
when a
> > > > > device needs to be powered up but runtime PM is not enabled.
> > > > >
> > > > > Adding Rafael and linux-pm, maybe they can provide some guidance =
on what
> > > > > to do in these situations.
> > > > >
> > > > > To summarize, what we're debating here is how to handle powering =
up a
> > > > > device if the pm_runtime infrastructure doesn't take care of it. =
Jon's
> > > > > proposal here was, and we use this elsewhere, to do something lik=
e this:
> > > > >
> > > > >       pm_runtime_enable(dev);
> > > > >       if (!pm_runtime_enabled(dev)) {
> > > > >               err =3D foo_runtime_resume(dev);
> > > > >               if (err < 0)
> > > > >                       goto fail;
> > > > >       }
> > > > >
> > > > > So basically when runtime PM is not available, we explicitly "res=
ume"
> > > > > the device to power it up.
> > > > >
> > > > > It seems to me like that's a fairly common problem, so I'm wonder=
ing if
> > > > > there's something that the runtime PM core could do to help with =
this.
> > > > > Or perhaps there's already a way to achieve this that we're all
> > > > > overlooking?
> > > > >
> > > > > Rafael, any suggestions?
> > > >
> > > > If any, a common helper would be appreciated, indeed.
> > >
> > > I'm not sure that I understand the problem correctly, so let me
> > > restate it the way I understand it.
> > >
> > > What we're talking about is a driver ->probe() callback.  Runtime PM
> > > is disabled initially and the device is off.  It needs to be powered
> > > up, but the way to do that depends on some configuration of the board
> > > etc., so ideally
> > >
> > > pm_runtime_enable(dev);
> > > ret =3D pm_runtime_resume(dev);
> > >
> > > should just work, but the question is what to do if runtime PM doesn't
> > > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
> > > else?
> >
> > Yes, the question is how to write the code for both with and without
> > CONFIG_PM (or CONFIG_PM_RUNTIME).
>=20
> This basically is about setup, because after that point all should
> just work in both cases.
>=20
> Personally, I would do
>=20
> if (IS_ENABLED(CONFIG_PM)) {
>   do setup based on pm-runtime
> } else {
>   do manual setup
> }
>=20
> > Right now, we have a code like below, pushing the initialization in an
> > async work and let the probe returning quickly.
> >
> >         hda_tegra_probe() {
> >                 ....
>=20
> So why don't you do
>=20
> if (!IS_ENABLED(CONFIG_PM)) {
>   do manual clock setup
> }
>=20
> here?

I think that's exactly what Jon and Sameer were proposing, although the
discussion started primarily because of the way it was done.

So basically the idea was to do:

	pm_runtime_enable()
	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
		hda_runtime_resume()

So we're not calling pm_runtime_resume() but rather the driver's
implementation of it. This is to avoid duplicating the code, which under
some circumstances can be fairly long. Duplicating is also error prone
because both instances may not always be in sync.

My understanding is that Takashi had reservations about using this kind
of construct because, well, frankly, it looks a little weird. We'd also
likely want to have a similar construct again in the ->remove() callback
to make sure we properly power off the device when it is no longer
needed. I'm just wondering if perhaps there should be a mechanism in the
core to take care of this, because this is basically something that we'd
need to do for every single driver.

For example, if !CONFIG_PM couldn't the pm_runtime_enable() function be
modified to do the above? This would be somewhat tricky because drivers
usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
that would result in an empty structure if !CONFIG_PM, but we could
probably work around that by adding a __SET_RUNTIME_PM_OPS that would
never be compiled out for this kind of case. Or such drivers could even
manually set .runtime_suspend and .runtime_resume to make sure they're
always populated.

Another way out of this would be to make sure we never run into the case
where runtime PM is disabled. If we always "select PM" on Tegra, then PM
should always be available. But is it guaranteed that runtime PM for the
devices is functional in that case? From a cursory look at the code it
would seem that way.

Thierry

--Pk/CTwBz1VvfPIDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTBn4ACgkQ3SOs138+
s6G4XA/+LliVo6vuvnFmCZ1Afg8ldDBnoTyh5vSoDAOAnpFTyPBGeIzbLz7nTKJ1
xanF3oFKTYkpQcrJ1mndXpt60MsUul33ZfOGfMNzL7GrBzNLpWS+qBfliPnsXNIv
tnqgk7LXgaHhqtIABpqcdoAvMVh+HdC1V6WrYYmnfLP/PiJsLL+wYBcwVcNzpkCv
iEq9XvbCotjuMiWEK1r5WcM20pl6Prspw2gfiOYj1DXaELWEpb6Ky6xTEM9NYMv+
L7hHO4uwvYBoUB1gz8zbpZeaPFWwFzva1/YUBXidthKmSHh/0IO85Ab7izcwTtq+
f4O0svexTB/my3lia+MHWkLnwKTowb7oi/owliXtPU4HIE3YCUzROtnCC9Dz8toO
HWu6xH9IjVgU/0Jb7gDWA2k9drw2kNlvZPrGL8Me+IwmWZJZGzMMCL/IeqJuKOMl
fI6gOoM3iWX8kUN0wiIuMTKUUoaR5guIyfdSa77X4ThqGdFm5oaRw0YbHNcyPiFZ
/xWnlnlwHsArCi1rC9NaJpOV3PmAZwRjrZlB9CV9YtbdDOgfkF356c2W3IfPdWPq
mORoFoqU0EoPbhrDcdprcNgDH80LqRZ5S6+D7SxuFjJ2SrkFmlazkyrYrZZIOBn+
wfdq3iZa1uhAGnhScfcMPO06TZjU/zDhrmPaTZbrNPC9QWQR/mw=
=zXax
-----END PGP SIGNATURE-----

--Pk/CTwBz1VvfPIDp--
