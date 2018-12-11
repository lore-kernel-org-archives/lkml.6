Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D2B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544489547;
	bh=OmpYUlOlEOCAOsVT1PMzhcCcV8Wh38fOfV646HE+EEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hhv2uooC9Ad5GJWncjjxRvndwCoOiNm9fjkhL9e1DqyVqnkvc3t49jb1lQppOrXnb
	 LvU+dDH+erhzXs59jWRa/ol7MlyC6xdt/IMQnWzk7zcdjhm6kEAWydrR7Ll+fV69GU
	 X4Z4HakOm+C0K7/FdZg/H1sqnSzPR4Vx0Ye4ypKo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D2B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLKAw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:52:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeLKAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r1BMoMMAYt82097lmO6hUTZdam+V73mUcm3kForJUS4=; b=gN+Ipnd9z8F/gYeKMV8lfjQzu
        j2KblGENRLU4pLQty8tdw3U+iMthKPQcs3aQlJLv3WwXsjCGbhUzX1esGVUKBWCV02LIBOQK8jPXg
        EguOPBwKpyyE/ZiXcdH9J140k9Y7/fqfGWdUB0WTCKNRgSDdTdayoFHI9zug3WbraDgTo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWHe-0000Fn-1D; Tue, 11 Dec 2018 00:52:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B036B11254C7; Tue, 11 Dec 2018 00:52:21 +0000 (GMT)
Date:   Tue, 11 Dec 2018 00:52:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
Message-ID: <20181211005221.GB3004@sirena.org.uk>
References: <20181206222318.240401-1-dianders@chromium.org>
 <20181210154311.GF6307@sirena.org.uk>
 <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
X-Cookie: Now I am depressed ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 08:32:32AM -0800, Doug Anderson wrote:
> On Mon, Dec 10, 2018 at 7:43 AM Mark Brown <broonie@kernel.org> wrote:

> > On Thu, Dec 06, 2018 at 02:23:18PM -0800, Douglas Anderson wrote:
> > > At the end of regulator_resolve_supply() we have historically turned
> > > on our supply in some cases.  This could be for one of two reasons:

> > This doesn't apply against current code, please check and resend.

> Can you clarify?  See below where it's applying cleanly to "for-next" for me:

I tried a git am on my for-4.21 and for-next branches and it didn't work
on either, I didn't investigate beyond that.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPCkQACgkQJNaLcl1U
h9B06wf9EpiWzf29xBmmhqd79v5rJetc45FV8S/Phs/qOd/rUp8tRe4oppsWeqAl
eaqLc+RS0xtJ0ybsysWjUXy/RS7Eb/m0DZmjPSRdWHOnDntQ3DpRfELSMcJgWsiV
JylGviGJ8Y06hF/RjX29sArtQKOuYk5j6FazjcVpy3U40jXLZ+qdyMsHIJlZqXuF
UzbDuL6i5rtvkmblqftVbv54FkQgyo5mnUKmEFBo/vxiWjPmlhepximIPooJv6vW
1RVoMdIt6UJMBHcTxy3pPDhpxcpQjH8KiKAL7YtaOfyZAg/i2tq4GBuViCM4/D4P
pw3td3Dnh8LKcqkTJfASeMlZVLOW0A==
=kDpS
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
