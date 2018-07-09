Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D23AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FD020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wCFW4suB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeGIMlb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:41:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48972 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeGIMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gyAeNIJB/ED/76fepLLjijboFfrcfHMwGXFw+sqwQ0I=; b=wCFW4suBS35jYis0zmD44CUEW
        STV9MaaknQvNH4UBzjTBmqker/kz62kHeuZ96JfgZw7TvDPsByeS+mZ1kHnIN/9dPdOCpTl/6zpD3
        sF6lNxxGqXGu/v/zc8vTzYQQ9bdq+VsoOYqVyhg4B/6ALJ9KSZ05yjjlGLV1ayAKH+RQU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVTi-0003kw-Dj; Mon, 09 Jul 2018 12:41:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVTh-0000ZT-Vu; Mon, 09 Jul 2018 13:41:18 +0100
Date:   Mon, 9 Jul 2018 13:41:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180709124117.GG16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 01:34:42PM +0100, Srinivas Kandagatla wrote:
> On 09/07/18 12:14, Mark Brown wrote:
> > > +static const struct component_master_ops sdm845_ops = {
> > > +	.bind = sdm845_bind,
> > > +	.unbind = sdm845_unbind,
> > > +};

> > Why is this using the component stuff rather than the normal support for
> > finding the components of audio cards?

> Could you elaborate this please?
> Do you mean something like snd_soc_lookup_component()?  Or in general audio
> card binding during startup.

Just the normal audio card binding during startup.

> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
> for first time.. for the second time(restart usecase) there are no hooks
> like bind/unbind.

This is not the case, the card will be unbound at the ASoC level when
any of the components are removed and then probed again when they
reappear.

> The reason why we chose to use component framework is because of bind and
> unbind functionality. Am more than happy to rework on this if there is
> already a alternative mechanism in ASoC which can provide this.

The component framework is a generalization of what ASoC does.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDV+0ACgkQJNaLcl1U
h9BaCwf8DPkajFrD2z0vPsuEoi+2W0C8+W5Ts6wFobM8vKNYBOY8NpGUF/EOjjUI
fTKW7aZXV6KQaxV6ESwfJw/ye1gZXb18fZVW/xPuzLSHpkcSzJwG+1Mg2jSSj3q2
BqezmNMnnB3MTMfw5w9jM1xwyM1a4AXrWK2jSSA8NfKV+vKvoa1HtydyzGLEjGyR
Bw6HiB5+93AT2ljB/Rvt2hKluHPEkfnYbhyEm18KzAnma6xacsC2OLmFMW550/x7
TuwA6wNajAgvIOKpf9b9USAqUQaL5GlvMpA+zgJk/ApKs5ta+Rq5mGeqUwdxogKi
AlbHY++iPkl8pqExaB9J7aZGM80PIA==
=nKqd
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
