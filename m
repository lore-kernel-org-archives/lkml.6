Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id inszMKOaHlsyYgAAmS7hNA
	; Mon, 11 Jun 2018 15:53:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8CDB260791; Mon, 11 Jun 2018 15:53:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOcJqXKf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8E3D607A4;
	Mon, 11 Jun 2018 15:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8E3D607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeFKPxu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:53:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35159 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeFKPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:53:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so20961679wrn.2;
        Mon, 11 Jun 2018 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Ko8To+hLTmQyyIxDrtq4tokmn6w7+Fqa/OksUCiZDY=;
        b=bOcJqXKfHKMSQVl92HAMj9eC4JUrhKgEfES7setXaP1HGf89yDQ6JIEIu/aXYlOv6o
         uxUAw9OZF/+zYjc5WzFV2dSG1oUgkiTOCK1XYQqw59p/IX3uvlhPYgA+yezCYeTQK0Pv
         UEDGGLrmCZKWHrOhlsBidZXibEdx1wjUrt4uZejV2VC5jkTC8a7jmWiyMZyEA7vavzp/
         WE9nGCfMkqOyF+SZ52voR232iMh50HfGQ7Y6uz07gdxcc5ckR1z/uOmldJ6OMmHGYrv1
         xs0nnkSu08FC+PvA9hQ+PM/fIR82V9uD5RIsFC65oO6LjPNZLbkUUBoyA+jH75OiFKYP
         KPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Ko8To+hLTmQyyIxDrtq4tokmn6w7+Fqa/OksUCiZDY=;
        b=HvEP960vhkPitw7PABe5JYfQGQCTdEPKtPpm7odS/3+MjCBtWbTkUydzSwlUtHsHxz
         ZTctHgv5QQfoiYQy8bd4MXDk4g8e5mm3qks2pntIEpukeNGVUQmBXRjU96R0T6WuQVSu
         PEsHISCtDoAxLb7BA5+/HZEdzlBBsfvHfrsEcda8anAAqc7DHPtixv9rONs8HLdthFfl
         3QjUOv+tgmQnxN7Ud6uWJaFP60oQ/4RH0nv0GoFp7QaoFBSL6K7G7uEl92FZOBmbRhIJ
         xDsEntNow8DfHtXceMDknhaq2J9Ign93sfpwO+xozuRwL2IT4F7keh16GVWZ/65E1DUc
         g3IQ==
X-Gm-Message-State: APt69E1Yx89mrgc6FoywTaW214yT+bw3hCkrM4giovMXKOam/gbjVhph
        l4Osqh5EuTt7SGHgM0Ei3CI=
X-Google-Smtp-Source: ADUXVKKw1MnllhbkRzl89zd56KzGgSOmBNIoJhpFAycBJAj2uJoG94lNogTKv6YD2ADKLEBBJoKecw==
X-Received: by 2002:a5d:4906:: with SMTP id x6-v6mr13407845wrq.66.1528732426411;
        Mon, 11 Jun 2018 08:53:46 -0700 (PDT)
Received: from localhost (pD9E510DD.dip0.t-ipconnect.de. [217.229.16.221])
        by smtp.gmail.com with ESMTPSA id r9-v6sm26262680wrs.63.2018.06.11.08.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 08:53:45 -0700 (PDT)
Date: Mon, 11 Jun 2018 17:53:43 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Message-ID: <20180611155343.GE31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com>
 <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com>
 <20180611113503.GC31977@ulmo>
 <2510221.F5DvE09a94@dimapc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <2510221.F5DvE09a94@dimapc>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 04:06:41PM +0300, Dmitry Osipenko wrote:
> On Monday, 11 June 2018 14:35:03 MSK Thierry Reding wrote:
> > On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> > > On 06.06.2018 14:02, Thierry Reding wrote:
> > > > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
[...]
> > > >> +	} else {
> > > >> +		init_completion(&emc->clk_handshake_complete);
> > > >> +
> > > >> +		err =3D devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr,=
=20
> 0,
> > > >> +				       dev_name(&pdev->dev), emc);
> > > >> +		if (err < 0) {
> > > >> +			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> > > >> +				emc->irq, err);
> > > >> +			return err;
> > > >> +		}
> > > >> +	}
> > > >> +
> > > >> +	emc->pll_m =3D clk_get_sys(NULL, "pll_m");
> > > >> +	if (IS_ERR(emc->pll_m)) {
> > > >> +		err =3D PTR_ERR(emc->pll_m);
> > > >> +		dev_err(&pdev->dev, "failed to get pll_m: %d\n", err);
> > > >> +		return err;
> > > >> +	}
> > > >> +
> > > >> +	emc->backup_clk =3D clk_get_sys(NULL, "pll_p");
> > > >> +	if (IS_ERR(emc->backup_clk)) {
> > > >> +		err =3D PTR_ERR(emc->backup_clk);
> > > >> +		dev_err(&pdev->dev, "failed to get pll_p: %d\n", err);
> > > >> +		goto put_pll_m;
> > > >> +	}
> > > >> +
> > > >> +	emc->clk =3D clk_get_sys(NULL, "emc");
> > > >> +	if (IS_ERR(emc->clk)) {
> > > >> +		err =3D PTR_ERR(emc->clk);
> > > >> +		dev_err(&pdev->dev, "failed to get emc: %d\n", err);
> > > >> +		goto put_backup;
> > > >> +	}
> > > >=20
> > > > Instead of using clk_get_sys(), why not specify these in the DT with
> > > > proper names for context ("emc", "pll", "backup")? Again, I don't t=
hink
> > > > we have to worry about backwards-compatibility here since there can=
 be
