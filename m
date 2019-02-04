Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A64CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207AD20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2Qh1Ar7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfBDIvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:51:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:51:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so13539581wrp.1;
        Mon, 04 Feb 2019 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smf+8VQxGaD0agFVH+QCM6zJIMHDmJkldoxyE2iq9DM=;
        b=H2Qh1Ar7rHMD/pi8sp6tpFehsufrF03mh2VA4vuctdsYhgn5WvUN/8bkXzWNDVtCch
         2jqOLrMLwa0nYLjehmiXSzwXTXftmn9aFJp3rG2OsyK6V1OAGAnfhDXu5eQC5AYCQIzK
         5MIWmWNAQ35/nuSIF1SsyPJXsF1gU/H5MhKHZkHKONQ/RyAS/lOTsqHdbfXDWE3qubd+
         IQzFXUKNqFb7hzRopNi04VgxlQm3D4+hKshfJJzvVl6DKDaOrKv8UGmB1uO3e8zrcgKE
         wKFUgqqh99kpBEj+gtO49Nigy9yol8Fz+83xl8NIrzbU2cL5EeHNfhYyNCunqABx3BX9
         MxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=smf+8VQxGaD0agFVH+QCM6zJIMHDmJkldoxyE2iq9DM=;
        b=AkD+ufLaB0YnL/m8jYvmzFBQQmRR6M5nXe1RQVlmFnjhe6Tm5sFNAPY/G4TdWKv+g2
         n4fg4hf0X45CCSL2PUf1vNFIZTb/gl++USWalOjaipE9Ouc+LcJsEii6buj15WK0y5Hm
         PQlTcXHa7DPuEwc0742c1NUhlJ1tgjZ+EVifEIbcagvfHxaRdm0Z893Hn0fYq0dHx+I6
         W/fx6UyVsm5V534o9TbLpYLL6DwINXwgMqrvu9C/dfojD7VCJMZDuoieTkCSMIj3IWkl
         xsHJZTzAyjCPHiu/BzTIPg0KE2ZhOgRX9GlMpy/KyP1qzzLEqf9yyTQxZvjUbEzU8Nz/
         qTWg==
X-Gm-Message-State: AJcUukf9fvuB6vUUOlGUpuY9T/qI6KJ8uTXLX3TJX9MYQJNYYqELZTD+
        xe0e8Jgnrs5cxEpG0ieikDg=
X-Google-Smtp-Source: ALg8bN6pk2mcT7MOHYJv1BwVSES1igDEmlffZIz+VUBkrwiibvD47NkRmdzserZ/xaHT/wvehI2A3w==
X-Received: by 2002:adf:92c7:: with SMTP id 65mr45345750wrn.228.1549270286824;
        Mon, 04 Feb 2019 00:51:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q14sm9834782wrw.39.2019.02.04.00.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 00:51:26 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:51:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Message-ID: <20190204085125.GG19087@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo>
 <2034694.JE9CgBysmF@aspire.rjw.lan>
 <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 01:46:20PM +0530, Sameer Pujar wrote:
>=20
> On 2/1/2019 4:54 AM, Rafael J. Wysocki wrote:
> > On Thursday, January 31, 2019 3:30:24 PM CET Thierry Reding wrote:
> > > --Pk/CTwBz1VvfPIDp
> > > Content-Type: text/plain; charset=3Dus-ascii
> > > Content-Disposition: inline
> > > Content-Transfer-Encoding: quoted-printable
> > >=20
> > > On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > On Thu, 31 Jan 2019 12:46:54 +0100,
> > > > > Rafael J. Wysocki wrote:
> > > > > > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> w=
rote:
> > > > > > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > > > > > Thierry Reding wrote:
> > > > > > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrot=
e:
> > > > > > [cut]
> > > > > >=20
> > > > > > > > > If I understand correctly the code, the pm domain is alre=
ady ac=3D
> > > tivated
> > > > > > > > > at calling driver's probe callback.
> > > > > > > > As far as I can tell, the domain will also be powered off a=
gain a=3D
> > > fter
> > > > > > > > probe finished, unless the device grabs a runtime PM refere=
nce. T=3D
> > > his is
> > > > > > > > what happens via the dev->pm_domain->sync() call after succ=
essful=3D
> > >   probe
> > > > > > > > of a driver.
> > > > > > > Ah, a good point.  This can be a problem with a probe work li=
ke this
> > > > > > > case.
> > > > > > >=20
> > > > > > > > It seems to me like it's not a very well defined case what =
to do =3D
> > > when a
> > > > > > > > device needs to be powered up but runtime PM is not enabled.
> > > > > > > >=20
> > > > > > > > Adding Rafael and linux-pm, maybe they can provide some gui=
dance =3D
> > > on what
> > > > > > > > to do in these situations.
> > > > > > > >=20
> > > > > > > > To summarize, what we're debating here is how to handle pow=
ering =3D
> > > up a
> > > > > > > > device if the pm_runtime infrastructure doesn't take care o=
f it. =3D
> > > Jon's
> > > > > > > > proposal here was, and we use this elsewhere, to do somethi=
ng lik=3D
> > > e this:
> > > > > > > >        pm_runtime_enable(dev);
> > > > > > > >        if (!pm_runtime_enabled(dev)) {
> > > > > > > >                err =3D3D foo_runtime_resume(dev);
> > > > > > > >                if (err < 0)
> > > > > > > >                        goto fail;
> > > > > > > >        }
> > > > > > > >=20
> > > > > > > > So basically when runtime PM is not available, we explicitl=
y "res=3D
> > > ume"
> > > > > > > > the device to power it up.
> > > > > > > >=20
> > > > > > > > It seems to me like that's a fairly common problem, so I'm =
wonder=3D
> > > ing if
> > > > > > > > there's something that the runtime PM core could do to help=
 with =3D
