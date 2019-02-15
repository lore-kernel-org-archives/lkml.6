Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AC621929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550231414;
	bh=c95PgAzIO6iaZB/cwfuElNDev1u2tploAESUHa9b+sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=omc876GAvT7Z17fCItADhEilcwKFgkBEQyRYUYnQCyBgP0nNdrCssN6VC+c2dInGe
	 iFkpXNAZy9uY9ZW5RjktXNtaxJIGnbdDZEy1c0GENT13QL1G7g6f3vFwTG9pIQYl+D
	 WDVo8yjtI7uAfjGaeEGTjk4mF114sQW4UHotntik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436692AbfBOLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:50:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfBOLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c95PgAzIO6iaZB/cwfuElNDev1u2tploAESUHa9b+sU=; b=CgSbVqPRIVE/W/Eq63wfC/Art
        5IpaWVksoBHrJoXzuSKdvl3iPh6LeVmYBVdClF4nonxFe/MI+sXpIpl144Hs1Tb8R5BK52dAfE3W4
        0M9DW0kVUQh5b6ATNfHOGM5FmQRoXUMyN1/RtAwPfKX2mHBF0k0yi1Rtq+Hx4t9QK5F2I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guc0I-0006Dw-9P; Fri, 15 Feb 2019 11:50:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C1A41127748; Fri, 15 Feb 2019 11:50:01 +0000 (GMT)
Date:   Fri, 15 Feb 2019 11:50:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190215115001.GA7897@sirena.org.uk>
References: <20190215013959.21320-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190215013959.21320-1-natechancellor@gmail.com>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 06:39:59PM -0700, Nathan Chancellor wrote:
> After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
> implementation"), Clang builds for arm64 started failing with the
> following error message.

Reviewed-by: Mark Brown <broonie@kernel.org>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxmp2YACgkQJNaLcl1U
h9DQjgf+Ip4Cg39+BMHVOwgGtQZ8sGLb2muZVuewBtYYoXWujQ/2ACbqGpUTK+l6
bCINCYohI10vWmLlO+pVkjae1tgZ3zVaSxlL/+Kcjf9FjLpWDda2TB1kg39VOd23
mxV+V9uYHJGdtUGaxqp3hSecfUU9isXHugsfakzgxbWagq7h55RRY++4ZUGPAoGw
yed8jvoYDJBVYvpSFAnZsf330/do0f6obFAq5UAUZrRIivc3kPgZo/KAoF92bo2m
rLna+hwqvRt7Xi6YwEH2QZ+CPMfIITK4Rgoc10vzMGs3RNLfJLbUlf3j6zOPn51D
V85AXuaop5+IPMC8l89jVsRJwJXnug==
=uD/V
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
