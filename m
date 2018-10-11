Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFAEC677D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D162075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mjnWlJME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D162075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJKWV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:21:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TCLng7w7kxew+FKYbtyLDyjZ3+fnEkyKO2PrKXbvdNE=; b=mjnWlJMErM6KNINZHFTzeICeN
        R4dEHVPJI8zJWsO5q2iLrOfxJHYmWWeDGEbMxckdPRekKnCFbTU+3GR0/66Btsh6+KcxBk9ltOBuW
        WXc/iLFaXSxJ+UoHUA1ILJ7+zT3PYgdSZWa+IzHolPLKavbJXg825IpZBRlJ6xCBzBR9U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcM3-0001s2-3j; Thu, 11 Oct 2018 14:54:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CB37E11223ED; Thu, 11 Oct 2018 15:54:22 +0100 (BST)
Date:   Thu, 11 Oct 2018 15:54:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181011145422.GG25351@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> Quoting Charles Keepax (2018-10-08 06:25:40)

> > +struct lochnagar_regmap_clk {
> > +       unsigned int cfg_reg;
> > +       unsigned int ena_mask;
> > +       unsigned int dir_mask;
> > +
> > +       unsigned int src_reg;
> > +       unsigned int src_mask;

> Are these 32 bits or 16 bits or 8 bits? Please use a u32/u16/u8 so we
> know the register width.

Note that regmap always uses unsigned int to represent registers
regardless of the underlying physical register width, this can be an
issue on reads since we pass the destination for the read in by address.

> > +struct lochnagar_clk_priv {
> > +       struct device *dev;
> > +       struct lochnagar *lochnagar;

> Is this used for anything besides getting the regmap? Can you get the
> pointer to the parent in probe and use that to get the regmap pointer
> from dev_get_remap() and also use the of_node of the parent to register

dev_get_regmap() is pretty expensive, I'd not advise using it in
anything that might approximate a fast path.  It's kind of debatable
when I2C gets involved but still feels wrong.

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/ZB4ACgkQJNaLcl1U
h9DNJAf9EKHrofZgBKsBnywuSARMnN1WAY1k6GAd/yVMp1Ri4P1CQ5MtrBdFEHce
IAGb09TNUUTrfG0VudexTn7YEc8zi/hZ7kNBFD383zkAlgyP2y3LRZRCftvgITOd
KvgC4yxNVD9exrB1T/WhZh7q9rxv7qwpZwvIOfYzO+vxAtxuAvaTJk+tfKOHSi2H
20kFHKH3BgbtZYucNSlh9spFqIwT2HP7H27TFWbfDd34Gbg4f/9VeKIrtDlEFbTb
EXfwpQasMEEBFv4SBJ056jPvDIzhxCZy7b7afuSbgwdjfWzfcaeS7MoqdaOVX1Ci
ekUtnCdiZ+ujH8ekjSWAEuDFjrs2GA==
=uWfp
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
