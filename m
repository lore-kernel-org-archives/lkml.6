Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C72BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C541920864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeFNETu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 00:19:50 -0400
Received: from sauhun.de ([88.99.104.3]:48956 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeFNETs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 00:19:48 -0400
Received: from localhost (softbank126012118084.bbtec.net [126.12.118.84])
        by pokefinder.org (Postfix) with ESMTPSA id 4591954006A;
        Thu, 14 Jun 2018 06:19:45 +0200 (CEST)
Date:   Thu, 14 Jun 2018 13:19:42 +0900
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
Message-ID: <20180614041941.4i2cadzoevujmzha@ninjato>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="st33g2u2nspyzp4d"
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-2-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--st33g2u2nspyzp4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

> +/**
> + * struct i3c_priv_xfer - I3C SDR private transfer
> + * @rnw: encodes the transfer direction. true for a read, false for a write
> + * @len: transfer length in bytes of the transfer
> + * @data: input/output buffer
> + */
> +struct i3c_priv_xfer {
> +	bool rnw;
> +	u16 len;
> +	union {
> +		void *in;
> +		const void *out;
> +	} data;

So, this is probably where most payloads end up?

I didn't notice any sign of DMA in these patches, but given my
experiences, DMA will come sooner or later. And in I2C, this was
problematic because then a lot of drivers were in the wild getting their
buffers from everywhere (stack!). We now have an opt-in approach to mark
buffers as DMA-safe.

I don't know if typical I3C transfers will be similar to I2C with
usually small payloads where DMA usually makes not much sense. Yet, I
think, that it might be a good idea to think about how this shall be
handled with I3C right away. Maybe simply enforcing buffers to be
DMA-safe. Or whatever.

A clear rule on that might save you hazzle later.

Regards,

   Wolfram


--st33g2u2nspyzp4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsh7NkACgkQFA3kzBSg
KbYaJQ//WvuZkJrJ/IluxoHlKtN048uYvkfLNZCpddYE5p7JfxrreeOyn/EMQYUX
ftikOAIWzo93LpPAgeKqHTD6FCMgfUDfB7RWZFJeRuMLZ/cOdDbsTA0Y/1S76SEl
LEXebvQYhHd3YJsqDDGmyhCoXGtf/1n7tEJ4ax4NdJVMx0QGXUWuAlQAs2QAzNYk
BzDfHEIbKc9469T5naQrQIVoaJLUqLCXs2RBzRnMDr8hl7wRtMckq64U28CiTNuz
Hu/yh7axdg0EIqy/famCHzsbfg8Z5GXig8PNEBG5fCf0vL4aMap+56siQHsP4UgV
bQgcIPSxqWcYBy2YVU4aiaLUdSYsAs/qympVnrWwRa6Lfy1z/JxPIs+7bI6TSER4
OlMhrTNEiyiZbP5uj4LF+JlmFwYthzxwM9/j8ae6ZMsry6nQ5VFTYyUjOSUis4bQ
05xrq8eZ1LDI6Kex4S9kY9OaN0bDo2u8xZv5yVqvbJaJ8dsD7uul94oGJPlO2jGm
rUErZxjH8Q3u3QeQIyyZWRZlX1dIv+feeLbjRXlPqcdQfPcjbrv98T6FsuYqttzs
FpA6wa1kbUZCchsuaxCvZu+5ja3OkYieYJ4keQlvO3EVzGnl3b0rcrOoSktr4ONs
yBoV6WvF7+a/c+2ldQvi3/qaVu350CbdLowLWvX5yIFWtCOSkGM=
=ojn/
-----END PGP SIGNATURE-----

--st33g2u2nspyzp4d--
