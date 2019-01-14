Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D7CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547506997;
	bh=79rJVvsdJaQH9A+XEpnjKMywDGi6n3NYiAlafk8jdhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rUPmnBlqOFq53Q04yW6EN6CI9+Pg9WwlVW2E3WdjQ+WCruO31ukwBGVjrk8iZAueW
	 d+NzEnyQX8jFg69xWVt1bQSRvmaT8cQerWa4eo/P2AadKjum9yDbidBSkwrCliSrlj
	 S1RctVYoE0jtH26ohkhwI8NDINqNM/8mxnoZZddA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfANXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:03:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfANXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W2d/sJksifvu3BVio+1/SWMT7I5lc8/k42xZEYFmUo0=; b=bZ/yT2Cs5S2IX38XzyjoAiCh8
        UzHjdL1UYUii9UxxASIFaNTBxgCmKnD1/DDzmMuB/jD76Z/P9xbTGNAt8wgKX6fl27f3sh93r2gGA
        f3/68Xl8KuVz+KMuToPhmb87yLbyV2k55mkTRXuJdjls9vxmT4uPIDJUW3Hj2uXuVWMDo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjBG0-0000SF-JB; Mon, 14 Jan 2019 23:03:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1FC911127AD1; Mon, 14 Jan 2019 23:02:55 +0000 (GMT)
Date:   Mon, 14 Jan 2019 23:02:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name
 vs. of_node assignement
Message-ID: <20190114230255.GK11073@sirena.org.uk>
References: <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
 <20190109125340.GD10405@sirena.org.uk>
 <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
 <20190109141439.GE10405@sirena.org.uk>
 <875zuxb9uy.wl-kuninori.morimoto.gx@renesas.com>
 <a2068291-e554-cc4f-9af9-0022f3c4de34@nvidia.com>
 <871s5kqb43.wl-kuninori.morimoto.gx@renesas.com>
 <dfdc497f-9e52-99d7-208c-d8eef31fe61d@nvidia.com>
 <87h8efpoxh.wl-kuninori.morimoto.gx@renesas.com>
 <ea6b6a3a-b4eb-1d29-51fd-330b2b170005@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Content-Disposition: inline
In-Reply-To: <ea6b6a3a-b4eb-1d29-51fd-330b2b170005@nvidia.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2019 at 09:15:42AM +0000, Jon Hunter wrote:
> On 11/01/2019 08:51, Kuninori Morimoto wrote:

> > So, can you agree about these ?
> > 1) Add enough information/documentation about legacy/modern style and its plan.
> > 2) Add dirty pointer fixup patch as workaround
> > 3) switch to modern style as much as possible

> I think that Mark needs to decided on whether use your 'dirty pointer'
> fix or not.

I've gone ahead with Curtis' version of Morimoto-san's patch just now -
hopefully that's fine for v5.0.  Like we've been saying neither approach
is ideal, thanks Jon and Morimoto-san for your efforts analyzing this
and your proposals.

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9FR4ACgkQJNaLcl1U
h9Dbawf/agRz5TjSTBnTWu+KSjrCB+C+lMhRKOffsiss0cyfbgpS+mKvdujG+ZPb
4ebTzIDaG+LZWS83jkfh9wcIWy7miQrcZ7DY5XwoFaiLp4fbkVA5lW5jId2juf4u
RTy1Q2RR3WR3LxQ0RTP86a+4L9Gf3jaQm3n2NIw0k9TqKgMB89q1inAMkTNn8F0U
AozHjzvy1o1P57iHFj+BTeAmfAlpqzfJ2wsadm8dyxauitp5Pa9JWepq+BZJX0g9
rw3OrFs2VKrpj6FfcVTaeyHgMSITOqcd19B+CoJoYBKP20+ogs58j71e0ndqALxw
DH40p4DyPx1zi98Q5cyo6gMiJI2xAg==
=JWgH
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
