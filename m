Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411D120836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpiz3aAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfBRQEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:04:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45965 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbfBRQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:04:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so29003689ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m+lidQw3+CwGVLVVkUFOmOJusJPLo4FhCDb4zUr+4K4=;
        b=fpiz3aAW8nHDHMJAu6WHVdxOgqunzkE7bf9gkunuHa/BM8tRNKxQRowZ99w5PB4NKV
         cgMi/jSVuK8sdW5HeZdt86IbMsatEX7xf7nag1YsBdiPZggJZk8FiAecR0D2IzVqkWA7
         nSD9Cxy3RDKFd6TPaMM3P033/H5uq5AIXcyGqvLZnzo2rdgg6q7d/MXfZRMUZvmWMnvv
         jyoWcOIgUPyB1XwonfgLFVlQgaUKqZEFGoGtal1nZpksshKqfEKuGgrnT6OB6wHzyCXM
         9gD4TGbDpMbSrUphCG/J5zoAbRYx1SZgVYFQLcw20mP7zklJ7DxRBQw1GkjswOXBsCrI
         eCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m+lidQw3+CwGVLVVkUFOmOJusJPLo4FhCDb4zUr+4K4=;
        b=Xe23ZMnyEwp/iyRtjpBZQHFux+pFR1rs6Kq2vJT9NTYEeGI+nKK/noZFhe4gAoiNdo
         5HPS9dZXVGEwPRfIeXMDsSiPBpSnLbuWPZE/8Jxs68/4SfxLxXMhTOZfNUTCdk2qH6CH
         PW2f3eBlF2aACQFITCnWPqZuWw3tJoEtJz5VkG3v9ks9qx14PfiTCZI2pSt+gc8n0tOQ
         orvptE1rqFBaijlq+BaTnJZxhRGWt0sewNNo2j1pJWJipR+lGmJjfGWCHJoLIutRnF2M
         CcpxWZg0c7X555v0+xqWEFcfEh9gmE5U2xPKmeMjDe3Tkv3EpUUBeYLm+7zWfnLzQRGL
         njKA==
X-Gm-Message-State: AHQUAuaIVDXtSVe78SpJokInsEPyEGQrMItAem5MLzbJ+uCIfl8qoIW/
        jGaRRBScVTt+Vh1luhSMFofUS4efah25CF1G8bQnYg==
X-Google-Smtp-Source: AHgI3Ibe3FvpE2nMhR/pmTjFU7Ghac0QgtFhBCfHVPTEU9Oe8rO/Tq2OD8kLthLdSyCea0wWkivfU/rQy10PK3qO0f8=
X-Received: by 2002:aca:d509:: with SMTP id m9mr13940235oig.64.1550505853166;
 Mon, 18 Feb 2019 08:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20190128142313.17036-1-benjamin.gaignard@st.com> <20190128142313.17036-2-benjamin.gaignard@st.com>
In-Reply-To: <20190128142313.17036-2-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 18 Feb 2019 17:04:02 +0100
Message-ID: <CA+M3ks4S3y9=VvAu1Vah9crd-g_Ri3T4szS-FkwiNP6rfXqO1g@mail.gmail.com>
Subject: Re: [RFC v2 1/7] devicetree: bindings: Document domains controller bindings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        s.hauer@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 28 janv. 2019 =C3=A0 15:23, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Document commons domains controller bindings for controller
> and client devices.

Gentle ping to get comments on those bindings,

Thanks,
Benjamin
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - complete rework of bindings description to try to give a better definit=
ion
>   of what bus domains could be.
>  .../bindings/bus/domains/domainsctrl.txt           | 55 ++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/domains/domains=
ctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/bus/domains/domainsctrl.tx=
t b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
> new file mode 100644
> index 000000000000..a3fced91842d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
> @@ -0,0 +1,55 @@
> +Common Domains Controller bindings properties
> +
> +Bus domains controllers allow to divided system on chip into multiple do=
mains
> +that can be used to select by who hardware blocks could be accessed.
> +A domain could be a cluster of CPUs (or coprocessors), a range of addres=
ses or
> +a group of hardware blocks.
> +
> +This device tree bindings can be used to bind bus domain consumer device=
s with
> +their bus domains provided by bus domains controllers. A bus domain prov=
ider
> +can be represented by any node in the device tree and can provide one or=
 more
> +bus domains. A consumer node can refer to the provider by a phandle and =
a set
> +of phandle arguments of length specified by the #domainctrl-cells proper=
ty in
> +the bus domain provider node.
> +
> +=3D=3DBus domain provider=3D=3D
> +
> +Required properties:
> +- #domainctrl-cells    : Number of cells in a bus domain specifier;
> +                         Can be any value as specified by device tree bi=
nding
> +                         documentation of a particular provider.
> +
> +=3D=3DBus domain consumer=3D=3D
> +
> +Required properties:
> +- domainsctrl-X                : A list of bus domain specifiers, as def=
ined by
> +                         bindings of the bus domain controller that is t=
he
> +                         bus domain provider.
> +
> +Optional properties:
> +- domainsctrl-names    : A list of bus domain name string sorted in the =
same
> +                         order as the domainsctrl-X proprerties. Consume=
r
> +                         drivers will use domainsctrl-names to match bus
> +                         domains with bus domains specifiers.
> +                         Note that "default" and "unbind" are reserved n=
ames
> +                         used by the framework.
> +
> +Example of usage with:
> +- a domains controller with a 2 parameters cell
> +- a domains controller with a 3 parameters cell
> +- a client device node using the both controllers and 2 configurations
> +  named "default" and "unbind"
> +
> +ctrl0: ctrl@0 {
> +       #domainctrl-cells =3D <2>;
> +};
> +
> +ctrl1: ctrl@1 {
> +       #domainctrl-cells =3D <3>;
> +};
> +
> +foo@0 {
> +       domains-names =3D "default", "unbind";
> +       domainctrl-0 =3D <&ctrl0 1 2>, <&ctrl1 3 4 5>;
> +       domainctrl-1 =3D <&ctrl0 6 7>, <&ctrl1 8 9 0>;
> +};
> --
> 2.15.0
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
