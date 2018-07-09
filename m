Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C36C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18D2204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jJkdJ0nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18D2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeGIMDi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:03:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeGIMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rJLRdYTxNdMQ39nLMUYq7fAKahcv6974Wo8eosCZ7Y8=; b=jJkdJ0nfsnYm1377p39EX2ogb
        HW7GgoU1QG0xe/O7llQOwzw5tnCG99D7l6YO51x60IWeEfu94yuNfFu+w33J17UgrqS4bNwusdRKu
        K1wAi0mp5nIyquNnpXW1KjFuUrY3maaHpzyab182mj85q42NPd2WE/6+VD191M9eG6A5E=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUt9-0003jU-S7; Mon, 09 Jul 2018 12:03:31 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUt9-0007mN-Br; Mon, 09 Jul 2018 13:03:31 +0100
Date:   Mon, 9 Jul 2018 13:03:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Message-ID: <20180709120331.GD16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <2110bdcf-96ad-deb5-a5cb-767d7b2e242d@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <2110bdcf-96ad-deb5-a5cb-767d7b2e242d@codeaurora.org>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 05:31:04PM +0530, Rohit Kumar wrote:
> On 7/9/2018 4:44 PM, Mark Brown wrote:
> > On Fri, Jul 06, 2018 at 03:13:13PM +0530, Rohit kumar wrote:

> > > +static const struct component_master_ops sdm845_ops = {
> > > +	.bind = sdm845_bind,
> > > +	.unbind = sdm845_unbind,
> > > +};

> > Why is this using the component stuff rather than the normal support for
> > finding the components of audio cards?

> QCOM soundcard is dependent on platform and cpu dais which gets registered
> only when ADSP is up.

This doesn't answer the question...

> This is the design being followed in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/qcom/apq8096.c?h=v4.18-rc4#n132

Oh dear, missed that :(  This is also broken and should be fixed.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDTxIACgkQJNaLcl1U
h9Bf9QfzBxfpdaf3Kgqek9OEaRg8qCwBJTPClTwxSL64WDXtnM9oqDQxuxgQW/3q
z9HMBar0c5vcZoaqfhDGD2Zh0ZFryjPrij/GMJEDmzi3P2X71c27yzWXu5zImwLI
3DjgmHs/Sbnu6XiSdadvPIRTqy8zXCT7jX8+OSfDDymzlAROQ8PqcFFDfHwY+PLe
lKvQgqv+k7DGQBCDktZOOA2LbrskCg2TlEkdT3LxXBEJWyNcY6lrpxvuhEOUdoWl
VeYsm91cvGYBmRJA4QUMCHzLOp3nL61k9hTaSGXhoQLtumubpsOHHz2Ovnmg2JR2
4TjGGhaf6JhB9wesxiHaW1t6cldK
=g8ov
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
