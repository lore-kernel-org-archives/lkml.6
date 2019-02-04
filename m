Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5C217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVnLWO0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBDIEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:04:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35573 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBDIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:04:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id r17so7367428wrp.2;
        Mon, 04 Feb 2019 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jrWpgMnwMFXU4XmY9sxO7yHYSkBdL9T1J5h2IFcD0JA=;
        b=pVnLWO0LiPZVVicptkW4LzLY5FxQ7NHiq8BTuHFHvr/Ug2HEMH1sSOF9fH3DFtCyke
         /4jkCVBfV6QpzxWSTs+YI+ftP8lKduRX4tAqN5aI6bxDpNScA/UdzFmWfbOLtxHq4Zxb
         rMxcXcRtQKe+Myi9GkCjKMQ6LBwn6kKjOqNK0u/DWgHJ75QoE0/jvWs9Way8GZuerkpP
         iAPcECoRSAsOQinuEyY2rzgtgoFL5Jc+nQ/HtBRat8RM74aQLUTwXYDdPJ0gEpY/lSdL
         Vo+AY0kkMhbNL6BcIsuXHVcwDsqXZO2+s+DB00YYnI0mBYag7IuCSBibWxQxOQuw1Xl5
         OQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jrWpgMnwMFXU4XmY9sxO7yHYSkBdL9T1J5h2IFcD0JA=;
        b=BiUW5F9gg9V3PLTV07W/dIxYC3dMcQpCd9R04xA7XHEGdwTph6AShDmJ2KugwXw6HP
         Hc2ywuduT1QixM3YCNR37lDZOWf2ZH/uEtsca5EEWkrRaQJJFv7T6ErIp2sdkjzkblHE
         7KdfQpCvOKwTPaECTIQKQbiQPZsCArTEpYw2TnSs8IG+ZFwuD7uRmfITb/aFBWjDCa5u
         eqevJ8088PoodZ4w9BsYWCBjhM8ITDAL0Mt+X0ild9HPzWKHFMf7jWRC1/2Ym4UkjMte
         bGyKUX8UwI1iYrzTP4qSKwULqgIBQqlRzUrlKQogvGLcFl3xfpG/B/+Tq5SWXrUSVCjt
         7YyA==
X-Gm-Message-State: AJcUukdhv/2f9bFJjW84GKs7PjXpdwRgnbnINg2qO29bGIVkESBjn1sF
        JAtlUEjKLX9E/YMT1CtC/Bo=
X-Google-Smtp-Source: ALg8bN7mmgzocyq1rRFrLXPxpnAAX/KVUITNGIJ+WO4bhkuiuho/W8sBOaJFdk+5SqY7rZR8CN9W+w==
X-Received: by 2002:adf:b307:: with SMTP id j7mr50450343wrd.46.1549267459882;
        Mon, 04 Feb 2019 00:04:19 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t5sm7532573wmg.43.2019.02.04.00.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 00:04:19 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:04:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
Message-ID: <20190204080418.GB19087@ulmo>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 09:07:45AM -0800, Sowjanya Komatineni wrote:
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
>  [V9] : Rebased to 5.0-rc4
> 	Removed dependency of APB DMA in Kconfig and added conditional check
> 	in I2C driver to decide on using DMA mode.
> 	Changed back the allocation of dma buffer during i2c probe.
> 	Fixed FIFO triggers depending on DMA Vs PIO.
>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLE=
TE
> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	other fixes
> 	Updated Kconfig for APB_DMA dependency
>  [V7] : Same as V6
>  [V6] : Updated for proper buffer allocation/freeing, channel release.
> 	Updated to use exact xfer size for syncing dma buffer.
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup for
> 	proper implementation of DMA.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 368 +++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 335 insertions(+), 33 deletions(-)

With Dmitry's concern addressed:

Acked-by: Thierry Reding <treding@nvidia.com>

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX8gIACgkQ3SOs138+
s6FdBRAAljL851+MhkfgLrJED3I1QmDxpTzTGRJt5DtAPY3nF4dWxHOjt1uhxmJ4
BV7Rvv/Yziq44k6vpigP5KvKUbAQKVBqXtfIEhGoosrjDP/WHoKGjeX4+Pp1JFPS
/4gxh5UE1EzJSuwT0sUEnzOgqKvpdPSMILlKniZzYJjlmEkSNp2LE7r1sAYJW3xZ
fUoi05jA6CsExJwu9Jcc57rK4aFQVoxVzxhcFmHacegYRI2w0xCRmzGiuTt69m/X
XGOwtsFyhekle50DMY/ag2pLVWmDCBNbd0QdBSAQElcocZdKo7pTCg9NJeSTIVYK
edJuMsdCG+A+A2gYfQNjF1oYdJ8+LbIMQkXLqeANi3PvlbgYWnfCEUq6wWf8y2pm
7cVIFedQjWgAQk08pR6uJH/hepCIWldsjYNGhtt1BzCABzep75OZ20qvK3p18WQ7
dCRNZOgbcQIpT1CDVCSs5AymdzF9ukMVzPVkTV8jNXPSkZ3XtqepfyfSzKXemJOl
74QWgbFNEJFFZi1F2852LmxDhEuGQFRDu3zcF7VDNY00wN7RFyxO7IlTZf8WE334
99cwCAskBZMeZ1YoMNJUe4yvhlUWP0bDRB2H6SqCIPQsVGC30OZnJmo8agOTuQ87
e5aY4u90CFWf4Tx+ekOnP6hlcncOrNt2cxZARNw1zHJ/8vXbG6Q=
=miRE
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