> > > > no regression.
> > >=20
> > > I don't think that "pll" and "backup" could be placed in DT because i=
t is
> > > a pure software-driver descriptio     in
> > DT. There are other cases, like for display, where we list clocks in the
> > DT that aren't strictly inputs to a hardware block. But they are related
> > to the functionality of the block, so I think it makes sense to list
> > them as well.
> >=20
> > In this particular case, the PLL is what drives the memory banks, which
> > is the think that the EMC controls, right? So that itself is reason
> > enough, in my opinion, to list it in DT. Much the same goes for the
> > backup clock, which is really just the PLL for some transient state
> > where the normal PLL is being reconfigured.
>=20
> PLL itself shouldn't really matter. EMC doesn't control PLL, but only=20
> interacts with the Clock-and-Reset controller. This means that we could u=
se=20
> PLL_C instead of PLL_M if we wanted. Though PLL_M is meant to be a "memor=
y=20
> PLL".
>=20
> To me a selection of a parent clock is a pure software description that i=
s=20
> wrong to be placed in DT.

I think of it as configuration rather than software description. The
problem that we're trying to solve with DT is primarily one of
configuration and parameterization. The idea is that we describe the
interfaces of some hardware module and then specify which resources
to use as inputs and/or outputs for those interfaces.

So in this case we can define that in order to perform its function the
EMC driver needs to somehow control a PLL that drives the memory. Even
if the EMC hardware itself doesn't control a PLL, not controlling a PLL
would make the EMC driver rather pointless. Actually, if the hardware
did control the PLL itself, there'd be no need to describe any aspect of
that PLL in the DT. We only need to describe it in DT because we've got
several possibilities and we want to make sure we pick one that is best
for our specific use-case.

> I'm not sure that specifying parent clock for display in DT is correct. T=
hat=20
> simply doesn't make sense because there are four possible parent clocks f=
or=20
> the display. Selection of a parent clock in DT is a pure software descrip=
tion=20
> that is only relevant for the upstream Linux DRM driver, it's a mistake t=
o me.

I disagree. While it is certainly true that there are multiple possible
PLLs for display, which one to use depends on the use-case. In most SoC
generations we have two display PLLs where pll_d2 is "more capable" than
pll_d because it can run at higher frequencies. pll_d for example can in
many cases not be used to drive an HDMI output at 1080p resolutions. For
DisplayPort output, pll_d can usually also not be used. It therefore
makes sense to define in DT which PLL to use for a particular use-case.

Now, I'll grant you that this somewhat blurs the lines of hardware
descriptions vs. software description. But the alternative would be that
we don't describe the PLLs in DT, which would imply that we have to have
some logic in the driver that either knows which PLLs exist on the given
SoC and can query their capabilities in order to determine which one to
use for any given use-case.

It also means that the driver becomes much less generic, because we have
to put a lot of SoC specific knowledge into the driver. This is perhaps
not a big issue for SoCs like Tegra that are very closely integrated
anyway, but imagine if you take the same approach with IP that can be
licensed from a third party and therefore could appear in many more
different combinations.

I think having the parent PLL defined in DT is a good compromise. If you
say that strictly only hardware interfaces can be represented in DT, you
take away a lot of the flexibility and in turn put a lot of the data
back into drivers.

> Moreover PLL isn't a "device" clock, but specifically a "system" clock. S=
o=20
> describing it in DT as a "device" clock is wrong to me too.
>=20
> Putting all together, the PLL's should be left as-is they are now in v2,=
=20
> please let me know if you disagree.

I don't care very strongly in this case because the driver is unlikely
to ever be reused anywhere other than on Tegra20. But looking up the
system clock by a string is not something that is typically encouraged
because it limits portability.

> The "emc" clock could be placed in DT since we won't bother with the DT=
=20
> backwards compatibility, I'll change it in the next revision of the patch=
set.

Frankly, if you don't have the other clocks in DT there's little sense
in having the EMC clock in DT.

Thierry

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsemwMACgkQ3SOs138+
s6GquQ/7BegUHmQUOGU1QSRBzUHfJ73w6QolDHvvcYmBYaQlktgdd8jkoW+TM/56
On9bm7MLPbiC9SKrBtoxa8YRiBZNTNBZgT9s7GIvdbdL+RPwcHXGsVcVX6/9quJB
ibpeggVOtOeiEIOLnfEN4PbQuUGvoYBphlDIi1oUU5vPk3jrFnBp/BU3QclRS4WI
4RZovn5zElY0vgHnCO9sVJWkxKGk4HFxTNxf8rLakQcO0c4ult1OlMdrg2q4hCrS
IpWuArufRnhzusiH9HRWckciRA5G04Au2Shol6OBcJBaKWnL8dzXa0o427chtLXM
i7S4YrE+kFyM2dy0C44qoedANc6ZU6VzQ6rzQlfxDG0fHHEo4avfka3KkOyE3oNN
De61GuQWAlZpib9pVSYofMUoW9NkTHzGPOe0AKizXRpkute6IqhWOnym4PswwgL1
z7NXIlIlb3tcmNRI4QwnWaAOuPRuc0kzOF7pO8I1ejxSfqlK/tM2TzX43RM9Cxo5
6bEIJUE9dVr2nru3R9H9w3CclqHw+cZAh76LFeFs7MaZs+l5AzH4mso0nhROkKQE
xsLQzX8iV757bEu1HAiwiz9gnF/OffiIMqu617+dmcQp7NAbqphKAgGD+OUQ9mpa
oAaMD6bbCiQCTGtTJWJGLazGuCwTbalCWThJ07f1yjorEDJBpw4=
=+U13
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
