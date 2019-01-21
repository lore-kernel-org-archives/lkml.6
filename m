Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5DDC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5F214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV8xsO5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAULzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:55:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfAULy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:54:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so22989400wra.6;
        Mon, 21 Jan 2019 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2bckD1+snFGOGZZCiG2lnZXT6WWcXhgG/DQ4ROHN98=;
        b=FV8xsO5l2YN5swp7+nh7GiRQl0NbcjTTDxsC3Hoc3jQLRje0Raek6qtCxzoJVTKYWE
         UInwOHNDRbEHUIMdZDT9B767cKjMd+ii+su+zeIvUJggpuZH5AJQ7vBom33AM9VmEW0r
         VofxvfdklHuqGY86+yPehEs8Tso7hz20ebcRIQhJHayGprDCnz2j0ysPMaJTPNUuxxRG
         y0l69u9tyOtBPaJYmjsG98tOTBghk6FoPbhiwIvMJ+IS5jkcdmq/1HHZ3xhwWQUakXG6
         LHah4vjHcOe+lmRoSmSwR5ek7y1QHPQsvpNK80OQOHxRNacD2mJODTcwJYLqHdIqhvpj
         ZvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2bckD1+snFGOGZZCiG2lnZXT6WWcXhgG/DQ4ROHN98=;
        b=AUP/4siWc54TGNbTepFJqsXUhJmsxDp/3/CKGLH3vpOQtkwPmQOqpAZRTrBrUB7ShW
         RWIVK12PW/x3NwOZy4ghx9kfOgPfTtLdWYezOghDBF2utpPV8vlFkc5JtXX4dmXCGqr6
         MFAWl2nOQyYogYh6Rswz5DRIgumGMTL2LCXwpIuvNGGNp6gVec6WyPUY2PP9ZDfgFSSD
         2Q3MU7JueQ5N15WCNnNy5sGFT1QNs8eoNJ2lP0BNBp2DUFOrScIGevBm7VKTbI7uqK9r
         evwBLgykhKyzNe1XtlNgOHScUiRfzxUxx0o/Ef9pGSOaJ+rLkOz4T6cZHHJs9yzRrZRG
         SlLQ==
X-Gm-Message-State: AJcUukdV/QYtmPM1kefofoLyRVdTG3UdNxVT501OXFDKfKOVqMvcE+UF
        BnFmgJStWK7lDCzspAwb4Qw=
X-Google-Smtp-Source: ALg8bN6AROHyYTpHAaLX3YniDNqNxrJXlsEEK+YEJd6rkXKjqMaxUWEbP5LdUQv/b2LFY7CMpaTMSw==
X-Received: by 2002:adf:f401:: with SMTP id g1mr28580931wro.103.1548071697629;
        Mon, 21 Jan 2019 03:54:57 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s5sm31880468wmh.37.2019.01.21.03.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:54:56 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:54:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190121115455.GJ16756@ulmo>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
 <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
 <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
 <20190117081956.hpj4ewdihpwuoonz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <20190117081956.hpj4ewdihpwuoonz@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 09:19:56AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Paul,
>=20
> On Wed, Jan 16, 2019 at 11:29:35AM -0800, Paul Walmsley wrote:
> > COMPILE_TEST made slightly more sense before the broad availability of=
=20
> > open-source soft cores, SoC integration, and IP; and before powerful,=
=20
> > inexpensive FPGAs and SoCs with FPGA fabrics were common.
> >=20
> > Even back then, COMPILE_TEST was starting to look questionable.  IP blo=
cks=20
> > from CPU- and SoC vendor-independent libraries, like DesignWare and the=
=20
> > Cadence IP libraries, were integrated on SoCs across varying CPU=20
> > architectures.  (Fortunately, looking at the tree, subsystem maintainer=
s=20
> > with DesignWare drivers seem to have largely avoided adding architectur=
e=20
> > or SoC-specific Kconfig restrictions there - and thus have also avoided=
=20
> > the need for COMPILE_TEST.)  If an unnecessary architecture Kconfig=20
> > dependency was added for a leaf driver, that Kconfig line would either=
=20
> > need to be patched out by hand, or if present, COMPILE_TEST would need =
to=20
> > be enabled.
> >=20
> > This was less of a problem then.  There were very few FPGA Linux users,=
=20
> > and they were mostly working on internal proprietary projects. FPGAs th=
at=20
> > could run Linux at a reasonable speed, including MMUs and FPUs, were=20
> > expensive or were missing good tool support.  So most FPGA Linux=20
> > development was restricted to ASIC vendors - the Samsungs, Qualcomms,=
=20
> > NVIDIAs of the world - for prototyping, and those FPGA platforms never=
=20
> > made it outside those companies.
> >=20
> > The situation is different now.  The major FPGA vendors have inexpensiv=
e=20
> > FPGA SoCs with full-featured CPU hard macros.  The development boards c=
an=20
> > be quite affordable (< USD 300 for the Xilinx Ultra96).  There are also=
=20
> > now open-source SoC HDL implementations - including MMUs, FPUs, and=20
> > peripherals like PWM and UART - for the conventional FPGA market.  Thes=
e=20
> > can run at mid-1990's clock rates - slow by modern standards but still=
=20
> > quite usable.
>=20
> In my eyes it's better to make a driver not possible to enable out of
> the box than offering to enable it while it most probably won't be used.

