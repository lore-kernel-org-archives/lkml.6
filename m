Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C448920652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ga4Ps5gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIDTH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:07:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeIDTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ngvxbGMLr+lAonHOjvbHN654NfHanB9jQNbx4DJKwpU=; b=ga4Ps5gwG4BIDigeBJUzYS+v+
        wrwbgwIl/cAWcj2LHFdR4d/1KGo4sIi1u0XAgzdlfhGSe+WOC2Sd2V9r974+ulBQ2MzqOlKvILcPU
        e4eNLLvBvWrk6uDZKHWTtuQuIZHtuv/3J8RrAXd4RvXclx0JUBKz7BLZnPJIkRcqI+/GA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxCWm-0001Qo-JX; Tue, 04 Sep 2018 14:42:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0512F11227D8; Tue,  4 Sep 2018 15:41:59 +0100 (BST)
Date:   Tue, 4 Sep 2018 15:41:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Message-ID: <20180904144159.GC12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 08:55:06AM -0500, Andrew F. Davis wrote:
> On 09/03/2018 06:26 AM, Mark Brown wrote:

> > If we really want to pay attention to something setting this up we'd
> > need to completely remove the widget - what the code is doing at the
> > minute is setting the voltage that the bias will go to when enabled,
> > there's still a widget for turning it on and off.  There's some chance
> > that this will break existing boards.

> Turning on bias is controlled separately, automatically in user-space in
> many cases, not based on the board. The DT needs to have a way to state
> that 0v is the needed bias on this board, without this you can not set
> 0v bias and 2v is chosen by default (which is IMHO should be 0v but that
> would change existing behavior so I won't touch that).

Surely turning on MICBIAS at 0V is equivalent to leaving the bias off?

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOmbcACgkQJNaLcl1U
h9BlLQf9Hx/u2QF/ksuOmtcn83rVcnqhADne0vQ++eSoUjlL7mIhKFrPJUuZd6Mp
J1GvAuP1MThcX+k+fZ9JzYNdzoq3fkciPR+IiLqIBwhHQN4kBqHrFtn+4DyBwijt
Z3HTRwCptBOXoP8Sok8IJfbQPSv4eA7LwjNR+KPyu9nNCcyl4xfg/3xC9+sIdWTi
FbVOlWYANa2cInTE7TVX7X6gAC019dGxPt2n42ssnWFmGH9iViWweWsaLzgdD/eS
MPCfLi5wIZjf5zdKq4IM0mYdwlnaOx6SjUz2iXOY/u6P6E53BUCdE4GEPZnWQK33
BZlSGaInys8bVfeFeeqBUIYeQfQ74A==
=/xOH
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
