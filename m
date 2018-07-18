Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7086ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784E020693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="II3QxDR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784E020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeGRR6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:58:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Km9YjbVlMki2soMa8PNHBQdMsqkeeslud55QZeyn0Q=; b=II3QxDR8x7k3rNnyj2EJM6lZa
        NeSC5YaBSpNSyy66+zIfX/HxGS1o5zPbnKQ6kB1ZxZP1lzKW+UL2WSur8wAGpAWvTofTAkjfUgYA5
        YBphkh4vhClooAUfGXjyspGaSEtxKRYvDwjYPbmWSOxrmo8oQrbW6umMNekSh8hfCIulM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffq6k-0003tV-5s; Wed, 18 Jul 2018 17:19:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffq6j-0008VX-5D; Wed, 18 Jul 2018 18:19:21 +0100
Date:   Wed, 18 Jul 2018 18:19:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
Message-ID: <20180718171921.GB20360@sirena.org.uk>
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
 <20180718150450.GO5700@sirena.org.uk>
 <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
X-Cookie: Marriage, n.:
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 11:47:30AM -0500, David Lechner wrote:
> On 7/18/18 10:04 AM, Mark Brown wrote:

> > This feels like it should have a soft implementation if it is going to
> > be truly usable, the vast majority of SPI controllers don't do this and

> This occurred to me as well. Another possibility, though, would be to leave
> it up to the client device drivers to support both cases, e.g.:

> 	if (master has SPI_CS_WORD support)
> 		setup message as single transfer
> 	else
> 		setup message as multiple one-word transfers

> This seems like that would be more efficient than having a generic
> implementation for masters that says:

That then requires every single user to open code this which immediately
suggests that there should be a helper which is going to look a lot like
any generic implementation.

> 	if (master does not have SPI_CS_WORD support)
> 		allocate enough transfers for each word of each
> 			each transfer of the message
> 		allocate and setup a new message for these transfers
> 		loop through the original transfers of the original
> 			message and copy them to the new transfers
> 		send the new message
> 		free allocated message and transfers

I'd imagine that the much bigger problem is that you end up with
enormous numbers of operations for any non-trivial transfers which is
going to happen anyway.  It's really only the copying bit that's at all
an overhead here.

> > I can only think of a few that have the hardware feature.  I'd also
> > expect to see some validation added to the core spi_setup() since at
> > present a client driver could set the mode option but then have it
> > ignored by the controller which would presumably break things, we
> > currently only have checks for specific modes and nothing that'd catch
> > an unknown flag like this.

> There is already a generic mode flags check in spi_setup() that will catch
> this and return an error if the device has the SPI_CS_WORD flag set and the
> controller does not. (I know this works because I ran into it during
> development.)

Ah, good - I'd forgotten it was there and didn't spot it when I went to
check.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPdpgACgkQJNaLcl1U
h9CCEwf/fjzvKt8d7Z/SHssIQdPcKePzdpYKRSJfq4cYuvxI1kjE7xLV5K+fmMoV
yAE/IlrchzIeuNY4ukoGnVlo/pVQxapBOzJQhzObkiReItNBH+wkMn6RFJQdBLCz
5T3eMgRbhGoiTuDhC/fLnUj8ZTgMBxOqKVUhigyG74I/QCODzq6T1x876dzWgn/x
E1PDRe5rHqSNd3+6DtGdBTuf6l3NwqjWN4xTzPQF/fw2bBeP20rN0QLD7esvDBkF
TdhIWktx7vJP6wHq3LFSrck7K0azTIjOjhwtE0/U5Vrz/lOF7B+IvVY8wbtdXE1A
JknONrhbUTCzsMeR3TAZ0rnCmXmttA==
=S4Z6
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
