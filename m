Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427EFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A21240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lYxG/mt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A21240E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGERr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:47:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGERr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GJgc+O+tpkznHLS/XMFnSiuu7KdK3C02purOoSMIj30=; b=lYxG/mt1WWgy3ZdweEQj//lIm
        h4dHJ5CyUrtLxoYvhEcn7DjpBYui+egTTLS2eD6y6orGMFBVO9tZaCHmKL86xgqKpeRjMaBqKjNph
        5I67Z/v4BWraQzSFMKXWjXDVEE2kfCuHRO8kpKaValygNY0i3o4hF4Fumesfeqof14kNE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Ll-000121-5L; Thu, 05 Jul 2018 17:47:25 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Lk-0001gg-3K; Thu, 05 Jul 2018 18:47:24 +0100
Date:   Thu, 5 Jul 2018 18:47:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Message-ID: <20180705174724.GG6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
 <20180705173059.GF6227@sirena.org.uk>
 <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 06:39:14PM +0100, Srinivas Kandagatla wrote:

> Are reg_read/reg_write callbacks in bus regmap redundant to read/write
> callbacks?

> By the looks of it, it seems redundant, reg_read/reg_write will never be
> used if bus regmap has read/write callbacks. Just wanted reconfirm before
> replacing them with just read/write callbacks.

Yes.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+WasACgkQJNaLcl1U
h9Ctsgf/W5M95JNkGApzOvZ1t8G6afSlQUw5P4gMTVdYIC7qb3ewSW3Hb/3LcNDQ
N/b+lDAi9Ec3huoqgHg322AmcxzxTZhSVNgckJtmgSSQm+ShUfKOWQh3bTdSLo4f
BHKeNVGrdOtaONNCkVlShsUrvA5esrjoblXZ6XScaqAoaRDN9sR9DmtL2jkFDI6T
blKuzjnuxbM+ZpGC4C4+t3JoQ4W/+CACXf5nEKTi9yvGoDiw8BZUtPjKiWCaaM64
rEl3S+kO3iHbLrGo0662P7haWkKcXDnS3BbSkJWGXrlXu1NZKCHpazKzvBhqWETQ
u9XBILy6MsCsY113GJ5Ul5DUomIBZg==
=jnsz
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
