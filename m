Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99371C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674D22186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMz8Hskn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfBFOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:53:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBFOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:53:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id z18so7126452wrh.2;
        Wed, 06 Feb 2019 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=chDfWqw+/5ZWoXvvqrPtUZx9NeyS2+puq943MyZd7Xo=;
        b=jMz8HsknGkDhG27DSgU8KEzDJhebyFqrYsgv74/bKqpln9jBfnF6tdmJPUVpxrrZGI
         OQkwG+4eSYzPfixPek0P7xn311z8hMad87K35pi00b7LBZP82vJsBUdZ2ZiygbzNjPZq
         yezssthiSdEX20ClIAS/3cg8kfQO3oR7DF++CO1DPLpO1xBHUlWuTfBRobKiggP6C7rm
         U8mDjnxQ+1klyyumS33m07WmHP15v/UiydVNNL7fZwFjCwO4yWIAZkluc/1iHPKDNWS6
         /wgvRd4XNtxFa6jmVEPrM/yaGWz2nNCAUok1Oc1KtNgSM14ERtlaZZGUGVdzccR26Pco
         7iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chDfWqw+/5ZWoXvvqrPtUZx9NeyS2+puq943MyZd7Xo=;
        b=iS/shhRcx1Om4+LITUJqzPSGc9TG/9w0ZQHrItrblF7ULXjE2ilFWpT5j7GGZaM6Wz
         mjTFLkfHLDxv4SZmyNULKE7CKvHNwyLCvye7vviLNDzG4uL3qfnteNdXNddBBCpf1eIt
         unf5QyVSErf/6enkmG0C3i+q1mK/5+Ch4t4L1tJstukVs7lMfLnPTe7o9E4ghfa31Y57
         flW5ELflJD8ThO1FqKcTFUHypef+77OGmN3MbBCgmD6XSzLKKW2g+ZSjJBvUKWc0If2D
         DSfoYmd/t/HAvoN1nk+dhNrZhhzRj1Y/ZQbe9Noo4FYWlJmmGPzz+nN+TJcMBNjjLoNn
         rLWA==
X-Gm-Message-State: AHQUAuYN0iac+fQ5yBX5bpd/dzadm0CN1EwSV3SuvcDb+1EeiNnYXB+g
        Z4Qwvr1IoC4rBtYu7nbSLGQ=
X-Google-Smtp-Source: AHgI3Ib5B/OWLJ8CrHWbMB3A/ub81GTikMXn5r9Jmpl7gPjdDJEaoQp8IZUUzO6CG6qlXWfQrSChPQ==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr8051159wrm.238.1549464825777;
        Wed, 06 Feb 2019 06:53:45 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q21sm10147456wmc.14.2019.02.06.06.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:53:45 -0800 (PST)
Date:   Wed, 6 Feb 2019 15:53:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
Message-ID: <20190206145343.GA3651@ulmo>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:26:25PM +0300, Dmitry Osipenko wrote:
[...]
> Oh, another important moment is that physically contiguous dma_buf
> allocation isn't guaranteed by the DMA API. This may become a problem
> for T186+ that can transfer up to 64K. We need to enforce the
> contiguous-allocation requirement by using
> dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) instead of the
> dma_alloc_coherent(), please see my other comment below.

Actually I don't think that's necessary here. DMA_ATTR_FORCE_CONTIGUOUS
only seems relevant if you've got an IOMMU attached to the device to
make sure the physical memory is also contiguous.

See this extract from Documentation/DMA-attributes.txt:

| DMA_ATTR_FORCE_CONTIGUOUS
| -------------------------
|=20
| By default DMA-mapping subsystem is allowed to assemble the buffer
| allocated by dma_alloc_attrs() function from individual pages if it can
| be mapped as contiguous chunk into device dma address space. By
| specifying this attribute the allocated buffer is forced to be contiguous
| also in physical memory.

We don't have an IOMMU attached to I2C or APBDMA, so this can't happen
and even if we had an IOMMU attached, all we care about is the device's
DMA address space, which means IOVA space, and that would still be
guaranteed to be contiguous, according to the above.

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa9PQACgkQ3SOs138+
s6GXdxAAjiGTq2n2wDf3exYGm44xiRYZamLgBXNrBSkvWArfYxh03oyDAdvc1Jz4
dNfY7pS4anqMXJ8EN6klhOkKDCZVt1mYqa2HHMOf/RMkJIgg/wC/4EfkJOKA8NdK
L0YukWOj+6yR3EYU5wcTrH3K2wdfIr7OxSyecEuJPmcvMyCPQNW3M6gts9rXxCTn
WRBHrFWECGBrcv0D6cUKq5iNVIYPiY0GgTyvL0IB7/xY1UUyn59cO6wIegDThSog
W29/uu/Lumc4UOrRJFq5VqRJGn+n4XNqFJ/5M4YMTRyThtzpWXui9zcmWroRh6be
V1lMJMhfXSs66/fM73LXWtELGxJQgl/8Q65/23Wkmy0OnvnNo2UrLG18fip7QTLL
5agQz+iHYqDzQaRO0Dlh6gMHOBLtA4gqJ7lVYYKfbK4kylVNqXBFjjC45NRnxZTp
1VWRD1MpHe9oVDj7YrJuMkrCC9AK8zrK/uKerfhvOugTOjsQwyg6RotSsAsSqbuv
KKLl3gSs8ZqrACXRRzhdQk9sGdznglid5+Qu+YPVqkDt1czXIbXOfphSWq8OHsZH
NbwBAvx2l4tsFnNNkS5OiPhH8PEA9PIw+W3G1Lvti9K/JYyCGl6Ha3xeTkN0D4hM
ceUyM3h+LljcfqMiXYW4gGvx4WPe4CmkHJBL4I5zD35ZcNJKI0A=
=OHcp
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
