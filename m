Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="soCkVD47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1271D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeIRCrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:47:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRCrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/LclAU4reglbNS2yposkqn9A0u4I4tK0aTQFZvyVcNU=; b=soCkVD47+5cdOx7FgWniXvvCH
        YT6xXvKMsgdVEnIQXulURzC4Nn0nsF8yeKT+kshaRuscGOqWTyFLAUuzhhEJmQTzjAQvIZWwm0VtN
        7XhXfk3wbUMwRICvNN4bjq829e0l9hUi2+3xs3fRavCR0Ntg1xqEShcL8ZTD7HW9Y/eBM=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g20tV-0000jM-P5; Mon, 17 Sep 2018 21:17:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6AE0C440078; Mon, 17 Sep 2018 22:17:19 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:17:19 -0700
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] spi: introduce SPI_CS_WORD mode flag
Message-ID: <20180917211719.GG2471@sirena.org.uk>
References: <20180913003920.30600-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20180913003920.30600-1-david@lechnology.com>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 07:39:16PM -0500, David Lechner wrote:
> This series introduces a new SPI mode flag, SPI_CS_WORD, that indicates that
> the chip select line should be toggled after each word sent. This series
> includes examples of how this can be implemented for both an SPI controller
> and an SPI device.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-cs-word

for you to fetch changes up to cbaa62e0094a840fecc853910e0c0454529cec03:

  spi: add software implementation for SPI_CS_WORD (2018-09-17 14:14:18 -0700)

----------------------------------------------------------------
spi: Provide SPI_CS_WORD

This provides a SPI operation mode which changes chip select after every
word, used by some devices such as ADCs and DACs.

----------------------------------------------------------------
David Lechner (2):
      spi: add new SPI_CS_WORD flag
      spi: add software implementation for SPI_CS_WORD

 drivers/spi/spi.c       | 31 ++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  2 +-
 2 files changed, 31 insertions(+), 2 deletions(-)

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlugGd4ACgkQJNaLcl1U
h9DJIgf/f4joAEfsig+UrOY9kHMRYVZQQFoCjDDAefcaga6TIqBd+4x5xuZQImCY
inytWF9nN4fkhmdlYAS1yDBSFQJveVIRS26W6A0qPZFJ1ZcIE7DAbcfZ6E5orXlD
lTNn3SbkZWUDEw2TCSbMvgRPBvIvvaKQW1sqomZTM5Em6IivdRoQRpzR8E6V6oZL
ThWQ/ApRuVKjdfzz1cho02XDGnPUX+3/AszMIsymBXjRnF+FkViQf+Wz+lvIweeR
14IJVEdYn1ZeAFKOihoVpGKf0TO4CtviaFYCuAtbmvX6UwLjsz0FpWuA8L4NExVj
4M06Dc8gbeMtjZT1YF7lia4ShuRNbw==
=mNnI
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
