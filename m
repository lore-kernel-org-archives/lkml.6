Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93701C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E33C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546875677;
	bh=EkgyVAaM4cAeG7gQ11CPhiJx80D3nogcVaJ2PiUYfxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AiuQ57JSAhwFKV59MkL3YGaNguv7J/1CE2MKO7MSE6ibyaS45aJkwF6V2jzP7eDKw
	 U1HJVxr/vcgOBzPq3JNc8qd6Qfqlkwtwkc/vuj1Ehec2aN5fWN7iQcT/Udz8Oty2Jk
	 7R+hB5TanjzExENMM+wTLfzw/xAR0KH9mia/u3KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfAGPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:41:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48754 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfAGPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lzJiLJYHOmEYUYvDL8OWme+ERqWvDtM4G2i+4tAJnMg=; b=RpV21yS8mWznAp1Rq1swu6A1o
        RYF51SwYIrHGV632+razFS1SMirPBcidpmVIXM8XPpjQaBAmMVZR0y/5EeiBIRbdZOp2i2DDt54pW
        GrfVdEb5DF6YlJho+7FitCDZkpeQg0zohJgoDZ77n3zEIu9GujXgxJVUH4Yztqi8wYH5Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggX1U-0007Po-T8; Mon, 07 Jan 2019 15:41:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6E05E1127491; Mon,  7 Jan 2019 15:41:04 +0000 (GMT)
Date:   Mon, 7 Jan 2019 15:41:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Message-ID: <20190107154104.GH9570@sirena.org.uk>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
 <20190107121919.GA9570@sirena.org.uk>
 <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Content-Disposition: inline
In-Reply-To: <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 10:16:53AM -0500, Sinan Kaya wrote:
> On Mon, Jan 7, 2019 at 7:19 AM Mark Brown <broonie@kernel.org> wrote:

> > Yes.  I've also applied it already and it's *still* being sent without
> > either a cover letter or the rest of the series :(

> There is a cover letter but it is being sent to Linux-acpi and Linux-next only.

> https://patchwork.kernel.org/cover/10749203/

> This means that you are not on either of these mailing lists.

No, it means that neither of those lists is going into my inbox
directly - the cover letters really need to go through the same route as
the patches to ensure that they're seen.  People often read the lists at
different times to their inbox, for example I prioritize reviewing
things that are in my inbox and look at list traffic less frequently
when my inbox is busy (as it tends to be most of the time).

> I apologize. I didn't realize that you applied this already. I'll drop
> this patch
> in case I need to submit a new revision.

You should have got this mail when it was applied:

http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/143687.html

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzcw8ACgkQJNaLcl1U
h9C6bAf/UcLxlzTCRDtcqBbYTaNDpsPQHDXWsqRODlqT15RDtF2y65YwskOLKZox
E6THXEVyFb/8gXoSlDXTZOR2SkLw8XtijSLgYwz4IhGO19ReRxVipR58hxOjb6Ma
ImuwYWqMkW37G6qFIf2w2y+jrDOe7Pj8NUCcVpyVHsLkDgWoBIoecb7Y8y3486Ja
f15LUJs+w9k8cpxmaC1xwJpPxPg9Onj58mLxYYc+zYwMG0kO4ZwI2EjtokrF39EW
IihDZrJeHyJPOW1HIZ2+3Rw/QqsWMmK9OQdbQoM4wWdRDzmsFIg6u/UlaLErXJ9f
rwghMtI8AYOy9EN0w/JEK7Aba8piTg==
=5HWq
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
