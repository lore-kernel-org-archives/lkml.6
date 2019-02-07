Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23FA21905
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAXHGQJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGLOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:14:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35965 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:14:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so11099847wrv.3;
        Thu, 07 Feb 2019 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N0OlnV8HwoaKj/rYMNsqYSRnDGF1u1fRgKBXV6Bkscs=;
        b=NAXHGQJJ1SV4/u3hbyR7lzj8fZ4PbG92iw2jBFMi/Mz/D09IVBacRPoWkTLTrZZJjK
         aNnarkpY3eVElIh2mBlgpwGiwQpZlzM8cr6VxlgwHQOZD7Q+10GQebTLt1GSSbm86Mmn
         uHO86LrhJVzYQA/OCDa/F7E/m4Gx2HJEKO8Y6mijETjCQBRtgMdnvkRR1Im3MX3WS2tk
         tzIDiH9ZoDDewnpRvGHTWxBJ5MqchCQwmHmk5P1wY1a6J73lb//zJ//5bGlc5jvE/B5J
         soc19750QtBqVvbnU6DN3T4Iniy5JMBKKKWrvI2mZUP9AkZIGqNGYFKZxq61LbFldf2n
         3XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N0OlnV8HwoaKj/rYMNsqYSRnDGF1u1fRgKBXV6Bkscs=;
        b=r60su9gjGE7fdyED5JVjblMO01fl6fzsLM5AhPJJfIMNZMevk0yf7ILE6POpzFQ+ma
         d/J6DpY7sa8a/GaELppzzEoGvk3kMWnZliA4jCBdMxHSJSpYi2y58JGZMZkITvpsBa22
         dyHFgmfLCyyGidUim5W03ak2PFfjlyAbxHxUX7oYFhu7JovQr3h7PjuCQLC2jMRLJe4T
         7GXcRL/iGu3Y4PwQpjJY9viC/Pp2EsxmOxKAST/SSSaw+FhblUDL/9ExaHuwn+v+pEhf
         OAdNruhVspyFvM+7ar/psDNCPjFXZmiv0odRqvnodAuBCBJKIBhnAiCP2IAuGNs691rD
         UK9w==
X-Gm-Message-State: AHQUAuaP1REp/Z9bYVoXshCPfr4bPF06Fott1MeQe5pWuykM+dwmwPME
        +GRzK2sccqdO7KMkc3TYAhCzqZD2ll8=
X-Google-Smtp-Source: AHgI3Ia6pEjWjam6pRDlfSzdOwgNViaANp+YupQ+C3oToZ6djhFdhiuls6riLjbRBDNE7Z3iXeHZTA==
X-Received: by 2002:adf:9004:: with SMTP id h4mr4616406wrh.121.1549538074049;
        Thu, 07 Feb 2019 03:14:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r200sm42811392wmb.36.2019.02.07.03.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:14:33 -0800 (PST)
Date:   Thu, 7 Feb 2019 12:14:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
Message-ID: <20190207111432.GC18518@ulmo>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 12:30:08PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Extend the bindings to cover the set of features found in Tegra186.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
>  1 file changed, 4 insertions(+)

Hi Greg, Mathias,

do you have any comments on this series or is it good to go into v5.1?

Thanks,
Thierry

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcExgACgkQ3SOs138+
s6GkcA/6AzSaIZc6unkYsm7c9Y6sOF4aTYASqwfQ6d8yHown2e5wY9Cb7K8AkRDk
N3+s/7j9C+axj9f8peXVhO4D+FbuXZOCOE5hZ+A7M9yKEyxHyuBMc71IlAFGMLUi
Jw5WTYScFoDSsub5Z/zHU7ZYWj7alwzXTiCncarn+rZx5Snt91S908+RfbYDck8W
iNhmshS16zxT8L5z2sASLr4Q/tLmNTzEZ88xI0t/FVuaN6g1fbg1cJXOy8rxVQy8
hgkw3JEHDeMt8XfS6LRfy0bkQyk3ElZ67P2BlDIMBt47cVNvv0t4NbLQ6DgtBCaP
RJu6VlSR1iZHOw/HORDu41oG95w6lHgnWqlv8ZVB9Tr0ENW429TIW3e4Y6zRoCRS
+zwLVftk7q/H0bjkR9H/lfFvPx2MGo0iE3EwrofNs1ORtjSvXO+ygl7MLvYU28+j
exAjBPEE+X8V1bhpU6n5p4QXWWZlhofYiRc8oyC1PCjRWqBUVnNNn2OHEXa3LElL
XheIjLjFCo3rOckVp8yvuvyZneZky+WBM0fuQ2pbk76fFZE77thwaauLsAxNu8AX
uLrXdR1PCWONffsgE70FXyEtLKKt6buaSmWKss2qxhNS/Aw4iviyOTghAuW4Hj/n
Jv1KwLAh9LewRmaSz1ayMjnt509jYclm9oAXT7cZMoH9RkxIU9o=
=r9Ex
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
