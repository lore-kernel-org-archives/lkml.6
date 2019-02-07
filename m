Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F041BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404A21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549549942;
	bh=ILf5JwXK46+MDWoHGi0uAdL4sV/3ogfmcR7tGPPdXt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8iy4pQfUcBeLH526nDPY6rBj8efQb+9iIimOYoDrj8yaarl7gdZ98HscqmkVa9GK
	 LWUWSnfhIXgeww2DTejRt6t3r2Sg4rZNmNIgV0F1JRj0EYcWA6VMyscCGBiKyU+are
	 fWuzDYxwpGpuw2L48IUJofdSLTWd0ASx9+j+5xHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfBGOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:32:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43912 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfBGOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wCX/Gf2L7Klc+hbojnj8CceCDWKHkLKPsq3rAGWsYdE=; b=xW0Mik73xu75+PlL27cMfs9VE
        niuAeLWqD1x7qMbH2jtXVO0caPNiQXLmAynp9ST4MHEVfn94WnL5PuKEopFqX2ZsTLvMk30Oa4Fjy
        bjGnAxlxAw+66p8MRKhUX1gZbmJ3E5ydJoPejL2mO/ctHuumy/CeeH1ZBYW+JkNCZCMDs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grkis-00062r-PF; Thu, 07 Feb 2019 14:32:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 389E91127EF9; Thu,  7 Feb 2019 14:32:14 +0000 (GMT)
Date:   Thu, 7 Feb 2019 14:32:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: Prevent clk_get_rate() calls in atomic
 context
Message-ID: <20190207143214.GC6190@sirena.org.uk>
References: <CGME20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a@epcas1p2.samsung.com>
 <20190207142041.19394-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20190207142041.19394-1-s.nawrocki@samsung.com>
X-Cookie: A day without sunshine is like night.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 03:20:41PM +0100, Sylwester Nawrocki wrote:

> [   82.109780] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
> [   82.117009] in_atomic(): 1, irqs_disabled(): 128, pid: 1554, name: speaker-test
> [   82.124235] 3 locks held by speaker-test/1554:
> [   82.128653]  #0: cc8c5328 (snd_pcm_link_rwlock){...-}, at: snd_pcm_stream_lock_irq+0x20/0x38

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcQW0ACgkQJNaLcl1U
h9ARiAf/WPaVRLaN6Qvhkmt2ZqSONQrzGcEnijel7RLZtrfYhDNLMdolFs7ICoLp
E9P0Lfknnizbx3iaxkgxBzn6YhdTAophE80N4xr9xvvCxepPWbA/HjFZpRepR2i2
R4k6AfZ1E/5sscLmn1r9TCJaDwRY5H4ERzHyGL78FJngmlrfzCptR6VjTs6Dcv+A
FNUxsYsQOtbe6ZH1G+3K0xxvvEc3phXyCfegkKZwmZ8fR26JVczrQ+k9Rcv/O4eN
eRdZ4cu1N3/eRjWrg5yO/TPfbLzFuc4w6NUhH0Hhb/gOaQvxxQvdkCRt0xcTn0eu
vCCZBNNQYhvJynqU3ZOOo4ySpZjNVg==
=4Q8x
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
