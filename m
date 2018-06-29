Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF8F27DA3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tYpZ2xwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF8F27DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935216AbeF2LGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:06:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeF2LGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YA+zWaeVk31F3fvj0xuP07aApHEdSLKfFbJpkp2TK/8=; b=tYpZ2xwStLp4lV965LhSIASNL
        6iz2OODNVthFbffCL1QvgGyoVfLQg2l3eIbYgU3380u+QqUhv8vywFhWpKNEdHU31iS094bN1xQX3
        zug+c7i11cvk9N27PgtfhED58P77onxXLWYaLbID3RIofo4hc2F/zPY0QpSPHaFdFC1mc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYrEg-0007kK-6O; Fri, 29 Jun 2018 11:06:42 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYrEf-0002XL-P7; Fri, 29 Jun 2018 12:06:41 +0100
Date:   Fri, 29 Jun 2018 12:06:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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
Message-ID: <20180629110641.GB6556@sirena.org.uk>
References: <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
 <20180627150126.GC5263@sirena.org.uk>
 <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
 <20180628101813.GD14040@sirena.org.uk>
 <87cc8c77-7b39-1746-4680-cb26d602e62e@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <87cc8c77-7b39-1746-4680-cb26d602e62e@codeaurora.org>
X-Cookie: Thank God I'm an atheist.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2018 at 11:04:17AM -0700, David Collins wrote:

> Do you have any remaining concerns with the qcom-rpmh-regulator binding
> and driver patches that would keep you from applying them (other than the
> dependency patches being applied first)?

To repeat I need to find the time to sit down and go through them
properly, the problems this driver has had mean I feel I need to be
extra careful there.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls2EsEACgkQJNaLcl1U
h9Bx1Af7Bz4I6SUQg9lGj8sFvYlmI95U/RkOKKl7qwJ1vL4rDIVYxUnCKptgUZwq
m999vmbzQx/olgopwVBpHjalHCCKSwUFUT3YLsZHOxhg6qT32C98tsWk0fc0ryXp
TxeeeXZyGf9g1hUE5VJvxZyLPvGk/iz62cI6U2vj9zPwrc8D1m5yNrWqos18roZo
oSF41AOVcFDlSU2AIbuelz/T4e15rxvHxygubBMzyMUGjVicYdnIfvLq+XRWOD6i
GVg7h1+rEXX8mAFslOj0E1Y+WruwGlbcQQtF0WmEw4bzoHjhUzwlKU6Iryjwfc2F
3OqeExM3CbmRv90iiRAz87ILL2Kotw==
=rGtf
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
