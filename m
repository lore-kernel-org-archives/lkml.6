Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD8A24906
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pMIRA5/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD8A24906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbeGCOvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:51:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeGCOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oUM+Pdh5sBuzX5hm9GY8hXnqeO6xknKk4ZVURaRmhok=; b=pMIRA5/TVOjJ2j+6NW70F/545
        0kT5XLDllTbWq5icS7xTHq9dYsTTP9EcT+tD6ZNPHFhCG7x1KlAIX15RmOxVWRQYV+M79JmfwtOXP
        PoFO/UexNmmML2cYtTDW0lNKrtU7LpG8XwpVcWDtA0a7eSw2UHq2cMUr+wEgBTSrEtNq4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faMdL-00067W-Ei; Tue, 03 Jul 2018 14:50:23 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faMdK-0001q8-KQ; Tue, 03 Jul 2018 15:50:22 +0100
Date:   Tue, 3 Jul 2018 15:50:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>, linux-spi@vger.kernel.org,
        LoRa_Community_Support@semtech.com
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Message-ID: <20180703145022.GA13744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
X-Cookie: Dental health is next to mental health.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 07:34:21PM +0200, Andreas F=E4rber wrote:
> Hi Mark,
>=20
> This driver is still evolving, there's newer code on my lora-next branch
> already: https://github.com/afaerber/linux/commits/lora-next

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> 2) This SPI device is in turn exposing the two SPI masters that you
> already found below, and I didn't see a sane way to split that code out
> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> any precedence either way?

A MFD?

> Am 02.07.2018 um 18:12 schrieb Mark Brown:
> > On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:

> >> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enab=
le)
> >> +{
> >> +	int ret;
> >> +
> >> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> >> +
> >> +	if (enable)
> >> +		return;

> > So we never disable chip select?

> Not here, I instead did that in transfer_one below.

That's obviously at best going to be fragile, you're implementing half
the operation here and half somewhere else which is most likely going to
break at some point when the framework changes.

> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio address write failed\n");
> >> +			return ret;
> >> +		}
> >> +
> >> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx=
_buf && xfr->len >=3D 2) ? tx_buf[1] : 0);
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> >> +			return ret;
> >> +		}

> > This looks awfully like you're coming in at the wrong abstraction layer
> > and the hardware actually implements a register abstraction rather than
> > a SPI one so you should be using regmap as the abstraction.

> I don't understand. Ben has suggested using regmap for the SPI _device_
> that we're talking to, which may be a good idea. But this SX1301 device
> in turn has two SPI _masters_ talking to an SX125x slave each. I don't
> see how using regmap instead of my wrappers avoids this spi_controller?

It seems obvious from the code that this isn't actually interacting with
a SPI controller, you're writing an address and a value to a register
map rather than dealing with a byte stream.  There may be a SPI bus
somewhere behind some other hardware but you don't seem to be
interacting with it as such.

> The whole point of this spi_controller is to abstract and separate the
> SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
> instead of mixing it into the SX1301 driver - to me that looks cleaner
> and more extensible. It also has the side-effect that we could configure
> the two radios via DT (frequencies, clk output, etc.).

A register map would work just as well here, we already have plenty of
devices that abstract at this level (most obviously the I2C/SPI devices
that use it to offer both interfaces with a single core driver).

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7jS0ACgkQJNaLcl1U
h9BcQQf/Wh+yvlTJq85AJqGSGc5/mDu0xDi4DSc3njoxybXSMNOTY11hoEWajvKx
GwwZWNtudrJViG3Tm0TBgwjmJTvssXxE92B4X+f6fvB7k2k3rkrqe9XmK1BiwNa1
8TsUvLfHWcJNdgjhoBik6qe7cRpHt1mpYbfzbP297byRRGOmI9uSir68DT000z2C
abtq9ZxfVk8SkYQFLC8aoJajitFkj7u7QKl78gmZoC32OhPv9gs2ewdd/49DtlUh
kacwJuoJ65CwC37rnt7sdL7HnAiIeSmm+pUHqbpMp5N10hLe0S+7CiFnVAnhHxAL
HL7IYIqEFd5p7Zn+0+FJRDXBYvkJXA==
=FVYx
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
