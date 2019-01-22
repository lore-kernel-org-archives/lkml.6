Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D7AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EF42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548175113;
	bh=NJRRsQL4YAMngR4DyEWPqzBh5UFihZdcDXyHNuuA7iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2COEVHDRON64DZyk/8fGKuW1z909u5p8xz9LwJlobHdPwCR/Lg+dvycLa9eEFq1aE
	 YgyK8BpJNjjInKEeqZdn2KLxde1QmmIoZNpFgU9XXwIWM3ZJmushFSSb6tBxheDP41
	 EDimhC5Csw52Ut3GZw42490BM1VMQbIt1attmbH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfAVQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:38:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfAVQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eyicJrquXGCCr5aMxHfGYET6nSKco2zO3PaNejCdxVA=; b=MaBnurPQ5K7UsFy+SSa+UIrMN
        I2zqxW0K7SIfYPFITeuuANPacr3dqmF4nTWvJ3D9+mbVGTO1bXkZw8EmQKwhQqjSQ952gPAmKO50x
        Xm9AADFS71R2J0JXEecuEFIH8P/iswcRBKMTAm343TMqlGDYAX1HjMNl1qqDd0D3j2S+E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glz4F-000713-9z; Tue, 22 Jan 2019 16:38:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A02161127A85; Tue, 22 Jan 2019 16:38:26 +0000 (GMT)
Date:   Tue, 22 Jan 2019 16:38:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: no need to check return value of debugfs_create
 functions
Message-ID: <20190122163826.GC7579@sirena.org.uk>
References: <20190122152151.16139-7-gregkh@linuxfoundation.org>
 <20190122155606.GB7579@sirena.org.uk>
 <20190122160857.GD21349@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20190122160857.GD21349@kroah.com>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 05:08:57PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 03:56:06PM +0000, Mark Brown wrote:

> > Given that all the rest of the function is doing is further debugfs
> > operations and when it fails people trying to use the debugfs do welcome
> > some diagnostics I'm not sure that's particularly helpful.

> The only way it will fail is if we are out of memory.  And you are in a
> bigger mess then, no one cares about debugfs calls, just make them and
> move on, you should never care about the result of such a call.

No, it also fails if there's already something with the same name in
debugfs which can happen as as a result of configuration.  This gets
confusing for users, they see the debugfs files they're expecting but
the contents don't match up at all.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHRwEACgkQJNaLcl1U
h9AE0Af/eIiC1KFg/nn23wa/AZbzsLhvgg2Ro2bR4Zvnepalah5BJXad7VeETWFx
M5ZGKB+RMVjPkyaLonbReDzR4rKLlZEv0WFa2vUDRN3gmrQ6k0yVRVJTJg83cfRO
s01crhCsSOKjsjgB2M0bJQeJYzkzLe3PpJMCX3igx9vkwWJSgU3Gxb+JmUKiwpXi
65+atLCmNRWhHXH32GlEBCwcSiwgMiCbWgHV2JkvyzK7715E5GtHClszwHrdQPN2
qRkC0gOIT/gohKa82aQMUbrvPOH7Pk7KZpMyw1SQAY1ZUEs0DEytV205IMkDYhpW
HVTza2lnNhB2AOIWvKq6eVJ6c8RC8w==
=TIzo
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
