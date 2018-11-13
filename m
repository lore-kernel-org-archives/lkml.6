Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D10C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC071223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="b5rsv2bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC071223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbeKNIiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:38:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FRDSffouTrTRxXmIGdA+uMp4NWeufgJXyoHM30q2deQ=; b=b5rsv2bGfg+kFwyUEuaqrVva2
        paHcxBVc0XoIog1Z/pCHzGTfUFrTr0BhmifUw61d/hkNNSLSbhswO+TbA8AHbGc6SHyQB0+f1Cm/w
        fXDPFmiL9r8cBAoAziNVwWM5Ar0U8WhcqNfBgbVEhkADx7Xq2OlvhthlzL8hnL65vxDhY=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMhKG-0002hr-9b; Tue, 13 Nov 2018 22:38:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5BFD7440078; Tue, 13 Nov 2018 22:38:22 +0000 (GMT)
Date:   Tue, 13 Nov 2018 14:38:22 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] spi: add driver for the SiFive SPI controller
Message-ID: <20181113223822.GN2089@sirena.org.uk>
References: <20181112142736.15009-1-kernel@esmil.dk>
 <20181113183527.GG2089@sirena.org.uk>
 <CANBLGcxF-WgsBVFHf4jGRR+Ox2vz=ewzhwGP1CZX-R5HpDAVBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HxQt9wRz9wbL5Edg"
Content-Disposition: inline
In-Reply-To: <CANBLGcxF-WgsBVFHf4jGRR+Ox2vz=ewzhwGP1CZX-R5HpDAVBg@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HxQt9wRz9wbL5Edg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 08:48:43PM +0100, Emil Renner Berthing wrote:
> On Tue, 13 Nov 2018 at 19:35, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Nov 12, 2018 at 03:27:36PM +0100, Emil Renner Berthing wrote:

> > > I know the discussions about the sifive devicetree compatible
> > > strings haven't come to a conclusion, so I'm sending this as
> > > an RFC to get some feedback on the rest of the code.

> > I've not seen any of these discussions or earlier versions of this
> > driver so I've no idea what's going on here :(

> No, sorry. This has been discussed on linux-riscv for other drivers
> like the uart. See my last answer.

> > > +Optional properties:
> > > +- sifive,fifo-depth          : Depth of hardware queues; defaults to 8
> > > +- sifive,max-bits-per-word   : Maximum bits per word; defaults to 8

> > If the hardware isn't fixed yet making these enumerable from the
> > hardware would be good...

> Agreed, but unfortunately this is already in the FU540-C000 chip on
> the HiFive Unleashed board sold by SiFive.

Pick an unused register you can read safely and define that value to the
default :)

> > > +/* for consistency we need this symbol */
> > > +#ifdef REG_FMT
> > > +#undef REG_FMT
> > > +#endif

> > We do?  For consistency with what?

> Below all the register offsets are defined as
> REG_<register name>. This is is a pattern I
> copied from other drivers, but here we have a
> register called "fmt" - hence REG_FMT.
> If you have a better pattern that doesn't clash
> with REG_FMT please let me know.

You shouldn't be using such generic names for your internal identifiers,
add a prefix to everything.

--HxQt9wRz9wbL5Edg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrUlsACgkQJNaLcl1U
h9Dh5Qf/VUw8Ra+KYUjDwFvhBTQ/WLhdXFh/koVtPuDeo/mLnyehCCyuEv/oSrll
0udob665plGSH3CYnEz4V9b5tmNdSJxp07aKox6x89MFVLEX7uvGcKBn3H5fWEs2
DVuySHjWrLqii2wO0CMIfOl36cv98tXKrY266JrfjDcOf8hCb/anRAo3kVpWjWb4
Xsu1swOFX21MIYzQvoSveObgSveQq6uKuvBZMlcBFvCMUVY3Nmz7txmmJybH/2Dt
1i2G85fW+vNQCnQMziZGIEcrZHimx+xUeW3gofnpedoiYMAFcJ90il6N2tGal4HV
791AgaI0CuowfiED5NUNrWxpANZX9A==
=XS6h
-----END PGP SIGNATURE-----

--HxQt9wRz9wbL5Edg--
