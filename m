Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D98C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81305271F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cSV+dxlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81305271F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeF1KSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:18:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeF1KSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=izSxCo3BVpO4VqYZPhku/v+pI/ocy5eWGO0QSky3BiY=; b=cSV+dxlTY1TEoZYUnrc5tUTex
        XS4rDpM8SPfOUacHhHjWd6SAg/lsgxSHbqyBtY7qB4jvJWXfa8O//Fa7kf0n5FWm0WIzoXvLtfJ+t
        R6ASD2yjPIMZEVM8fgsGxCPzaSDdo0I1ZN3KvZUewYpA0HQGsxRpaAqNlA6TKvmmxwem0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU0E-0005Dw-H5; Thu, 28 Jun 2018 10:18:14 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU0D-0003za-I3; Thu, 28 Jun 2018 11:18:13 +0100
Date:   Thu, 28 Jun 2018 11:18:13 +0100
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
Message-ID: <20180628101813.GD14040@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
 <20180627150126.GC5263@sirena.org.uk>
 <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
X-Cookie: Money is the root of all wealth.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 09:28:03AM -0700, Doug Anderson wrote:

> OK, great.  I guess I'm confused about the "|| COMPILE_TEST" causing
> problems then?  I was worried that anyone trying to do "COMPILE_TEST"
> on your tree (or linuxnext if RPMh isn't there) would get failures due
> to the lack of header files.  I guess if it's a problem you could just
> gut the "|| COMPILE_TEST" and it could be added back in later?

Ugh, yes - that'll break things.  In that case I can't apply this
without a signed tag from Andy's tree with the dependency stuff in.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0teQACgkQJNaLcl1U
h9B4TAf/ebk6w0cZmO9WqSItIKbXOeN6pTRVfdLR8OW71Ma4XHNP/NrPJgfGThwk
6CBoSUWb5FWtzp6kkgdoRkyV/bO0f+uoZ1JREnJecYAV8SaJ8Jq5lxXyBmYWJ5/J
1E4v/ijMfvEs8xrEJvhpoZfPGt746yt6Kh5ymlb93UaIBJZBj2bxz1sF3n4vU1JX
sQT+XlBPipoD7sV8pb/X7YVm1N2+SWU9eKs6Cm5AUOVqcnnOTAuRhhq5HPNh1nT/
BOVZkOztWcIo0xsA0RICgxlKMXoVevXGHg5t1dmGr6sWGXxu/T5KM7CoZlPzNBU3
4E6tid1s+MOfqXHvu0MltEGP/vTLpQ==
=0TTH
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
