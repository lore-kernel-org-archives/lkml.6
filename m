Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F92AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4500F21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyLztQj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGLB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:01:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54168 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:01:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so5636286wmb.3;
        Thu, 07 Feb 2019 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzQ23UDeK7PHEVRyyARuGg+OdrxkLivi2VV7NzIABrQ=;
        b=JyLztQj5YqQrisLqhEJ3J/WitUl5U81LWFJILnIOGBbvvV+1se58Ln44NbS16ViHa6
         4Gdz9CgmeviBxCkxsDMb3PVlJNWZPcyS0anG4QojADJY5+rjNWmM27hHkmv4dwYRCAje
         Iez/91P1kuiVwI4wmr1C1ihf81I+OgaNfq8uQNtrdMCqcP3qi8LjZ0+Smcy+fsH7bRuu
         IgQDDveN89M9ZCzLKSzhPtlvuKLGYBaUe4uwXUqpnT5aVGsOAK1uBmMbhwCqi7Zsc8Ir
         2bmv2YtFNOaf92bLQ4JQXxxlwrA7cVgEUpYkuYkDDLO89uluCVF+2Av06vwQKe+/l7uQ
         Ct8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzQ23UDeK7PHEVRyyARuGg+OdrxkLivi2VV7NzIABrQ=;
        b=JwV6qRs1K+AIIb2upBL3TDF53i91Tq02jAYOYwDouBo0lVb9kgZ2sP7YaJbOc1aNa4
         GMtMPVot7UuKBUm1wH/K/843T5YsAiunHWhGPt7DSc/YoRvgKl2WVs8uW33ff2naHn5n
         Yhed9WQwOPlqD2wUpQ4/Kxtf/rYhqT7iYvjHLXBS0rVbIEGMYIGFGlRp6ei5J2P7fINo
         9wBpSmbeFGRT162H90aG60FqSd9fx8FGBTfBQzO6tT5+e63Ma7L7vvtwQc5cOXergQeX
         HisB5uHJ+6C/K92ULQ3I31qHvYBeY36YMekeYlQUHbOpXhftTDa83h7jF+7o8ejJt3OB
         ADUQ==
X-Gm-Message-State: AHQUAuY7Iq9s9+ICDdtOqukTMg5g5LpitJEWclg4iV1dZ2KCAu21dB6s
        Z5ZL8D5mFfU+A6C0mzrLkg82Oz60+0s=
X-Google-Smtp-Source: AHgI3IZki8S5bYoKMQMQkYs92gfdqp7PeWyidqx9B6TSXQQsOW8BGAuPT2connvIwOv44QC5hrk7Jw==
X-Received: by 2002:a7b:c854:: with SMTP id c20mr7408732wml.153.1549537315294;
        Thu, 07 Feb 2019 03:01:55 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b14sm31954088wrx.36.2019.02.07.03.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:01:54 -0800 (PST)
Date:   Thu, 7 Feb 2019 12:01:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
Message-ID: <20190207110153.GA18518@ulmo>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:16:07AM -0800, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.
>=20
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
>=20
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
>=20
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V14] : Switched back to use dma_alloc_coherent as it guarentees contigu=
ous device
> 	 dma address space.
> 	 Fixed FIFO Trigger level programming to construct value from scratch.
> 	 Previous versions does register read-modify-write without masking.
> 	 T20 has DVC offsets different to I2C. This version has fix to account D=
VC
> 	 offset during dma slave configuration.
>  [V13] : T20 has DVC used for some power controls. This version has fix f=
or using
> 	 proper DVC register offsets for DMA programming incase when used in DMA
> 	 mode.
>  [V12] : Replaced dma_alloc_coherent with dma_alloc_attrs to force the al=
located
> 	 buffer to be contiguous also in physical memory as Tegra194 supports max
> 	 64K and dma_alloc_coherent doesnt guarentee contiguous memory.
> 	 Changed return code from EIO to EINVAL incase of failure to obtain dma
> 	 descriptor.
> 	 Fixed coding style check issues.	=20
>  [V11] : Replaced deprecated dmaengine_terminate_all with dmaengine_termi=
ne_async
> 	 from non-atomic context and dmaengine_terminate_sync from atomic contex=
t.
> 	 Fixed to program fifo trigger levels properly when transfer falls back =
to
> 	 pio mode in case of dma slave configuration failure and other minor fix=
es.
>  [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 designs.
> 	 Added apbdma hw support flag to now allow Tegra186 and later use
> 	 APBDMA driver.
> 	 Added explicit flow control enable for DMA slave config and error handl=
ing.
> 	 Moved releasing DMA resources to seperate function to reuse in
> 	 multiple places.
> 	 Updated to register tegra_i2c_driver from module level rather than subs=
ys
> 	 level.
> 	 Other minor feedback
>  [V9] :  Rebased to 5.0-rc4
> 	 Removed dependency of APB DMA in Kconfig and added conditional check
>  	 in I2C driver to decide on using DMA mode.
> 	 Changed back the allocation of dma buffer during i2c probe.
> 	 Fixed FIFO triggers depending on DMA Vs PIO.
>  [V8] :  Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPL=
ETE
> 	 interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	 other fixes
> 	 Updated Kconfig for APB_DMA dependency
>  [V7] :  Same as V6
>  [V6] :  Updated for proper buffer allocation/freeing, channel release.
> 	 Updated to use exact xfer size for syncing dma buffer.
>  [V5] :  Same as V4
>  [V4] :  Updated to allocate DMA buffer only when DMA mode.
> 	 Updated to fall back to PIO mode when DMA channel request or
> 	 buffer allocation fails.
>  [V3] :  Updated without additional buffer allocation.
>  [V2] :  Updated based on V1 review feedback along with code cleanup for
> 	 proper implementation of DMA.
>=20
>=20
>  drivers/i2c/busses/i2c-tegra.c | 411 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 367 insertions(+), 44 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcEBwACgkQ3SOs138+
s6EU7w/8CEwyqm8AGe4LvzCTVthcN5L8+7m/yo1ffdW45DOXxVqTNA6j+8raC2Fw
3u/egfWhOBpIuBSFTcUK+7rn5pSGxvWNG07BCJEYNr/dbYt8TZpZnZlop90opQoU
AJh4Cj9Wo3u8//fdJScjkMJFdfkZkjXdvN4/7U4wwvLl4pDUDjwLhj9Zqdui2teO
iIaW8CZ58SCfQOb04JLOLuh6s/2GPfsC89sRk9108WvYzRkolonRsFIc7fOARh9X
x5COVGvfNoI2hNSYarqfbbEO/H1jVAG26s1i9DwAt7GGSHMNJ14NY46zptxZMaWV
BZzjr3DGNBemUDKPFHGCrFYdjSW+QpXTYEfUoWY4bJuNU9/xNyok+DHnSKH62QtG
HFlgUTqVW0wF7acPePyz4XyRHiBgjWIVtSMHe9Ju2V56A91ETcucAYGAzXaqHezs
I6S8fNLLaFyPJlQsAs8UcizjW/lTzbS4UUDMAhS5MwcihxOuWvvDF9/G44BTJRwv
h01EjrRxeyTjBk0IsCS/b6aOR6GX3esTrMLmyVnqroCacwwEaR48xkcrqMlMRS1z
Kzk4Knq5kMl6ItvPfv/Dj8B6oQjRPMmjq0fJcwkDIR/Du0wsNjWMe+deQvujoPZF
CDF4O/Ke5lHxPGUawKOBgwUX5oyTmsSYXbs7QXC5B04/Z9vjZgk=
=gaQ3
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