> > > this.
> > > > > > > > Or perhaps there's already a way to achieve this that we're=
 all
> > > > > > > > overlooking?
> > > > > > > >=20
> > > > > > > > Rafael, any suggestions?
> > > > > > > If any, a common helper would be appreciated, indeed.
> > > > > > I'm not sure that I understand the problem correctly, so let me
> > > > > > restate it the way I understand it.
> > > > > >=20
> > > > > > What we're talking about is a driver ->probe() callback.  Runti=
me PM
> > > > > > is disabled initially and the device is off.  It needs to be po=
wered
> > > > > > up, but the way to do that depends on some configuration of the=
 board
> > > > > > etc., so ideally
> > > > > >=20
> > > > > > pm_runtime_enable(dev);
> > > > > > ret =3D3D pm_runtime_resume(dev);
> > > > > >=20
> > > > > > should just work, but the question is what to do if runtime PM =
doesn't
> > > > > > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or som=
ething
> > > > > > else?
> > > > > Yes, the question is how to write the code for both with and with=
out
> > > > > CONFIG_PM (or CONFIG_PM_RUNTIME).
> > > > =3D20
> > > > This basically is about setup, because after that point all should
> > > > just work in both cases.
> > > > =3D20
> > > > Personally, I would do
> > > > =3D20
> > > > if (IS_ENABLED(CONFIG_PM)) {
> > > >    do setup based on pm-runtime
> > > > } else {
> > > >    do manual setup
> > > > }
> > > > =3D20
> > > > > Right now, we have a code like below, pushing the initialization =
in an
> > > > > async work and let the probe returning quickly.
> > > > >=20
> > > > >          hda_tegra_probe() {
> > > > >                  ....
> > > > =3D20
> > > > So why don't you do
> > > > =3D20
> > > > if (!IS_ENABLED(CONFIG_PM)) {
> > > >    do manual clock setup
> > > > }
> > > > =3D20
> > > > here?
> > > I think that's exactly what Jon and Sameer were proposing, although t=
he
> > > discussion started primarily because of the way it was done.
> > >=20
> > > So basically the idea was to do:
> > >=20
> > > 	pm_runtime_enable()
> > > 	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
> > But why is it any better than checking !IS_ENABLED(CONFIG_PM) directly?
> >=20
> > > 		hda_runtime_resume()
> > >=20
> > > So we're not calling pm_runtime_resume() but rather the driver's
> > > implementation of it. This is to avoid duplicating the code, which un=
der
> > > some circumstances can be fairly long. Duplicating is also error prone
> > > because both instances may not always be in sync.
> > >=20
> > > My understanding is that Takashi had reservations about using this ki=
nd
> > > of construct because, well, frankly, it looks a little weird.
> > Yes, the way it was originally written above was weird, but is checking
> > IS_ENABLED(CONFIG_PM) directly really so weird?
> >=20
> > > We'd also likely want to have a similar construct again in the ->remo=
ve()
> > > callback to make sure we properly power off the device when it is no =
longer
> > > needed.
> > Sure.  Again, why don't you make it conditional on IS_ENABLED(CONFIG_PM=
)?
> >=20
> > > I'm just wondering if perhaps there should be a mechanism in the
> > > core to take care of this,
> > How exactly?  How's the core going to know what to do when CONFIG_PM is
> > disabled?
> >=20
> > > because this is basically something that we'd need to do for every si=
ngle
> > > driver.
> > That is not true.  If the device is alwyas "on" to start with, you don't
> > need to do anything.  That's the case on many systems.
> >=20
> > > For example, if !CONFIG_PM couldn't the pm_runtime_enable() function =
be
> > > modified to do the above?
> > But you'd need to pass a pointer to your hda_runtime_resume() to it at =
least
> > and how's that simpler than using a simple conditional directly?
> >=20
> > > This would be somewhat tricky because drivers
> > > usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
> > > that would result in an empty structure if !CONFIG_PM, but we could
> > > probably work around that by adding a __SET_RUNTIME_PM_OPS that would
> > > never be compiled out for this kind of case. Or such drivers could ev=
en
> > > manually set .runtime_suspend and .runtime_resume to make sure they're
> > > always populated.
> > >=20
> > > Another way out of this would be to make sure we never run into the c=
ase
> > > where runtime PM is disabled. If we always "select PM" on Tegra, then=
 PM
