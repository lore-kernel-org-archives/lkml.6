Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D5920643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXms9h+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeLNOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:19:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:19:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so5584652wrt.11;
        Fri, 14 Dec 2018 06:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/nS2nBCSWE3okZRVHaOusd1kkBVf5zbVjIVcJM/6Ig=;
        b=RXms9h+Jf7Dm77IL5vj1NdPaRJpLFBGyuX1syQxsu00KQtc5f0I2OHocXF1w0fUeJt
         PGhmD4E4tL58oYd+vNZxpFkNeP7S03u8iDhfHjhFOvGOuqqdyEO07bznuXcWaA4lFTGR
         Mmba/qbS+VHvxbDUeNnyVS9spPvpleFqnGTfeMsbwvtIzDSHs0qMDDq7IBKsKLk1ktW9
         FvnVm3l9QVQE61tC7nj9oPfPewL1tdL+eL7GHqs5lT0l4+8LzIeyxdxBNLKS4H/Yi3cX
         BD7b0srFcfkLUFJi88nyFBvWO7dHJI2+bThTZl4zKmfLhotGk4ka0slsxo7ULOHcsjGs
         QwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/nS2nBCSWE3okZRVHaOusd1kkBVf5zbVjIVcJM/6Ig=;
        b=l5Lv7biYtwy5ahWsTSxXsFnTPfV9js59lkiX5HSmWzx8en8MzwYwTHwOFew9zv5hG4
         Lm3a34J7zyHVa+wmoCR7hjk0HipQ5wtGBiwbioD7aDyG1/Dj3VN7mBtSssKo2i3zl2sk
         0S7hdYqiXSL/769herQjfTmfmBdI8iRhdpxosB2+ZIMLsnVUJLPbHytMKVnebFtxIYaX
         MERY8Am6uaO7jsfxPyUQghwRsjM8QwD/nrCQsnAhR7DNmCoNeZyD2uXOOXkn/6haUhQl
         IKqyFwf9sRXU3F4r4NGSfcF1C+wscb1uLXAmOciklooQlZHdcmX3yf0yita6EjhT9SEe
         i8Cw==
X-Gm-Message-State: AA+aEWYt9UluoUGRmUaygWJnh+vl4XuT3doAIK2rYSqSSyPfpzwnIvoX
        FqOKFCLEmORaTnlMjJP5HjY=
X-Google-Smtp-Source: AFSGD/Xawyg9XxS1mdqHcfunYeQDb4OqL51E9mm4/pKiHsLFuT/HOptXupaGZlwVhCJQnxYYg6AZZw==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr2955953wrq.133.1544797188016;
        Fri, 14 Dec 2018 06:19:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id i186sm5788647wmd.19.2018.12.14.06.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:19:47 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:19:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] thermal: tegra: add get_trend ops
Message-ID: <20181214141946.GE23379@ulmo>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-5-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <1544780993-20744-5-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 05:49:53PM +0800, Wei Ni wrote:
> Add support for get_trend ops that allows soctherm
> sensors to be used with the step-wise governor.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTvAIACgkQ3SOs138+
s6GvehAAj3hJ67iBueGgi+r4pzZlT18hh8Yw6bN1Q7/zyNk5tfSOzXZjcwDwSuOG
ILJKyHg9JXerfl1RDmlu08pcAUoNbP79K231Nv5PMI0fLBxqyRl6J7BfozPAjlNf
8xfT/oJV3P2F+TVeDXg7uwCDfENdiBVYi8e03ist/CZXgwLamTKF6jWwdgShMHJr
m0NAULfQecomOwqXix/fKH/o3xv8BUPzJFGaA1g82L77zIflnifWNIxIu0Wswpmf
2wHjUOkIoWmC8KwSc1gP37O5BNDpMFgvMnRWImcqohH2hgCU5T22Lp+r4LGFWzdL
+0LDoJo0IldnpDf1opoTyRE6ofFOKwOKM3G7uHd0EOfexChZZU2kde34MATMXLFE
a8L7hMNuNZsYawjQsjrd6f0bIbzhk1KRowmKI5nK30pgd0VlTrp4NIVTZ9TIsRLV
9Es20BVQj+OIHfnoaOHc9nclOcNsLRl3yx53FCa4WTUKnbbUpICkOEjnh+anHeOV
aMHBr4m1yfedEl2DCAHdFU5Ot+3DS2bSw95woiisqt1pP2hjXB5Jzh3oggvHcwz5
svuDIrrVrHqldc+qBdvHh4Rd6UnmgaUJenKCuZDvv3boO2CrV53MThqL97do6N4e
TS6xsbFPyHL2FCKSzJQiQKnHWht11VXrnt1GR/R7c6J92BAcS0E=
=mzu0
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
