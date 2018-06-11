Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QCUfAV2OHlsifgAAmS7hNA
	; Mon, 11 Jun 2018 15:01:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8F33360791; Mon, 11 Jun 2018 15:01:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ieUCo33z"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1AEB060351;
	Mon, 11 Jun 2018 15:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AEB060351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbeFKPBA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:01:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeFKPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5R4zTjNRc7+z+jD1K6zBwdZBNZZoD6GafNoVhHGOx80=; b=ieUCo33zA3xq11I6CdlMoc14f
        7LFFcupsSJCJh16lg/qAnWHDTFZcrFwT/hk3AXsE9p91UDC24a8xjgmSUhgSAX7J2r0THj5NaY1qt
        cw6HKcupYWkAqljPuNTOgy2TRRubpbUL+xK0I6NsY20GikuUihd7UkWnA7JxyI/OrXQAQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSOJT-0000wn-Sv; Mon, 11 Jun 2018 15:00:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSOJS-0002p2-Ji; Mon, 11 Jun 2018 16:00:54 +0100
Date: Mon, 11 Jun 2018 16:00:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
Message-ID: <20180611150054.GC11580@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org>
 <20180601093511.GA11734@ulmo>
 <CACRpkdZEMPfxHc8dZOvyYN+S4o_zwKuYCTBbMiXMLsCZRz_f6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <CACRpkdZEMPfxHc8dZOvyYN+S4o_zwKuYCTBbMiXMLsCZRz_f6A@mail.gmail.com>
X-Cookie: Sell by date stamped on bottom.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2018 at 03:11:14PM +0200, Linus Walleij wrote:

> The DT binding for "regulator-fixed" specifies that enable-active-high
> should be set for polarity inversion. For historical reasons, I guess,
> we screwed up. The example in the binding uses that.

No, it just says that if the enable is active high then we should
specify it using that boolean property.  It explicitly says that enables
might be active low:

| - enable-active-high: Polarity of GPIO is Active high
| If this property is missing, the default assumed is Active low.

This binding predates the GPIO binding having any gpiolib level polarity
inversion.

> Sadly this only handled the undocumented fixed
> regulator binding "reg-fixed-voltage". So I need to fix it
> for "regulator-fixed" as well, and then it "should work".

The normal fixed voltage regulator parses enable-active-high?

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsejqUACgkQJNaLcl1U
h9BKUgf8DEQo+BbR0pBDJQHeVyBccqLeTfpwWukOEZYTwwmcXICJ++al8kL2Pey7
5l2X6iE6Jk78Ixoh2wqij14NmHIGNwlP6D1EO6aKP8IzHQKEE28nO5HjM/YbAhHI
8cdtPkQCDqG2BcGe16xDyLkeONyd1SCjZMCNAZh0ivG2Ba5mWAQZ4G66g/+yDiVY
4GQMb183Zo3JNdwv+exopSfRd3E5rR5fKsQ3B9poI7V1eC7nu78ItV5gSyQuMzLY
7lot8yb9fSKv6F6geKD3FCTmmobuPAGb8KfYagMJv3HFwLw6tO0DusQWNFpII6Qs
X4pfKcDTvFA4t8JPj2ly8PGlJcN1Sw==
=lMaH
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
