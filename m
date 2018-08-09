Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3924BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F05621E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlV4dkd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F05621E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeHIQRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:17:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33605 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHIQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:17:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so5250596wrp.0;
        Thu, 09 Aug 2018 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RvNm6I+lSX7aMlkpUTovcElxYYvrXzxKlfVI1Yudfc=;
        b=RlV4dkd54hVWTZGBqY2J0OXZoPD6Q2MdqRVPH2qkpH9ergIj0aLRcIDLVKeOW5ofpk
         vS9nibnMThj/o6XLtbs7j5CSauaiv35q+TxpZ7RoYjekiZKK4ZiX6FzmpJL50kYYt1Dn
         7PBdJHK2dZTG22jY8PZ/OoYWFqsnLumyxsDJFNOLy4TTpFFXeS1nlh2mp2LFzZB/cA8I
         l5Rp7/nWvlUgnPG3kHHh5XeX/nEPVoCFYak54wKTfdpaIKNnIlQf7xUgl5BgYLR+wLqZ
         E9Im4XgQ5GUTAVJ0wTuPyYX3bRmCHmv8ExDm6EdTEcTppmM46MXMipaPu8v+trmSeF7P
         w7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RvNm6I+lSX7aMlkpUTovcElxYYvrXzxKlfVI1Yudfc=;
        b=sYokMFnxZBxXcd5LFaEkfFEslOMjAStVGguAJf/2MJYIgty/CT8a9jxEiUmD0y0O9C
         JixWC1mQfgMollAM1q+NlWcKgfY2DJ/p0da+P6JO16xFBE5AXJ0a9xXjvF1/XOXu5KGH
         ZnU3zJsfJbNPsxawo1gcsqr9A4mDeMsIX/tmIuHGE9BryoX6clUpoEQJgddEDFbhzG7l
         QvUpXDzPpgByrg2VUdlLGnwVuHc96nwKwf9yWrCHzV6nAsA6W51uul0PTv+eBQ+x3s+8
         SicQAinRa7jTvWhnnFEiO8MAFIPWNAe7gRkCmMTeMRTAgsjKXGg+qz5+kj5Z3ZGz2XoR
         uAlA==
X-Gm-Message-State: AOUpUlEWivcVb03MA+1IvfLoM+7KwklCQYlhrfyIRPQJraDx2c7V5VUN
        oU/NRi1ftCkYe8j2Aor6YmQ=
X-Google-Smtp-Source: AA+uWPxGO2/NKTgqN0YpA2qABrM9bVkMCMhUa8jBaMgh6UjvAsPGZL667KflrM95G800ANgc38clAw==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr1541148wrt.162.1533822738366;
        Thu, 09 Aug 2018 06:52:18 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id j9-v6sm7526973wrv.5.2018.08.09.06.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:52:17 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:52:16 +0200
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
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Message-ID: <20180809135216.GF21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
 <20180809114922.GN21639@ulmo>
 <20180809150226.64657f56@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="py13wRIzy9nU46ee"
Content-Disposition: inline
In-Reply-To: <20180809150226.64657f56@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--py13wRIzy9nU46ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:02:26PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:49:22 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> > > Add the HS400 DQS trim value for Tegra186 SDMMC4.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra186.dtsi
> > > index 6e9ef26..9e07bc6 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > @@ -313,6 +313,7 @@
> > >  		nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D <0x0a>;
> > >  		nvidia,default-tap =3D <0x5>;
> > >  		nvidia,default-trim =3D <0x9>;
> > > +		nvidia,dqs-trim =3D <63>;
> > >  		status =3D "disabled";
> > >  	};
> > >   =20
> >=20
> > Isn't this technically dependent on the board layout and as such would
> > belong in the board DTS file? Or does this value work on all existing
> > Tegra186 platforms?
>=20
> This value is specified as part of the controller initialization
> sequence in the TRM. I've understood that this (and other tap and trim)
> value(s) are used for compensating the propagation delay differences
> that are caused by the internal SoC layout.

Hmm... it would seem to me like the routing on a board would have a more
significant impact than the SoC internal routing. But perhaps the board-
specific routing is actually what the automatic calibration is used for?

Anyway, if it ever turns out that we need slightly different values on a
given board, we can always override the value in the board DTS file.

Thierry

--py13wRIzy9nU46ee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRxAACgkQ3SOs138+
s6GlhxAAj/a6meiHIxY5TFAsnZb/aNtRSgkDmy2CGv4Bpdl4HUedX4+bflQcv66a
IoNqAApjYRXVdBNZfkAH78MQV157U99U5hone+1RHzJFsybW7cXem+qSACQBXFLV
378VghbCmtZspJ9afGAFxdkkkPKorK9uMmip3PUS0Wz8c2RKf5YL113FrkUoOJDE
cbkjYrj3WYz0wL3o9n1/FyYKeNfFg12fN1zO7afmxHag+f6IeWzynb2kqEUwBniC
Em1F1vVfNdI4gbREXFfQOESkJQzG42hWACYCm86EQ57IbtVrP4e3cyi4BDIeEG93
bhy2TuhL+ETmp2HYhgq/0lXELb727jmrwfQ/E3vVTpHf0+sbPrxBaeKf2k9cmNM2
BadcdjXAPrLwJ4oe7jib5iX61+aXz1DBfGJnATe9hg9YvdNgF8R/460Ql2W/g+T+
Io3Vwke6nQc8OJQgpiruQ5IBYSpzp9iHMT7yw8K44jf4fLcno97dfg1kOrcayF9q
5L93aawL3ZHuGT+Tml0v52u2OfOfsrloV4Tnqj6yWe6/6quVXmHrObf1xK8IYO6a
U1l5uaQcZX221F+5Bia6hnEQfkoR4JfhOUaU5bjKNA6ReKt08bSxaFkQZ9ARy6h7
X8dqmoU2EMO3uYDCdHlWC/b8YN0KLAyfps8banXV4mRzUDuBz5M=
=q8pn
-----END PGP SIGNATURE-----

--py13wRIzy9nU46ee--
