Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F34C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997FE2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHuqNxtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfBDLFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:05:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfBDLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:05:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so12895665wmf.5;
        Mon, 04 Feb 2019 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V4R1B+WpjXBZ+afYTx7lLgfDZ7dxM8MhztSezDWYPRY=;
        b=EHuqNxtEVu9cn/3dPZV+i3XNm3pjnbfpxAbFVK7uRMzzwndti7wuJpqymOMWH65NJi
         tJE+kUDLc7ppggNcDMpZOCDsAlG+8Y1A4MNlqfS+KH7Ax4oDif9HDF7ZSOOc7jKt8Uo+
         qL/sJWvlvgauy3tRBV1MPAC9jysiOKXbd4dw1OpDf00fsam7Ur/uHkFo0+YaX3MAbO7B
         HGNxUTUnyP9JmO4aZYLqqi8+fJsxIoeovECfa/mE+tjEqYM/a6/7sL9eqiYFg0AjUNcY
         mlBVFt0HCK3mQb6jsKH44GuwaFYAo12qB0Ln9WBoB6ojvEuUc/dbhMZiAoB1QYEuvKmN
         s/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V4R1B+WpjXBZ+afYTx7lLgfDZ7dxM8MhztSezDWYPRY=;
        b=nYnsId2tUMPaE1asb1ejfcwFM/dZEG1JxdLVSzPepl/HE48SZtRhlIE1S1A5eQMsUY
         AlkZjBiJK9LpNk56oQrsmtWz8yeQz1pCDQDT54BxkKIdWXRGVPJleFrx7efepgKffxaM
         Kih4zj9WTEAS7Tambamk6X9v0tdaZGg+XUaXvkubyQSd9aIpir6k4I3DHgBdSLMIO/Fj
         fuL9fCcBQb9rJb1aop1KTcIk7t3MWRXpuK+T75dMT0LPxyoU4GFDOQhxPMdx/fdqECSN
         95OPdiqojD8Vy3LY/B6ZHfwpJsKdn4r1fC22k5GlWQfpQq5bAV9eUbkNLhzr+VheDm8S
         mp/Q==
X-Gm-Message-State: AHQUAuZ+7tK3la2EPEyZ7qbk8cJTtulDOxrMW+h/gSKZmEbUthJG4H8F
        roIy5OitLaTJPZOWTohdRYU=
X-Google-Smtp-Source: AHgI3Ib0z4AO9+0NiTYcqK7+v3VNNcrT9mejZI4V35F0eVo4io2IoojgLYKomAvUv9S9tEi9M3A7Nw==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr12301235wmk.47.1549278311846;
        Mon, 04 Feb 2019 03:05:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y145sm8419327wmd.30.2019.02.04.03.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 03:05:11 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:05:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Message-ID: <20190204110510.GA10412@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo>
 <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
 <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
>=20
>=20
> On 04/02/2019 08:45, Thierry Reding wrote:
>=20
> ...
>=20
> > The idea was, as I was saying below, to reuse dev_pm_ops even if
> > !CONFIG_PM. So pm_runtime_enable() could be something like this:
> >=20
> > 	pm_runtime_enable(dev)
> > 	{
> > 		if (!CONFIG_PM)
> > 			if (dev->pm_ops->resume)
> > 				dev->pm_ops->resume(dev);
> >=20
> > 		...
> > 	}
> >=20
> > But that's admittedly somewhat of a stretch. This could of course be
> > made somewhat nicer by adding an explicit variant, say:
> >=20
> > 	pm_runtime_enable_foo(dev)
> > 	{
> > 		if (!CONFIG_PM && dev->pm_ops->resume)
> > 			return dev->pm_ops->resume(dev);
> >=20
> > 		return 0;
> > 	}
> >=20
> > Maybe the fact that I couldn't come up with a good name is a good
> > indication that this is a bad idea...
>=20
> How about some new APIs called ...
>=20
> pm_runtime_enable_get()
> pm_runtime_enable_get_sync()
> pm_runtime_put_disable() (implies a put_sync)
>=20
> ... and in these APIs we add ...
>=20
> pm_runtime_enable_get(dev)
> {
> 	if (!CONFIG_PM && dev->pm_ops->resume)
> 		return dev->pm_ops->resume(dev);
>=20
> 	pm_runtime_enable(dev);
> 	return pm_runtime_get(dev);
> }

