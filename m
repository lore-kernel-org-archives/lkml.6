Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AAD20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490037;
	bh=MGyde75C+hsXuqv8TNday+LjU68JDcFn+jhbEaT8CtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YM3nR1oH9mObheQryOxSM7ub1ac5D6t4KSRv8WKmaEZD/49DLHdgPjksJfVonBEAE
	 HurkoBxtGlS78VaRve6mWLtMOgGA45Ra5pMFm3JMU+pqjFcwH9Gf6YyB1SLbL4DCZ9
	 cdyxCPnkkNWy7QNcf9UNZJq1d/vXFW3067vGWgkU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AAD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeLKBAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:00:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeLKBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hz84za78d7J4tOO2IeRsLZzWQWaRsxBkz5b7bkFRtG4=; b=qP42V5ew+jVZqwFhkSDIB6Is8
        2GJqWVBkzna9tTJKq6iPmzjQo16b645Hgb0WIB1BFTGRo9fcNXte2GSoiOPLQAV4g69oHByDz5CEA
        ema+wyTg2Bxu/WySDQBqH1lq+qqt+G+NByTPTJbQXfLpO4tOgIkepzd+cV03Ky8FMuAo0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWPY-0000GP-Uu; Tue, 11 Dec 2018 01:00:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8644D11254C7; Tue, 11 Dec 2018 01:00:32 +0000 (GMT)
Date:   Tue, 11 Dec 2018 01:00:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
Message-ID: <20181211010032.GE3004@sirena.org.uk>
References: <20181206222318.240401-1-dianders@chromium.org>
 <20181210154311.GF6307@sirena.org.uk>
 <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
 <20181211005221.GB3004@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <20181211005221.GB3004@sirena.org.uk>
X-Cookie: Now I am depressed ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 12:52:21AM +0000, Mark Brown wrote:
> On Mon, Dec 10, 2018 at 08:32:32AM -0800, Doug Anderson wrote:

> > Can you clarify?  See below where it's applying cleanly to "for-next" for me:

> I tried a git am on my for-4.21 and for-next branches and it didn't work
> on either, I didn't investigate beyond that.

Applying: regulator: core: Clean enabling always-on regulators + their supplies
Using index info to reconstruct a base tree...
M	drivers/regulator/core.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/regulator/core.c
CONFLICT (content): Merge conflict in drivers/regulator/core.c
Recorded preimage for 'drivers/regulator/core.c'
error: Failed to merge in the changes.
Patch failed at 0001 regulator: core: Clean enabling always-on regulators + their supplies
hint: Use 'git am --show-current-patch' to see the failed patch

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPDC8ACgkQJNaLcl1U
h9Dm6wgAgUM9iIZMY3DZaEupMytg81LntavVJcaNeKK1lCao4sVl3by+W7w7ShYi
fmvy/nNve1aXJuz10I0IdjndSD0PMTEPnuGwa3VvIaPH6xVeFUpuKZWTmaDZ7Qv+
GfWFPbRVFQhZU32lX1XT9doRkvmOWiVUr1P9frkbufY51HyG/nsFOuCJVZ0eUoNM
XxC0N+8M6a1+tTlMRoL+FpTfBB4mfUVPZSWXL1CSglhUwybLqHFVH0YNbExGK3pa
Q9261Cgx26M9vwbDzHbvS+Viqm1dYoSOpARshMh+y7g8g6hhcg8GWx4Vz1KIbV0y
dsrEPANqoo/IJ52NA3/s+9YUOCokTg==
=PEAT
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
