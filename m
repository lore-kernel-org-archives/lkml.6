Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920C12151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RLMmL0gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920C12151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJQRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:52:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeJQRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a6WND7pWdvr5Qf+0xCeKno9SMzNngxlEIImzXrPgw5A=; b=RLMmL0gCudEt3AaNk6HX+71hJ
        ZRExTD1un5560yepmaSL21IZa0Vjp9KYywrb/oGMbqY6IMgRTAP6igGlV9S1FqQ3aE1UPeJZf/8Bs
        SN1r+lrLFRNtaXnxkpMTXqJdSQb0tpoG+mju06Xa0CsUTugwB6DY0xjgI9E8xpHPAckqA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCiZV-0000oy-6a; Wed, 17 Oct 2018 09:56:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EE66411224C3; Wed, 17 Oct 2018 10:56:56 +0100 (BST)
Date:   Wed, 17 Oct 2018 10:56:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 1/3] driver core: add probe_err log helper
Message-ID: <20181017095656.GC24097@sirena.org.uk>
References: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
 <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
 <20181017085824.30806-1-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20181017085824.30806-1-a.hajda@samsung.com>
X-Cookie: No passing zone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 10:58:24AM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:

Reviwed-by: Mark Brown <broonie@kernel.org>

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHB2gACgkQJNaLcl1U
h9DyCgf8Czf0Nr9kCIDHXbVxidcWJ6S2Ss07BSl6Gmsjc9bB5Vj66F+J2HuI9wRl
y28f2ZsRbDd8r674DyryGuUe5Ct+iqKkzpqVrFd7Fye5/5UA0GxW7pSjFAaR9H1W
f79u0wSaBmt+Iw0XipQE0ScLUGMGo3SjsrbfGTitixs1X34SUFitkgqnht9N33jR
V4U90pxT2L2MpR0gLEgLr+wlNTkeCMTh0y1ugAY6Ewu4ysK9Lvphkp5krCcCiEoX
c52eO9qDY3A3lDkLvbyN2e2fbocifuhV2ogktKTEFAfhC5GMuLpHR0r24PrEnsKB
WUmN6VfO95f4q/En+3+7O0Qy8Spz8Q==
=CDkY
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
