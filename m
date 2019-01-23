Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FBAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5696021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548258949;
	bh=4XiF7XB6j/3r3YmS3LSqBWnY8A/uK9xGTJhL4sUFnJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jPcg6TlJrIzRetMSbuaYQdk7R9qIoQMXPnTdGYO+6sKGyQF1sybk0Ho0Ep1QDPjZu
	 BsOBA6SLWNAWIFFHhMX8mcACM6AIrj0eCmU/ixXQWNNBZVJWbaAzPbmw5/pUsZO4Ol
	 foRIkFBg7ACFog1lNUcEI8t6b5nAA1OMsP9h9iDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAWPzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:55:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qCb2cfVsJ18RrAwohqaEffdA2F77n5lDC7o3AK/BZHM=; b=mps/FHoYLmktEb7TKgx7CrBPm
        w6qMI8j0IcY3UJ2d1isBCMfrPChpZVej0SBylFxCiBCF1gVdikz95KxNbJA3IX0kBJ9TWjfVneyyS
        bKsmqxSbSjdetg6nnzRz70qk9Tx7OmFQ0s/iJA6HssqIkoAYOOxzv7MxOjGrACMNHmy7U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmKsF-0005rq-Q7; Wed, 23 Jan 2019 15:55:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6C47C1127ABA; Wed, 23 Jan 2019 15:55:31 +0000 (GMT)
Date:   Wed, 23 Jan 2019 15:55:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 01/13] regmap: regmap-irq: Add main status
 register support
Message-ID: <20190123155531.GC7503@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <a5a3cdb00b9181897fc675f4a6900064d9289fdc.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <a5a3cdb00b9181897fc675f4a6900064d9289fdc.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:42:24AM +0200, Matti Vaittinen wrote:

> There is bunch of devices with multiple logical blocks which
> can generate interrupts. It's not a rare case that the interrupt
> reason registers are arranged so that there is own status/ack/mask
> register for each logical block. In some devices there is also a
> 'main interrupt register(s)' which can indicate what sub blocks
> have interrupts pending.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-irq-main-status

for you to fetch changes up to a2d21848d9211dad5e786aa7368709ca8938834e:

  regmap: regmap-irq: Add main status register support (2019-01-23 15:52:15 +0000)

----------------------------------------------------------------
regmap: Main status register support

Add support for a main status register, used by chips on slower buses
with many interrupt sources to improve performance in interrupt
handling.

----------------------------------------------------------------
Matti Vaittinen (1):
      regmap: regmap-irq: Add main status register support

 drivers/base/regmap/regmap-irq.c | 99 ++++++++++++++++++++++++++++++++++++++--
 include/linux/regmap.h           | 31 +++++++++++++
 2 files changed, 126 insertions(+), 4 deletions(-)

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIjnIACgkQJNaLcl1U
h9A6Dwf6A9lsIBpD+TiAoijbdEzoXqd/cmk7XgSy/A667LTDjzbi5yBhrjhOGwkz
83o5oE/oS6bba5hgVls8QO4C3sGrPhdtDPF+Q6LpGS4uNxq/o6Mv3KRbZU8RAPzZ
F0znv/m2UqJa67vx20iiS72+oZEyFfuaihQRjMBP+nP4nFu/dmnmLZegh3h6R/z6
xliTfo5ljMjCb2h379hdmlbv4FUJ9d4A7ARvs49AB6Wt/br0WWVdINBPQiVRWYY7
bTLeY9HglV2z2UL72NNMRU5ie1vhiLGDwCkEbiVWVXscay3sLl3xyBUJHFfLbc4D
kIE6YXfIVU52U/5gIucvj4wN2qz+Qg==
=kp0o
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
