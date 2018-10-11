Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7D2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY4FKYqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D7D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeJLAR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:17:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbeJLAR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:17:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so16185399wmd.0;
        Thu, 11 Oct 2018 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MzwDrqfrZz6JA5QLj2fqXA3UQrVajFeoF/BgHo9/Zg=;
        b=AY4FKYqhKQqVq/XzrwXS7Win/l78R5upDfdWyDiOI5k/qfImlsm89fFZnLrY2oDjuT
         hclLvGKdnPOQNTw4rU31Ro8wx/p1Mx3OXl35aXVntCiBJOjIZMB34CFYgVPQLJmK5gwq
         hyNC5n1TY0ZzG0jKxo31Efnjeb8YY+DbL7TFV8X8DKCtiSFFpIjy25oZlHltJaoFski1
         5GH6EPhzFDfaKs9Tupoy8ZJKKBd9FqtHdVYWbgg+N9pres0LC3F1AhFxSm9L1b8U7G8k
         2X4qD0NXJ2ApLNZjUGg2xB715HH8mHjA9+sLzE91qmGVvg1t1HUcv7rd0Lw0bH4bXDoT
         QT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MzwDrqfrZz6JA5QLj2fqXA3UQrVajFeoF/BgHo9/Zg=;
        b=LTrOj64CKCN9Xfagaq7XZIccVf59xH5C0VIvGnvgrJuyuetyryK8AEl937q/A36pME
         gTaXgYrDb3cyuQk2UR8ACiWVefCoT7JsgQO9W0W1yMfEC+ivzqrc+gNmyRYRiEo80pdB
         2jry0Y97Jvq399Uuwx+H22JTF5OsG0UbT4+eHjldjdkitIwFE/0CzxcquXy4yRMayO0+
         /cuDRHlVARIOWPeN1Yj1j0yzEXaDszW7WZIybiBsn4A6y0XrVxzBYvmVfmd2PEWjgmH9
         lUIGJyU4oj39Ge/hTX0IQpKSFsfbWNGz+8ovoIx+HiqNHjjyWBxW/fAGxB+pyFBk0T+c
         sG+Q==
X-Gm-Message-State: ABuFfoiZaF/r19kclczt96zhEc8H3AxT231gjjfrcOY6UDv3WBJKrS8W
        +AaYdBHDoULcU8E1p5PDiLk=
X-Google-Smtp-Source: ACcGV63DR+8s95LvO5ZGaMVXPQrdQfI00HWJAV02/nhp/qiS4AhLL17+kBL02JDa+vWCxNkwQmeUzQ==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr2367978wmd.90.1539276594038;
        Thu, 11 Oct 2018 09:49:54 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id c184-v6sm16346774wma.15.2018.10.11.09.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:49:53 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:49:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/5] dt-bindings: usb: xhci-tegra: Add power-domain
 details
Message-ID: <20181011164952.GC7393@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:11:46PM +0100, Jon Hunter wrote:
> Add details for power-domains to the Tegra xHCI bindings so that
> generic power-domains can be used for inconjunction with the xHCI
> driver.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt | 8 +++++=
+++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.t=
xt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> index 3eee9e505400..4156c3e181c5 100644
> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> @@ -59,6 +59,14 @@ For Tegra210:
>  - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1=
=2E05 V.
>  - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
>  - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8=
 V.
> +- power-domains: A list of PM domain specifiers that reference each powe=
r-domain
> +  used by the xHCI controller. This list must comprise of a specifier fo=
r the
> +  XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
> +  ../arm/tegra/nvidia,tegra20-pmc.txt for details.
> +- power-domain-names: A list of names that represent each of the specifi=
ers in
> +  the 'power-domains' property. Must include 'xusb_ss' and 'xusb_host' w=
hich

Total bike-shed comment: maybe call these "superspeed" and "host" or
something. The xusb_ prefix is kind of redundent because of the context.
On the other hand, those are the names by which the power partitions are
referred to, so either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/fzAACgkQ3SOs138+
s6E1Kg//WXm9D1vGvegOneAlxvdtj2qjj88BeB3Jlvl46mxINwhmlrWB52aZJMwz
WUekuHgpyEVBoINMlAxFqYCPurWMnFClFLkj/VeiE8qLqRSjnNmIbTNQoTahXzAm
sFsxLUX7RnEYCJAbAiY+8QjTqs3sPCObl5RAn/5/hJWgQIAtAtAcIo5OOG1TsZze
PJxRxAoLgB6RkJG1FvXEO6RhR63waxFd8OtIr6c4lqsix/v8f6UJohAyL0fCdQ7y
PJy3z9DYRLtf65njFH4mwH9VTrWBV7dtnFgpShjTkfeIk4tYb1z1KBxm+sAoNqTI
wHcWmUAZglrbCErqBH4lYSESLv9Xy46ArDbNtq4QnFRRMkZJGmyr/qux+cuUA9pX
KPTRMJRCzqJCoMFfm2MHcliB98mkII3naJj6TYdO+G0df3USMqjGsFPYiV83ry+5
WObcRjdgAAlUhl8w0gW9NAETuuzWIdkZ7uBkY7R8Emv/OQuWTXsud0zdDXsbubeQ
R6I+QGawaJrYxnFz/7EXT2EAn9uFj/YCiUwbRLJ70ePftEWorKHTP0Fbl52NJHEV
f2qKYLJ+BUW4vhkd+H/S4NQQ0t0VVrbgOFQyWGggSFkO3t3O7aOloiSF103i3mdZ
nu6X0RvONuK6nPo3QTvxw0mZa5imA914oTQ1n0j9p+HRA/a4O8E=
=TH2z
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
