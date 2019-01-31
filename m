Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BD2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7429E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCyLQJkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfAaLFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:05:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39715 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAaLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:05:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so2054046wmi.4;
        Thu, 31 Jan 2019 03:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7aWYIeDSRu37qcvD91X+mq+QeqQ7LiZZhZ13fw7hToQ=;
        b=BCyLQJkQT8xTWi3+Tob/nuokrm3kEg4ZNjEkVRzGm3hYoTTDAtP5TGRdOo7Lxev8hn
         2N9Lyf0NLGZsRYyC9u7eT9E/X2GkTZ2xq4SNfYJ88Ed3LshbgcR7ZHidhYHEC8FncQwS
         ds/1mbhhzbQ35zVVUbcajOlzMwU3637B/5luBg7vlBZc3Khu6uFwb46KEHpjothlxvY+
         vrPgoFheAONgWdGqiqMJD00cRrx7yOJKTD442QsymF6CcxrVjW55Zc6HgIyj04GhvQt9
         mtP3eTb9o7MGhjBDPvCknX3xF+HgU7eGilB9OTRuse+47wdBl7zKN9FFnpjKo3EBsfpL
         aM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7aWYIeDSRu37qcvD91X+mq+QeqQ7LiZZhZ13fw7hToQ=;
        b=Bxl6A6ydaK+xEcCGKUL9bv74Npzaf7hYubYaynIk5IV5fOf7rDh8xpvCeasa7bJC7o
         gkRjkszOUthyvO14AGUCb2WFM3/lW7AV6rK4HQnXYUga4Elt8aOaUuWf0wQNUThlqRRX
         z5feU8n5lC3mmukrt9Uy9FI1Z6IOtC5oe1VItgm5eiZmgu4UYNqV+TLfgOX+CLxjDtg+
         90ZnZsGwZgUNrmqHfYidqUkDa13kAhqpDO8X4BtxxTBPPu+oaFkWPaKyFl2M5rz8RfYV
         dpNuEjicno9J6jTOprhgr0u3xoIvKawAy+eVJigFTtO7g3aEfAXamsxmOdalQKqT2YKS
         TkKA==
X-Gm-Message-State: AJcUukc/UgLPQmTG7YlsXayTXepW8XHpzVagrmte5U1qskXq66VbuxVv
        FYkcSfQ+Fi6ah7WHbUyIm6Q=
X-Google-Smtp-Source: ALg8bN48D9M8sncpprcbTCWTiFEzMUf9GpCRFfcZ+HIYbxxMn6cElCsdBgc5veXZHSGxYmDN5abTZQ==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr28774121wmf.14.1548932733397;
        Thu, 31 Jan 2019 03:05:33 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v8sm5150081wrq.53.2019.01.31.03.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 03:05:32 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:05:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        pierre-louis.bossart@linux.intel.com,
        Sameer Pujar <spujar@nvidia.com>, perex@perex.cz,
        alsa-devel@alsa-project.org, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Message-ID: <20190131110530.GA23438@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <s5ha7jicd4l.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> On Wed, 30 Jan 2019 13:45:49 +0100,
