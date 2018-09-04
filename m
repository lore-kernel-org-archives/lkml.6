Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7354C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725E32086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YwE9i9HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725E32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIDTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:20:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIDTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SX7LGK0v9KqOk9fkCYu7nbNo/KS7UYeR8nCtItn80rg=; b=YwE9i9HL9VO6cCnaC5WFOQV1o
        Tnw141O14sxmP4+2ipcHpprcV8R8ULlYnUo1BzZ9Ju0W3nQXMOhU3f5fWTTgWbV5K8KdM9BcVWiWT
        lgpgYex2vWyUTo/ySzUvDokpGjmSSQjeK4QhykpfdQRAvFUcbWRAFbAnSKv4bHcpk8Xwg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxCjP-0001RB-PT; Tue, 04 Sep 2018 14:55:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5834C11227D8; Tue,  4 Sep 2018 15:55:03 +0100 (BST)
Date:   Tue, 4 Sep 2018 15:55:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Message-ID: <20180904145503.GD12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 09:43:03AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:41 AM, Mark Brown wrote:

> >>> If we really want to pay attention to something setting this up we'd
> >>> need to completely remove the widget - what the code is doing at the
> >>> minute is setting the voltage that the bias will go to when enabled,
> >>> there's still a widget for turning it on and off.  There's some chance
> >>> that this will break existing boards.

> >> Turning on bias is controlled separately, automatically in user-space in
> >> many cases, not based on the board. The DT needs to have a way to state
> >> that 0v is the needed bias on this board, without this you can not set
> >> 0v bias and 2v is chosen by default (which is IMHO should be 0v but that
> >> would change existing behavior so I won't touch that).

> > Surely turning on MICBIAS at 0V is equivalent to leaving the bias off?

> It is, but DT doesn't control when or why MICBIAS is turned on or off,
> only what voltage on should be.

The DT controls this in so far as it will arrange for the bias to be
connected to something, if it's not connected to anything then it will
only be turned on if the machine driver explicitly forces it on which is
a potential source of problems but seems comfortably in "you broke it,
you get to keep the pieces" territory.  If we really want to have a way
of explicitly specifying that some widgets should never be turned on
then it feels like rather than have something device and widget specific
like this we should instead have a higher level way of doing that which
can be applied to any widget, that is something that could be useful
especially with things like speaker drivers where there's real potential
for physical damage to the system.

Like I said in my original reply I'm also worried that this will break
existing boards by causing them to change to a voltage of 0 when they
had managed to end up with the default of 2V which happened to work for
them.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOnMYACgkQJNaLcl1U
h9C5rQf9EitPZEIwdrnRzlotHH90WYdwdgA/c4XcKqOlnJ5fFPBoOhfrODmw2fOS
zt7IgdjXBPyNeUtWGvAxNJW2IQ1bdwA6pTr5LtB/LPa22N54tCa7i58T3kc4knGM
TbivsKuBndK2nAgPlA0779KK0LLM6EjSs+lQ5mFWvFCwLUbSQ7fEA9nZ0zVTtq+3
JP5F6OEvvht98QxHKVm9TwcaED2tMW428RThXmh09soARjGQFhAFD28OLthTQG71
/yLKFGFgSLgvJT4/rXeGvdAHLBQnbkDc/9VPyrqpdjh7Yc+YrFK9sChK5Y/vBkgI
YGli/tDAJq71FIS1OPPxfj6qYMFN8g==
=+cLv
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
