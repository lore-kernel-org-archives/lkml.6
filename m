Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB4FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197A620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1Qwziqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfBEQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:21:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34070 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBEQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:21:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so19792wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bw1zg/KZ3YP70YS6h/TCefy8QR5iQXHDKxLF5HOAAp8=;
        b=o1QwziqaesCh5P9lRa8AhhcdeeVJUdEPZ/RcX7ox/OQAK2UnPq+BabcelXdHLeCt00
         xSAgHmdYvvRh2wKJ2EssV4d39aZhm0vdYe2SFn+MNLESAY2XIHgMhmkcD7Yxm61xewuX
         Y5H6tE/7fXbhaDWfK1pypkKgo86JUqO4jOlWPQaL64sQPVarIXMWaFIJZUaNTjLt7V7b
         pxdvjGD8VizgRH1DlynsZ+xQqNlH/rLKVPF9xX4E1C4x0sLOQMRi9zF9wvvI9hKYZNuO
         SqUwfz1vY0ipMaCRH7jurhSUtpyZJTWlF18Z+MmaU5dm3qUrG7E6kJiS/Mbhjrsm8Qtb
         f9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bw1zg/KZ3YP70YS6h/TCefy8QR5iQXHDKxLF5HOAAp8=;
        b=oZm3cHG8fO3ZblckpXiEW3gg+AMrWZJ1tIHveAUuNRbAKxcWnahWyDA/kg3yi3/mrx
         2eyHWXI1AuHFe+DJVSaI7gSJA9WdwSEghw48+mHWGe9RCA0+Ymk0awxBfLDGLjhNx3BG
         SdxbPw7qvN5pW0+tlLJnmSkjD3jM+k9h6OVpIcSVO+yWel3u0yZL3CRAsxf16su3yVZQ
         P/7ZoPaMa5YdwMRxJGsE/xZ3ouKD8P2wo2xJUFpMf8e01GxZUNzJQixVNObkU0pEKBcn
         8kAR4IJ2nxsG3llg+eiQZ7aCr+Ru4v2BfDoHF7WS6lu1GWjxvhQDvPNwbviPFsMDllNv
         mpiA==
X-Gm-Message-State: AHQUAuaosA6pi9vyWCdkF/MePwUix6SiiWomHihosGkc9oRBRjRegMwJ
        PbdbHo43hZ/BijP/UaT83ExD1RDuixs=
X-Google-Smtp-Source: AHgI3IYWk+LsQoXifYWXRu5NvxIr6JTR3TUKvbSQ8M6jQyuzcHjVyySp35TfISrUvFaTek9+MDsOSw==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr4249657wmg.78.1549383659342;
        Tue, 05 Feb 2019 08:20:59 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v22sm4467761wml.37.2019.02.05.08.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:20:58 -0800 (PST)
Date:   Tue, 5 Feb 2019 17:20:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Message-ID: <20190205162057.GA29974@ulmo>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190205161036.GA782@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:10:36PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 12:06:02PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Drivers that are built as modules may want to use these functions, so
> > make them available like the rest of the functions.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> How do they want to use these functions?  The proper way is to
> call dma_alloc_coherent / dma_alloc_free and let the DMA API
> handle the rest.

This is again for the host1x driver and Tegra DRM where we had a similar
situation a little while ago where we needed to explicitly detach from a
DMA/IOMMU mapping.

I ran into a similar situation on Tegra186 (which has an ARM SMMU). The
host1x driver needs to allocate memory for a push buffer that commands
are written to. This push buffer is mapped translated through the SMMU
using direct IOMMU API usage. We use the same domain to also map command
buffers that userspace can pass in.

The problem is that if I use dma_alloc_coherent(), then the memory will
already be mapped via the SMMU at that point and then the driver, not
knowing that memory has already been mapped, will attempt to map an IOVA
which will cause an SMMU fault when the host1x tries to access the
memory.

I didn't find an equivalent to arm_iommu_detach_device() for non-ARM,
but then stumbled across this and thought it was rather convenient for
these cases. If there's a better way to deal with this situation, I'd be
happy to do so.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxZt+YACgkQ3SOs138+
s6FSlxAAlC10Qh1f+7ePw23JTUxc7z8UWOPkt36ZuuJ0PMKin0QFFGx/x5atfSH9
N1c0nzH6bTi5RcdQ7qjkFkJrYnXfHnZaBmQqp2agsNI2F0X431Be3byeAxD+Pr9M
v8vVImN5LV2NUXtrgJaDhOdFg/yBOV7HoNWoiFA7GBxaKjVquQrZ1AxbWfvgEw/G
piPrkNh2oWl0dwK2PIvXD7BUTR9i4u+a2lOqozdfo8rOoIGfsOsSnkI9biDFi7zH
J5F8x1Q1KbK/VqT73dzPPOLa9w5WR9NddPaqc/BtFQGNevpNbnF0UM6oIsYWAysn
RU1Dj8XLApzINvFGP+lYY7HOW+fai6ckvkIXwPDUYxsgcnFts9cjrnqYEqZJceo7
N0cuiExgaqgRREJrvQ3kv2u9+dCKgQulqpNa7G9++T+6w0dhP76Eur5akH8UMYxd
BQSJEl5G/T0E3KZ2Hq/Jn47/A4iTb/QaP7mM8ewM60NT493Md4gMR27hvbezbeIl
neaH+eTcbvyjxe4lbf+0TBqWK0FzkZh4tUwurZ/NPOMVD0z+KgJo2ZFsxh84pr2f
mbmrC3zSNSA4Ls7EFaX4oOwUfsS/WVRaTz9w4eNo4V7i7hXKYhWbPJvrVIaCmK8c
o//eHmWRyMN2XTpJx/rzJ918TEr6eeZo9XZGymFj04Al+R8LvV8=
=72tt
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
