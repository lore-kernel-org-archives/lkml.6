Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88145ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5129A2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KdQA6yXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5129A2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJQRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:37:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YvV3E8fDWT33/BF2JN0pyZvn5VEVzOUB1JTN5jmEtPI=; b=KdQA6yXr5WXVMbBpg8tVWF9QE
        slVHWGdOIaV7K7hCHayhklpjfkX7tZRmkdqQaEfoEfd3J2gmQtfCgiQFlX80sT/H1y1gKqb34A9Yu
        96FfSqz4FIJ8DB0q89trBAmGGPcqnFQI5EHZavw+/m0HKa6QYokehee56u+tm4RIH8R7Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCiLA-0000kO-QX; Wed, 17 Oct 2018 09:42:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 60B7811224C4; Wed, 17 Oct 2018 10:42:08 +0100 (BST)
Date:   Wed, 17 Oct 2018 10:42:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Message-ID: <20181017094208.GA24097@sirena.org.uk>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
 <1539628457.30311.5.camel@impinj.com>
 <20181016090310.GA7449@sirena.org.uk>
 <1539718160.30311.10.camel@impinj.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <1539718160.30311.10.camel@impinj.com>
X-Cookie: No passing zone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 07:29:21PM +0000, Trent Piepho wrote:
> On Tue, 2018-10-16 at 10:03 +0100, Mark Brown wrote:
> > On Mon, Oct 15, 2018 at 06:34:18PM +0000, Trent Piepho wrote:

> > > I imagine it depends on what set_cs needs to do, which might not be
> > > solely related to changing the CS line.

> > It should be.  If something is hanging other work on set_cs() then it's
> > going to break.

> IIRC, for spi-dw setting CS is the only way to trigger the master to do
> anything.  I think orion is the same way.  Even if you don't want a CS
> line the driver still needs to assert one.  Which CS to use as the
> dummy CS is a challenge that has come up before.

> bcm2835_spi_set_cs() does check SPI_NO_CS, but it still does a lot of
> other stuff even if that is set, likely because of the above issue.

For hardware that's that broken I'd recommend deferring the actual CS
setting operation to the transfer operation instead; that way we can
guarantee it happens for any pattern of access to the chip select (or
error out if we can't represent it properly, though obviously a lot of
such systems use a GPIO for the chip select to work around the broken
hardware).

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHA+wACgkQJNaLcl1U
h9D7iAf1E+tEL/0/m02X3vYOi4VSrh4lRPpsHO7rts6ytFWFkd2if6GN5KTNI921
CGCgTeiqOm6csLuUi9LBJ65ccwenslCgyo8/ik8PsHOS722dUg4UCqCeBpCVE9CR
B3nsnAvJfa3uAk53a8I4OR0iDTtOauGugTs6oPLF1CU2QsJSevLgJeZP5cgg14Pn
RR5OnK99UQXzMuTThTagDkPhg4lfXrodYGJ4ZpxhlY1ebE1mLhwQ9wqXKGBFKfdT
nTNmTY0zP5Kl6rPT3M2NvIXaML747kQjqrJOv6rh1uIimZD1kejxXfMTqHIX3aXy
pncogI5DiwuHvRwgaM9LbeHalGwQ
=XpV0
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
