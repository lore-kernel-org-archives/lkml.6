Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E187120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547578587;
	bh=8gQl+s990M05cQ3VvFBXgmmgX5ItsFAnYvqIt4lCjGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZeBx/vL44TjpbAnCQehdiXYCPA9YnrTeY9QKM+lFXFD/czPVsEUQ9cE77poMXuFtc
	 6cIs33fNMCN2ZigUMriRC+ZK52HVwFceDwEz7a96P97FjecE5aZDRgHpCji1+O0LZf
	 JVPM+HQad3CMrzw4F8CUAgBalTWUJEOKx+Xr3Flg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfAOS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:56:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfAOS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8gQl+s990M05cQ3VvFBXgmmgX5ItsFAnYvqIt4lCjGo=; b=gJ8YHs+hVdxUvFXd8wbum4D5q
        Ou3Is1tSUAvPhFxx264bFdyw99OiXyvou12Rg3N8II6vTO2sUoKvpcac9vuR1kR9N4zsd0idOY14v
        eG2f+EcEcfy0pjKiAqLN9OmqxtZAVn8qQkxQ14SScgi8geieCPdwZM3vfNapCFTHiqDhA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjTso-00026T-W0; Tue, 15 Jan 2019 18:56:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 580AB1127848; Tue, 15 Jan 2019 18:56:18 +0000 (GMT)
Date:   Tue, 15 Jan 2019 18:56:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc
Message-ID: <20190115185618.GF5522@sirena.org.uk>
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
 <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
 <7ha7k1ker7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <7ha7k1ker7.fsf@baylibre.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 09:33:00AM -0800, Kevin Hilman wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> > I hope there is someone else with this board on CC since I don't
> > know how to ask the robot to test patches.

> Both Neil and I have access to this board, so we can test any fixes for
> you.

Given the amount of work Linus is doing at the minute on GPIO API
cleanups that affect lots of boards I'm thinking it might be sensible
for him to have a tree in KernelCI where he can test things before
posting them upstream?

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+LNEACgkQJNaLcl1U
h9CAIgf/e3XRiaQczcaUDTJTgNuwiabeZh2dgTzlJfwCfJb7t9SlNLBONGLAJtVs
+Nz4Uqgk81jrt0M2YbbrrTBWEKk3gK5VvIiccSSQMigSTIo17GzqacWmFxh6cPIR
/nrPFHGylL9R6X2ig4dWKouTi375Q1AmnDCZSDFImiSbVWensHk4n/ujOYbtey/9
Cu78J8MkaTak7q/aMYc5UDccSULGvmCxUdmc3d5qChGLwaTaypKb42JBFYXyQdO2
9WXzJ2bq4b9WXw0KXQT5dZWQeF9r8cvIEI79YvZkE1Ox48E1QoMLlabjqHkoTwB/
p1m7bbJadwPZmXKGX74sbFMkaTbXwg==
=aTRy
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
