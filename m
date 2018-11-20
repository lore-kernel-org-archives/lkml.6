Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F09C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96087204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aijjU6DY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96087204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeKUCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:55:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUCzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=at3fvwn+KrKO/rVkxWNYDOmKEaGFuH3qzbPEqHl2C70=; b=aijjU6DYwe1yEhUPH5oimJVwR
        EGoHQ23cpejJNkkXKpGBKvKAsikcLQQeh0lmF3CMR37fc144FoAxghHG1igCcq5bnQc9iJpaBmnl+
        AJ5yppOdVulSuc96hLeXKtgolUxYEdpgSp8KX6swG/RYof6Qv0Zt97J/HwamzNzESZerc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8pk-0001ln-OE; Tue, 20 Nov 2018 16:25:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2FE311124DC2; Tue, 20 Nov 2018 16:25:04 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:25:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, digetx@gmail.com,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in
 regulator_force_disable()
Message-ID: <20181120162504.GJ3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-7-dianders@chromium.org>
 <20181120155458.GG3894@sirena.org.uk>
 <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aznLbwQ42o7LEaqN"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aznLbwQ42o7LEaqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 08:04:57AM -0800, Doug Anderson wrote:

> In general it's hard for me to reason about how the system in general
> should behave after regulator_force_disable() is called.  Is it
> basically expected that the system will panic soon after?
> Specifically other consumers of the same regulator will think it's on
> but it won't actually be on.  What should happen if one of those other
> consumers calls disable/enable?  Should the regulator turn back on?
> ...or is the regulator permanently off until the system reboots?

If something has been forced off the system is in very serious trouble
and had a cricial safety problem, though the fact that there's error
handling code that did the force disable might mean that there's some
ability to recover the situation - for example, this might be part of
thermal management or something like charger management.  Other drivers
do get notified if something gets forced off so a well written system
will ensure that other users of a regulator that can get force disabled
will have handling for this as should userspace.  We don't have any such
full systems in mainline, though - it is a really uncommon case.

The usage in the Adreno drivers just looks to be another completely
out of expectation regulator API usage in the QC code.  I do wish there
were a way to flag API calls as needing review :(

--aznLbwQ42o7LEaqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0NV8ACgkQJNaLcl1U
h9CllQf/c3nEJiuxm0cFd2sgAj07C0ivBaapX023nBIVeQPnU6hzBTIR5kjM6Qc2
wvL9iPK+wzOPSi1/TZF6hvqpcBuakHTzfy08qx14tuc7oWnPzcA+7llM6d1IepqA
veSUyhOG8uSDOaSqx9nOP3yudn5GvcVo05hTzGnQgYOwHTDXiO5lB/dRL+CwEOmz
uYNCP7Qb2Rh9X3ReCAU//mp5XLArbDYiojBlAx0WxYp49hD8Ox7WWO4wlxKqas11
DlIU5TqKTz/Uq7JfogIo0UdfhGjl2iyode95N0w+1+CBEjPud+ZfVHDLafZ9a/ij
hyJf/N7vMipIJZzotQbzS8v7BnZYLg==
=hfMO
-----END PGP SIGNATURE-----

--aznLbwQ42o7LEaqN--
