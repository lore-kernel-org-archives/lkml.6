Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E59ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F26206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F26206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeGTLxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:53:36 -0400
Received: from sauhun.de ([88.99.104.3]:56162 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbeGTLxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:53:36 -0400
Received: from localhost (p54B33241.dip0.t-ipconnect.de [84.179.50.65])
        by pokefinder.org (Postfix) with ESMTPSA id 360F45E000F;
        Fri, 20 Jul 2018 13:05:50 +0200 (CEST)
Date:   Fri, 20 Jul 2018 13:05:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180720110549.zgre7f7x7jkrbyt7@ninjato>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkvhz6jgoqk4tzls"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkvhz6jgoqk4tzls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>   will only ever be observable from one master at a time, when you
>   switch over, all children get removed on one master and added to
>   the other one, to be probed again by their respective drivers.

Yes. The very first versions of the demuxer tried to do it in a
hot-swapping like fashion but then I switched over because of...

> it definitely opens up questions in what happens to e.g. the sysfs
> representation, lock order, and power management that I'd rather
> not have to think about.

... this! There are dragons, I can tell you :)

> * The other thing we definitely have to support for i3c is to deal with
>    handing over control of the bus between the i3c master owned
>    by Linux, and other masters that are /not/ owned by the same
>    Linux instance. This is the part that the spec discusses in much
>    detail, with the intention of temporarily giving up control of the
>    bus to let another master do its thing on a shared slave without
>    user interaction.

I can't comment about this one.


--xkvhz6jgoqk4tzls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltRwgkACgkQFA3kzBSg
KbZY3w/9Fp795KxCTRbIxeQgXGj98k3Bl1La27iUL2CwndG4xQaRfaVIEkXTTCfF
5mFk/Ui4wzofIK3d6s97bmiu3WyMG+wR6rIEB7ikVZUeuGbXmSrygcidPkCbw7ka
EDrbnA+Sfj5+a0yOUGquZ6sho2+jFeTnTIG2zRm8vsbqXqHkqZMrFrrf5EFH27GH
stpmRZhfHzimbLLbq5fw1Q0GdPz2g5xlMbioBkGGVq4Q26B2XE4Ggp26UcGlyraF
wBEfTYW23JQ/uepPhvxVR/Cj63s9hq5e4o4YMb9PJsTmJ/FG4Ja317hYc0MR+jS8
6G5eYdzve2P+6tz0+syo8OVS0gjWSm1b7XXsYpeeZtoM2/2sDHMrEGPkvsfrLtBQ
2xT9SrClmT8SX9Sc3rQEFJNxlzVTv/bp+kfMRnN1DVG+Aa6KnPLJxoLhfMapEzgf
JUZ2fZs35Puo1Aw/dQWuBQiqvPpqyd4PEsC/f0WiebQYviXnDgXpV3WmEwCAWOyz
2qVFZwYoQ3LuzOVSNLY42FDyHAgrS/TOzKP2WExlFIin0yyjCmEWBmhwH5Tfr9ww
MMzy3E2VIFpHlFEW4LwhbheT7BMt3Rrn42aJ+7FBw8NVgsTTuublb8F+tt5fN1B8
mX9y6VFUJWd/BMf/RIYNB3HZCxIwvRAJWYuv0SwWighqYetB0NU=
=qblC
-----END PGP SIGNATURE-----

--xkvhz6jgoqk4tzls--
