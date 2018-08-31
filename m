Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F1C20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEH3JWIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F1C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeHaSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:07:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37611 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:07:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so5432970wmc.2;
        Fri, 31 Aug 2018 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w68OPPeM4OfO5AHU0F6qhhlOJIZW4sN1LPmSii4kkaY=;
        b=LEH3JWIBJFLhJSQ744xfhLhpRgTvya+Sf7cRSaxYNL4JdKp2lUk2EGZk/sQdKGVxvE
         WVYVgJ5z/PV/9pE2tPJ2MGckQuhl7W7OZBIUWM87SHQ78onsPrQ4MU44EewMGC7egQ/R
         H/oebJCGBXSPsQDM/J9c1AbG0BkxZ3MhzCQKuwlw162b2vyPupljBjM65+bzZQXLJJG+
         Bn30kmobnYQiTK/LezIBvJ5BeZXPwl8cWJ1N9R7GM0WbOv0nQGrEvMVbPNNohtx9VRiX
         SWZAhipHdHW/s64b5KFn9JJeFUyl3lPuJOLgPlNk3LFbTiBrtt5mb92jXRsYRCOHX2+a
         GtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w68OPPeM4OfO5AHU0F6qhhlOJIZW4sN1LPmSii4kkaY=;
        b=AHD2amhzp3qR1wEaw2fCqmF2vS5zZkzHxQ/Utv8KnFUOukhuSzV0kKv5YMlFTJ8REX
         Cf4PNictYvv1txRYfv1PnKihDdR/FkOf2PGQ+64FWfXJWn1a+OEsXULgati2aH96ZaWn
         meg6EVX9yN8xaE12Cif+IlMzgFhL29yhCal1aUMlBI1LQqqeRiBleYRiD9mZVErVszJY
         a5lr/E751kKfOG8vIP5GZTEuh+bYpteejAvGpDkc0NDGfxCXGfEkK67zoqY5YIDhFwWL
         GvTBYkbnmvkHU7ftBfH3pmF2Y5Xrd9gc+GhZWMgfAnGLZCt4mtx6enGvHVHdfFP8M7rg
         FqAA==
X-Gm-Message-State: APzg51Ajbm8P8A/jq74bDVDbKLKYfX+rqsxY6wNdrwUPYjhH046xd/15
        elzrAq6BG6JFTKbFH8bDYqA=
X-Google-Smtp-Source: ANB0VdYZ/nJQWZCVC2LM3JtqbWsI8OURAx7LrXKRfJxL9ZJdDSCLWdcrYPjxsUpySFQ0QSSMrmEXpA==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr5181579wmd.40.1535723987202;
        Fri, 31 Aug 2018 06:59:47 -0700 (PDT)
Received: from localhost (pD9E51F49.dip0.t-ipconnect.de. [217.229.31.73])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3140549wmc.13.2018.08.31.06.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 06:59:46 -0700 (PDT)
Date:   Fri, 31 Aug 2018 15:59:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 11/38] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Message-ID: <20180831135945.GA7926@ulmo>
References: <20180830150639.21048-1-avienamo@nvidia.com>
 <20180830150639.21048-12-avienamo@nvidia.com>
 <CAPDyKFpnoWq36RoJKSDHD7Wtn-x1iqbD_Jy1kg2ncewe-HV0OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpnoWq36RoJKSDHD7Wtn-x1iqbD_Jy1kg2ncewe-HV0OA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 03:16:17PM +0200, Ulf Hansson wrote:
> On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> > Parse the pinctrl state and nvidia,only-1-8-v properties from the device
> > tree. Validate the pinctrl and regulator configuration before unmasking
> > UHS modes. Implement pad voltage state reconfiguration in the mmc
> > start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
> > and add set it for Tegra210 and Tegra186.
> >
> > The pad configuration is done in the mmc callback because the order of
> > pad reconfiguration and sdhci voltage switch depend on the voltage to
> > which the transition occurs.
> >
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> Applied this one the rest of the mmc changes, up and to patch27.
>=20
> Those changes I haven't picked in this series, I am assuming those
> will go through some another tree? Thierry, will you pick them up?

Yes, I can pick up the non-MMC patches into the Tegra tree. Can you also
look at the following two series and pick them up if you don't have any
further comments?

	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D7351
	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D9537

For the former, patches 1-4 should go into the MMC tree, and for the
latter you already picked up patch 1, so only patch 2 remains.

Thanks,
Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSc0ACgkQ3SOs138+
s6Hm9RAAle9Tm1bRz9/oTHcre/zL6ZDYptbEClBH002obyyQZCDuznOBXbujTYLA
uX5YDTpBE07AAaTQO1n74nrldZN0WmGVrs9coOi+be0E+3Am+Dgrj2vn/GuMeU6T
rlN38SDeoTTjPP/qC6Mhw+6v2wRa2bn/JuVvShmND9u8bAOeqx/tG+GVY3b0rW0q
oou+8HpQaGEdN9BNqLTI2aej2zczqSNI0BdTlqYDUJoA2iovWkdUrJMz5okEiCc4
s45HvaYrnRfo2oKWap8cCnwVzXF/0glJRNJAXFM9bZLo52q58KeK1tPtwyfOJaIR
OdA0viIXGMpjU4cc4QqDxujgf5nKfE2r2p+RqWVOTEawi02ECw4v1WZGLbx0o+KO
npXaTD3OQIrJtGOtIT0WEHmI3FVDo72yYpsNAbxoGdhnHRaO/E99Pp4WqTsWxaTw
re+iXcOcESoOpAKkNyUkwkFS0tY7qfr4+zVLslRS1fpCOZeKikKvR64QPjwx558Y
MdKE8zdfDuWcgfq6fHuhCW96jXe0WzqtADzem5oU8ZP76KsX5yYxf9JilbCJpfkO
MLJUKIaKGx2dVQ36/S33ugIKx5VZ0OgmlUUyQKdui4X1e6sfuTvY71TTqkxyCpeS
tiUCE4tlkGeICKjKL5Eyri1kzRGDx5l9jB/hSexEsHLrh/Mvo7s=
=d2pb
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
