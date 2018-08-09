Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C382121E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odt0om0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C382121E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbeHIQLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:11:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33655 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:11:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so2401290wmh.0;
        Thu, 09 Aug 2018 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kR8iGCfxX/c+YJFNMyAaSnmC5oP5U4nbEXwPQBfySPE=;
        b=Odt0om0ClvBvydAbCHpUjUET5llNz9bHqyT/xoKIurt/2758xxZlaED9PGc+zBIjIs
         yRyd5PlT+uYNU20d4XmAAFzHz54U47IC0GfCO0Y0XbVQGQlH5dE6AEYe82ddSsJfWgce
         86xcSv4X14CScb6/jBhfEBsrprkMLTK05IsQjdNyo196fw44BaEG8+gT/So1EyVnH2FJ
         olsyosJQWCNwT+7OmS2M62qEU4IXPkuuTSmzmoCJhM0V/c6Sc+e8ge9oQrYJOlTyXhuN
         LZcj71hI0Kyijp6RBhBFlkPCRO2IjM7wufRVWMALvq1XqP77dCvORJzs1R2sWnvjYI6B
         3NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kR8iGCfxX/c+YJFNMyAaSnmC5oP5U4nbEXwPQBfySPE=;
        b=Q+vpzBpPbM+MUcndsoi3hUTl9uc9xCnm4EdgXTgE4ORr6UbIc9inygrudai83Z9+qJ
         wxMq9LqZlsF3YNqGsZAsBnqP7EpJMORK/kiZTJ+okTWkaIYXD23i3ZcC9PMxODwYJZAG
         +GBnerPeMFPivpCq/HfWGBggAvvmnBTfkgwQcMDY8+WPafAueDNdvmA7BJRVglxf402P
         8ogeknJmFbMWJA/v6yY5DUPgD14L0JYobtAqgZt/We5kvWHoEJcz3kT68JJcmPAbsKqP
         NcgUcnlMpYopEUNpVZCMA2VWbQxcQs43zKZUorpEr11EB+yUcO1E33lNydb2vMLdFhZN
         t6VA==
X-Gm-Message-State: AOUpUlHMYVAXo8oux5+JiK80vRhGhgbM0/YIfBph+LlQe5j6foMmw3RV
        7L8lQEBhrMMUfmG5R1rQm7A=
X-Google-Smtp-Source: AA+uWPzcOUemJDY/Kd6+C67hw/3u93vCRpZO+lFGk2oPoQW51AeIJEERIrOX8PWuIYBfgj9uda/YcQ==
X-Received: by 2002:a1c:8e08:: with SMTP id q8-v6mr1835301wmd.137.1533822410806;
        Thu, 09 Aug 2018 06:46:50 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id s124-v6sm8344994wmf.47.2018.08.09.06.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:46:49 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:46:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Message-ID: <20180809134648.GD21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
 <20180809113609.GI21639@ulmo>
 <20180809144515.06089abe@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aDj5WtVma0yWCzS8"
Content-Disposition: inline
In-Reply-To: <20180809144515.06089abe@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aDj5WtVma0yWCzS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 02:45:15PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:36:09 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:
> > > Document HS400 DQS trim value device tree property.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +=
++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdh=
ci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > index 3c7960a..7d294f3 100644
> > > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
> > >    trimmer value for non-tunable modes.
> > >  - nvidia,default-trim : Specify the default outbound clock trimmer
> > >    value.
> > > +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > > =20
> > >    Notes on the pad calibration pull up and pulldown offset values:
> > >      - The property values are drive codes which are programmed into =
the
> > > @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
> > >      - The values are programmed to the Vendor Clock Control Register.
> > >        Please refer to the reference manual of the SoC for correct
> > >        values.
> > > +    - The DQS trim values are only used on controllers which support
> > > +      HS400 timing. =20
> >=20
> > One of these additions says "DQS trim values", the other says "DQS trim
> > value". It is unclear from the above how many values there are. I think
> > this should be more explicit. Also, I don't see why the note about which
> > controllers the DQS trim value(s) applies to is in a separate paragraph.
> > Couldn't it be moved to the property description?
>=20
> It's a single value. The plural form is a mistake.
>=20
> > Also, I think the bindings should specify which generations of Tegra do
> > support HS400. Where else are people supposed to find that information?
>=20
> This property is under the "Optional properties for Tegra210 and
> Tegra186" section and it only applies for the said generations.

What's the point of specifying that they are only used on controllers
which support HS400? Are you saying that only a subset of the SDHCI
controllers on Tegra210 and Tegra186 support HS400?

Thierry

--aDj5WtVma0yWCzS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRcgACgkQ3SOs138+
s6GKGA/8CdIrC2ZwPCoGAeZaGzJRhdKYMMhZA3mE2cY0PR5ir5mTrTcUPZiS6VlR
9bwTq08preNTV7EHStY/5m36vCAqLnB765y9nBiUrHOGQqP3xJRUoQvgyaXOm7+o
7Gk7lxSgWu8oMjWXLUVbzXHGWmVkLEPPFG/xbMqcDT517Us6Ss4jY6qU+V7okGU7
+uBGQVmLWGcuc3Bp+swRAU7OhigiJa73DtMg5Z5hejXf98eexmNANBGrmRV0KUeJ
GfKBrzCYtC2eujvL0Dw6xUT98FJV3QTLQ2brr5uoecj5FR2uP4gQ30nmJbv0KCtQ
4RHVJpA/ygeBp1/3U7LK3VEzLiv2axKhK5dEcem9BfOn+P0Aew6JErQrCiS2XVsU
FVSglbNRabjgm97HCyxafRiQaHYCrqR6/ZhmZ6XpC7D3+F6aBTDMGc7gANjNei0U
J3uQO4lWq0g4JJPMZ+wkdGz11AOBAU0XQrndfoZj3tz8d6q6dbYclhLaEccbggHt
RK/IIQntRyb2W/54bAoQa3imDVyp2aKlENfcguzt+S/4ReFbzIgmUGvL0lrRc5wB
i2ZxIhEY1qgZ4xxlWidzEG/iFQE+gZJ4HRpyzDyNIGt49KZYvF4gurr0835ezVXt
EsGvP9ViMUZQSOj2OS/zPlDnAzMvMM8AqPUy2MS3ZhI/8gM4IhE=
=qr0G
-----END PGP SIGNATURE-----

--aDj5WtVma0yWCzS8--
