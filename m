Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDA8217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550512223;
	bh=jRZeoTFlKyXvf/zLxsbrmXQfvKgjmaZRswVDpAZdZy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LrJ4M/KBYBEGr53mlJHI1MiNZx9oJ0BYOccuRZkD8ddU5Nd5NM12qM5D2dw32lq4q
	 xXIImo+AEDIWp3Ua1oYgqS9mcl8YFCcHiq/9K1DckdaW5S6AGdl860nWL6AFhlzksh
	 Nuz4tBYb90FyHqyKdj2KBn06eldUtKZ7dz0uDTNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbfBRRuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:50:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55244 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389827AbfBRRuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wUM7cc3kcAaNGX8m52ndMeki5M7z/2TxPAmJdk/6L1c=; b=DDe2riewxv/XliYCdtyFQZ4IV
        jNbUgOzrymlBJrDOKXWePKMojIZ5Px1Uqq2a7+YwQJzG0CIK6strAVo+2Y6CxpL95VsGirlse/qbk
        crWIleSe7FwBVOhfLJz11/5PRC8/QH7K57rt2CqzOVYN61rNPw2yRNGcsvhtlPzqgKbGU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvn3U-0001No-CY; Mon, 18 Feb 2019 17:50:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BEEE41128008; Mon, 18 Feb 2019 17:50:10 +0000 (GMT)
Date:   Mon, 18 Feb 2019 17:50:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "vicencb@gmail.com" <vicencb@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix refcount underflow
Message-ID: <20190218175010.GB10794@sirena.org.uk>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
 <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
 <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <s5hpnrp8ret.wl-tiwai@suse.de>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 08:52:26AM +0100, Takashi Iwai wrote:
> Daniel Baluta wrote:

> > > Fixes: commit da215354eb55c ("ASoC: simple-card: merge simple-scu-
> > > card")

> > Thanks! I thought about adding this but the current patch will not
> > cleanly apply because of:

> > 2d01a84605a55c ("ASoC: simple-card: reduce naming prefix")

That doesn't matter for fixes tags.  However...

> Yeah, it's a bit tricky because of the code change at this time.

> At best, send two patches, once for 5.0 and once for 5.1, and let Mark
> apply both of them and do the empty merge from 5.0 to 5.1, or let him
> resolve the merge conflict by applying manually the 5.1 patch.

...since this is something that needs to be fixed for v5.0 we need a
patch that can be applied on v5.0 (and has been tested by someone who
sees the issue there).  Takashi's plan seems like a good way to do that,
if you could send a patch against my for-5.0 branch (or just Linus'
tree) that'd be great.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq8FIACgkQJNaLcl1U
h9B58Qf+I/VpXqp+ASMjZ2UG85bKjLNGgZTHGDBbBYTTHLdWKjUrcyZqeiZ5A/lJ
DxUx8EIo+4PbmytunRjAvZHyp3K9s/6ozEyj4qbyCe81YyE2cqNQopHkucIA0b+X
nwyse/s7n7QqFjkFgTd4WNkveRowP/CvV4FzfucxBRKoL/5AkpGFkfDAGNTY6RDb
M5xpiDeUErV52RCFuZ7rwGNh57G4RVFnKcQV507ZuwxVlZ4kl++QdyeAHMGDlnXS
sUc3GXS4QzMCuTYUUW4aR+FkBjvFitc/3q1MTqQ8UytaiyGNIgqIYOjSHkhDFZIa
pBqnUzari84A+/+ehuQbJNUUeo9y9Q==
=dxr7
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
