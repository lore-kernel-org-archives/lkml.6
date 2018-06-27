Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A0C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F869260B9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tYdx/pNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F869260B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965525AbeF0PBe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:01:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965204AbeF0PBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4vv+sQ9jGm3YNQayH9KoTFZRRhbVJE9kVdhUWh7yslw=; b=tYdx/pNqEPsyzecJWRf6fP+fk
        c2kNJs53E3o+iZFU1VArlpCKVY3ZAUfAi/zJ9TbapyGoStXPWDqc0r1amXjEtS/EZtcFQn/vm8xDd
        GkbJ8aXrhL3e4n2uLDQHnPpoOBRO6W+xsGq2kPtUQ8it1m2D8uT2FusCL6TSrnEGfSqfo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBwk-0003GI-Jc; Wed, 27 Jun 2018 15:01:26 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBwk-0006Cj-5N; Wed, 27 Jun 2018 16:01:26 +0100
Date:   Wed, 27 Jun 2018 16:01:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180627150126.GC5263@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
X-Cookie: The horror... the horror!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 11:15:14AM -0700, Doug Anderson wrote:

> I think he's still planning on re-shuffling his tree a bit.  When he
> does this, do you need him to put the RPMh patches somewhere you can
> merge into your tree?

Well, I *think* there's no actual dependency here since it's a new
driver with a Kconfig dependency.  It really just needs me to get round
to trawling through what's a fairly large patch with a troubled history
now you've reviewed it.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlszpsUACgkQJNaLcl1U
h9DRXAf/RSwjn9Yep/XR4J9nwQWdsAQuo9Gvn9tJjRoGglOah9oGV4HW8M3S3Jir
RCTOixlFD8QmHXBMRkEoeY/dVPquUjJD1AvRUK54G+8Vi3oeb5G1ZvlY3bc0E7B3
qXp9Gqp9fZ/6hWj/cmfkilgsdnbEiuaY3rWxUUWNKo1g6L8YzyXdLPMOoQ6KN9yv
l+6GgUSct+LzxSXr6Bpas9mp1b/6xVH/3zbf/4+rp5Jod5ZMMOyHdX2YxKg7LwPZ
qUUMFJYufubQIHGMeG8jLLFQG6ZreKG46OptHwSb5MXM46Uw40SrewGw4NMYYrt7
JC3SzS+o9RlMhpmNBdqasAiYDQe2qw==
=uOTE
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
