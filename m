Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5B21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="voSjHxcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5B21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJSUoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:44:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJSUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NTHM+hUmysi02WJjSwOg+yOHqodh7BLy55z9nZNro0s=; b=voSjHxcD3XrgbW/fVwCZHGtQ9
        nI71Fr3aIsap5rRpmAVpViBqSIfAu2Qu+VfaYceydTbxd9y76jwjWOPHg1ZbRO7zQugjGhXqWJ5QH
        zFprQh4tePdKuCtbJmxhz+x+nvijOrnYkI6xh7X1dkOnB50EuWk79i6sJabyOoerEsz8A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDU36-000098-Hy; Fri, 19 Oct 2018 12:38:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 301101122548; Fri, 19 Oct 2018 13:38:40 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:38:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181019123840.GL5895@sirena.org.uk>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
 <20181019112622.GB5895@sirena.org.uk>
 <20181019121920.GL1653@imbe.wolfsonmicro.main>
 <20181019122118.GI5895@sirena.org.uk>
 <20181019123442.GM1653@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline
In-Reply-To: <20181019123442.GM1653@imbe.wolfsonmicro.main>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 01:34:42PM +0100, Charles Keepax wrote:
> On Fri, Oct 19, 2018 at 01:21:18PM +0100, Mark Brown wrote:

> > It looks a lot like

> > bef9391cbec547351c6a13e52f3a26bb2d271ec7 regulator: lochnagar: Add support for the Cirrus Logic Lochnagar

> > in -next.

> Well it sure does look a lot like my patch :-). Apologies
> something must have gone wrong on one of our ends as I don't
> seem to have ever received your usual confirmation email it
> was merged. I will try to keep a closer eye on people's trees
> in future.

They do sometimes seem to get flagged as spam, I think due to the amount
of boilerplate and possibly even the fact that they include the patches.

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJ0E8ACgkQJNaLcl1U
h9AbXgf8DhZ8F5ouO3YDC0DRt0RqX2RDoLGELBtfApk5ZkNbeHJCCVV0hScGSfK3
XQ0aRncbrXuR8w4HV7uS7yqXUM9zvjTrhZ1pP6bBskFCnnpjXyLUvbILlJUZuViq
JSbTJHGmbMrK1x9Tm9u2CamGRM8gE+5fpKPt67p/PQ/z0peADKBGRZ1sVY2Yu0t7
qHqFdSvmYgkRkmQVfOAOZ0RxNJk/t8i5R3j4Hy01xqkMQI9UitQPY2JpBPFterLn
exCRh2Oi3KQrCynABN9+fpd4S4H3izOkLBaj6/3f7H+F2/d4/7LAImpcg8M/DA4C
R5LlPB2DMmxonXXT2UzFds/dcRz2+g==
=o511
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--
