Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C026206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547510783;
	bh=AwzoNIpIiT1EYQpVvwyX8XE+fAO4qTtoXdyyyJoYamg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UN5FfVyciMzurD3h41bXDwwohxPF1Y4qC63eomEGSxhL3JN0NsbHxU3plZZdNpo6K
	 S2MmQs5OLVaEPAlIL0or7jIpmsgLRr0yvCJVy+wWSBxUHdRZxraOCRZ8u7iWO4hgdX
	 o/9hrbZ0XP8Aoe+h0HDB16Q1GPDRRWv9COQ+mbgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfAOAGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:06:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfAOAGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FQ+hBYp/aGxKXJmqp5lNSD251Kl7hEqpCaaSL7187Yw=; b=A8XYWk+Of0Bekp7ZOJZWhFoX3
        gmUSg4/LPbCH32jSXNrStl5IUoiVlCTySlsN3M0dVnEhdIJkmdvt50yoFNlRbd+V0fi15xRMv3+kT
        Nh8MPw5mbOHfMwzZTU5L5KStDHlNSwXOvlwDrmEfOrCG+y7D2QI6TqFaa887THJammXjs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjCF8-0000pp-D3; Tue, 15 Jan 2019 00:06:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0FE22112349B; Tue, 15 Jan 2019 00:06:10 +0000 (GMT)
Date:   Tue, 15 Jan 2019 00:06:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        vinod.koul@linaro.org, Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190115000610.GM11073@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Content-Disposition: inline
In-Reply-To: <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:

> Adding some traces I can see that the the platform name we use doesn't se=
em
> compatible with your logic. All the Intel boards used a constant platform
> name matching the PCI ID, see e.g. [1], which IIRC is used to bind
> components. Liam, do you recall in more details if this is really require=
d?

That's telling me that either snd_soc_find_components() isn't finding
components in the same way that we do when we bind things which isn't
good or we're binding links without having fully matched everything on
the link which also isn't good. =20

Without a system that shows the issue I can't 100% confirm but I think
it's the former - I'm fairly sure that those machines are relying on the
component name being initialized to fmt_single_name() in
snd_soc_component_initialize().  That is supposed to wind up using
dev_name() (which would be the PCI address for a PCI device) as the
basis of the name.  What I can't currently see is how exactly that gets
bound (or how any of the other links avoid trouble for that matter).  We
could revert and push this into cards but I would rather be confident
that we understand what's going on, I'm not comfortable that we aren't
just pushing the breakage around rather than fixing it.  Can someone
with an x86 system take a look and confirm exactly what's going on with
binding these cards please?

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9I/EACgkQJNaLcl1U
h9CXiQf/ais5lfLk5aThXWHOcT4Aeoa0gV56hJp1nZlMrEqb1NJ2cJwcbJhJK3mR
tHznZeav6m+nItDv0/qwQKuu4XAI/A2WVQl52w6aBQUoVyJhDTIowkxRg1IHQzyf
y549gsvaqYW9OU9L0wPMIIqCJWXuTmpdSRcw7VlAqNB4SOQAGKDZpanAQzFOETg9
7mqSDTDrROwt0kK7PXkQrtfYwb8FtpYZKJvq/siY4oKM6trowrVn73qgLLWLHhsc
pWk3oqcr+6q+Yn1S46FoAxNoi3fq1qhXopSxXi+jJWQ1MNQOWijIMjYQfn8qCSCc
YqnhYw4TVD84O6dU0crP6DRw6pkbnA==
=jct2
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--