This might sound like a good idea in general, but it's also something
that is pretty much impossible to do. There's just no heuristic that
would allow you to determine with a sufficient degree of probability
that a driver won't be needed. Most of the PCI drivers that are
installed on my workstation aren't used, and I would venture to say
there are a lot of drivers that aren't used in, say, 95% of
installations. That doesn't mean that we should somehow make these
drivers difficult to install, or require someone to patch the kernel
to build them.

> People who configure their own kernel and distribution kernel
> maintainers will thank you. (Well ok, they won't notice, so they won't
> actually tell you, but anyhow.) I'm a member of the Debian kernel team
> and I see how many config items there are that are not explicitly
> handled for the various different kernel images. If they were restricted
> using COMPILE_TEST to just be possible to enable on machines where it is
> known (or at least likely) to make sense that would help. Also when I do
> a kernel version bump for a machine with a tailored kernel running (say)
> on an ARM/i.MX SoC, I could more easily be careful about the relevant
> changes when doing oldconfig if I were not asked about a whole bunch of
> drivers that are sure to be irrelevant.

I think the important thing here is that the driver is "default n". If
you're a developer and build your own kernels, you're pretty likely to
know already if a new kernel that you're installing contains that new
driver that you've been working on or waiting for. In that case you can
easily just enable it manually rather than go through make oldconfig and
wait for it to show up.

As for distribution kernel maintainers, are they really still building a
lot of different kernels? If so, it sounds like most of the multi-
platform efforts have been in vain. I would imagine that if, as a
distribution kernel team, you'd want to carefully evaluate for every
driver whether or not you'd want to include it. I would also imagine
that you'd want to provide your users with the most flexible kernel
possible, so that if they do have a system with an FPGA that you'd make
it possible for them to use pwm-sifive if they choose to synthesize it.

If you really want to create custom builds tailored to a single chip or
board, it's going to be a fair amount of work anyway. I've occasionally
done that in the past and usually just resorted to starting from an
allnoconfig configuration and then working my way up from there.

As for daily work as a developer, when I transition between kernel
versions, or from one linux-next to another, I typically end up doing
the manual equivalent of:

	$ yes '' | make oldconfig

if I know that I'm not interested in any new features. But I also often
just look at what's new because it's interesting to see what's been
going on elsewhere.

Thierry

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFsw0ACgkQ3SOs138+
s6GNbg//X2cHx6MggoF4ietANVc9LVW8Bw6/XohO0dLUy5qlwnhnFxt7AhCeczQ/
RKBciwJzq7iLy6TozjXxVRvtZKUWLmOQ3R6cckDv5NVNl3W+snuEh8w/2JTUArGS
o9wIM90cpPBIfhfBadz/kxoOqtOBy0FiYokoyaykm+jPbNh2uQzQx0n+LiqHfoV0
on3t3n9YrjPYHKC9VTpb8hsaFGDi8EhXqxaaXs4DlKboz6ezIYAi5o3ObLhI3aRs
4fk1T63gWIlwb2qteXGAMdFsJGBzHtALwrZFxJQ1M3GWnyz/JkbCGTvLlsbdNA4V
HheD38F+geoAaK+j5RdESJw1vWkX1w/GqoN9njwEod8kEfzbhpnPofm0U5WSwkvU
GFtRzVD1iC2Qn/U3YtiZu3UbFF+LVadBp7lk8vX/mqKsUdYdlA7esgCGOKVmsxNk
AFm4R+frtEZwf1gG5BVOw3LeZFPGT2Om1wOIawdxbfyGnrQl2dsPuo97jjqcZ90+
T9F6s1jel/OVnJhWwzCdZi7sf/swwLyeoYn3vd+PWiT2WhRaDMygwg/KtVoY+or8
1G+AKQSLDbh618/ck/La6VSssIMfwwVdAyD4t9eQtKiR48N6JobgkQwumvyFpllF
a7zVRytrnwgDFRSkayIJGz+faQRJ68vwePKlxQPH1Sy2POhAdn4=
=dNnQ
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
