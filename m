Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B46C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42DF206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544808386;
	bh=PJS6L8NSCiSYUEt3yNTmDAJDxfD8ZDs9nD/1xgIfAOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V+SkS1f2yj2BL7LeRGFk5Qc5RfyHwy0b13FE/sjexHLnMvoyI1ptrO1otN1qie/0+
	 /whMknHbgw7fIDRWUs0x7tts5a3SZW5jlHOT2b7cyYnxl6tB/w5Yjtv0JVP7LRcu8O
	 KzYdl4ZwDXA6YVL5H56o9SUoKWSrouGRvEYZ0eMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbeLNR0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:26:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bESAXOQ35DTub4pRwwGfIfPg1e8IOE8t1ASv++6AFvA=; b=diEdBEFWYpkmUQ00XShE2AoML
        j86y5VxitAXRJ36O8Mak2DF+R+oGK3/GYd7knRQ2cWQZqT2vMebvJ0Hf294JgutW/r9KWzlZMQQh0
        TteXcRGjOISkflLQOYUjBPv/+oMLiLI1tS1NSIqVU/K6sY9Vakh7Y2EHaI6jrFGEakv5U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXrEC-0007jn-Eq; Fri, 14 Dec 2018 17:26:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EF64011258A2; Fri, 14 Dec 2018 17:26:19 +0000 (GMT)
Date:   Fri, 14 Dec 2018 17:26:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181214172619.GC6467@sirena.org.uk>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
 <20181207075829.GA24940@localhost.localdomain>
 <20181207131418.GB6510@sirena.org.uk>
 <20181214135819.GA2735@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20181214135819.GA2735@localhost.localdomain>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 03:58:19PM +0200, Matti Vaittinen wrote:
> On Fri, Dec 07, 2018 at 01:14:18PM +0000, Mark Brown wrote:

> > > Then we could have chip->no_of set for the 'main irq chip' and for those
> > > chips we don't wan't to expose via DT. In my case I would leave no_of
> > > unset only for the irq-chip which I created for the GPIO? Is this a
> > > silly idea?

> > That's worth a shot, yes - I'd need to see it fully fleshed out I think
> > but it looks sensible (no ternery operator please).

> Do you think this would be benefical even if we add the 'main irq
> support'? If so, I can generate a patch out of this. I think this would
> really suffice for my current need - but this stops wokrking as soon as
> more than one sub-irq-chip want's to expose interrupts via DT.

Hrm, yeah.  That's a thing.  I think I'd misvisualized the DT change as
being the other way around for some reason.

> > Your idea definitely works for the current case, yes - I'm just thinking
> > about future edge and extension cases.

> I could send an example on how the driver utilizing the original RFC
> interface would look like. I am starting to think it was not *that* bad
> after all...

That might help, yes.

> > > I see your point now. But as I said, I am not sure we should add the
> > > overhead of 'main irq bit description' for simple cases just to cover
> > > the corner cases. Yet I can try seeing what I can come up with if you
> > > think this is the way to go.

> > If you could take a look that'd be great.

> I did some experiment. I will post this as another RFC - but I am really
> not terribly happy about it. It's complex (well, in my opinion) and I am
> not sure the driver interface is much easier. But you can see it
> yourself.

Great, I'll take a proper look on Monday.  Thanks for putting the time
in here!

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwT57sACgkQJNaLcl1U
h9DX9wf/QCOKy3++Gk7DVRrPuKNRIbAE0QJq09ub/OGPp5Roe07ivloAbpLJZSRD
SXTFZXVzpEisAAsubHXvw6GBWm4F7DejN6HSzK/mMM3rInEpuGlKSL2je6M5JXsg
tzs3QnqbOobgxUv4wCcKPYiahxZrNbn+2D0Rh2Eux+ZUzOdIpwS0ms7MJ+vajjzu
prq1b7JHWb+a5t9U/MOsZH/ullFgvsx+uERL+fUipYYzKFPGPF0skJwUlbKkdr/j
BIJVCalvczh6ZjWFAIMa8Wgku4hsN6LUxpuvpaB+hfKoRhtX4mMs3z4qJGgloIZ/
anv/SO2q5sJjQwnHWhI9g7afd8OaMg==
=7AXF
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
