Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E47C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5320824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB5320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJZLFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 07:05:15 -0400
Received: from anholt.net ([50.246.234.109]:36906 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJZLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 07:05:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1CEE210A12ED;
        Thu, 25 Oct 2018 19:30:08 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 86ZfCleEFgi5; Thu, 25 Oct 2018 19:30:06 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6C2FA10A0F99;
        Thu, 25 Oct 2018 19:30:06 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 034F72FE1BF0; Thu, 25 Oct 2018 19:30:05 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5" touchscreen
In-Reply-To: <2e548bd7-81f3-5952-b5de-96c26c9f6b19@tronnes.org>
References: <20181024184313.2967-1-eric@anholt.net> <87h8harnv4.fsf@anholt.net> <2e548bd7-81f3-5952-b5de-96c26c9f6b19@tronnes.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 25 Oct 2018 19:30:04 -0700
Message-ID: <87o9bhphhv.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Den 25.10.2018 18.29, skrev Eric Anholt:
>> Eric Anholt <eric@anholt.net> writes:
>>
>>> I was going to start working on making the vc4 driver work with
>>> tinydrm panels, but it turned out tinydrm didn't have the panel I had
>>> previously bought.  So, last night I ported the fbtft staging
>>> driver over to DRM.
>>>
>>> It seems to work (with DT at
>>> https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
>>> fbdev works great including rotated, and so does modetest.  However,
>>> when X11 comes up at 16bpp, I get:
>>>
>>> https://photos.app.goo.gl/8tuhzPFFoDGamEfk8
>>>
>>> If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
>>> any ideas?
>> Also, with these patches and the format modifier patch I just sent, mesa
>> with vc4 is now working with this driver on this branch:
>>
>> https://gitlab.freedesktop.org/anholt/mesa/commits/kmsro
>
> Ah, nice to see this happening!
> Getting hw rendering was one of the advantages I saw DRM could provide
> over fbdev on these displays. Little did I know how complicated graphics
> was outside fbdev, so I was unable to realise this myself.
>
> The current solution to get hw rendering is to have a userspace process
> that continously copies the framebuffer:
> https://github.com/tasanakorn/rpi-fbcp
>
> It's used by some of the small DIY handheld game consoles that run
> emulators which requires hw rendering.
>
>> Now I wonder how we can improve performance of the SPI updates.
>
> At what SPI speed are you running? The datasheet for most of these
> display controllers list the max speed as 10MHz, but almost all of them
> can go faster. Some are reported going as high as 70-80MHz. That's for
> the pixel data transfer, not the commands. tinydrm/mipi-dbi.c sends
> commands at 10MHz and pixels at full speed (mipi_dbi_spi_cmd_max_speed()).
> Most panels I have run at 32MHz or 48MHz.

I copied the DT from the adafruit tree, which has it at 32mhz.  System
performance seems to be limited by the copy and format conversion I
think -- in particular, I wonder if we shouldn't be doing our dirty
copies in our own workqueue.  I haven't managed to get any really good
profiling data yet, though.

glxgears at 128x128 is nice and smooth, and at 480x320 it's 6fps.
That's not filling 32mhz of SPI.  On the other hand, I would have
expected the uncached reads for the 4-to-2 swapped conversion to be able
to go faster than 3.5mb/sec.  If it's the uncached reads, we could at
least use NEON for the copy to cached, and probably even do the whole
conversion in NEON with a bit more thought.

Another option: use a vc4 RCL to do RGBA8888 to RGB565, since that will
be less pressure on the bus.  But then, I suppose I should just figure
out what's going on that makes X11 at RGBA8888 break, and fix that so we
don't even have to do that conversion.

I keep hoping there's some way we could feed output from the DISPSLAVE
HVS register directly to the SPI master -- FIFO32 gets us close (two
16-bit pixels packed next to each other, leftmost in the lower 2 bytes),
but the need for byte swapping (as opposed to R/B swapping) I think
makes it impossible.

> Almost all the time is spent in the SPI transfer, so every hz counts. On
> the Pi there's byte swapping because the DMA capable SPI controller can't
> do 16-bit (tinydrm_swab16()). If I remember correctly this has negligible
> impact on performance.
>
> The SPI controller/driver on the Pi has some restrictions on the speeds
> to choose from because the divisor has to be a multiple of two
> (bcm2835_spi_transfer_one()).

That's weird.  My specs say CDIV must be a *power* of two, with lower
values rounded down.  I guess that means we might be running things
fast, not slow, though (and at 32mhz out of 250, we should be getting
the same CDIV).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvSfCwACgkQtdYpNtH8
nuiPUw//fvXTsurPu2BCl58pMcW76ja4IHDiPu7kQQESmNRZSu9wx3jGxIUgEl2z
3hpA0r0wrxmYMk1q79DIhyq8qJbhlnc02h2Us5qLYpuBiBbpZ5hU/f/X4aTG3g7Y
6lKxg2oheTMfHXuFDrRfSN/VdY/gJvnscC7BlLyIyjVIwu8lpvcUsXhiQ/mdZw+J
OcRu1ZD45MCNmrFzGeSs6iTIf3OLr7xG8Vh0wpec4WH+h9axIfWjm9X0ldbKzFap
wFi6mQ37Qrfu1CZo9ETQ9rZR/P30jRPOEe6MEWrLLRpxQx2Rj/0jTFr5aOSWcf22
bXKMqevoVkq6e6yt7b3yxMzi8VkDLXCmj3mbZO4c0xb+KQCmjZ0e9SRwO6unmntQ
ee2rU4AkKM7wNj/1wgtgwebJzmuFknEgmWK6/u+/tJAiKr08Vsq7aWkiV1phe5L6
fk9q3eB9b3fktKo/RejxVKSrmo8f782HzuAMCP8i0vbrqNjoYENdq+duiT6lWZHa
JOPt7QwPInFXmncJ1iw1s6kons7Z7XiXkTD7UELd/v+okezdNJXclTBxuSsRK5BN
+HtPEKVxz1PdEWgYiuoLdbwYxJXbwO4Biy3slzi7xZqe1MaahulKEjZb8mE7Kls5
3QlpJhUr/pXrYIKDEJ8Awj78hIQKe06FDgcvHyQDUTXPXOZ32v8=
=5mhz
-----END PGP SIGNATURE-----
--=-=-=--
