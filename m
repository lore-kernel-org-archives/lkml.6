Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C64C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A420663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n59Qo4yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfAUKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:43:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfAUKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:43:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so22674816wrx.9;
        Mon, 21 Jan 2019 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhqmqw30SFNlUyMoNlB85kG0doKZfQWelxbBtseKkAs=;
        b=n59Qo4ybLmG+zIwayrNljMdcivBletoeQWbHMfKi/iG6c0yAd4DgxoaZVmzgzY45hB
         lnfLowTLzA163D8T4NmAI9wI485d9O5ZbyJkDNK7Bj5OJ+rngJ/+fD/PpxsEhV8MebBH
         FrWwO2Axz6bIIZu89h5gjy1f0+z28ewAqNxq6mudMmfp+ja5MPEaW0p2yZLhz+Ps13tk
         tgSj0I/uqJBPcDl6l5T+eUmHmhaNrdPndJqyrNsLlWBbozqTM9tr4wPd80bBwGxJvw5J
         DYe2pB1SpdOxnbS/H777yCy0BnfDjuiHrBm3rQO1iat+ea/1U3UI2FJAu/6eSkcbriv/
         SaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhqmqw30SFNlUyMoNlB85kG0doKZfQWelxbBtseKkAs=;
        b=ef4v+qwsIi5Q9Z7U5wORhyE86iSQW9IFQ6rx34wggmlf9lv69A/bMYRi/5uVR4m/aM
         plpvSiJ3I4WlkleBjb/yYkQYGhShAuR55iy8dYIxEOtC+36UeGq3bJgy45zvRbIVvtta
         Vgu/K62ZL/9hpN0+H5hMnNy1PTmvhxYong4IfKOytBFxOp15idash2Te37jqDFv+2qyi
         p7uCyVAdC+Vm3abTzPxHFTt/zOc9RNaDzqGCDRZN2JYdg1CblxwL2wzaREN9gVUFMkkg
         yz/GaC58nTHsJx3BzjOyzTxWWacx+2eY5EE+EscMVBR2pbSoM5AmHIpRmGHXwgOSIafZ
         WsLw==
X-Gm-Message-State: AJcUukdK9FH07a8rnp+Ez16vtV5QJ4l08hBkOKElVkbkXOzPU/Bfw4Ut
        HCj9gl+POc7S0TYz3kPHXhY=
X-Google-Smtp-Source: ALg8bN74wzuhD7Iz+qYIJPWdTD3koZoodg5TMx0LJ7202PeFwdw8DqKuXpRSnok2l+eB9cXc0FGxHA==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr28304371wrx.298.1548067415069;
        Mon, 21 Jan 2019 02:43:35 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x81sm50586856wmg.17.2019.01.21.02.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:43:34 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:43:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Message-ID: <20190121104333.GD16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:03:50AM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for Tegra SDMMC.
>=20
> Tegra186 and Tegra194 supports HW Command queue only
> on SDMMC4 controller. This property is used to identify
> command queue support controller in the tegra sdhci driver.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..fb14c2c8d7ee 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
>  - nvidia,default-trim : Specify the default outbound clock trimmer
>    value.
>  - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> +- supports-cqe : The presence of this property indicates that the
> +  corresponding controller supports HW command queue feature.
> +  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
> +  controller supports HW Command Queue with eMMC device.

Hi Rob,

are you okay with the property name for this. I'm wondering if it should
have a vendor prefix or not, but I suspect that something like this may
be needed for other vendors as well, so not having a vendor prefix could
be warranted in this case.

Thierry

> =20
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> --=20
> 2.7.4
>=20

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFolUACgkQ3SOs138+
s6E7EQ//UNWSE3hytU7lm2GZMzGWL1JIUUfBHox5c+CLYu0FbjJb8hpsjBG8PM5K
61CBgHndu7TCuU/6J+HRKLCBETJEJUa6h+Xkj7zWaPeKItFTYF0b+BB4O/WL5bHb
1sXuktkVFezv2UM2m7Xy4AX4sIFzqj1eeWCi6xh2V6FkM3rofOawygqpN+DPhzuz
aLJxuZ9+qIeNtzYdJqBs2AmMHenbvjhlwcNunyuCDyqTMnYf/bt9ny/gIwQ9X7xc
UYsBKoirf7uBJDYyuDG2Bz3sk6+gr5X0Dc9NqtyUBEhZXmog4rr1oEnHQYjuqrXo
UO+DMhNzKj9PNYzLnAbQG02GkcmMFTtx05+7igbI3pRoVr9SnLlALQUUP3bwcj2/
JweBB1j75HH7g+TKJuiALOdQ46i9moTDUszSo8EByhmNUESbuZiXl7yGO6Iv/7HU
dXyRENbiBx4lHTqoeI2z6vqnmdIfg6PL5f22Ei36t6j2ZtGmFrOrbT/BfWK7DSPB
EvsTM20IGIUvUQwwAS9qPan7zeYMmVQkXcMxiMYLzTEfSMFzDMXNvrugRgndprff
8rah2BMB0PeY97bXmLFagsrG8fmlTknEdBooWnSkZrICQonXbGo8A8psd7cNMK2c
4Wmz3oNj8HEhxKOH+Rb/yp6iyAiHSPwVGIx67EDN8kAwiCowS28=
=cgdy
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
