Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF8A24210
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YBPBuHz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF8A24210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeGCPcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:32:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932440AbeGCPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FSRXtc547TiJ/Ek+9nzTt7NxLBNfnZIoF5dyOdV3v8g=; b=YBPBuHz7petmBvGo5XEFYNUrR
        YzJ8ThlIv9T6Q8MhPa4BHBsL0gyoerUip6FjFX4/UIKirnZeU7ljFWNk57c10JxDjNrxnIPv45y+v
        xOI9Nv9h1n5x53mhvLMSspy6ATTkGYxf2iWJuETbSsuIMxhnXDE7bF12du8T/Oj3dMkTw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNHG-00069P-S0; Tue, 03 Jul 2018 15:31:39 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNHF-0003Ui-Qr; Tue, 03 Jul 2018 16:31:37 +0100
Date:   Tue, 3 Jul 2018 16:31:37 +0100
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
Message-ID: <20180703153137.GB13744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
X-Cookie: Dental health is next to mental health.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:09:38PM +0200, Andreas F=E4rber wrote:
> Am 03.07.2018 um 16:50 schrieb Mark Brown:

> >> 2) This SPI device is in turn exposing the two SPI masters that you
> >> already found below, and I didn't see a sane way to split that code out
> >> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> >> any precedence either way?

> > A MFD?

> I know of mfd, but how would the the the net vs. spi pieces interact
> then? Some functions would need to be exported then or is there an
> easier way without needing to set a cross-module API in stone?

It's an in-kernel ABI it's not exactly set in stone but yeah, you'll
need some interface.  A lot of devices work by having the children know
that they're part of a MFD and fish things out of the parent device,
either the pdata or (in the common case where the MFD bit mostly just
instantiates subdevices and holds a regmap) with dev_get_regmap().

> > A register map would work just as well here, we already have plenty of
> > devices that abstract at this level (most obviously the I2C/SPI devices
> > that use it to offer both interfaces with a single core driver).

> The address and data registers together form a two-byte SPI message!

> It is transmitted by writing to the CS register.

> The received data is afterwards available in another register.

Right, but it seems from the code that the hardware understands that
it's formatting register I/O and not just shifting in and out a byte
stream which is what a SPI controller does.  I'd not be surprised to
learn that the register you're calling a chip select register is a
strobe that initiates the transfer (and that this may be some of the
difficulty you're having with handling it in the way the framework
expects), the pattern with writing 1 followed immediately by 0 is a bit
of a flag here.

I've seen such before hardware where I know it was intentionally
designed that way so it wouldn't be totally surprising.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7ltkACgkQJNaLcl1U
h9A+lwf+M8MTt6KWaR4J9ViDILdK0W8JxGgJ2Glb/wXPZ7TDowwt6N0oQs8Cg8cZ
ch1D/dW0vBuW/NmvFtarbcfqAEJCIlL9oFovgMTao6RLZTc1L2unzKifbtTzUhHo
bqUXZA5ubjQuwESRbbd5C9PM2HSMfXKn2BrvvLYz9FyYMRlGVJf9oom8vGzYBo/t
DbMe/c4o+Tw7golyzKKraTTV61DAtXeaT0wgYLKR5iB/sPtViqn9LombTM7tyQxi
Oi3SLV/Q838Bpk+fwQEXfRzSVO073z9+46kpG4lg11xzf9WT9lOq6e2qrtOgsCVy
FEW068wwEBTdALjHWYCx3DUkN4prIQ==
=Dyei
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
