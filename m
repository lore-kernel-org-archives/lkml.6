Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A473923F82
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Zi87V8DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A473923F82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeGEQuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:50:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeGEQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cGUqediT1FV9EwrgR3w4YzyYMXdd5fY92fTO7bd7SMk=; b=Zi87V8DVl+fEKKoVzdNnVsy9Y
        3zeWHIbCQLV4ONewukh7udSrKPlBAgCGo9V2uVSHUDnnO2eFiOGlUaViqLdx3mRXbvzeFV1ErhmeJ
        cdyGKog97M+cz7HZhqbykN5TOkjlUets6NYqTs6jPCFEXKNXPAA+Jvsu73DNLLa113w/I=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7SN-000100-Gv; Thu, 05 Jul 2018 16:50:11 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7SN-0007pi-3I; Thu, 05 Jul 2018 17:50:11 +0100
Date:   Thu, 5 Jul 2018 17:50:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Message-ID: <20180705165011.GC6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 05:13:21PM +0100, Srinivas Kandagatla wrote:

> I think I got it wrong by looking at _regmap_bus_read() implementation which
> calls _regmap_raw_read(), this made me think that read/writes callbacks
> imply raw read/writes. Looks like that is not the case.

They are reads and writes, the thing is that they're reads and writes of
the register map that's also accessible for other operations rather than
something separate.

> All am trying to do is support paged registers, which seems to be only
> possible via read/write support at bus level.

Could you explain what you mean by paged registers?  There's framework
support for what's normally called pages but perhaps this is some
slimbus specific thing?

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+TEIACgkQJNaLcl1U
h9BV6Qf/YNI1I8OaYffK4zwYsjGpMRe4M0LvAW5ZMcqX3WI6v3DgqWeWwuZ2i4Mq
84riJ88XTtfuk0uQUm1GPBf5BIE7FOD7SaNR8QOfgLAZSAgq4sEcGu6fJRYK+97A
2GTylrltzsc/ZDOEsctJKTmdK/h0pF2DWv4zQ2SG9VpFB3HxpjxpYxG+N8x9cv8I
KNEcqJaK8uLBaiNRYRmuVB3HMSW0WO0hQhKOphETNelrGor2Y4HPyqO5q47yeuc9
HcCdu4sUBKYFWqNl3Fb4gtOaLYSlehUH68oL5GBT47+jPCYN4NKzHZdrQQmhDwBW
eT3qzOzZOQFUSffd64wlVZSxf7LF5g==
=bFLm
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
