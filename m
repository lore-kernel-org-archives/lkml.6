Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD63C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YjWiROD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD63C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeH2TYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:24:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2TYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GVB1UU6bi4gEOSNGnceU3Cjrd5hIgKgYxmVcR0XxOU4=; b=YjWiROD0mzwAQoSxvdOWb5AXs
        oea82Dg9IT6eSDn0SLErHd8ImZHGmd1AbbmDuZLsjHOfn/pEwSG7+yk403sOprjePJv3TxpTgUEdT
        E5oGUaxCOxvE41rB5hZ4hWvTXSx2iTvOQeGfdO1MpZ7AEhYvfxFYVuSHKpSgg9kKL3pOc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fv2Mz-0000T7-9W; Wed, 29 Aug 2018 15:26:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BDDE6112486B; Wed, 29 Aug 2018 16:26:56 +0100 (BST)
Date:   Wed, 29 Aug 2018 16:26:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, florian.meier@koalo.de,
        cristian.birsan@microchip.com
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
Message-ID: <20180829152656.GF27808@sirena.org.uk>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
 <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
X-Cookie: Not every question deserves an answer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2018 at 06:20:59PM +0300, Codrin Ciubotariu wrote:
> On 29.08.2018 17:53, Mark Brown wrote:

> > That also has the nice bonus that with that I think you'd be able to use
> > the graph card rather than a custom driver?

> The main reason for adding a custom driver and not using graph/simple card
> is the snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
> XTAL_RATE, SND_SOC_CLOCK_IN) call. This enables the oscillator found in the
> wm8731 codec. Since WM8731_SYSCLK_XTAL is not 0, we can't use
> system-clock-frequency DT property to set it.

Right, that'd be more substantial surgery on the driver to change the DT
binding so that it's got a clock provider in it; it'd be nice to do but
it's a bit much to make it a blocker so the machine driver is OK.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGuz8ACgkQJNaLcl1U
h9ABhgf+P2btioRY9N06d9KjSWUiRSkEYQPemnjN526ijueP5FG94UR8X5u2zmxE
6IyhiNVhkYYm3lythZpKBabkm0nU3ZR1wUhMa+RUCs2ZAaUKSRs+TK+LhqIDpAPw
eV+I7/kJ/1OD83+Z0NJNeAxxECW/QwkH90tBSwYC5mUmMiofOMAJWLAQHWaPBsBA
nR3oYqiEySwVj3EYJ/dqWhy9v9Ld/fYykqy/+RbrRiradU3UuS7MapUnPUySi9nE
jjV6n+rAXnZXwNX6zcawFISVzXeBrhbpdTLVmelIIxZa71ESj7sL30GXIZCXhHLt
D7Ux1EEd4mGBJwfIjzcKhIy1PVHriw==
=MfUu
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
