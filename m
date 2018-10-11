Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4BCC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56732085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVm9H6F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56732085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeJLATo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:19:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbeJLATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so10467565wra.11;
        Thu, 11 Oct 2018 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jI7CTsUirfCf0T84RzcPmTuL3U4prbDCy+NPnuFI9ps=;
        b=HVm9H6F1zV6h0c9hlkE1OcP3swoYX85ryNN8MaqFwx+FdHXGfMCg55wyeviz4S9HvJ
         c++gUszOBh6XCy3+YSW8+g/bYGCmyyqPHlOoDj0wKCCZMUOEkLXkmv5IIq7Vp/E5FKJB
         WjM38LacIU5DULt/PP6fURuvFTtQh7NnJbFq7XyDkMcZe1P33gOBFyq51rt0dI9V1h6f
         tczATHcsdYq7mFZP+7aiQTfUFX69jEoZXocmNRn+mUpnDietY0AGNkVmeO0P50o4Ni6d
         pBDLRWnA2Q+lYq79XEpk74zF4cUlu0sp6HHWkIh/63wNtDmNvISys3wytPpedisuT/ea
         xuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jI7CTsUirfCf0T84RzcPmTuL3U4prbDCy+NPnuFI9ps=;
        b=kGDSzXvHrPGAD6/2EYodHcURklkDODX5oz+8dEEFsBW2r5xVIhEQatgvuFHvefqkFM
         8tnW9oiBTS9ig1m1czDhiHd3cwk4uKTa6kdiQnU9EXQzZg/aPYN0oFuTnBKrLjwACMpc
         tluGA134MAP8fS/0rzlqQdkD+KlBe9Z3isxqB1RRrBr6ZtZ2XQiKZuxVmtS2encPJwEf
         AdLP18eyD8ZRg+Z9BJS/VLf+NVWGcx6BXfIwaDdfhf3A9agtt96vT4PqAvGqc3LwEF1v
         E08L5J/nAY8oLUiZmXc/V31GZjb8KwJcqnW6mfAoL2nDBrl6bes0+oVpTLXYogW/Yr+O
         dEVw==
X-Gm-Message-State: ABuFfoizJ5mmr1Gh6i0rcoR1sUmXwYHOX9HpkWhJrUV1364rI2mtaU2B
        e3aROJY21xipeIE++g+oKaU=
X-Google-Smtp-Source: ACcGV6336213L9sv/0UDvsFeppCpTlHuU7g1TlVYXV6Ij1/cALY/Az2MBTKZ/peyPczwSvZmTxjsdg==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr2316182wrb.31.1539276699249;
        Thu, 11 Oct 2018 09:51:39 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id a18sm20190338wrx.55.2018.10.11.09.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:51:38 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:51:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 5/5] arm64: dts: tegra210: Add power-domains for xHCI
Message-ID: <20181011165137.GE7393@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-6-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <1538143910-24400-6-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:11:50PM +0100, Jon Hunter wrote:
> Populate the power-domain properties for the xHCI device for Tegra210.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Again, if somebody wants to pick up the series as a whole:

Acked-by: Thierry Reding <treding@nvidia.com>

Otherwise I'll pick this up when the rest have gone in.

Thierry

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/f5kACgkQ3SOs138+
s6FGrQ/8DB6xrcailVBQ2ScrstfYyLF/r+GdjnB0TzC/eYoyErsFJrUFmZgy1Pa9
QKn6yndbgroYW+DkK3Jd65iedVM3fY8F40qyWVTyR3NCLvIlwnnR7oevJgr4CzCD
NUqbCrPmgNMCnQgiH+Q443go6eapWq5Uf5xUCYq1QOfWsxJ6hWTXp3g3VZkQWN5L
vhBG1USfkVUghja2WeIJ9j4F/LdTj0RYlIEbDEy+gIOlRrD87oRUS2K1AvD+o6py
EvuTqROGf0wPXYuQYW07Q/8LybC/OHRQS5LGYk1LRim0Q+yGun2QcSI3mxWDG74H
2UTFyl2IiXKzTfpy1vYeIPcVAVMKFbP27iUUjUlUYZcDeIXx6tcTRPpKdy+liOH7
/drEasfxvxnnPeq0MwBs1VrPYwDBIPf0rR93zElx2Pjh++mR+9kj69uneo6uO4NX
pJJS58Zq9KTKLLTERV/9r0KBwESe6DCWpzRxge2v11y6iciOlhoT1rjaSm9lKQpT
PqT9HNtsfDuiWh1zmDXDm3AlRGtzODp0kymdQjf+yuxFcumHZCay0cL6vfhs2+d1
VHpMxLtk+mYvydUEKvh8D1w98Q33fY9D2DE6yIWPsBvHrdNcmVxhByiW82Q7av/H
cmkr0ozLe4PppovASA8QTd9OMEUjWJKDqL7tj3igcrGePhJJ5Hs=
=5cGk
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