> Jon Hunter wrote:
> >=20
> >=20
> > On 25/01/2019 11:06, Sameer Pujar wrote:
> > > If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
> > > will not be ON. This could cause issue during probe, where hda init
> > > setup is done. This patch enables clocks unconditionally during probe.
> > >=20
> > > Along with above, follwoing changes are done.
> > >   * enable runtime PM before exiting from probe work. This helps to a=
void
> > >     usage of pm_runtime_get_sync/pm_runtime_put() in probe work.
> > >   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
> > >   * runtime PM callbacks moved out of CONFIG_PM check
> > >=20
> > > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > > Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  sound/pci/hda/hda_tegra.c | 26 +++++++++++++++++---------
> > >  1 file changed, 17 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> > > index c8d18dc..ba6175f 100644
> > > --- a/sound/pci/hda/hda_tegra.c
> > > +++ b/sound/pci/hda/hda_tegra.c
> > > @@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_teg=
ra *data)
> > >  	return rc;
> > >  }
> > > =20
> > > -#ifdef CONFIG_PM_SLEEP
> > >  static void hda_tegra_disable_clocks(struct hda_tegra *data)
> > >  {
> > >  	clk_disable_unprepare(data->hda2hdmi_clk);
> > > @@ -227,6 +226,7 @@ static void hda_tegra_disable_clocks(struct hda_t=
egra *data)
> > >  	clk_disable_unprepare(data->hda_clk);
> > >  }
> > > =20
> > > +#ifdef CONFIG_PM_SLEEP
> > >  /*
> > >   * power management
> > >   */
> > > @@ -257,7 +257,6 @@ static int hda_tegra_resume(struct device *dev)
> > >  }
> > >  #endif /* CONFIG_PM_SLEEP */
> > > =20
> > > -#ifdef CONFIG_PM
> > >  static int hda_tegra_runtime_suspend(struct device *dev)
> > >  {
> > >  	struct snd_card *card =3D dev_get_drvdata(dev);
> > > @@ -283,7 +282,7 @@ static int hda_tegra_runtime_resume(struct device=
 *dev)
> > >  	int rc;
> > > =20
> > >  	rc =3D hda_tegra_enable_clocks(hda);
> > > -	if (rc !=3D 0)
> > > +	if (rc)
> > >  		return rc;
> > >  	if (chip && chip->running) {
> > >  		hda_tegra_init(hda);
> > > @@ -292,7 +291,6 @@ static int hda_tegra_runtime_resume(struct device=
 *dev)
> > > =20
> > >  	return 0;
> > >  }
> > > -#endif /* CONFIG_PM */
> > > =20
> > >  static const struct dev_pm_ops hda_tegra_pm =3D {
> > >  	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
> > > @@ -551,9 +549,9 @@ static int hda_tegra_probe(struct platform_device=
 *pdev)
> > > =20
> > >  	dev_set_drvdata(&pdev->dev, card);
> > > =20
> > > -	pm_runtime_enable(hda->dev);
> > > -	if (!azx_has_pm_runtime(chip))
> > > -		pm_runtime_forbid(hda->dev);
> > > +	err =3D hda_tegra_enable_clocks(hda);
> > > +	if (err)
> > > +		goto out_free;
> >=20
> > We also need to think about power-domains here. Enabling the clocks
> > might not be enough as the appropriate power-domain needs to be enabled.
> > For 64-bit Tegra runtime-pm will handle the power-domains (assuming they
> > are populated in device-tree). So I still think it is better we call
> > pm_runtime_get_sync() at some point rather than just replying on
> > enabling the clocks.
>=20
> If I understand correctly the code, the pm domain is already activated
> at calling driver's probe callback.

As far as I can tell, the domain will also be powered off again after
probe finished, unless the device grabs a runtime PM reference. This is
what happens via the dev->pm_domain->sync() call after successful probe
of a driver.

It seems to me like it's not a very well defined case what to do when a
device needs to be powered up but runtime PM is not enabled.

Adding Rafael and linux-pm, maybe they can provide some guidance on what
to do in these situations.

To summarize, what we're debating here is how to handle powering up a
device if the pm_runtime infrastructure doesn't take care of it. Jon's
proposal here was, and we use this elsewhere, to do something like this:

	pm_runtime_enable(dev);
	if (!pm_runtime_enabled(dev)) {
		err =3D foo_runtime_resume(dev);
		if (err < 0)
			goto fail;
	}

So basically when runtime PM is not available, we explicitly "resume"
the device to power it up.

It seems to me like that's a fairly common problem, so I'm wondering if
there's something that the runtime PM core could do to help with this.
Or perhaps there's already a way to achieve this that we're all
overlooking?

Rafael, any suggestions?

Thanks,
Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS1ngACgkQ3SOs138+
s6E8rBAAjzQAb31XTYdEsyXIwYmUXSryCimpXWKM58O4tV5wB8ulcFJDv5t87O4Z
EfnmuVlQCFdXx1nbx6YIAHgOalzCjnhW16DUHOr7JDagX9xAjwqV0DRpBXfhp4/S
fDb0zmeB3/Ecub3Oquh3dd2Fu/6AuULZR49XKszlbpoxk20q8VaeV6DI0U6VkudY
isXcsjw6cPg1E1JpiZNYRYX5VEMvVRVYpz6zcVsz8RxkUWHgVuk0OI8izlJ6CbXK
87bCjWty7fgW7Iz7tgJzSPo+pHo/9Jlns4zZkHTkX2+y7CE2jYpM+FwaiVVovcu3
7mRapuI6np7t4YSRii/zdaPff39K1vtWo/NUJToufL7bI81MyNXTKkjC5n4+p9un
xr8Mx+biAKFszOa1FU2WwkjOWZeeuQkPpo5mVOgXzPD1ObPGzsPqvdmUtmSao+31
/s51KWvTsA0qpc80WM9xcq8Yu/VPQJvHOj4Al6fuBTXhfGL1sQKduMuKztYgZM6m
C+KIFp3i4ddtb/VbwR1S4vw5ccI7Y1baw1k5F6ozpEpaFsie4VYuZuN5QXLgWw4Q
texUkRLnZdZw32yKxyg0+e2co6ZbImRasciw/y8kYHc+Alxmhkl3RMWgEqyb36f7
gyyD5Xf1EgPDCq2l9GDQGDAajPJr4v8wVtuEdcyZd4XEHLhQHno=
=lotk
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
