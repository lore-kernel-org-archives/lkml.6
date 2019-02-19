Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8775C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C659205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661318;
	bh=NNc6vBVeoFaN+p2rBM9WmeQ+Km9HokmzovhqdZx6O+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vuBREaLXF4yZD4lhs06zLm1/ks4XdWLynkOK+zdbLTXP+XgpNsVgS/BoZfcEnZg/m
	 4VKTH89PhidsFG3igAcuEoFmOJK4tcCCBpzLcuQo+bqk2T5Xqw3FTnmmqNM8Ivt0fd
	 8p43ZE77ISbOCb/iuLdDXLsASgPvdxVCPnF3n/t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfBTLPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:15:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbfBTLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NNc6vBVeoFaN+p2rBM9WmeQ+Km9HokmzovhqdZx6O+s=; b=U6Sn9EWU8IKgcQAqxnmlaVfy8
        yHkbjsKOjucXS8x+7QSLHGLWjkRZrMbjthsEASgviaykFID0XYpzHXsZM/aaw/rZY0mZZhNzT8VvN
        1ChdXbbyCYBQnwO7d/koGzoC4aXCrrStjg7WpvhdSc7vdnZc12qtM3+6B1bP1Ia1gfEX0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011k-EX; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A055411284E2; Tue, 19 Feb 2019 17:18:03 +0000 (GMT)
Date:   Tue, 19 Feb 2019 17:18:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Codrin.Ciubotariu@microchip.com, lgirdwood@gmail.com,
        dannenberg@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Message-ID: <20190219171803.GC20883@sirena.org.uk>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
 <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 11:06:48AM -0600, Andrew F. Davis wrote:

> Did this work for you before? Strange it would if reversed, I wonder if
> the SLEEP bit is really doing anything here. Can investigate later, for
> this patch:

Thinking about it some more I'm wondering if it gets overridden by
something else (ie, the CODEC actually being asleep requires this being
set and some other thing being turned off).

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsOkoACgkQJNaLcl1U
h9C8cgf/bElHXfzIqyP2DfbS7VJ8xR8goYpHDclWxxsbAmGZzhUt1T3BOkcSIG66
QtUabn0AxqGUIywyf/2eFleKxlXrAQFrgYEzQagBqu/umyf4/kkTvcl1qEaYXIOD
7dLB1oYPa3Ey5NPkcNXGjBv3debezssjQHp7aLBnAqKvbV1y6u2iJxZqlGKHfHmu
zWidKOEBUqrr2EkzybpxNSg1eGBcFbFL80uTlAajklBMMuDSC0+6ZyWUTfUtpx2t
tvh7b7ch4XYJGHI/MrSzkonkQ0SiOWJI8NquV+yIz0fditA70i81YZJLvMJGxliC
DlOLBEeD/YGnF53GNmeH60kH2eWLlw==
=YvJQ
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
