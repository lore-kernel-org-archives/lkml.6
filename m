Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D990C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0CB2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icPvQcw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0CB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeLNIrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:47:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:47:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so4158820wrt.4;
        Fri, 14 Dec 2018 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OMakbEMVYE+EiRgIwxVLkR42BtjAexiTFJ9eeosKgZI=;
        b=icPvQcw8mGJIlzhxSK98+8GNDDYnerJwSpaukXQK3Imwk+Ow/b47tdK2IXMChwczmH
         xf9tqV22V5vyg+hZEfItmv2Kv9Oc2jkraC70vzojRNxodhusX3CsoSGiKZB6ZRmeoXaO
         oPds4czj78XC/4MzCanylWDjm6RYawSAvs3eJGTMTKq9kzmkDPyqPdiSyyHmF9nKjjXI
         a5HQWKjmY++ub4VcihgT6/v9pCrk4b0daitaxNi3l/bTziJYHj6ot3aO+jK0l9iDAwgD
         42FqxyEh8ng2ilrnfX7n6NkjOjUu9woJlSyebvpWqVKIm6QN7lf2Nak+MqY/iX8rNrCh
         5tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OMakbEMVYE+EiRgIwxVLkR42BtjAexiTFJ9eeosKgZI=;
        b=IcUyMXoI/C3tptVcrJ87l4V3zvmzDXIUCDw3jCVBZ0BhRay3MfiuU4Ze2T9tLQr+Mf
         lTlC9A7VWG3bfCWmv0HH8a2GoFbriHX8rfoav+1u+RilrT1RtuYAVyWjpEXBeJDtbDv9
         +vc/E0vaWWoEDGKYU/hRzfp4DoM7GXLrm1hbW+Wvy6L927rvYiGT3QuW0LBQGnQvMpbp
         UFDvyvxfx9abQzDP+0Pp3S1NMWPV71FBVftfFw6wySVNuf7KBqCYbTpEGrDTLmyIiC9D
         z5pRcX+jAdxNYV3/eEIhd8S9pi/AQSDlPS0NoCdPpXjgGcuJPAbt3oIeiCXsT3PfmCyt
         M0Dg==
X-Gm-Message-State: AA+aEWaB6UrFTL5fFk7EjZe33XvvcHeBAiK6dcVaIL3Hvshi0+vn3rmN
        4tL6vNe3L5BtXhH2MHwFtSY=
X-Google-Smtp-Source: AFSGD/VdQtB+ar+SCHrXBvddChua3lRDhU+H+Fb+D51MOV1oGDwVlddBfhLN47zQ6wDcdo0lCnSiww==
X-Received: by 2002:adf:f350:: with SMTP id e16mr1704486wrp.125.1544777221472;
        Fri, 14 Dec 2018 00:47:01 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s16sm2898767wrt.77.2018.12.14.00.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:47:00 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:46:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
Message-ID: <20181214084659.GA19965@ulmo>
References: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:25:43PM -0800, Sowjanya Komatineni wrote:
> Some of the SDMMC pads auto calibration values parsed from
> devicetree are assigned incorrectly. This patch fixes it.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTbgEACgkQ3SOs138+
s6G/Hw/9FRc0rkwbf8rQpR3O0Hqm4mr9fInom3F1We8s9MJAMFM8j+ZwcCi3fVir
tBZn2vSvdm6H0isoXDa6ZaHERGWcgcKOO+K3gyMf+iC8qQyLfjEiv6UKWfgyUe/w
2QhUN4h9XrjTaEKZzyXQE+1JHzYX/OOViA5ee8MzzK9C7L7+kcQ88q2SodLlYgxp
JK1NbV6ijIoCz3w4jHJRZ83LUbWnm4kKt5UXWCPvGjx64MFEOSK8g96AMI1pl5b1
wpBP6aLuTNgteNCg3OemFPtpKicKfeS6gCUBG5qh6IeAsbp5w3gXSlsNHBGLuBYJ
5YuCuizy40/qZz/o5mLP+ektXQk2lLjzGsrcrwfLWISUk3Kbmnv0fFbds6IaTBNn
83VbGd9xIwCqK0ItP73dw5lkEW8D+sOwIlKIBBwxCY0v1KovadAdYlYSBfjHpOGv
Gx4Emi3AbW+nuAxHPtvgtMwCEc9JN+i9Vkks1mEZ0dU56FpmglWhq5ybJg3s2bf6
9+/kSqpk8CDhA6YUfXnVfvYZAXAGb5xvbEOF1yE5iH38OJZPMPhwTlD6FNjj+cSR
q/V97yN44x7bNrdaSB9GamzUYMkEVT96aglxdgsCXVo95VlmFZfO5dUf+oA6r8LA
4dRZLri2sgILF2BFmSA4Ce1LfkfPVJpzV34FPcUDMENaK0lvmoc=
=9eTQ
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