> > > should always be available. But is it guaranteed that runtime PM for =
the
> > > devices is functional in that case? From a cursory look at the code it
> > > would seem that way.
> > If you select PM, then all of the requisite code should be there.
> >=20
> > Alternatively, you can make the driver depend on PM.
> Objective is to have things working with or without CONFIG_PM enabled.
> From previous comments and discussions it appears that there is mixed
> response
> for calling hda_tegra_runtime_resume() or runtime PM APIs in probe() call.
> Need
> to have consensus regarding the best practice to be followed, which would
> eventually
> can be used in other drivers too.
>=20
> Rafael is suggesting to use CONFIG_PM check to do manual setup or runtime=
 PM
> setup in probe,
> which would bring back the earlier above mentioned concern.
>=20
> if (IS_ENABLED(CONFIG_PM)) {
> do setup based on pm-runtime
> } else {
> =C2=A0=C2=A0=C2=A0 do manual setup
> }
> Both if/else might end up doing the same here.
> Do we really need CONFIG_PM check here?
>=20
> Instead does below proposal appear fine?
>=20
> probe() {
> =C2=A0=C2=A0=C2=A0 hda_tegra_enable_clock();
> }
>=20
> probe_work() {
> =C2=A0=C2=A0=C2=A0 /* hda setup */
> =C2=A0=C2=A0=C2=A0 . . .
> =C2=A0=C2=A0=C2=A0 pm_runtime_set_active(); /* initial state as active */
> =C2=A0=C2=A0=C2=A0 pm_runtime_enable();
> =C2=A0=C2=A0=C2=A0 return;
> }
>=20
> remove() {
> =C2=A0=C2=A0=C2=A0 pm_runtime_disable();
> =C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended())
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hda_tegra_runtime_suspend(); /* tak=
es care of both CONFIG_PM
> enable/disable case */
> }
>=20
> One of the other concern was, remove() and probe() do not appear to be in
> sync, because in probe() hda_tegra_enable_clock()
> is called and in remove() there is hda_tegra_runtime_suspend() to
> effectively disable clock.
> IMO, this should be ok since it can avoid duplication and proper comment =
can
> be added here for clarity.
> Alternatively we can call hda_tegra_runtime_resume() in probe()
> unconditionally to avoid confusion.
>=20
> Another point Thierry mentioned was, after successful probe() power-domain
> would be turned OFF. It seems Rafael had a different
> view. I am little confused here. Kindly clarify if above proposal seems
> fine.

We're wasting an awful lot of time over the discussion of something that
I think is of questionable usefulness. I propose we do the below and can
forget about this once and for all.

Thierry

--- >8 ---
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 7f3b83e0d324..51a8fa3566ef 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select PM
 	select PM_OPP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX/Q0ACgkQ3SOs138+
s6Hs/g/9FmgXwahgpeGPZIj6OWvEsiQYSUp0yjxQj04la/tI+xNPM8JlQacRJfRm
TsOgcgV40UheK/NJw3QI8PdlaynyM/LaxOwZUMXunWvpb05S5tZznQXQEq/R5uia
8eLr4b6mBcg2W+bFHPJbbwM899uteZBfEGnNvu3if6f5kNMXGrIy2AyBZ72HSCso
5+4BXYMDQKJVBuXBhCCxufG5v4QyjEp/djZayZvHYXI1lTBJYq0CCeOanAqIfZUd
FwtwYkUm7ybwtkdKv73z+prgx3RxjQgx0SJpH/BzPGNKoa/kCo+cyGkP1k4nWcMH
wrM+mv5NSVb1/M42EQwsFwLFeXn7BVdy9Ma5znuY65/CuT1DNWTkRQ7lYWO3dGvx
8WsLs0RpvTNlOCQv6zSN6gdoNin29g0NgXrSZEb+Zmv49buzCJEEEIFXaED7zBXA
/HL4Qs8GYSbfpncjbA1KgRhaVzrVNChvGDECCNZs0FOp1+FuoDn7ewK3pTdYc+IL
omKQNdaCJ9I4LCiXX5D/uCsV9gPugXu4nwlb9AA045XTHkgRbKpo0PI78Xh8caQJ
LYPDSyI3qACfEg+pPMSvLD4Pf9lHo/Ks/+zgkeR9w1zAx7fTAx+1pbdDTKyPpi8z
Ia+66iACS5ruf8/Sar/MJaDTM1jInoNf61uFsFS1lc3iLiyg/o4=
=hKmq
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
