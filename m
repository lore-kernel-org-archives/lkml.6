Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B89C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A30620852
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A30620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeH0Nrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:47:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60475 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Nro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:47:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D6B5A82F9C; Mon, 27 Aug 2018 12:01:43 +0200 (CEST)
Date:   Mon, 27 Aug 2018 12:01:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180827100143.GE31905@amd>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <1535106467-17843-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 2018-08-24 15:57:42, Kiran Gunda wrote:
> Update the bindings with the new properties used for
> PMI8998.

> Changes from V3:
>     - Removed the default values.

Why?

> +- qcom,current-limit-microamp
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   uA; per-string current limit; value from 0 to 30000 with
> +		      2500 uA step.
> =20
>  - qcom,current-boost-limit
>  	Usage:        optional
>  	Value type:   <u32>
>  	Definition:   mA; boost current limit.
>  		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
> -		      1680. Default: 805 mA
> +		      1680.
>  		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
> -		      1500. Default: 970 mA
> +		      1500.
>

I'd say that optional properties should list default values...?

>  - qcom,ovp
>  	Usage:        optional
>  	Value type:   <u32>
>  	Definition:   V; Over-voltage protection limit; one of:
> -		      27, 29, 32, 35. default: 29V
> +		      27, 29, 32, 35.
>  		      This property is supported only for PM8941.
>

Same here.

> +- qcom,ovp-millivolt
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mV; Over-voltage protection limit;
> +		      For pmi8998: one of 18100, 19600, 29600, 31100
> +		      If this property is not specified for PM8941, it
> +		      falls back to "qcom,ovp" property.
> +

"voltage-limit-millivolt"? "ovp" is not really well known acronym.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDzAcACgkQMOfwapXb+vIp1gCfb3HRiCG01VfOcS0fmSAkZALF
eMsAoJ9WOxCqP7mQKiPdgicGXubmhmzN
=Ap6I
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
