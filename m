Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF789C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5072086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MRkePell"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5072086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeIYW6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:58:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeIYW6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wyYGznuTGERFqtE+W7O1ExPw9GAO9l+P/kurQNcOL7M=; b=MRkePellSLC/g8IOtsPbX8jwd
        G8QbX6QZUpfUBH1moUZ5R7Vf/a3wcT7yIIKiTeUpGCP4TPNnpusNq72+zsAIzq0SS0rEW608/LApx
        TgA5oA/nlkw/ewDFzdHo7DHZ22rtQH+Hvz7BJHa28YZYa0WNYppnlxsn2/HeV4tzXTjh4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g4qWs-0001Fb-Lt; Tue, 25 Sep 2018 16:49:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B0928440078; Tue, 25 Sep 2018 17:49:41 +0100 (BST)
Date:   Tue, 25 Sep 2018 09:49:41 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_ops
Message-ID: <20180925164941.GN20825@sirena.org.uk>
References: <20180925004711.99422-1-mka@chromium.org>
 <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline
In-Reply-To: <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 25, 2018 at 11:36:55AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 25, 2018 at 3:48 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> >   extern const struct dma_map_ops dummy_dma_ops;
> >                                   ^

> > Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

> But it misses 'dma' part as I can see they are still DMA related.

> snd_dummy_dma_ops ?

Yes, we have many different set of operations in ALSA, snd_dummy_ops is
just inviting further collisions.

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluqZyEACgkQJNaLcl1U
h9AdQwgAheMn3bz50bARVTfx4ejXNfP8dBxZZEsIbr6PXpeSEqhWDjyvqfZ8vRtH
NFHwlD1W3z4KojNe4CEhlElg1pVVy1wJJWrIF29QPmnoPLddrKQEUthoDFbbfg7y
8cHmNeBICXa7yggpjgEhCeXvm12GpxccQer9lmNRABdOEqunMJXrrapdvFWUc8bm
BzJmcRPyb/nKlV6Q4qenHXterbAivYdzhYj7MVt9t9T4MO7C/728qtEpoxv0XgR9
s1UtcHbGiZCMoMo+BjykvKopzAYVqsKSvIdpPF2BIhwWj5LqGAXk1oWDc0NC69iJ
ZYpi81FNXuRLCiNjCTcgE0adE0en7Q==
=lrxi
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--
