Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49465C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51A42086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UG81BaeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51A42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeIDUWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:22:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/EgwkKgL/ZO0Ht7IV+GC6vD78yiejreUaL5V8SIpwoI=; b=UG81BaeM6qDfg8HJ8MJ1HekuR
        2e0Uj2LyBwzZNZCzklDBuXPiU1lP32zFLzt+FZfXak1PRXv9PB9VnkxGFL6M4wHOiWu5TWA0sw3RK
        oeWQBKzEc4t3mskXxc7E1mFTvhZGLM0blYSVZWE5+cLxt1z9CRN9jvbhTCW+Yx6PjFY6o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxDhH-0001TE-St; Tue, 04 Sep 2018 15:56:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9819211227D8; Tue,  4 Sep 2018 16:56:55 +0100 (BST)
Date:   Tue, 4 Sep 2018 16:56:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Message-ID: <20180904155655.GJ12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
 <20180904145503.GD12993@sirena.org.uk>
 <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:10:24AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:55 AM, Mark Brown wrote:

> > you get to keep the pieces" territory.  If we really want to have a way
> > of explicitly specifying that some widgets should never be turned on
> > then it feels like rather than have something device and widget specific
> > like this we should instead have a higher level way of doing that which
> > can be applied to any widget, that is something that could be useful
> > especially with things like speaker drivers where there's real potential
> > for physical damage to the system.

> Not sure how that could even look, it would need to be in DT as only
> that layer knows the connections, but then the it would also have to
> have internal knowledge of the widgets used in the driver..

We already have a bunch of DT code that knows about and uses the
external widgets the device has (which are I'd guess the only ones where
this is an issue)?  I was thinking just have a property that lists the
widgets that should never be turned on.

> > Like I said in my original reply I'm also worried that this will break
> > existing boards by causing them to change to a voltage of 0 when they
> > had managed to end up with the default of 2V which happened to work for
> > them.

> Then only time this could happen is if they specified MICBIAS_OFF in DT
> but got the default 2v instead. In which case, yes, the behavior would
> change, but it would also be changing to the correct behavior. We can't
> avoid fixing code on the off chance someone depended on the broken
> behavior, no progress could ever be made.

I'm really having a lot of trouble seeing MICBIAS_OFF as a useful
voltage to specify in DT in the first place.

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOq0YACgkQJNaLcl1U
h9CuhAf/dmux31fp+cI7rFVG+vbv4eJGv2tb02jeXVb0zMA4sOMbcdVzSDdFEkDj
uczuKt63JFcvR/6VsoRhbVy7p1KgGLWH3eswLIPJLltgkMBpXlxzZWck7FpRHswH
JWYa2kYtkygvORR4YNdtSzQWkbDCbhmGkSNriGKJo4tfkY+PLJCLjLohHynktlYt
+Gon0wLd96yTMWWD8UJo9uJCDBdmXefqTd07IKuUFkQYNJThcBIzkSG2COO98VZD
JvvtK97wm4SQW5ZQVNrRrCDB/h6jUrSjZxtqtBLswKYrOQNxbbe4e8tH0Q4aqQCO
4dzcmmQQ0rRNFpaeu5toGpTPycy7ew==
=Ry/6
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
