Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6659DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235C620869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F96rOdYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfAaWZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:25:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38716 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAaWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:25:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so4234415wml.3;
        Thu, 31 Jan 2019 14:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxRVzwmr43MFYtitLEnUc5MTY10C4drP5BE48d+eRmo=;
        b=F96rOdYoEnKLkn70Uc6m1OpSQ+hBdAv66nWXqdoGPSQO9Q2EUrb80y1UYzIVlN3eVs
         +aNxFVBzy1/w90lHFQHhGW/tsLf+XpWKyIBECI8z9GMIQG/PrL7MHlyHDAELXly08ALZ
         CKV2gBH6R3y6+4SuBz7bKlNfNFoqtBdvf2fbPRrYFKS1kwfa1R7CC+RF9UX4m0+mJcMk
         CaDP7+pGzpnmqi3qo5e/yjUaSManX2ikiNiaBCt1DjOlQuHjvn4uSL7Iyq10ooE7FxBb
         fWwDdgc363gDBFee9x87gcd0+ar+TIIqXSQiEOIj6an2SeQluNUPrG0xxum2f3kuMh4Q
         3tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxRVzwmr43MFYtitLEnUc5MTY10C4drP5BE48d+eRmo=;
        b=ffDkXAuQA0IENyUz67/nwNNMuWAdE89dUJB8LAFPYOO84F6CuP7mt7UWk+CbzOxAtV
         QzmyA0fZSqwKVV9KklkpYQB+lwyy/vPBlne9RsZdFPcFVQRc1NSq/Uc/2s22CQFfILZz
         OzPMNWI4xxsCtD57MmQaJht/Y/kL1O6BiM/nWGgCcnQxIqGFS92KYt4FwYzy0wm41pY6
         qyLMGihHLRvZWHaaAms901Ude/k2wtFdeW1U3wgwUNG2pQtA2BRWTabI9m9XZvWJyDop
         1R144gKHuWY+1IsTEdfwiPKiwMfUNnEq965ZrefiD0wTyjedG7zWhTS246hCG5ziElUT
         yf5g==
X-Gm-Message-State: AJcUukfFMogTXQl/0F7/fIDr+xtXEu/tzzEtCdaoev8trmzxl55lJcgc
        +oDOvUzHwaBUpJs1IRTwTVU=
X-Google-Smtp-Source: ALg8bN7lj5rwqOuFcu6r7j7j6Fd8nCDnyflk4OEQOpY0EH+YLRHh03KoV3GHISoKXHbJFCWCRafWew==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr31791846wmd.51.1548973520843;
        Thu, 31 Jan 2019 14:25:20 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id m4sm401746wml.2.2019.01.31.14.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 14:25:20 -0800 (PST)
Date:   Thu, 31 Jan 2019 23:25:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bo Yan <byan@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: add topology data for Tegra194 cpu
Message-ID: <20190131222517.GB13156@mithrandir>
References: <1548959754-3941-1-git-send-email-byan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <1548959754-3941-1-git-send-email-byan@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 10:35:54AM -0800, Bo Yan wrote:
> The xavier CPU architecture includes 8 CPU cores organized in
> 4 clusters. Add cpu-map data for topology initialization, add
> cache data for cache node creation in sysfs.
>=20
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 148 +++++++++++++++++++++++++=
++++--
>  1 file changed, 140 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 6dfa1ca..7c2a1fb 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -870,63 +870,195 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&cl0_0>;
> +				};
> +
> +				core1 {
> +					cpu =3D <&cl0_1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&cl1_0>;
> +				};
> +
> +				core1 {
> +					cpu =3D <&cl1_1>;
> +				};
> +			};
> +
> +			cluster2 {
> +				core0 {
> +					cpu =3D <&cl2_0>;
> +				};
> +
> +				core1 {
> +					cpu =3D <&cl2_1>;
> +				};
> +			};
> +
> +			cluster3 {
> +				core0 {
> +					cpu =3D <&cl3_0>;
> +				};
> +
> +				core1 {
> +					cpu =3D <&cl3_1>;
> +				};
> +			};
> +		};
> +
> +		cl0_0: cpu@0 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x10000>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;

These don't seem to be well-defined. They are mentioned in a very weird
locations (Documentation/devicetree/booting-without-of.txt) but there
seem to be examples and other device tree files that use them so maybe
those are all valid. It might be worth mentioning these in other places
where people can more easily find them.

According to the above document, {i,d}-cache-line-size are deprecated in
favour of {i,d}-cache-block-size.