Yeah, those sound sensible. I'm still a bit torn between this and just
enforcing PM. At least on the display side I think we already require PM
and with all the power domain work that you did we'd be much better off
if we could just get rid of the !PM workarounds.

> >>> This would be somewhat tricky because drivers
> >>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
> >>> that would result in an empty structure if !CONFIG_PM, but we could
> >>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
> >>> never be compiled out for this kind of case. Or such drivers could ev=
en
> >>> manually set .runtime_suspend and .runtime_resume to make sure they're
> >>> always populated.
> >>>
> >>> Another way out of this would be to make sure we never run into the c=
ase
> >>> where runtime PM is disabled. If we always "select PM" on Tegra, then=
 PM
> >>> should always be available. But is it guaranteed that runtime PM for =
the
> >>> devices is functional in that case? From a cursory look at the code it
> >>> would seem that way.
> >>
> >> If you select PM, then all of the requisite code should be there.
> >=20
> > We do this on 64-bit ARM, but there had been some pushback when we had
> > proposed to do the same thing on 32-bit ARM. I think there were two
> > concerns:
> >=20
> > 	1) select PM would force the setting for all platforms on multi-
> > 	   platforms builds
> >=20
> > 	2) prevents anyone from disabling PM for debugging purposes
> >=20
> > 1) no longer seems to be valid because Rockchip already selects PM
> > unconditionally. I'm not sure if 2) is valid anymore either. I haven't
> > run a build with !PM in a very long time and I wouldn't be surprised if
> > that was completely broken.
> >=20
> > Maybe we need to try this again since a couple of years have elapsed and
> > runtime PM support on Tegra is much more mature at this point.
> >=20
> >> Alternatively, you can make the driver depend on PM.
> >=20
> > That's probably the easiest way out, but to be honest I think I'd prefer
> > to just enforce PM and keep things simple.
> >=20
> > Jon, any objections?
>=20
> None, but seems overkill just for this case.

But that's precisely the point. It's not just about this case. We've
already got some drivers where we do a similar dance just to be able to
support the, let's admit it, exotic case where somebody turns off PM. I
think supporting !PM might have made sense at a point where we had no
support for power management at all. But I think we've come a long way
since then, and while we may still have some ways to go in some areas,
we do fairly decent runtime PM most of the time, to the point where I no
longer see any benefits in !PM.

Thierry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYHGMACgkQ3SOs138+
s6Gx3w//XJu+ERF3qvtbn607pHgfD4SfNiWNCog4IPuO8zYEdQQ0YdGjDusNOUBV
m3tMjat2semb69xdMr4/H7DiINvFVLw/s/WBvkKVw8/XH3C3jP23zD0lkgODn/f1
HKLdxeAWrQ8BgJmoyoOl1pQ8jfKsM161C+dRI/4eDgvwxvyLYWAOt/oVgKQbeHwl
ySRh2tfcit7yb2YwJFsUgyXAtipZNXmSeNfKg/ozSUaMlYfxUAAwiPZRa053LLsm
L41MRflToeqrRfA5mNKRR7xz6pASP60V+MGPh8BSZIYvlwBLnk2qxP29ovG6br20
Yz3YjoKU0QyqgqdxLWbdrVYLGhr0vGH4MnHnW82wjd4HbRdyesUVgszGyRPWVmj5
/NstNMPwjMhtzQZu38x0xY7KttUeADGePgcs/qiysXxLeYX9vjLAiSzMF9PjgDMf
zltaMxogr7nVN0PDZ8J5nTVhP92zqCFskA5VsnVp1/Fq+6Tq9GVINB5FKjfDQiaK
wO/LtvjSIhHBJGePNFyakwh7NCdsaj49P0PGP81T+N5XC2V8+i0ObY15Ur1HsRvH
EYdlr+dcCeu2x9PXvkrXgVpSZ5kpewUc/3mlMo/ndNlZzX3zrXYCXP4B7E1jDuwX
kEnZ/O+1yTAKYSCdT3yBveUBiOmxml+2+/h0UIRHkKyvk5i2KeQ=
=oPAV
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
