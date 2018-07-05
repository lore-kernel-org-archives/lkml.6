Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F24CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WhIodYbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C765F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeGEPJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:09:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeGEPJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nUzfiiFK+HQoyv5sG7EGbt0hVLr5MGXmnSQjz/9l9/0=; b=WhIodYbfjY9MMtZQ9MhHqrJlO
        kbf6obOUa5Ctz6qyl38x4DPnqDS9BvmfZsGr1GgNng6TLHSu2uPUjC0ysmj9gd85e2seCxjz9eVw8
        ihLWuQyWMTivw6pBXIb6sPtAhHO8lfb+TX0RVfJrbruGFdqzVfGuzcs55tDhfZdjukk6M=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb5sR-0000xU-Fc; Thu, 05 Jul 2018 15:08:59 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb5sP-0004So-RM; Thu, 05 Jul 2018 16:08:57 +0100
Date:   Thu, 5 Jul 2018 16:08:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Message-ID: <20180705150857.GA6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 12:37:00PM +0100, Srinivas Kandagatla wrote:

> SLIMbus supports upto 16 bytes in value management messages,
> so add support to raw read/writes upto 16 bytes.

That's not what raw access is.  It's unmediated access to existing
registers, not some other thing with completely different register sizes
which you can't see through the register map.  The intended use is for
things like fast firmware downloads.  If it's not part of the register
map we shouldn't be going through regmap to get to it.

> Also useful for paged register access on SLIMbus interfaced codecs.

That needs a bunch more explanation...  in what way does raw access
relate to paged register maps?

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+NIkACgkQJNaLcl1U
h9CgaAf+O/7Vv1B6FBGkyZAWEtgbx7kuUHRjw+gL5RkucN53bfq4VCnb7HuogOul
4/70MYrtH+++epGz/Vkojs+D8rmRPpytYT+vdVbw3dPhX4G/y37DV8DLunb9EpAs
qr8SJVqfSbXEpNwxEiRLNRvlWQAUf+kFpx370jaJlJOY0TqZH6Hx3RVzYq6GMZ7J
Z0Im0Y/pVpjyh+qK+z/gsMbMCsppMhFPcZLDVqNeqIPHqZeWeiXkDnU+jvWvH7wO
h40Whn/X4ZepvpdsJ/vroqqaleSrpQ7LWQfLm5DIdL/rlUcmyMHUn09vx3lwkKDx
PwCGf0V+0864OXeiWJtWjCCt7lN20A==
=uxp1
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