I also don't see any mention of {i,d}-cache_sets in the device tree
bindings, though riscv/cpus.txt mentions {i,d}-cache-sets (note the
hyphen instead of underscore) in the examples. arm/l2c2x0.txt and
arm/uniphier/cache-unifier.txt describe cache-sets, though that's
slightly different.

Might make sense to document all these in more standard places. Maybe
adding them to arm/cpus.txt. For consistency with other properties, I
think there should be called {i,d}-cache-sets like for RISC-V.

> +			l2-cache =3D <&l2_0>;

This seems to be called next-level-cache everywhere else, though it's
only formally described in arm/uniphier/cache-uniphier.txt. So might
also make sense to add this to arm/cpus.txt.

>  		};
> =20
> -		cpu@1 {
> +		cl0_1: cpu@1 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x10001>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_0>;
>  		};
> =20
> -		cpu@2 {
> +		cl1_0: cpu@2 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x100>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_1>;
>  		};
> =20
> -		cpu@3 {
> +		cl1_1: cpu@3 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x101>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_1>;
>  		};
> =20
> -		cpu@4 {
> +		cl2_0: cpu@4 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x200>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_2>;
>  		};
> =20
> -		cpu@5 {
> +		cl2_1: cpu@5 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x201>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_2>;
>  		};
> =20
> -		cpu@6 {
> +		cl3_0: cpu@6 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x10300>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_3>;
>  		};
> =20
> -		cpu@7 {
> +		cl3_1: cpu@7 {
>  			compatible =3D "nvidia,tegra194-carmel", "arm,armv8";
>  			device_type =3D "cpu";
>  			reg =3D <0x10301>;
>  			enable-method =3D "psci";
> +			i-cache-size =3D <131072>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			d-cache-line-size =3D <64>;
> +			d-cache_sets =3D <256>;
> +			l2-cache =3D <&l2_3>;
>  		};
>  	};
> =20
> +	l2_0: l2-cache0 {
> +		cache-size =3D <2097152>;
> +		cache-line-size =3D <64>;
> +		cache-sets =3D <2048>;
> +		next-level-cache =3D <&l3>;
> +	};

Does this need a compatible string? Also, are there controllers behind
these caches? I'm just wondering if these also need reg properties and
unit-addresses.

arm/l2c2x0.txt and arm/uniphier/cache-uniphier.txt describe an
additional property that you don't specify here: cache-level. This
sounds useful to have so that we don't have to guess the cache level
=66rom the name, which may or may not work depending on what people name
the nodes.

Also, similar to the L1 cache, cache-block-size is preferred over
cache-line-size.

> +	l3: l3-cache {
> +		cache-size =3D <4194304>;
> +		cache-line-size =3D <64>;
> +		cache-sets =3D <4096>;
> +	};

The same comments apply as for the L2 caches.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTdcYACgkQ3SOs138+
s6FzABAAjbztv50UkzwKg4xpgqcu8AkBW++ovcczpqHF6n78vgNJIy3INrdJEj4p
fU7XAWA2WvkrCuQj8yXW/2cGli8Ud8HV8+oHxLDLDCAn4mooQHZPE2oRA14aT8Mw
JU2XIjfrjF292vaKAahohJuvJMQOl1JIXc247qHd90QLvUeT8lJKlL8NSX/KPxpL
Gs5WhFEAlcrIo7Yk1X4kpjG6CmtXC1NxVXBbYiP5XkWjezfOKovQUlvFxlgnNP/z
leQq6s0VqzGtVm5LUan6GR1iK/ACtbkbAvpZUCa4Wqh1Rf1Mhckrz1cf6oxB2fic
iqBwbJAzi5v5JCjAN39zcKxujpUL/g/Q5gP3Rtpv7Mt3wKG1xl1qdMy18T+oH1Cf
AS+LSXFANk8+q53PdmLajlt/0mk6P3mEYWNw/s0QNix4xfy1Q2Mp65UDW++TrpXZ
JewQAJ91sri0rukZlKq64cOj6lmyq06EwuqwvFcgXNCpvFdq2jmBTGXOXrEO3Usc
t/MVmkGrIJPxMsaroaQ8xViXdejcOIauv8royGZq9aluZN4LcKAuFrwkKoKSBWYg
9gPjscvhSAB9PHv2Uk33xWIHWgIOxEV6OiTlfaZGu0R2asTn7nnqfv3iYA+OSdaG
bHhGZTSbjeaoBM5h8OzDsZyASXsAwo2r1RUvcHe0jBmPh1AI31U=
=8xhE
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
