Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED0721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519062;
	bh=f79EABYDV+dsASJEvEqhPNamqf/vT4jNMtDLjiGrScg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HUBruOMibTDQ+S4Hr0ie86Hk0CAfxX/R1q1C1E43twCMVBf0KAJn8e8OAN5OTccyP
	 aSsCLPFr6NEXTb+4V59qUkd47SbnKfJSBJ7L7dx9if+lFE/HbjPD75J8qsKetCQ37m
	 cP3mLdHo3ifpJOLkszRt+Vjg1XnJeX/QCR9jjBPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfACMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:37:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfACMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f79EABYDV+dsASJEvEqhPNamqf/vT4jNMtDLjiGrScg=; b=d0n8LxGZy3PpIfjIs+EE8Mpd3
        FYrWxgW0/9IidXX/M2+o8B6PLYGj95PczplxgeEMJWH2j8CimIHhzPq5+a5rbTxwVQ3jfDbFcPI18
        yebyIbbIQbcpjVzWhpkh7Y+7D+0xjq4FYICoYfUz7vHQAhG7jrnFInoFQQBPEMxOPX7G0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gf2FV-0005TW-AK; Thu, 03 Jan 2019 12:37:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B277A440080; Thu,  3 Jan 2019 12:37:20 +0000 (GMT)
Date:   Thu, 3 Jan 2019 12:37:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        starnight@g.ncu.edu.tw, "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio
 to register as a clk provider
Message-ID: <20190103123720.GR1846@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
 <20181231175034.GI1846@sirena.org.uk>
 <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
 <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2C7pJE7HE4aLL3l"
Content-Disposition: inline
In-Reply-To: <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2C7pJE7HE4aLL3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 01:44:40AM +0100, Andreas F=E4rber wrote:

> So, the third invocation of sun6i_transfer_one() calling clk_get_rate()
> hangs at the prepare_lock instead of reference-counting, because it runs
> from a separate kthread, unlike the two previous calls?

If there's any contestation for the bus we push all the I/O through a
separate thread to maintain ordering and improve performance.

> I did not find any *regmap_init_spi() based example in drivers/clk/, and
> all other "spi" mentions in drivers/clk/ appeared to be clock names.
> The closest was devm_regmap_init_i2c() based clk-cdce706.c, which uses
> the prepare/unprepare ops, as suggested by Mark, and does
> regmap_update_bits() from there.

You'll find a bunch of the MFDs have SPI options as well.

--l2C7pJE7HE4aLL3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuAf8ACgkQJNaLcl1U
h9B0fgf+L5M5NYjkOb8YWAmiLMYKo32qz8zumAKB3jHRMDLhmVZ11snwrNem9O1u
a9uD3TkuRJqmhjiGU41W0F+7+72K6RVlQHqQXBTCbvBp2NtnwPUlwRsJyDMjfuoE
m+Tc1NWzViVdxoSBK1GwGc49gZcZtqLT0gfInSOCSyhDQpD815qpSaBH72jh3oNa
txSLnhegZan3tHsatH0Vi0Ly8JweQ+RMG3GV9vWe4DgPAA8kM1/p2Pg7pCVUPb6O
jwFZEtXHVKW4ZRQ093OPH+1ReH31GoxKnXkw0S8cq4vnLqbnxcTpRrs8X8DypCbF
ofLLAAWzlMrfyfXw0tF5wjGAI0x/fg==
=fEFJ
-----END PGP SIGNATURE-----

--l2C7pJE7HE4aLL3l--
