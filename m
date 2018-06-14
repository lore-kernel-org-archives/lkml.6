Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D4120C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B02208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B02208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeFNIP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:15:56 -0400
Received: from sauhun.de ([88.99.104.3]:50022 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752837AbeFNIPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:15:52 -0400
Received: from localhost (softbank126012118084.bbtec.net [126.12.118.84])
        by pokefinder.org (Postfix) with ESMTPSA id F056A54006A;
        Thu, 14 Jun 2018 10:15:49 +0200 (CEST)
Date:   Thu, 14 Jun 2018 17:15:42 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180614081541.zlxu6ga47gdg42un@ninjato>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
 <20180614041941.4i2cadzoevujmzha@ninjato>
 <20180614090758.17180594@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7unw2cj2dmujiusg"
Content-Disposition: inline
In-Reply-To: <20180614090758.17180594@bbrezillon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7unw2cj2dmujiusg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I don't know if typical I3C transfers will be similar to I2C with
> > usually small payloads where DMA usually makes not much sense. Yet, I
> > think, that it might be a good idea to think about how this shall be
> > handled with I3C right away. Maybe simply enforcing buffers to be
> > DMA-safe. Or whatever.
> >=20
> > A clear rule on that might save you hazzle later.
>=20
> I completely agree. I'll clarify that and for people to pass DMA-able
> buffers to this struct (just as the SPI framework does). Note that we

Ok, cool!

> don't really have a way to ensure that the buffer is actually
> DMA-safe from the core, because this notion is architecture/SoC
> dependent.

True, we can't ensure it at the core. Still, a documented rule will make
it clear that everything else is considered a bug. Much better than a
gray area you have to deal with later.

Kind regards,

   Wolfram


--7unw2cj2dmujiusg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsiJC0ACgkQFA3kzBSg
KbZEnQ//dFjlQ2ROtEDcAOlzSfstcuOOulEjtSAycl1EYPFpn+G0xs/n3rHqiZmP
wmjHmKAmqNHSAmyUSjlqCmXirzruB8Rln7eCb1OUFZSEyp2hDh3VA73xJaEdFOFF
EgyoyN1SchNgUxeEj08r3zBDv5KFPh6dCEgIQOwFRB299v4BD6xS+O2gvzgveWGW
oUXd8l1qeVBC25/DbnlxT0iqC/1q0U+usrR/Eu2KInztK5ug9vQ43hTkJaZ+SbiI
cmKv0AOWAhd3wAtg5oCmFuC8tzIW07uq+RsDiRpsc6BFwKtNCAbhI3cUAy3CCI17
5iCIqlCremt3nYLPERYwhVT10pM7j75mYqOsO7VQDsomFEyMWKxTp6DyqgIgRBJO
EG4+9/rmHKPdbSSiWZ3GpVf/MFcdNlzRkN0+lzml5juz/SLaeyBr6Jxh5VxCzRLI
yOnXfvPMEGFEr8E45vaoeOqpgm3cb0ivC4pgJ/buPDHiVetGAWHzF96sT3xSXYv5
8PlJDovgHEPwuXPXvtPlpkBndzls7dKvW+Gmyz2czQphwHo+C9ww/PhpY16zSZRk
dZbZU4V7OFmjO9bWPj1jWpLEnoYlrGMziOuX43CsCNOjSQe6oMEdXFZw5QjB2SQ1
eSn45yFoypMWEvTZtZyP+wvHKcnYm7VxEYQWy9QAtaWzkEe1fWk=
=x3M4
-----END PGP SIGNATURE-----

--7unw2cj2dmujiusg--
