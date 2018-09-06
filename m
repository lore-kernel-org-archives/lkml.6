Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OWI57Qk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC59820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeIFR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:59:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MEGEPpw14g03QbqYAK4tk4htkRjua2Epo7g8SxRHlW0=; b=OWI57Qk+fN3P5ossF5+5hzTbr
        /zDHoYXy9Qm8Hibj4ksD4amdh8MYSmJZKsMZC+UzpqNJdBQGHGSYAXqThd0Wq3oSonh/+DqChaSDg
        /m7/H+k2DRxbZQTwqkQaTfbrLKtqQ3jopOsuDth5bWPi+IZEh15JrnzoTbXvwYawWKQpU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxuFx-0004F9-Vu; Thu, 06 Sep 2018 13:23:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 99BAD1122A1F; Thu,  6 Sep 2018 14:23:33 +0100 (BST)
Date:   Thu, 6 Sep 2018 14:23:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v3] spi: dw: support 4-16 bits per word
Message-ID: <20180906132333.GG5360@sirena.org.uk>
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
 <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
 <20180906110926.GF5360@sirena.org.uk>
 <CAAh8qsyMcL-acBf4nXq2RSE=Y43FMG8v+TuyvvmgGtkjHchAyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <CAAh8qsyMcL-acBf4nXq2RSE=Y43FMG8v+TuyvvmgGtkjHchAyQ@mail.gmail.com>
X-Cookie: You will lose an important disk file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2018 at 01:23:34PM +0200, Simon Goldschmidt wrote:
> On Thu, Sep 6, 2018 at 1:09 PM Mark Brown <broonie@kernel.org> wrote:

> > Please don't send new patches in reply to old patch serieses, it makes
> > it harder to follow what the current version of things is and makes it
> > much easier for the patches to get lost in the old threads.

> Ok, no problem and thanks for the hint! Where does this requirement
> come from? Patchwork or mail sorting habits?

Mail sorting.  It can mean that you get things like someone deleting a
thread and the new patch getting caught up in a thread delete command
and hence missed.

> Anyway, how does this continue, will you pick the patch or do I need
> to somehow collect yet more reviews?

You should've got a mail at about the same time saying it's been
applied.

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluRKlQACgkQJNaLcl1U
h9CwRwf+N8tdfUCN4L8ZOFeE3umGG0yN6jbjo4GYV8NMZW0oC7F6Je7uDZTk3+zY
L7mXbYwxmkPfvAmayZVM7gv2E/jq2Mx0Vs2bIA9tjgO/WIMx0Y876rCY5QpVSTAg
yrmnMv4fzeQMBfosNg0SQCO6Cvf/l5EE/TwGbbAJknsOw+lCZXxL/NwOj007OaO9
ctHuFzs/IoF6qWUcNYKrIyjY+0erEUC19gB4h/U60JAPcDwWTBwuQMGIXeXdEjel
5Ix7NsflJl1oLuAPxpKyGWFv+1pOFJ+eUIb3R99pkJIOECItCn+WjuChBAFBzQs8
r4U+HcrZQLjxWqErKHi0PCKw74x62Q==
=Dq84
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
