Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88102ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32353206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="h2aLNmO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32353206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeGTMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:33:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36316 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeGTMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f818n1gZTZhbN1EYhmiY+1eRCpC3kyC0eUV5hsrW/qg=; b=h2aLNmO+yksjiyJV3+CG6soY/
        ji4eK+8iTm66YvCpL6c257jnObE7vd9cnxyTHHybR6tRBcqlyN0yHEjji2do0+mfZ68upyVW3zqP2
        NOlNBNwih0L0E3Zwx4WjKBDicELn5GpnQ/rNRX4bIlrHgpr5e56rIn2WhqzaX2+6pIKtA=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgTqQ-0008Ka-O0; Fri, 20 Jul 2018 11:45:10 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgTqP-00059h-TG; Fri, 20 Jul 2018 12:45:09 +0100
Date:   Fri, 20 Jul 2018 12:45:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
Message-ID: <20180720114509.GA10784@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
 <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk>
 <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 10:02:21AM +0900, Ard Biesheuvel wrote:
> On 20 July 2018 at 00:50, Mark Brown <broonie@kernel.org> wrote:

> > Existing hardware can definitely do the IV generation and I believe that
> > it can chain multiple sectors together though I'd need to confirm this,
> > as mentioned elsewhere in the thread the ccree driver is for one of
> > the relevant devices.  I've poked some relevant people.

> As far as I can infer from the ccree driver source, IV generation and
> en/decryption are separate operations, and given that each sector
> requires both operations to be applied in sequence, letting the crypto
> layer handle an entire bio does not have any benefit *at the moment*.

Interesting...  they were reporting some benefits from that with their
out of tree driver prior to upstreaming (and there are other
implementations out there, that's the only one I definitely know about).
I have to confess I didn't look at their in tree driver, looking briefly
now it looks awfully like the hardware should be able to chain IV
generation together with encryption without bothering the CPU which
would be good enough.

> In fact, it seems to me that the ability to use protected AES keys is
> much more appealing than any performance argument (including 'it may
> be slower but at least it does not load the CPU'), so some background
> on how such a change would enable this use case would be beneficial as
> well to getting this adopted.

Right, that's another benefit which was on the radar for followup work.

> So my recommendation would be to focus on moving the IV generation
> into the crypto layer, but conservatively, and not confuse people by
> making additional changes that could theoretically improve
> performance, but only on hardware that does not exist.

It certainly seems like splitting things up will at least allow things
to progress.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltRy0UACgkQJNaLcl1U
h9D4cAf/UeA1QxAG8k/NTSGp51av2cdaz/Een7dRZFxOJcXArVrBiJFvNIT//4OX
F7vKF9RFwOFi+okI30UvaLKslVPryr3wi7cLubcwsrJnCgPvYFTcrfkOwZu1FCs3
BmT+w+eSiUIrd2dy+Lobb8rzSQPIJDPW5mo6zvAPK8Ml1mpNyrAgbg4AgH2KkCWm
oLBEYxhg7348vL65RrYEbYNDvIpZ54chIrxwFsknVK1iSEm+orJR0k9EFMhw7wmZ
XSie3/248JCKl0A/poweBaGXoxjRJM9ilSD2HICwodFJImwfmtiH6+XPMaibheTY
Q6gEEiIPvz+o6snHzsD4qKSBOwRJQA==
=5nTD
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
