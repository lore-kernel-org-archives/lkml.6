Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECD5214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547210376;
	bh=Q2G2M8x/JFE6O+PeReFhrs03QCz/Szzvf/g8GFp6Yxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gxGjq1kZZpKF+DPlPUr0Az7x6WFQRpUV0uoLd2uGL8TJW1fqgKXGY5e9syQBx7pDa
	 L27HO6gJqQkW75Ew7tCvmViqHaxfeJ1z2K74UgHvlO4oAI05ImLDIYgplHdxIjETBS
	 0CrjMmo/6ECGm3s7v71bXKc4fOcZwUfv6ZG+Jb/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfAKMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:39:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbfAKMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D/NfYiAP7tuTDrJC/6QMQEqWJDLLQHwMQdWAk2dYgnE=; b=iKSePolpHb2ceciufTWQ05pEe
        myZymPxBk+i7dMsmq/+qf0vZ+Ifm9jH/bTI4b8ZljB58HQWrgQ0nfSrc+9KyMtcwST9DN3GJNSgEr
        cLQHS1SK6hflB3bskcgSi/fI/qLau8QQQHkTcqfJrmeUN70KOV/v+H9EViAHt7upoJ5r4=;
Received: from 94.197.121.207.threembb.co.uk ([94.197.121.207] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghw5j-0008Fy-88; Fri, 11 Jan 2019 12:39:15 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D3E8F440082; Fri, 11 Jan 2019 12:39:13 +0000 (GMT)
Date:   Fri, 11 Jan 2019 12:39:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux@armlinux.org.uk,
        lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190111123913.GA2804@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 10:24:26AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 09.01.2019 18:57, Mark Brown wrote:

> > regulator state which feels fragile.  But based on the cover letter
> > that's kind of like what the initial proposal about target states was so
> > perhaps this is the way we end up going...=20

> Are you talking about [1] ?

I can't follow that link right now, I'm working offline.

> I can get rid of this patch, take advantage of [3] and [4] and introduce
> also the regulator standby states. In this case, no matter the mapping b/w
> Linux power saving modes and AT91 SoC's power saving modes, we will be
> covered on misconfiguration (at least on SAMA5D2 Xplained board).

> And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
> thing would be that in case of no input for regulator's state in
> mem/standby the board could not properly suspended/resumed), if any.

> What do you think about this?

Like I say I'm working offline so I can't check the links but it sounds
like you're saying that the existing suspend mode configuration features
are enough for your systems?  If so that's great - certainly what you're
saying above sounds sensible to me but it's possible I misunderstood
something based on not having the links.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw4jm4ACgkQJNaLcl1U
h9Ccswf+NULiFYb7x7jPouVeC7CIJLiKxHhaBH5KaCJsAITd15esv74wkfRHqf+A
sI52Sg6uJA4Cxt68zZz9EAMslHECb1wdMcgLfj1C1GKP0mjiF2IQmbG0jlAwbjLX
gt69eODFF9sWJs7FyCQsH605yavOv1jVYEPblgT9efgmJYZEm2FkVLDwUrGbI9rU
ARsLuXTfJ0t0RWOvYr/H81P76EJgE95+x0tD9KygwNWENzx/u5nRBpZJmSbB9x3h
C8HkW3ftkWZWU2KmgySOw0t+k7UM6/H8WmA0sUi/gHEocPtqIgPiu6BMOVqNwLuA
Yf+vPlQk2zChUP2bfLqcxwdtmXCkfg==
=uQKs
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
