Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F356C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CE021D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVBzUAzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CE021D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeHIOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:43:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeHIOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:43:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so55156wma.5;
        Thu, 09 Aug 2018 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrl/E3lUGQp5F7FqCmeXNEB1K9J3BUiRK/p/GEXLJtY=;
        b=MVBzUAzYQksYLh4gavrhVtp5ugpkYFmdJvmqsETgRyWnNOZFgL5IF8/mD13vzxnc8X
         GcDs5buJAhbdkPiGFuPu4Rf2Nk/lY6ZBJgx6j2P+yFPHbdV392h0L+BX7cBSjmU+6zPH
         66JTmYCxZG54eGCbqsIBj/504a41iYr67apx+gtHGoDQGkLmZg8L43d4imW/4IcfGP6u
         CeoRTs34HIXl1zcSQOUcAVy+3eKojDb0UIcNpyML5oOfhgd9ms+XN0+QSS6J52xCyIKD
         wF9niv9npe4/1NWpE2S+n2SqB/g3C3uB3t6t3d9YiQtluEziWvBTngHd8JhVqrmruN3A
         b6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrl/E3lUGQp5F7FqCmeXNEB1K9J3BUiRK/p/GEXLJtY=;
        b=m6jAk9sRgkK70B6s98tbDkY/erg9+dJk6/kYTUuiqtQmPvxvxQQykcQ5Z6h/OiRFmU
         kzB5hU5/a2e0tOtq6ttw+eUtd0KZNpOg2xswK9I2BHAIq1ycC3f7ubwvRxv5Ujv4Mw0v
         Xl9KhjDrtA5ikfI0U7/SRRMPf7OnW9sJAUnEe36/pDjXhqoMsaY8FaTfb13KhJSQlSIh
         Tmo3YFLx4t0K3tE35LnRd4e5pJX2d/SDJg6p7twi9esimDXbsHHBDKjWoFCWevm2xzIP
         ZLLnVJAV7GqIA59OD4x8wZBFma6Fl69jVesM130fag8pEUEpr7IC4KehmZPC6Zf80kDb
         NwOg==
X-Gm-Message-State: AOUpUlHqxt+MS71zsaido9IUkLSBYiMDHRIZoBua2mlevdEkDw+e6yxI
        +ay2/R/4tFRd1rT4enkGMCo=
X-Google-Smtp-Source: AA+uWPzqnQBsHvhhUhhxEupAshi/787+jXTPWzIPygyO99bM03LLi4a2Lzf+JXbvo8Cs6q3LcdwL1g==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr1551731wme.125.1533817100812;
        Thu, 09 Aug 2018 05:18:20 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id i23-v6sm10915850wmf.24.2018.08.09.05.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:18:19 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:18:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 03/40] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
Message-ID: <20180809121818.GQ21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-4-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-4-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:53PM +0300, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to=
 be
> programmed before executing automatic pad drive strength calibration.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 36 ++++++++++++++++=
++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214d..2e973b5 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -24,6 +24,7 @@ Required properties:
>  Optional properties:
>  - power-gpios : Specify GPIOs for power control
> =20
> +Optional properties for Tegra210 and Tegra186:

This looks like a stray addition.

>  Example:
> =20
>  sdhci@c8000200 {
> @@ -45,6 +46,37 @@ Optional properties for Tegra210 and Tegra186:
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- nvidia,only-1-8-v : The presence of this property indicates that the
> +  controller operates at a 1.8 V fixed I/O voltage.
> +- nvidia,pad-autocal-pull-up-offset-3v3,
> +  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
> +  calibration offsets for 3.3 V signaling modes.
> +- nvidia,pad-autocal-pull-up-offset-1v8,
> +  nvidia,pad-autocal-pull-down-offset-1v8 : Specify drive strength
> +  calibration offsets for 1.8 V signaling modes.
> +- nvidia,pad-autocal-pull-up-offset-3v3-timeout,
> +  nvidia,pad-autocal-pull-down-offset-3v3-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 3.3 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-1v8-timeout,
> +  nvidia,pad-autocal-pull-down-offset-1v8-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 1.8 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-sdr104,
> +  nvidia,pad-autocal-pull-down-offset-sdr104 : Specify drive strength
> +  calibration offsets for SDR104 mode.
> +- nvidia,pad-autocal-pull-up-offset-hs400,
> +  nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
> +  calibration offsets for HS400 mode.

There's no mention here about how many values each of these properties
needs. I guess given that the property names are singular it implies a
single value.

Thierry

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMQoACgkQ3SOs138+
s6Fevg/+MNfOC0Z9TgoTTFq8en1xRYQOPng4O9aKl/54+TC2EtpsPQAcpGQGpqgd
D0FgOxD+hdkdoQwWG0831rxAGW03ICVsVdqnsUOHBeBgDsKA55JVs1Ixl0Hl41cU
RQHD6QYm3iLDjSPi6qintqSidND9fVAU2JHVLdgzQDo+LkFOJ00kcfAheqrl8Keb
1yAm4rN69k1aNwMI6buxo1l8jFk3UJa12AVwseUoZNB9AtzkVf0Ei9EYvoIYiuQ2
Y3aEBJxOmAME5V1Dpy2B0uAIfbrQk0fMbx7KdbycUvARThzj+C8JnVz3O7KgDY24
XkyqDLwfi+VRZiDNPeWOWX45nkTDq+Fvw4WfIzqJB26dYPWm1mh4D+JhG3BgPtdW
F4oohcSmNCpeiu18CUiccKVrn25TcIVJpS2PdryqRGLHTuhpALAwyOThdxA2WAhP
Wfn1LQH8sV1Rmhs18hF7OB1j33LhjkfXiT3lEp0Ouy4Qejm9S6Qj39hzX58c/Et7
Wu9QY/e6VOIok1sMCAEnegfZQjxPKzL0XRztqKaOQ5PjHcrjUlOkpH9Vv+C4We8G
J2jJYeL1D0CANSKDpndk/PT6V50hBzqaXbavFZsPYU7syp7tCejSO21EHkzV8ok2
bFNxgbE05xtuY3U53z0LLW4A1zhoeclPvIbz+cmAwKnFtEstSTI=
=ZtE+
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
