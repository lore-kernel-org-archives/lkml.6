Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC91C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE1A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZG9luoO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE1A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeK3GIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:08:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38746 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4jKvjlNW9oBOV1GXTAjYNtui4ONPXB70PaE0kP7xzn4=; b=ZG9luoO9hTWQFfndg/panOv/U
        4tTW5PPDDcxrOrFhPWDlX997pqhxi9VbRvyhEJW2r/7Fs0wb/Zr/21ir1bebWe6VwVUJaWZZgU+38
        OOxZGYa8EQhKpLY/BspfA9khW97uaA75wrVuooEQvm+7dYBTitMbkmGxH9+UWwPMz5NMM=;
Received: from 188.29.165.70.threembb.co.uk ([188.29.165.70] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gSRZE-00036d-97; Thu, 29 Nov 2018 19:01:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0BAAB440078; Thu, 29 Nov 2018 19:01:33 +0000 (GMT)
Date:   Thu, 29 Nov 2018 19:01:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ckeepax@opensource.cirrus.com
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
Message-ID: <20181129190132.GM2089@sirena.org.uk>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <CAMpxmJUsAccSKELNxn6DEWO6_3aCbzM=hZyaXUCr30S0-Eh0mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mDSUb3soQrPtHYgy"
Content-Disposition: inline
In-Reply-To: <CAMpxmJUsAccSKELNxn6DEWO6_3aCbzM=hZyaXUCr30S0-Eh0mA@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mDSUb3soQrPtHYgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 29, 2018 at 07:38:20PM +0100, Bartosz Golaszewski wrote:

> I'm wondering if instead of using the non-devm variants of
> gpiod_get_*() routines, we shouldn't provide helpers in the regulator
> framework that would be named accordingly, for example:
> regulator_gpiod_get_optional() etc. even if all they do is call the
> relevant gpiolib function. Those helpers could then be documented as
> passing the control over GPIO lines over to the regulator subsystem.

> The reason for that is that most driver developers will automatically
> use devm functions whenever available and having a single non-devm
> function without any comment used in a driver normally using devres
> looks like a bug. Expect people sending "fixes" in a couple months.

I predict that people would then immediately start demanding devm_
variants of that function...

--mDSUb3soQrPtHYgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwAN4wACgkQJNaLcl1U
h9BdTAf9FuBzyCXH+8N0FZSbkFFEKvSA97LAbwYwv6lJWzQfkyYN/i7nFxAmyfKr
URMA7sxFMkIwXRvghNL7y9lyWoLhz5a+EWp2N8mAaTdEj8V1k+7dWC/vIX87w5Xq
3WtNZw/ZAIQAMy7YXN7rwa9Chi4v91TkhF2j7T5BgAnvtAaQC68ruCt9kCO3Hn86
Qh5TIkZL+LAcql7TvNEO2Dc5VDvOM81fygrR0ZuC7zdNhCILdjL9LV/ZPk3JLDaw
oZpf69eLs1U8cYFPUXKsr46OoaXUPyjQ/k+VMAyXYiM00yJXuDVTrlS4LpP05WCz
qRE0MnS3iD7HUSl6/AP93XaN2EMXFA==
=TSQQ
-----END PGP SIGNATURE-----

--mDSUb3soQrPtHYgy--
