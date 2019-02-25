Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C36C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA53C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113615;
	bh=O+xGPy3JzMLLp3C4tbdofaSyXYIReJDBEeFvDXe32vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SmzsnRiEQIoirNinEaBXKXn8teEzLR6KKo1fi6ZT1fUcg9saA7Bpg8SF4EDSjHr21
	 jqQtmStJ0f59OgbD24nIN8WLA+GKTZngMQKG9/OR5yYe1b2KHBoupFNxdVSGvBXVM5
	 jYi66H8IJZk6nGlE2+58JbWB5+/ppBELZltBlYLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfBYQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:53:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41850 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfBYQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O+xGPy3JzMLLp3C4tbdofaSyXYIReJDBEeFvDXe32vk=; b=sYqwztpdlR4P0k04yWbu5itGf
        cwAnt3w5AszlXSQSSdiSuHyX5LJGjoHGLC4r9FhIQAPjIuvI2yvCV1Y4M7y58KRoMZwixvWi1mxr8
        mIbM8IzaFn3gUzeafMCD7vFA2jRyRoYTuXN8fHZG37FTgytyXyx3DNnVquvSdpd5zYqZM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyJVD-0003NO-Cc; Mon, 25 Feb 2019 16:53:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AE2371128354; Mon, 25 Feb 2019 16:53:14 +0000 (GMT)
Date:   Mon, 25 Feb 2019 16:53:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Qian Cai <cai@lca.pw>, Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] [v2] kasan: turn off asan-stack for clang-8 and earlier
Message-ID: <20190225165314.GC13898@sirena.org.uk>
References: <20190222222950.3997333-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20190222222950.3997333-1-arnd@arndb.de>
X-Cookie: Neil Armstrong tripped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 22, 2019 at 11:29:10PM +0100, Arnd Bergmann wrote:
> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> about overly large stack frames, the worst ones being:

Reviewed-by: Mark Brown <broonie@kernel.org>

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx0HXkACgkQJNaLcl1U
h9DxnAf/V+F2ebTkIHA0IRg4ScHkk50z/xCZpeaBXpk9t8DTI49Ih9Vd0DvsiHik
VWhvyGOVDr5Rth/JKnY22vICnYzL6IspKHLOtNeGamI7xvgT17dVpoiijht7vlyX
/tzpD8c++a8DcpEkSmMAJSKX3fJpPbljmzyRNCpAVy97WYUBq6wfvpf/KT8b3PIe
PdZxRoBSMPcGzHi2rD/6Pl7xdXcgavH0ywMEdgC7joTD62MHOl7Xv3jN26gRTiYJ
4ynuCsf8pdM3SaDp1f2eJqgD/Jgo0UKmRjmj1B4qcmVMVqxn97TNBSEC2y2CNBMw
ppDkjsJn6uLnP8k9gZSqt+I1MczF7w==
=2CZ+
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
